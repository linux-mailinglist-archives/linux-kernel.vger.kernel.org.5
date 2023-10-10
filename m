Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F487BF0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441898AbjJJCjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441879AbjJJCjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:39:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487B693
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:39:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D828C433C7;
        Tue, 10 Oct 2023 02:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696905541;
        bh=CRpJbftkNFaCLIPhcQgckrIB5Pwz8ytV6P5nMBDZFL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIzthgWUBODnznko5YErlVcsGedhd4oY4a9Qr7s0B5IlEk4BpX9UoKGJo+YhGhsGv
         eSO7SMHMfcNWH2PkQOMQhYTdHD8TrhcaFJeg1ob81gv3cM6rMruQma/5uYbleHwd1z
         4ri+9+3xw+5MwzSimg7xWPexOQN2LZUYpmR1rKByTJe/bECUFglyQkmpNkMDm0wCIt
         l4zHkXL7oL/6DJiWTLHc9a9D53onKl7/4pxv7qQdjtIjxGGglfls0yk0fwteVHDSJB
         HJPR0ecyKTn+pv1aKALP8N4jJve51q3pJ5+s2OWIZRXNoAxiXjxeyG20C3sDP4omb1
         SW9Wi5UPTDHgw==
Date:   Tue, 10 Oct 2023 10:38:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] soc: imx8mp: support 128 bits UID
Message-ID: <20231010023851.GN819755@dragon>
References: <20231008083808.1517132-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008083808.1517132-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 04:38:08PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Current driver only supports 64bits UID for i.MX8MP, but
> i.MX8MP UID is actually 128bits, the high 64bits is at 0xE00.
> So update driver to support it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/soc-imx8m.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index ec87d9d878f3..5dcc227d41c0 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -24,6 +24,7 @@
>  #define OCOTP_UID_HIGH			0x420
>  
>  #define IMX8MP_OCOTP_UID_OFFSET		0x10
> +#define IMX8MP_OCOTP_UID_HIGH		0xE00

Lowercase for hex values just like other macros in the file?

>  
>  /* Same as ANADIG_DIGPROG_IMX7D */
>  #define ANADIG_DIGPROG_IMX8MM	0x800
> @@ -34,6 +35,7 @@ struct imx8_soc_data {
>  };
>  
>  static u64 soc_uid;
> +static u64 soc_uid_h;
>  
>  #ifdef CONFIG_HAVE_ARM_SMCCC
>  static u32 imx8mq_soc_revision_from_atf(void)
> @@ -122,8 +124,15 @@ static void __init imx8mm_soc_uid(void)
>  	soc_uid <<= 32;
>  	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
>  
> +	if (offset) {
> +		soc_uid_h = readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH + 0x10);
> +		soc_uid_h <<= 32;
> +		soc_uid_h |= readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH);
> +	}
> +
>  	clk_disable_unprepare(clk);
>  	clk_put(clk);
> +

Unrelated change.

>  	iounmap(ocotp_base);
>  	of_node_put(np);
>  }
> @@ -222,7 +231,12 @@ static int __init imx8_soc_init(void)
>  		goto free_soc;
>  	}
>  
> -	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
> +	if (soc_uid_h) {
> +		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
> +							soc_uid_h, soc_uid);
> +	} else {
> +		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
> +	}

Unnecessary braces for single statement.

Also it would be nice to have a newline here.

Shawn

>  	if (!soc_dev_attr->serial_number) {
>  		ret = -ENOMEM;
>  		goto free_rev;
> -- 
> 2.37.1
> 
