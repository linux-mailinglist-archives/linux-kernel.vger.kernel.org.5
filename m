Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597EC765996
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjG0RLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjG0RLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:11:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7BC30E3;
        Thu, 27 Jul 2023 10:11:00 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:580::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB2A666015A0;
        Thu, 27 Jul 2023 18:10:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690477858;
        bh=E2DEXdpIOFGoKjwDPsij+hvboO8PwGO9KDMyYSS8/g8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PO2HdFdaDesVZug0aiSrvrGIcYwCWh0/En+KEJmYoLDvpbf3y5clLKeL7Qx9leBy4
         SvmCFI2bqj0dUTPWpxWoOI7N5a7ed+DUHs1igWV+rVHtyzrZ9OlxKPJzBKCBgzlXdB
         WkTitGe2C0HzOy1B1dHDm4W/PL6YmfOnIID1VCWZ2SYCUYUCo820L2krj2z18mQ6Ga
         OdBGNJHUSWtvmRZk16cveAszn809lMB/unrCyFDDY2+HRtRf3dFkVy/OpEGxM024pY
         oIKP16WG/UyofGetUUb1mel9zsTkKSyGq5IDWHNNm+hSAnuphkCf2S85utev9dYYT3
         K6rMPkvvzE8JQ==
Message-ID: <8f0fbb7c3c18c211b4d407dc1b45539a1ce41766.camel@collabora.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Thu, 27 Jul 2023 13:10:47 -0400
In-Reply-To: <b2d75cf6-2e57-65ab-ebf1-caaa17f479e0@synaptics.com>
References: <ZK2NiQd1KnraAr20@aptenodytes>
         <c46d0c53b7e5dc8dcdf7925f3d892024390a8b2b.camel@collabora.com>
         <ZK6zjaJtulRSrn7P@aptenodytes>
         <bbd62e1b-dd0b-e351-110e-040b42d02974@synaptics.com>
         <ZL-8yBhWWChKBDHM@aptenodytes>
         <c15805b0-261b-114a-c29d-b63f00dd8da4@synaptics.com>
         <87cfcdfadee89984496c3f52d01b4f1e10c12cae.camel@collabora.com>
         <b2d75cf6-2e57-65ab-ebf1-caaa17f479e0@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 27 juillet 2023 =C3=A0 10:45 +0800, Hsia-Jun Li a =C3=A9crit=C2=A0=
:
>=20
> On 7/27/23 03:53, Nicolas Dufresne wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >=20
> >=20
> > Hi,
> >=20
> > Le mercredi 26 juillet 2023 =C3=A0 10:49 +0800, Hsia-Jun Li a =C3=A9cri=
t :
> > > > I am strongly against this approach, instead I think we need to kee=
p all
> > > > vendor-specific parts in the kernel driver and provide a clean unif=
ied userspace
> > > > API.
> > > >=20
> > > We are driving away vendor participation. Besides, the current design=
 is
> > > a performance bottleneck.
> >=20
> >=20

. . .=20

> Or we just define an interface that only FOSS would use.

We explicitly favour FOSS and make API that guaranty you can use the driver=
 with
FOSS. This is not something we do in secret, this is fundamental to being a=
 GPL
project. On DRM side, were the API is a lot more flexible, they explicitly
reject drivers without an actual FOSS user. We don't strictly have to do th=
at in
V4L2, because the API is done at a higher level. But if we were to come up =
with
a lower level abstraction, we'd certainly have this rules.

. . .
>=20

>=20
> Please DO ***NOT*** make a standard that occupied many memory behinds=20
> usersace and a standard that user has to handle the reconstruction=20
> buffer holding with a strange mechanism(I mean reconstruction buffer=20
> lifetime would be manged by userspace manually).

In all fairness, people have limited time, and builds on top of existing
infrastructure. The reason reconstruction buffers won't be exposed is reall=
y
simple to understand. We don't have API in current framework to support all=
 the
allocations happening in codec drivers. If we could not progress without th=
at,
I've sure finding solution would become a priority. But the trith is that w=
e can
live without, and are aiming to move forward without.

We can certainly start a thread on the subject, I even have plenty of ideas=
 how
to introduce these without throwing away all the existing stuff. But only i=
f
there is a clear intention to actually implement it. We have plenty on our =
plate
and exposing reconstruction buffers can certainly wait.

regards,
Nicolas
>=20
