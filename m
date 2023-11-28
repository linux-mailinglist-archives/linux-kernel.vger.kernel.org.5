Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDDF7FB8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbjK1KzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbjK1KzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:55:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE89B182
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:55:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03AFC433C7;
        Tue, 28 Nov 2023 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701168916;
        bh=xaI8DgSJpCKxnGj0OgbufF5SQT3bV5304U6aBzNRRtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXtbiMX+CCuZfqiD8VznplAdiicAVzfiX3wkUpZKwQM9w1U6b5Iwr1vcwOZvy/HcJ
         JbM+hep59s/yueEpV2COfKs/6Od67nUg/hGKAoEc2A4wohIB1PJzAUl4/+NI01GVvt
         wpO/5Dhe4G279cAtXNQPcHKvT1tUlqhahkXUU7DzhMTy4G9SmnzmT/TW+UnKpFbily
         7euOw8ign1svEO5l9EJmYb0kL5n5ZfF6O88DxP1webG52W1wu6g8zG/ALTB8JkfeA+
         igdkKZzIGCBcQaNFPikaydeyV9Zmx8zqWq3KX/+TpGIQ1FvEnj86+jXcQ+/jboyRLO
         wXp+ZOJwygbig==
Date:   Tue, 28 Nov 2023 16:25:06 +0530
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
Subject: Re: [PATCH v5 06/10] scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to
 hosts with HW version 5
Message-ID: <20231128105506.GO3088@thinkpad>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-7-git-send-email-quic_cang@quicinc.com>
 <20231128055520.GG3088@thinkpad>
 <4648b6a0-92cb-4411-9b58-03219962505d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4648b6a0-92cb-4411-9b58-03219962505d@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 03:48:02PM +0800, Can Guo wrote:
> Hi Mani,
> 
> On 11/28/2023 1:55 PM, Manivannan Sadhasivam wrote:
> > On Thu, Nov 23, 2023 at 12:46:26AM -0800, Can Guo wrote:
> > > Qcom UFS hosts, with HW ver 5, can only support up to HS-G5 Rate-A due to
> > > HW limitations. If the HS-G5 PHY gear is used, update host_params->hs_rate
> > > to Rate-A, so that the subsequent power mode changes shall stick to Rate-A.
> > > 
> > > Signed-off-by: Can Guo <quic_cang@quicinc.com>
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > One question below...
> > 
> > > ---
> > >   drivers/ufs/host/ufs-qcom.c | 18 +++++++++++++++++-
> > >   1 file changed, 17 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > > index 9613ad9..6756f8d 100644
> > > --- a/drivers/ufs/host/ufs-qcom.c
> > > +++ b/drivers/ufs/host/ufs-qcom.c
> > > @@ -442,9 +442,25 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
> > >   static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> > >   {
> > >   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> > > +	struct ufs_host_params *host_params = &host->host_params;
> > >   	struct phy *phy = host->generic_phy;
> > > +	enum phy_mode mode;
> > >   	int ret;
> > > +	/*
> > > +	 * HW ver 5 can only support up to HS-G5 Rate-A due to HW limitations.
> > > +	 * If the HS-G5 PHY gear is used, update host_params->hs_rate to Rate-A,
> > > +	 * so that the subsequent power mode change shall stick to Rate-A.
> > > +	 */
> > > +	if (host->hw_ver.major == 0x5) {
> > > +		if (host->phy_gear == UFS_HS_G5)
> > > +			host_params->hs_rate = PA_HS_MODE_A;
> > > +		else
> > > +			host_params->hs_rate = PA_HS_MODE_B;
> > 
> > Is this 'else' part really needed? Since there wouldn't be any 2nd init, I think
> > we can skip that.
> 
> We need it because, even there is only one init, if a UFS3.1 device is
> attached, phy_gear is given as UFS_HS_G4 in ufs_qcom_set_phy_gear(), hence
> we need to put the UFS at HS-G4 Rate B, not Rate A.
> 

But the default hs_rate is PA_HS_MODE_B only and the else condition would be not
needed for the 1st init.

- Mani

> Thanks,
> Can Guo.
> 
> > 
> > - Mani
> > 
> > > +	}
> > > +
> > > +	mode = host_params->hs_rate == PA_HS_MODE_B ? PHY_MODE_UFS_HS_B : PHY_MODE_UFS_HS_A;
> > > +
> > >   	/* Reset UFS Host Controller and PHY */
> > >   	ret = ufs_qcom_host_reset(hba);
> > >   	if (ret)
> > > @@ -459,7 +475,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> > >   		return ret;
> > >   	}
> > > -	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->phy_gear);
> > > +	phy_set_mode_ext(phy, mode, host->phy_gear);
> > >   	/* power on phy - start serdes and phy's power and clocks */
> > >   	ret = phy_power_on(phy);
> > > -- 
> > > 2.7.4
> > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
