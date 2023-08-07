Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D73877185E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjHGCeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGCeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F081897
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CC8861305
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D334C433C8;
        Mon,  7 Aug 2023 02:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691375645;
        bh=VAgi2CztxDruPAYpUNX48zokdXixjyqxS/hrrk1Od78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdcNIft7JOYsKV5VnSN916AvoJhkYFj7nDyzq3HVG5nEgzKDzqbqcm+xvtJPzgMxp
         /y1inm0W4e05t7rAYweMY14xzOU+lNU/vm6WJoZEDWyxEZErLZvAKDSAR8S3hMA0Pm
         7/br/X8WgoZXue1WmCpJbx8pSeE+OlU93P+9LBIRtgRwB/TMkyE68Xg7uVyshDqrxg
         d6O2QqTgu0Gv7AbO1+M3e172SZP8JVoDglX8UaVGBa9of87hig91uPvgQ/8m5a+J8i
         GY4W89urt+gLNuTdG17eJ9iOG5hkYObwa0rs6pFf9rwK+VRMI+GQXUzLM6xrrkYu/8
         oZJwRLKF6sgPw==
Date:   Mon, 7 Aug 2023 10:33:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 3/9] firmware: imx: scu: drop return value check
Message-ID: <20230807023354.GL151430@dragon>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
 <20230731090449.2845997-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731090449.2845997-4-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 05:04:43PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> For IMX_SC_MISC_FUNC_UNIQUE_ID, the scfw has a return value,
> and the imx-scu always return 0. So drop the return value check.

imx_scu_call_rpc() could fail for a few reason.  Are we not want to
check those possible failures?

Shawn

> 
> BTW, also initialize msg to 0.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/imx-scu-soc.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
> index 2f32353de2c9..ef9103987e76 100644
> --- a/drivers/firmware/imx/imx-scu-soc.c
> +++ b/drivers/firmware/imx/imx-scu-soc.c
> @@ -33,20 +33,15 @@ struct imx_sc_msg_misc_get_soc_uid {
>  
>  static int imx_scu_soc_uid(u64 *soc_uid)
>  {
> -	struct imx_sc_msg_misc_get_soc_uid msg;
> +	struct imx_sc_msg_misc_get_soc_uid msg = { 0 };
>  	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> -	int ret;
>  
>  	hdr->ver = IMX_SC_RPC_VERSION;
>  	hdr->svc = IMX_SC_RPC_SVC_MISC;
>  	hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
>  	hdr->size = 1;
>  
> -	ret = imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
> -	if (ret) {
> -		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
> -		return ret;
> -	}
> +	imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
>  
>  	*soc_uid = msg.uid_high;
>  	*soc_uid <<= 32;
> -- 
> 2.37.1
> 
