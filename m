Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0D57C04C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343980AbjJJTgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbjJJTgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:36:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EDCAC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:36:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF304C433C7;
        Tue, 10 Oct 2023 19:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696966605;
        bh=uD7ClMOlrXNZucpoYnlZ28XUQ78JwLXF5AuAtp1WUwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k7vWiM/Yz0PhW0Ss7wKsaKqgBHZaO7QBO00j3RtRK6zfBXxWhUDD6o7xMvc60QjQ1
         RcMDye+IPKtZrBCDB+F6DoQjOmMh4oQccmwfrbsM9YQLpxX+Ktj0hG9cN4aq+F90h0
         tQrj4cTkWnfTinCP1gTSH1/T4R1iPkQ8b7sCdVkDrRwZNPuRK//hej2o8N6n8mdYhZ
         D2s+1lS+ZH5NwQGmqAkko3jMz/dypR6jMOqsmYuLlmiLoTWC8kz07kfSmPGqeWwBFR
         F94iXliE/hPeGq3/ZTh+KOhEGZIYTefAv8d+N3C3MrFU8XRPCnQdmoE9mhG6+ndzo6
         OAQXy4SU2G4qQ==
Date:   Tue, 10 Oct 2023 12:36:43 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     David Kaplan <david.kaplan@amd.com>
Cc:     x86@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231010193643.su6iqjniuxqqke6d@treble>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-4-david.kaplan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010171020.462211-4-david.kaplan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:10:20PM -0500, David Kaplan wrote:
> All CPU bugs that require a return thunk define a special return thunk
> to use (e.g., srso_return_thunk).  The default thunk,
> __x86_return_thunk, should never be used after apply_returns() completes.
> Otherwise this could lead to potential speculation holes.
> 
> Enforce this by replacing this thunk with a ud2 when alternatives are
> applied.  Alternative instructions are applied after apply_returns().
> 
> The default thunk is only used during kernel boot, it is not used during
> module init since that occurs after apply_returns().
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>  arch/x86/lib/retpoline.S | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index 3da768a71cf9..10212cf4a9af 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -358,15 +358,17 @@ SYM_FUNC_END(call_depth_return_thunk)
>   * This function name is magical and is used by -mfunction-return=thunk-extern
>   * for the compiler to generate JMPs to it.
>   *
> - * This code is only used during kernel boot or module init.  All
> + * This code is only used during kernel boot.  All
>   * 'JMP __x86_return_thunk' sites are changed to something else by
>   * apply_returns().
> + *
> + * This thunk is turned into a ud2 to ensure it is never used at runtime.
> + * Alternative instructions are applied after apply_returns().
>   */
>  SYM_CODE_START(__x86_return_thunk)
>  	UNWIND_HINT_FUNC
>  	ANNOTATE_NOENDBR
> -	ANNOTATE_UNRET_SAFE
> -	ret
> +	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE;ret),"ud2", X86_FEATURE_RETHUNK

If it's truly never used after boot (even for non-rethunk cases) then
can we use X86_FEATURE_ALWAYS?

-- 
Josh
