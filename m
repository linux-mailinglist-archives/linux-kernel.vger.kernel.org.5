Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771207F5CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbjKWKlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344712AbjKWKlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:41:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345B0D4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:41:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DB5C433C8;
        Thu, 23 Nov 2023 10:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700736069;
        bh=Hkc1CbVP74rWsRS/mA/tcbwRhWdc8iXVODn1MEKtb88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rokRtD0NdMvB91IlUuhs0K3iwBjaS2c7Mlggb2wtwlePzX4HuRbd1lDTLrKcy62rG
         dq8WXdiuySzqCIw6ovL1ylZfL665wtyPTXnDT88BPWWNyY3+0qPymwApF34UEO2TJa
         HPEgTLAM2jvJZWBgIR/Bv7fEzZndINnqnsOSTqssZCg8y0hKc3frKJbkytAPkR6IVC
         D0iXYWULNq4tugO14WVkNWrbefRpEUZHPd43G2HT3gTNqfuej991XNC7GXmTB4D9R4
         x95o+Jo9eBgmoEdXkcOT8XMEkzKJ9f3W+YHSVNSXMj9Uy4bUcsLZyPnHEnU91Sa0de
         XnP7BfpdbzUJg==
Date:   Thu, 23 Nov 2023 19:41:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded
 config
Message-Id: <20231123194106.08f5832f558fe806b1fd8098@kernel.org>
In-Reply-To: <20231121231342.193646-3-oss@malat.biz>
References: <20231121231342.193646-1-oss@malat.biz>
        <20231121231342.193646-3-oss@malat.biz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 00:13:42 +0100
Petr Malat <oss@malat.biz> wrote:

> Eliminate all allocations in embedded config handling to allow calling
> it from arch_setup and applying early options.
> 
> Config stored in initrd can't be used for early options, because initrd
> is set up after early options are processed.
> 
> Add this information to the documentation and also to the option
> description.
> 
> Signed-off-by: Petr Malat <oss@malat.biz>
> ---
>  Documentation/admin-guide/bootconfig.rst |   3 +
>  init/Kconfig                             |   4 +-
>  init/main.c                              | 141 ++++++++++++++++++-----
>  lib/bootconfig.c                         |  20 +++-
>  4 files changed, 132 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index 91339efdcb54..fb085f696f9b 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -161,6 +161,9 @@ Boot Kernel With a Boot Config
>  There are two options to boot the kernel with bootconfig: attaching the
>  bootconfig to the initrd image or embedding it in the kernel itself.
>  
> +Early options may be specified only in the embedded bootconfig, because
> +they are processed before the initrd.
> +
>  Attaching a Boot Config to Initrd
>  ---------------------------------
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index 9161d2dbad0c..04de756c935e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1310,7 +1310,9 @@ config BOOT_CONFIG
>  	  Extra boot config allows system admin to pass a config file as
>  	  complemental extension of kernel cmdline when booting.
>  	  The boot config file must be attached at the end of initramfs
> -	  with checksum, size and magic word.
> +	  with checksum, size and magic word. Note that early options may
> +	  be specified in the embedded bootconfig only. Early options
> +	  specified in initrd bootconfig will not be applied.
>  	  See <file:Documentation/admin-guide/bootconfig.rst> for details.
>  
>  	  If unsure, say Y.
> diff --git a/init/main.c b/init/main.c
> index 0cd738f7f0cf..9aac59673a3a 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -158,6 +158,9 @@ static size_t initargs_offs;
>  static char *execute_command;
>  static char *ramdisk_execute_command = "/init";
>  
> +static int __init do_early_param(char *param, char *val,
> +				 const char *unused, void *arg);
> +
>  /*
>   * Used to generate warnings if static_key manipulation functions are used
>   * before jump_label_init is called.
> @@ -406,63 +409,134 @@ static int __init warn_bootconfig(char *str)
>  	return 0;
>  }
>  
> -static void __init setup_boot_config(void)
> +static void __init boot_config_pr_err(const char *msg, int pos, const char *src)
> +{
> +	if (pos < 0)
> +		pr_err("Failed to init bootconfig: %s.\n", msg);
> +	else
> +		pr_err("Failed to parse %s bootconfig: %s at %d.\n",
> +				src, msg, pos);
> +}
> +
> +static int __init setup_boot_config_early(void)
>  {
>  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> -	const char *msg, *initrd_data;
> -	int pos, ret;
> -	size_t initrd_size, embeded_size = 0;
> -	char *err, *embeded_data = NULL;
> +	static int prev_rtn __initdata;

I would rather like 'done_retval' instead of 'prev_rtn'.

> +	struct xbc_node *root, *knode, *vnode;
> +	char *embeded_data, *err;
> +	const char *val, *msg;
> +	size_t embeded_size;
> +	int ret, pos;
>  
> -	/* Cut out the bootconfig data even if we have no bootconfig option */
> -	initrd_data = get_boot_config_from_initrd(&initrd_size);
> -	/* If there is no bootconfig in initrd, try embedded one. */
> -	if (!initrd_data || IS_ENABLED(CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD))
> -		embeded_data = xbc_get_embedded_bootconfig(&embeded_size);
> +	if (prev_rtn)
> +		return prev_rtn;
>  
> +	embeded_data = xbc_get_embedded_bootconfig(&embeded_size);
>  	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
>  			 bootconfig_params);

This copy & check should be skipped if IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE) because
this only checks "bootconfig" is in the cmdline.
Can you introduce following flag and initialize it here?

#ifdef CONFIG_BOOT_CONFIG_FORCE
#define bootconfig_enabled	(true)
#else
static bool bootconfig_enabled __initdata;
#endif

> -
> -	if (IS_ERR(err) || !(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)))
> -		return;
> -
> +	if (IS_ERR(err) || !(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE))) {
> +		prev_rtn = embeded_data ? -ENOMSG : -ENODATA;
> +		return prev_rtn;

Than we don't need to set a strange error value...

> +	}
>  	/* parse_args() stops at the next param of '--' and returns an address */
>  	if (err)
>  		initargs_offs = err - tmp_cmdline;
>  
> -	if (!initrd_data && !embeded_data) {
> -		/* If user intended to use bootconfig, show an error level message */
> -		if (bootconfig_found)
> -			pr_err("'bootconfig' found on command line, but no bootconfig found\n");
> -		else
> -			pr_info("No bootconfig data provided, so skipping bootconfig");
> -		return;
> +	if (!embeded_data) {
> +		prev_rtn = -ENOPROTOOPT;

Also, we can recheck xbc_get_embedded_bootconfig(&embeded_size) later instead of
using this error code.

> +		return prev_rtn;
>  	}
>  
>  	ret = xbc_init(embeded_data, embeded_size, &msg, &pos);
> -	if (ret < 0)
> -		goto err0;
> +	if (ret < 0) {
> +		boot_config_pr_err(msg, pos, "embedded");
> +		prev_rtn = ret;
> +		return prev_rtn;
> +	}
> +	prev_rtn = 1;

This function should be splitted into init_embedded_boot_config() and
apply_boot_config_early(). The latter one should not be called twice.

> +
> +	/* Process early options */
> +	root = xbc_find_node("kernel");
> +	if (!root)
> +		goto out;
> +
> +	xbc_node_for_each_key_value(root, knode, val) {
> +		ret = xbc_node_compose_key_after(root, knode,
> +				xbc_namebuf, XBC_KEYLEN_MAX);
> +		if (ret < 0)
> +			continue;
> +
> +		vnode = xbc_node_get_child(knode);
> +		if (!vnode) {
> +			do_early_param(xbc_namebuf, NULL, NULL, NULL);
> +			continue;
> +		}
> +
> +		xbc_array_for_each_value(vnode, val) {
> +			if (strscpy(tmp_cmdline, val, sizeof(tmp_cmdline)) < 1) {
> +				pr_err("Value for '%s' too long\n", xbc_namebuf);
> +				break;
> +			}
> +			do_early_param(xbc_namebuf, tmp_cmdline, NULL, NULL);
> +		}
> +	}
> +
> +out:	return embeded_data ? 1 : 0;
> +}
> +
> +static void __init setup_boot_config(void)
> +{
> +	const char *msg, *initrd_data;
> +	int pos, ret;
> +	size_t initrd_size, s;
> +
> +	/* Cut out the bootconfig data even if we have no bootconfig option */
> +	initrd_data = get_boot_config_from_initrd(&initrd_size);
> +
> +	ret = setup_boot_config_early();

Because you should not apply early_params here, you need to call only
init_embedded_boot_config() here.

> +	if (ret == -ENOMSG || (ret == -ENODATA && initrd_data)) {

Also, this can be
	if (!bootconfig_enabled) {
		if (initrd_data || xbc_get_embedded_bootconfig(&s))

> +		pr_info("Bootconfig data present, but handling is disabled\n");
> +		return;


> +	} else if (ret == -ENODATA) {
> +		/* Bootconfig disabled and bootconfig data are not present */
> +		return;

this can be removed.

> +	} else if (ret == -ENOPROTOOPT) {

This should be

	} else {

> +		/* Embedded bootconfig not found */
> +		if (!initrd_data) {
> +			pr_err("'bootconfig' found on command line, but no bootconfig data found\n");
> +			return;
> +		}
> +		ret = xbc_init(NULL, 0, &msg, &pos);
> +		if (ret)
> +			goto err0;

> +	} else if (ret < 0) {
> +		/* Other error, should be logged already */
> +		return;

So this is checked at first.

> +	} else if (initrd_data && !IS_ENABLED(CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD)) {

And as I pointed, we can remove CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD so this case
should be removed.

> +		/* Embedded bootconfig handled, but we should not append to it */
> +		xbc_get_info(&ret, &s);
> +		pr_info("Replacing embedded bootconfig of %d nodes and %zu bytes.\n", ret, s);
> +		xbc_exit();
> +		ret = xbc_init(NULL, 0, &msg, &pos);
> +		if (ret)
> +			goto err0;
> +	}

Thank you,

>  
>  	/* Call append even if no data are there as embedded bootconfig is in .init */
>  	ret = xbc_append(initrd_data, initrd_size, &msg, &pos);
>  	if (ret < 0)
>  		goto err0;
>  
> -	xbc_get_info(&ret, NULL);
> -	pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)(embeded_size + initrd_size), ret);
> +	xbc_get_info(&ret, &s);
> +	pr_info("Load bootconfig: %d nodes %zu bytes.\n", ret, s);
>  	/* keys starting with "kernel." are passed via cmdline */
>  	extra_command_line = xbc_make_cmdline("kernel");
>  	/* Also, "init." keys are init arguments */
>  	extra_init_args = xbc_make_cmdline("init");
>  	return;
>  
> -err0:	if (pos < 0)
> -		pr_err("Failed to init bootconfig: %s.\n", msg);
> -	else
> -		pr_err("Failed to parse %s bootconfig: %s at %zu.\n",
> -				pos < embeded_size ? "embedded" : "initrd",
> -				msg, pos < embeded_size ? pos : pos - embeded_size);
> +err0:	boot_config_pr_err(msg, pos, "initrd");
>  }
>  
>  static void __init exit_boot_config(void)
> @@ -766,6 +840,11 @@ void __init parse_early_param(void)
>  	if (done)
>  		return;
>  
> +#ifdef CONFIG_BOOT_CONFIG_EMBED
> +	/* Process early options from boot config */
> +	setup_boot_config_early();
> +#endif
> +
>  	/* All fall through to do_early_param. */
>  	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>  	parse_early_options(tmp_cmdline);
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 841163ce5313..4048057e3e23 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -45,7 +45,11 @@ char * __init xbc_get_embedded_bootconfig(size_t *size)
>   * node (for array).
>   */
>  
> +#ifdef CONFIG_BOOT_CONFIG_EMBED
> +static struct xbc_node xbc_nodes[XBC_NODE_MAX];
> +#else
>  static struct xbc_node *xbc_nodes __initdata;
> +#endif
>  static int xbc_node_num __initdata;
>  static char *xbc_data __initdata;
>  static bool xbc_data_allocated __initdata;
> @@ -914,8 +918,12 @@ void __init xbc_exit(void)
>  	xbc_data_size = 0;
>  	xbc_data_allocated = 0;
>  	xbc_node_num = 0;
> +#ifdef CONFIG_BOOT_CONFIG_EMBED
> +	memset(xbc_nodes, 0, sizeof(xbc_nodes));
> +#else
>  	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
>  	xbc_nodes = NULL;
> +#endif
>  	brace_index = 0;
>  }
>  
> @@ -973,6 +981,7 @@ int __init xbc_init(char *data, size_t size, const char **emsg, int *epos)
>  		return -ERANGE;
>  	}
>  
> +#ifndef CONFIG_BOOT_CONFIG_EMBED
>  	xbc_nodes = xbc_alloc_mem(sizeof(struct xbc_node) * XBC_NODE_MAX);
>  	if (!xbc_nodes) {
>  		if (emsg)
> @@ -980,7 +989,7 @@ int __init xbc_init(char *data, size_t size, const char **emsg, int *epos)
>  		return -ENOMEM;
>  	}
>  	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
> -
> +#endif
>  	if (!data)
>  		return 0;
>  	xbc_data = data;
> @@ -999,6 +1008,7 @@ int __init xbc_append(const char *data, size_t size, const char **emsg, int *epo
>  {
>  	size_t new_size, parse_start;
>  	char *new_data;
> +	int ret;
>  
>  	new_size = xbc_data_size + size;
>  	if (new_size > XBC_DATA_MAX) {
> @@ -1024,8 +1034,8 @@ int __init xbc_append(const char *data, size_t size, const char **emsg, int *epo
>  
>  	if (xbc_data_size) {
>  		memcpy(new_data, xbc_data, xbc_data_size - 1);
> -		new_data[xbc_data_size - 1] = '\n';
>  		parse_start = xbc_data_size - 1;
> +		new_data[parse_start] = '\n';
>  	} else {
>  		parse_start = 0;
>  	}
> @@ -1039,6 +1049,8 @@ int __init xbc_append(const char *data, size_t size, const char **emsg, int *epo
>  
>  	if (!data)
>  		return 0;
> -
> -	return xbc_parse_and_verify_tree(parse_start, epos, emsg);
> +	ret = xbc_parse_and_verify_tree(parse_start, epos, emsg);
> +	if (ret && epos)
> +		*epos -= parse_start;
> +	return ret;
>  }
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
