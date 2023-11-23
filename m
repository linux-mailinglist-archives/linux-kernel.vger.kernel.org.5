Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5A47F5670
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbjKWCao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKWCam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:30:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A23D191
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 18:30:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31687C433C7;
        Thu, 23 Nov 2023 02:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700706647;
        bh=RG/9HtREZC7P8kyrlN4x4dzPHdA++B0V9olP3M7OUxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DMe2UTHVVzp6Vd+lr4hmm0DPL7Jkdf583jhx3bp2HJDrWVvSS/eSHbzpw8o0WC79I
         De+VfG9nNgyN66NA96EEu0+fzeaNFUmBl2dkeUAItWZFxwiLxyKg9gkK5yBE2QLPKe
         AuwDyuJSl0Og4XVtfQ8nbuxqltvr57WaEX6UAkwfwz4p9Gr0SEl937aB6mmCYvlAiB
         nRWSCwD+FZHbSYu8adrpqVu1GU7zfC5tNemKkp910hmpmaGZr6YQrhHPPUg+dloSVl
         +TS6bzwWDddF9yMXGF4gs5wJKUUiLevYVhuuzpFLLCH18W5Lra2ghkI9t5FvXoKaK1
         bI3tYuXD3SGDA==
Date:   Thu, 23 Nov 2023 11:30:43 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 1/2] bootconfig: Support appending initrd config to
 embedded one
Message-Id: <20231123113043.26d103fe1fac8fdd2bf5ae1d@kernel.org>
In-Reply-To: <20231121231342.193646-2-oss@malat.biz>
References: <20231121231342.193646-1-oss@malat.biz>
        <20231121231342.193646-2-oss@malat.biz>
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

On Wed, 22 Nov 2023 00:13:41 +0100
Petr Malat <oss@malat.biz> wrote:

> When both embedded and initrd boot configs are present, initrd config is
> preferred. Introduce CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD option, which
> allows appending the initrd config to the embedded one.
> 
> We handle embedded boot config in-place to avoid allocations, which will
> be handy for early parameters support.
> 
> Signed-off-by: Petr Malat <oss@malat.biz>
> ---
>  include/linux/bootconfig.h |  10 ++-
>  init/Kconfig               |   9 +++
>  init/main.c                |  62 ++++++++++--------
>  lib/bootconfig-data.S      |   3 +-
>  lib/bootconfig.c           | 129 +++++++++++++++++++++++++++----------
>  5 files changed, 146 insertions(+), 67 deletions(-)
> 
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index ca73940e26df..88bbcffa82d5 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -281,7 +281,10 @@ static inline int __init xbc_node_compose_key(struct xbc_node *node,
>  }
>  
>  /* XBC node initializer */
> -int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
> +int __init xbc_init(char *buf, size_t size, const char **emsg, int *epos);
> +
> +/* Append XBC data */
> +int __init xbc_append(const char *data, size_t size, const char **emsg, int *epos);
>  
>  /* XBC node and size information */
>  int __init xbc_get_info(int *node_size, size_t *data_size);
> @@ -291,10 +294,11 @@ void __init xbc_exit(void);
>  
>  /* XBC embedded bootconfig data in kernel */
>  #ifdef CONFIG_BOOT_CONFIG_EMBED
> -const char * __init xbc_get_embedded_bootconfig(size_t *size);
> +char * __init xbc_get_embedded_bootconfig(size_t *size);
>  #else
> -static inline const char *xbc_get_embedded_bootconfig(size_t *size)
> +static inline char *xbc_get_embedded_bootconfig(size_t *size)
>  {
> +	*size = 0;
>  	return NULL;
>  }
>  #endif
> diff --git a/init/Kconfig b/init/Kconfig
> index 6d35728b94b2..9161d2dbad0c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1339,6 +1339,15 @@ config BOOT_CONFIG_EMBED
>  
>  	  If unsure, say N.
>  
> +config BOOT_CONFIG_EMBED_APPEND_INITRD

With the early param handling feature, this must be enabled always because
without this feature, the early params are set by embedded bootconfig, but
that will be replaced by initrd bootconfig.


> +	bool "Append initrd bootconfig to the embedded one"
> +	depends on BOOT_CONFIG_EMBED && BLK_DEV_INITRD
> +	default n
> +	help
> +	  By default if both embedded bootconfig and initrd bootconfig are
> +	  found, initrd bootconfig is preferred. If this option is set, initrd
> +	  bootconfig gets appended to the embedded one.
> +
>  config BOOT_CONFIG_EMBED_FILE
>  	string "Embedded bootconfig file path"
>  	depends on BOOT_CONFIG_EMBED
> diff --git a/init/main.c b/init/main.c
> index 436d73261810..0cd738f7f0cf 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -267,6 +267,9 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
>  	u32 *hdr;
>  	int i;
>  
> +	if (_size)
> +		*_size = 0;
> +
>  	if (!initrd_end)
>  		return NULL;
>  
> @@ -309,6 +312,8 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
>  #else
>  static void * __init get_boot_config_from_initrd(size_t *_size)
>  {
> +	if (_size)
> +		*_size = 0;
>  	return NULL;
>  }
>  #endif
> @@ -404,16 +409,16 @@ static int __init warn_bootconfig(char *str)
>  static void __init setup_boot_config(void)
>  {
>  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> -	const char *msg, *data;
> +	const char *msg, *initrd_data;
>  	int pos, ret;
> -	size_t size;
> -	char *err;
> +	size_t initrd_size, embeded_size = 0;
> +	char *err, *embeded_data = NULL;
>  
>  	/* Cut out the bootconfig data even if we have no bootconfig option */
> -	data = get_boot_config_from_initrd(&size);
> +	initrd_data = get_boot_config_from_initrd(&initrd_size);
>  	/* If there is no bootconfig in initrd, try embedded one. */
> -	if (!data)
> -		data = xbc_get_embedded_bootconfig(&size);
> +	if (!initrd_data || IS_ENABLED(CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD))
> +		embeded_data = xbc_get_embedded_bootconfig(&embeded_size);

Thus, this part can be simply get both initrd and embedded one.

Thank you,

>  
>  	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> @@ -426,7 +431,7 @@ static void __init setup_boot_config(void)
>  	if (err)
>  		initargs_offs = err - tmp_cmdline;
>  
> -	if (!data) {
> +	if (!initrd_data && !embeded_data) {
>  		/* If user intended to use bootconfig, show an error level message */
>  		if (bootconfig_found)
>  			pr_err("'bootconfig' found on command line, but no bootconfig found\n");
> @@ -435,28 +440,29 @@ static void __init setup_boot_config(void)
>  		return;
>  	}
>  
> -	if (size >= XBC_DATA_MAX) {
> -		pr_err("bootconfig size %ld greater than max size %d\n",
> -			(long)size, XBC_DATA_MAX);
> -		return;
> -	}
> -
> -	ret = xbc_init(data, size, &msg, &pos);
> -	if (ret < 0) {
> -		if (pos < 0)
> -			pr_err("Failed to init bootconfig: %s.\n", msg);
> -		else
> -			pr_err("Failed to parse bootconfig: %s at %d.\n",
> -				msg, pos);
> -	} else {
> -		xbc_get_info(&ret, NULL);
> -		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
> -		/* keys starting with "kernel." are passed via cmdline */
> -		extra_command_line = xbc_make_cmdline("kernel");
> -		/* Also, "init." keys are init arguments */
> -		extra_init_args = xbc_make_cmdline("init");
> -	}
> +	ret = xbc_init(embeded_data, embeded_size, &msg, &pos);
> +	if (ret < 0)
> +		goto err0;
> +
> +	/* Call append even if no data are there as embedded bootconfig is in .init */
> +	ret = xbc_append(initrd_data, initrd_size, &msg, &pos);
> +	if (ret < 0)
> +		goto err0;
> +
> +	xbc_get_info(&ret, NULL);
> +	pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)(embeded_size + initrd_size), ret);
> +	/* keys starting with "kernel." are passed via cmdline */
> +	extra_command_line = xbc_make_cmdline("kernel");
> +	/* Also, "init." keys are init arguments */
> +	extra_init_args = xbc_make_cmdline("init");
>  	return;
> +
> +err0:	if (pos < 0)
> +		pr_err("Failed to init bootconfig: %s.\n", msg);
> +	else
> +		pr_err("Failed to parse %s bootconfig: %s at %zu.\n",
> +				pos < embeded_size ? "embedded" : "initrd",
> +				msg, pos < embeded_size ? pos : pos - embeded_size);
>  }
>  
>  static void __init exit_boot_config(void)
> diff --git a/lib/bootconfig-data.S b/lib/bootconfig-data.S
> index ef85ba1a82f4..f447e24eb8fa 100644
> --- a/lib/bootconfig-data.S
> +++ b/lib/bootconfig-data.S
> @@ -2,9 +2,10 @@
>  /*
>   * Embed default bootconfig in the kernel.
>   */
> -	.section .init.rodata, "aw"
> +	.section .init.data, "aw"
>  	.global embedded_bootconfig_data
>  embedded_bootconfig_data:
>  	.incbin "lib/default.bconf"
> +	.byte 0
>  	.global embedded_bootconfig_data_end
>  embedded_bootconfig_data_end:
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index c59d26068a64..841163ce5313 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -15,13 +15,13 @@
>  
>  #ifdef CONFIG_BOOT_CONFIG_EMBED
>  /* embedded_bootconfig_data is defined in bootconfig-data.S */
> -extern __visible const char embedded_bootconfig_data[];
> -extern __visible const char embedded_bootconfig_data_end[];
> +extern __visible char embedded_bootconfig_data[];
> +extern __visible char embedded_bootconfig_data_end[];
>  
> -const char * __init xbc_get_embedded_bootconfig(size_t *size)
> +char * __init xbc_get_embedded_bootconfig(size_t *size)
>  {
>  	*size = embedded_bootconfig_data_end - embedded_bootconfig_data;
> -	return (*size) ? embedded_bootconfig_data : NULL;
> +	return *size ? embedded_bootconfig_data : NULL;
>  }
>  #endif
>  
> @@ -48,6 +48,7 @@ const char * __init xbc_get_embedded_bootconfig(size_t *size)
>  static struct xbc_node *xbc_nodes __initdata;
>  static int xbc_node_num __initdata;
>  static char *xbc_data __initdata;
> +static bool xbc_data_allocated __initdata;
>  static size_t xbc_data_size __initdata;
>  static struct xbc_node *last_parent __initdata;
>  static const char *xbc_err_msg __initdata;
> @@ -846,13 +847,14 @@ static int __init xbc_verify_tree(void)
>  }
>  
>  /* Need to setup xbc_data and xbc_nodes before call this. */
> -static int __init xbc_parse_tree(void)
> +static int __init xbc_parse_tree(int offset)
>  {
>  	char *p, *q;
>  	int ret = 0, c;
>  
> -	last_parent = NULL;
> -	p = xbc_data;
> +	if (!offset)
> +		last_parent = NULL;
> +	p = xbc_data + offset;
>  	do {
>  		q = strpbrk(p, "{}=+;:\n#");
>  		if (!q) {
> @@ -906,18 +908,42 @@ static int __init xbc_parse_tree(void)
>   */
>  void __init xbc_exit(void)
>  {
> -	xbc_free_mem(xbc_data, xbc_data_size);
> +	if (xbc_data_allocated)
> +		xbc_free_mem(xbc_data, xbc_data_size);
>  	xbc_data = NULL;
>  	xbc_data_size = 0;
> +	xbc_data_allocated = 0;
>  	xbc_node_num = 0;
>  	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
>  	xbc_nodes = NULL;
>  	brace_index = 0;
>  }
>  
> +static int xbc_parse_and_verify_tree(int offset, int *epos, const char **emsg)
> +{
> +	int ret;
> +
> +	ret = xbc_parse_tree(offset);
> +	if (!ret) {
> +		ret = xbc_verify_tree();
> +		if (!ret)
> +			return xbc_node_num;
> +	}
> +
> +	if (epos)
> +		*epos = xbc_err_pos;
> +	if (emsg)
> +		*emsg = xbc_err_msg;
> +
> +	xbc_exit();
> +	return ret;
> +}
> +
>  /**
>   * xbc_init() - Parse given XBC file and build XBC internal tree
> - * @data: The boot config text original data
> + * @data: Null terminated boot config data, that can be directly
> + *        modified by the parser and will exist till xbc_exit()
> + *        or xbc_append() is called.
>   * @size: The size of @data
>   * @emsg: A pointer of const char * to store the error message
>   * @epos: A pointer of int to store the error position
> @@ -930,10 +956,8 @@ void __init xbc_exit(void)
>   * @epos will be updated with the error position which is the byte offset
>   * of @buf. If the error is not a parser error, @epos will be -1.
>   */
> -int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
> +int __init xbc_init(char *data, size_t size, const char **emsg, int *epos)
>  {
> -	int ret;
> -
>  	if (epos)
>  		*epos = -1;
>  
> @@ -942,44 +966,79 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
>  			*emsg = "Bootconfig is already initialized";
>  		return -EBUSY;
>  	}
> -	if (size > XBC_DATA_MAX || size == 0) {
> +	if (size > XBC_DATA_MAX || (size == 0 && data != NULL)) {
>  		if (emsg)
>  			*emsg = size ? "Config data is too big" :
>  				"Config data is empty";
>  		return -ERANGE;
>  	}
>  
> -	xbc_data = xbc_alloc_mem(size + 1);
> -	if (!xbc_data) {
> -		if (emsg)
> -			*emsg = "Failed to allocate bootconfig data";
> -		return -ENOMEM;
> -	}
> -	memcpy(xbc_data, data, size);
> -	xbc_data[size] = '\0';
> -	xbc_data_size = size + 1;
> -
>  	xbc_nodes = xbc_alloc_mem(sizeof(struct xbc_node) * XBC_NODE_MAX);
>  	if (!xbc_nodes) {
>  		if (emsg)
>  			*emsg = "Failed to allocate bootconfig nodes";
> -		xbc_exit();
>  		return -ENOMEM;
>  	}
>  	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
>  
> -	ret = xbc_parse_tree();
> -	if (!ret)
> -		ret = xbc_verify_tree();
> +	if (!data)
> +		return 0;
> +	xbc_data = data;
> +	xbc_data_size = size;
> +	return xbc_parse_and_verify_tree(0, epos, emsg);
> +}
>  
> -	if (ret < 0) {
> -		if (epos)
> -			*epos = xbc_err_pos;
> +/**
> + * xbc_append() - Append data to already existing XBC tree
> + * @data: Boot config data, which are copied by the function.
> + * @size: The size of @data
> + * @emsg: A pointer of const char * to store the error message
> + * @epos: A pointer of int to store the error position
> + */
> +int __init xbc_append(const char *data, size_t size, const char **emsg, int *epos)
> +{
> +	size_t new_size, parse_start;
> +	char *new_data;
> +
> +	new_size = xbc_data_size + size;
> +	if (new_size > XBC_DATA_MAX) {
>  		if (emsg)
> -			*emsg = xbc_err_msg;
> -		xbc_exit();
> -	} else
> -		ret = xbc_node_num;
> +			*emsg = "Merged config data is too big";
> +		return -ERANGE;
> +	}
> +	if (new_size == 0) {
> +		if (data) {
> +			if (emsg)
> +				*emsg = "Appended data is empty";
> +			return -ERANGE;
> +		}
> +		return 0;
> +	}
>  
> -	return ret;
> +	new_data = xbc_alloc_mem(new_size);
> +	if (!new_data) {
> +		if (emsg)
> +			*emsg = "Failed to allocate bootconfig data";
> +		return -ENOMEM;
> +	}
> +
> +	if (xbc_data_size) {
> +		memcpy(new_data, xbc_data, xbc_data_size - 1);
> +		new_data[xbc_data_size - 1] = '\n';
> +		parse_start = xbc_data_size - 1;
> +	} else {
> +		parse_start = 0;
> +	}
> +	memcpy(new_data + xbc_data_size, data, size);
> +	new_data[new_size - 1] = 0;
> +	if (xbc_data_allocated)
> +		xbc_free_mem(xbc_data, xbc_data_size);
> +	xbc_data_allocated = 1;
> +	xbc_data = new_data;
> +	xbc_data_size = new_size;
> +
> +	if (!data)
> +		return 0;
> +
> +	return xbc_parse_and_verify_tree(parse_start, epos, emsg);
>  }
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
