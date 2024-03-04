Return-Path: <linux-kernel+bounces-91195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD81870B0E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04FFB2280D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552B79DD7;
	Mon,  4 Mar 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SFfEsAdi"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219041AADE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709582151; cv=none; b=t4JUu2bbAU4+D1PM9/6WY8ieE2kbv4wMgkaJRlbq9u9DuxCZoWhXPB9LTYz1Ve/Jr2ljqDjGXGxDfXwsxzCW2qLvNS3XZnpxptAqJj+KIvgDiDg9BVPGbz7ZR07uMOxkd8cgjl+0TxTODujZecftGFhIO+VuQrqK3ish6LPgouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709582151; c=relaxed/simple;
	bh=Tog5zeobrRKVTjzHtvdP4CwzoUt0XlUpqhaKOA6akkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upozDxgGJqnqRCkPFnZu14Fr+NHtIJcd03tVgWHGZn8Yq07BdT9Onzpp8ALNBr9Qpjd9DA0DMZYvA8IcYUcOI0YcgyvMD5vRZ7PvIYZ9pkWVFNL10ll4zr00DjZfjtUJSfEAAO4q8y5IAGIT3z1EMP+vT7luqvTCZfvcitPnrZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SFfEsAdi; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e4e78f9272so426457a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 11:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709582149; x=1710186949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NChCIovI4USYlbL0DUhfDLCbSUUEkB22ExtjdPhFtk=;
        b=SFfEsAdi4tOaMFaHuRt5A0k3vLs7falbjoC1eqjJc4Uz8YY586EPHKkKWWGZ+YYMq4
         u8qbzRjjvLG0qN5lfp38yddnm1fqTubajBc6w4rZg+qh90PB6ntU50r+Mb28cHZGAuWK
         Db7IakFRfTSh8aSssYTB3HvKJsyUCPj+tL4DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709582149; x=1710186949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NChCIovI4USYlbL0DUhfDLCbSUUEkB22ExtjdPhFtk=;
        b=BKbZwFh7vmiz1+wwxEE7dylprFbsMaauRshH2WQwndr9nRepdAsqad45cOIkMqNhBs
         oi4bnERXWc3kCDibSc57eEnkYBuPHe8h5RApWjqL4VZ4yNFrC/IzG9kn56qxFhrW/3Fl
         kwCr8/FN7YinRFnhP0Zje81OkE6LhCFeM+Sf+JeSv0IwBf7F0fmtFTj0rcoS/3ZJV9tH
         YVXPQfNraunx9Qg3MF+mLEPb1pC1KixJYTIVJqgET7g8XJ/D6WvoQgBWBLbIaku2I4lt
         ggjlqCWmdUSPlrXiDq9/FOdTr1J8ayxhohPs/cwQu6pB4DkTwH89safCUzkC0IyLE7/C
         vWeg==
X-Forwarded-Encrypted: i=1; AJvYcCVXLWXB2PjEHf7LpkQSBDcdqyLDQanO+hq+zhqa0nBpoc3v7MEFKbDdJW202XhzER9I5sGEF6zNu7hgerMShoj4HYMsn9SAMY49P12V
X-Gm-Message-State: AOJu0YwbWIsLTLvyeWuban+GE5uy7SMB2vsvKhBmoZEU/dEa9AA08sZb
	q/ynHpVx7bL3sP2R05JOHJV7Md3SGaUbaBoXxVTAeWP254LHwT0wxme9aLV1qIgDEj1DyVC9Ih4
	YjSnJAARlxbMRtDj5Zy44XDGvFIvCzDccuS2z
X-Google-Smtp-Source: AGHT+IH/daYx78kTRsjvivGYL4lFX/eiSnMvvHZW7wCrYqUj4CUHMpbMfS/Z7+FVgRoBdMex8ZYd8yNiaMAznb2VoxY=
X-Received: by 2002:a9d:6c4d:0:b0:6e4:ecc3:556a with SMTP id
 g13-20020a9d6c4d000000b006e4ecc3556amr2250029otq.14.1709582149237; Mon, 04
 Mar 2024 11:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <20240223223958.3887423-2-hsinyi@chromium.org>
 <87wmqqjmt9.fsf@intel.com> <CAJMQK-jSPg6vU3SLmRy7zwNHJ4yqO2hT6RaiYxA4ifZ7CzwD9Q@mail.gmail.com>
 <CAD=FV=WU-2yystd40e+g9VNDNTiv5c=nP0uQg-AR03o7UGMTdA@mail.gmail.com>
 <87bk7z6x1w.fsf@intel.com> <CAD=FV=Wzm9Y7m9Q6KqO7yWdnc1xToaRMb2f1s2TQMJqpqVYLOg@mail.gmail.com>
 <CAA8EJpqHJTbc+TCpkccjx_eQH36zaNgcQ9QssecNeQUQgfYApQ@mail.gmail.com> <CAD=FV=XyV=V-USfq8kp058=FzRQq=bPA5A4GDb1p0zO-KPbtwQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XyV=V-USfq8kp058=FzRQq=bPA5A4GDb1p0zO-KPbtwQ@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Mon, 4 Mar 2024 11:55:23 -0800
Message-ID: <CAJMQK-gKF+ZeAe4Hp8di83Zx8gp-BJ0vuj6uzi0hsaxeju8GyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm_edid: Add a function to get EDID base block
To: Doug Anderson <dianders@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:17=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Sun, Mar 3, 2024 at 1:30=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > > The problem is that Dmitry didn't like the idea of using a hash and i=
n
> > > v2 Hsin-Yi has moved to using the name of the display. ...except of
> > > course that eDP panels don't always properly specify
> > > "EDID_DETAIL_MONITOR_NAME". See the discussion [1]. If you want to se=
e
> > > some of the EDIDs involved, you can see Hsin-Yi's post [2]. The panel=
s
> > > included stuff like this:
> > >
> > >     Alphanumeric Data String: 'AUO'
> > >     Alphanumeric Data String: 'B116XAN04.0 '
> > >
> > > The fact that there is more than one string in there makes it hard to
> > > just "return" the display name in a generic way. The way Hsin-Yi's
> > > code was doing it was that it would consider it a match if the panel
> > > name was in any of the strings...
> > >
> > > How about this as a solution: we change drm_edid_get_panel_id() to
> > > return an opaque type (struct drm_edid_panel_id_blob) that's really
> > > just the first block of the EDID but we can all pretend that it isn't=
.
> > > Then we can add a function in drm_edid.c that takes this opaque blob,
> > > a 32-bit integer (as per drm_edid_encode_panel_id()), and a string
> > > name and it can tell us if the blob matches?
> >
> > Would it be easier to push drm_edid_match to drm_edid.c? It looks way
> > more simpler than the opaque blob.
>
> Yeah, that sounds reasonable / cleaner to me. Good idea! Maybe Hsin-Yi
> will be able to try this out and see if there's a reason it wouldn't
> work.

Thanks for all the suggestions. I sent out v3, which still has a blob
type since we need
1. get panel id
2. do the string matching.

And I felt that packing these 2 steps into one function may make that
function do multiple tasks?

But let me know if it's preferred in this way.

v3: https://lore.kernel.org/lkml/20240304195214.14563-1-hsinyi@chromium.org=
/

>
> -Doug

