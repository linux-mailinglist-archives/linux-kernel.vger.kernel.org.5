Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8167FB956
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbjK1LV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343838AbjK1LVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:21:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B31D6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:21:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACEAC433C8;
        Tue, 28 Nov 2023 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701170490;
        bh=i2DI2lTZRH7Axef8lpr2fdCRAi/tsvwjQbIBNg6ppKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eant+qr0P1HZHabKslZIjVVItph5/CbW2XVL0AUtY1QEuN3EMW2onX27lKXKbg3Bn
         Bvg+MNrC+kdHf7IsAST0EXCJmRnuOtRXzCZ3xdStk/ONmQm+SC9IjpT4CfIIKgeiNf
         74SwjhX8le2hIUSdIeCmo88ZD46XPYdvzSiS8s0XUF2TZeSwUiN069wok99T5xGiUJ
         f9cH/mTvAxGSu0r21mQ7FWOh6lo9RVwUjp/sUZctQpG1qnPSoG+rud1D0BE97nlEGj
         gyYU1J6eiHzqFETUht0MTuMMe9vpnSWhLqVbQjyL6o+MtE66YijZ5V8xy1dAMUHXSr
         RcN4Twvwxh9Tw==
Date:   Tue, 28 Nov 2023 16:50:59 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, adrian.hunter@intel.com, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 04/10] scsi: ufs: ufs-qcom: Limit negotiated gear to
 selected PHY gear
Message-ID: <20231128112059.GS3088@thinkpad>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-5-git-send-email-quic_cang@quicinc.com>
 <20231128054522.GF3088@thinkpad>
 <bc69d9ef-6ddc-4389-8bf0-9405385a494b@quicinc.com>
 <20231128105237.GN3088@thinkpad>
 <238a3df1-5631-4922-b268-83d3dfb80c6a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <238a3df1-5631-4922-b268-83d3dfb80c6a@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 07:03:41PM +0800, Can Guo wrote:
> 
> 
> On 11/28/2023 6:52 PM, Manivannan Sadhasivam wrote:
> > On Tue, Nov 28, 2023 at 04:05:59PM +0800, Can Guo wrote:
> > > Hi Mani,
> > > 
> > > On 11/28/2023 1:45 PM, Manivannan Sadhasivam wrote:
> > > > On Thu, Nov 23, 2023 at 12:46:24AM -0800, Can Guo wrote:
> > > > > In the dual init scenario, the initial PHY gear is set to HS-G2, and the
> > > > > first Power Mode Change (PMC) is meant to find the best matching PHY gear
> > > > > for the 2nd init. However, for the first PMC, if the negotiated gear (say
> > > > > HS-G4) is higher than the initial PHY gear, we cannot go ahead let PMC to
> > > > > the negotiated gear happen, because the programmed UFS PHY settings may not
> > > > > support the negotiated gear. Fix it by overwriting the negotiated gear with
> > > > > the PHY gear.
> > > > > 
> > > > 
> > > > I don't quite understand this patch. If the phy_gear is G2 initially and the
> > > > negotiated gear is G4, then as per this change,
> > > > 
> > > > phy_gear = G4;
> > > > negotiated gear = G2;
> > > > 
> > > > Could you please explain how this make sense?
> > > 
> > > phy_gear was G2 (in the beginning) and just now changed to G4, but the PHY
> > > settings programmed in the beginning can only support no-G4 (not G4).
> > > Without this change, as the negotiated gear is G4, the power mode change is
> > > going to put UFS at HS-G4 mode, but the PHY settings programmed is no-G4.
> > 
> > But we are going to reinit the PHY anyway, isn't it?
> 
> We are power mode changing to HS-G4 with no-G4 PHY settings programmed, the
> power mode change operation, in the 1st init, may immediately cause UIC
> errors and lead to probe fail. We are not seeing issues as of now, maybe
> because the amount of HW used for testing is not large enough.
> 

I'm not sure what you are saying is what happening. Because, if we use the
incompatible gear setting, we should immediately see the UIC error.

> This change is not really related to this specific series, I can remove it
> in next version.
> 

Please do so. This needs to be reviewed separately.

- Mani

> Thanks,
> Can Guo.
> 
> > 
> > > This change is to limit the negotiated gear to HS-G2 for the 1st init. In
> > > the 2nd init, as the new PHY gear is G4, G4 PHY settings would be
> > > programmed, it'd be safe to put the UFS at HS-G4 mode.
> > > 
> > 
> > Why do we need to limit it since we already have the logic in place to set
> > whatever gear mode applicable for 1st init?
> > 
> > - Mani
> > 
> > > Thanks,
> > > Can Guo.
> > > > 
> > > > - Mani
> > > > 
> > > > > Signed-off-by: Can Guo <quic_cang@quicinc.com>
> > > > > ---
> > > > >    drivers/ufs/host/ufs-qcom.c | 7 ++++++-
> > > > >    1 file changed, 6 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > > > > index cc0eb37..d4edf58 100644
> > > > > --- a/drivers/ufs/host/ufs-qcom.c
> > > > > +++ b/drivers/ufs/host/ufs-qcom.c
> > > > > @@ -920,8 +920,13 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
> > > > >    		 * because, the PHY gear settings are backwards compatible and we only need to
> > > > >    		 * change the PHY gear settings while scaling to higher gears.
> > > > >    		 */
> > > > > -		if (dev_req_params->gear_tx > host->phy_gear)
> > > > > +		if (dev_req_params->gear_tx > host->phy_gear) {
> > > > > +			u32 old_phy_gear = host->phy_gear;
> > > > > +
> > > > >    			host->phy_gear = dev_req_params->gear_tx;
> > > > > +			dev_req_params->gear_tx = old_phy_gear;
> > > > > +			dev_req_params->gear_rx = old_phy_gear;
> > > > > +		}
> > > > >    		/* enable the device ref clock before changing to HS mode */
> > > > >    		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&
> > > > > -- 
> > > > > 2.7.4
> > > > > 
> > > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
