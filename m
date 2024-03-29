Return-Path: <linux-kernel+bounces-125183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE008921BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3538CB24894
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F5F85927;
	Fri, 29 Mar 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrA9Byun"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21981C0DF5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730281; cv=none; b=FX3Dl4IZBwR844wmHKz953PQ/vBWxxcAt9M2e1ojfD3vNG1tqMPlZDvn/mgWWU4fqw6AY/hAaxZfZ7X5ub1xxFnDHnhqmGqhcIdj0j8JmxDXIPY96G7cGFKUKfq7eGrjSzgSGJdAAXSNVa55usci3MPmNGOC0L+NPIwVngwEucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730281; c=relaxed/simple;
	bh=UBlirrXGogE8gGO0RdhSlJdLuIR/MtYM/Uu2iWbjN1Y=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XqOrPoEa7Dq42vLEDeeSz5X1Ve1Al9/ApAHakD8t3bXu0r1CmofCBu8nGrDUOZqSgMxsB1aCp4FYlopAJBqIL9Y2xVN1+4KhwnuNKsag20aed1emQ+U1qZJoeQak3ydmsGn6hoU/grF3v6ign51Cmr9SqSU/8YzbsjzDFW5RCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OrA9Byun; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41553b105b8so2612565e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711730278; x=1712335078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2N2sjDVZQ5s5rWMc1AGGuzwDRxJwDXuM3KrfxZH98mw=;
        b=OrA9ByunMbXLuqhqN3nVU/kJVldpb4w5i1slXUYXbKcdCC4r6JX/MtGsR6ER4q1XgX
         vuIFNeKZnQ8k5wkt1RGNjDpQlxVs9vk6o4WI3nWYtEgdpi/jmfjqKSD0QLo+0dboi2DD
         cyn61s678o5+J4bAPIgJLanOdKmyMloZDl6mzY/F4NzzXRATlvxAnsGMppMtgRYuUzTa
         A58wh4C5sdaN42ezvYpwcfi+54NUUOb4YQKEeAUHP1gWYrwciJWwheo95mYgiTr2QFU4
         p7q03L0+AgmyRJEzp94uWYmWeXCLiT8NLULTN1qULbwivSLiBxQvu86Jo2CFi2O17e6w
         rHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711730278; x=1712335078;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N2sjDVZQ5s5rWMc1AGGuzwDRxJwDXuM3KrfxZH98mw=;
        b=gRjoF7n5nIiLuSOIk3eyiROUJy3s0NSfjCPX6bLzuB7wJP1K4n0JXCZEz4Mq+RCI6J
         7Zz7rv000sISGXZkrEg7/QZNZH3vuJaKw3LGTGIEuyeYOkuaC7S2OFKk8uteT1STyZyB
         T1rqQgvOaq51WgXrOtDeMLF9V6NZjZowueJWgnm4NoOrs7eprOu0Vxam4yoY/426dEQK
         QJrJjpc6zVc11m0dcwI8cDJ787+WWSz+jnDIS1v8N004Z5fEyAwN+z0O8hpHfEJL0Jhp
         itNaPFQLrhIEl7/nrK8On8XYVzYZJfE7S1ssW7co5Uv7F4c3KfqhNIzj7ayEqVdk8vth
         FMeg==
X-Forwarded-Encrypted: i=1; AJvYcCXU/LuP8NIURJL1KtyAinCP6vMobA6xaCbC4ZO4VFpUZhqOBCXQQU9V+ptmXN1bbKsIYLiLZuyZUO8VO+0hXfkHdjWRbhbiyh8wF1Pt
X-Gm-Message-State: AOJu0YzqFAbQThwFcE+yDBNcl7lX3vjewLU0Am5xqHcQXF++qhUqIEMD
	emSz89CYB6GebmNemqpdzc1NDKbj31DHUQ5DRXIT0hR6ZFpNW3vIuf5zbU5zWXw=
X-Google-Smtp-Source: AGHT+IE9lrROr7Xt4WRR3WKh9SAKOAjngnqU+7gTIU7bJRWiC8dVxAT6q6g7+dXPYYDLeV3MgA6fBQ==
X-Received: by 2002:a05:600c:4e8b:b0:414:f60:5d6a with SMTP id f11-20020a05600c4e8b00b004140f605d6amr2080570wmq.0.1711730278063;
        Fri, 29 Mar 2024 09:37:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b004146bcdde06sm5958736wmq.6.2024.03.29.09.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 09:37:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20240109230704.4120561-1-christianshewitt@gmail.com>
References: <20240109230704.4120561-1-christianshewitt@gmail.com>
Subject: Re: [PATCH] drm/meson: vclk: fix calculation of 59.94 fractional
 rates
Message-Id: <171173027724.1500306.13941100169169682823.b4-ty@linaro.org>
Date: Fri, 29 Mar 2024 17:37:57 +0100
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

On Tue, 09 Jan 2024 23:07:04 +0000, Christian Hewitt wrote:
> Playing 4K media with 59.94 fractional rate (typically VP9) causes the screen to lose
> sync with the following error reported in the system log:
> 
> [   89.610280] Fatal Error, invalid HDMI vclk freq 593406
> 
> Modetest shows the following:
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/meson: vclk: fix calculation of 59.94 fractional rates
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/bfbc68e4d8695497f858a45a142665e22a512ea3

-- 
Neil


