Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DEB79D44C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbjILPFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbjILPFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:05:41 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4650112E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:05:37 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-770ef4d36f2so228725785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1694531136; x=1695135936; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vM3oyGRFxtHxm1neHgA67Osk9iJA5NE4DNejEYZfvZ8=;
        b=bCskFdpgHM/CSy0ZSLzi0ZaVLCc6R02F7zfxu1ulgQ4Gg34Xsjx+sguK855gCPRPAS
         5y1yU0Qwfc6/NxxYS566OBijR4WiesaFPyUJK3hXcoTppT40C4yi50xnfTJKdfFUHsMA
         7xR+2P7U2DHyJ6B+5LPtNyK1seerXwe61yGxkFjfVwhT6vWooQDNFoNyBqISh4E9iQF/
         +nZcFH9cIwj5hr6lONW4p7KUOZajr6Jmt/y8jGZ5SZgXt8Fc/3KqTcKsvwW9RU6rjTFj
         C0Hx+flROkQpnZTY5Y68ptpw3EEauPLyxugDnm56MhuLj2Ei2QR6UVOoLO0zgfwy9KBB
         MDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694531136; x=1695135936;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vM3oyGRFxtHxm1neHgA67Osk9iJA5NE4DNejEYZfvZ8=;
        b=rcIpf18akEWCnDx/Z5iVHOGDkuFa7UIsqqyg5zei0+iQIQIRj/8kreZCCIYc7OJ/Qd
         m/gsvYM1OuWx0VbzI6It7TbI4VH/eXOy5IwzO+VcJS01UgjhGbaTn+5FePASXivspVyX
         IPOfUNo2GgXhbO3e0L34pIyWPNx4fKdZA1Z0etcc/wk12rN6Pmwfl0nYv6DZSdr6Z3Y/
         j7z6VzjEZi15B9g6SHmSNPJrQGuS9REslBsCgxwrgZ1pewHhkeXpci/FysiwrVfBMebu
         7PQhGesNOiF2B97KWps/5UY3hbLbmxpTSGtlLG4l9rIHYevVk3iwHcDj+nczQLUMPA7h
         l/uw==
X-Gm-Message-State: AOJu0Yyf02dUFWxgYd1aOM4Zysf1dQz9HMHRIPOB7QoKkRJS/VebNW3p
        RlLqeOAIQu0GYmugrTphMbFOiQ==
X-Google-Smtp-Source: AGHT+IETEyxKiwuQg/hyiHZWR8ejsoB5rvNcCqFck37LlPZlL1+L6Aam0BaJ+MZGh5Xo6lDDiukNdA==
X-Received: by 2002:a05:620a:454c:b0:76c:aff9:9f27 with SMTP id u12-20020a05620a454c00b0076caff99f27mr17152733qkp.59.1694531136409;
        Tue, 12 Sep 2023 08:05:36 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:bae9::7a9])
        by smtp.gmail.com with ESMTPSA id s41-20020a05622a1aa900b004053bcffe49sm3380085qtc.9.2023.09.12.08.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:05:36 -0700 (PDT)
Message-ID: <d15067b12571f8868925aace9dc84473cd74ec1f.camel@ndufresne.ca>
Subject: Re: [PATCH 3/9] dma-heap: Provide accessors so that in-kernel
 drivers can allocate dmabufs from specific heaps
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Yong Wu =?UTF-8?Q?=28=E5=90=B4=E5=8B=87=29?= 
        <Yong.Wu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jstultz@google.com" <jstultz@google.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jianjiao Zeng =?UTF-8?Q?=28=E6=9B=BE=E5=81=A5=E5=A7=A3=29?= 
        <Jianjiao.Zeng@mediatek.com>,
        Kuohong Wang =?UTF-8?Q?=28=E7=8E=8B=E5=9C=8B=E9=B4=BB=29?= 
        <kuohong.wang@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Brian.Starkey@arm.com" <Brian.Starkey@arm.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Date:   Tue, 12 Sep 2023 11:05:35 -0400
In-Reply-To: <8e795311ff93c7a336eb688818f055c5c569741e.camel@mediatek.com>
References: <20230911023038.30649-1-yong.wu@mediatek.com>
         <20230911023038.30649-4-yong.wu@mediatek.com>
         <827b859e3ff8176ef0b18c29bc17481b4105e368.camel@ndufresne.ca>
         <8e795311ff93c7a336eb688818f055c5c569741e.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 12 septembre 2023 =C3=A0 08:47 +0000, Yong Wu (=E5=90=B4=E5=8B=87)=
 a =C3=A9crit=C2=A0:
> On Mon, 2023-09-11 at 12:12 -0400, Nicolas Dufresne wrote:
> >  	=20
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Hi,
> >=20
> > Le lundi 11 septembre 2023 =C3=A0 10:30 +0800, Yong Wu a =C3=A9crit :
> > > From: John Stultz <jstultz@google.com>
> > >=20
> > > This allows drivers who don't want to create their own
> > > DMA-BUF exporter to be able to allocate DMA-BUFs directly
> > > from existing DMA-BUF Heaps.
> > >=20
> > > There is some concern that the premise of DMA-BUF heaps is
> > > that userland knows better about what type of heap memory
> > > is needed for a pipeline, so it would likely be best for
> > > drivers to import and fill DMA-BUFs allocated by userland
> > > instead of allocating one themselves, but this is still
> > > up for debate.
> >=20
> >=20
> > Would be nice for the reviewers to provide the information about the
> > user of
> > this new in-kernel API. I noticed it because I was CCed, but
> > strangely it didn't
> > make it to the mailing list yet and its not clear in the cover what
> > this is used
> > with.=20
> >=20
> > I can explain in my words though, my read is that this is used to
> > allocate both
> > user visible and driver internal memory segments in MTK VCODEC
> > driver.
> >=20
> > I'm somewhat concerned that DMABuf objects are used to abstract
> > secure memory
> > allocation from tee. For framebuffers that are going to be exported
> > and shared
> > its probably fair use, but it seems that internal shared memory and
> > codec
> > specific reference buffers also endup with a dmabuf fd (often called
> > a secure fd
> > in the v4l2 patchset) for data that is not being shared, and requires
> > a 1:1
> > mapping to a tee handle anyway. Is that the design we'd like to
> > follow ?=20
>=20
> Yes. basically this is right.
>=20
> > Can't
> > we directly allocate from the tee, adding needed helper to make this
> > as simple
> > as allocating from a HEAP ?
>=20
> If this happens, the memory will always be inside TEE. Here we create a
> new _CMA heap, it will cma_alloc/free dynamically. Reserve it before
> SVP start, and release to kernel after SVP done.

Ok, I see the benefit of having a common driver then. It would add to the
complexity, but having a driver for the tee allocator and v4l2/heaps would =
be
another option?

>  =20
> Secondly. the v4l2/drm has the mature driver control flow, like
> drm_gem_prime_import_dev that always use dma_buf ops. So we can use the
> current flow as much as possible without having to re-plan a flow in
> the TEE.

From what I've read from Yunfei series, this is only partially true for V4L=
2.
The vb2 queue MMAP feature have dmabuf exportation as optional, but its not=
 a
problem to always back it up with a dmabuf object. But for internal SHM buf=
fers
used for firmware communication, I've never seen any driver use a DMABuf.

Same applies for primary decode buffers when frame buffer compression or po=
st-
processing it used (or reconstruction buffer in encoders), these are not us=
er
visible and are usually not DMABuf.

>=20
> >=20
> > Nicolas
> >=20
> > >=20
> > > Signed-off-by: John Stultz <jstultz@google.com>
> > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > [Yong: Fix the checkpatch alignment warning]
> > > ---
> > >  drivers/dma-buf/dma-heap.c | 60 ++++++++++++++++++++++++++++----
> > ------
> > >  include/linux/dma-heap.h   | 25 ++++++++++++++++
> > >  2 files changed, 69 insertions(+), 16 deletions(-)
> > >=20
> [snip]

