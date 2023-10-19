Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEC37CFEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346436AbjJSPsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346336AbjJSPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:48:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE73E124;
        Thu, 19 Oct 2023 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=pn3uO/arD3fO0IFGZTIzO6TjABrdzGr297my+fEHmUs=; b=qZsHla9xapeuTcdf/k4ygwi3t/
        GmHwYEmzui2YwSQH7yrQjNzyI2Yl/3xhT2pokj4XVvs5Uq+9lt7Mkp9AFXexEAQ31W9Ct0MxN2eE8
        kjVj/ToQVgIZjWvgJ5C7jnI824xC5JVLxNQdjYePJMbjsrzCOk8MNXQd+YdOQLn/w36jUsPWaYjCg
        dpC5/pWzPKL37XXRoVLGIquVMjakYflpe4fPNjBrnyEYvxOtpXfe6d3tlZhfpJTEyZ7WAFyWLV4vk
        nSr/2vwK+/jcluTnfcT/K92XZc1OXefq256ymHJA/wx/rz0ytSe7wdSm2SXX2epygBs1pqiro6eDU
        J/HnN6Rw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtVGC-000FWt-2e;
        Thu, 19 Oct 2023 15:48:32 +0000
Message-ID: <d0c6044f-11e0-4f00-b7e6-eaf1e72f17a5@infradead.org>
Date:   Thu, 19 Oct 2023 08:48:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sh: bios: Revive earlyprintk support
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1697708489.git.geert+renesas@glider.be>
 <c40972dfec3dcc6719808d5df388857360262878.1697708489.git.geert+renesas@glider.be>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c40972dfec3dcc6719808d5df388857360262878.1697708489.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/19/23 02:46, Geert Uytterhoeven wrote:
> The SuperH BIOS earlyprintk code is protected by CONFIG_EARLY_PRINTK.
> However, when this protection was added, it was missed that SuperH no
> longer defines an EARLY_PRINTK config symbol since commit
> e76fe57447e88916 ("sh: Remove old early serial console code V2"), so
> BIOS earlyprintk can no longer be used.
> 
> Fix this by reviving the EARLY_PRINTK config symbol.
> 
> Fixes: d0380e6c3c0f6edb ("early_printk: consolidate random copies of identical code")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/sh/Kconfig.debug | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
> index c449e7c1b20ff5b5..8bcd6c1431a95be9 100644
> --- a/arch/sh/Kconfig.debug
> +++ b/arch/sh/Kconfig.debug
> @@ -22,6 +22,17 @@ config STACK_DEBUG
>  	  every function call and will therefore incur a major
>  	  performance hit. Most users should say N.
>  
> +config EARLY_PRINTK
> +	bool "Early printk"
> +	depends on SH_STANDARD_BIOS
> +	help
> +	  Say Y here to redirect kernel printk messages to the serial port
> +	  used by the SH-IPL bootloader, starting very early in the boot
> +	  process and ending when the kernel's serial console is initialised.
> +	  This option is only useful while porting the kernel to a new machine,

Can we expect to see new machine ports using arch/sh/ ?

> +	  when the kernel may crash or hang before the serial console is
> +	  initialised.  If unsure, say N.
> +
>  config 4KSTACKS
>  	bool "Use 4Kb for kernel stacks instead of 8Kb"
>  	depends on DEBUG_KERNEL && (MMU || BROKEN) && !PAGE_SIZE_64KB


-- 
~Randy
