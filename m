Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7B47B565C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbjJBPQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbjJBPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:16:20 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE78B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:16:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 745A31C0009;
        Mon,  2 Oct 2023 15:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696259775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AY6CEUXfWvCVK8bHGt4MBD50WkCv7rvLNyBiVvtUYjk=;
        b=KalJIx+1ICwgQ4vaILtd1YXpqzAo8gDl5U5EFJJNMZkznoqMdE2vMzJidDTdKPZON/n28W
        UlsSzZfoP5m8CSUb0hMfx23ul1+GibQ35/fX7iPPK/2TFQzUSexI8ETlneCOzgJ6pCMJSv
        9fSu+8M6b8O1W46L8q8qLNO45V8iCX5OKXwdPF9XGegw8zGXVMTRP1qpzWIsq0tskDDo/R
        2KxybmkDs9Zi1OjyYD2ppdP9dglAR89XY2OJ3u+X+PJitEyhWygrNMMXUKmnMDvdQpWeRf
        JrMxIu1YtqloTKKhHxR6nhqr0m4gCy4gMOQBbKTEYe4y093kIoskhm/dwdrEgg==
Date:   Mon, 2 Oct 2023 17:16:12 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
Message-ID: <20231002171612.067b84a8@xps-13>
In-Reply-To: <2023100200-snowcap-arena-a548@gregkh>
References: <20230922174854.611975-1-miquel.raynal@bootlin.com>
        <20230922174854.611975-2-miquel.raynal@bootlin.com>
        <2023100200-snowcap-arena-a548@gregkh>
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

gregkh@linuxfoundation.org wrote on Mon, 2 Oct 2023 11:35:02 +0200:

> On Fri, Sep 22, 2023 at 07:48:52PM +0200, Miquel Raynal wrote:
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
> > probes with costly (and sometimes endless) deferrals.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> Did I miss why these were decided to be platform devices and not normal
> devices on their own "bus" that are attached to the parent device
> properly?  Why platform for a dynamic thing?

I don't think you missed anything, following the discussion "how to
picture these layouts as devices" I came up with the simplest
approach: using the platform infrastructure. I thought creating my own
additional bus just for that would involve too much code duplication.
I agree the current implementation kind of abuses the platform
infrastructure. I will have a look in order to maybe mutate this into
its own bus.

> If I did agree with this, it should be documented here in the changelog
> why this is required to be this way so I don't ask the question again in
> the future :)

Haha, I don't think you did ;)

Thanks,
Miqu=C3=A8l
