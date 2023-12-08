Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96A380A4E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573866AbjLHN5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573857AbjLHN5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:57:41 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D05C173B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:57:47 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 53D19240106
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:57:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1702043864; bh=MqMA5eXxYSHMs5eMUtbebE4rmWa8231Kz2vpnDkYL1M=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=ZZuYyHHLhfuqU7oGpQ1wR/NUVz/LV0NQ0JvJ3OCUKRvRHYt3qZJeKZJGapO+k6bxT
         4BMEfqHWEZQZS/1SrMk2zIbqnnSbsq/hIbxDhr4nK/fqS88jsV7LmIIlAXFvOL6zge
         epAqHYvuvfAZkyZaSumezdLNFYXbNgU0k+nY/7+4RwT+lenrz99lXxVz9gTOBkwiN1
         SHDf/omKx/qDRwIvhqoKm5OtWMoh8PZKg/glSAoqD3FRMIqeLxhBcr5qNs298WZ704
         t9qZ3WCcptCTDT3Gdk15Pm+Q6TdfVD0Q5r3V5/03FKlqKyYFWe4uocjgCODxzEDfQk
         iZOOaTlI0JmzQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Smt4l2Gnvz6txp;
        Fri,  8 Dec 2023 14:57:43 +0100 (CET)
Date:   Fri,  8 Dec 2023 13:57:42 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (corsair-psu) Fix failure to load when built-in
 to kernel
Message-ID: <20231208145742.6def047a@posteo.net>
In-Reply-To: <d91d4bf1-3e8d-4b63-baa9-479a91d04eb7@gmail.com>
References: <20231208130710.191420-1-savicaleksa83@gmail.com>
        <d91d4bf1-3e8d-4b63-baa9-479a91d04eb7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 14:11:44 +0100
Aleksa Savic <savicaleksa83@gmail.com> wrote:

> On 2023-12-08 14:07:10 GMT+01:00, Aleksa Savic wrote:
> > When built-in to the kernel, the corsair-psu driver fails to register with
> > the following message:
> > 
> > "Driver 'corsair-psu' was unable to register with bus_type 'hid'
> > because the bus was not initialized."
> > 
> > Fix this by initializing the driver after the HID bus using
> > late_initcall(), as hwmon is built before HID.
> > 
> > Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
> > Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> > ---
> >  drivers/hwmon/corsair-psu.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> > index 904890598c11..48831a528965 100644
> > --- a/drivers/hwmon/corsair-psu.c
> > +++ b/drivers/hwmon/corsair-psu.c
> > @@ -899,7 +899,20 @@ static struct hid_driver corsairpsu_driver = {
> >  	.reset_resume	= corsairpsu_resume,
> >  #endif
> >  };
> > -module_hid_driver(corsairpsu_driver);
> > +
> > +static int __init corsairpsu_hid_init(void)
> > +{
> > +	return hid_register_driver(&corsairpsu_driver);
> > +}
> > +
> > +static void __exit corsairpsu_hid_exit(void)
> > +{
> > +	hid_unregister_driver(&corsairpsu_driver);
> > +}
> > +
> > +/* When compiled into the kernel, initialize after the hid bus */
> > +late_initcall(corsairpsu_hid_init);
> > +module_exit(corsairpsu_hid_exit);
> >  
> >  MODULE_LICENSE("GPL");
> >  MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
> 
> 
> Woops! Just saw that the same fix was sent yesterday. Please disregard, sorry!
>
> Aleksa

It is fine. I just start to wonder if there was a change in the subsystem. I
used the driver as built-in in the past for several months and never had that
issue. And now it is a real flood of reports.

greetings,
Will
