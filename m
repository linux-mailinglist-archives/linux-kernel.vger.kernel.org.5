Return-Path: <linux-kernel+bounces-67317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E29BA8569AA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B544B22613
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43CE135A68;
	Thu, 15 Feb 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DqT8yqjQ"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A401754B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015035; cv=none; b=VypzbJRRNrmtynwK+vwLyYtWAsgHeEYTDYSpwd9VAVYVB85g2+uJHq+HYhigWTeA2kd2IruLybf8JR9bDm4hKxuP+iVDWgmnz0hocoGZh75aNNi0kC6+D/5a+/Rpp+XklG9cSztSKnZjovlPU92t5l78pFAxrpn5yyAzdXsUTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015035; c=relaxed/simple;
	bh=D3SjFKHEqf5L12pfvficEa9lk8RaZ3EWL64Cv3Zonw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6Me3Vv9a2CnBTXabeMTRyOlTwUqASvERMJg6u4uOz00s1oZXo17E0XYbB6mQkr8L5lH/rG4UoAR3U5oBJKWuLfJSGMNZ3uSQ9a2F55/G9PXHuqia7OzRGAS2/DyaKdacAjqaF7KhcpwuX/ShfBwqy0XNOp5Czqpxe5pYLIB20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DqT8yqjQ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7873eaa0ce7so2195785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708015032; x=1708619832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmHGzp5FxmeS/Awr4jPPRzY9AtNn0hlFjjkqswS8JcA=;
        b=DqT8yqjQTcUOQ6T/uhSiKgh+Wg/wWyMMrJD7qQTwYL6598OfD+g0cqST3dAgjSKlSO
         WuUGZjz33BI3RgAoFsgfGbHqoFJjsEI4Zbc6GNzBAeVtMjh3OhIM5hphbs8Dpiu7gdND
         lF2vvh8Xv3/jpGXcB5/lOzKwZ+wWqtntMlwzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015032; x=1708619832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmHGzp5FxmeS/Awr4jPPRzY9AtNn0hlFjjkqswS8JcA=;
        b=nJe0uXxUU9p0KeHsbCbToIvwWGtVuEnHtGbeh2xyLQcHjLlOAlUrCnNQ10ePrM94Ou
         yR9lH7q/+Dywga6495j4G+BbvPWQUNKpBsaAeesCn1+zqt1VsQUmcsg0vOKoNjSqBlyZ
         X3KZYm4s8lgr9nf6sTiJx5SLY5TifAFMvTnGX91XuHQ671bWYnYkG7Y85UTH6SFuHp99
         8bdGvRISdQKY2QGNwg9fl7d1TWfTKPYyiuC/x/U0v95ggusL+KFdCpP5WGZIyg17XwjG
         wLwAGShDebjNEBTTfSiyf6hOU9vqw4TuxXA3xORVEMP2whjXN0yFV3kSHcmvfKj6fdcO
         9Xxg==
X-Forwarded-Encrypted: i=1; AJvYcCXDchQooW4+LF1dLScaOPaoVvc4oQlyXpX02WBQCfepECq8Qf/xRXjO1ge7gVF7jrG8p2lGqUacHQ4OGgXSOQw5a4vQ1l/dvDdxJ5bM
X-Gm-Message-State: AOJu0YztXzlyx9YwfN9ldWOO2+X3Q7+59yrLZMY91PgOqdoHnAONvMwr
	bVLRjVd9CReQYPSkJJqzb0Nzw2ONQ5I5EG417hOZiJ9AlGiLK5IOJx6cVKpkJY1Ee8XLQeFnVTy
	JjWVV
X-Google-Smtp-Source: AGHT+IHfGTm8RqvNAFP+x47Ld9i8pr0cYAUsX61M+v0Geho3BEtySwESeCTTPjHbGFI81lv1ZgJpxQ==
X-Received: by 2002:ad4:596c:0:b0:68e:f0a5:26d0 with SMTP id eq12-20020ad4596c000000b0068ef0a526d0mr2200109qvb.47.1708015031871;
        Thu, 15 Feb 2024 08:37:11 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id nz11-20020a0562143a8b00b0068f2b0f2549sm258105qvb.88.2024.02.15.08.37.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 08:37:11 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-428405a0205so432001cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:37:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZK4MRr5DafJhAZ7FHyiUbri1McXnkBNQNQA71KPjqL0yiISMVtFgYbdqtOvGjIuAiEbLEqZHWY+R/SU59WNCxYVb07WZNxpb+0fHu
X-Received: by 2002:ac8:1247:0:b0:42c:1aba:c8c4 with SMTP id
 g7-20020ac81247000000b0042c1abac8c4mr13457qtj.12.1708015030579; Thu, 15 Feb
 2024 08:37:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214072435.1496536-2-hsinyi@chromium.org> <CAD=FV=VmDZvWVJ+DKN5bMPvJaLouNq26=Qyd4N9O+a0FeWCJpA@mail.gmail.com>
In-Reply-To: <CAD=FV=VmDZvWVJ+DKN5bMPvJaLouNq26=Qyd4N9O+a0FeWCJpA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 15 Feb 2024 08:36:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xeq59G_teWKj4LkUCMxQqVh4Hzjp1hWRU4VDBAUW9TqA@mail.gmail.com>
Message-ID: <CAD=FV=Xeq59G_teWKj4LkUCMxQqVh4Hzjp1hWRU4VDBAUW9TqA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/panel-edp: Add auo_b116xa3_mode"
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 14, 2024 at 1:41=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Feb 13, 2024 at 11:24=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.or=
g> wrote:
> >
> > This reverts commit 70e0d5550f5cec301ad116703b840a539fe985dc.
> >
> > The overridden mode fixes the panel glitching issue on mt8186 chromeboo=
k.
> > However, it causes the internal display not working on mt8173 chromeboo=
k.
> > Revert the overridden mode for now to let mt8173 have a functional disp=
lay.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 19 ++-----------------
> >  1 file changed, 2 insertions(+), 17 deletions(-)
>
> Given that the breakage for affected mt8173 Chromebooks is pretty bad
> (black screen), I'll plan to just wait an extra day for any screams
> and then I'll apply to drm-misc-fixes.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

It caused a merge conflict against drm-misc-fixes since other panels
have been added in the meantime. I'm going to stick this in
drm-misc-next to avoid the merge headache. If someone is affected and
really wants this in fixes, please shout and we can figure out how to
make it happen.

1a5e81de180e Revert "drm/panel-edp: Add auo_b116xa3_mode"

-Doug

