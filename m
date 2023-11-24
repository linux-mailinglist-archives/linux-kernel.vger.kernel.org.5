Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19CF7F76DC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjKXOuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjKXOuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:50:07 -0500
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6ECD60;
        Fri, 24 Nov 2023 06:50:12 -0800 (PST)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 17D2C5201D5;
        Fri, 24 Nov 2023 15:50:11 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Fri, 24 Nov
 2023 15:50:10 +0100
Date:   Fri, 24 Nov 2023 15:50:05 +0100
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <gregkh@linuxfoundation.org>, <corbet@lwn.net>, <tj@kernel.org>,
        <rdunlap@infradead.org>, <paulmck@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <erosca@de.adit-jv.com>,
        <Martin.Mueller5@de.bosch.com>
Subject: Re: [PATCH] usb: hubs: Decrease IN-endpoint poll interval for
 Microchip USB491x hub
Message-ID: <20231124145005.GA72525@vmlxhi-118.adit-jv.com>
References: <20231123081948.58776-1-hgajjar@de.adit-jv.com>
 <988f4311-a726-4a7e-b0bf-6aeec13d8f23@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <988f4311-a726-4a7e-b0bf-6aeec13d8f23@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 01:17:03PM -0500, Alan Stern wrote:
> On Thu, Nov 23, 2023 at 09:19:48AM +0100, Hardik Gajjar wrote:
> > There is a potential delay in announcing downstream USB bus activity to
> > Linux USB drivers due to the default interrupt endpoint having a poll
> > interval of 256ms.
> > 
> > Microchip has recommended ignoring the device descriptor and reducing
> > that value to 32ms, as it was too late to modify it in silicon.
> > 
> > This patch aims to speed up the USB enumeration process, facilitating
> > the successful completion of Apple CarPlay certifications and enhancing
> > user experience when utilizing USB devices through the Microchip Multihost
> > Hub.
> > 
> > A new quirk, USB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL, accelerates the
> > notification process by changing the Endpoint interrupt poll interval
> > from 256ms to 32ms.
> 
> But this is meant to apply only to hubs, right?  So shouldn't it be a 
> HUB_QUIRK_32_MS_INTR_INTERVAL macro, used in hub.c's hub_id_table, 
> rather than a general USB quirk?

Thank you, Alan, for the feedback. To confirm my understanding, are you suggesting
moving all implementations to hub.c, adding the hub-specific quirk, and using the
same quirk to update the bInterval value parsed by usb_get_configuration() in
usb_enumerate_device()?"

> 
> > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
> >  drivers/usb/core/config.c                       |  8 ++++++++
> >  drivers/usb/core/quirks.c                       | 11 +++++++++++
> >  include/linux/usb/quirks.h                      |  5 +++++
> >  4 files changed, 28 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 65731b060e3f..6b0a66f0e6bf 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6908,6 +6908,10 @@
> >  					pause after every control message);
> >  				o = USB_QUIRK_HUB_SLOW_RESET (Hub needs extra
> >  					delay after resetting its port);
> > +				p = USB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL (Set
> > +					bInterval to a Maximum of 9 to Reduce
> > +					default Poll Rate from 256 ms to
> > +					32 ms);
> 
> 256 ms and 32 ms are _periods_ (or intervals), not _rates_.
> 
> bInterval=9 corresponds to 32 ms only for High Speed and SuperSpeed* 
> devices.  For Low and Full Speed it corresponds to 9 ms.  Explanatory 
> comments should strive not to be misleading.
> 
> Alan Stern
