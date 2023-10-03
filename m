Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83A57B65C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbjJCJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbjJCJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:43:35 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D094AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:43:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8042060010;
        Tue,  3 Oct 2023 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696326209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4LHiTO8J5DrocIATZ0jDU3X1xjYKOP2tGzA9u4EZDo=;
        b=d648logROWclZX60FNwk9b8wY1gBcRPgySLZPx7OwkyAq200PKxxTcdcPunKV8kzWuB/s9
        5OHlQjfLThjk5PRQ/inhZP95VjdabL2+GJGfwTfBEJRAEiSDpd7ybm+EFCyP2kQQyUeiCn
        KJ6eyeMp/mPOG9yGZErX44KfMTcpA3Plr8hxB27WcOnuX8Js1c2O6m5Eunt09EpLaEto4d
        UwKRfMe/u8fHwDm7JCL8p3AJcDbAnihjpSpMdRyXM5E15UPYrc3SKE302EEWi1Pye7F0rd
        vhP8oeVu0YqPKWluDckx8mcuDLPwbmaS/RLddtoSOUPUuqHezpvYXsg0oNBCYg==
Date:   Tue, 3 Oct 2023 11:43:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v10 1/3] nvmem: core: Rework layouts to become platform
 devices
Message-ID: <20231003114326.7c61b07c@xps-13>
In-Reply-To: <84ff0dd8-706e-4b44-5313-3dd77b83100c@linaro.org>
References: <20230922174854.611975-1-miquel.raynal@bootlin.com>
        <20230922174854.611975-2-miquel.raynal@bootlin.com>
        <84ff0dd8-706e-4b44-5313-3dd77b83100c@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

> > +static int nvmem_dev_match_available_layout(struct device *dev, void *=
data)
> > +{
> > +	struct nvmem_device *nvmem =3D to_nvmem_device(dev);
> > +
> > +	return nvmem_match_available_layout(nvmem);
> > +}
> > +
> > +static int nvmem_for_each_dev(int (*fn)(struct device *dev, void *data=
))
> > +{
> > +	return bus_for_each_dev(&nvmem_bus_type, NULL, NULL, fn);
> > +}
> > +
> > +/*
> > + * When an NVMEM device is registered, try to match against a layout a=
nd
> > + * populate the cells. When an NVMEM layout is probed, ensure all NVME=
M devices
> > + * which could use it properly expose their cells.
> > + */
> > +static int nvmem_notifier_call(struct notifier_block *notifier,
> > +			       unsigned long event_flags, void *context)
> > +{
> > +	struct nvmem_device *nvmem =3D NULL;
> > +	int ret;
> > +
> > +	switch (event_flags) {
> > +	case NVMEM_ADD:
> > +		nvmem =3D context;
> > +		break;
> > +	case NVMEM_LAYOUT_ADD:
> > +		break;
> > +	default:
> > +		return NOTIFY_DONE;
> > +	} =20
>=20
> It looks bit unnatural for core to register notifier for its own events.
>=20
>=20
> Why do we need the notifier at core level, can we not just handle this in=
 core before raising these events, instead of registering a notifier cb?

There is no good place to do that "synchronously". We need some kind of
notification mechanism in these two cases:
* A memory device is being probed -> if a matching layout driver is
  already available, we need to parse the device and expose the cells,
  but not in the thread registering the memory device.
* A layout driver is being insmod'ed -> if a memory device needs it to
  create cells we need to parse the device content, but I find it
  crappy to start device-specific parsing in the registration handler.

So probe of the memory device is not a good place for this, nor is the
registration of the layout driver. Yet, we need to do the same
operation upon two different "events".

This notifier mechanism is a clean and easy way to get notified and
implement a callback which is also not blocking the thread doing the
initial registration. I am personally not bothered using it only
internally. If you have another mechanism in mind to perform a similar
operation, or a way to avoid this need I'll do the switch.

Thanks,
Miqu=C3=A8l
