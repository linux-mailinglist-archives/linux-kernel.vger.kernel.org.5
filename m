Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7076280AAD5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574262AbjLHRb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLHRb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:31:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA8F85
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:31:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C51CC433C8;
        Fri,  8 Dec 2023 17:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702056693;
        bh=jidHsWIy2RHPmyo07QZHtscgTyRrcFhr6KRNd4KD7GM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hW2bMg+Zx2738kwJe6NZncA2ed73Ll2e9F8xe//9HeMtmq67+V4HP2A8WVE4L6XWF
         QwrcSkj3EbGS+mLhuzZ3LlQjCQOeQ7VZDZbVXCuTv/gkz2vCY0S3MvOyx3kdk4i9bj
         bbP8qTl93yyHpElsq900A7jaUyxdL3cbMjqqdhc8toITR0Gu2yITqo/dxQb+H+jS8c
         Izy08HF9QYgweXwt4BtjLJU0M6dPvuxTrjw/Zd0Gm34mLnJ8uC472rIEWvrg/zRy6X
         KnYuvwlwFBm0LH6/xQepk77R/CiRaCNM+JQceJRYRBK7Y+TNEw2L53wKZEpVA/J7Z7
         ePmptf5yQrdxA==
Date:   Fri, 8 Dec 2023 23:01:18 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikebi@micron.com, lporzio@micron.com
Subject: Re: [PATCH v4 2/3] scsi: ufs: core: Add UFS RTC support
Message-ID: <20231208173118.GE15552@thinkpad>
References: <20231208103940.153734-1-beanhuo@iokpp.de>
 <20231208103940.153734-3-beanhuo@iokpp.de>
 <20231208145021.GC15552@thinkpad>
 <89c02f8b999a90329f2125380ad2d984767d25ae.camel@iokpp.de>
 <20231208170609.GD15552@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208170609.GD15552@thinkpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:36:24PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 08, 2023 at 04:12:44PM +0100, Bean Huo wrote:
> > On Fri, 2023-12-08 at 20:20 +0530, Manivannan Sadhasivam wrote:
> > > > +        */
> > > > +       val = ts64.tv_sec - hba->dev_info.rtc_time_baseline;
> > > > +
> > > 
> > > This logic will work if the host has RTC. But if there is no RTC,
> > > then tv_sec
> > > will return time elapsed since boot. The spec clearly states that
> > > host should
> > > use absolute mode if it has RTC and relative otherwise.
> > > 
> > > Maybe you should add a logic to detect whether RTC is present or not
> > > and
> > > override the mode in device?
> > 
> > Thank you for your reviews. I will incorporate the suggested changes
> > into the patch, addressing all comments except for the RTC mode switch.
> > The proposal is to perform the RTC mode switch during UFS provisioning,
> > not at runtime in the UFS online phase. This approach ensures that the
> > UFS configuration is populated based on the RTC configuration
> > established during provisioning. It is advisable not to change the RTC
> > mode after provisioning is complete. Additionally, the usage of tv_sec,
> > which returns time elapsed since boot, suggests that there is no issue
> > with utilizing the RTC in this context.
> 
> Except that the warning will be issued to users after each 10s for 40 years.
> Atleast get rid of that.
> 

I tried this series on Qcom RB5 board and found the issue due to the usage of
UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH flag. When this flag is set,
ufshcd_device_init() will be called twice due to reinit of the controller and
PHY.

Since RTC work is initialized and scheduled from ufshcd_device_init(), panic
happens during second time. Is it possible to move RTC init outside of
ufshcd_device_init(). Maybe you can parse RTC params in ufshcd_device_init()
and initialize the work elsewhere. Or you can cancel the work before calling
ufshcd_device_init() second time.

- Mani

> - Mani
> 
> > 
> > Kind regards,
> > Bean
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
