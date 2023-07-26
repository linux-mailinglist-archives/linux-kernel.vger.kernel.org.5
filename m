Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E1F763FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGZTyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjGZTyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:54:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCB21BF6;
        Wed, 26 Jul 2023 12:54:10 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:580::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B58D6606F8A;
        Wed, 26 Jul 2023 20:54:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690401248;
        bh=UcOrA8SIWWtnawAkOkr1I4M28Jmi8tXZddLqSw+V8JU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W16Q36YyNsYA97Y3EY732WUvNVXJ748CBu5KB/cdLIfH5F6Q1G8Bc6PeP4oxKqltI
         /lpeq/u1SIz5fyOGFl8fSWoEhxx8+V7Lsf3znDUt2wI+yAYhax8L/U3QjY4rmb3Xem
         O0i87ruJt2PcMrc1d77TEHQMxPatTKH0sxh+oDvLs/M3btjpPnBOpkOhESDZU+aNHb
         2rF+glV+kl9vH8K6E1iAMLXS1Xm1FRPv90dwOOnAJxia6GoTV/LG81L9O7KWp7LSpX
         tICoSuuayOeGaHhbjQDFFNCjLwE+2lijQ/Rx7d52iFy+Ntmr2epmkTvR7PyBSRG4kU
         1D3DdPoe7hXoQ==
Message-ID: <87cfcdfadee89984496c3f52d01b4f1e10c12cae.camel@collabora.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Wed, 26 Jul 2023 15:53:58 -0400
In-Reply-To: <c15805b0-261b-114a-c29d-b63f00dd8da4@synaptics.com>
References: <ZK2NiQd1KnraAr20@aptenodytes>
         <c46d0c53b7e5dc8dcdf7925f3d892024390a8b2b.camel@collabora.com>
         <ZK6zjaJtulRSrn7P@aptenodytes>
         <bbd62e1b-dd0b-e351-110e-040b42d02974@synaptics.com>
         <ZL-8yBhWWChKBDHM@aptenodytes>
         <c15805b0-261b-114a-c29d-b63f00dd8da4@synaptics.com>
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

Hi,

Le mercredi 26 juillet 2023 =C3=A0 10:49 +0800, Hsia-Jun Li a =C3=A9crit=C2=
=A0:
> > I am strongly against this approach, instead I think we need to keep al=
l
> > vendor-specific parts in the kernel driver and provide a clean unified =
userspace
> > API.
> >=20
> We are driving away vendor participation. Besides, the current design is=
=20
> a performance bottleneck.

I know you have been hammering this argument for many many years. But in
concrete situation, we have conducted tests, and we out perform vendors sta=
cks
that directly hit into hardware register with stateless CODEC. Also, Paul's
proposal, is that fine grain / highly close to metal tuning of the encoding
process should endup in the Linux kernel, so that it can benefit from the
natural hard real-time advantage of a hard IRQ. Just like anything else, we=
 will
find a lot of common methods and shareable code which will benefit in secur=
ity
and quality, which is very unlike what we normally get from per vendor BSP.=
 The
strategy is the same as everything else in Linux, vendor will adpot it if t=
here
is a clear benefit. And better quality, ease of use, good collection of mat=
ure
userspace software is what makes the difference. It does takes time of cour=
se.

regards,
Nicolas
