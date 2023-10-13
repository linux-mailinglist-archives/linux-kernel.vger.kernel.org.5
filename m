Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91FF7C8D60
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjJMS6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:58:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9778983;
        Fri, 13 Oct 2023 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BX46dNDWacbTLnmiaLVn5n52llMO/qsVCUFz6T6ofcM=; b=GHy2B436bq7f/+P60+nkE0cQOh
        29Qe3rqIM5Q5KtjRNqFXM+U7iE7WHDENeWxQJQYCmz+MjCGoxM9qqhNitOFrdRYLUEPh6K32vAEyr
        +G7EzaQOMWL64UtUzpyb72hbqAd7N42EwSiXLY0tfJdctbvgzSUAmAm+3TvBRgQOPAe1BoNWoSLZE
        WwTrEmHfEEJ5CA+Rm097ca3TlxEmzV/LEnkbhPb6YgzbTgwWWYU+h3tmAtMrLw2WebWgi2FVMfFkU
        V6DxdCcZrsUrrezsydsLD6htyflcW0j4KDK5PRv4xHL+dJ3RdVMfkg3Xmr5MesRiOFX6qj1kclEbk
        U69u8slA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qrNMI-0045wN-1R;
        Fri, 13 Oct 2023 18:58:02 +0000
Date:   Fri, 13 Oct 2023 11:58:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joey Jiao <quic_jiangenj@quicinc.com>,
        linux-hardening@vger.kernel.org, syzkaller@googlegroups.com
Cc:     linux-modules@vger.kernel.org, quic_likaid@quicinc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] module: Add CONFIG_MODULE_DISABLE_INIT_FREE option
Message-ID: <ZSmTOtp8mKfBSSkD@bombadil.infradead.org>
References: <20231013062711.28852-1-quic_jiangenj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013062711.28852-1-quic_jiangenj@quicinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joey,

Thanks for working hard on expanding on the commit log to try to
describe the rationale for this. I'd like review from the linux-hardening
folks and at least one syzkaller developer.

On Fri, Oct 13, 2023 at 11:57:11AM +0530, Joey Jiao wrote:
> Syzkaller uses the _RET_IP_ (also known as pc) to decode covered
> file/function/line,

OK but that seems immediately limited as your Kconfig confirms to
!CONFIG_RANDOMIZE_BASE and even for things like kaslr.

> and it employs pc ^ hash(prev_pc) (referred to as
> signal) to indicate covered edge. If the pc for the same file/line
> keeps changing across reboots, syzkaller will report incorrect coverage
> data.

Yeah that seems pretty limiting. Why not use something like the
effort being put forward to map symbols a bit more accurately to
file / lines as with what Alessandro Carminati is doing for
scripts/link-vmlinux.sh to kallsyms. Although that effort helps
tracers differentiate duplicate symbols it would seem to also help
fuzzers too even if CONFIG_RANDOMIZE_BASE or kaslr are enabled.

[0] https://lore.kernel.org/all/ZSVkRkf3DNyxb7Vw@oracle.com/T/#m465130eb6cdd16a4c187206c69cf6a17960f90a9

> Additionally, even if kaslr can be disabled, we cannot get the
> same covered edge for module because both pc and prev_pc have changed,
> thus altering pc ^ hash(prev_pc).
> 
> To facilitate syzkaller coverage, it is crucial for both the core kernel
> and modules to maintain at the same addresses across reboots.

The problem I see with this, is that, even if it does help, the argument
being put forward here is that the below recipe is completley
deterministic and it's not obviously clear to me that it truly is.

> So, the following steps are necessary:
> - In userspace:
>   1) To maintain an uninterrupted loading sequence, it is recommended to
> execute modprobe commands by loading one module at a time, to avoid any
> interference from the scheduler.
>   2) Avoid unloading any module during fuzzing.
> - In kernel:
>   1) Disable CONFIG_RANDOMIZE_BASE to load the core kernel at the same
> address consistently.
>   2) To ensure deterministic module loading at the same address, enabling
> CONFIG_MODULE_DISABLE_INIT_FREE prevents the asynchronous freeing of init
> sections. Without this option, there is a possibility that the next module
> could be loaded into previous freed init pages of a previous loaded module.

Is this well documented somewhere as a requirement for kernels running
syzkaller?

Because clearly CONFIG_MODULE_DISABLE_INIT_FREE is showing that the
above recipe was *not* deterministic and that there were holes in it.
Who's to say this completes the determinism?

Now, if the justificaiton is that it helps current *state of the art*
fuzzing mapping... that's different and then this could just be
temporary until a more accurate deterministic mechanism is considered.

> It is important to note that this option is intended for fuzzing tests only
> and should not be set as the default configuration in production builds.

  Luis

> 
> Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
> ---
>  kernel/module/Kconfig | 13 +++++++++++++
>  kernel/module/main.c  |  3 ++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 33a2e991f608..d0df0b5997b0 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -389,4 +389,17 @@ config MODULES_TREE_LOOKUP
>  	def_bool y
>  	depends on PERF_EVENTS || TRACING || CFI_CLANG
>  
> +config MODULE_DISABLE_INIT_FREE
> +	bool "Disable freeing of init sections"
> +	default n
> +	depends on !RANDOMIZE_BASE
> +	help
> +	  By default, the kernel frees init sections after module is fully
> +	  loaded.
> +
> +	  Enabling MODULE_DISABLE_INIT_FREE allows users to prevent the freeing
> +	  of init sections. It is particularly helpful for syzkaller fuzzing,
> +	  ensuring that the module consistently loads at the same address
> +	  across reboots.

But that seems false, I don't see proof to that yet. Helping it be more
acurrate, maybe. If the docs for syzkaller clearly spell these
requirements out then maybe this is valuable upstream for now, but
in the meantime the assumption above is just a bit too large for me
to accept to be true.

> +
>  endif # MODULES
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 98fedfdb8db5..d226df3a6cf6 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2593,7 +2593,8 @@ static noinline int do_init_module(struct module *mod)
>  	 * be cleaned up needs to sync with the queued work - ie
>  	 * rcu_barrier()
>  	 */
> -	if (llist_add(&freeinit->node, &init_free_list))
> +	if (!IS_ENABLED(CONFIG_MODULE_DISABLE_INIT_FREE) &&
> +	    llist_add(&freeinit->node, &init_free_list))
>  		schedule_work(&init_free_wq);
>  
>  	mutex_unlock(&module_mutex);
> -- 
> 2.42.0
> 
