Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3697FE9B9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344736AbjK3H3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344718AbjK3H3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:29:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFDAB9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:29:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E364BC433C8;
        Thu, 30 Nov 2023 07:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701329350;
        bh=dyoP5GxI47SkSPARVksRZSB18YswC7fIj5rxMeiVlMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eWirZx2eiNBm1xpvsYjjKUsfOMId8hoQ1XftDSWXUUO3Mx/CQ1tEbl6zQwPAIBLze
         8nxWYGYPVaLY+BwAcWhv0l61i8ovPYnQ8ljdcFCXO01+LpW3kpzjyDcqRxHeImWSgY
         VuRMu5V2Wl2EwlAEgYkba/6o2fdmjlgVRXAyrtN3Bxy5x5gKkui/IUlQ2xS7tXEe9a
         dB/+Jts/YllTpPSleLeYxMrDDkmMlOHQFVJDjx5QatkUQhKUA5bTNKttchzeoLbujX
         WInYQImZF/jOXf7Cvfh7JB3IngUvodKng/B83iWelgnR7ldTXT/njPHk4oKlNWTJpO
         Vnck+CazlAqMw==
Date:   Thu, 30 Nov 2023 12:58:59 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Eric Chanudet <echanude@redhat.com>
Cc:     Can Guo <quic_cang@quicinc.com>, bvanassche@acm.org,
        adrian.hunter@intel.com, cmd4@qualcomm.com, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 10/10] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Message-ID: <20231130072859.GJ3043@thinkpad>
References: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
 <1701246516-11626-11-git-send-email-quic_cang@quicinc.com>
 <rgn6deseihby3wuwqll5qkephtzthcpxvoel6fpf6baxwjabjb@3fnuzl7bhako>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rgn6deseihby3wuwqll5qkephtzthcpxvoel6fpf6baxwjabjb@3fnuzl7bhako>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 02:04:35PM -0500, Eric Chanudet wrote:
> On Wed, Nov 29, 2023 at 12:28:35AM -0800, Can Guo wrote:
> > From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
> > 
> > A spare register in UFS host controller is used to indicate the UFS device
> > version. The spare register is populated by bootloader for now, but in
> > future it will be populated by HW automatically during link startup with
> > its best efforts in any boot stages prior to Linux.
> > 
> > During host driver init, read the spare register, if it is not populated
> > with a UFS device version, go ahead with the dual init mechanism. If a UFS
> > device version is in there, use the UFS device version together with host
> > controller's HW version to decide the proper PHY gear which should be used
> > to configure the UFS PHY without going through the second init.
> > 
> > Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> > Signed-off-by: Can Guo <quic_cang@quicinc.com>
> > ---
> >  drivers/ufs/host/ufs-qcom.c | 23 ++++++++++++++++++-----
> >  drivers/ufs/host/ufs-qcom.h |  2 ++
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index 9c0ebbc..e94dea2 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -1068,15 +1068,28 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
> >  static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
> >  {
> >  	struct ufs_host_params *host_params = &host->host_params;
> > +	u32 val, dev_major = 0;
> >  
> >  	host->phy_gear = host_params->hs_tx_gear;
> >  
> > -	/*
> > -	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> > -	 * Switching to max gear will be performed during reinit if supported.
> > -	 */
> > -	if (host->hw_ver.major < 0x4)
> > +	if (host->hw_ver.major < 0x4) {
> > +		/*
> > +		 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> > +		 * Switching to max gear will be performed during reinit if supported.
> > +		 */
> >  		host->phy_gear = UFS_HS_G2;
> > +	} else {
> > +		val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
> > +		dev_major = FIELD_GET(GENMASK(7, 4), val);
> > +
> > +		/* UFS device version populated, no need to do init twice */
> 
> This change documents the content of the register as "UFS device
> version", both inline in the code and in the commit description. Earlier
> in this series[1], Mani mentioned it was the gear info:
> > > [...]populating a spare register in the bootloader with the max gear
> > > info that the bootloader has already found[...]
> 
> Is it the gear number as in HS-G4? Or the version as in UFS controller
> revision 3.1?
> 

That was a mistake from my end, apologies. The register has the device version
only and the driver uses both device and host controller's version info to
decide the initial gear.

- Mani

> [1] https://lore.kernel.org/all/20231018124741.GA47321@thinkpad/
> 
> > +		if (dev_major != 0)
> > +			host->hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
> > +
> > +		/* For UFS 3.1 and older, apply HS-G4 PHY gear to save power */
> > +		if (dev_major < 0x4 && dev_major > 0)
> > +			host->phy_gear = UFS_HS_G4;
> > +	}
> >  }
> >  
> >  static void ufs_qcom_set_host_params(struct ufs_hba *hba)
> > diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> > index 11419eb..d12fc5a 100644
> > --- a/drivers/ufs/host/ufs-qcom.h
> > +++ b/drivers/ufs/host/ufs-qcom.h
> > @@ -54,6 +54,8 @@ enum {
> >  	UFS_AH8_CFG				= 0xFC,
> >  
> >  	REG_UFS_CFG3				= 0x271C,
> > +
> > +	REG_UFS_DEBUG_SPARE_CFG			= 0x284C,
> >  };
> >  
> >  /* QCOM UFS host controller vendor specific debug registers */
> > -- 
> > 2.7.4
> > 
> > 
> 
> -- 
> Eric Chanudet
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
