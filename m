Return-Path: <linux-kernel+bounces-106292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E695587EC0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F99B207F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71974F8B2;
	Mon, 18 Mar 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqvoI9te"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391614F1FB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775385; cv=none; b=oXRLKxmtuzo4DzQwxVsEO2LyzzD9Blxe6/V5jYDJ3Vu7afccYaGXiDFBDnHbnQWt25/yR/OAG6SUHKnsSOFC81mAoA3KFWsMkopOIKRTGeKkKVfSPBmSJpPhDqCcelQcdedQOvRJ1okjisXpmUuCIEuUJA6n7UPZ+G3vQrgJl2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775385; c=relaxed/simple;
	bh=PFKY8P9uLN62ApI+Z3FFCcoXpZUmlFDSZSeMeJysXY4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k26RtbuIvupDOAIGaX6knZ9U83R+kJmHK37XgDGKpOztESH8uEQ/JTXeUaZV2u611ZvORiwKiJsujnpVrhcLuyZEn92GTOCRD0Uf+b21TASoKGbNNx5C6NODcrfcJ5+CVc6JjDtYtXDLmE3iys2niwVUMW5pFTfiEz/rQmsjXbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kqvoI9te; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4141341f1a8so4793265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710775382; x=1711380182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sut0DqIpwqX91jrZWIRaSBuVK+4YCVtsDkrn+V+ry8M=;
        b=kqvoI9teGiVYd8oCgE7zzSKMMhdmj66BaN+gCAkXCSnTW+JnXTfzW72FGn1/Fa3cr9
         LafBpwvPIr0HY0QWcs3Jk2CThIS03/ApMK85sweyBfR1sAQcEtIc978e1WYwOSJCx4kM
         LJiCv3kMy2dnKtPrIrUtYke3m0VWDFmANzP5w5TTXgc2bBqUESDvuxVC6QCe2GFBhu6s
         mwsKym+HPEspEOEo9IEfCVTnyWqERPjoodG/6ApLkl9Xw+Tbo0gCjeg+m5f8XFCmuGvD
         Zw8cJqL1dqFohDyC8YvUD9WX0FQ4E8/e9b6OM64hBBONlHc5cVRrX+Kt6s175wGpQOpJ
         p9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710775382; x=1711380182;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sut0DqIpwqX91jrZWIRaSBuVK+4YCVtsDkrn+V+ry8M=;
        b=kXq8zl5QrMbFwJFjw2CretCM5sjnJoYrshz3BD0vE5GHGiuIhjqaCWxfhDMgoIuK+e
         KDdOJu3H5RTEA3unmde0zgA7VJfcQazIKpn/LMxLrFq1g0OBYphzbSLksDfdl0zATojw
         NBGbKG/Ojaxkes4olN6zVV8tiTTk0SKeSr7QPnDmEAKmuK+lI6rJmsI5v54dSNsm5nIs
         LiLB82li5Bywr+v0ZIKW+6OmsX31aGVWJ3TnrAEfunnk/CTXKsmXrSrBb76ROz7KNtME
         XtKscnNYpB5MLagxNQQ8Xnbuaz5gDUz7ZfTY8BjXNfo5lJJvYcYsNVpWcYXZPT3+qplk
         1E1A==
X-Forwarded-Encrypted: i=1; AJvYcCVz9Luq9y7cd+USlFTllfCOCpHBqERK1vFuH0CKc3IoEIWF6SHAit76C/MEsZoGpvbpt60bmKPPfz8z/69XVlNRoDnK/9Cc/SOSlX9y
X-Gm-Message-State: AOJu0YyImgRVfMCGbj89OawdPyo0Xg3RC/tu+SXGlSr1W9X4jH8QljUU
	bU23Wkh6Y92yZUMsyINysDzQDV0+csTrASt5cXsVDmVa8RbxpN9U7od/l9zUz+8=
X-Google-Smtp-Source: AGHT+IGXNkgAFahUOxtfKfiWh1w3pGZblZ1/BUAf+/1flkV9GmtT/uu/WYWOcC3ZLpemGuq4U4wCcw==
X-Received: by 2002:a05:600c:444c:b0:414:12ef:83a9 with SMTP id v12-20020a05600c444c00b0041412ef83a9mr1675347wmn.20.1710775382539;
        Mon, 18 Mar 2024 08:23:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b00413294ddb72sm15047500wmo.20.2024.03.18.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:23:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Phong LE <ple@baylibre.com>, Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240316174419.1170460-1-sui.jingfeng@linux.dev>
References: <20240316174419.1170460-1-sui.jingfeng@linux.dev>
Subject: Re: [PATCH] drm/bridge: it66121: Remove a duplicated invoke of
 of_device_is_available()
Message-Id: <171077538170.2168000.2876052780716705591.b4-ty@linaro.org>
Date: Mon, 18 Mar 2024 16:23:01 +0100
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

On Sun, 17 Mar 2024 01:44:19 +0800, Sui Jingfeng wrote:
> The calling of of_device_is_available() in it66121_probe() is duplicated,
> as the of_graph_get_remote_node() has already do the check for us. There
> is no need to call it again, thus delete the later one.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/bridge: it66121: Remove a duplicated invoke of of_device_is_available()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/2c7d26555845ca5fb70353b4b77d8f6c4e32e54c

-- 
Neil


