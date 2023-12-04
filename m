Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724308038BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjLDP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjLDPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:25:48 -0500
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF292CA;
        Mon,  4 Dec 2023 07:25:53 -0800 (PST)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 053995202C0;
        Mon,  4 Dec 2023 16:25:52 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 4 Dec
 2023 16:25:51 +0100
Date:   Mon, 4 Dec 2023 16:25:43 +0100
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>, <corbet@lwn.net>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <tj@kernel.org>, <paulmck@kernel.org>,
        <Martin.Mueller5@de.bosch.com>
Subject: Re: [PATCH v3] usb: hub: Add quirk to decrease IN-ep poll interval
 for Microchip USB491x hub
Message-ID: <20231204152543.GA115715@vmlxhi-118.adit-jv.com>
References: <20231201144705.97385-1-hgajjar@de.adit-jv.com>
 <39f334d2-abe6-4b4d-a48c-b22a907c6ea6@rowland.harvard.edu>
 <2023120437-opposite-juiciness-e0dd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023120437-opposite-juiciness-e0dd@gregkh>
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

On Mon, Dec 04, 2023 at 08:02:50AM +0100, Greg KH wrote:
> On Fri, Dec 01, 2023 at 11:13:53AM -0500, Alan Stern wrote:
> > On Fri, Dec 01, 2023 at 03:47:05PM +0100, Hardik Gajjar wrote:
> > > There is a potential delay in notifying Linux USB drivers of downstream
> > > USB bus activity when connecting a high-speed or superSpeed device via the
> > > Microchip USB491x hub. This delay is due to the fixed bInterval value of
> > > 12 in the silicon of the Microchip USB491x hub.
> > > 
> > > Microchip requested to ignore the device descriptor and decrease that
> > > value to 9 as it was too late to modify that in silicon.
> > > 
> > > This patch speeds up the USB enummeration process that helps to pass
> > > Apple Carplay certifications and improve the User experience when utilizing
> > > the USB device via Microchip Multihost USB491x Hub.
> > > 
> > > A new hub quirk HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL speeds up
> > > the notification process for Microchip USB491x hub by limiting
> > > the maximum bInterval value to 9.
> > > 
> > > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> > > ---
> > > changes since version 1:
> > > 	- Move implementation from config.c and quirk.c to hub.c as this is hub
> > > 	  specific changes.
> > > 	- Improve commit message.
> > > 	- Link to v1 - https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_20231123081948.58776-2D1-2Dhgajjar-40de.adit-2Djv.com_&d=DwICAg&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=MwlH5BZuYXKwMbYoZm0ibbRgqL9CLBFJs3W-um9OX810KDZtChbSXjDyPjCZhJDf&s=xgoOKLqU4fKUbsJMZHzIQzrWKH2W9ikdmKvGntoPcaA&e=
> > > 
> > > changes since version 2:
> > >     - Call usb_set_interface after updating the bInterval to Tell the HCD about modification
> > > 	- Link to v2 - https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_20231130084855.119937-2D1-2Dhgajjar-40de.adit-2Djv.com_&d=DwICAg&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=MwlH5BZuYXKwMbYoZm0ibbRgqL9CLBFJs3W-um9OX810KDZtChbSXjDyPjCZhJDf&s=Ck2GM1MhxBKLkLrlkZd_QwoIXz07CbJGVqpVss0rSEI&e=
> > > ---
> > >  drivers/usb/core/hub.c | 27 +++++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > > 
> > > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > > index b4584a0cd484..b5ac29c5f016 100644
> > > --- a/drivers/usb/core/hub.c
> > > +++ b/drivers/usb/core/hub.c
> > > @@ -47,12 +47,18 @@
> > >  #define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
> > >  #define USB_PRODUCT_TUSB8041_USB3		0x8140
> > >  #define USB_PRODUCT_TUSB8041_USB2		0x8142
> > > +#define USB_VENDOR_MICROCHIP			0x0424
> > > +#define USB_PRODUCT_USB4913			0x4913
> > > +#define USB_PRODUCT_USB4914			0x4914
> > > +#define USB_PRODUCT_USB4915			0x4915
> > >  #define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
> > >  #define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
> > > +#define HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL	0x08
> > 
> > Why use 0x08 instead of 0x04?
> 
> And why not use BIT() as that's what these are.
> 
> thanks,
> 
> greg k-h

I am considering aligning with existing quirks.
Is it advisable to use something like HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL BIT(2)? 
I'm thinking to submit two patches – one to replace hard values with BIT() in existing quirks and a second patch containing my changes.

Thanks,
Hardik 

