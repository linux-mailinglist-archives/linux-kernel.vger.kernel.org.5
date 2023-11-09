Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707A57E64A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjKIHrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKIHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:47:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ED6268D;
        Wed,  8 Nov 2023 23:47:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089CAC433C8;
        Thu,  9 Nov 2023 07:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699516058;
        bh=dO4szKpe9ahRKdh4RcivDnfYxJP2VL+39rlM14Eku8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjPt4uKZz2GbHkzFKwAlHez4jvkBmPfsbsblZc7v7qLPpJhkLiwGmifEyirP0gJ1g
         fiZ/Bq647hqI+AynS1bxXvNs+6EpNhZSCl6EJ/q2uEBpHwCRpRI1sKQqSM51QlPO4j
         w4xfK5Gp8g2XU2M4oeagZF8MrV5FF5vTgCH/ZkWYEQiOVLdJZuHdXUzfn1Qn5SC0sv
         CgCLULXHKiXAovkiGBb6ym+hgMkXLiea8fb+9lieR0wz02NJPCuPN2O+S7l7mmnYzr
         7VP087tb+WucK9yMTpv8qKw846XSDti/9Q52jHJMhOfE9JimO+CgR/8hNpIN9ki2uM
         masie1JPKoawQ==
Date:   Thu, 9 Nov 2023 13:17:22 +0530
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
Message-ID: <20231109074722.GE3752@thinkpad>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-4-git-send-email-cang@qti.qualcomm.com>
 <20231108052310.GC3296@thinkpad>
 <49b331dc-37eb-6e26-f701-c83187a30788@quicinc.com>
 <20231109034717.GD3752@thinkpad>
 <91ff9299-9a2a-94b5-c9a7-c5599292cb2b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91ff9299-9a2a-94b5-c9a7-c5599292cb2b@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 12:07:37PM +0800, Can Guo wrote:
> Hi Mani,
> 
> On 11/9/2023 11:47 AM, Manivannan Sadhasivam wrote:
> > On Wed, Nov 08, 2023 at 04:21:52PM +0800, Can Guo wrote:
> > > Hi Mani,
> > > 
> > > On 11/8/2023 1:23 PM, Manivannan Sadhasivam wrote:
> > > > On Mon, Nov 06, 2023 at 08:46:09PM -0800, Can Guo wrote:
> > > > > From: Can Guo <quic_cang@quicinc.com>
> > > > > 
> > > > > During host driver init, the phy_gear is set to the minimum supported gear
> > > > > (HS_G2). Then, during the first power mode change, the negotiated gear, say
> > > > > HS-G4, is updated to the phy_gear variable so that in the second init the
> > > > > updated phy_gear can be used to program the PHY.
> > > > > 
> > > > > But the current code only allows update the phy_gear to a higher value. If
> > > > > one wants to start the first init with the maximum support gear, say HS-G4,
> > > > > the phy_gear is not updated to HS-G3 if the device only supports HS-G3.
> > > > > 
> > > > 
> > > > Can you elaborate when this can happen? AFAICS, there are 3 possibilities of
> > > > initial phy gear with this series:
> > > > 
> > > > 1. If ufshc is < 5.0, then G2 will be used.
> > > > 2. If ufshc is >= 5.0 and if the version is populated in register, then that
> > > > gear will be used. Most likely that gear can be G4/G5 depending on the device
> > > > connected.
> > > > 3. If ufshc is >=5.0 and version is not populated, then G4 will be used.
> > > > 
> > > > In all the above cases, I do not see any necessity to switch the phy gear
> > > > setting to lower one while scaling. Since the gears are backwards compatible,
> > > > we always use one phy gear sequence. Moreover, we only have 2 init sequences.
> > > > 
> > > > Please correct me if I'm missing anything.
> > > > 
> > > > - Mani
> > > In the next patch, I am setting the initial PHY gear to max HS gear read
> > > from UFS host cap register, so that we don't need to keep updating the
> > > initial value for host->phy_gear for different HW versions in future. FYI,
> > > for HW ver 5 and 6, it is HS-G5. In future, the max gear might become HS-G6
> > > or higher on newer HW verions.
> > > 
> > > I the case #3, if HS-G5 is set to host->phy_gear, the first init uses HS-G5,
> > > then after negotiation if the agreed gear is HS-G4, we need to update
> > > host->phy_gear to HS-G4 (a lower value) such that we use a power saving PHY
> > > gear settings during the 2nd init.
> > > 
> > > If the commit message is making you confused, I can update it in next
> > > version. Please let me if I made any mistakes here.
> > > 
> > 
> > I see redundancy while setting the phy_gear and it is leading to confusion.
> > In ufs_qcom_set_host_params(), first you are setting phy_gear based on
> > ufs_qcom_get_hs_gear(), then changing it again with the version check for v5.
> > 
> > I don't see a necessity for "host->phy_gear = host_params->hs_tx_gear", since in
> > the later check, you are covering both version <5 and >=5.
> In the case of HW version >= 5, we are only overwriting the PHY gear only if
> the UFS device cannot support HS-G5. Hence, we need to give host->phy_gear
> an initial value.
> 

Okay, I overlooked that part, thanks for clarifying. I think if we move the
logic to ufs_qcom_get_phy_gear(), it will be clear.

- Mani

> > 
> > Btw, it would be better to move this logic to a separate function like
> > ufs_qcom_get_phy_gear() to align with ufs_qcom_get_hs_gear().
> > 
> OK, will do in next version.
> 
> Thanks,
> Can Guo.
> > - Mani
> > 
> > > Thanks,
> > > Can Guo.
> > 

-- 
மணிவண்ணன் சதாசிவம்
