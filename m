Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135D0771D28
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjHGJdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGJda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:33:30 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DCEE7B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:33:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E5E42000A;
        Mon,  7 Aug 2023 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691400806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtYbzRcQ6XjwjvKil4QI+vkjjqINuSRUpPIAc5daf/s=;
        b=M4bWRF0nJRKyVIFGIyW5YuCqD22A/p/YB9WxeAeCEs9oVK8POVvPZ0WO/G45YfTod+Jp6w
        IoUh67ZM6ryKacxiqWgLbc4n9hFb2X599dB0NHXRRw6i8M07VXFrEDmWR0UqdhX59hMdDt
        jX3yYFcg6xSJzciGHbHwWcTQxriEIKyNuooGMFFOWCbO5DNMTJhUeRKp/Xyxh8cR7OoEi3
        JoRABVozIDag7WeWpgLRF1kFf04fkID9hKdD48i+6SNqsDnh7ZIjf/uSWQsW6gP9WsQT2y
        BTGek3QQuEZ6QwLzJAdPCmeW3Iij8XRKt5twPE8agH2SvWbftiIh2Nwz3qH5bA==
Date:   Mon, 7 Aug 2023 11:33:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v8 6/8] nvmem: core: Rework layouts to become platform
 devices
Message-ID: <20230807113321.0f0d46d8@xps-13>
In-Reply-To: <2023080704-garage-amused-f18b@gregkh>
References: <20230807082419.38780-1-miquel.raynal@bootlin.com>
        <20230807082419.38780-7-miquel.raynal@bootlin.com>
        <2023080704-garage-amused-f18b@gregkh>
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

Hi Greg,

gregkh@linuxfoundation.org wrote on Mon, 7 Aug 2023 11:05:48 +0200:

> On Mon, Aug 07, 2023 at 10:24:17AM +0200, Miquel Raynal wrote:
> > Current layout support was initially written without modules support in
> > mind. When the requirement for module support rose, the existing base
> > was improved to adopt modularization support, but kind of a design flaw
> > was introduced. With the existing implementation, when a storage device
> > registers into NVMEM, the core tries to hook a layout (if any) and
> > populates its cells immediately. This means, if the hardware description
> > expects a layout to be hooked up, but no driver was provided for that,
> > the storage medium will fail to probe and try later from
> > scratch. Technically, the layouts are more like a "plus" and, even we
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
> >   a layout with the new layout
> > This way, there is no strong order to enforce, any NVMEM device creation
> > or NVMEM layout driver insertion will be observed as a new event which
> > may lead to the creation of additional cells, without disturbing the
> > probes with costly (and sometimes endless) deferrals. =20
>=20
> This is good, but why are you using a platform device here?  Is it a
> real platform device, or just a "fake" one you created?  If a fake one,
> please don't do that, use a real device, or a virtual device.  Platform
> devices should ONLY represent actual, real, platform devices (i.e. ones
> descibed by the firmware).

NVMEM layouts have their own firmware node (DT only in this case), so I
guess we are in the "real device" situation here? But there is no
specific hardware in the physical world, so I don't know in which class
they should preferably be. I thought platform devices would be a
helpful abstraction.

With this additional information, in case you advise for using virtual
devices, would you mind being more specific on what you expect? What
should be used instead of platform devices?

> Sorry but I couldn't answer this question by looking at this patch, the
> device creation path isn't exactly obvious :)

I would expect this to be handled by the of_platform_populate() call,
but perhaps you were looking for something else.

Thanks,
Miqu=C3=A8l
