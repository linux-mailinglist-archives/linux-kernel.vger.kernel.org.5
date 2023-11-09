Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661077E6892
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjKIKnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjKIKnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:43:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFC4B7;
        Thu,  9 Nov 2023 02:43:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929CFC433C7;
        Thu,  9 Nov 2023 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699526586;
        bh=um0NP0x0nrIkTRKAL136Wv2MFuy+v5MKvyXzPkBIAhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgTc1bLb1mR1O5tAx89incuO5PZu3jXmEuOpIYZavKWqmfTSablL6ap9C1w3D1JAw
         zswwHNu/PS1pgU6l1CPpdD+K7l8HNvwwjl0o2aJNiwHa4+k4ghkrgC8OOmtubRHdBB
         bZkM/Vyywhb9AwJT8TFQU8q1eZQ65rqddaj3AWUJYN0WZQqu2Ia6xERPlRYqdzWE8u
         lWICifMdazlTsCUnito9oSNnTAeUOKoBBhL2AZLM998CqrbkfJEaBYoM47RoR38AWS
         K6MHPv/vTWmeKejScauk/WMDeYZQX1ospVMYGZ0BaVw39kxHORPej6I0C1u6mEs6EU
         jQqJFtajJqoCw==
Date:   Thu, 9 Nov 2023 16:12:50 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Can Guo <cang@qti.qualcomm.com>, quic_cang@quicinc.com,
        bvanassche@acm.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
Message-ID: <20231109104250.GF3752@thinkpad>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-7-git-send-email-cang@qti.qualcomm.com>
 <CAA8EJpqEkkEoQ9vncNJU1t=mKbvBXKk1FUxnmGTE0Q++sf=oXA@mail.gmail.com>
 <20231108054942.GF3296@thinkpad>
 <CAA8EJpoCZChHDQLF0QHN0PkRUWV20thXMQvK-sH2fpYaC1zcvg@mail.gmail.com>
 <20231109032418.GA3752@thinkpad>
 <CAA8EJpoZUf9Ku5meH5VAcSkCbna__5LdPi8rgnN0tyBc-UzzWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpoZUf9Ku5meH5VAcSkCbna__5LdPi8rgnN0tyBc-UzzWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 11:40:51AM +0200, Dmitry Baryshkov wrote:
> On Thu, 9 Nov 2023 at 05:24, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Wed, Nov 08, 2023 at 08:56:16AM +0200, Dmitry Baryshkov wrote:
> > > On Wed, 8 Nov 2023 at 07:49, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > >
> > > > On Tue, Nov 07, 2023 at 03:18:09PM +0200, Dmitry Baryshkov wrote:
> > > > > On Tue, 7 Nov 2023 at 06:47, Can Guo <cang@qti.qualcomm.com> wrote:
> > > > > >
> > > > > > From: Can Guo <quic_cang@quicinc.com>
> > > > > >
> > > > > > On SM8550, two sets of UFS PHY settings are provided, one set is to support
> > > > > > HS-G5, another set is to support HS-G4 and lower gears. The two sets of PHY
> > > > > > settings are programming different values to different registers, mixing
> > > > > > the two sets and/or overwriting one set with another set is definitely not
> > > > > > blessed by UFS PHY designers. In order to add HS-G5 support for SM8550, we
> > > > > > need to split the two sets into their dedicated tables, and leave only the
> > > > > > common settings in the .tlbs. To have the PHY programmed with the correct
> > > > > > set of PHY settings, the submode passed to PHY driver must be either HS-G4
> > > > > > or HS-G5.
> > > > > >
> > > >
> > > > You should also mention that this issue is also present in G4 supported targets.
> > > > And a note that it will get fixed later.
> > > >
> > > > > > Signed-off-by: Can Guo <quic_cang@quicinc.com>
> > > > > > ---
> > > > > >  drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
> > > > > >  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
> > > > > >  .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  12 +++
> > > > > >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 112 ++++++++++++++++++---
> > > > > >  4 files changed, 115 insertions(+), 13 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> > > > > > index c23d5e4..e563af5 100644
> > > > > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> > > > > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
> > > > > > @@ -18,6 +18,7 @@
> > > > > >  #define QPHY_V6_PCS_UFS_BIST_FIXED_PAT_CTRL            0x060
> > > > > >  #define QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY           0x074
> > > > > >  #define QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY           0x0bc
> > > > > > +#define QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY        0x12c
> > > > > >  #define QPHY_V6_PCS_UFS_DEBUG_BUS_CLKSEL               0x158
> > > > > >  #define QPHY_V6_PCS_UFS_LINECFG_DISABLE                        0x17c
> > > > > >  #define QPHY_V6_PCS_UFS_RX_MIN_HIBERN8_TIME            0x184
> > > > > > @@ -27,5 +28,6 @@
> > > > > >  #define QPHY_V6_PCS_UFS_READY_STATUS                   0x1a8
> > > > > >  #define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1              0x1f4
> > > > > >  #define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1               0x1fc
> > > > > > +#define QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME         0x220
> > > > > >
> > > > > >  #endif
> > > > > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> > > > > > index f420f8f..ef392ce 100644
> > > > > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> > > > > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
> > > > > > @@ -56,6 +56,8 @@
> > > > > >  #define QSERDES_V6_COM_SYS_CLK_CTRL                            0xe4
> > > > > >  #define QSERDES_V6_COM_SYSCLK_BUF_ENABLE                       0xe8
> > > > > >  #define QSERDES_V6_COM_PLL_IVCO                                        0xf4
> > > > > > +#define QSERDES_V6_COM_CMN_IETRIM                              0xfc
> > > > > > +#define QSERDES_V6_COM_CMN_IPTRIM                              0x100
> > > > > >  #define QSERDES_V6_COM_SYSCLK_EN_SEL                           0x110
> > > > > >  #define QSERDES_V6_COM_RESETSM_CNTRL                           0x118
> > > > > >  #define QSERDES_V6_COM_LOCK_CMP_EN                             0x120
> > > > > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> > > > > > index 15bcb4b..48f31c8 100644
> > > > > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> > > > > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> > > > > > @@ -10,10 +10,20 @@
> > > > > >  #define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX                     0x2c
> > > > > >  #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX              0x30
> > > > > >  #define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX              0x34
> > > > > > +#define QSERDES_UFS_V6_TX_LANE_MODE_1                          0x7c
> > > > > > +#define QSERDES_UFS_V6_TX_FR_DCC_CTRL                          0x108
> > > > > >
> > > > > >  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2          0x08
> > > > > >  #define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4          0x10
> > > > > > +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4          0x24
> > > > > > +#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4       0x54
> > > > > > +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2                   0xd4
> > > > > > +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4                   0xdc
> > > > > > +#define QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4                   0xf0
> > > > > > +#define QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS                     0xf4
> > > > > >  #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL                      0x178
> > > > > > +#define QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1             0x1bc
> > > > > > +#define QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3                        0x1c4
> > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0                     0x208
> > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1                     0x20c
> > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3                     0x214
> > > > > > @@ -25,6 +35,8 @@
> > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE3_B5                                0x264
> > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE3_B8                                0x270
> > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE4_B3                                0x280
> > > > > > +#define QSERDES_UFS_V6_RX_MODE_RATE4_B4                                0x284
> > > > > >  #define QSERDES_UFS_V6_RX_MODE_RATE4_B6                                0x28c
> > > > > > +#define QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL                      0x2f8
> > > > > >
> > > > > >  #endif
> > > > > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > > > > > index 3927eba..e0a01497 100644
> > > > > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > > > > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > > > > > @@ -649,32 +649,51 @@ static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
> > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
> > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
> > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
> > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> > > > > > +
> > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
> > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
> > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
> > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
> > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
> > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
> > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
> > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x4c),
> > > > > > +};
> > > > > > +
> > > > > > +static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
> > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
> > > > > > +};
> > > > > > +
> > > > > > +static const struct qmp_phy_init_tbl sm8550_ufsphy_g4_serdes[] = {
> > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> > > > > >         QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
> > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
> > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
> > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x99),
> > > > > > -       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x07),
> > > > >
> > > > > Aside from moving these registers to the HS_G4 table, you are also
> > > > > changing these registers. It makes me think that there was an error in
> > > > > the original programming sequence.
> > > > > If that is correct, could you please split the patch into two pieces:
> > > > > - Fix programming sequence (add proper Fixes tags)
> > > > > - Split G4 and G5 tables.
> > > >
> > > > Ack
> > > >
> > > > >
> > > > > > +
> > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
> > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
> > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
> > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x14),
> > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x99),
> > > > > > +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),
> > > > >
> > > > > I see all the MODE1 registers being only present in G4 and G5 tables.
> > > > > Should they be programmed for the modes lower than G4?
> > > > >
> > > >
> > > > We use G4 table for all the modes <= G4.
> > >
> > > Could you please point me how it's handled?
> > > In the patch I see just:
> > >
> > >        if (qmp->submode == UFS_HS_G4)
> > >                qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_g4);
> > >        else if (qmp->submode == UFS_HS_G5)
> > >                qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_g5);
> > >
> > > Which looks like two special cases (HS_G4 and HS_G5) and nothing for
> > > anything else.
> > >
> >
> > Yes, and the UFS driver passes only G4/G5. For all the gears <=G4, G4 init
> > sequence will be used and for G5, G5 sequence will be used.
> >
> 
> That's what I could not find in the UFS driver. I see a call to
> `phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->phy_gear);` and
> host->phy_gear is initialised to UFS_HS_G2.
> 

You need to check the UFS driver changes in this series to get the complete
picture as the logic is getting changed.

It is common to get confused because of the way the UFS driver (qcom mostly)
handles the PHY init sequence programming. We used to have only one init
sequence for older targets and life was easy. But when I wanted to add G4
support for SM8250, I learned that there are 2 separate init sequences. One for
non-G4 and other for G4. So I used the phy_sub_mode property to pass the
relevant mode from the UFS driver to the PHY driver and programmed the sequence
accordingly. This got extended to non-G5 and G5 now.

Now, the UFS driver will start probing from a low gear for older targets (G2)
and G4/G5 for newer ones then scale up based on the device and host capability.
For older targets, the common table (tbls) will be used if the submode doesn't
match G4/G5. But for newer targets, the UFS driver will _only_ pass G4 or G5 as
the phy_gear, so those specific sequence will only be used.

Hope I'm clear.

- Mani

> Maybe we should change the condition here (in the PHY driver) to:
> 
> if (qmp->submode <= UFS_HS_G4)
> 
> ?
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்
