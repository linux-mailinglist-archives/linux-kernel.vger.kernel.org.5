Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3337E9927
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjKMJib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjKMJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:38:30 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA3710D0;
        Mon, 13 Nov 2023 01:38:24 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 616DE1BF204;
        Mon, 13 Nov 2023 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699868301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqGFUmwjIwMKEFYJBPWri7nDivqn7HaPpW3APRDduOs=;
        b=Jn6KjOCzax0h1kRFxyrgdRD9NGIc45CtpQo4fcmAZ1H2Kcr0uIWnop2fzZbrmbf6cVoKDL
        sW9AfaDz8P3rweffxb2AE9+Acaa8OvDev9aML6JY3r9ijMQC+KOBm/bT3fp440A3HbIWeN
        GI0jlRe0D20a9Vw5xGdWK1SzS2CWRPGCjumsUdbyVfUUJq2LI1u+V+MpAMTnqiWr3GQ7vG
        ANKHpEEhz8UY8U1efcwcFDTi7kQOlmYULwdbuxGcRBBjUsJQu0GTQT+WOuvzhQsOyVfHrt
        K//EWTht1W2LoF0MfT3Dq4TeAfrQwUJllw4f4cTurkzTq5qsXR0qFzfNfkKB8g==
Date:   Mon, 13 Nov 2023 10:38:20 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] driver core: Keep the supplier fwnode consistent
 with the device
Message-ID: <20231113103820.7b04f5d0@bootlin.com>
In-Reply-To: <CAGETcx-06mFw+KNvYRf36etkQwuF4TJyNzt=KmwnCUzptKnMrw@mail.gmail.com>
References: <20231110075549.702374-1-herve.codina@bootlin.com>
        <CAGETcx-06mFw+KNvYRf36etkQwuF4TJyNzt=KmwnCUzptKnMrw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Fri, 10 Nov 2023 17:50:07 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Thu, Nov 9, 2023 at 11:56 PM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > The commit 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child
> > fwnode's consumer links") introduces the possibility to use the
> > supplier's parent device instead of the supplier itself.
> > In that case the supplier fwnode used is not updated and is no more
> > consistent with the supplier device used.
> >
> > Update the fwnode used to be consistent with the supplier device used.
> >
> > Fixes: 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's consumer links")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/base/core.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 4d8b315c48a1..17f2568e0a79 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2076,6 +2076,18 @@ static int fw_devlink_create_devlink(struct device *con,
> >                 sup_dev = get_dev_from_fwnode(sup_handle);
> >
> >         if (sup_dev) {
> > +               /*
> > +                * The supplier device may have changed and so, the supplier
> > +                * fwnode maybe inconsistent.
> > +                * Update the supplier fwnode
> > +                */
> > +               sup_handle = sup_dev->fwnode;
> > +               if (!sup_handle) {
> > +                       dev_dbg(con, "Not linking %s - fwnode NULL\n",
> > +                               dev_name(sup_dev));
> > +                       goto out;
> > +               }
> > +  
> 
> Nack. It's easier to debug when you know what supplier you were
> pointing to in DT that triggered the creation of the device link. The
> parent could be several levels up and multiple supplier links might be
> skipped for various reasons. If they all printed the parent's fwnode,
> it'll be confusing to debug.

In fact, I will remove the check if(!sup_handle) in the next iteration.

Indeed, sup_handle cannot be NULL.
sup_dev is retrieved from fwnode_get_next_parent_dev() or get_dev_from_fwnode().
In both cases, if sup_dev is valid, sup_dev->fwnode is valid too.
So, the check and the dev_dbg() call make no sense.

Best regards,
Hervé
