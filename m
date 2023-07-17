Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1359075693C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjGQQdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjGQQd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:33:28 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A771B6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:33:27 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9217B60003;
        Mon, 17 Jul 2023 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689611606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aIwHzHJkLMQ/PIwojGZhkPtw9JKwjdkl6ysVTkh+5J4=;
        b=gqzn1r5hnP0SVRfKTPdGZ8JDY0R2tUcYwpAFsHvzT3crpGVtwwFtgRLw10VHkH2PqvluqI
        Bg8DrgB2m90VCyPCEAOwVMOhWk8XICobL+DSkY6lb0HQv7BobxkRdkAI4Qlou8T0KnJqKL
        0vRjEypb3cB+BbWElnFWBC0rvIZk3+Vb786MVeFTcvWXuCcmw4wv0Gzmexv3viKseci2SX
        t+tEFZuJkRSTV85jQDmjfHXR5byZ6HdvvSAiq9CyJR1raRieVhFD2QMV47Rhl72uIHb/7w
        Sh0+Ty+vFJaztVjlGSuCNqB3Q3/MTvsXJhIwmdWT0/P+85J2+Org4SxmRgDqTA==
Date:   Mon, 17 Jul 2023 18:33:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 3/3] nvmem: core: Expose cells through sysfs
Message-ID: <20230717183323.49a55ad0@xps-13>
In-Reply-To: <2023071717-channel-supernova-4cc9@gregkh>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
        <20230717075147.43326-4-miquel.raynal@bootlin.com>
        <2023071717-channel-supernova-4cc9@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

gregkh@linuxfoundation.org wrote on Mon, 17 Jul 2023 16:32:09 +0200:

> On Mon, Jul 17, 2023 at 09:51:47AM +0200, Miquel Raynal wrote:
> > The binary content of nvmem devices is available to the user so in the
> > easiest cases, finding the content of a cell is rather easy as it is
> > just a matter of looking at a known and fixed offset. However, nvmem
> > layouts have been recently introduced to cope with more advanced
> > situations, where the offset and size of the cells is not known in
> > advance or is dynamic. When using layouts, more advanced parsers are
> > used by the kernel in order to give direct access to the content of each
> > cell, regardless of its position/size in the underlying
> > device. Unfortunately, these information are not accessible by users,
> > unless by fully re-implementing the parser logic in userland.
> >=20
> > Let's expose the cells and their content through sysfs to avoid these
> > situations. Of course the relevant NVMEM sysfs Kconfig option must be
> > enabled for this support to be available.
> >=20
> > Not all nvmem devices expose cells. Indeed, the .bin_attrs attribute
> > group member will be filled at runtime only when relevant and will
> > remain empty otherwise. In this case, as the cells attribute group will
> > be empty, it will not lead to any additional folder/file creation.
> >=20
> > Exposed cells are read-only. There is, in practice, everything in the
> > core to support a write path, but as I don't see any need for that, I
> > prefer to keep the interface simple (and probably safer). The interface
> > is documented as being in the "testing" state which means we can later
> > add a write attribute if though relevant.
> >=20
> > There is one limitation though: if a layout is built as a module but is
> > not properly installed in the system and loaded manually with insmod
> > while the nvmem device driver was built-in, the cells won't appear in
> > sysfs. But if done like that, the cells won't be usable by the built-in
> > kernel drivers anyway. =20
>=20
> Wait, what?  That should not be an issue here, if so, then this change
> is not correct and should be fixed as this is NOT an issue for sysfs
> (otherwise the whole tree wouldn't work.)
>=20
> Please fix up your dependancies if this is somehow not working properly.

I'm not sure I fully get your point.

There is no way we can describe any dependency between a storage device
driver and an nvmem layout. NVMEM is a pure software abstraction, the
layout that will be chosen depends on the device tree, but if the
layout has not been installed, there is no existing mechanism in
the kernel to prevent it from being loaded (how do you know it's
not on purpose?).

Thanks,
Miqu=C3=A8l
