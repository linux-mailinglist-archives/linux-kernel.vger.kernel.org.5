Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052AC7C7374
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379493AbjJLQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjJLQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:50:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1ABBE;
        Thu, 12 Oct 2023 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6y1wB+wLmbd3DnNxETvQ+qCVK9s9E8u1DdnwFwmSGKc=; b=3Evlr9KoSDHi22us3TUTb+Fiyd
        gpw+vQLph7yAIUkkXcLUqlYn6cWIAUPdtGWauTTIyuMru/9b6Fpqw2kSlok3vm+PyhsPpNckmHPl7
        eYJIj5eVzmazuqs/5C1p7XZY7nBlj66Az8VFEVFwgx98zi1pBh553mqSYysImTi6L5R+8W8UTwCgp
        ovUGic/6YcYy833JjclTyb8KHJwHjkMiIvikmnZ067/eCewx2XLGsFU/UdrzetMW62sjIfQcsRd+9
        Y/za7hzSia8NxG/hekMKqNR0ospFPvJneh96OYcuV35sOaSCB2yx73EJIfVqYzyIH78cgU6w4Ggbn
        FuS0O7KA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqytH-001SdC-2n;
        Thu, 12 Oct 2023 16:50:27 +0000
Date:   Thu, 12 Oct 2023 09:50:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joey Jiao <quic_jiangenj@quicinc.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: Add CONFIG_MODULE_DISABLE_INIT_FREE option
Message-ID: <ZSgj02JtR+Hkc5qz@bombadil.infradead.org>
References: <20231012014012.9030-1-quic_jiangenj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012014012.9030-1-quic_jiangenj@quicinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 07:10:11AM +0530, Joey Jiao wrote:
> To facilitate syzkaller test, it's essential for the module to retain the same
> address across reboots.

Why?

> In userspace, the execution of modprobe commands must
> occur sequentially.

Why?

> In the kernel, selecting the CONFIG_MODULE_DISABLE_INIT_FREE
> option disables the asynchronous freeing of init sections.

No it does not.

> Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
> ---
>  kernel/module/Kconfig | 8 ++++++++
>  kernel/module/main.c  | 5 +++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 33a2e991f608..1cdbee4c51de 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -389,4 +389,12 @@ config MODULES_TREE_LOOKUP
>  	def_bool y
>  	depends on PERF_EVENTS || TRACING || CFI_CLANG
>  
> +config MODULE_DISABLE_INIT_FREE
> +	bool "Disable freeing of init sections"
> +	default n
> +	help
> +	  Allows users to prevent the freeing of init sections. This option is
> +	  particularly helpful for syzkaller fuzzing, ensuring that the module
> +	  consistently loads into the same address across reboots.
> +
>  endif # MODULES
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 98fedfdb8db5..a5210b90c078 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2593,8 +2593,9 @@ static noinline int do_init_module(struct module *mod)
>  	 * be cleaned up needs to sync with the queued work - ie
>  	 * rcu_barrier()
>  	 */
> -	if (llist_add(&freeinit->node, &init_free_list))
> -		schedule_work(&init_free_wq);
> +	if (llist_add(&freeinit->node, &init_free_list) &&
> +		!IS_ENABLED(CONFIG_MODULE_DISABLE_INIT_FREE))
> +			schedule_work(&init_free_wq);

llist_add() returns true if the list was empty prior to adding the
entry, so the functionality you are adding makes no sense with the
commit log in any way shape or form.

  Luis
