Return-Path: <linux-kernel+bounces-158164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1218B1C68
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80401F228B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA926EB4E;
	Thu, 25 Apr 2024 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqe5S+6r"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE816BB5D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032190; cv=none; b=PXJ8npsYH0W56xsCEjxkq8xDZmObVFP9+8FLxkKmwhFlZLc+qaCGal9PlcN1PdYbLoteQGty12i0oyxCv2tcAtWxOpNU79hifeiMF1lTcpBceXNpUy3cP/Oa9HQn6y+6UTo64Yn1nvlbuzv3c+ynIwiyLoeoH2nbrFGgmoPo+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032190; c=relaxed/simple;
	bh=Dv/1Irsuk+EStz1F4AIgJ6Ur17ysV8gdm0BilvGUwuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZK5RyewWIALesGKS2A4nRkSO6zh+GKOB1KfywkFbzaKJDjRuaqdxDpFAnOAwLe789dnujoUVe2Vd0I7bB+bgnsa4q3pceeL6/NVn0p+dep3uvlDFfZUmijqLsPRyaj9HTklc8hnjC6xPSEHcewtG5TpI+Rlu06fBLVFARUStAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nqe5S+6r; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de477949644so795771276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714032187; x=1714636987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y2BwMZXFm0L9AAXwMySeLBZN60aZGomq2yuNgtOR/fg=;
        b=nqe5S+6raIzck0Rt+T5Q6dzMTQYA0Qu6M4wkJ8VsO0uzLncAUkZ3skg4Td1+gJOJK5
         nACf2P2iLdafj8KNY0jROAJTGv//R1NqGO2RIowAmRHKY8elEz/9RY88NH5EzRf9/brd
         ye2PzNRxBtFQA63nMdiWrf4ZIcW7y/+8vqfXpoN5XiJOZhsErQt3vlLMx5SyVHRlVuT1
         nXlnegP+iz7jZXlACGItWf0YQAf6shM2cF9TLQddYr/7TqrdO2+fSbJrSjwOjhfHY5uY
         QS/AQweW+Hh7bW9RDhk/4eaPmk3FW7Edxe80WQtRiPkxL3h8PCVCcE/FOvhmUSGcNz4V
         /HUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714032187; x=1714636987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2BwMZXFm0L9AAXwMySeLBZN60aZGomq2yuNgtOR/fg=;
        b=M6Bq1sFrNlUCQ5LPDvjmCD0XhOPLGmfrEB+4pVubdDflZ7JkxaAzcg7Tvk9JPDK/hD
         8o/gErWtMw41RKZH7gzAK6WxFU261otqomWqYKLfU1PpFB0fCrcXIyENRtTz4FwZyRsR
         lhB8XEvZ6gQK61AVgeeo+5Bruuas1lCy/vOSfceeSQoGkDAEYvfW6/QInuEBGTPBCYs4
         LwE0LIPDDOR+yiWgmUyrvT22R8OxEsem9yEpw8CKvZo1MkZO05rrw0bN6rPGxTuv8SaU
         LnHYQpk39pjCtCR1C8YGsTHlt7xZYLoCCTBze7z8HA1BxyqfGAIu+9njNKnGuYBwx/nR
         v90A==
X-Forwarded-Encrypted: i=1; AJvYcCXbD4zZKdAtcSuc9P2lwXqGDQfL97ZF9DOaI/uyNyejY4h/Fbdc0XfxOwZY3DeoyemKSOuoluy983FCzWO7B9kW9TgwAWmdY2DFSw7J
X-Gm-Message-State: AOJu0YzSIX4b4FmnzOp0NH1+evSYWpnizwlxSqf+wzQY9dh7sgwvfE+T
	HrTxajPGiPaUyK+muxp7r2IinMGguhZpAbSTcTPO90SB1P9P5O8JqiIsENkgJBWlOncP00c97rY
	SfhdZ0bOey4hh1GNDcmAbMqeDiXeooreTrRp+5g==
X-Google-Smtp-Source: AGHT+IFkldo+vd6Mqtt1W7SjY880Ctl0aJc8yw+e5geIUtLXOum8JAuNYHkA+bs9AdjkfTBSrq+5nwYSpMu+pDUVJ60=
X-Received: by 2002:a05:6902:604:b0:de5:4f40:689b with SMTP id
 d4-20020a056902060400b00de54f40689bmr5315526ybt.25.1714032187496; Thu, 25 Apr
 2024 01:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330202741.83867-1-krzysztof.kozlowski@linaro.org>
 <ul5vzz54kppxo6zkr7k6seejmmlgp3d4dqfzjlj5la3e5ltolo@ug5dtoknkibu> <16de57e6-39c1-4528-b9a7-8b8af2ec6880@linaro.org>
In-Reply-To: <16de57e6-39c1-4528-b9a7-8b8af2ec6880@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Apr 2024 11:02:56 +0300
Message-ID: <CAA8EJpp0KNXWdUVd38-+cOHOC45_orzY5vrv_VxtE9-Weo5QUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: chipone-icn6211: drop driver owner assignment
To: neil.armstrong@linaro.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 10:47, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Hi Dmitry,
>
> On 24/04/2024 11:12, Dmitry Baryshkov wrote:
> > On Sat, Mar 30, 2024 at 09:27:40PM +0100, Krzysztof Kozlowski wrote:
> >> Core in mipi_dsi_driver_register() already sets the .owner, so driver
> >> does not need to.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>   drivers/gpu/drm/bridge/chipone-icn6211.c | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> >
>
> I tried to apply them but you already applied them... could you make sure to notify the list when applying ?

Ack, excuse me.



-- 
With best wishes
Dmitry

