Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7448F775FC4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjHIMvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjHIMv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:51:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BBD213F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A8A66393D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FEDC433C8;
        Wed,  9 Aug 2023 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691585465;
        bh=T48WHjFLhEm2vnv/v96J9aS+qVl+eNSnEiw9tCjz1as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=udgSnQdlyTumAcwM4KtsmCSL3TBAHAAyztt7yjLCZywoeMpd1klrstmzIqNoedo5L
         0fr3aE/XPOl4/iMt9HjLC+I69zAByapY3PCgoCzBNonqPrb8GErAEUoWCFX+OAh4b/
         B8mz9xvpcjqrm0cs4LU/mKhUvADOOmGNOZHsjQ0E3dTJiyOPFUKk/OdGmIfp/AsEAv
         sM0s840JToj7t/4x6NXY+4z4l2vTxrXD+zlY0KsP0Y49wdbs3b/1+TgUai7vnUWhl0
         V1kELtE8exjg3CahJb3O7qYd16kV2fHBogZsba+ZO5C+4JlOW76rpYAqUhTC/vK2F4
         jDC6AMoreAyPQ==
Date:   Wed, 9 Aug 2023 08:51:01 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 05/17] x86/cpu: Cleanup the untrain mess
Message-ID: <20230809125101.xxwhuipfvj7kbasn@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.782716727@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072200.782716727@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:23AM +0200, Peter Zijlstra wrote:
> Since there can only be one active return_thunk, there only needs be
> one (matching) untrain_ret. It fundamentally doesn't make sense to
> allow multiple untrain_ret at the same time.
> 
> Fold all the 3 different untrain methods into a single (temporary)
> helper stub.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/nospec-branch.h |   19 +++++--------------
>  arch/x86/lib/retpoline.S             |    7 +++++++
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -272,9 +272,9 @@
>  .endm
>  
>  #ifdef CONFIG_CPU_UNRET_ENTRY
> -#define CALL_ZEN_UNTRAIN_RET	"call zen_untrain_ret"
> +#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
>  #else
> -#define CALL_ZEN_UNTRAIN_RET	""
> +#define CALL_UNTRAIN_RET	""
>  #endif
>  
>  /*
> @@ -293,15 +293,10 @@
>  	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
>  	VALIDATE_UNRET_END
>  	ALTERNATIVE_3 "",						\
> -		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
> +		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\

SRSO doesn't have X86_FEATURE_UNRET set.

-- 
Josh
