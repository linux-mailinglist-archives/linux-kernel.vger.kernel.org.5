Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D533782699
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjHUJz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjHUJz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:55:57 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DDEA9;
        Mon, 21 Aug 2023 02:55:54 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id BD26E5202ED;
        Mon, 21 Aug 2023 11:55:52 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.32; Mon, 21 Aug
 2023 11:55:52 +0200
Date:   Mon, 21 Aug 2023 11:55:47 +0200
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <yangyingliang@huawei.com>,
        <jinpu.wang@ionos.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <erosca@de.adit-jv.com>
Subject: Re: [PATCH] usb: hcd: xhci: Add set command timer delay API
Message-ID: <20230821095547.GA9820@vmlxhi-118.adit-jv.com>
References: <20230818092353.124658-1-hgajjar@de.adit-jv.com>
 <2c029018-a926-6fda-ed71-937ac74d00b0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2c029018-a926-6fda-ed71-937ac74d00b0@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 04:18:30PM +0300, Mathias Nyman wrote:
> On 18.8.2023 12.23, Hardik Gajjar wrote:
> > xHCI driver starts the response timer after sending each
> > command to the device. The default value of this timer is
> > 5 seconds (XHCI_CMD_DEFAULT_TIMEOUT = HZ*5). This seems
> > too high in time crtical use case.
> > 
> > This patch provides an API to change the default value of
> > the timer from the vendor USB driver.
> > 
> > The default value will be XHCI_CMD_DEFAULT_TIMEOUT (5 sec)
> > 
> > Use case:
> > According to the Smartphone integration certification
> > requirement in the automotive, the phone connected via USB
> > should complete enumeration and user space handshake
> > within 3 sec.
> 
> The above incorrectly makes it sound as if the command timeout
> timer causes the delay.
>
Thank you, Mathias, for your prompt response. I will enhance the message
to provide more specificity in the subsequent patch.
> > 
> > Reducing the response waiting time by setting the smaller
> > command timer delay helps to speed up overall re-enumeration
> > process of the USB device in case of device is not responding
> > properly in first enumeration iteration.
> 
> So is this a case where addressing a usb device behind xHC always
> fail on the first attempt, i.e. address device command in xhci
> never completes. Solution proposed here is to fail faster and
> retry?
> 
> Is the rootcause known why first enumeration fails?
> 
> Does setting old_scheme_first module parameter help?
> 
Yes, you are correct. The problem occurs when setting the address,
and in such cases, this patch helps to fail faster and retry.

Unfortunately, the root cause is unknown. This problem is mainly
observed with Android phones. Upon analyzing the USB analyzer logs,
it seems that the device is not responding to the SET_ADDRESS request.

I tried using "old_scheme_first=Y," but that did not help. Below are
the short logs of the first iteration enumeration failure.
> > 
> > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> > ---
> >   drivers/usb/core/hcd.c       | 23 +++++++++++++++++++++++
> >   drivers/usb/host/xhci-ring.c | 10 +++++-----
> >   drivers/usb/host/xhci.c      | 15 +++++++++++++++
> >   drivers/usb/host/xhci.h      |  1 +
> >   include/linux/usb/hcd.h      |  2 ++
> >   5 files changed, 46 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index 8300baedafd2..e392e90e918c 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -3157,6 +3157,29 @@ int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
> >   }
> >   EXPORT_SYMBOL_GPL(usb_hcd_setup_local_mem);
> > +/**
> > + * usb_hcd_set_cmd_timer_delay Set the delay of the command timer.
> > + * @hcd - pointer to the HCD representing the controller
> > + * @delay - Delay value to be used in command timer.
> > + *
> > + * wrapper function to call the set_cmd_timer_delay API of the host
> > + * diver.
> > + *
> > + * return 0 on success; otherwise -ENODEV means the feature not
> > + * supported by host driver.
> > + */
> > +
> > +int usb_hcd_set_cmd_timer_delay(struct usb_hcd *hcd, int delay)
> > +{
> > +	int ret = -ENODEV;
> > +
> > +	if (hcd->driver->set_cmd_timer_delay)
> > +		ret = hcd->driver->set_cmd_timer_delay(hcd, delay);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(usb_hcd_set_cmd_timer_delay);
> > +
> 
> The xhci command timeout is more of a xhci internal thing, not sure it's a good
> idea to add this to hcd.
> 
> Would it make sense to add a timeout parameter to hcd->driver->address_device(hcd, udev)
> instead?
> 
> First priority should of course be finding out why the first enumeration fails,
> and solve that.
> 
> Thanks
> Mathias
Thanks for the suggestion to modify hcd->driver->address_device.
I will definitely implement it.However to confirm.

So, if I understand correctly, the idea is to avoid exposing any
API from the xhci driver, but instead, create an interface in hcd.c (such as sysfs or API)
and incorporate the delay in address_device as an additional parameter.

However, in that case, modifying xhci is still necessary as the timer is controlled from there.

Thanks,
Hardik
