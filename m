Return-Path: <linux-kernel+bounces-85984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D168C86BE12
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7DF284F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B750637163;
	Thu, 29 Feb 2024 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QeLn0EuP"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D20023D2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168699; cv=none; b=kERR2uQG598Z30QoNrFZTOJaX/UmCh/9TsmeJIn+IumAKqnaLZzjM9dv2l4ZaeU1icmRHJYB8lgLQEWPbjrbYp4U46gFWrI0+njdaGuzxyq8/df3IabTTPKC01baNG6C2YUStPX7LIbnM4Fh++0kC7Y4tsZ4aSVw99ze52oClBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168699; c=relaxed/simple;
	bh=mlW/QceuhwMc0DNGKXMDyALlNyqTylgx0y9zgyIvfV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4zMGxL9uqzHkn/CYlZrBzDvB8K/C0YjucLNvCoLyKHZS+bkvbRr8BRwLp+hvqp9FKveqv03iwYZm8ZWHfp9W4eu9FobZz69OJwi+n9kp5Z/HgVyoj5J/VVOpEg8h/26B0vzUIuVjasPdq2p3rxVdMlLUfp8HbhPV/V1K0ppT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QeLn0EuP; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e49872f576so189458a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709168696; x=1709773496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+B/QFkmhGVByeQP+/pLiaj4NFRJ5VlaaL5Kc+sknpU=;
        b=QeLn0EuPWaRqunHl7x4cD+na0SOlzWd0UypLEeZKh0a4LKb7qdGCa+nlI04mMvYRJ7
         69qTszzOC7wVQFvZxaoyMXaurxDa1wAmVD6h2OW+UudllFeStTdQU6psw6vEDO7OoTtz
         dUdx5zRml7AYwKXqUAv4df+km5Ik1U1pz0lgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168696; x=1709773496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+B/QFkmhGVByeQP+/pLiaj4NFRJ5VlaaL5Kc+sknpU=;
        b=SiZPR8UOzWct/XgqCVonI7eqGIbCgbkOwf6UPiiPMX55OnZ80EodfyqElFLOIu5xCo
         rj9JDpp7OYGK3abC+AV3F8bzKe2PFcq3M5S8zQNJKly79vB2/ezuU67gv/GBKzHA1tjM
         eunVMtq1LX+Lpt9zM+whA1hXrRp7Vst4IFWpm9ieFBSBzFKV3l5+c5IhnimB9fqqQjqi
         dFV5EanMVFZa38H51uPgoCNG1LnRZ0f+EnpkODQNp64TU1S8eoTKi3X4mLM58eDCUA3g
         GKKMb4SzHkchoX1maE4sWF3vR88z3wezKt2HTXrWsYMT6x1J1fGU2nSSZH7cvMeEwryI
         4WUg==
X-Forwarded-Encrypted: i=1; AJvYcCWMsgQ3RkiNgHHuIgTgMeYjUk4LzunfYHigTsw+P8JrFTXvk7xb0S1iwt94R/ltVcpB8iwkgdc21yFE8IuXdaSUeKnv8Pzzf5XKn+SB
X-Gm-Message-State: AOJu0YyoLbb6RKOvZsxTRM47KBtFq1xTOjQc2dFAwNGEBcV36acsk/q6
	omj9GqsnMa5bTZzAAN2Sz0g+EMcVC56SoGA4QdJbnTjn7T9lssVG9G8qWTIfaKeSvpB33YYeJFx
	SAQ3525LPuma8jnQZkbVmDKKbinLg9dBeNkIr
X-Google-Smtp-Source: AGHT+IFhWTqT6PtD4JEMKkFFd3nv0wlgYavQr4yUhVPVv9OfdNYWexXhMXSXQcwUC632H3U5Qtfim6FlE06VQO+AHt0=
X-Received: by 2002:a05:6830:2013:b0:6e4:8d2d:64e5 with SMTP id
 e19-20020a056830201300b006e48d2d64e5mr578147otp.13.1709168696649; Wed, 28 Feb
 2024 17:04:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228011133.1238439-1-hsinyi@chromium.org> <20240228011133.1238439-4-hsinyi@chromium.org>
 <CAD=FV=VV6fprky=v9koiVGmWcXKL3V4F2LOu7FriPbT_zT6xyA@mail.gmail.com>
In-Reply-To: <CAD=FV=VV6fprky=v9koiVGmWcXKL3V4F2LOu7FriPbT_zT6xyA@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 28 Feb 2024 17:04:31 -0800
Message-ID: <CAJMQK-gmWHXNmxk4fWM0DEDN0kdUxVJF_D8pU_8CYCpBnd3-Ag@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: panel-edp: Fix AUO 0x405c panel naming
 and add a variant
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:22=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Feb 27, 2024 at 5:11=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org=
> wrote:
> >
> > There are 2 different AUO panels using the same panel id. One of the
> > variants requires using overridden modes to resolve glitching issue as
> > described in commit 70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_mode"=
).
> > Other variants should use the modes parsed from EDID.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > v2: new
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
>
> The previous version of this patch that we reverted also had an
> override for AUO 0x615c. Is that one no longer needed?
>
>
> > @@ -1990,7 +2003,9 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B11=
6XAN06.1"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B11=
6XTN02.5"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B14=
0HAN04.0"),
> > -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B=
116XAK01.0"),
> > +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B=
116XAN04.0 "),
> > +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "=
B116XAK01.0 ",
> > +                        &auo_b116xa3_mode),
>
> The name string now has a space at the end of it. I _guess_ that's OK.
> Hmmm, but I guess you should update the kernel doc for "struct
> edp_panel_entry". The name field is described as "Name of this panel
> (for printing to logs)". Now it should include that it's also used for
> matching EDIDs in some cases too.

The space here is because in the EDID, there is space at the end,
before 0x0a (\n).
Okay I will update the kernel doc to mention that the same should be
exactly the same as the panel name.

