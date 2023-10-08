Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EB47BCE9B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbjJHNjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344799AbjJHNjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:39:35 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BEAD6;
        Sun,  8 Oct 2023 06:39:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66CEB60004;
        Sun,  8 Oct 2023 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696772367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IBXkYS6fQ5HNeBmYBLasOhlEeE8uByHUo5jMn0E96xE=;
        b=m0v2eknngWwC18FYvgvuMt5MCXsPIUxJRHrztGTLfHwS+Z1Ev3pCEv42Z8kGipcBBTr03q
        j9B1DeYbgnQfE5Xz0vCrqj/eDoZmzf9AutJqKT7VNL5t3b7489ikRDP36zjga6RXO3Wk3S
        e0Yjcl34c+c0t88shUPRUgBlI1bBNvs4Xo4RrIJqXC3pTXtWwGLuZJQ+seSmb3mmR/5pz3
        /s7Bifn5Y5EyRJHzpVw4WJ1u4dWdvkajnkdhapk7E10HqTjqCan4tlLmzvWl3629YWicbs
        mXjGCGCTrhY4jCdknbMfbBSUR/tyr3wh/NsMAlkkWgROrTtefrVwoMaezgCUeg==
Date:   Sun, 8 Oct 2023 15:39:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v12 2/7] nvmem: Clarify the situation when there is no
 DT node available
Message-ID: <20231008153919.5b8e2562@xps-13>
In-Reply-To: <2e3ea6a4e63e0c6bebf4c18b165250e5@milecki.pl>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
        <20231005155907.2701706-3-miquel.raynal@bootlin.com>
        <05cd4592d0cfe0fb86aeb24db01de547@milecki.pl>
        <20231006183229.51cd8e60@xps-13>
        <2e3ea6a4e63e0c6bebf4c18b165250e5@milecki.pl>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

rafal@milecki.pl wrote on Sat, 07 Oct 2023 18:09:06 +0200:

> One comment below
>=20
> On 2023-10-06 18:32, Miquel Raynal wrote:
> > rafal@milecki.pl wrote on Fri, 06 Oct 2023 13:41:52 +0200:
> >  =20
> >> On 2023-10-05 17:59, Miquel Raynal wrote: =20
> >> > At a first look it might seem that the presence of the of_node point=
er
> >> > in the nvmem device does not matter much, but in practice, after > l=
ooking
> >> > deep into the DT core, nvmem_add_cells_from_dt() will simply and alw=
ays
> >> > return NULL if this field is not provided. As most mtd devices don't
> >> > populate this field (this could evolve later), it means none of their
> >> > children cells will be populated unless no_of_node is explicitly set=
 to
> >> > false. In order to clarify the logic, let's add clear check at the
> >> > beginning of this helper. =20
> >> >> I'm somehow confused by above explanation and code too. I read it =
=20
> >> carefully 5 times but I can't see what exactly this change helps with.=
 =20
> >> >> At first look at nvmem_add_cells_from_legacy_of() I can see it uses=
 =20
> >> "of_node" so I don't really agree with "it might seem that the >> pres=
ence
> >> of the of_node pointer in the nvmem device does not matter much". =20
> >> >> You really don't need to look deep into DT core (actually you don't=
 >> have =20
> >> to look into it at all) to understand that nvmem_add_cells_from_dt()
> >> will return 0 (nitpicking: not NULL) for a NULL pointer. It's all made
> >> of for_each_child_of_node(). Obviously it does nothing if there is
> >> nothing to loop over. =20
> >=20
> > That was not obvious to me as I thought it would start from /, which I
> > think some other function do when you don't provide a start node. =20
>=20
> What about documenting that function instead of adding redundant code?

Yeah would work as well. But I will just get rid of this, with your
other patch that solves the fact that of_node will be there with mtd
devices, it's no longer relevant.

Thanks,
Miqu=C3=A8l
