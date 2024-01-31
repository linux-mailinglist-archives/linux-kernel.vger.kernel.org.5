Return-Path: <linux-kernel+bounces-46229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E286843CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BCBB2BB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09FE6A34B;
	Wed, 31 Jan 2024 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEtMRyj2"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C9967E90
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696819; cv=none; b=TC3Md7lROkTG5TWVaBo2E9g71lI0AiGDbGfxTIvV/l4t1Jm0bJ/zBjZ9lEuyp8/VpaxYHPliL10QtrF3oRAjrjJPvOIjc+EHTUa7jOvG3pCJAaTpjVo5sndIC0CB7sVnSe7Lnu5PUqsgLTXHFm96gk3Esge9MmJZiKa/chlF0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696819; c=relaxed/simple;
	bh=tyqDI+3ZnJjTHgP7GW/Pe4PTo3RiUCrtkEdyWTbtEyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lx57JgmHbq2QsGi35ImSCeMBJrjkvi70yv+z73Tza7hygS74gDvrQIZ+IaFk6rj62TZb+WEAYowyjR6OEpkuQVfRD6TU1lpQZRwc8oHajQkhjzv9sWeej5J08ifyRbg4frQo+n0RrOoItrM+4UOAYLdt7Ao3Glz58f3+Wc3dUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TEtMRyj2; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6c4a5bf2fso282441276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706696816; x=1707301616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWIGLVURJo4ZNOv6LbG+L2EJurKR+kNUUVg3etTCY74=;
        b=TEtMRyj2lIuJtg9br8rZ9SSBrKJZoj5zczP69CCt64onCrs6wDNJZeNqdhMkrWK0Eh
         Lpa80FiY4gdfA65WKfCRs3SN220Gx+at9Pvk3Ln7rEUMLhQx1u215ITe6KMqD4UPeHOS
         ZvssoM5aMtMHjMsnyhbpIOL5M0LXpNLhBqOVUt1GkVpgbWfwD4lnaYvJh0mRAG3EBlUI
         qRicv8oJZQDf7xE2lPHuyd60lYj8mrazkqw8kNUzlFKxBnNBn1N+HmJZmqMhqj9ZtGiV
         WIPzQpOD//PkMAW4VmgBmBkDh48jSWzc6JVPcyd8gDibVQjjQUINSqFKOug6wBpEUmxD
         YJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696816; x=1707301616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWIGLVURJo4ZNOv6LbG+L2EJurKR+kNUUVg3etTCY74=;
        b=kGgMO82QbWTo7XtowOmdZJ8f+NEvfFmDGVcdyC4WcLyzBmY149+IBnNjo0yc2QpMB8
         lW6Sp29yr/mTaXHUfg0T/KH38hHhHz25aWbDlwnC8KgnS8Foz9JW1HFWH/v04d/Bsduh
         mFr6G9RpjpcKNapZh1C+Z8+wWg5cjBnyiZVuVuegUQ+cJLdb+nG1CrBNvZKpcKJCGZaU
         pCj16PDmIPmItRJheXhqNeif53kn8EaMuK9wlvRbK7UvrQKiF3B3VLZex4GvO3zHV4R9
         xRQSgf6ifQEWXXUcm4m1g1z6XsXGYbcBf9Xt9XiOmN32z9sXyBho2MfUsJzLfa+NKA9Q
         NJeA==
X-Gm-Message-State: AOJu0Yy41JZJHKoQaZ0nUtrL5f/LRuL7/1zkQ+aqCFDv4WQAeXGgDZCk
	TK0olABQld/YeHa0nZcEWYDjqW8l9FqFoZG8V5DBP/9JePbmwpOYEMotFnSoAT1fX7SveTyymYt
	tvB6zRRA1Qv/XQEVD77M4C2IZBcummaqIpYzEvA==
X-Google-Smtp-Source: AGHT+IEqJVgu4nIRdtbsrRTsERmdIoAZnatopWJ6POWGE249ajHq/UFYIvx+LLtNTS6kTpwKklekHqS/zpNcV+La09M=
X-Received: by 2002:a25:2fc2:0:b0:dc6:c669:9914 with SMTP id
 v185-20020a252fc2000000b00dc6c6699914mr444876ybv.15.1706696816245; Wed, 31
 Jan 2024 02:26:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230216111214.3489223-1-daniel.vetter@ffwll.ch>
 <20230307145613.xvhru3fpcudlpazt@houat> <aac416742920953999a9ce230ac68139bf5b9790.camel@mediatek.com>
 <ZbKlsTEvGPiGtzS3@phenom.ffwll.local> <1349365de499bae53a8c868738c7270fc16813d5.camel@mediatek.com>
 <ZboOp7JOp5teV1Cs@phenom.ffwll.local>
In-Reply-To: <ZboOp7JOp5teV1Cs@phenom.ffwll.local>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 31 Jan 2024 12:26:45 +0200
Message-ID: <CAA8EJpqAU=RvqJUPmPO2LCJ+6KMOT8Pi2WrkPq8YHzhyRVxHeg@mail.gmail.com>
Subject: Re: [PATCH] drm/atomic-helpers: remove legacy_cursor_update hacks
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"michel@daenzer.net" <michel@daenzer.net>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"mikita.lipski@amd.com" <mikita.lipski@amd.com>, 
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"maxime@cerno.tech" <maxime@cerno.tech>, "daniel.vetter@intel.com" <daniel.vetter@intel.com>, 
	"nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"quic_abhinavk@quicinc.com" <quic_abhinavk@quicinc.com>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"manasi.d.navare@intel.com" <manasi.d.navare@intel.com>, 
	"lucas.demarchi@intel.com" <lucas.demarchi@intel.com>, "sean@poorly.run" <sean@poorly.run>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>, "fshao@chromium.org" <fshao@chromium.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"jani.nikula@intel.com" <jani.nikula@intel.com>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>
Cc: "daniel@ffwll.ch" <daniel@ffwll.ch>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jan 2024 at 11:11, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Jan 31, 2024 at 05:17:08AM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=
=BF=E7=A5=A5) wrote:
> > On Thu, 2024-01-25 at 19:17 +0100, Daniel Vetter wrote:
> > >
> > > External email : Please do not click links or open attachments until
> > > you have verified the sender or the content.
> > >  On Tue, Jan 23, 2024 at 06:09:05AM +0000, Jason-JH Lin (=E6=9E=97=E7=
=9D=BF=E7=A5=A5) wrote:
> > > > Hi Maxime, Daniel,
> > > >
> > > > We encountered similar issue with mediatek SoCs.
> > > >
> > > > We have found that in drm_atomic_helper_commit_rpm(), when
> > > disabling
> > > > the cursor plane, the old_state->legacy_cursor_update in
> > > > drm_atomic_wait_for_vblank() is set to true.
> > > > As the result, we are not actually waiting for a vlbank to wait for
> > > our
> > > > hardware to close the cursor plane. Subsequently, the execution
> > > > proceeds to drm_atomic_helper_cleanup_planes() to  free the cursor
> > > > buffer. This can lead to use-after-free issues with our hardware.
> > > >
> > > > Could you please apply this patch to fix our problem?
> > > > Or are there any considerations for not applying this patch?
> > >
> > > Mostly it needs someone to collect a pile of acks/tested-by and then
> > > land
> > > it.
> > >
> >
> > Got it. I would add tested-by tag for mediatek SoC.
> >
> > > I'd be _very_ happy if someone else can take care of that ...
> > >
> > > There's also the potential issue that it might slow down some of the
> > > legacy X11 use-cases that really needed a non-blocking cursor, but I
> > > think
> > > all the drivers where this matters have switched over to the async
> > > plane
> > > update stuff meanwhile. So hopefully that's good.
> > >
> >
> > I think all the drivers should have switched to async plane update.
> >
> > Can we add the checking condition to see if atomic_async_update/check
> > function are implemented?
>
> Pretty sure not all have done that, so really it boils down to whether we
> break a real user's use-case. Which pretty much can only be checked by
> merging the patch (hence the requirement to get as many acks as possible
> from display drivers) and then being willing to handle any fallout that's
> reported as regressions for a specific driver.
>
> It's a pile of work, at least when it goes south, that's why I'm looking
> for volunteers.

I can check this on all sensible msm generations, including mdp4, but
it will be next week, after the FOSDEM.

BTW, for technical reasons one of the msm platforms still has the
legacy cursor implementation might it be related?

>
> Note that handling the fallout doesn't mean you have to fix that specific
> driver, the only realistic option might be to reinstate the legacy cursor
> behaviour, but as an explicit opt-in that only that specific driver
> enables.
>
> So maybe for next round of that patch it might be good to have a 2nd patc=
h
> which implements this fallback plan in the shared atomic modeset code?
>
> Cheers, Sima


--=20
With best wishes
Dmitry

