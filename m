Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F557FB934
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344533AbjK1LPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344547AbjK1LPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:15:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD0010CA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:15:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568CBC433C7;
        Tue, 28 Nov 2023 11:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701170142;
        bh=3+j71CuhjAOePD46bT+Oifrh9ykcPU2RFbLXXeRFQys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZNdqWOh6qU+ZW25NoVDR0ho+3PC8J3JfEp9d+h766C2jbGpO5HIcLr6YeQ0g875U
         xPFXxdB13sTGHFWZOZDKxFUqZtN8xVGKLLnMalBzIdomBJ0X9klYxzCt223iI74Y0f
         d+07Tg31Jg5TODNX0V54OQNBF+CGfBC0ppetifmnZWxu9Hfde84vdYYsYPnRSp2PiY
         R+2+uI0enCq8TAZ4Xyaf5/NOGjVJ5obgM04WQfKcx+HBXIzlZP7YteB1/F4bP5Ad8k
         qQBKajWstbNG99FyIHBOWU+LuIKGROsMBCMQj0hOnG90h+c2em5TOlbfgpV8S7l7li
         SMSKHgYBeX7bw==
Date:   Tue, 28 Nov 2023 16:45:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     Ziqi Chen <quic_ziqichen@quicinc.com>, quic_asutoshd@quicinc.com,
        bvanassche@acm.org, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com, linux-scsi@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: qcom: move ufs_qcom_host_reset() to
 ufs_qcom_device_reset()
Message-ID: <20231128111528.GR3088@thinkpad>
References: <1698145815-17396-1-git-send-email-quic_ziqichen@quicinc.com>
 <20231025074128.GA3648@thinkpad>
 <85d7a1ef-92c4-49ae-afe0-727c1b446f55@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85d7a1ef-92c4-49ae-afe0-727c1b446f55@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 02:14:57PM +0800, Can Guo wrote:
> 
> 
> On 10/25/2023 3:41 PM, Manivannan Sadhasivam wrote:
> > On Tue, Oct 24, 2023 at 07:10:15PM +0800, Ziqi Chen wrote:
> > > During PISI test, we found the issue that host Tx still bursting after
> > 
> > What is PISI test?
> > 
> > > H/W reset. Move ufs_qcom_host_reset() to ufs_qcom_device_reset() and
> > > reset host before device reset to stop tx burst.
> > > 
> > 
> > device_reset() callback is supposed to reset only the device and not the host.
> > So NACK for this patch.
> 
> Agree, the change should come in a more reasonable way.
> 
> Actually, similar code is already there in ufs_mtk_device_reset() in
> ufs-mediatek.c, I guess here is trying to mimic that fashion.
> 
> This change, from its functionality point of view, we do need it, because I
> occasionally (2 out of 10) hit PHY error on lane 0 during reboot test (in my
> case, I tried SM8350, SM8450 and SM8550， all same).
> 

I do not suspect the intention of this patch, but I do not like the way how it
is being done. Even if the reset has to be moved, the patch description should
describe how it fixes the issue.

- Mani

> [    1.911188] [DEBUG]ufshcd_update_uic_error: UECPA:0x80000002
> [    1.922843] [DEBUG]ufshcd_update_uic_error: UECDL:0x80004000
> [    1.934473] [DEBUG]ufshcd_update_uic_error: UECN:0x0
> [    1.944688] [DEBUG]ufshcd_update_uic_error: UECT:0x0
> [    1.954901] [DEBUG]ufshcd_update_uic_error: UECDME:0x0
> 
> I found out that the PHY error pops out right after UFS device gets reset in
> the 2nd init. After having this change in place, the PA/DL errors are gone.
> 
> Thanks,
> Can Guo.
> > 
> > - Mani
> > 
> > > Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
> > > ---
> > >   drivers/ufs/host/ufs-qcom.c | 13 +++++++------
> > >   1 file changed, 7 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > > index 96cb8b5..43163d3 100644
> > > --- a/drivers/ufs/host/ufs-qcom.c
> > > +++ b/drivers/ufs/host/ufs-qcom.c
> > > @@ -445,12 +445,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> > >   	struct phy *phy = host->generic_phy;
> > >   	int ret;
> > > -	/* Reset UFS Host Controller and PHY */
> > > -	ret = ufs_qcom_host_reset(hba);
> > > -	if (ret)
> > > -		dev_warn(hba->dev, "%s: host reset returned %d\n",
> > > -				  __func__, ret);
> > > -
> > >   	/* phy initialization - calibrate the phy */
> > >   	ret = phy_init(phy);
> > >   	if (ret) {
> > > @@ -1709,6 +1703,13 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
> > >   static int ufs_qcom_device_reset(struct ufs_hba *hba)
> > >   {
> > >   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> > > +	int ret = 0;
> > > +
> > > +	/* Reset UFS Host Controller and PHY */
> > > +	ret = ufs_qcom_host_reset(hba);
> > > +	if (ret)
> > > +		dev_warn(hba->dev, "%s: host reset returned %d\n",
> > > +				  __func__, ret);
> > >   	/* reset gpio is optional */
> > >   	if (!host->device_reset)
> > > -- 
> > > 2.7.4
> > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
