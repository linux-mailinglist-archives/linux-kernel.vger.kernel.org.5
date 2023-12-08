Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7696080AA05
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574105AbjLHRGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjLHRGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:06:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776041989
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:06:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86110C433C8;
        Fri,  8 Dec 2023 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702055184;
        bh=mxdO+AgZgxQrWokleW50XZOg/gCxBMjkuHhRTUdEc5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sEmmsggfNl/uihEtJRxzo6AOd3cu/tKmCNiECPZP8J3nTetJtO4rgrUJ/gabq4bgh
         6EiL1i+W6/pFlCfpM2ktnrMaC4iBA6rBKJfKk7R9g3lsAorl1x2yzyrzZrWJXZfStM
         rXanj2EgFeEqyKBb/VzQ7n5Md6Yby6VVBs/PajvHPRdxHOFNFnejMS4mY7W25Rx2JZ
         6EWUshyUL5eV9KnyjyzGrtW21Gl+jOHoABb32yunQbM4SJ7H6Kw2Kpp+9CKpqfoJ6P
         16PDdg/GGRmnijiS0z8ez/sc4fUt4IHyQI6WRn2ZvS8qHYl7jNXvuHaXn+d3655XBg
         G5ftfY37XvCOw==
Date:   Fri, 8 Dec 2023 22:36:09 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikebi@micron.com, lporzio@micron.com
Subject: Re: [PATCH v4 2/3] scsi: ufs: core: Add UFS RTC support
Message-ID: <20231208170609.GD15552@thinkpad>
References: <20231208103940.153734-1-beanhuo@iokpp.de>
 <20231208103940.153734-3-beanhuo@iokpp.de>
 <20231208145021.GC15552@thinkpad>
 <89c02f8b999a90329f2125380ad2d984767d25ae.camel@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89c02f8b999a90329f2125380ad2d984767d25ae.camel@iokpp.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 04:12:44PM +0100, Bean Huo wrote:
> On Fri, 2023-12-08 at 20:20 +0530, Manivannan Sadhasivam wrote:
> > > +        */
> > > +       val = ts64.tv_sec - hba->dev_info.rtc_time_baseline;
> > > +
> > 
> > This logic will work if the host has RTC. But if there is no RTC,
> > then tv_sec
> > will return time elapsed since boot. The spec clearly states that
> > host should
> > use absolute mode if it has RTC and relative otherwise.
> > 
> > Maybe you should add a logic to detect whether RTC is present or not
> > and
> > override the mode in device?
> 
> Thank you for your reviews. I will incorporate the suggested changes
> into the patch, addressing all comments except for the RTC mode switch.
> The proposal is to perform the RTC mode switch during UFS provisioning,
> not at runtime in the UFS online phase. This approach ensures that the
> UFS configuration is populated based on the RTC configuration
> established during provisioning. It is advisable not to change the RTC
> mode after provisioning is complete. Additionally, the usage of tv_sec,
> which returns time elapsed since boot, suggests that there is no issue
> with utilizing the RTC in this context.

Except that the warning will be issued to users after each 10s for 40 years.
Atleast get rid of that.

- Mani

> 
> Kind regards,
> Bean

-- 
மணிவண்ணன் சதாசிவம்
