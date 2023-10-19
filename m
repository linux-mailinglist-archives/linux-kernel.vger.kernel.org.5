Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E667CF42B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjJSJjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJSJjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:39:32 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338C9106;
        Thu, 19 Oct 2023 02:39:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0BD41240006;
        Thu, 19 Oct 2023 09:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697708367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=cGl5byPyRt4Dyc2mGkICLZ0WP6tf30bsG6wfqqctHUs=;
        b=ZU/TPnonJbEQlFzVZayq14Wdoh9JXqo0H6KNMkR+kmJ/pGabHBZLnpP4P9NCD0ULK4TpLr
        sf1ObDGbw4+q0hyQiuUdmues9dbkrvcQApb0Ko82egOE8g3KvH332cujb4sX5+J25si37/
        wzDOZOSHs4PGL/JBw7FVK6TismXIjvxWUUgYAE+tWm4hv5AIXsb29wkGh/h/dTLz2a4jRn
        vqAGEe+4pOiSQbjEs60fmJaTq4uwmntORvYPP8GZsTl6QrXvDaosfL/ciPMxcV5FinQ/w5
        MR/iuhqv9pm0YmjpEG+TfucwnYFAEMFlj7s3Iuay1u1xPrvtxQeJgu7BuAk4lw==
Date:   Thu, 19 Oct 2023 11:39:25 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: V4L2 Encoders Pre-Processing Support Questions
Message-ID: <ZTD5TXND4R7JqvCD@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WgtQJeX6hvjvRJCr"
Content-Disposition: inline
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WgtQJeX6hvjvRJCr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

While working on the Allwinner Video Engine H.264 encoder, I found that it =
has
some pre-processing capabilities. This includes things like chroma
down-sampling, colorspace conversion and scaling.

For example this means that you can feed the encoder with YUV 4:2:2 data and
it will downsample it to 4:2:0 since that's the only thing the hardware can=
 do.
It can also happen when e.g. providing RGB source pictures which will be
converted to YUV 4:2:0 internally.

I was wondering how all of this is dealt with currently and whether this sh=
ould
be a topic of attention. As far as I can see there is currently no practica=
l way
for userspace to know that such downsampling will take place, although this=
 is
useful to know.

Would it make sense to have an additional media entity between the source v=
ideo
node and the encoder proc and have the actual pixel format configured in th=
at
link (this would still be a video-centric device so userspace would not be
expected to configure that link). But then what if the hardware can either
down-sample or keep the provided sub-sampling? How would userspace indicate
which behavior to select? It is maybe not great to let userspace configure =
the
pads when this is a video-node-centric driver.

Perhaps this could be a control or the driver could decide to pick the least
destructive sub-sampling available based on the selected codec profile
(but this is still a guess that may not match the use case). With a control
we probably don't need an extra media entity.

Another topic is scaling. We can generally support scaling by allowing a
different size for the coded queue after configuring the picture queue.
However there would be some interaction with the selection rectangle, which=
 is
used to set the cropping rectangle from the *source*. So the driver will ne=
ed
to take this rectangle and scale it to match with the coded size.

The main inconsistency here is that the rectangle would no longer correspon=
d to
what will be set in the bitstream, nor would the destination size since it =
does
not count the cropping rectangle by definition. It might be more sensible to
have the selection rectangle operate on the coded/destination queue instead,
but things are already specified to be the other way round.

Maybe a selection rectangle could be introduced for the coded queue too, wh=
ich
would generally be propagated from the picture-side one, except in the case=
 of
scaling where it would be used to clarify the actual final size (coded size
taking the cropping in account). It this case the source selection rectangle
would be understood as an actual source crop (may not be supported by hardw=
are)
instead of an indication for the codec metadata crop fields. And the coded
queue dimensions would need to take in account this source cropping, which =
is
kinda contradictory with the current semantics. Perhaps we could define that
the source crop rectangle should be entirely ignored when scaling is used,
which would simplify things (although we lose the ability to support source
cropping if the hardware can do it).

If operating on the source selection rectangle only (no second rectangle on=
 the
coded queue) some cases would be impossible to reach, for instance going fr=
om
some aligned dimensions to unaligned ones (e.g. 1280x720 source scaled to
1920x1088 and we want the codec cropping fields to indicate 1920x1080).

Anyway just wanted to check if people have already thought about these topi=
cs,
but I'm mostly thinking out loud and I'm of course not saying we need to so=
lve
these problems now.

Sorry again for the long email, I hope the points I'm making are somewhat
understandable.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--WgtQJeX6hvjvRJCr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmUw+U0ACgkQ3cLmz3+f
v9GLIAf/V2WamAA+X64t4+tHKp2M6Vt+DWHzYUa0ykf+2nsdgutynZBs9hbSBfcv
Gq7AdeD28O40eIH7jGC7LUEMjVRCxeXHNSWWSqmvhtiJDU2qQL6FVwyXjU3SSqVb
CKj3HG+ZhSdEVl+c8HigpdmylFCKJTSIlyIFA3RmZuu/A6hPRacq3fXP42HD0q7E
Ou+cPmoOf5CHx8Ew9nyUPRDaHTDwr1/r/y0GukXOg0KnyBvuJp/ns7rq5B1rwxF9
C+kD+jkBa7BlJjRjEcQDse+tMGxWiqfGR+eG0lWN9dZM6WCrAIfeWxh522RbxRJe
0isYOxAZHJ8AD6ny84gj4Kd3n4xv6w==
=qz3U
-----END PGP SIGNATURE-----

--WgtQJeX6hvjvRJCr--
