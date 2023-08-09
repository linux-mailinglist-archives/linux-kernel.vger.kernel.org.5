Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3258A7761A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjHINuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjHINuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781B21FC2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABC14616A0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FC9C433C7;
        Wed,  9 Aug 2023 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691589009;
        bh=FNqeWc4kMaof6TZwaAnCoTBocYhWY2edTP9MmNEAyfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDSxERMiPbIy1HuPhWzbE/EffbyxhqOLAG8IiGjE5XXO8cJSQEJyCE2vclFfsZAtI
         LVoebBeIHkF8EQVYh4LuG8k/yBk59lUVxK93tTHsj0vbzDN0qgOGQklTDuYWI9dPsg
         JdhO2TkSlfmk1CjxwqEt/IWfY02YNIncHDG67JwQs6+eJN804VbAhxzCovxhbCdxpp
         ZoNGVt6H0phXeiHyrwUNDOYgqk9qZdMol4EsmVssLT5W49Xwk258lF21hBXMYPNh1w
         rezsOm39BpOdsay1a5Jbbyj4s/+q3qVd9YRIEzc5KsPx2h4r6AnZPLVZvfB5rD/3k+
         VXBXZ80S5k/VQ==
Date:   Wed, 9 Aug 2023 09:50:04 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 07/17] x86/cpu/kvm: Provide UNTRAIN_RET_VM
Message-ID: <20230809135004.2xy76kqpptfqxsp5@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.922634286@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072200.922634286@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:25AM +0200, Peter Zijlstra wrote:
> With the difference being that UNTRAIN_RET_VM uses
> X86_FEATURE_IBPB_ON_VMEXIT instead of X86_FEATURE_ENTRY_IBPB.
> 
> This cures VMEXIT doing potentially unret+IBPB or double IBPB.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/nospec-branch.h |   11 +++++++++++
>  arch/x86/kernel/cpu/bugs.c           |   17 ++++++++++++++++-
>  arch/x86/kvm/svm/vmenter.S           |    7 ++-----
>  3 files changed, 29 insertions(+), 6 deletions(-)
> 
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -299,6 +299,17 @@
>  #endif
>  .endm
>  
> +.macro UNTRAIN_RET_VM
> +#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
> +	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)

Maybe can be simplified?

#if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)

-- 
Josh
