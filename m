Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61729768518
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjG3Lig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG3Lie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:38:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61ED189;
        Sun, 30 Jul 2023 04:38:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA5960C1E;
        Sun, 30 Jul 2023 11:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE8AC433C8;
        Sun, 30 Jul 2023 11:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690717112;
        bh=Utllk/tkddiJum7QAnNqbad52ZULbHvTkVGIxPyhS2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VV1+6gehhZ4GjLtKOsYF9niAy8dsNga1seriKQLKphDp4vhr3YzNAa6RolzlEcRaL
         6nH26OunpN/F87lpnt4103JJaYYs3rxbOgGbcKd0YMS52t6m4oZJFb99uxcHUziHB5
         9HTAX9ZbhaO8va1lzhSeiBWZ8OsamwT6Tkngkvug=
Date:   Sun, 30 Jul 2023 13:38:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/22] Input: ili210x - use device core to create
 driver-specific device attributes
Message-ID: <2023073010-debunk-tripping-270a@gregkh>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
 <20230729005133.1095051-13-dmitry.torokhov@gmail.com>
 <fd975ac8-bea4-22ae-cb5f-cbdaa3566d25@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd975ac8-bea4-22ae-cb5f-cbdaa3566d25@denx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 05:07:17PM +0200, Marek Vasut wrote:
> On 7/29/23 02:51, Dmitry Torokhov wrote:
> > Instead of creating driver-specific device attributes with
> > devm_device_add_group() have device core do this by setting up dev_groups
> > pointer in the driver structure.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >   drivers/input/touchscreen/ili210x.c | 15 +++++----------
> >   1 file changed, 5 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
> > index ad6828e4f2e2..31ffdc2a93f3 100644
> > --- a/drivers/input/touchscreen/ili210x.c
> > +++ b/drivers/input/touchscreen/ili210x.c
> > @@ -876,7 +876,7 @@ static ssize_t ili210x_firmware_update_store(struct device *dev,
> >   static DEVICE_ATTR(firmware_update, 0200, NULL, ili210x_firmware_update_store);
> > -static struct attribute *ili210x_attributes[] = {
> > +static struct attribute *ili210x_attrs[] = {
> >   	&dev_attr_calibrate.attr,
> >   	&dev_attr_firmware_update.attr,
> >   	&dev_attr_firmware_version.attr,
> > @@ -904,10 +904,11 @@ static umode_t ili210x_attributes_visible(struct kobject *kobj,
> >   	return attr->mode;
> >   }
> > -static const struct attribute_group ili210x_attr_group = {
> > -	.attrs = ili210x_attributes,
> > +static const struct attribute_group ili210x_group = {
> > +	.attrs = ili210x_attrs,
> 
> Is all the renaming really necessary and relevant to this patch ?

Yes, it's needed for the __ATTRIBUTE_GROUPS() macro.

thanks,

greg k-h
