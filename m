Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2477C78D840
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjH3S35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245486AbjH3PTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:19:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92DAE8;
        Wed, 30 Aug 2023 08:19:03 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7C8EB66071BE;
        Wed, 30 Aug 2023 16:19:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693408742;
        bh=zp4dOKYj5P2tbc9SOBi3zKYc8MACLC/blDAk7LSJAeU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ixeFWC8byNhVcaT8civxVnZbjC3jmIwMDdi5VCHpDwpEJ3oRDENR8qLz5DeCOhFOs
         Lp1mFL2VzQ99Hw+ATRij+Ne41vFsV9nFpeHcEKzDD0I5cKTzWtbC1hc9Gzljrwemta
         JR0hc2u/GJaJ1bozL7o8xH4fcHYe1OszsVpAZDSiO9tx/XwOqWbfTDtI6nuLttR6PY
         oY494YhspwrH8KFmb+HjeKHFF0CrU5logWvPI9kbaTckVsBrjr7/aciPgESqu0+kZJ
         zwO9o3sRf9DcFcz27ZXaeCXbu/UN6ptg6zyuccJnyom0OjURDwbN3IlVrr+l1aNj+p
         nkz2AZFeQCqiA==
Message-ID: <e5b416f54fb18363c88813ab3240e6f9c48081f9.camel@collabora.com>
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
Date:   Wed, 30 Aug 2023 11:18:52 -0400
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
> > It was suggested so far to leave h264 slice headers writing to the driv=
er. This
> > is motivated by H264 slice header not being byte aligned in size, so th=
e
> H.264, H.265 has the byte_alignment() in nalu. You don't need skip bits=
=20
> feature which could be found in H1.

As you said so, I rechecked the H.264 grammar.

...
  slice_header( )
  slice_data( )
...

There is lot of variable size items in the slice_header() syntax and no pad=
ding
bits. And no padding at the start of any of the slice_data types. So no, th=
e
slice_header() syntax in H.264 is not byte aligned like you are claiming he=
re.
Its important to be super accurate about these things, as it will cause err=
ors
to be made. Please always double check.

Nicolas
