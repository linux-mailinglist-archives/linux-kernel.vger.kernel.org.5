Return-Path: <linux-kernel+bounces-46344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12435843E56
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5FF28E388
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7107691C;
	Wed, 31 Jan 2024 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HLiOeYSl"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112D76043
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700545; cv=none; b=cXNXV63yfro+L7JVTruN9Q08XrKKJ84gS6sim/yvc4x+GcOT6WghOccarVbaE4GwLAXu4PnHSkTNXgUPp8h8uhdKFWh/Qj5a6Ukdv+TwjC4taDiac/2F2IuRDBqL2iU91mvMAOboks+Gctp+dq/VXORRfC8IWgUUKL+2i3Srjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700545; c=relaxed/simple;
	bh=yz09reOw4cbe5t8nBB/s3d+xbya47tOp+Gvn14oIpQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJYXPmnG1bxHSkjOTRU2QQAgnO6P5tdnXQ931dD8dmeaa6/Wos57wvZWsLDZ2b2YaPW+I0MZlLCXcjNO34e5CoQkBKC2pB6GSFzaEWmbBxHlvFU4X9fbT5c/lYsGpyNuHI5imjArSawBlTjEE/8PHSUFngDvzhgnONGsIWij/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=HLiOeYSl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a352d9c0f9dso148926066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706700542; x=1707305342; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UqhHWwD0G4uA9KZYS4hbxluQXzkwr0OlBUL6FsGhiWg=;
        b=HLiOeYSlMWq8VAf2NEDTF5Hy03KcSIXsrzHtc60g8rtE6PMGP9skX0Mg5aSgARZkBi
         yERMwRy9RolinIwwuuJtA+r9WWv9yTCesfyP4iYrQNbl2Bk2+KZKZldMAaBt/xZpA1FS
         isZEe55jC55+HGtXUmQv6kgd3bl0DBdVq8qEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706700542; x=1707305342;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqhHWwD0G4uA9KZYS4hbxluQXzkwr0OlBUL6FsGhiWg=;
        b=eTdFSwjslJ07Pz6/VrJ7jQM7Jyrxr0DtC14KzOGTIxorWOS7MElYJpyDv6ck3dQj3O
         epQ7HuKVilSs6VOyWoerj2JVJ0StAcqRWplHuz7scufv40M8XvUixTykiCEae3F3rs63
         dJrhSWgiyeRARRBjp+U3kKNjVAOEJR3mq7AXy1BFziJEFpKtWXiv/zfoiXeShvF/1HFQ
         bUAmX6AmSSKuxjx/ezhVAev3WSw4MvB756rBq6/wIoLtPe6uSPVAejf9J+Sv/SS49oAX
         Fig3wX9le5fBrpBMxPFnmEyTNx+mhe/sl38yOy6siUjF8RmFs9Jbue3jRGDefKf53HFm
         Qutg==
X-Gm-Message-State: AOJu0YxcRIhsaV6VK50N959F13CGtpb6ynGq9RhPLJUfBYkikpJa0ZTl
	Bg/RLfABQ5TQHFKtTSp2GlB8C8HC810bVQQ9J8wZfzP2brT8yCut8ED9ka/1woc=
X-Google-Smtp-Source: AGHT+IEF59TprIa6Ram1HS7MhbdsWEwmnMxvdors8usQrdNdBa4tbbMATy8t9TnYJpReIzZrvsqyxg==
X-Received: by 2002:a17:906:4f0e:b0:a31:410a:18e4 with SMTP id t14-20020a1709064f0e00b00a31410a18e4mr886491eju.4.1706700541914;
        Wed, 31 Jan 2024 03:29:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVQg6OreM8PpU4kdOWR1ROcpBxhI0KOFi8yuDak8zGiFs/4kT7V4Qx4VBX/FFBu06AKIYEyB4sPazzAizbPK7O49rHn8RS/gfXPjPGlI3SFOKCnewgu9bTfvPiRy6rb+7LNEfNKSpT6Vc+zIXkx+2GSyurNfiDgq+2Y8DUIVVbNs5hpmZUiJ7vP7IZIW6yi+ANAiZgRLbTvGIDj5lqe+H+EGj3nX0xTDTbLhK8RB/PcVIzZhollLovJA8MDvLVfWYtYkxkOHRaznsXa1zX+pye0pO6eo0Srsd/DxM7Wu48P0Uvw0P6fCWrt/e6HFJ5nCo7N+Uv2CyCjx/6EMAdAysp+TrNle4NeRcLeHJTmHpdwN51QAAwHxFA3Fy7Fa45Pw0ssb5xa8FHH2LToB1fH3So/24Og/rzhAcI8XqHSNDAE9FAfkNR5BNI1a1WHZkvjey8uCi/YS08UxRgAhWWlqZiapxLMvqhv8ktKBxnrwPPi0ODL0lQAtuR7ZJ/F//zYx27zFTZd93HtkeSz+4CBuqU38t6OkyKkvrdRihf2ZivOvEA/30EzLmdN0byBwyCYgHWWm5DuYUX+GktDiCwHpC1Lm4xji1nifQ70uncJBkhW66Fnl2jdnrNSR0GWmqNpAgljJJYHDK2SNh8TU+4IGIzAXARHIpXsBy4BcEWb32RXcjeKxR2R46J7lshdAGBdhqIEBFu+1nni32ojt5Oh1nl6hjS34D8kg9cJErcDZtFFUDQaVvxp2IhtZu6HCsJ7G4nDB4Xh4Y9nNCPrhxBek+wPmXtL2CovnAVDzoqNGxnFF7zBrh8+ZKH/mXm0lFcKxxwDnApqwzgi6HQCtEfeoW1mtH5yfXvbHUMOYioIJwMVDISp2In+OG8lWcLrQ4kC86M5MZN1HsJRbgO7AfUb/2VoqTsCgXlGygKgR3CDBZHY4uMQPgqRW/B+7FPFDz4u4bBDTF
 PCe9piEndN99AfqgZO/Yg+q1HbZ/V1e02L7iL1fV+VfhrVr2bovvCzuOfP5ry4VQ==
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906784600b00a30e1f233b4sm6064491ejm.128.2024.01.31.03.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 03:29:01 -0800 (PST)
Date: Wed, 31 Jan 2024 12:28:59 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"michel@daenzer.net" <michel@daenzer.net>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"mikita.lipski@amd.com" <mikita.lipski@amd.com>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"maxime@cerno.tech" <maxime@cerno.tech>,
	"daniel.vetter@intel.com" <daniel.vetter@intel.com>,
	"nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"quic_abhinavk@quicinc.com" <quic_abhinavk@quicinc.com>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"manasi.d.navare@intel.com" <manasi.d.navare@intel.com>,
	"lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
	"sean@poorly.run" <sean@poorly.run>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
	"fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"jani.nikula@intel.com" <jani.nikula@intel.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] drm/atomic-helpers: remove legacy_cursor_update hacks
Message-ID: <Zbou-y7eNhQTMpKo@phenom.ffwll.local>
Mail-Followup-To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"michel@daenzer.net" <michel@daenzer.net>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"mikita.lipski@amd.com" <mikita.lipski@amd.com>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"maxime@cerno.tech" <maxime@cerno.tech>,
	"daniel.vetter@intel.com" <daniel.vetter@intel.com>,
	"nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"quic_abhinavk@quicinc.com" <quic_abhinavk@quicinc.com>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"manasi.d.navare@intel.com" <manasi.d.navare@intel.com>,
	"lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
	"sean@poorly.run" <sean@poorly.run>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
	"fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"jani.nikula@intel.com" <jani.nikula@intel.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>
References: <20230216111214.3489223-1-daniel.vetter@ffwll.ch>
 <20230307145613.xvhru3fpcudlpazt@houat>
 <aac416742920953999a9ce230ac68139bf5b9790.camel@mediatek.com>
 <ZbKlsTEvGPiGtzS3@phenom.ffwll.local>
 <1349365de499bae53a8c868738c7270fc16813d5.camel@mediatek.com>
 <ZboOp7JOp5teV1Cs@phenom.ffwll.local>
 <CAA8EJpqAU=RvqJUPmPO2LCJ+6KMOT8Pi2WrkPq8YHzhyRVxHeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpqAU=RvqJUPmPO2LCJ+6KMOT8Pi2WrkPq8YHzhyRVxHeg@mail.gmail.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Wed, Jan 31, 2024 at 12:26:45PM +0200, Dmitry Baryshkov wrote:
> On Wed, 31 Jan 2024 at 11:11, Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Jan 31, 2024 at 05:17:08AM +0000, Jason-JH Lin (林睿祥) wrote:
> > > On Thu, 2024-01-25 at 19:17 +0100, Daniel Vetter wrote:
> > > >
> > > > External email : Please do not click links or open attachments until
> > > > you have verified the sender or the content.
> > > >  On Tue, Jan 23, 2024 at 06:09:05AM +0000, Jason-JH Lin (林睿祥) wrote:
> > > > > Hi Maxime, Daniel,
> > > > >
> > > > > We encountered similar issue with mediatek SoCs.
> > > > >
> > > > > We have found that in drm_atomic_helper_commit_rpm(), when
> > > > disabling
> > > > > the cursor plane, the old_state->legacy_cursor_update in
> > > > > drm_atomic_wait_for_vblank() is set to true.
> > > > > As the result, we are not actually waiting for a vlbank to wait for
> > > > our
> > > > > hardware to close the cursor plane. Subsequently, the execution
> > > > > proceeds to drm_atomic_helper_cleanup_planes() to  free the cursor
> > > > > buffer. This can lead to use-after-free issues with our hardware.
> > > > >
> > > > > Could you please apply this patch to fix our problem?
> > > > > Or are there any considerations for not applying this patch?
> > > >
> > > > Mostly it needs someone to collect a pile of acks/tested-by and then
> > > > land
> > > > it.
> > > >
> > >
> > > Got it. I would add tested-by tag for mediatek SoC.
> > >
> > > > I'd be _very_ happy if someone else can take care of that ...
> > > >
> > > > There's also the potential issue that it might slow down some of the
> > > > legacy X11 use-cases that really needed a non-blocking cursor, but I
> > > > think
> > > > all the drivers where this matters have switched over to the async
> > > > plane
> > > > update stuff meanwhile. So hopefully that's good.
> > > >
> > >
> > > I think all the drivers should have switched to async plane update.
> > >
> > > Can we add the checking condition to see if atomic_async_update/check
> > > function are implemented?
> >
> > Pretty sure not all have done that, so really it boils down to whether we
> > break a real user's use-case. Which pretty much can only be checked by
> > merging the patch (hence the requirement to get as many acks as possible
> > from display drivers) and then being willing to handle any fallout that's
> > reported as regressions for a specific driver.
> >
> > It's a pile of work, at least when it goes south, that's why I'm looking
> > for volunteers.
> 
> I can check this on all sensible msm generations, including mdp4, but
> it will be next week, after the FOSDEM.
> 
> BTW, for technical reasons one of the msm platforms still has the
> legacy cursor implementation might it be related?

Yeah, msm is one of the drivers I had to change with some hacks to avoid
really bad fallout. It should still work like before, but that's one that
definitely needs testing.
-Sima

> 
> >
> > Note that handling the fallout doesn't mean you have to fix that specific
> > driver, the only realistic option might be to reinstate the legacy cursor
> > behaviour, but as an explicit opt-in that only that specific driver
> > enables.
> >
> > So maybe for next round of that patch it might be good to have a 2nd patch
> > which implements this fallback plan in the shared atomic modeset code?
> >
> > Cheers, Sima
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

