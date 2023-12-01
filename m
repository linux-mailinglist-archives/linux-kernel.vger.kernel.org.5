Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DE98002F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377483AbjLAFSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377435AbjLAFSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:18:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC35BD40
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:18:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185C0C433C9;
        Fri,  1 Dec 2023 05:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701407897;
        bh=dCH6U9DOKu1MDBp3F2VxdSLSjeuwOTuCV17QciUNQRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cASA5TYKYLtyKWEJ+B6W6xHPbbn4MqWOo92HlcZDaTIUdHRtQOwhk3B/sWKSqdV4U
         fovI7Idrlv9uvN3ewXvXh/XP3F2dCE0HywhNBZCoWDnYSA+qoeRA59KWKMwzdzmQex
         4ZCKzFEFUWzEPV0zcea2SD19oJLMqIO6cFGyk9RU6zlR0XWAebLUnf75bjVhFkPktg
         Qxov3HdiAz1k5W99OcyxyggkQX3C5AEKmDq0yRUh4wuwUZEJpilbo+A6rnXYSYCyjG
         VK0jf7bVJcsqaaZ1Krx2q18Wae9zIUSf0cpxhsoM+1BHCIjutvU09qxnWDB0EURHGg
         Iizq4ICOe48hg==
Date:   Fri, 1 Dec 2023 10:48:00 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Ziqi Chen <quic_ziqichen@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <quic_cang@quicinc.com>, quic_asutoshd@quicinc.com,
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
Message-ID: <20231201051800.GA4009@thinkpad>
References: <1698145815-17396-1-git-send-email-quic_ziqichen@quicinc.com>
 <20231025074128.GA3648@thinkpad>
 <85d7a1ef-92c4-49ae-afe0-727c1b446f55@quicinc.com>
 <c6a72c38-aa63-79b8-c784-d753749f7272@quicinc.com>
 <20231128112731.GV3088@thinkpad>
 <ed81bb9e-a9cd-4d32-bfa0-2f0d28742026@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed81bb9e-a9cd-4d32-bfa0-2f0d28742026@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 08:10:57PM +0800, Ziqi Chen wrote:
> 
> 
> On 11/28/2023 7:27 PM, Manivannan Sadhasivam wrote:
> > On Tue, Nov 28, 2023 at 03:40:57AM +0800, Ziqi Chen wrote:
> > > 
> > > 
> > > On 11/22/2023 2:14 PM, Can Guo wrote:
> > > > 
> > > > 
> > > > On 10/25/2023 3:41 PM, Manivannan Sadhasivam wrote:
> > > > > On Tue, Oct 24, 2023 at 07:10:15PM +0800, Ziqi Chen wrote:
> > > > > > During PISI test, we found the issue that host Tx still bursting after
> > > > > 
> > > > > What is PISI test?
> > > 
> > > SI measurement.
> > > 
> > 
> > Please expand it in the patch description.
> 
> Sure, I will update in next patch version.
> 
> > 
> > > > > 
> > > > > > H/W reset. Move ufs_qcom_host_reset() to ufs_qcom_device_reset() and
> > > > > > reset host before device reset to stop tx burst.
> > > > > > 
> > > > > 
> > > > > device_reset() callback is supposed to reset only the device and not
> > > > > the host.
> > > > > So NACK for this patch.
> > > > 
> > > > Agree, the change should come in a more reasonable way.
> > > > 
> > > > Actually, similar code is already there in ufs_mtk_device_reset() in
> > > > ufs-mediatek.c, I guess here is trying to mimic that fashion.
> > > > 
> > > > This change, from its functionality point of view, we do need it,
> > > > because I occasionally (2 out of 10) hit PHY error on lane 0 during
> > > > reboot test (in my case, I tried SM8350, SM8450 and SM8550， all same).
> > > > 
> > > > [    1.911188] [DEBUG]ufshcd_update_uic_error: UECPA:0x80000002
> > > > [    1.922843] [DEBUG]ufshcd_update_uic_error: UECDL:0x80004000
> > > > [    1.934473] [DEBUG]ufshcd_update_uic_error: UECN:0x0
> > > > [    1.944688] [DEBUG]ufshcd_update_uic_error: UECT:0x0
> > > > [    1.954901] [DEBUG]ufshcd_update_uic_error: UECDME:0x0
> > > > 
> > > > I found out that the PHY error pops out right after UFS device gets
> > > > reset in the 2nd init. After having this change in place, the PA/DL
> > > > errors are gone.
> > > 
> > > Hi Mani,
> > > 
> > > There is another way that adding a new vops that call XXX_host_reset() from
> > > soc vendor driver. in this way, we can call this vops in core layer without
> > > the dependency of device reset.
> > > due to we already observed such error and received many same reports from
> > > different OEMs, we need to fix it in some way.
> > > if you think above way is available, I will update new patch in soon. Or
> > > could you give us other suggestion?
> > > 
> > 
> > First, please describe the issue in detail. How the issue is getting triggered
> > and then justify your change. I do not have access to the bug reports that you
> > received.
> 
> From the waveform measured by Samsung , we can see at the end of 2nd Link
> Startup, host still keep bursting after H/W reset. This abnormal timing
> would cause the PA/DL error mentioned by Can.
> 
> On the other hand, at the end of 1st Link start up, Host ends bursting at
> first and then sends H/W reset to device. So Samsung suggested to do host
> reset before every time device reset to fix this issue. That's what you saw
> in this patch.  This patch has been verified by OEMs.
> 

Thanks for the detail. This info should have been part of the patch description.

> So do you think if we can keep this change with details update in commit
> message. or need to do other improvement?
> 

For sure we should not do host reset within device_reset callback. I'd like to
know at what point of time we are seeing the host burst after device reset. I
mean can you point me to the code in the ufshcd driver that when calling
device_reset you are seeing the issue? Then we can do a host_reset before that
_specific_ device_reset with the help of the new vops you suggested.

- Mani

> 
> -Ziqi
> 
> > 
> > - Mani
> > 
> > > -Ziqi
> > > 
> > > > 
> > > > Thanks,
> > > > Can Guo.
> > > > > 
> > > > > - Mani
> > > > > 
> > > > > > Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
> > > > > > ---
> > > > > >    drivers/ufs/host/ufs-qcom.c | 13 +++++++------
> > > > > >    1 file changed, 7 insertions(+), 6 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > > > > > index 96cb8b5..43163d3 100644
> > > > > > --- a/drivers/ufs/host/ufs-qcom.c
> > > > > > +++ b/drivers/ufs/host/ufs-qcom.c
> > > > > > @@ -445,12 +445,6 @@ static int
> > > > > > ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> > > > > >        struct phy *phy = host->generic_phy;
> > > > > >        int ret;
> > > > > > -    /* Reset UFS Host Controller and PHY */
> > > > > > -    ret = ufs_qcom_host_reset(hba);
> > > > > > -    if (ret)
> > > > > > -        dev_warn(hba->dev, "%s: host reset returned %d\n",
> > > > > > -                  __func__, ret);
> > > > > > -
> > > > > >        /* phy initialization - calibrate the phy */
> > > > > >        ret = phy_init(phy);
> > > > > >        if (ret) {
> > > > > > @@ -1709,6 +1703,13 @@ static void ufs_qcom_dump_dbg_regs(struct
> > > > > > ufs_hba *hba)
> > > > > >    static int ufs_qcom_device_reset(struct ufs_hba *hba)
> > > > > >    {
> > > > > >        struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> > > > > > +    int ret = 0;
> > > > > > +
> > > > > > +    /* Reset UFS Host Controller and PHY */
> > > > > > +    ret = ufs_qcom_host_reset(hba);
> > > > > > +    if (ret)
> > > > > > +        dev_warn(hba->dev, "%s: host reset returned %d\n",
> > > > > > +                  __func__, ret);
> > > > > >        /* reset gpio is optional */
> > > > > >        if (!host->device_reset)
> > > > > > -- 
> > > > > > 2.7.4
> > > > > > 
> > > > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
