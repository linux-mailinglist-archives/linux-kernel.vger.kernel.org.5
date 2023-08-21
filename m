Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB95782D00
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbjHUPOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjHUPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:13:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E47FE9;
        Mon, 21 Aug 2023 08:13:56 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EFD1466071A2;
        Mon, 21 Aug 2023 16:13:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692630835;
        bh=mFYNrWixquz4I5luw3F/bSFPhcKJg4y5ERXJ27lQSkY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J/nCbIoa01is3DP2Gpqb/EJ1TYgDL/+H3Co6FmthiB/j3/VOKBzu+r4ei77aOWPz7
         ntPdB5xsrJUJ9qddEZzrl5yA1HLRUHrETg5EnFjvVY4xOllwa8Z738qNDz7d9AkgN/
         ilsEnFPcSCm2BLcm9B7dQxy2m8y7l3iqrwAcq6+cUK0/K9tpoM53pGDT5ZTMwARpUR
         LU2Tk9ItbUqrCktr5iaawyTGlLiXimfi1BhEWlMGjO0yWf2zgspD/o+zDhLye9Sjxl
         bSutzpZuhRBhhUmxv0jhILnXe9zXw8ymp6anSPqwxNC4omM+DsD/o05e30Y2M76OZG
         WvtArhGjqoy6Q==
Message-ID: <720c476189552596cbd61dd74d6fa12818718036.camel@collabora.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Mon, 21 Aug 2023 11:13:44 -0400
In-Reply-To: <ZNaVQ-zxIuCpGGha@aptenodytes>
References: <ZK2NiQd1KnraAr20@aptenodytes> <ZNTp1e4gJ2zeYmS-@aptenodytes>
         <a2e8e01ea754232dd3562b34702b6600d7358605.camel@collabora.com>
         <ZNaVQ-zxIuCpGGha@aptenodytes>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

I've been away last week.

Le vendredi 11 ao=C3=BBt 2023 =C3=A0 22:08 +0200, Paul Kocialkowski a =C3=
=A9crit=C2=A0:
> Hi Nicolas,
>=20
> On Thu 10 Aug 23, 10:34, Nicolas Dufresne wrote:
> > Le jeudi 10 ao=C3=BBt 2023 =C3=A0 15:44 +0200, Paul Kocialkowski a =C3=
=A9crit=C2=A0:
> > > Hi folks,
> > >=20
> > > On Tue 11 Jul 23, 19:12, Paul Kocialkowski wrote:
> > > > I am now working on a H.264 encoder driver for Allwinner platforms =
(currently
> > > > focusing on the V3/V3s), which already provides some usable bitstre=
am and will
> > > > be published soon.
> > >=20
> > > So I wanted to shared an update on my side since I've been making pro=
gress on
> > > the H.264 encoding work for Allwinner platforms. At this point the co=
de supports
> > > IDR, I and P frames, with a single reference. It also supports GOP (b=
oth closed
> > > and open with IDR or I frame interval and explicit keyframe request) =
but uses
> > > QP controls and does not yet provide rate control. I hope to be able =
to
> > > implement rate-control before we can make a first public release of t=
he code.
> >=20
> > Just a reminder that we will code review the API first, the supporting
> > implementation will just be companion. So in this context, the sooner t=
he better
> > for an RFC here.
>=20
> I definitely want to have some proposal that is (even vaguely) agreed upo=
n
> before proposing patches for mainline, even at the stage of RFC.
>=20
> While I already have working results at this point, the API that is used =
is
> very basic and just reuses controls from stateful encoders, with no extra
> addition. Various assumptions are made in the kernel and there is no real
> reference management, since the previous frame is always expected to be u=
sed
> as the only reference.

One thing we are looking at these days, and aren't current controllable in
stateful interface is RTP RPSI (reference picture selection indication). Th=
is is
feedback that a remote decoder sends when a reference picture has been deco=
ded.
In short, even if only 1 reference is used, we'd like the reference to chan=
ge
only when we received the acknowledgement that the new one has been
reconstructed on the other side.

I'm not super keep in having to modify the Linux kernel specially for this
feature. Specially that similar API offer it at a lower level (VA, D3D12, a=
nd
probably future API).

>=20
> We plan to make a public release at some point in the near future which s=
hows
> these working results, but it will not be a base for our discussion here =
yet.
>=20
> > > One of the main topics of concern now is how reference frames should =
be managed
> > > and how it should interact with kernel-side GOP management and rate c=
ontrol.
> >=20
> > Maybe we need to have a discussion about kernel side GOP management fir=
st ?
> > While I think kernel side rate control is un-avoidable, I don't think s=
tateless
> > encoder should have kernel side GOP management.
>=20
> I don't have strong opinions about this. The rationale for my proposal is=
 that
> kernel-side rate control will be quite difficult to operate without knowl=
edge
> of the period at which intra/inter frames are produced. Maybe there are k=
nown
> methods to handle this, but I have the impression that most rate control
> implementations use the GOP size as a parameter.
>=20
> More generally I think an expectation behind rate control is to be able t=
o
> decide at which time a specific frame type is produced. This is not possi=
ble if
> the decision is entirely up to userspace.

In Television (and Youtube) streaming, the GOP size is just fixed, and you =
deal
with it. In fact, I never seen GOP or picture pattern being modified by the=
 rate
control. In general, the high end rate controls will follow an HRD
specification. The rate controls will require information that represent
constraints, this is not limited to the rate. In H.264/HEVC, the level and
profile will play a role. But you could also add the VBV size and probably =
more.
I have never read the HRD specification completely.

In cable streaming notably, the RC job is to monitor the about of bits over=
 a
period of time (the window). This window is defined by the streaming hardwa=
re
buffering capabilities. Best at this point is to start reading through HRD
specifications, and open source rate control implementation (notably x264).

I think overall, we can live with adding hints were needed, and if the gop
information is appropriate hint, then we can just reuse the existing contro=
l.

>=20
> > > Leaving GOP management to the kernel-side implies having it decide wh=
ich frame
> > > should be IDR, I or P (and B for encoders that can support it), while=
 keeping
> > > the possibility to request a keyframe (IDR) and configure GOP size. N=
ow it seems
> > > to me that this is already a good balance between giving userspace a =
decent
> > > level of control while not having to specify the frame type explicitl=
y for each
> > > frame or maintain a GOP in userspace.
> >=20
> > My expectation for stateless encoder is to have to specify the frame ty=
pe and
> > the associate references if the type requires it.

Ack. For us, this is also why we would require requests (unlike statful
encoder), as we have per frame information to carry, and requests explicitl=
y
attach the information to the frame.

> >=20
> > >=20
> > > Requesting the frame type explicitly seems more fragile as many situa=
tions will
> > > be invalid (e.g. requesting a P frame at the beginning of the stream,=
 etc) and
> > > it generally requires userspace to know a lot about what the codec as=
sumptions
> > > are. Also for B frames the decision would need to be consistent with =
the fact
> > > that a following frame (in display order) would need to be submitted =
earlier
> > > than the current frame and inform the kernel so that the picture orde=
r count
> > > (display order indication) can be maintained. This is not impossible =
or out of
> > > reach, but it brings a lot of complexity for little advantage.
> >=20
> > We have had a lot more consistent results over the last decade with sta=
teless
> > hardware codecs in contrast to stateful where we endup with wide variat=
ion in
> > behaviour. This applies to Chromium, GStreamer and any active users of =
VA
> > encoders really. I'm strongly in favour for stateless reference API out=
 of the
> > Linux kernel.
>=20
> Okay I understand the lower level of control make it possible to get much=
 better
> results than opaque firmware-driven encoders and it would be a shame to n=
ot
> leverage this possibility with an API that is too restrictive.
>=20
> However I do think it should be possible to operate the encoder without a=
 lot
> of codec-specific supporting code from userspace. This is also why I like=
 having
> kernel-side rate control (among other reasons).

Ack. We need a compromise here.


[...]

>=20
> > > The next topic of interest is reference management. It seems pretty c=
lear that
> > > the decision of whether a frame should be a reference or not always n=
eeds to be
> > > taken when encoding that frame. In H.264 the nal_ref_idc slice header=
 element
> > > indicates whether a frame is marked as reference or not. IDR frames c=
an
> > > additionally be marked as long-term reference (if I understood correc=
tly, the
> > > frame will stay in the reference picture list until the next IDR fram=
e).
> >=20
> > This is incorrect. Any frames can be marked as long term reference, it =
does not
> > matter what type they are. From what I recall, marking of the long term=
 in the
> > bitstream is using a explicit IDX, so there is no specific rules on whi=
ch one
> > get evicted. Long term of course are limited as they occupy space in th=
e DPB.=20
> > Also, Each CODEC have different DPB semantic. For H.264, the DPB can ru=
n in two
> > modes. The first is a simple fifo, in this case, any frame you encode a=
nd want
> > to keep as reference is pushed into the DPB (which has a fixed size min=
us the
> > long term). If full, the oldest frame is removed. It is not bound to ID=
R or GOP.
> > Though, an IDR will implicitly cause the decoder to evict everything (i=
ncluding
> > long term).
> >=20
> > The second mode uses the memory management commands. This is a series i=
f
> > instruction that the encoder can send to the decoder. The specification=
 is quite
> > complex, it is a common source of bugs in decoders and a place were sta=
teless
> > hardware codecs performs more consistently in general. Through the comm=
ands, the
> > encoder ensure that the decoder dpb representation stay on sync.
>=20
> This is also what I understand from repeated reading of the spec and than=
ks for
> the summary write-up!
>=20
> My assumption was that it would be preferable to operate in the simple fi=
fo
> mode since the memory management commands need to be added to the bitstre=
am
> headers and require coordination from the kernel. Like you said it seems =
complex
> and error-prone.
>=20
> But maybe this mechanism could be used to allow any particular reference =
frame
> configuration, opening the way for userspace to fully decide what the ref=
erence
> buffer lists are? Also it would be good to know if such mechanisms are ge=
nerally
> present in codecs or if most of them have an implicit reference list that=
 cannot
> be modified.

Of course, the subject is much more relevant when there is encoders with mo=
re
then 1 reference. But you are correct, what the commands do, is allow to ch=
ange,
add or remove any reference from the list (random modification), as long as=
 they
fit in the codec contraints (like the DPB size notably). This is the only w=
ay
one can implement temporal SVC reference pattern, robust reference trees or=
 RTP
RPSI. Note that long term reference also exists, and are less complex then =
these
commands.

I this raises a big question, and I never checked how this worked with let'=
s say
VA. Shall we let the driver resolve the changes into commands (VP8 have
something similar, while VP9 and AV1 are refresh flags, which are just triv=
ial
to compute). I believe I'll have to investigate this further.

> >=20
[...]

> > > Addition information gathered:
> > > - It seems likely that the Allwinner Video Engine only supports one r=
eference
> > >   frame. There's a register for specifying the rec buffer of a second=
 one but
> > >   I have never seen the proprietary blob use it. It might be as easy =
as
> > >   specifying a non-zero address there but it might also be ignored or=
 require
> > >   some undocumented bit to use more than one reference. I haven't mad=
e any
> > >   attempt at using it yet.
> >=20
> > There is something in that fact that makes me think of Hantro H1. Hantr=
o H1 also
> > have a second reference, but non one ever use it. We have on our todo t=
o
> > actually give this a look.
>=20
> Having looked at both register layouts, I would tend to think both design=
s
> are distinct. It's still unclear where Allwinner's video engine comes fro=
m:
> perhaps they made it in-house, perhaps some obscure Chinese design house =
made it
> for them or it could be known hardware with a modified register layout.

Ack,
>=20
> I would also be interested to know if the H1 can do more than one referen=
ce!

From what we have in our pretty thin documentation, references are being
"searched" for fuzzy match and motion. So when you pass 2 references to the
encoder, then the encoder will search equally in both. I suspect it does a =
lot
more then that, and saves some information in the auxiliary buffers that ex=
ist
per reference, but this isn't documented and I'm not specialized enough rea=
lly.

From usage perspective, all you have to do is give it access to the referen=
ces
picture data (reconstructed image and auxiliary data). The result is compre=
ssed
macroblock data that may refer to these. We don't really know if it is used=
, but
we do assume it is and place it in the reference list. This is of course no=
rmal
thing to do, specially when using a reference fifo.

In theory, you could implement multiple reference with a HW that only suppo=
rts
1. A technique could be to compress the image multiple time, and keep the "=
best"
one for the current configuration. Though, a proper multi-pass encoder woul=
d
avoid the bandwidth overhead of compressing and writing the temporary resul=
t.

>=20
> > > - Contrary to what I said after Andrzej's talk at EOSS, most Allwinne=
r platforms
> > >   do not support VP8 encode (despite Allwinner's proprietary blob hav=
ing an
> > >   API for it). The only platform that advertises it is the A80 and th=
is might
> > >   actually be a VP8-only Hantro H1. It seems that the API they develo=
ped in the
> > >   library stuck around even if no other platform can use it.
> >=20
> > Thanks for letting us know. Our assumption is that a second hardware de=
sign is
> > unlikely as Google was giving it for free to any hardware makers that w=
anted it.
> >=20
> > >=20
> > > Sorry for the long email again, I'm trying to be a bit more explanato=
ry than
> > > just giving some bare conclusions that I drew on my own.
> > >=20
> > > What do you think about these ideas?
> >=20
> > In general, we diverge on the direction we want the interface to be. Wh=
at you
> > seem to describe now is just a normal stateful encoder interface with e=
verything
> > needed to drive the stateless hardware implemented in the Linux kernel.=
 There is
> > no parsing or other unsafety in encoders, so I don't have a strict no-g=
o
> > argument for that, but for me, it means much more complex drivers and l=
esser
> > flexibility. The VA model have been working great for us in the past, g=
iving us
> > the ability to implement new feature, or even slightly of spec features=
. While,
> > the Linux kernel might not be the right place for these experimental me=
thods.
>=20
> VA seems too low-level for our case here, as it seems to expect full cont=
rol
> over more or less each bitstream parameter that will be produced.
>=20
> I think we have to find some middle-ground that is not as limiting as sta=
teful
> encoders but not as low-level as VA.
>=20
> > Personally, I would rather discuss around your uAPI RFC though, I think=
 a lot of
> > other devs here would like to see what you have drafted.
>=20
> Hehe I wish I had some advanced proposal here but my implementation is qu=
ite
> simplified compared to what we have to plan for mainline.

No worries, let's do that later then. On our side, we have similar limitati=
on,
since we have to have something working before we can spend more time in tu=
rning
it into something upstream. So we have "something" for VP8, we'll do "somet=
hing"
for H.264, from there we should be able to iterate. But having the opportun=
ity
to iterate over a more capable hardware would clearly help understand the b=
igger
picture.

cheers,
Nicolas
