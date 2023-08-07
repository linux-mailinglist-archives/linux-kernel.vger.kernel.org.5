Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CFD771877
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjHGCwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjHGCwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:52:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7211986
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D43B9612F5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345ECC433C7;
        Mon,  7 Aug 2023 02:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691376724;
        bh=gJk6vVUXiDkmun1RcHH2FC9OYEdQQqWcGTvzESd3jtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qiqVSHhvLFxrJT5OH8ndniw3nRBvfBjs/YcaJ6ndswkbACC/4rTH3sIDzQiS11m5m
         x3cEMjZUqhxk42ZR024u2P4pSQ5HlszAbBWbJZYqXLl7iv3s9zDSzwc5Dduv8who+G
         EEPpMRZL2/aLE1V0T80GUXLAVf3NZ7j4zjMvJQhf9qEMg9BU/PcBaF2Efv6jaJ9daJ
         fBxyK/qzIUIIX/z2X86WDvlI2uXn2RHhtcN3kMhfmO7CNYpglnP4dSmlGy3FzRdN6u
         WEkcNONDJePjlHHE6yDaQybnOkG7qI1pT/KQqPaHe7BtXv1QdVVVLWpQKUATfMj1hc
         CQoom4Gnh0mhQ==
Date:   Mon, 7 Aug 2023 10:51:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 4/9] firmware: imx: scu: use soc name for soc_id
Message-ID: <20230807025153.GM151430@dragon>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
 <20230731090449.2845997-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731090449.2845997-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 05:04:44PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Same as soc-imx8m and soc-imx driver, use soc name for soc_id
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/imx-scu-soc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
> index ef9103987e76..cb8377670a7d 100644
> --- a/drivers/firmware/imx/imx-scu-soc.c
> +++ b/drivers/firmware/imx/imx-scu-soc.c
> @@ -107,10 +107,12 @@ int imx_scu_soc_init(struct device *dev)
>  		return -EINVAL;
>  
>  	/* format soc_id value passed from SCU firmware */
> -	val = id & 0x1f;
> -	soc_dev_attr->soc_id = devm_kasprintf(dev, GFP_KERNEL, "0x%x", val);
> -	if (!soc_dev_attr->soc_id)
> -		return -ENOMEM;
> +	if (of_machine_is_compatible("fsl,imx8qm"))
> +		soc_dev_attr->soc_id = "i.MX8QM";
> +	else if (of_machine_is_compatible("fsl,imx8qxp"))
> +		soc_dev_attr->soc_id = "i.MX8QXP";
> +	else if (of_machine_is_compatible("fsl,imx8dxl"))
> +		soc_dev_attr->soc_id = "i.MX8DXL";

Is it possible to deduce SoC name from the id retrieved from SCU firmware?
IMO, device tree should be the last resort when there is no other
sources for the such information.

Shawn

>  
>  	/* format revision value passed from SCU firmware */
>  	val = (id >> 5) & 0xf;
> -- 
> 2.37.1
> 
