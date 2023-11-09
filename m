Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226237E62BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 04:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjKIDrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 22:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKIDrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 22:47:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F4626AB;
        Wed,  8 Nov 2023 19:47:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FD2C433C7;
        Thu,  9 Nov 2023 03:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699501653;
        bh=SWhjJ7hhv9wUwqxTduJwGa1UjeUMqMhHmLc00yZI2UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEdF27pk6HCPeWqdWutrT2VL5TCOV1t1BGdbD03A2hdCz2ryxX2P+n0jr4dwRj61G
         6jo5Ks8YERqKV3//Can0w7/eJQy8oEIPdBrpWdmNnZvIgJFC5Mj0S28fDo1UYDUi/c
         x4ve6uGVTxP+vDCHqGb50asCoCbEvDYZ7qsj1Vf/HychKLNraKqpJar8G5CCDo7KpJ
         +xAHyXO3u20eT12Re+GdQJyr9hsqavj7vSNTNFB/YZFEI1f4Wa7xzftR7F09Nu6BeV
         6iUW7Lp4/bZJF9VRJ2KcDj3gSqqh42XV6TkEhnaIKK3UBPa9CA1AO4n4pAAr9VyQzO
         JRopHU2ZPbZ5Q==
Date:   Thu, 9 Nov 2023 09:17:17 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     Can Guo <cang@qti.qualcomm.com>, bvanassche@acm.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] scsi: ufs: ufs-qcom: Allow the first init start
 with the maximum supported gear
Message-ID: <20231109034717.GD3752@thinkpad>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-4-git-send-email-cang@qti.qualcomm.com>
 <20231108052310.GC3296@thinkpad>
 <49b331dc-37eb-6e26-f701-c83187a30788@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49b331dc-37eb-6e26-f701-c83187a30788@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 04:21:52PM +0800, Can Guo wrote:
> Hi Mani,
> 
> On 11/8/2023 1:23 PM, Manivannan Sadhasivam wrote:
> > On Mon, Nov 06, 2023 at 08:46:09PM -0800, Can Guo wrote:
> > > From: Can Guo <quic_cang@quicinc.com>
> > > 
> > > During host driver init, the phy_gear is set to the minimum supported gear
> > > (HS_G2). Then, during the first power mode change, the negotiated gear, say
> > > HS-G4, is updated to the phy_gear variable so that in the second init the
> > > updated phy_gear can be used to program the PHY.
> > > 
> > > But the current code only allows update the phy_gear to a higher value. If
> > > one wants to start the first init with the maximum support gear, say HS-G4,
> > > the phy_gear is not updated to HS-G3 if the device only supports HS-G3.
> > > 
> > 
> > Can you elaborate when this can happen? AFAICS, there are 3 possibilities of
> > initial phy gear with this series:
> > 
> > 1. If ufshc is < 5.0, then G2 will be used.
> > 2. If ufshc is >= 5.0 and if the version is populated in register, then that
> > gear will be used. Most likely that gear can be G4/G5 depending on the device
> > connected.
> > 3. If ufshc is >=5.0 and version is not populated, then G4 will be used.
> > 
> > In all the above cases, I do not see any necessity to switch the phy gear
> > setting to lower one while scaling. Since the gears are backwards compatible,
> > we always use one phy gear sequence. Moreover, we only have 2 init sequences.
> > 
> > Please correct me if I'm missing anything.
> > 
> > - Mani
> In the next patch, I am setting the initial PHY gear to max HS gear read
> from UFS host cap register, so that we don't need to keep updating the
> initial value for host->phy_gear for different HW versions in future. FYI,
> for HW ver 5 and 6, it is HS-G5. In future, the max gear might become HS-G6
> or higher on newer HW verions.
> 
> I the case #3, if HS-G5 is set to host->phy_gear, the first init uses HS-G5,
> then after negotiation if the agreed gear is HS-G4, we need to update
> host->phy_gear to HS-G4 (a lower value) such that we use a power saving PHY
> gear settings during the 2nd init.
> 
> If the commit message is making you confused, I can update it in next
> version. Please let me if I made any mistakes here.
> 

I see redundancy while setting the phy_gear and it is leading to confusion.
In ufs_qcom_set_host_params(), first you are setting phy_gear based on
ufs_qcom_get_hs_gear(), then changing it again with the version check for v5.

I don't see a necessity for "host->phy_gear = host_params->hs_tx_gear", since in
the later check, you are covering both version <5 and >=5.

Btw, it would be better to move this logic to a separate function like
ufs_qcom_get_phy_gear() to align with ufs_qcom_get_hs_gear().

- Mani

> Thanks,
> Can Guo.

-- 
மணிவண்ணன் சதாசிவம்
