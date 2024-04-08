Return-Path: <linux-kernel+bounces-134863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A666289B803
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C08A282C72
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B66F2030B;
	Mon,  8 Apr 2024 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dd3VuSkd"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4341BC39
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559319; cv=none; b=slcizhXl4Ad7xgqIsgODs4YCtSyfwkftsYopRPqmy1jyNBg6nwGyunhCDOnnF0tQcJ3YV7T+S0RLdwtksVtRbCkO1frpfzUsOP3daDr8zO5SyBEc8LLPrRQmc0rbYx1B7R3vuXdjjE9N16Sc1uxdkRS5L3K0ueG7RbhLOFnd90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559319; c=relaxed/simple;
	bh=nxld6Wy8KQmN20c+bWuyU8Dcu8mgfZTFKb7o7eOZHzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1uNzDMm8S5G1LbPYsYANMoj0VoRRYf9qNLs1rlUSNH/dP+JrUcWlPTc+Ejo3c6WyUtU1xmI4KY7KnGYkUnsnDzKNbvRqpj/bq8w5eWHlQ1h+CYO1pRHJYg0wEENTX4yvmXsgC5AKxFUVru7ISC5zvz2K77SmVp1rsY5M/euK+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dd3VuSkd; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-699312b101fso23281776d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712559314; x=1713164114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxld6Wy8KQmN20c+bWuyU8Dcu8mgfZTFKb7o7eOZHzE=;
        b=Dd3VuSkdMDC3DlROahrxdz7hnKOBFPBgBJFoZu+QeczQT2pyQnetVIUP56so1oW7vl
         1tLcZSKpQhpHJuIgXlaw2ujke5/LVcIaMk5RpgcJPPpc8xzUSiakzlkLtkHQDO7hPY/c
         VaPDybUU2ym41cK1SuSryXtfHdus03SYQrZO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712559314; x=1713164114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxld6Wy8KQmN20c+bWuyU8Dcu8mgfZTFKb7o7eOZHzE=;
        b=J/28DXU7V7dh0n2OCkPK+3Ftb6TjYPgjZxcONdPcfG/QMbS1wIhKvGwfKQM0BoRMRU
         fJMf6ByYiCHh5PcFFOKXlGIdLg2NJbq0IU46lqk2iVGk5Cx61jU6PYEA+FlitlVN2kiK
         rj80nqxdPux6ReFUyQriFa59WxSu1qfybz6Cxrt9FzDxZwq86ewFusXLvPZO1+ZEeM8x
         ClNx3fa4v1ynaMAP8Hv4KMO1J7JuqxX4kRCFUha/10dCBSPYUrZSqcyzaTn3du1P/wcj
         pmzsYHpkt+7vZ5N01MLvhGGSXU9jBdI4C8UfFBzxtuC1SUiK9YZxh4QnRwnfkwLd6bpq
         f2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8P6eaVOnn4UF7L57daMlpZZQXhiaU3UEVuumnNMClfAdU+RfH4QQ/qPN81T3hGj4NcMFswoKZtG435LxMo652lW745LzqiuNiO9yv
X-Gm-Message-State: AOJu0Ywr7aGp2zZAE9D23az5fqYu+KurBZv3rpO70sn73zlTFuylhV9g
	lj/Zvxv+5LPyAVNT6SHkbKymqbyubA2nNqAHQQTeiNPWYaMGwpatc7/6Kraip7kkeeKQqYnnZaG
	ogA==
X-Google-Smtp-Source: AGHT+IH5GiNLIgDu+eNq/lGLw2sFJW6G4rjklhidpO48ElWyqswo3wwaHF1wu4/M9M2Cf3kiXTOjyQ==
X-Received: by 2002:ad4:5150:0:b0:69b:1e98:8e91 with SMTP id g16-20020ad45150000000b0069b1e988e91mr869919qvq.62.1712559314649;
        Sun, 07 Apr 2024 23:55:14 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id j6-20020a0cc346000000b0069b192e63bfsm896614qvi.91.2024.04.07.23.55.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:55:13 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42ee0c326e8so346221cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:55:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJH/p11Sm3JVlz1Hd7Mb/QR0aaJFkCQW4xwt876TEFiK8wOeWPl9HdjuN6dj9Fl07DYPs27YCTP/AixaJc2t4+rbT7llmcFrxAphuz
X-Received: by 2002:a05:622a:510b:b0:430:ed37:bad0 with SMTP id
 ev11-20020a05622a510b00b00430ed37bad0mr368183qtb.13.1712559312989; Sun, 07
 Apr 2024 23:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325215631.3804796-1-dianders@chromium.org>
 <20240325145626.1.I659b2517d9f619d09e804e071591ecab76335dfb@changeid> <CAJMQK-gcN06k2zFQoSYKZcxxoRvkXVqCFmFtQ0xUS=+1VG+92Q@mail.gmail.com>
In-Reply-To: <CAJMQK-gcN06k2zFQoSYKZcxxoRvkXVqCFmFtQ0xUS=+1VG+92Q@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 7 Apr 2024 23:54:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQXzJJG4Lf1=LR=sDs6M4w8auLzfc_uG1Hb-9qC_qaRg@mail.gmail.com>
Message-ID: <CAD=FV=UQXzJJG4Lf1=LR=sDs6M4w8auLzfc_uG1Hb-9qC_qaRg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/panel-edp: Abstract out function to set
 conservative timings
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Pin-yen Lin <treapking@chromium.org>, 
	Prahlad Kilambi <prahladk@google.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2024 at 4:52=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> On Mon, Mar 25, 2024 at 2:56=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > If we're using the generic "edp-panel" compatible string and we fail
> > to detect an eDP panel then we fall back to conservative timings for
> > powering up and powering down the panel. Abstract out the function for
> > setting these timings so it can be used in future patches.
> >
> > No functional change expected--just code movement.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

Pushed to drm-misc-next:

2cbee8ae55f5 drm/panel-edp: Abstract out function to set conservative timin=
gs

