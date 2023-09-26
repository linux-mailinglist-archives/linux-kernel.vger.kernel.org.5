Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAFA7AE676
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjIZHLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZHLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:11:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B903AEB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:11:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A28776607313;
        Tue, 26 Sep 2023 08:11:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695712293;
        bh=Un9kNmibt/1LyNRx3dilYTDLfKHRNSrtYcTFTDYcqVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=izubzpAdJUmlqw799jWDhJJwlf44rQt8twSWJ7JGD6gmAbR0lsGYGZ+Wte/v0Q54c
         zNTE9YVhhw3sSa9DUuHDZ+O5e4UuZ9uRPjYMWoZDNhKz/caK/sAK7ggb7gIIs6VU3B
         yFJHRTNBtugS2K+RNTtxYSOdac2NG/W7kwMLyiI66eJW2jJSuFGD+LTb+M2I9wNEMq
         hi+2wAcXJ8pojhmqHY1yHpTndhNuQe6uVj+CQ0Vez2pbR35Sg2ueuG18L5CwBesRQ8
         9YsR8MpuMCbjSBb0INtNmhH2oo2M0LiMFp+MPQedfmdCLsXdGNGLxbStHcoq09Z46+
         sIytARsTNr70Q==
Date:   Tue, 26 Sep 2023 09:11:29 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com,
        faith.ekstrand@collabora.com, luben.tuikov@amd.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Donald Robson <Donald.Robson@imgtec.com>,
        Frank Binns <Frank.Binns@imgtec.com>,
        Sarah Walker <sarah.walker@imgtec.com>
Subject: Re: [PATCH drm-misc-next 1/3] drm/sched: implement dynamic job flow
 control
Message-ID: <20230926091129.2d7d7472@collabora.com>
In-Reply-To: <c6ec9ab4-d63b-0a72-4abf-682b94739877@amd.com>
References: <20230924224555.15595-1-dakr@redhat.com>
        <20230925145513.49abcc52@collabora.com>
        <c6ec9ab4-d63b-0a72-4abf-682b94739877@amd.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 19:55:21 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> Am 25.09.23 um 14:55 schrieb Boris Brezillon:
> > +The imagination team, who's probably interested too.
> >
> > On Mon, 25 Sep 2023 00:43:06 +0200
> > Danilo Krummrich <dakr@redhat.com> wrote:
> > =20
> >> Currently, job flow control is implemented simply by limiting the amou=
nt
> >> of jobs in flight. Therefore, a scheduler is initialized with a
> >> submission limit that corresponds to a certain amount of jobs.
> >>
> >> This implies that for each job drivers need to account for the maximum
> >> job size possible in order to not overflow the ring buffer.
> >>
> >> However, there are drivers, such as Nouveau, where the job size has a
> >> rather large range. For such drivers it can easily happen that job
> >> submissions not even filling the ring by 1% can block subsequent
> >> submissions, which, in the worst case, can lead to the ring run dry.
> >>
> >> In order to overcome this issue, allow for tracking the actual job size
> >> instead of the amount job jobs. Therefore, add a field to track a job's
> >> submission units, which represents the amount of units a job contribut=
es
> >> to the scheduler's submission limit. =20
> > As mentioned earlier, this might allow some simplifications in the
> > PowerVR driver where we do flow-control using a dma_fence returned
> > through ->prepare_job(). The only thing that'd be missing is a way to
> > dynamically query the size of a job (a new hook?), instead of having the
> > size fixed at creation time, because PVR jobs embed native fence waits,
> > and the number of native fences will decrease if some of these fences
> > are signalled before ->run_job() is called, thus reducing the job size.=
 =20
>=20
> Exactly that is a little bit questionable since it allows for the device=
=20
> to postpone jobs infinitely.
>=20
> It would be good if the scheduler is able to validate if it's ever able=20
> to run the job when it is pushed into the entity.

Yes, we do that already. We check that the immutable part of the job
(everything that's not a native fence wait) fits in the ringbuf.

