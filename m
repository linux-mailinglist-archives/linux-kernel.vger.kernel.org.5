Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00EF764018
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGZUDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGZUDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:03:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772C01BF6;
        Wed, 26 Jul 2023 13:03:00 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:580::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 05E8F6605835;
        Wed, 26 Jul 2023 21:02:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690401779;
        bh=gearTXn/NA1vf3XwUpplsDwpHaVmvkzNdWyDMsuqeZo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UJ7rpORaK+nEzKWJekZChGytRWr5gox773JXYZpmRVnbWU9+ghrzyRBbx1Hsx0GV2
         XwPOXowfw3cXxEzN3ZDJek7mUUkh+kJHIdG9QkLxxvs7ng+65UB3eJwpWh6b67l5wh
         V1MlukVZ6V8D7oRxEKws80RLD2k/c86JUlFKXrcaq9zwoib55tHhlV50sKU9LR+lZD
         HEhwVGbSRxwETxb2W7ItX+tA2CMQ9YyPJjxbdtsrhBOmdjnn65d9RsgN/RNLxJLHod
         Wqmu5hUFHMI0Vu86d4IznJkx/DykGVMgg6+uJwgj+oJVfwmvNmBAvGkkp+kg0SrR8w
         +S+lTwQsKju5A==
Message-ID: <4afabd718f632965314794946d4b31cec739a3d6.camel@collabora.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Michael Grzeschik <mgr@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Wed, 26 Jul 2023 16:02:49 -0400
In-Reply-To: <ZL-RWOfUYh5VbUo1@aptenodytes>
References: <ZK2NiQd1KnraAr20@aptenodytes>
         <20230721181951.GL12001@pengutronix.de>
         <c6a222be5eee962581cf5dcb9a1473cf45ff303c.camel@collabora.com>
         <ZL-RWOfUYh5VbUo1@aptenodytes>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 25 juillet 2023 =C3=A0 11:09 +0200, Paul Kocialkowski a =C3=A9crit=
=C2=A0:
> Hi Nicolas,
>=20
> On Mon 24 Jul 23, 10:03, Nicolas Dufresne wrote:
> > Le vendredi 21 juillet 2023 =C3=A0 20:19 +0200, Michael Grzeschik a =C3=
=A9crit=C2=A0:
> > > > As a result, we cannot expect that any given encoder is able to pro=
duce frames
> > > > for any set of headers. Reporting related constraints and limitatio=
ns (beyond
> > > > profile/level) seems quite difficult and error-prone.
> > > >=20
> > > > So it seems that keeping header generation in-kernel only (close to=
 where the
> > > > hardware is actually configured) is the safest approach.
> > >=20
> > > For the case with the rkvenc, the headers are also not created by the
> > > kernel driver. Instead we use the gst_h264_bit_writer_sps/pps functio=
ns
> > > that are part of the codecparsers module.
> >=20
> > One level of granularity we can add is split headers (like SPS/PPS) and
> > slice/frame headers.
>=20
> Do you mean asking the driver to return a buffer with only SPS/PPS and th=
en
> return another buffer with the slice/frame header?
>=20
> Looks like there's already a control for it: V4L2_CID_MPEG_VIDEO_HEADER_M=
ODE
> which takes either
> - V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE: looks like what you're suggesting
> - V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME: usual case
>=20
> So that could certainly be supported to easily allow userspace to stuff e=
xtra
> NALUs in-between.

Good point, indeed.

>=20
> > It remains that in some cases, like HEVC, when the slice
> > header is byte aligned, it can be nice to be able to handle it at appli=
cation
> > side in order to avoid limiting SVC support (and other creative feature=
s) by our
> > API/abstraction limitations.
>=20
> Do you see something in the headers that we expect the kernel to generate=
 that
> would need specific changes to support features like SVC?

Getting the kernel to set the layer IDs, unless we have a full SVC configur=
ation
would just be extra indirections. That being said, if we mention HEVC, thes=
e IDs
can be modified in-place as they use a fixed number of bytes. If you can sp=
lit
the headers appart, generating per layer headers in application makes a lot=
 of
sense.

Traditionally, slice headers are made by stateless accelerators, but not th=
e
SPS/PPS and friend.

>=20
> From what I can see there's a svc_extension_flag that's only set for spec=
ific
> NALUs (prefix_nal_unit/lice_layer_extension) so these could be inserted b=
y
> userspace.
>=20
> Also I'm not very knowledgeable about SVC so it's not very clear to me if=
 it's
> possible to take an encoder that doesn't support SVC and turn the resulti=
ng
> stream into something SVC-ready by adding extra NAL units or if the encod=
er
> should be a lot more involved.

You can use any encoders to create a temporal SVC. Its only about the
referencing pattern, made so you can reduce the framerate (dividing by 2
usually).

For spatial layer, the encoders need scaling capabilities. I'm not totally =
sure
how multi-view work, but this is most likely just using left eye as referen=
ce
(not having an I frame ever for the second eye).

>=20
> Also do you know if we have stateful codecs supporting SVC?

We don't at the moment, they all produce headers with layer id hardcoded to=
 0 as
far as I'm aware. The general plan (if it had continued) might have been to
offer a memu based control, and drivers could offer from a list of preset S=
VC
pattern. Mimicking what browsers needs:

https://www.w3.org/TR/webrtc-svc/

>=20
> > I think a certain level of "per CODEC" reasoning is
> > also needed. Just like, I would not want to have to ask the kernel to g=
enerate
> > user data SEI and other in-band data.
>=20
> Yeah it looks like there is definitely a need for adding extra NALUs from
> userspace without passing that data to the kernel.
>=20
> Cheers,
>=20
> Paul
>=20

