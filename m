Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D947FB959
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbjK1LWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344562AbjK1LWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:22:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AAE1B5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:22:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E45C433C8;
        Tue, 28 Nov 2023 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701170573;
        bh=WglVg4QTboxa3lShvbhgZWQpr4iJvJtH84sJvM8L2Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GoUKnOd+WSY7zMaRmi6vpxO/0HINSs/K0kiokux3y/7OZyKEVGWUCkffSLUK9fGT2
         aKQlGpy2IeZlZK3THoC3Nk69HdDRWqaaBbUthmrgs+dgpHBXwxE7yrH7UcDjCTKM5W
         cM+igWMJ1Yk373hTLLdLkYx0YQ3sx96eP33DabCQf5SL90n47YKDdEPJbSpAk7iYiA
         mhplZMp2agZtroYvsbq1ya7C6LMidw++F2jsVO6s26EtTDL4XZYaM+V9E4S5hKAqNG
         uXWvrVNvHFlFINQxQ9dpj724nLWaL+mZOHAsgZtDg1pU3hbTApqtEcDdhLZt9QWv7f
         M5q9JxujjV+Ow==
Date:   Tue, 28 Nov 2023 16:52:43 +0530
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
Subject: Re: [PATCH v5 07/10] scsi: ufs: ufs-qcom: Set initial PHY gear to
 max HS gear for HW ver 5 and newer
Message-ID: <20231128112243.GT3088@thinkpad>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-8-git-send-email-quic_cang@quicinc.com>
 <20231128060046.GH3088@thinkpad>
 <d198f09b-6b5f-42de-9331-30c6d2a12b67@quicinc.com>
 <20231128105902.GP3088@thinkpad>
 <19e8a264-dc9f-4303-b5b4-f781b9fd0125@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19e8a264-dc9f-4303-b5b4-f781b9fd0125@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 07:01:27PM +0800, Can Guo wrote:
> 
> 
> On 11/28/2023 6:59 PM, Manivannan Sadhasivam wrote:
> > On Tue, Nov 28, 2023 at 03:58:42PM +0800, Can Guo wrote:
> > > Hi Mani,
> > > 
> > > On 11/28/2023 2:00 PM, Manivannan Sadhasivam wrote:
> > > > On Thu, Nov 23, 2023 at 12:46:27AM -0800, Can Guo wrote:
> > > > > Set the initial PHY gear to max HS gear for hosts with HW ver 5 and newer.
> > > > > 
> > > > 
> > > > MAX_GEAR will be used for hosts with hw_ver.major >= 4
> > > 
> > > I put it > 5 because I am not intent to touch any old targets which has
> > > proven working fine with starting with PHY gear HS_G2. If I put it >= 4,
> > > there would be many targets impacted by this change. I need to go back and
> > > test those platforms (HW ver == 4).
> > > 
> > 
> > This assumption will make the code hard to maintain. I think if you happen to
> > test it on atleast a couple of old targets it should be good since I do not see
> > how others can fail.
> 
> Point taken. I will put it >= 4 in next version and test it on platforms
> like SM8350 and SM8450.
> 

Appreciated, thanks!

- Mani

> Thanks,
> Can Guo.
> 
> > 
> > - Mani
> > 
> > > Thanks,
> > > Can Guo.
> > > 
> > > > 
> > > > > This patch is not changing any functionalities or logic but only a
> > > > > preparation patch for the next patch in this series.
> > > > > 
> > > > > Signed-off-by: Can Guo <quic_cang@quicinc.com>
> > > > > ---
> > > > >    drivers/ufs/host/ufs-qcom.c | 21 +++++++++++++++------
> > > > >    1 file changed, 15 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > > > > index 6756f8d..7bbccf4 100644
> > > > > --- a/drivers/ufs/host/ufs-qcom.c
> > > > > +++ b/drivers/ufs/host/ufs-qcom.c
> > > > > @@ -1067,6 +1067,20 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
> > > > >    		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
> > > > >    }
> > > > > +static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
> > > > > +{
> > > > > +	struct ufs_host_params *host_params = &host->host_params;
> > > > > +
> > > > > +	host->phy_gear = host_params->hs_tx_gear;
> > > > > +
> > > > > +	/*
> > > > > +	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> > > > > +	 * Switching to max gear will be performed during reinit if supported.
> > > > 
> > > > You need to reword this comment too.
> > > > 
> > > > > +	 */
> > > > > +	if (host->hw_ver.major < 0x5)
> > > > 
> > > > As I mentioned above, MAX_GEAR will be used if hw_ver.major is >=4 in
> > > > ufs_qcom_get_hs_gear(). So this check should be (< 0x4).
> > > > 
> > > > - Mani
> > > > 
> > > > > +		host->phy_gear = UFS_HS_G2;
> > > > > +}
> > > > > +
> > > > >    static void ufs_qcom_set_host_params(struct ufs_hba *hba)
> > > > >    {
> > > > >    	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> > > > > @@ -1303,6 +1317,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> > > > >    	ufs_qcom_set_caps(hba);
> > > > >    	ufs_qcom_advertise_quirks(hba);
> > > > >    	ufs_qcom_set_host_params(hba);
> > > > > +	ufs_qcom_set_phy_gear(host);
> > > > >    	err = ufs_qcom_ice_init(host);
> > > > >    	if (err)
> > > > > @@ -1320,12 +1335,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> > > > >    		dev_warn(dev, "%s: failed to configure the testbus %d\n",
> > > > >    				__func__, err);
> > > > > -	/*
> > > > > -	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
> > > > > -	 * Switching to max gear will be performed during reinit if supported.
> > > > > -	 */
> > > > > -	host->phy_gear = UFS_HS_G2;
> > > > > -
> > > > >    	return 0;
> > > > >    out_variant_clear:
> > > > > -- 
> > > > > 2.7.4
> > > > > 
> > > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
