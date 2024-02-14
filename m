Return-Path: <linux-kernel+bounces-65997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60908855508
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE76286954
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F401D13EFF6;
	Wed, 14 Feb 2024 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+mtiC78"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1721DDC1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946900; cv=none; b=okjWDzQzkrgqXr5F9oPgD+nvoKfNkpQFH0WSxQZbZEpruHTpsWVZOwNuPC+SfOqZEVVs31ZLGriqjAVwlAjL63uSA9JMsmT1QVzH1Xl4h79vyzLwue5ufKwcQ4fNEV9z3c7yhtnb27cDXuY58xRKMlAWKUe+XKiPIW/ooOIHRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946900; c=relaxed/simple;
	bh=EHfWJjPiWn88jq5xGGDBdva+KaTyzMMLFJA93x+8IeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud7eEDU2IHXH7506y6riTAZS2WrwJocJWseh09LeekQppz/kRBN7ObETHxD8SOe0l7vxP0IRcsTYL9VtjLzKEBxZUj5QpyzK4G3iCyiZubJOr0UTuFaW9oiWc2Ij/hDu8Z62LGPLLt7vJUzzr/U/685zyupRwDnI1y746eAMcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d+mtiC78; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0d95e8133so2145341fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707946894; x=1708551694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnjm8I32cDhuopRTHQD8F4ipS3W9vZirc7u9Gsk+x7w=;
        b=d+mtiC786jX1xQBH3qwif368FWu5+51EF9dl0o3uxk/DTKHA3fdNeHz/pstFP+QExf
         QMc+WRuTJWGrlObPrqmygoykA4h69zq9kFOj5NlD/KxLIQ+0iHrEmxx6yzsWSj5pRcrA
         jfRyGZRZaw5R7bqSWfMcUR3X2JxH/hmIdyaf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946894; x=1708551694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnjm8I32cDhuopRTHQD8F4ipS3W9vZirc7u9Gsk+x7w=;
        b=ZRNS+Rf5jh6xywAMeE0XSHrcN5aMPFFtHRSpEL1OIOdjJDPA/3V/61OWY48vFbd79l
         Gdr+0NLLZAsUMT7hAR8Xjmlr9Ww3KplmSgl03AiIFzKh7nuxJ/jzEMzkMaRBV0qDX2vh
         Pdg2ZW7KVue7KKovVI9+CHXTK6n/gIThfX00rnRhpIEpatGEPS0anyOOrp0b5kUm7tLv
         rGPjB4smENzI9Yrd2UbK4aVMsTM5e5yAWM6Ev/EHE6V/5YHryhZMXdmAN9itu4yoFIhj
         FHfWg5J/Y1Fglt0+NPEbdeejtjJAiGSdjSLr4gxgGArbOaijhB78UqCxqIe/ldGlH7It
         RWxg==
X-Forwarded-Encrypted: i=1; AJvYcCXRna4TXgMUaMf5nb19cZcXjNHn7PljIHPHbsSN+XTevt7Zsxe7qMy3G6vRFr1/tDZPce13BUWpmXFc2Khgix1dBnlNNdNhyxGww7zf
X-Gm-Message-State: AOJu0Yzpm9/74/+oHSUyYBUWg2+YCo3UQHIi+UCVZQMcwheyeD65oEu2
	SDqmXWW9uAFpOc23rprkXA/D4N0983M52pywl1FbMONdvylwA/yIGJa53hjNKYby+hXb0WWvcLl
	46x0S
X-Google-Smtp-Source: AGHT+IFelYPnBwSVaBVMJWCeYNeLginQ5XMTq8ehEmhOYB1wH7NkC8vrCEc7iwl5t5TRz2l6qs5nKQ==
X-Received: by 2002:a05:651c:483:b0:2d0:9b1c:649e with SMTP id s3-20020a05651c048300b002d09b1c649emr2418724ljc.31.1707946894499;
        Wed, 14 Feb 2024 13:41:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXI6Ehii6DQRA30v9J+7vBTjJbNW0IfqjgIQkw+fnU67ylvN+jPaKBqZd9k7VRxK1aA61REQK9rgwmo677ZPCrjv3D497USuBIYhS7E
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id x63-20020a50bac5000000b0056368be8a58sm899555ede.27.2024.02.14.13.41.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 13:41:33 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56101dee221so735a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:41:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIyJNv5rxFcaBRM3mlRmtZhTBluRcXKiI7PJkvStO7J9r+syufEB8Q2zwP2QRqjkmTqYoYL5/7GU9SbtG+cMJICV/u5TcsmHSoL2cR
X-Received: by 2002:a50:9f08:0:b0:561:e7d8:50a8 with SMTP id
 b8-20020a509f08000000b00561e7d850a8mr369992edf.0.1707946893039; Wed, 14 Feb
 2024 13:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214072435.1496536-2-hsinyi@chromium.org>
In-Reply-To: <20240214072435.1496536-2-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 14 Feb 2024 13:41:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VmDZvWVJ+DKN5bMPvJaLouNq26=Qyd4N9O+a0FeWCJpA@mail.gmail.com>
Message-ID: <CAD=FV=VmDZvWVJ+DKN5bMPvJaLouNq26=Qyd4N9O+a0FeWCJpA@mail.gmail.com>
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

On Tue, Feb 13, 2024 at 11:24=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org>=
 wrote:
>
> This reverts commit 70e0d5550f5cec301ad116703b840a539fe985dc.
>
> The overridden mode fixes the panel glitching issue on mt8186 chromebook.
> However, it causes the internal display not working on mt8173 chromebook.
> Revert the overridden mode for now to let mt8173 have a functional displa=
y.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)

Given that the breakage for affected mt8173 Chromebooks is pretty bad
(black screen), I'll plan to just wait an extra day for any screams
and then I'll apply to drm-misc-fixes.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

