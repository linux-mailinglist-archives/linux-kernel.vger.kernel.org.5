Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8679F04A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjIMRSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjIMRSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:18:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E111BE3;
        Wed, 13 Sep 2023 10:18:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 918336607334;
        Wed, 13 Sep 2023 18:18:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694625481;
        bh=qkQc0xPkJZv4MQDkYeq0TPKFPY0tuZwz54peEXg8Lxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mQHUyJ8sPtv2kQ3oCun3pRUeCO1BT6ite9Mp5p1x3f6RUWGGTN+L+NIhLEQyjwd7h
         vIp1ISlItO1EfT60aPYOXLfXDtVuYUg+4dQ/Fl2KZTwuv7tv2lIF8KBttczEUhk2zw
         8+RD462sEzN1RN9mKuoZ3BnBf0QYnRYP6XcNpzQbkEJ4cD1/k/JJXIdesj1BTJKRsD
         y1ysYJNIZ1YfmHHRf/rvec4Q6glIpVft1UN7vTv5dmnSTjHd7fuXmDAfHw3HjFJ5uc
         F/Tn9HGehmvgLpwVmjUqgVruXFj/wToU9vdP11MRSlyTzs5Fthgu/8HhqlVEl6Lylc
         Q79mfzKTllSVQ==
Date:   Wed, 13 Sep 2023 19:17:57 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com,
        freedreno@lists.freedesktop.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: Re: [PATCH v4 6/6] drm/drm-file: Show finer-grained BO sizes in
 drm_show_memory_stats
Message-ID: <20230913191757.6594f8c8@collabora.com>
In-Reply-To: <CAF6AEGu+NeMfeP3yVLr76fUmXeWPx86D9ckw_WjXu+Xpn6DJvA@mail.gmail.com>
References: <20230912084044.955864-1-adrian.larumbe@collabora.com>
        <20230912084044.955864-7-adrian.larumbe@collabora.com>
        <20230912113210.65897aab@collabora.com>
        <CAF6AEGtzOS89V1vbobpSEb9KX8x9T0FfmkW2OAaxAKLs+GugKA@mail.gmail.com>
        <CAF6AEGup93tQMYrmx6iKex2Fxz+Yu5m-MMWPmeOQ4yx_Racnag@mail.gmail.com>
        <20230913093637.2748d217@collabora.com>
        <CAF6AEGu+NeMfeP3yVLr76fUmXeWPx86D9ckw_WjXu+Xpn6DJvA@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 09:46:45 -0700
Rob Clark <robdclark@gmail.com> wrote:

> On Wed, Sep 13, 2023 at 12:36=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Tue, 12 Sep 2023 19:14:35 -0700
> > Rob Clark <robdclark@gmail.com> wrote:
> > =20
> > > On Tue, Sep 12, 2023 at 6:46=E2=80=AFPM Rob Clark <robdclark@gmail.co=
m> wrote: =20
> > > >
> > > > On Tue, Sep 12, 2023 at 2:32=E2=80=AFAM Boris Brezillon
> > > > <boris.brezillon@collabora.com> wrote: =20
> > > > >
> > > > > On Tue, 12 Sep 2023 09:37:00 +0100
> > > > > Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> > > > > =20
> > > > > > The current implementation will try to pick the highest availab=
le size
> > > > > > display unit as soon as the BO size exceeds that of the previous
> > > > > > multiplier. That can lead to loss of precision in BO's whose si=
ze is
> > > > > > not a multiple of a MiB.
> > > > > >
> > > > > > Fix it by changing the unit selection criteria.
> > > > > >
> > > > > > For much bigger BO's, their size will naturally be aligned on s=
omething
> > > > > > bigger than a 4 KiB page, so in practice it is very unlikely th=
eir display
> > > > > > unit would default to KiB. =20
> > > > >
> > > > > Let's wait for Rob's opinion on this. =20
> > > >
> > > > This would mean that if you have SZ_1G + SZ_1K worth of buffers, yo=
u'd
> > > > report the result in KiB.. which seems like overkill to me, esp giv=
en
> > > > that the result is just a snapshot in time of a figure that
> > > > realistically is dynamic. =20
> >
> > Yeah, my point was that, generally, such big buffers tend to have
> > a bigger size alignment (like 2MB for anything bigger than 1GB), but
> > maybe this assumption doesn't stand for all drivers. =20
>=20
> Maybe for CMA?  Regardless, this # is the sum of buffer sizes, so you
> could still get that 1G+1K scenario

My bad, for some reason I had per-buffer size printing in mind.
