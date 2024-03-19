Return-Path: <linux-kernel+bounces-108197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958D988075A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2937D2841EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBF93C6AC;
	Tue, 19 Mar 2024 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yIBlYZZM"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B23381AD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888312; cv=none; b=qQgJC+OyeN1chFYPc0tcEUHYVEaZSg7uLOsZrNA0scdnW1zOzhf6MFwkwvzq7ojFtOqJWtZmINguqCF04/LKJQfr8ybgVzD1pNejuCzSqiNbB0RGzEuexokv7V5cwyiZyzhzY05dFLBJtaX7JkLMaO77zCa9h7dO/Sds4j5gi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888312; c=relaxed/simple;
	bh=jczcFVTaYhGigMO8m6XsP7+Z2CSGS4dJUSBbeEtzhR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHi68DOmQkCnrh4l4S7xMYikdy1xdrllHOTbHnBkWAZOTLXlxytoWkslVv93BJeOnW02wrI8losm5mv9nYagbTdAJk3oma1ZKqTfYPrw+tMvrMRGBK6jVZq3w+WFzdxVMQLQ/Xswizr195kRctQ+52Qt5C49C0InqsyFpAGMc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yIBlYZZM; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-609eb3e5a56so65894117b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710888309; x=1711493109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pQqzWk+vG/Yifue6kYN9pL804kvE+CAcl3rI2SerYrg=;
        b=yIBlYZZMV6Q3gUNAJCZ2qSB7wSaIJIqshyYXH22z6UKWpyzJeqMMV74xKwwKaYTXQp
         recwe1GOCV6QPZzFodDtBbfuQc1pdc8yKAzmIMenkXfSzCyqU+Lww4rdqrXIMzXhosqa
         4Ax3MRjWGPD4TzINZA3YJN96Cs7poEcMmmt3Mmyc3WTWAiBn60DKSdgqgOCfqTk5Qr/T
         6jX8OBI25o/5oC+DXD8UYcu8EFpUXFCo0Gq7npcL51opQEj1kg5fKE9d2jEcEnn9+t/U
         xg6o5Y15o7Mgc8LLphRJtjRvSQu0CXWdaDEyQfChQGe1dJcdD9VBs9fGE5p3cDVH2CPX
         l8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710888309; x=1711493109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQqzWk+vG/Yifue6kYN9pL804kvE+CAcl3rI2SerYrg=;
        b=dUZNscEMSBadJzSLapICbmJH1ARqaWTRZ3QVIMqDH8QSK8hlN/QShqiXb9BfKeC8au
         kgIY48mK140yXLUv81Zu0jFcNfIAV8toKCKgT+eT8VyHUEysPPGTr7f9P2OP9FxVs9AF
         GvIKOgkfJpyWCKjR7vJ1CHA67P+jLlLocBnzSp7mgBYZiRdkbBJ4Hu++qCNVjHg/M0P9
         kNM6dZS8g03EELAv0Z1pqPm1uWK/zPIiIQjMw6NiuT5uMNFBk890JljkP5/3tGcXh51o
         KQ6wo2VZBqdScsIX1EYnbubCXJWIpSJH0Qe6pySZ4hyvZyvgYmzemWoq9Gs/XLE6uJeH
         sBcg==
X-Forwarded-Encrypted: i=1; AJvYcCVRtaZCkaDHaNsOF4cC49hxoEaiv3BVd9dKWpd1CFtVVucEk3Em81e6RdwrkV5uHLDP3GggwymNgzIUrT0LQ+RbcDu6N/AEnvrqJeBy
X-Gm-Message-State: AOJu0YxZl5NJTHJT0HDvpemqa0tyE1zF6PlPYJcqaH3r+VcCVKSiIDp3
	Xdh3pEXjzEQ0Bak2XlTOKK9qhGVxNDY242Ed3a06AifnHc/JHrru4R1dgY3mOLn9oTV7g7Dgm5B
	RfAl9OsL07ELz9OAwAwrxaOeiOxVE865YL5swbg==
X-Google-Smtp-Source: AGHT+IHAZs2FKAPJJSOuCRtpl8N3osuzygCJ/ew0ONS2Wfx9/D47o8Y7hTNZXigpA+m4BsbEswZ9ChA4+j+EbdZMdiI=
X-Received: by 2002:a25:abcc:0:b0:dc6:b088:e742 with SMTP id
 v70-20020a25abcc000000b00dc6b088e742mr15020800ybi.8.1710888308713; Tue, 19
 Mar 2024 15:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319135836.v2.1.I521dad0693cc24fe4dd14cba0c7048d94f5b6b41@changeid>
In-Reply-To: <20240319135836.v2.1.I521dad0693cc24fe4dd14cba0c7048d94f5b6b41@changeid>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 20 Mar 2024 00:44:57 +0200
Message-ID: <CAA8EJpoCu5+KPJEeCSRLCgSQmTNxNsVCfP=9e4mtFaqADuuKBg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/dp: Clarify that wait_hpd_asserted() is not
 optional for panels
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Imre Deak <imre.deak@intel.com>, 
	Jani Nikula <jani.nikula@intel.com>, Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 22:58, Douglas Anderson <dianders@chromium.org> wrote:
>
> In response to my patch removing the "wait for HPD" logic at the
> beginning of the MSM DP transfer() callback [1], we had some debate
> about what the "This is an optional function" meant in the
> documentation of the wait_hpd_asserted() callback. Let's clarify.
>
> As talked about in the MSM DP patch [1], before wait_hpd_asserted()
> was introduced there was no great way for panel drivers to wait for
> HPD in the case that the "built-in" HPD signal was used. Panel drivers
> could only wait for HPD if a GPIO was used. At the time, we ended up
> just saying that if we were using the "built-in" HPD signal that DP
> AUX controllers needed to wait for HPD themselves at the beginning of
> their transfer() callback. The fact that the wait for HPD at the
> beginning of transfer() was awkward/problematic was the whole reason
> wait_hpd_asserted() was added.
>
> Let's make it obvious that if a DP AUX controller implements
> wait_hpd_asserted() that they don't need a loop waiting for HPD at the
> start of their transfer() function. We'll still allow DP controllers
> to work the old way but mark it as deprecated.
>
> [1] https://lore.kernel.org/r/20240315143621.v2.3.I535606f6d4f7e3e5588bb75c55996f61980183cd@changeid
>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I would consider changing the docs to say that implementing
> wait_hpd_asserted() is actually _required_ for any DP controllers that
> want to support eDP panels parented on the DP AUX bus. The issue is
> that one DP controller (tegra/dpaux.c, found by looking for those that
> include display/drm_dp_aux_bus.h) does populate the DP AUX bus but
> doesn't implement wait_hpd_asserted(). I'm actually not sure how/if
> this work on tegra since I also don't see any delay loop for HPD in
> tegra's transfer() callback. For now, I've left wait_hpd_asserted() as
> optional and described the old/deprecated way things used to work
> before wait_hpd_asserted().
>
> Changes in v2:
> - Make it clear that panels don't need to call if HPD is a GPIO.
>
>  include/drm/display/drm_dp_helper.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

