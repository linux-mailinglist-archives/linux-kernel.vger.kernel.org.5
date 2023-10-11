Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25AF7C5D86
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjJKTUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjJKTUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:20:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3053B8F;
        Wed, 11 Oct 2023 12:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lgjkqHX2tUg8J3lXvm+VQWd9+smBMxN3ogHXgE1zA9U=; b=tk93etI1BLYzTY2MpHDz3iLPJ9
        5j6SbX9aun+EvVMGxaRioZG4uogoJ2Ar5WLiTMHQyFGLWR2XWHElExKqQ1tWp7IJJT9r19zzZmqGQ
        zu/dpFriZG0kI48Gf+gfRwZU6HU4iRBlxnUON9hvLZ1sCa7PtY+yyYgv0aWBxxtbTeZGRX5BdUrj0
        DVsStSBDRlSP/BiB0SdzX2tZ8wwfPniX/5un6X1zS5vFhhR2LPe3xEa1VLZGJ9+nXrdq3bH0aa7fN
        kkYmJC6dVzvB2Cc6Z/cbZIbW9VVAsaeGJig4XEpxu80EclXpkVRTtmBixPg4EAGHcETbzlS9sp3gC
        YRJP5SLw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqekZ-00GXV9-31;
        Wed, 11 Oct 2023 19:20:07 +0000
Date:   Wed, 11 Oct 2023 12:20:07 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joey Jiao <quic_jiangenj@quicinc.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
Message-ID: <ZSb1Z6EcogoUYcOR@bombadil.infradead.org>
References: <20231011074438.6098-1-quic_jiangenj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011074438.6098-1-quic_jiangenj@quicinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 01:14:38PM +0530, Joey Jiao wrote:
> When modprobe cmds are executed one by one, the final loaded modules
> are not in fixed sequence as expected.
> 
> Add the option to make sure modules are in fixed sequence across reboot.
> 
> Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
> ---
>  kernel/module/Kconfig | 11 +++++++++++
>  kernel/module/main.c  |  3 ++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 33a2e991f608..b45a45f31d6d 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -389,4 +389,15 @@ config MODULES_TREE_LOOKUP
>  	def_bool y
>  	depends on PERF_EVENTS || TRACING || CFI_CLANG
>  
> +config MODULE_LOAD_IN_SEQUENCE
> +	bool "Load module in sequence"
> +	default n
> +	help
> +	  By default, modules are loaded in random sequence depending on when modprobe
> +	  is executed.
> +
> +	  This option allows modules to be loaded in sequence if modprobe cmds are
> +	  executed one by one in sequence. This option is helpful during syzkaller fuzzing
> +	  to make sure module is loaded into fixed address across device reboot.
> +
>  endif # MODULES
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 98fedfdb8db5..e238a31d09eb 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2594,7 +2594,8 @@ static noinline int do_init_module(struct module *mod)
>  	 * rcu_barrier()
>  	 */
>  	if (llist_add(&freeinit->node, &init_free_list))
> -		schedule_work(&init_free_wq);
> +		if (!IS_ENABLED(CONFIG_MODULE_LOAD_IN_SEQUENCE)) {
> +			schedule_work(&init_free_wq);
>  

As Christoph suggested the rationale for something like this needs to be
clearly spelled out in the commit log and if so valuable it should be
a default. The commit log and even the Kconfig description do little
to justify any rationale for this.

  Luis
