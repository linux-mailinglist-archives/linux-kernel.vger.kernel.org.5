Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA7675D134
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGUST7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGUST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:19:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB672D6D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:19:55 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qMujJ-0007bY-Td; Fri, 21 Jul 2023 20:19:53 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qMujH-0002AX-8H; Fri, 21 Jul 2023 20:19:51 +0200
Date:   Fri, 21 Jul 2023 20:19:51 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jernej =?iso-8859-15?Q?=A6krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Message-ID: <20230721181951.GL12001@pengutronix.de>
References: <ZK2NiQd1KnraAr20@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
Content-Disposition: inline
In-Reply-To: <ZK2NiQd1KnraAr20@aptenodytes>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everyone!

Just to let you know. I have just pushed a Branch that includes some first
steps to make the h264-stateless encoder working in Gstreamer. The work is
based on the VP8 Stateless Encoder patches Benjamin Gaignard created.

https://gitlab.freedesktop.org/mgrzeschik/gstreamer/-/commits/1.22/topic/h2=
64-stateless-encoder

The codec this is used with, is the rkvenc that can be found on rockchip
rk3568. I will send an RFC driver for that in the next weeks after my vacat=
ion.

On Tue, Jul 11, 2023 at 07:12:41PM +0200, Paul Kocialkowski wrote:
>After various discussions following Andrzej's talk at EOSS, feedback from =
the
>Media Summit (which I could not attend unfortunately) and various direct
>discussions, I have compiled some thoughts and ideas about stateless encod=
ers
>support with various proposals. This is the result of a few years of inter=
est
>in the topic, after working on a PoC for the Hantro H1 using the hantro dr=
iver,
>which turned out to have numerous design issues.
>
>I am now working on a H.264 encoder driver for Allwinner platforms (curren=
tly
>focusing on the V3/V3s), which already provides some usable bitstream and =
will
>be published soon.
>
>This is a very long email where I've tried to split things into distinct t=
opics
>and explain a few concepts to make sure everyone is on the same page.
>
># Bitstream Headers
>
>Stateless encoders typically do not generate all the bitstream headers and
>sometimes no header at all (e.g. Allwinner encoder does not even produce s=
lice
>headers). There's often some hardware block that makes bit-level writing t=
o the
>destination buffer easier (deals with alignment, etc).
>
>The values of the bitstream headers must be in line with how the compressed
>data bitstream is generated and generally follow the codec specification.
>Some encoders might allow configuring all the fields found in the headers,
>others may only allow configuring a few or have specific constraints regar=
ding
>which values are allowed.
>
>As a result, we cannot expect that any given encoder is able to produce fr=
ames
>for any set of headers. Reporting related constraints and limitations (bey=
ond
>profile/level) seems quite difficult and error-prone.
>
>So it seems that keeping header generation in-kernel only (close to where =
the
>hardware is actually configured) is the safest approach.

For the case with the rkvenc, the headers are also not created by the
kernel driver. Instead we use the gst_h264_bit_writer_sps/pps functions
that are part of the codecparsers module.

># Codec Features
>
>Codecs have many variable features that can be enabled or not and specific
>configuration fields that can take various values. There is usually some
>top-level indication of profile/level that restricts what can be used.
>
>This is a very similar situation to stateful encoding, where codec-specific
>controls are used to report and set profile/level and configure these aspe=
cts.
>A particularly nice thing about it is that we can reuse these existing con=
trols
>and add new ones in the future for features that are not yet covered.
>
>This approach feels more flexible than designing new structures with a sel=
ected
>set of parameters (that could match the existing controls) for each codec.

I back the Idea of generic profiles instead of explicit configuration
=66rom the usersapace point of view.

The parameterization works like this:

Read the sane default parameter set from the driver.
Modify the parameters based on the userspace decisions.
 - (currently hardcoded and not based on any user input)
Write the updated parameters back to the driver.

># Reference and Reconstruction Management
<snip>

># Frame Types
<snip>

># Rate Control
<snip>

># Regions of Interest
<snip>

Since the first shot of the rkvenc is I-Frame only code, these other topics=
 are
currently undefined and unimplemented in the Gstreamer stack.


Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmS6zEQACgkQC+njFXoe
LGTPfQ/+PmQ8Lvg2djfpwtS7LxFWLLcSURknZAUaxzfZ33D6DjikuhpISojkKcX8
mQ9Maq0mkyvQJUGWCpnB/28k2360UV2V3n7x16E9ZjUoQhj4WL0k+1H5aL/74rRw
GnOBvEK6KwI09BsDhb+ozMYhbW8TIp3FYpTj8lZBtjrcyqkiioDwcCOqQBZB+NwG
TJbBUkG59O0F9BXFNfR/QDF0eJnKE5CpkNVlSkKUPR9tRpmwt+lVvxXBv2fo7g9g
dFWLKlzUZ1qxEQY3ZVrBQd7JZ4jBrREHlsJx2Wj22AI1gCrYpnA3aknRcs8BfdZc
BnRj7FZ893OoVJlFbRqP4w8PVnNasxOAiuu5njOnl/3lpjlh7A2l286qaEw863V0
jMNQSUI2KQS5vvpWZ7f+4j1obwKr/1hS1Y6HBoFwES9BgIFegAcq+dYZaUOxZQk5
Fx/zGG+3Uldx6NOsOIzV46cHLbmFVZ8v68zlB8FFZkdqeP93xdTAD/DUEpNnQ19B
Pvm1kKM4nTZIDGLDFJOxF4xiHu8oOypKfeFksXdjqDp4CvQDuYnf0fsEff3rAAUN
MwL4pTWm1R2aLNq9FcXJ7mX/1H+bkCV2R5mPd0yllFArV/xF3nNRspEuvn8BWzn3
knSPOepvZ89dsFcJdduTabzypDDYtGiCwMd/Wf1G9ZUsb2l/Z9s=
=7cn6
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--
