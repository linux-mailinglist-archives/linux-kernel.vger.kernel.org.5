Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151C97C4C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbjJKHi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344888AbjJKHiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:38:52 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147EB9D;
        Wed, 11 Oct 2023 00:38:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BF9E1BF20B;
        Wed, 11 Oct 2023 07:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697009928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=80AN/ewLY3sOG4mBkN0xkLR7Lqdajsc/Pog++sJfJ24=;
        b=nRKHGoiukw1U7hMyInMzLPB4Ppzu5iQMeeCG8G96Igdm1kRuk91r7d4REEJ4EdL1e1aVwc
        itmKn7Ka52HSQGTnRzpj+xJPyuc0xwLn/rs5/3To6DwuNPTpmiWNuX7crVp3rNQZSRsjmZ
        PqX0B61wSIbuc5+XlC+AI6dT5hS6WHEvehgsDXnwBCcI8BOK6+Cs4bKINHD3PyBwEiFNrt
        rdy71o66PKi933CBOM5Vy9SCEiFkqmnseK6iB+g54pEzcJqIfK94E4m3e/wZIluzIWv1Ua
        XUDGrbC2WiBOrA5SylFXIy/wPpLym5cuU4U1s6K6l2X0Akr6UOxLg1J33YY2Hg==
Date:   Wed, 11 Oct 2023 09:38:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v12 5/7] nvmem: core: Rework layouts to become regular
 devices
Message-ID: <20231011093843.49831a75@xps-13>
In-Reply-To: <dc96ddb1-502c-e643-7749-d057d1fc6490@linaro.org>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
        <20231005155907.2701706-6-miquel.raynal@bootlin.com>
        <dc96ddb1-502c-e643-7749-d057d1fc6490@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Mon, 9 Oct 2023 10:44:45 +0100:

> On 05/10/2023 16:59, Miquel Raynal wrote:
> > Current layout support was initially written without modules support in
> > mind. When the requirement for module support rose, the existing base
> > was improved to adopt modularization support, but kind of a design flaw
> > was introduced. With the existing implementation, when a storage device
> > registers into NVMEM, the core tries to hook a layout (if any) and
> > populates its cells immediately. This means, if the hardware description
> > expects a layout to be hooked up, but no driver was provided for that,
> > the storage medium will fail to probe and try later from
> > scratch. Technically, the layouts are more like a "plus" and, even we =
=20
>=20
> This is not true, As layouts are kind of resources for nvmem providers, I=
deally the provider driver should defer if there is no matching layout avai=
lable.

That is not possible as layouts are now devices, the device will be
populated but you cannot know when it will be actually probed?

> Expressing this as a weak dependency is going to be an issue,
>=20
> 1. With creating the sysfs entries and user notifications

For me, this is not an issue. Greg?

> 2. nvmem consumers will be in a confused state with provider registered b=
ut without cells added yet.

Wow, I feel like we are moving backwards.

Consumers don't know about the nvmem devices, they just care about a
cell. If the cell isn't there, the consumer decides what it wants
to do with that.

We initially discussed that we would not EPROBE_DEFER if the layouts
were not yet available because the NVMEM device may be created from a
device that is the main storage and while you don't have your rootfs,
you don't have access to your modules. And anyway it's probably a bad
idea to allow endless probe deferrals on your main storage device.

If the cells are not available at that time, it's not a huge deal? The
consumers will have to wait a bit more (or take any other action, this
is device dependent).

> --srini
> > consider that the hardware description shall be correct, we could still
> > probe the storage device (especially if it contains the rootfs).
> >=20
> > One way to overcome this situation is to consider the layouts as
> > devices, and leverage the existing notifier mechanism. When a new NVMEM
> > device is registered, we can:
> > - populate its nvmem-layout child, if any
> > - try to modprobe the relevant driver, if relevant
> > - try to hook the NVMEM device with a layout in the notifier
> > And when a new layout is registered:
> > - try to hook all the existing NVMEM devices which are not yet hooked to
> >    a layout with the new layout
> > This way, there is no strong order to enforce, any NVMEM device creation
> > or NVMEM layout driver insertion will be observed as a new event which
> > may lead to the creation of additional cells, without disturbing the
> > probes with costly (and sometimes endless) deferrals.
> >=20
> > In order to achieve that goal we need:
> > * To keep track of all nvmem devices
> > * To create a new bus for the nvmem-layouts with minimal logic to match
> >    nvmem-layout devices with nvmem-layout drivers.
> > All this infrastructure code is created in the layouts.c file.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Tested-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > ---

Thanks,
Miqu=C3=A8l
