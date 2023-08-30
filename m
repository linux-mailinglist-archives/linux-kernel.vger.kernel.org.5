Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D6478E05F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbjH3TNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245328AbjH3PLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:11:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80214E8;
        Wed, 30 Aug 2023 08:11:03 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E13B566071BE;
        Wed, 30 Aug 2023 16:11:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693408262;
        bh=VnXf1LaCN72XTFXRU9tqw/+twmKCXDqgk1FTB/JX2wQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iWZwhEKAM2fxzFVH//VHX0A9ouso0+PgDThTmLUeC86oMtb/TeiMBJQaKk/zUqof0
         vlsHZozBjM6QXQK7Xruf6WaHlL9ijIspEsuPY/mvkBirK/OmhtC1JQmwSxqDMpbjT2
         pbQETIq3qzRLrjeSpRgHKPtpjjHur//skEbiNj8wmdEO8SBs6+9bCnwpVyfxRnhTRm
         qMNLIh38R44ySTG093OyIV0GgxNp/D/RFxjjzM32bfwM/E2L+c0nmAGasemml1Y4x8
         r+C81rHe16uMQo3Q0uRRKb6dn1NgPp6/HrcIEZPRgvz/VtdxYS1oC+XDCh7iUGCxO5
         NFi6S2zkqG3ug==
Message-ID: <4d08d98d853d78bbb6dba826d30c3386fe0b31e8.camel@collabora.com>
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
Date:   Wed, 30 Aug 2023 11:10:52 -0400
In-Reply-To: <52e9b710-5011-656b-aebf-8d57e6496ddd@synaptics.com>
References: <ZK2NiQd1KnraAr20@aptenodytes> <ZNTp1e4gJ2zeYmS-@aptenodytes>
         <a2e8e01ea754232dd3562b34702b6600d7358605.camel@collabora.com>
         <ZNaVQ-zxIuCpGGha@aptenodytes>
         <720c476189552596cbd61dd74d6fa12818718036.camel@collabora.com>
         <39270c5e-24ab-8ff6-d925-7718b1fef3c4@synaptics.com>
         <a0fa6559c3933a5a4c8b7502282adae3429e0b57.camel@collabora.com>
         <52e9b710-5011-656b-aebf-8d57e6496ddd@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 23 ao=C3=BBt 2023 =C3=A0 11:04 +0800, Hsia-Jun Li a =C3=A9crit=
=C2=A0:
> > Though, if we drop the GOP structure and favour this approach, the late=
ncy could
> > be regain later by introducing fence base streaming. The technique woul=
d be for
> > a video source (like a capture driver) to pass dmabuf that aren't fille=
d yet,
> > but have a companion fence. This would allow queuing requests ahead of =
time, and
> > all we need is enough pre-allocation to accommodate the desired look ah=
ead. Only
> > issue is that perhaps this violates the fundamental of "short term" del=
ivery of
> > fences. But fences can also fail I think, in case the capture was stopp=
ed.
> >=20
> I don't think it would help. Fence is a thing for DRM/GPU without a queue=
.
> Even with a fence, would the video sink tell us the motion delta here?

It helps with the latency since the encoder can start its search and analyz=
es as
soon as frames are available, instead of until you have all N frames availa=
ble
(refer to the MIN_BUFFER_FOR controls used when lookahead is needed).

> > We can certainly move forward with this as a future solution, or just d=
on't
> > implement future aware RC algorithm in term to avoid the huge task this=
 involves
> > (and possibly patents?)
> >=20
> I think we should not restrict how the userspace(vendor) operate the=20
> hardware.

Omitting is not restricting. Vendors have to learn to be community members =
and
propose/add the tools and APIs they need to support their features. We cann=
ot
fix vendors in this regard, those who jumps over that fence are wining.

Nicolas
