Return-Path: <linux-kernel+bounces-33738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706B8836DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955551C22D81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9AD47F40;
	Mon, 22 Jan 2024 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ts5aD70g"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF91041767
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942901; cv=none; b=OSgOtZ9WMIzF7r/UkPqIEueNRSgsxFZnG81w8e6x1uXUqKOHTp51nmMF9dzgvsAH6HDEdfvlUDQ6u8JVaicJWvh5fgZDB6nhVCgGwvvcsmia9md4cEPzaqhPTEZaEtoinbGYvJHIAq5IQ9U/mfYKig3P7lIUkIA90711opXtBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942901; c=relaxed/simple;
	bh=WDqvmjQjNPw7xiA+qGDQxkaHJRxufdafVrKYp1S8kq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xo+Ja+9gGnzD+DpNNFZMm1cjprsl1mKwJtNrRoSo19EEnwQdLzau9s7XgHLAOLXMFvqYRABvF71qjmUel0KD0tEXk/m0LF+tmptO7UbNy4iUHLE5g4Wz/otD62g2BmnJQKS/TpV8RoLwkj7b2aw1wniD0s+6z8hvhj9ujbhxq2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ts5aD70g; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a30995f564aso28309166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705942897; x=1706547697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uy+XgE6dRrCm1kEyPh0L3J8oRZMz37vPT45FSGIvqe8=;
        b=Ts5aD70gGwzp05FRMOdDer0PSy7ScJ/q2kiR6wylRqXpdIZNYFGGa74KZhfuOswLri
         +Ki6tR4OgTZEWKuMS+9Ay598BDDXF5NYJK5j90FPFHnSDufqjO+gbrhkWksrnziCHw9O
         bGUntD6lmVkksVb4ZkAezl/IyGiHtvntiPBhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942897; x=1706547697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uy+XgE6dRrCm1kEyPh0L3J8oRZMz37vPT45FSGIvqe8=;
        b=lAl/pOu5Lho297FIY98C5UnDrSUgbDWzyjb/7UCMpIsnNqa4/zyvChjK5HCKoSon1S
         hQsKlbx4KSZBv4AIf2H2X5spB8/edtRjYgLRi1U5ntskrmuifkMnX6reu8YSHyfjfOK2
         sJ1gQZzDlZMlK1sadmqD7DYTWg6mfgdP74cQHRQtq2YL5ID6acewIkA4ydoBGuK7WtxV
         G6iX63ww+4LlSKG/zV0XbgAZaNguwKW3N266M4QMFG/maeDRUV5UlYQcuSnEllM7/xlE
         mTuVDgikGX0Sn2adAYtAr+LqhVyHpc/OIcIRdzcCaJ/Rp/+yjiLE14i+j1zzlLTqQ+08
         /+7w==
X-Gm-Message-State: AOJu0YyKZoIsSHZ/oTsDmJFziejU4MSsQveIoShSNYIFQ3Dc97uSVKGb
	Bxy+cHOjRx9Py3alUBhvSpskSSbgqUZyCb8iUx7FMRuLxShN5ahlZjzQgrNNvuEA+lws76p6SKF
	qkA==
X-Google-Smtp-Source: AGHT+IGGLsNtyRJF6BmMwxPs5oy/seUqdxGYIWjkyZehB3s1ORwJv3KF2o5Ui95ow+pMatEJ7lnkiw==
X-Received: by 2002:a17:907:592:b0:a29:852c:cc4f with SMTP id vw18-20020a170907059200b00a29852ccc4fmr1897842ejb.64.1705942896837;
        Mon, 22 Jan 2024 09:01:36 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id x25-20020a1709064bd900b00a28f54aacf1sm13585894ejv.185.2024.01.22.09.01.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:01:36 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e4afe9ea7so77975e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:01:35 -0800 (PST)
X-Received: by 2002:a05:600c:4fd0:b0:40e:61cf:af91 with SMTP id
 o16-20020a05600c4fd000b0040e61cfaf91mr340412wmq.7.1705942895107; Mon, 22 Jan
 2024 09:01:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118015916.2296741-1-hsinyi@chromium.org> <CAD=FV=WYm0=uyQMf8yZpqaCWN2dympTt_bUVPOe+nafBLdS_DQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WYm0=uyQMf8yZpqaCWN2dympTt_bUVPOe+nafBLdS_DQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Jan 2024 09:01:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UXqsULhVL0Mpk=V0VoR1yQaeBQA_6zYriCdQxNfEHktA@mail.gmail.com>
Message-ID: <CAD=FV=UXqsULhVL0Mpk=V0VoR1yQaeBQA_6zYriCdQxNfEHktA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Ensure bridge is suspended in disable()
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Xin Ji <xji@analogixsemi.com>, Pin-yen Lin <treapking@chromium.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 18, 2024 at 9:30=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Jan 17, 2024 at 5:59=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org=
> wrote:
> >
> > Similar to commit 26db46bc9c67 ("drm/bridge: parade-ps8640: Ensure brid=
ge
> > is suspended in .post_disable()"). Add a mutex to ensure that aux trans=
fer
> > won't race with atomic_disable by holding the PM reference and prevent
> > the bridge from suspend.
> >
> > Also we need to use pm_runtime_put_sync_suspend() to suspend the bridge
> > instead of idle with pm_runtime_put_sync().
> >
> > Fixes: 3203e497eb76 ("drm/bridge: anx7625: Synchronously run runtime su=
spend.")
> > Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid through=
 aux channel")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Tested-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 7 ++++++-
> >  drivers/gpu/drm/bridge/analogix/anx7625.h | 2 ++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
>
> This looks good to me.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I guess this started showing up more because of commit 49ddab089611
> ("drm/panel-edp: use put_sync in unprepare"), right? Since that's a
> recent commit then that means there's probably a little more urgency
> in getting this landed. That being said, it feels like it would be
> most legit to allow this to hang out on the list for a few days before
> landing. I'll aim for early next week unless someone else has any
> comments.

Pushed to drm-misc-fixes.

4d5b7daa3c61 drm/bridge: anx7625: Ensure bridge is suspended in disable()


> I guess we should see if we need to do something similar for
> ti-sn65dsi86 too since I could imagine it having similar problems.

I tried this myself and I couldn't see any problems there. I also
spent some time thinking about it and it seemed fine. There should be
no fundamental reason why we'd have to necessarily power cycle the
bridge chip in this case. Presumably ps8640 needs it because the
embedded firmware on ps8640 is easy to confuse. I'm less familiar with
the anx bridge chip, but I could believe something similar is
happening there.

-Doug

