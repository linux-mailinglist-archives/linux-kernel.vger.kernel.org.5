Return-Path: <linux-kernel+bounces-165545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B218B8DC9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB51B248F8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8040F12FF8E;
	Wed,  1 May 2024 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TH6sMGYn"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4B12FB18
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579766; cv=none; b=ke4AUSULVtEf5tbqwSxUuHVClIIDoKDPPcFJoN5uSK4wf1hxqp0kKrNf/AH0tNUvcf8l87yj1fVIH32PfuBbKKIMMpbaAP/4EEcG5ls9A2LhL0ImaP7Gyduq6lpbcZuU1oY4KbNFj+tMESDggekNJUrRVKXkcpSONjOi8R9hAmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579766; c=relaxed/simple;
	bh=w45uJndfwrvSJq4iRCq3cjF1YjdgQLGQeSBXlESvxyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7pJMTdXIO/xx2GNPQ684sIcOER6ai3H0Nam7VgntwwqycOB/daJhRIbaSWNWdxekYa0vRlJUv6BsM0OTwAQakK2H+V2XVMzVb8bCrsg+11S3Pc6KoaLJjgq4i4d8U59uIMUjSvdPK8EAm6q60BhUVev62Qgq3Y+n+IyY8HOr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TH6sMGYn; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5aa4204bacdso4224880eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714579762; x=1715184562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2spOwtWOqMT7Ms41TL5RVzlbesAQkmsONqFkI4fS7c=;
        b=TH6sMGYnvrKFGRTzf/D2pHDicpJ9aSMx1ocX2nvQjVZte4r7RViEm6XGw38kvmy4x5
         Zd/oqY8s8qKaVIzkFrM7rk5Kj9M7zE8b8ZsZgrBtGt6S1ezMcwybcmBEAnOHKjHwYA3i
         6rAly5HL5APOTTgTFJY+7HMvw+lW7g4bITDdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579762; x=1715184562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2spOwtWOqMT7Ms41TL5RVzlbesAQkmsONqFkI4fS7c=;
        b=LNFzGFfc1mGTPkXylrUmoEkdldpTT1mili0AyyfkzJfq4uOjpLDl80+97G6tghaLOE
         /Nc72PNOZcP9y1olIDMyYWFJn1nm8eNyG4dBlEZZZoCA/IhjRDbHCQb/Td9mASYUiFg1
         EoHIoI4lvRDakth3fhQKt6xrS5dA/qNCpXFqUaIc2BfAR5d3UG+KRXfk+WICpFY4i5pg
         ZWugO6Veofz4T8eQbsqC5zsL7zvny8LU4duuymNDSBLJIUrhchspbXuZ1Vs93GlKDqaj
         DdHYYi8nwuLE4SckJYd+qpHjTy+bMPxp4QeWjjjgScwoj+14oZqTi00Xu6iW1JsZcIsc
         2t2g==
X-Forwarded-Encrypted: i=1; AJvYcCU2pHWcmOR2tSDMV/Llt2X1Wux3n+ijndlWzAZphVq7CxbFsP0UfIKb4XhCEGmZm2w46oYLKg32TbdAnNWEXfuUfxPjW1k3yYK0CjkX
X-Gm-Message-State: AOJu0YxGinX6JHQemtb4uY+o3WkcAcUAqyXz8OQ/B93Ialw5er14BR4i
	ZVeY2De5+5RStoEk6cnYh1PjQXrWK4jrb8228qG2xD1ZqgJ0PmV2zePL9WDaSnZdynOH54fqy5U
	=
X-Google-Smtp-Source: AGHT+IFItGmM4BSSvzXzZvagSGywhuS0rs0a48PeUchgjYjRETBmkibU0KGmXcn5+moleehO5FPSSw==
X-Received: by 2002:a4a:b00e:0:b0:5ac:a573:7422 with SMTP id f14-20020a4ab00e000000b005aca5737422mr3003611oon.2.1714579761816;
        Wed, 01 May 2024 09:09:21 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id dh3-20020a05622a4e0300b0043c7d293f9fsm848206qtb.67.2024.05.01.09.09.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 09:09:21 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-439b1c72676so77851cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:09:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzygKelBNNZx5WmxEIx+jyOghxAqwHqgSEyfDojt1oowqMu84PPQ6D7rcHVt4fMNcXXDoEkc19eHSzd+zFofT+9F0NbnFTvoaaz92J
X-Received: by 2002:ac8:5d8f:0:b0:43a:c84f:5689 with SMTP id
 d15-20020ac85d8f000000b0043ac84f5689mr233727qtx.1.1714579759956; Wed, 01 May
 2024 09:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501051323.805076-1-sui.jingfeng@linux.dev>
In-Reply-To: <20240501051323.805076-1-sui.jingfeng@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 1 May 2024 09:09:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XdQjEM05Jw7iVVcHbJ9oqy8qQeH66oxf2g304QKDaL=Q@mail.gmail.com>
Message-ID: <CAD=FV=XdQjEM05Jw7iVVcHbJ9oqy8qQeH66oxf2g304QKDaL=Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/debugfs: Drop conditionals around of_node pointers
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 30, 2024 at 10:13=E2=80=AFPM Sui Jingfeng <sui.jingfeng@linux.d=
ev> wrote:
>
> Having conditional around the of_node pointer of the drm_bridge structure
> is not necessary anymore, since drm_bridge structure always has the of_no=
de
> member since the commit d8dfccde2709 ("drm/bridge: Drop conditionals arou=
nd
> of_node pointers").
>
> So drop the conditional, please also note that this patch is following th=
e
> convention used by driver core, see commit c9e358dfc4a8 ("driver-core:
> remove conditionals around devicetree pointers").
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
> v2: Update commit message
> ---
>  drivers/gpu/drm/drm_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Pushed to drm-misc-next:

235e60653f8d drm/debugfs: Drop conditionals around of_node pointers

-Doug

