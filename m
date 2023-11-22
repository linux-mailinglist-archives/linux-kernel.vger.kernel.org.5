Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623CE7F472C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbjKVM4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbjKVM4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:56:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D049DD40
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:56:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D115C433C8;
        Wed, 22 Nov 2023 12:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700657797;
        bh=FU2GRBpzFMvCFhka/4yUjVC5jdbP1aO+NFWCN0EDrIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4N6jxHCAp4tFCAJNZ7zrrZ9aW5XpMkXkuRi8Yp9MB1itrGb27EWR0AimfSKvrUe+
         xIKBWrSUoRPshnpNl/1FbBTjcPt/Cl1VF0vhzco59odzRlZyGwoZRmdMZjOLfPFhmg
         rhd6wCVTDYHvqEWbxWu18YI68DOmN2iKp/5KC7ZgoBSiYhZoCFqq90NkNgkLbVufOZ
         q9/CcH0gvOYYJMS+j0JhWcnUbX18Dgj2WqBDTMO9yLEHoKizitqAl+ddoLOJORmSPa
         IWJTygjglhV4AnSeNAennSuNsqXoua77PVtIPyT4UHBhbMo0josGMwqdZzNhJqI4bQ
         ZRy/iwYGuHwRQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5mmh-0001kR-1j;
        Wed, 22 Nov 2023 13:56:52 +0100
Date:   Wed, 22 Nov 2023 13:56:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: qcom-qmp-usb: Add Qualcomm X1E80100 USB3 PHY
 support
Message-ID: <ZV36k8AZdy9Zm-rj@hovoldconsulting.com>
References: <20231122-phy-qualcomm-usb3-uniphy-x1e80100-v1-0-3f5bd223d5b4@linaro.org>
 <20231122-phy-qualcomm-usb3-uniphy-x1e80100-v1-2-3f5bd223d5b4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-phy-qualcomm-usb3-uniphy-x1e80100-v1-2-3f5bd223d5b4@linaro.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 02:05:22PM +0200, Abel Vesa wrote:
> The X1E80100 platform has two instances of the USB3 UNI phy attached
> to the multi-port USB controller, add definition for these.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 152 ++++++++++++++++++++++++++++++++
>  1 file changed, 152 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index 02f156298e77..bbeba5722cf0 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -24,6 +24,7 @@
>  #include "phy-qcom-qmp-pcs-misc-v4.h"
>  #include "phy-qcom-qmp-pcs-usb-v4.h"
>  #include "phy-qcom-qmp-pcs-usb-v5.h"
> +#include "phy-qcom-qmp-pcs-usb-v7.h"
>  
>  /* QPHY_SW_RESET bit */
>  #define SW_RESET				BIT(0)
> @@ -1138,6 +1139,134 @@ static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_usb_tbl[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
>  };
>  
> +static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_serdes_tbl[] = {

These tables and...

> @@ -1411,6 +1540,26 @@ static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
>  	.regs			= qmp_v5_usb3phy_regs_layout,
>  };
>  
> +static const struct qmp_phy_cfg x1e80100_usb3_uniphy_cfg = {
> +	.lanes			= 1,
> +
> +	.offsets		= &qmp_usb_offsets_v5,
> +
> +	.serdes_tbl		= x1e80100_usb3_uniphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(x1e80100_usb3_uniphy_serdes_tbl),
> +	.tx_tbl			= x1e80100_usb3_uniphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(x1e80100_usb3_uniphy_tx_tbl),
> +	.rx_tbl			= x1e80100_usb3_uniphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(x1e80100_usb3_uniphy_rx_tbl),
> +	.pcs_tbl		= x1e80100_usb3_uniphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(x1e80100_usb3_uniphy_pcs_tbl),
> +	.pcs_usb_tbl		= x1e80100_usb3_uniphy_pcs_usb_tbl,
> +	.pcs_usb_tbl_num	= ARRAY_SIZE(x1e80100_usb3_uniphy_pcs_usb_tbl),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= qmp_v5_usb3phy_regs_layout,
> +};

...this struct no longer looks like they've been added at the right
places.

> +
>  static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
>  	.lanes			= 1,
>  
> @@ -2247,6 +2396,9 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,sc8280xp-qmp-usb3-uni-phy",
>  		.data = &sc8280xp_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,x1e80100-qmp-usb3-uni-phy",
> +		.data = &x1e80100_usb3_uniphy_cfg,

Same here, please keep the entries sorted by compatible (and please
check your other x1e80100 patches for such issues after changing the SoC
name).

>  	}, {
>  		.compatible = "qcom,sdm845-qmp-usb3-uni-phy",
>  		.data = &qmp_v3_usb3_uniphy_cfg,

Johan
