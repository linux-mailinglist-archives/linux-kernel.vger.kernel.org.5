Return-Path: <linux-kernel+bounces-94713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6998743E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B811C20F13
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41831CABE;
	Wed,  6 Mar 2024 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YFUw+MTo"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41961CABA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767789; cv=none; b=D23psj6k3KsdpM9/7EYmE0grHisyecWUd/JnJgi4ulCs4QVgBDFCWM2oSYKgdsKzUya+FXepsNoE/HQjLAbkZxW2HDLleTPy/bqf4pv3+baW/oYYtPyWIhXu0GfYC/TKHfaHPi2LkB/AguylIJkAI0mfWmRY5TxIqQ3Zdg9j0xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767789; c=relaxed/simple;
	bh=DnBm+bQ7E7yNZiUAZm8JEJVZl/3UDOMDBbFg7w2+z2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHaK/IYCdimDnWrDAUIuNlx89tWFmBksSuRIpWnpfYkP0PBZAfCHKPnYHOt6ekrHmIk9odCj8gEP3mjSMAN/5VuplSeNlpWP+k6kO6sF23gVDFhHuKmSTyVd7fBMdxtfBLPWWChWZuVGLej361zNE68aU9HLGGvOS9dix9LsJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YFUw+MTo; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e125818649so184336a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709767784; x=1710372584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaFmd/1u2c5uMjx4A/ChsNo48SDfCVdtCDWwH1LnNag=;
        b=YFUw+MToRUv8dKCQuMzu75lO/maJ+lcBjuNeb4h6EbIS5V0IFwiPLWuWL0EtUku8U1
         G4LutOpGZkwlS3Ga1nW8qney7mwUYimPGHgdqoEPx+AtOwyDOERszyrQ9Z06wC7hZAoo
         7238BZDgvVu0dJwIB9IlENMSxo1nSN8ivrW2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709767784; x=1710372584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaFmd/1u2c5uMjx4A/ChsNo48SDfCVdtCDWwH1LnNag=;
        b=NSs9Oig0VjZ4f/3ImmtFkjoMVENXaxh3xk9mzKpRg4uh3IybumpJiaRE6ALbCftKiK
         HxtSsJ1wtA7XoMdu7O2TO9FUNfjC7HnjMC+wDkqKWCqvTSgLPcj/Cwv3cHltbvIyDVNF
         I7dTJWdAv0EYReYxe9Ji3AedUf/1UQWx+e+cbv+ncoVOrCd34QaSTO/R6WrWzBB74jC7
         UFqQqODh3TeBL+RtkaRrfJq79OF8lxMQcjWVSGTMW7A1XlTP1rWfKXUa0lJ7vLzMTQuu
         6i0KU4HIBGB1Jmzdk77sSphy7L05tMzZ8F6gBAPjuKKEyv9GQj8kunN1xxQUZKib+Snh
         /Ldg==
X-Forwarded-Encrypted: i=1; AJvYcCXxUyrir/FFUTqjYco+v4kJyQRR6+xYOzT8ta6ErrVxXKlz/YUNt4mCBMBRYyo4wf1GMuw/3z+uGWdQY9lgyj9VrHFvjcYlHdZnbnJP
X-Gm-Message-State: AOJu0YxCGinx4tF+aDorY18gG/wd6XgzNv931wXh22tS2ZgwE4VZ8R4+
	vt6FV786Kzd7t9WbtaJ6cHEn08BNaYH+NSOZrnao/V6BJxvNZuBscOYUfxTBRYcg746LHvSw9fs
	=
X-Google-Smtp-Source: AGHT+IHmgDj0pOv28JPbib4KD6blAMNdhXER/xZQFGPgp9VfOQGPT/cmqvbFXrbx+KY3KCMZ6oEMWA==
X-Received: by 2002:a05:6870:220c:b0:220:b839:4bb0 with SMTP id i12-20020a056870220c00b00220b8394bb0mr6825490oaf.19.1709767784491;
        Wed, 06 Mar 2024 15:29:44 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id l4-20020ac84a84000000b0042ee49dd434sm4254123qtq.29.2024.03.06.15.29.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:29:40 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-428405a0205so54981cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:29:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzhy7RdTInFzYuB4rO7HpZe88vcO/jXaT+8AO8k1UtDoa/uE5i67oZnclkKty3vVNW3uAKLKxYmy+zuD5f4MQsCUP273eY1jlB2ndg
X-Received: by 2002:a05:622a:64c:b0:42f:a3c:2d47 with SMTP id
 a12-20020a05622a064c00b0042f0a3c2d47mr159395qtb.8.1709767780037; Wed, 06 Mar
 2024 15:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200353.1436198-1-hsinyi@chromium.org> <20240306200353.1436198-3-hsinyi@chromium.org>
In-Reply-To: <20240306200353.1436198-3-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Mar 2024 15:29:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WvvLFN4U5-EewpXEcT-gz0qO+2SrYdEQpC-+s0DBeBUw@mail.gmail.com>
Message-ID: <CAD=FV=WvvLFN4U5-EewpXEcT-gz0qO+2SrYdEQpC-+s0DBeBUw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] drm/edid: Clean up drm_edid_get_panel_id()
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
> drm_edid_get_panel_id() now just directly call edid_extract_panel_id().
>
> Merge them into one function.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v4->v5: new
> ---
>  drivers/gpu/drm/drm_edid.c | 39 ++++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)

Personally I wouldn't have objected to this being squashed into patch
#1, but I'm also OK as you have it.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

