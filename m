Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD980032A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377554AbjLAFqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjLAFqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:46:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82605F2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:46:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C657C433C7;
        Fri,  1 Dec 2023 05:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701409578;
        bh=HYNNvHoGq5a3xbfd/FFacYy2iONYs/LWphKbeUdcGJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIZNI+9ZHmmbpYbR0zK10tDnJjKLWfPiPx/A3BCN0S9HEQyqysJa90ngrflqgrkrS
         k8zB8KV4Yrsw3MQ4rJgWDieUKIG8F64EDrPHtlat6cawzIrUwrUHa28/Sn3rfU+uLo
         kzKlMowNl187EHbqO/zYvAn/6ahZNZRn9JTQandW181BKDHiS4UzfQK4us4DBqyJL2
         JXxRvFgriNLAKVPM1vza8MkS7AeAyJCHGjRWdXwVUNL8SclJTd2tyoEpD+pBIjU71o
         deZHryoHp8GRxBWuh8PIih/hCNCHPWWdf8vgUT/xdjLN6aR2fBt2UZm3U3lJ3scN12
         +kOb/tmHbTcxw==
Date:   Fri, 1 Dec 2023 11:16:03 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, adrian.hunter@intel.com, vkoul@kernel.org,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 10/10] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
Message-ID: <20231201054603.GD4009@thinkpad>
References: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
 <1701407001-471-11-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1701407001-471-11-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:03:20PM -0800, Can Guo wrote:
> On SM8550, two sets of UFS PHY settings are provided, one set is to support
> HS-G5, another set is to support HS-G4 and lower gears. The two sets of PHY
> settings are programming different values to different registers, mixing
> the two sets and/or overwriting one set with another set is definitely not
> blessed by UFS PHY designers.
> 
> To add HS-G5 support for SM8550, split the two sets of PHY settings into
> their dedicated overlay tables, only the common parts of the two sets of
> PHY settings are left in the .tbls.
> 
> Consider we are going to add even higher gear support in future, to avoid
> adding more tables with different names, rename the .tbls_hs_g4 and make it
> an array, a size of 2 is enough as of now.
> 
> In this case, .tbls alone is not a complete set of PHY settings, so either
> tbls_hs_overlay[0] or tbls_hs_overlay[1] must be applied on top of the
> .tbls to become a complete set of PHY settings.
> 
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>  .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |   8 +
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 169 ++++++++++++++++++---
>  4 files changed, 159 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> index fe6c450..970cc06 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> @@ -19,6 +19,7 @@
>  #define QPHY_V6_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
>  #define QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
>  #define QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0bc
> +#define QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY	0x12c
>  #define QPHY_V6_PCS_UFS_DEBUG_BUS_CLKSEL		0x158
>  #define QPHY_V6_PCS_UFS_LINECFG_DISABLE			0x17c
>  #define QPHY_V6_PCS_UFS_RX_MIN_HIBERN8_TIME		0x184
> @@ -28,5 +29,6 @@
>  #define QPHY_V6_PCS_UFS_READY_STATUS			0x1a8
>  #define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1		0x1f4
>  #define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1		0x1fc
> +#define QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME		0x220
>  
>  #endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> index f420f8f..ef392ce 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> @@ -56,6 +56,8 @@
>  #define QSERDES_V6_COM_SYS_CLK_CTRL				0xe4
>  #define QSERDES_V6_COM_SYSCLK_BUF_ENABLE			0xe8
>  #define QSERDES_V6_COM_PLL_IVCO					0xf4
> +#define QSERDES_V6_COM_CMN_IETRIM				0xfc
> +#define QSERDES_V6_COM_CMN_IPTRIM				0x100
>  #define QSERDES_V6_COM_SYSCLK_EN_SEL				0x110
>  #define QSERDES_V6_COM_RESETSM_CNTRL				0x118
>  #define QSERDES_V6_COM_LOCK_CMP_EN				0x120
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> index 35d497f..d9a87bd 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> @@ -15,13 +15,19 @@
>  
>  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2		0x08
>  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4		0x10
> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4		0x24
>  #define QSERDES_UFS_V6_RX_UCDR_SO_SATURATION			0x28
> +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4	0x54
>  #define QSERDES_UFS_V6_RX_UCDR_PI_CTRL1				0x58
>  #define QSERDES_UFS_V6_RX_RX_TERM_BW_CTRL0			0xc4
>  #define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2			0xd4
>  #define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4			0xdc
> +#define QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4			0xf0
> +#define QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS			0xf4
>  #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL			0x178
> +#define QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x1bc
>  #define QSERDES_UFS_V6_RX_INTERFACE_MODE			0x1e0
> +#define QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3			0x1c4
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0			0x208
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1			0x20c
>  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3			0x214
> @@ -33,6 +39,8 @@
>  #define QSERDES_UFS_V6_RX_MODE_RATE3_B5				0x264
>  #define QSERDES_UFS_V6_RX_MODE_RATE3_B8				0x270
>  #define QSERDES_UFS_V6_RX_MODE_RATE4_B3				0x280
> +#define QSERDES_UFS_V6_RX_MODE_RATE4_B4				0x284
>  #define QSERDES_UFS_V6_RX_MODE_RATE4_B6				0x28c
> +#define QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL			0x2f8
>  
>  #endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 3c2e625..11cea34 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -41,6 +41,8 @@
>  
>  #define PHY_INIT_COMPLETE_TIMEOUT		10000
>  
> +#define NUM_OVERLAY				2
> +
>  struct qmp_phy_init_tbl {
>  	unsigned int offset;
>  	unsigned int val;
> @@ -754,15 +756,22 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_serdes[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
> @@ -771,19 +780,24 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),
>  };
>  
> -static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
> -	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_serdes[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IETRIM, 0x1b),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IPTRIM, 0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x06),
>  };
>  
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_tx[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x05),
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_tx[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_FR_DCC_CTRL, 0x4c),
>  };
>  
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
> -	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
>  
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xc2),
> @@ -799,16 +813,45 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
>  };
>  
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_rx[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_rx[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4, 0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B3, 0xb9),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B4, 0x4f),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B6, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL, 0x30),
> +};
> +
>  static const struct qmp_phy_init_tbl sm8550_ufsphy_pcs[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x69),
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
> -	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> +};
> +
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_pcs[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
>  	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
>  };
>  
> +static const struct qmp_phy_init_tbl sm8550_ufsphy_g5_pcs[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY, 0x4f),
> +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME, 0x9e),
> +};
> +
>  static const struct qmp_phy_init_tbl sm8650_ufsphy_serdes[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0xd9),
>  	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
> @@ -889,6 +932,8 @@ struct qmp_phy_cfg_tbls {
>  	int rx_num;
>  	const struct qmp_phy_init_tbl *pcs;
>  	int pcs_num;
> +	/* Maximum supported Gear of this tbls */
> +	u32 max_gear;
>  };
>  
>  /* struct qmp_phy_cfg - per-PHY initialization config */
> @@ -896,13 +941,15 @@ struct qmp_phy_cfg {
>  	int lanes;
>  
>  	const struct qmp_ufs_offsets *offsets;
> +	/* Maximum supported Gear of this config */
> +	u32 max_supported_gear;
>  
>  	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
>  	const struct qmp_phy_cfg_tbls tbls;
>  	/* Additional sequence for HS Series B */
>  	const struct qmp_phy_cfg_tbls tbls_hs_b;
> -	/* Additional sequence for HS G4 */
> -	const struct qmp_phy_cfg_tbls tbls_hs_g4;
> +	/* Additional sequence for different HS Gears */
> +	const struct qmp_phy_cfg_tbls tbls_hs_overlay[NUM_OVERLAY];
>  
>  	/* clock ids to be requested */
>  	const char * const *clk_list;
> @@ -1005,6 +1052,7 @@ static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
>  	.lanes			= 1,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G3,
>  
>  	.tbls = {
>  		.serdes		= msm8996_ufsphy_serdes,
> @@ -1030,6 +1078,7 @@ static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes		= sm8350_ufsphy_serdes,
> @@ -1045,13 +1094,14 @@ static const struct qmp_phy_cfg sa8775p_ufsphy_cfg = {
>  		.serdes		= sm8350_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx		= sm8350_ufsphy_g4_tx,
>  		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>  		.rx		= sm8350_ufsphy_g4_rx,
>  		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>  		.pcs		= sm8350_ufsphy_g4_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list		= sm8450_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> @@ -1064,6 +1114,7 @@ static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
>  	.lanes                  = 2,
>  
>  	.offsets                = &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes         = sm8150_ufsphy_serdes,
> @@ -1079,13 +1130,14 @@ static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
>  		.serdes         = sm8150_ufsphy_hs_b_serdes,
>  		.serdes_num     = ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx             = sm8250_ufsphy_hs_g4_tx,
>  		.tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
>  		.rx             = sc7280_ufsphy_hs_g4_rx,
>  		.rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
>  		.pcs            = sm8150_ufsphy_hs_g4_pcs,
>  		.pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list               = sm8450_ufs_phy_clk_l,
>  	.num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> @@ -1098,6 +1150,7 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes		= sm8350_ufsphy_serdes,
> @@ -1113,13 +1166,14 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
>  		.serdes		= sm8350_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx		= sm8350_ufsphy_g4_tx,
>  		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>  		.rx		= sm8350_ufsphy_g4_rx,
>  		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>  		.pcs		= sm8350_ufsphy_g4_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list		= sdm845_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> @@ -1132,6 +1186,7 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G3,
>  
>  	.tbls = {
>  		.serdes		= sdm845_ufsphy_serdes,
> @@ -1160,6 +1215,7 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>  	.lanes			= 1,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G3,
>  
>  	.tbls = {
>  		.serdes		= sm6115_ufsphy_serdes,
> @@ -1188,6 +1244,7 @@ static const struct qmp_phy_cfg sm7150_ufsphy_cfg = {
>  	.lanes			= 1,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G3,
>  
>  	.tbls = {
>  		.serdes		= sdm845_ufsphy_serdes,
> @@ -1216,6 +1273,7 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes		= sm8150_ufsphy_serdes,
> @@ -1231,13 +1289,14 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
>  		.serdes		= sm8150_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx		= sm8150_ufsphy_hs_g4_tx,
>  		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_hs_g4_tx),
>  		.rx		= sm8150_ufsphy_hs_g4_rx,
>  		.rx_num		= ARRAY_SIZE(sm8150_ufsphy_hs_g4_rx),
>  		.pcs		= sm8150_ufsphy_hs_g4_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list		= sdm845_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> @@ -1250,6 +1309,7 @@ static const struct qmp_phy_cfg sm8250_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes		= sm8150_ufsphy_serdes,
> @@ -1265,13 +1325,14 @@ static const struct qmp_phy_cfg sm8250_ufsphy_cfg = {
>  		.serdes		= sm8150_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx		= sm8250_ufsphy_hs_g4_tx,
>  		.tx_num		= ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
>  		.rx		= sm8250_ufsphy_hs_g4_rx,
>  		.rx_num		= ARRAY_SIZE(sm8250_ufsphy_hs_g4_rx),
>  		.pcs		= sm8150_ufsphy_hs_g4_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list		= sdm845_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> @@ -1284,6 +1345,7 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes		= sm8350_ufsphy_serdes,
> @@ -1299,13 +1361,14 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
>  		.serdes		= sm8350_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx		= sm8350_ufsphy_g4_tx,
>  		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>  		.rx		= sm8350_ufsphy_g4_rx,
>  		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>  		.pcs		= sm8350_ufsphy_g4_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list		= sdm845_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> @@ -1318,6 +1381,7 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets,
> +	.max_supported_gear	= UFS_HS_G4,
>  
>  	.tbls = {
>  		.serdes		= sm8350_ufsphy_serdes,
> @@ -1333,13 +1397,14 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
>  		.serdes		= sm8350_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
>  	},
> -	.tbls_hs_g4 = {
> +	.tbls_hs_overlay[0] = {
>  		.tx		= sm8350_ufsphy_g4_tx,
>  		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>  		.rx		= sm8350_ufsphy_g4_rx,
>  		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>  		.pcs		= sm8350_ufsphy_g4_pcs,
>  		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
>  	},
>  	.clk_list		= sm8450_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> @@ -1352,6 +1417,7 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets_v6,
> +	.max_supported_gear	= UFS_HS_G5,
>  
>  	.tbls = {
>  		.serdes		= sm8550_ufsphy_serdes,
> @@ -1367,6 +1433,26 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
>  		.serdes		= sm8550_ufsphy_hs_b_serdes,
>  		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_hs_b_serdes),
>  	},
> +	.tbls_hs_overlay[0] = {
> +		.serdes		= sm8550_ufsphy_g4_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_g4_serdes),
> +		.tx		= sm8550_ufsphy_g4_tx,
> +		.tx_num		= ARRAY_SIZE(sm8550_ufsphy_g4_tx),
> +		.rx		= sm8550_ufsphy_g4_rx,
> +		.rx_num		= ARRAY_SIZE(sm8550_ufsphy_g4_rx),
> +		.pcs		= sm8550_ufsphy_g4_pcs,
> +		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_g4_pcs),
> +		.max_gear	= UFS_HS_G4,
> +	},
> +	.tbls_hs_overlay[1] = {
> +		.serdes		= sm8550_ufsphy_g5_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_g5_serdes),
> +		.rx		= sm8550_ufsphy_g5_rx,
> +		.rx_num		= ARRAY_SIZE(sm8550_ufsphy_g5_rx),
> +		.pcs		= sm8550_ufsphy_g5_pcs,
> +		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_g5_pcs),
> +		.max_gear	= UFS_HS_G5,
> +	},
>  	.clk_list		= sdm845_ufs_phy_clk_l,
>  	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>  	.vreg_list		= qmp_phy_vreg_l,
> @@ -1378,6 +1464,7 @@ static const struct qmp_phy_cfg sm8650_ufsphy_cfg = {
>  	.lanes			= 2,
>  
>  	.offsets		= &qmp_ufs_offsets_v6,
> +	.max_supported_gear	= UFS_HS_G5,
>  
>  	.tbls = {
>  		.serdes		= sm8650_ufsphy_serdes,
> @@ -1451,17 +1538,49 @@ static void qmp_ufs_pcs_init(struct qmp_ufs *qmp, const struct qmp_phy_cfg_tbls
>  	qmp_ufs_configure(pcs, tbls->pcs, tbls->pcs_num);
>  }
>  
> +static int qmp_ufs_get_gear_overlay(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
> +{
> +	u32 max_gear, floor_max_gear = cfg->max_supported_gear;
> +	int idx, ret = -EINVAL;
> +
> +	for (idx = NUM_OVERLAY - 1; idx >= 0; idx--) {
> +		max_gear = cfg->tbls_hs_overlay[idx].max_gear;
> +
> +		/* Skip if the table is not available */
> +		if (max_gear == 0)
> +			continue;
> +
> +		/* Direct matching, bail */
> +		if (qmp->submode == max_gear)
> +			return idx;
> +
> +		/* If no direct matching, the lowest gear is the best matching */
> +		if (max_gear < floor_max_gear) {
> +			ret = idx;
> +			floor_max_gear = max_gear;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
>  {
> +	int i;
> +
>  	qmp_ufs_serdes_init(qmp, &cfg->tbls);
> -	if (qmp->mode == PHY_MODE_UFS_HS_B)
> -		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
>  	qmp_ufs_lanes_init(qmp, &cfg->tbls);
> -	if (qmp->submode == UFS_HS_G4)
> -		qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_g4);
>  	qmp_ufs_pcs_init(qmp, &cfg->tbls);
> -	if (qmp->submode == UFS_HS_G4)
> -		qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_g4);
> +
> +	i = qmp_ufs_get_gear_overlay(qmp, cfg);
> +	if (i >= 0) {
> +		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_overlay[i]);
> +		qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_overlay[i]);
> +		qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_overlay[i]);
> +	}
> +
> +	if (qmp->mode == PHY_MODE_UFS_HS_B)
> +		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
>  }
>  
>  static int qmp_ufs_com_init(struct qmp_ufs *qmp)
> @@ -1633,6 +1752,12 @@ static int qmp_ufs_disable(struct phy *phy)
>  static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
>  {
>  	struct qmp_ufs *qmp = phy_get_drvdata(phy);
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +
> +	if (submode > cfg->max_supported_gear || submode == 0) {
> +		dev_err(qmp->dev, "Invalid PHY submode %d\n", submode);
> +		return -EINVAL;
> +	}
>  
>  	qmp->mode = mode;
>  	qmp->submode = submode;
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
