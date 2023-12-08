Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E144C80B00B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjLHW7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHW7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:59:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38C910D0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:59:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC64C433C9;
        Fri,  8 Dec 2023 22:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702076362;
        bh=ADMPGnG3jf6x58PDxr4hdxMpH14Q1rygtk48rXifLcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iCbKvEhbQKJx0RsDcnz/MNuZ2h1wzqjanLvPnkSWt9yBI3re8cd5OUlqKLUAWT7cT
         kHHJQzxSHT5eT34MufW9CxownYfHbXwfsT53je5RRqdvn+KjeiyjTEEclMbm+EFpL7
         ICFOlhGBh22WMT0XuDA0MMAuaDg5iB5Hux1KCCqA16fyNx/2weNCTB2lct5hzR74CU
         vDlrtvM63fBnlwluVkewlvEj5Z1OmZnrd0Wt+P7OEZFTEG/GTZ9ANFkNgn1hqqvtoh
         NiLjReQ+7sjGk+lVoieQYuCExiCalyJ9yfGKd+eHfqh5AaD28BTpVb83b7gst51SAv
         jg9p5mC2f2yww==
Date:   Sat, 9 Dec 2023 07:59:17 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Kris Van Hees <kris.van.hees@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH 2/6] module: add CONFIG_BUILTIN_RANGES option
Message-Id: <20231209075917.833c8f1ae78172dbb1d83b97@kernel.org>
In-Reply-To: <20231208050752.2787575-3-kris.van.hees@oracle.com>
References: <20231208050752.2787575-1-kris.van.hees@oracle.com>
        <20231208050752.2787575-3-kris.van.hees@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Dec 2023 00:07:48 -0500
Kris Van Hees <kris.van.hees@oracle.com> wrote:

> The CONFIG_BUILTIN_RANGES option controls whether offset range data is
> generated for kernel modules that are built into the kernel image.
> 
> Signed-off-by: Kris Van Hees <kris.van.hees@oracle.com>
> Reviewed-by: Nick Alcock <nick.alcock@oracle.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/module/Kconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 33a2e991f608..0798439b11ac 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -389,4 +389,21 @@ config MODULES_TREE_LOOKUP
>  	def_bool y
>  	depends on PERF_EVENTS || TRACING || CFI_CLANG
>  
> +config BUILTIN_RANGES

BUILTIN_MODULE_RANGES ?
BTW, even if CONFIG_MODULES=n, we can embed the kernel module code.
So should this visible if the CONFIG_MODULES=n ?

Thank you,

> +	bool "Generate address range information for builtin modules"
> +	depends on VMLINUX_MAP
> +	help
> +	  When modules are built into the kernel, there will be no module name
> +	  associated with its symbols in /proc/kallsyms.  Tracers may want to
> +	  identify symbols by module name and symbol name regardless of whether
> +	  the module is configured as loadable or not.
> +
> +	  This option generates modules.builtin.ranges in the build tree with
> +	  offset ranges (per ELF section) for the module(s) they belong to.
> +	  It also records an anchor symbol to determine the load address of the
> +	  section.
> +
> +	  It is fully compatible with CONFIG_RANDOMIZE_BASE and similar late-
> +	  address-modification options.
> +
>  endif # MODULES
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
