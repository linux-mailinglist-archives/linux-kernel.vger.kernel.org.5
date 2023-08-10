Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FD97779CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjHJNpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjHJNo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:44:59 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DF3E54;
        Thu, 10 Aug 2023 06:44:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8085FFF807;
        Thu, 10 Aug 2023 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691675095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F5wViiyTAWyY+OJipO1aRrw89grP1l5LueXf0JFiGBU=;
        b=nqPyyfX7SLmFdffRCMPwJopLv8vbOy52xfGyEj8J2svRbEyH/6GxZPAev2zuiONIf7xqHS
        FqVwrxfVDzoqEJzO7S2sL0fv2y9uuBEjPYnBTEsKQPfrU7pwMo12PsDi07PCBUkWZoOBAu
        9GzbIfKZzSkEJ6MEzSOSFSsIxRIDwjhMSSILt6wpozpd8aRybn/LUJq31Ko0kNqyOUGohE
        HF00qXAU9BiIEi+NdMaJdShSsvI+wDsvWOZ+hPCHHRV73zVoiA4Osyvx10nzXFSLHcGB0Q
        eT8/n8G5wDtFeAi7EsvTjw2tvDSz07tGw3LGHIL56FBEyput1NhN5F+IXhfGwA==
Date:   Thu, 10 Aug 2023 15:44:53 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Message-ID: <ZNTp1e4gJ2zeYmS-@aptenodytes>
References: <ZK2NiQd1KnraAr20@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ShpM4Z1pidaOmmi6"
Content-Disposition: inline
In-Reply-To: <ZK2NiQd1KnraAr20@aptenodytes>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ShpM4Z1pidaOmmi6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

On Tue 11 Jul 23, 19:12, Paul Kocialkowski wrote:
> I am now working on a H.264 encoder driver for Allwinner platforms (curre=
ntly
> focusing on the V3/V3s), which already provides some usable bitstream and=
 will
> be published soon.

So I wanted to shared an update on my side since I've been making progress =
on
the H.264 encoding work for Allwinner platforms. At this point the code sup=
ports
IDR, I and P frames, with a single reference. It also supports GOP (both cl=
osed
and open with IDR or I frame interval and explicit keyframe request) but us=
es
QP controls and does not yet provide rate control. I hope to be able to
implement rate-control before we can make a first public release of the cod=
e.

One of the main topics of concern now is how reference frames should be man=
aged
and how it should interact with kernel-side GOP management and rate control.

Leaving GOP management to the kernel-side implies having it decide which fr=
ame
should be IDR, I or P (and B for encoders that can support it), while keepi=
ng
the possibility to request a keyframe (IDR) and configure GOP size. Now it =
seems
to me that this is already a good balance between giving userspace a decent
level of control while not having to specify the frame type explicitly for =
each
frame or maintain a GOP in userspace.

Requesting the frame type explicitly seems more fragile as many situations =
will
be invalid (e.g. requesting a P frame at the beginning of the stream, etc) =
and
it generally requires userspace to know a lot about what the codec assumpti=
ons
are. Also for B frames the decision would need to be consistent with the fa=
ct
that a following frame (in display order) would need to be submitted earlier
than the current frame and inform the kernel so that the picture order count
(display order indication) can be maintained. This is not impossible or out=
 of
reach, but it brings a lot of complexity for little advantage.

Leaving the decision to the kernel side with some hints (whether to force a
keyframe, whether to allow B frames) seems a lot easier, especially for B f=
rames
since the kernel could just receive frames in-order and decide to hold one
so that it can use the next frame submitted as a forward reference for this
upcoming B frame. This requires flushing support but it's already well in p=
lace
for stateful encoders.

The next topic of interest is reference management. It seems pretty clear t=
hat
the decision of whether a frame should be a reference or not always needs t=
o be
taken when encoding that frame. In H.264 the nal_ref_idc slice header eleme=
nt
indicates whether a frame is marked as reference or not. IDR frames can
additionally be marked as long-term reference (if I understood correctly, t=
he
frame will stay in the reference picture list until the next IDR frame).
Frames that are marked as reference are added to the l0/l1 lists implicitly
that way and are evicted mostly depending on the number of reference slots
available, or when a new GOP is started.

With the frame type decided by the kernel, it becomes nearly impossible for
userspace to keep track of the reference lists. Userspace would at least ne=
ed
to know when an IDR frame is produced to flush the reference lists. In addi=
tion
it looks like most hardware doesn't have a way to explicitly discard previo=
us
frames that were marked as reference from being used as reference for next
frames. All in all this means that we should expect little control over the
reference frames list.

As a result my updated proposal would be to have userspace only indicate wh=
ether
a submitted frame should be marked as a reference or not instead of submitt=
ing
an explicit list of previous buffers that should be used as reference, which
would be impossible to honor in many cases.

Addition information gathered:
- It seems likely that the Allwinner Video Engine only supports one referen=
ce
  frame. There's a register for specifying the rec buffer of a second one b=
ut
  I have never seen the proprietary blob use it. It might be as easy as
  specifying a non-zero address there but it might also be ignored or requi=
re
  some undocumented bit to use more than one reference. I haven't made any
  attempt at using it yet.
- Contrary to what I said after Andrzej's talk at EOSS, most Allwinner plat=
forms
  do not support VP8 encode (despite Allwinner's proprietary blob having an
  API for it). The only platform that advertises it is the A80 and this mig=
ht
  actually be a VP8-only Hantro H1. It seems that the API they developed in=
 the
  library stuck around even if no other platform can use it.

Sorry for the long email again, I'm trying to be a bit more explanatory than
just giving some bare conclusions that I drew on my own.

What do you think about these ideas?

Cheers,

Paul

>=20
> This is a very long email where I've tried to split things into distinct =
topics
> and explain a few concepts to make sure everyone is on the same page.
>=20
> # Bitstream Headers
>=20
> Stateless encoders typically do not generate all the bitstream headers and
> sometimes no header at all (e.g. Allwinner encoder does not even produce =
slice
> headers). There's often some hardware block that makes bit-level writing =
to the
> destination buffer easier (deals with alignment, etc).
>=20
> The values of the bitstream headers must be in line with how the compress=
ed
> data bitstream is generated and generally follow the codec specification.
> Some encoders might allow configuring all the fields found in the headers,
> others may only allow configuring a few or have specific constraints rega=
rding
> which values are allowed.
>=20
> As a result, we cannot expect that any given encoder is able to produce f=
rames
> for any set of headers. Reporting related constraints and limitations (be=
yond
> profile/level) seems quite difficult and error-prone.
>=20
> So it seems that keeping header generation in-kernel only (close to where=
 the
> hardware is actually configured) is the safest approach.
>=20
> # Codec Features
>=20
> Codecs have many variable features that can be enabled or not and specific
> configuration fields that can take various values. There is usually some
> top-level indication of profile/level that restricts what can be used.
>=20
> This is a very similar situation to stateful encoding, where codec-specif=
ic
> controls are used to report and set profile/level and configure these asp=
ects.
> A particularly nice thing about it is that we can reuse these existing co=
ntrols
> and add new ones in the future for features that are not yet covered.
>=20
> This approach feels more flexible than designing new structures with a se=
lected
> set of parameters (that could match the existing controls) for each codec.
>=20
> # Reference and Reconstruction Management
>=20
> With stateless encoding, we need to tell the hardware which frames need t=
o be
> used as references for encoding the current frame and make sure we have t=
he
> these references available as decoded frames in memory.
>=20
> Regardless of references, stateless encoders typically need some memory s=
pace to
> write the decoded (known as reconstructed) frame while it's being encoded.
>=20
> One question here is how many slots for decoded pictures should be alloca=
ted
> by the driver when starting to stream. There is usually a maximum number =
of
> reference frames that can be used at a time, although perhaps there is a =
use
> case to keeping more around and alternative between them for future refer=
ences.
>=20
> Another question is how the driver should keep track of which frame will =
be used
> as a reference in the future and which one can be evicted from the pool of
> decoded pictures if it's not going to be used anymore.
>=20
> A restrictive approach would be to let the driver alone manage that, simi=
larly
> to how stateful encoders behave. However it might provide extra flexibili=
ty
> (and memory gain) to allow userspace to configure the maximum number of p=
ossible
> reference frames. In that case it becomes necessary to indicate if a given
> frame will be used as a reference in the future (maybe using a buffer fla=
g)
> and to indicate which previous reference frames (probably to be identifie=
d with
> the matching output buffer's timestamp) should be used for the current en=
code.
> This could be done with a new dedicated control (as a variable-sized arra=
y of
> timestamps). Note that userspace would have to update it for every frame =
or the
> reference frames will remain the same for future encodes.
>=20
> The driver will then make sure to keep the reconstructed buffer around, i=
n one
> of the slots. When there's no slot left, the driver will drop the oldest
> reference it has (maybe with a bounce buffer to still allow it to be used=
 as a
> reference for the current encode).
>=20
> With this behavior defined in the uAPI spec, userspace will also be able =
to
> keep track of which previous frame is no longer allowed as a reference.
>=20
> # Frame Types
>=20
> Stateless encoder drivers will typically instruct the hardware to encode =
either
> an intra-coded or an inter-coded frame. While a stream composed only of a=
 single
> intra-coded frame followed by only inter-coded frames is possible, it's
> generally not desirable as it is not very robust against data loss and ma=
kes
> seeking difficult.
>=20
> As a result, the frame type is usually decided based on a given GOP size
> (the frequency at which a new intra-coded frame is produced) while intra-=
coded
> frames can be explicitly requested upon request. Stateful encoders implem=
ent
> these through dedicated controls:
> - V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME
> - V4L2_CID_MPEG_VIDEO_GOP_SIZE
> - V4L2_CID_MPEG_VIDEO_H264_I_PERIOD
>=20
> It seems that reusing them would be possible, which would let the driver =
decide
> of the particular frame type.
>=20
> However it makes the reference frame management a bit trickier since refe=
rence
> frames might be requested from userspace for a frame that ends up being
> intra-coded. We can either allow this and silently ignore the info or exp=
ect
> that userspace keeps track of the GOP index and not send references on th=
e first
> frame.
>=20
> In some codecs, there's also a notion of barrier key-frames (IDR frames in
> H.264) that strictly forbid using any past reference beyond the frame.
> There seems to be an assumption that the GOP start uses this kind of frame
> (and not any intra-coded frame), while the force key frame control does n=
ot
> particularly specify it.
>=20
> In that case we should flush the list of references and userspace should =
no
> longer provide references to them for future frames. This puts a requirem=
ent on
> userspace to keep track of GOP start in order to know when to flush its
> reference list. It could also check if V4L2_BUF_FLAG_KEYFRAME is set, but=
 this
> could also indicate a general intra-coded frame that is not a barrier.
>=20
> So another possibility would be for userspace to explicitly indicate which
> frame type to use (in a codec-specific way) and act accordingly, leaving =
any
> notion of GOP up to userspace. I feel like this might be the easiest appr=
oach
> while giving an extra degree of control to userspace.
>=20
> # Rate Control
>=20
> Another important feature of encoders is the ability to control the amoun=
t of
> data produced following different rate control strategies. Stateful encod=
ers
> typically do this in-firmware and expose controls for selecting the strat=
egy
> and associated targets.
>=20
> It seems desirable to support both automatic and manual rate-control to
> userspace.
>=20
> Automatic control would be implemented kernel-side (with algos possibly s=
hared
> across drivers) and reuse existing stateful controls. The advantage is
> simplicity (userspace does not need to carry its own rate-control
> implementation) and to ensure that there is a built-in mechanism for comm=
on
> strategies available for every driver (no mandatory dependency on a propr=
ietary
> userspace stack). There may also be extra statistics or controls availabl=
e to
> the driver that allow finer-grain control.
>=20
> Manual control allows userspace to get creative and requires the ability =
to set
> the quantization parameter (QP) directly for each frame (controls are alr=
eady
> as many stateful encoders also support it).
>=20
> # Regions of Interest
>=20
> Regions of interest (ROIs) allow specifying sub-regions of the frame that=
 should
> be prioritized for quality. Stateless encoders typically support a limited
> number and allow setting specific QP values for these regions.
>=20
> While the QP value should be used directly in manual rate-control, we pro=
bably
> want to have some "level of importance" setting for kernel-side rate-cont=
rol,
> along with the dimensions/position of each ROI. This could be expressed w=
ith
> a new structure containing all these elements and presented as a variable=
-sized
> array control with as many elements as the hardware can support.
>=20
> --=20
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com



--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--ShpM4Z1pidaOmmi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmTU6dQACgkQ3cLmz3+f
v9G4Ygf/e+uKGcCeNhh5mnTZJnRh/vPHLTUPn+TLR1edwu/z4dxKsmo8L4yFehUF
zMWcIT297rMOYCBBWufciJKFppUlYjTXC5KW/n4P0wkO2n4hCXVFTlfzcoPL96aN
IecH4rFzcXa2xCxzIex3HQXQJiz5gHDD0FqZcSbNFCt/Rb5znCPrrBFlQdVeSuHj
qsOCLY91Njnqf7APx4BBvJ7VAmE34hU/t6mJxWxsZiWwhOnNRjHWcXCnkz7HSJpU
gBAGd/iK5y1M+mHQ9F2Ko5vdzLXqsW0cEGf4P0nY0mTOGrTMBZftmyCD4DXSYXTP
/RaYpbxIHGgevE8DqFhwhiwyh8UsqQ==
=nb4q
-----END PGP SIGNATURE-----

--ShpM4Z1pidaOmmi6--
