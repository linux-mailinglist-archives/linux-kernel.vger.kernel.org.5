Return-Path: <linux-kernel+bounces-94712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9080F8743DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A8F1C20B00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C11CA84;
	Wed,  6 Mar 2024 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aMBk5es9"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7AF1C6B8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767782; cv=none; b=Sp3mqEoaqiq36z6VE8wkfFFYwaBEV9+z/IW57rGKKVbw5IZl1zvnk7d14edFuK+wxr+ZsYwjOMAyQ2Nbq93EocEsOP4iCyqB4J5TbNVGntYPd3TNuCP1R8zJdYLnmuRBEhCTg9yJKrrtore8CNnAp0wd7CEUp5wAZ2esmSo9zrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767782; c=relaxed/simple;
	bh=mo25dRKIB6WKcnbFU6qlCbXXw0KZcBA4ZPV4g0tBQFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWowW1XzzbKjhm2jTAhCd8m2/iyXod0ReJn3CFOI2nyRTEC49AZxQyR6qHhHgm/qEZ0FBPTr/PNpqWXkR7jcxOXQAHXMYqOEmciqxATXJwbXF/ONdMhV0RflNfk6fySi6dHBtp34GnmUD6/MdMBq8TDYLAGtXQN+06ZIm4KjJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aMBk5es9; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc74435c428so265844276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709767779; x=1710372579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGsPzppFtUXfRhn5RIjUZ0vV1nkpHRnqu3sV9ck0Fd8=;
        b=aMBk5es965cJbKwNL9pO/f4uzGrPC92eNbC8ZxCtfBGux9U8i2ARHgc7wPPldEev4a
         oDxkcrc5sVnQCNgKu7rLUlrAU6jV2k7gqi3G/F+faHRL+7yBk5cJQmrqzRpawXV7mY8N
         29r1662rd8CW3stieVstiBgXg4uT4zi3k4F+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709767779; x=1710372579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGsPzppFtUXfRhn5RIjUZ0vV1nkpHRnqu3sV9ck0Fd8=;
        b=v+IQEAJvWBHuoF0c3jHAro1qDUQRlRua0NdFGzzQ4xiCkv3pF+IPZqMF3dz8GgascF
         No/t6KYAASwOVY+uUQejaB8/0xcxlB3sd6zuxFXRqwQ2l6TvjPZWZiR9K3JjowAgcjGr
         NZWgyeoT9vNiGcOfVQNloaaU5FKZycIHKhwKeSHbdbNutq4XaVn0+Rseu0i5maHgfq+A
         zUUhlSkzCopL0KSmxaTTV/WdkgOiRMENavWHGKRftQZuDO5TcBecAAnF/crACxRWwbyD
         feho6XYuSHA1ZeCVnQa+9DM0hyk7BC2by2swo75KokEcfD62JVXyiuae6JadgEneNgIe
         MR2w==
X-Forwarded-Encrypted: i=1; AJvYcCXgboSYKD9fU2bSBUsw1GP5aZOZp6kT8hpahwDCzn62g1WIXMHK8/2SsUVaLpl7n8AMG84QmrJn8MvGpr01mxA7LCJyYqBR+kyWmO/z
X-Gm-Message-State: AOJu0Yx2DFbIpuB37dCvEGuWg82+zpVOHA/1no/JiAUaPvjfVL/QGHf7
	sN0D3LPtT7xhqKPQUj/gN4HFQnEbJ/L7lLo3ttpX68MR/5tsy0WuuS5V8gAvQUXbjJaIeApAk+I
	=
X-Google-Smtp-Source: AGHT+IHswIoTdz+wKmOov8hEKeXDW6WAJPIpWPSR6pWnvPC4RudJtUP46SuoXRXL0J+o0c/RRyoqJg==
X-Received: by 2002:a25:bccc:0:b0:dc7:4776:e31 with SMTP id l12-20020a25bccc000000b00dc747760e31mr13577253ybm.24.1709767778798;
        Wed, 06 Mar 2024 15:29:38 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id ye8-20020a05620a3b8800b0078836355a1bsm2249569qkn.71.2024.03.06.15.29.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:29:37 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42ef8193ae6so55541cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:29:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRUR4jfAGOMb0MWYJgB+2EKOxKGE5VvMq+CUd+1wI1e7eiMohxBPZpFWDBoJSpg9TZkgDqQkIfFF3EPQHVGhHrfOHJRfxtme1AtY9N
X-Received: by 2002:ac8:5dc8:0:b0:42e:eac5:23d7 with SMTP id
 e8-20020ac85dc8000000b0042eeac523d7mr192594qtx.0.1709767777192; Wed, 06 Mar
 2024 15:29:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200353.1436198-1-hsinyi@chromium.org> <20240306200353.1436198-2-hsinyi@chromium.org>
In-Reply-To: <20240306200353.1436198-2-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Mar 2024 15:29:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XcMRLvSU+_QrNMSOo4JH0hPmA-F3HFjOBj=QwHHQy_mA@mail.gmail.com>
Message-ID: <CAD=FV=XcMRLvSU+_QrNMSOo4JH0hPmA-F3HFjOBj=QwHHQy_mA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] drm_edid: Add a function to get EDID base block
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 6, 2024 at 12:04=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> @@ -2764,58 +2764,71 @@ static u32 edid_extract_panel_id(const struct edi=
d *edid)
>  }
>
>  /**
> - * drm_edid_get_panel_id - Get a panel's ID through DDC
> - * @adapter: I2C adapter to use for DDC
> + * drm_edid_get_panel_id - Get a panel's ID from EDID
> + * @drm_edid: EDID that contains panel ID.
>   *
> - * This function reads the first block of the EDID of a panel and (assum=
ing
> + * This function uses the first block of the EDID of a panel and (assumi=
ng
>   * that the EDID is valid) extracts the ID out of it. The ID is a 32-bit=
 value
>   * (16 bits of manufacturer ID and 16 bits of per-manufacturer ID) that'=
s
>   * supposed to be different for each different modem of panel.
>   *
> + * Return: A 32-bit ID that should be different for each make/model of p=
anel.
> + *         See the functions drm_edid_encode_panel_id() and
> + *         drm_edid_decode_panel_id() for some details on the structure =
of this
> + *         ID.
> + */
> +u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid)
> +{

I'd leave it up to Jani, but I'd wonder whether we need to confirm
drm_edid->size here is at least as big as the base block. In other
words: is there ever any chance that someone would have allocated a
struct drm_edid but not actually read a full base block into it?

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

