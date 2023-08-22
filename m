Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D69783AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjHVHSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjHVHRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:17:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E86CE4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A3B364975
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E088BC433C7;
        Tue, 22 Aug 2023 07:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688572;
        bh=RT1OqrnCd6C6NpSoQD4g/wycSyNNvZa0qH/WkMlLIEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkibjg8RJY/v5zU5QOiRXZN8i5SHGLwq4hIQusVJdGKGyW5IcSNlcDloW97ry31xZ
         96c1VJ0wZA9WniGpFmcBFK92DByr5fdRqabNss3qxr+37ycJW/oWZ+bKUzjiOkUcgY
         a4BTHtOb50KW6ayoKIlv3vVPxQUjX2xzo1JZAXVXEH1Ubfx9KufBM2s2qqWV9m1vzF
         lXymaAtmxoMM1bv9ZHr7FpEOx1I/ecST98DcdvNVQod71dWAHaHTTMPkh11pi5U3o0
         xRSWyfI0PgkiGclbSkrsWasJB86w/EgsL71I0qynjmDW2f4/UMiUWM4nXQmmDdaOro
         wfKRXG6hw/PLA==
Date:   Tue, 22 Aug 2023 09:16:07 +0200
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH V3 2/3] octeontx2-af: CN10KB: fix PFC configuration
Message-ID: <20230822071607.GJ2711035@kernel.org>
References: <20230821052516.398572-1-sumang@marvell.com>
 <20230821052516.398572-3-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821052516.398572-3-sumang@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:55:15AM +0530, Suman Ghosh wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
> 
> The previous patch which added new CN10KB RPM block support,
> has a bug due to which PFC is not getting configured properly.
> This patch fixes the same.

Hi Suman,

I think it would be useful to describe what the bug is - it seems like an
incorrect mask in some cases - and how that might affect users. Better
still would be commands for an example usage where the problem previously
manifested.

> 
> Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
> index b4fcb20c3f4f..af21e2030cff 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
> @@ -355,8 +355,8 @@ int rpm_lmac_enadis_pause_frm(void *rpmd, int lmac_id, u8 tx_pause,
>  
>  void rpm_lmac_pause_frm_config(void *rpmd, int lmac_id, bool enable)
>  {
> +	u64 cfg, pfc_class_mask_cfg;
>  	rpm_t *rpm = rpmd;
> -	u64 cfg;
>  
>  	/* ALL pause frames received are completely ignored */
>  	cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
> @@ -380,9 +380,11 @@ void rpm_lmac_pause_frm_config(void *rpmd, int lmac_id, bool enable)
>  		rpm_write(rpm, 0, RPMX_CMR_CHAN_MSK_OR, ~0ULL);
>  
>  	/* Disable all PFC classes */
> -	cfg = rpm_read(rpm, lmac_id, RPMX_CMRX_PRT_CBFC_CTL);
> +	pfc_class_mask_cfg = is_dev_rpm2(rpm) ? RPM2_CMRX_PRT_CBFC_CTL :
> +						RPMX_CMRX_PRT_CBFC_CTL;

Maybe it is overkill, but as this appears at least twice,
perhaps a helper would be appropriate.

> +	cfg = rpm_read(rpm, lmac_id, pfc_class_mask_cfg);
>  	cfg = FIELD_SET(RPM_PFC_CLASS_MASK, 0, cfg);
> -	rpm_write(rpm, lmac_id, RPMX_CMRX_PRT_CBFC_CTL, cfg);
> +	rpm_write(rpm, lmac_id, pfc_class_mask_cfg, cfg);
>  }
>  
>  int rpm_get_rx_stats(void *rpmd, int lmac_id, int idx, u64 *rx_stat)
> @@ -605,8 +607,11 @@ int rpm_lmac_pfc_config(void *rpmd, int lmac_id, u8 tx_pause, u8 rx_pause, u16 p
>  	if (!is_lmac_valid(rpm, lmac_id))
>  		return -ENODEV;
>  
> +	pfc_class_mask_cfg = is_dev_rpm2(rpm) ? RPM2_CMRX_PRT_CBFC_CTL :
> +						RPMX_CMRX_PRT_CBFC_CTL;
> +
>  	cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
> -	class_en = rpm_read(rpm, lmac_id, RPMX_CMRX_PRT_CBFC_CTL);
> +	class_en = rpm_read(rpm, lmac_id, pfc_class_mask_cfg);
>  	pfc_en |= FIELD_GET(RPM_PFC_CLASS_MASK, class_en);
>  
>  	if (rx_pause) {
> @@ -635,10 +640,6 @@ int rpm_lmac_pfc_config(void *rpmd, int lmac_id, u8 tx_pause, u8 rx_pause, u16 p
>  		cfg |= RPMX_MTI_MAC100X_COMMAND_CONFIG_PFC_MODE;
>  
>  	rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
> -
> -	pfc_class_mask_cfg = is_dev_rpm2(rpm) ? RPM2_CMRX_PRT_CBFC_CTL :
> -						RPMX_CMRX_PRT_CBFC_CTL;
> -
>  	rpm_write(rpm, lmac_id, pfc_class_mask_cfg, class_en);
>  
>  	return 0;
> -- 
> 2.25.1
> 
> 
