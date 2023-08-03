Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0527276EAED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbjHCNoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbjHCNnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:43:03 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26356184;
        Thu,  3 Aug 2023 06:39:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16934FF80C;
        Thu,  3 Aug 2023 13:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691069981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VuPcGKq6RqBhRLLNk1iVkEHeMOCxedfo5CNJI7uNPyE=;
        b=MOtHIb2Tt2m9x01YSpUQc1FVyEbHLkIBNwEo7TXbNkvfuAilUsz+LyBTr5QqL1H6VKU3zP
        Fivc+NdfFDRVUXY5fDDyvKp21wWQv6XRkYlDDnexjHnRymnSch7myKOnnipmuMCdbmRHNj
        rION1mub6JmaLpWplXFVQRNb3+nFCseAQvAIr37yOggrCojUGzNIEQ8vaPPelkkTBsuhxK
        tnRfZ6fkMgGjXpMRbfE1lNkW0qwp+tMQ7io/hOq4CHksalH25Uqo0PbODLiecdty/OE0f0
        u6ZtzhenPqY/c76P+7rH4ufboQHO0lUN85FBXI7pGqfk/ch+EtMn4I81x2q7kQ==
Date:   Thu, 3 Aug 2023 15:39:40 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anvesh Jain P <quic_ajainp@quicinc.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>
Subject: Re: [PATCH] rtc: rtc-pm8xxx: control default alarm wake up capability
Message-ID: <20230803133940eef87e40@mail.local>
References: <20230801114549.26956-1-quic_ajainp@quicinc.com>
 <20230801124056fc665814@mail.local>
 <93722831-dc83-8ea3-4af9-33eaefcf81be@quicinc.com>
 <202308011934080c7083b9@mail.local>
 <43055e2f-963c-a738-964e-d483c751d913@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43055e2f-963c-a738-964e-d483c751d913@quicinc.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 19:01:51+0530, Anvesh Jain P wrote:
> 
> 
> On 8/2/2023 1:04 AM, Alexandre Belloni wrote:
> > On 01/08/2023 18:18:46+0530, Anvesh Jain P wrote:
> > > In automotive systems, RTC should not wake up the device when it is parked
> > > or when it is garage to avoid leakage current. providing a control from
> > > device tree to avoid RTC wake up based on the use case is reason for this
> > > patch.
> > > 
> > 
> > Then simply avoid providing an IRQ or setting an alarm.
> The purpose of the change is just to block alarms/notifications waking up
> the target when it is in Suspend2ram(low power) mode.
> if we disable IRQ, alarms/notifications won't come even when the target is
> in active mode.
> This change will just stop the wake up capability of the alarm when target
> is in suspend 2 ram mode based on flag passed from device tree.
> Use case of this patch is,
> In mobile targets where alarms / notifications will need to wake up the
> target when there is a reminder as per user expectation.
> where as in automotive targets, when driver is not in Car and target is in
> suspend state, alarms/notifications would have no meaning and waking up the
> target of no use as there is no user to attend the message. hence blocking
> them in automotive use cases based on device tree is the use of this patch.

Simply remove the alarm before going to suspend, this is a userspace
policy, it has nothing to do in the device or kernel.

> > 
> > > On 8/1/2023 6:10 PM, Alexandre Belloni wrote:
> > > > On 01/08/2023 17:15:49+0530, Anvesh Jain P wrote:
> > > > > Enable & disable rtc alarm wake up capability based on
> > > > > default parameter passed from device tree.
> > > > > 
> > > > 
> > > > I see what you are doing but not why this is necessary, NAK.
> > > > 
> > > > > Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
> > > > > Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> > > > > ---
> > > > >    drivers/rtc/rtc-pm8xxx.c | 3 +++
> > > > >    1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> > > > > index f6b779c12ca7..bed57be602b6 100644
> > > > > --- a/drivers/rtc/rtc-pm8xxx.c
> > > > > +++ b/drivers/rtc/rtc-pm8xxx.c
> > > > > @@ -523,6 +523,9 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
> > > > >    	if (rc)
> > > > >    		return rc;
> > > > > +	if (of_property_read_bool(pdev->dev.of_node, "disable-alarm-wakeup"))
> > > > > +		device_set_wakeup_capable(&pdev->dev, false);
> > > > > +
> > > > >    	rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
> > > > >    	if (rc)
> > > > >    		return rc;
> > > > > 
> > > > > base-commit: 0a8db05b571ad5b8d5c8774a004c0424260a90bd
> > > > > -- 
> > > > > 2.17.1
> > > > > 
> > > > 
> > 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
