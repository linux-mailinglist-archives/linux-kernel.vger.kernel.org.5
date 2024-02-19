Return-Path: <linux-kernel+bounces-71009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC7B859F55
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 098BAB220F8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF30222619;
	Mon, 19 Feb 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dccw8q1u"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC922098
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333873; cv=none; b=E881Ed3A9T6srArTTlYH2zMXNGAIeR8Oet4O4l9cb9adJNgGceeIi+2+o5z/d/hUd5q6qyRItIAmImraqws88hAEYBeCRyaw7/cR7+D8SOz7s3tSjWR+zeUJK6QJmxM2RdxzE0qSlaQzPp0VYEFFwnNojeJRpiwyEKd7vUOqKBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333873; c=relaxed/simple;
	bh=wwZHmrGbJWh0b7ZTyX7zE2wXT8mAd1Iwl46dGtT2SwM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M2YkAi/VTZJwtUCFmjAxMEW6bMS1QG/hH53XHh2PpMnL0N4szf5SRuH6LN5FhJkTRS31lvdmV1V+5Lmm9u8QUKd5yED413bt/Ru2r/lacO94sTtf5UVwO1+0ox7dbKfS+s6182RaetirKerTzWqFdPTNO61RmjidjHGuXx/N+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dccw8q1u; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c15bfa17b2so212888b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708333870; x=1708938670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+h4S1K1tLaVXVrg7ekOJUruu89mTgLkF+9ddaVZWrlg=;
        b=dccw8q1urCRemJmfpgZEy1R7gUvlQu738ZyeoWdJfKmpVd/xxUWHtTceA7SnwYDRUp
         UQn+HsgNj43UIdJKZa+EoM/SujwDSwIPq41MdkKXuk+hlEFdWsJOR2Dp/M5YZJHaH291
         50vrA7FYPHrGjRbOk/i8wHHBA6DOh+/khcbMtD72ONUEIbwlpv6rGchiheDPqpGs/ZQZ
         qecWbnOvLWZrusnN71SbgoyAcnHwjE8P2h/7c0g+W4/6vfbX2mXgy/F0FXu3skMPItSG
         nmCaCpBycR711uhEGpFVFb88RNXuWfemQ/fUhK/gQqsF4ywMcheFrnTCIPbfVs/fQ09t
         9WAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333870; x=1708938670;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+h4S1K1tLaVXVrg7ekOJUruu89mTgLkF+9ddaVZWrlg=;
        b=E9ATHYySDXmtGcMWIIlHmLTdl3owTsA/DerWBSVQBIpab86MOTcozxv/fzUie12wFr
         wigH3TAguBbW5mrGLoT4cuWS9TKQQdiQw/dg+dz7hN9l7i6P8RZ/hPoJniIySuR6KX4S
         19On9BvQh7ckkWTsOik2GD6SeS4ocP9icvhAX2yx63PXw5P2ONvtY2X1hZdvgon0TSbr
         g9dEe9aPRC62jpQO+KQdPIHw6w9BPIthxxhvIqKfyNHSBwNyOPlLEKR9uCleRgbjBO2p
         fI8Z6TMVQrgRZRMrDvEn1dqWMM2XkI3sYjOMLAk5QI3V1lzl9SopXIjueV/QgUp2wcTf
         +PTw==
X-Forwarded-Encrypted: i=1; AJvYcCXFIDfzuW/xjdavLjGC6i7PJ59RcHJs0BVhJ1L72hrMyHpcy2gUY3hCEu+8YGsbFFXOQguwf5u/kurTVXECQrmUczwpAReIg6IYXfzB
X-Gm-Message-State: AOJu0YxbpIo9HwRxBdWfE/FRUSwb7oANH2qYcDgMkxgSOJVoOkBx8Wob
	+yRbx9BJCw36t9+yhBu3IwWiFY7lPGavhuRnORx7ytd6Z9AlLO2gTiXI+naGqrY=
X-Google-Smtp-Source: AGHT+IFrJDEsmrNpenTSRtilhd/10AdR+4gy/uGPKPaR81L4w/RKMIvbZJSKvSK+eK/CCppY8sGY5A==
X-Received: by 2002:a05:6808:1c5:b0:3c0:4229:89e5 with SMTP id x5-20020a05680801c500b003c0422989e5mr9494381oic.51.1708333870551;
        Mon, 19 Feb 2024 01:11:10 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z16-20020aa791d0000000b006e0d165f8a4sm4307506pfa.20.2024.02.19.01.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:11:10 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, 
 Douglas Anderson <dianders@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20240216123111.1.I71c103720909790e1ec5a3f5bd96b18ab7b596fa@changeid>
References: <20240216123111.1.I71c103720909790e1ec5a3f5bd96b18ab7b596fa@changeid>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: make use of
 prepare_prev_first
Message-Id: <170833386468.1779963.10700248718904415408.b4-ty@linaro.org>
Date: Mon, 19 Feb 2024 10:11:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Fri, 16 Feb 2024 12:31:12 -0800, Douglas Anderson wrote:
> The panel on sc7180-trogdor-wormdingler and
> sc7180-trogdor-quackingstick hasn't been coming up since commit
> 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI hosts
> at modeset"). Let's add "prepare_prev_first" as has been done for many
> other DSI panels.
> 
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: boe-tv101wum-nl6: make use of prepare_prev_first
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=42a7a16bedc991190310a02dd202e29cfac52525

-- 
Neil


