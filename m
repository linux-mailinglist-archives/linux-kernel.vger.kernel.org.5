Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7B67F53AC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbjKVWrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344461AbjKVWrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:47:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529DA4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=IWi/mPYc+5VVJ/OP+S1Nqnn3N83YU8SmRAzoFvaiXKI=; b=r5jdkUefHHN6LxYNty1XggVyDb
        V3zDgl0CPbjMFrWxDzvDqpHvVWGWrSwDXB3nXCHsCKiFqSASjP6b/Z+rBhqwP5O75Ae1BFXcbFxaI
        K3j1zOqMkY8v8YK/wm7meghg0/AKaptiY39m0MIjmtYnTbsrqWPDopROndxRdkoA6ajcGwigugXZc
        z29EPqTTLI5GMGrscFxpxCzEx5HVCJzCLbWGwKjytuZs8vMOv6R0pNvWh6CulsCOQ5+9TPSVMwkTc
        NH0sts5Z93YqWkdwsr2A6M1TW6zUArGnQ8UVX6I3+R3DSBxEpkx2yky9ygFyg+BjX3lgdjTDyjp8G
        H/3KZOgg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r5w0J-003Elb-19;
        Wed, 22 Nov 2023 22:47:31 +0000
Message-ID: <4a67b4bb-d211-4726-8f43-d3f159127dd9@infradead.org>
Date:   Wed, 22 Nov 2023 14:47:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded config
Content-Language: en-US
To:     Petr Malat <oss@malat.biz>, linux-kernel@vger.kernel.org
Cc:     mhiramat@kernel.org, paulmck@kernel.org, rostedt@goodmis.org
References: <20231121231342.193646-1-oss@malat.biz>
 <20231121231342.193646-3-oss@malat.biz>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231121231342.193646-3-oss@malat.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 11/21/23 15:13, Petr Malat wrote:
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

I'm confused by which options are early options. Are they specified or
described somewhere?
How does a user know which options are "early" options?


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

[]

> +
> +static int __init setup_boot_config_early(void)
>  {
>  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> -	const char *msg, *initrd_data;
> -	int pos, ret;
> -	size_t initrd_size, embeded_size = 0;
> -	char *err, *embeded_data = NULL;
> +	static int prev_rtn __initdata;
> +	struct xbc_node *root, *knode, *vnode;
> +	char *embeded_data, *err;
> +	const char *val, *msg;
> +	size_t embeded_size;
> +	int ret, pos;

It hurts my eyes to see "embeded" here.

Thanks.
-- 
~Randy
