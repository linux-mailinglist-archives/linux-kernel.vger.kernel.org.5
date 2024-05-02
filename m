Return-Path: <linux-kernel+bounces-166065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A728B9573
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E621F224ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAB62C190;
	Thu,  2 May 2024 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvlGJWM5"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD4728DBC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714635826; cv=none; b=R2LSYAv9+wk8m9LesIJKNGZs9d/5UM9+sCZgVfwvMGlA0oKBjUcJMeIBhLR6kK3hjflddQFOmudTMn/O+0uVgPyiRhZ4TJBtTwt5mRv9+Ycdwa37f4KxV0FRmY3dbTICHKXm+OyoK8kKbQL3aH0Z4bt7ohTzsrG9nLUq0JPvAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714635826; c=relaxed/simple;
	bh=QuBrZiydi3IzL6rvcoA5ChHszds1aw7fAYJAAMco0OE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HSO6DmnR6q7+Tvr+99o30MYaiyHojMiozCcUp/GQ6G5GZ0n2EOZ5aH+IVZtNe7oVUZ81UESU8Wlu1FA8L5iTpsM5G1q6MpvMmjVwbahen43RSd8Yb0/aIMIpKuaolWyar/1xfV7h1t2j76Trh0FotggH+6qbE2uyxpXP7dcHJhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YvlGJWM5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41dc9f98e8dso2931245e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 00:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714635823; x=1715240623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGgotSGp9gsuipLMYd1ZWIVlu9K3yF2blE80Dn0oYuM=;
        b=YvlGJWM5dggSfndWded9OukiME5ceFQi++LI4Kow3z7r7Pl+lO6r54kYwdfzNldodH
         ufB7m0ITfUFHPhakvPN3R7TLIwRxOpnyHtiZq6oG00l2mOMjxIm3yiMDWkEfN0J769sB
         MMvylsw0s01k2kNf7Y00dfqY4ddKwLesg754ltWGD8J30D0TLk6hV4x1Z6TZKECDyRs0
         fyHNcbhG+zPx8J+zSYSNaIYywDahJc5CZ7NQSB9egGDILRYYLlunX52ojGNbIBpmgjeF
         15OfTRrdbovFK/FyFLxYCANPo9aEFnP16Ih3v4do4kI4r8b5/U6zNlTVuFMFwuAWxO/y
         H79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714635823; x=1715240623;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGgotSGp9gsuipLMYd1ZWIVlu9K3yF2blE80Dn0oYuM=;
        b=G2bqLDmAiqWuf7nys80ld/pcBXtTuGdqjvGTX0zcpS6mWT2Zde/jLuzQSCBHhtuMQy
         5gL+56Xf/qgOd24lirfzwJFlzBrUfn58Z9yORbVnweulhPHgsmWzjVrZZA8X5y4wOf1o
         2FSgnYkMaWjMEDPJIWtIuQcYZ4xvUDbIWyvGbIgXO9LuxTz6bxmNlc0Q2yyo8fYlTDG9
         Ip8IOUfk8LEFCahafYoPSwd2IfmEVA0tQYDQvOFbbO2NtIfVuRIiZqCPc1GP+Qk18/jp
         lkCpjud7K+fvDS7J/hYHCjoFfL/D3Wb4Y+zbi3pogq6FiW5sBZQ65/86JMIBamrOqQfL
         qZVg==
X-Forwarded-Encrypted: i=1; AJvYcCWqc4G9Bxqzs3JWlkicy+aao6QUMdmwmdPdEjgvuZ2hP6h6J+E5gFE5qadkREO6Gyz0mnWSgqyuYwiJ+a5IfMLbDA4SS/xsULYP63wE
X-Gm-Message-State: AOJu0YwE0SrcKPrpXDj302dKSFyiehSGedLU+zwayg30HBzl/DJIksdl
	xjEMx5XV9drcU4pWJLcBf+VYAY/+IVSpRY8a1jI0kegwJhUYWk0fNe1+40KnZTGrEm7JrO+JaaS
	rNIk=
X-Google-Smtp-Source: AGHT+IHBvi5rUF5z4sbErHKgeUt1U8sqlRkmtV1aGTApGe5CPviRWujQqws9zO9M7mkcLfw0+m7IbQ==
X-Received: by 2002:a5d:64ca:0:b0:34c:769e:d9a0 with SMTP id f10-20020a5d64ca000000b0034c769ed9a0mr1877617wri.26.1714635822953;
        Thu, 02 May 2024 00:43:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u17-20020a5d4691000000b0034da966c3d8sm567903wrq.16.2024.05.02.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 00:43:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
In-Reply-To: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
References: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/3] drm/panel: ili9341: Obvious fixes
Message-Id: <171463582219.3069182.3806050898196009292.b4-ty@linaro.org>
Date: Thu, 02 May 2024 09:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Thu, 25 Apr 2024 17:26:16 +0300, Andy Shevchenko wrote:
> A few obvious fixes to the driver.
> 
> Andy Shevchenko (3):
>   drm/panel: ili9341: Correct use of device property APIs
>   drm/panel: ili9341: Respect deferred probe
>   drm/panel: ili9341: Use predefined error codes
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/3] drm/panel: ili9341: Correct use of device property APIs
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d43cd48ef1791801c61a54fade4a88d294dedf77
[2/3] drm/panel: ili9341: Respect deferred probe
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/740fc1e0509be3f7e2207e89125b06119ed62943
[3/3] drm/panel: ili9341: Use predefined error codes
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/da85f0aaa9f21999753b01d45c0343f885a8f905

-- 
Neil


