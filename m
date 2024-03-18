Return-Path: <linux-kernel+bounces-106291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5984987EC0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882B41C21880
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DEB4F5F9;
	Mon, 18 Mar 2024 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6luNY1P"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD764F1F9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775385; cv=none; b=BwiqvaYoxcMkthkhRm29ZJMJMJQV1Uoo9fhzHsp+S/Vus08sFM0HajcyTrBqdSoL+yKdpuvkwt/kG2kbW2SzT73xZLfCbMQ3MHQDppox1G0syJV2LhQVBUSzP3NYk4n8DHMfkYCGT0U0rAcH635+uszIIpO9Dh9DosKVax/BDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775385; c=relaxed/simple;
	bh=AtJQfQJS33AaSIuSBYt1botiGDm4lYqVBh3J38xzrek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jnc1qFNpVEWmEfEARPrXpeutHcK7An9LigR36I40io1LLUootd980dwsB2W/gvyCGUl1KLCZqugkEiM72zfcQobmqVI2EFQML5nn8CuqUY8hUwWY90NXVIM+8ntAeSogSQLVtfqULxzW0Xbmfc7dYZRSXFrezSufooguuUONf6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g6luNY1P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-414618e6820so772545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710775382; x=1711380182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Twv+JvklLp9BaiBbFAxQP4duO8HXQ31vQnaAdXX0vqU=;
        b=g6luNY1PKDgSLIpwoUmDJJcG3AcSp9eUSRWPF5YL3VnAUttcxGUkg0eB0kR6PXj7zO
         JW3kFDKKJbuuZz/t4HMzM0S4LS3UAwPWjHyWWjcip4CQfxICrZh8+1rraGPehpcyTcBl
         7tFSH/dIh6Q83uM9HQyYhHkopkZJP5nNnx6PIX3Zrcz4RtcFo+TVm6t70chwkN+XG4Vp
         WM5s0Zk2/M5J0k8VQnLhu6agKfym6j9vKHZR5woPaUAAtFTEYjvYztoSqoIfgq6IxfU4
         sA+sRrKAWD9wovZhQbVTSRjOLYgc4sbb/bF46H4ISx+n0hjnrpErA5pTtlNlXINXxeW3
         V9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710775382; x=1711380182;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Twv+JvklLp9BaiBbFAxQP4duO8HXQ31vQnaAdXX0vqU=;
        b=sgidJVu21itnRpdNFH3UHr3UPbJStcAleMi92cgiTZq50l7xKF9RNzuU+YErGFjXKQ
         J3AaRz3faQVXc2x77gmrCZzVOV5D1lkh/cgIp6BwpWi28q10h3BbvTo3qK+kPEpUZvBk
         /HaqXsVAodP0S9xXrm+8bwWzmIJEBSGBNz5X5aWBDCo2seC8yM1gs5PJU35l0gx9mHVc
         bCgJYxzM3pG23nybsPJxp+pZuW5iSBe63tKQIZSPXZUnuP/PYBFPCTRXt+/tbVkxXjWU
         Bkh+cfGUJ3+3QmR2NRyo/rtVOA66dmWWYilBvBQw2dRL+Drg+dERE8sR9WFrjPaLMHfN
         vMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJdHiT66zH1U1vgWSgicRU6xawddYr5l9ZRM5dZ+z5v+X7UVxT73xPT43Mk86zm0H6GVkyMmtE3f6AKcykrqnNxhX6DboKTJS6os0w
X-Gm-Message-State: AOJu0YwBSq+ZOMObkgeLUlxA9CUh3wZBMmQhKShWU458yh4BQoAEZpOR
	N4E0yyvLtSZR8gnvhR6BZqAsV78l7BmSzww6EKUmt6Ps04866dXlmCREDPQtEgU=
X-Google-Smtp-Source: AGHT+IGvK4rbbO+qQM1IvrwjNxX04794KUSmFHWIS20CyIXRJPL5YFBAsGz7LbwTbujJus3OJTfCvg==
X-Received: by 2002:a05:600c:1393:b0:414:286:fd4e with SMTP id u19-20020a05600c139300b004140286fd4emr6302133wmf.22.1710775381632;
        Mon, 18 Mar 2024 08:23:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b00413294ddb72sm15047500wmo.20.2024.03.18.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:23:01 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jani Nikula <jani.nikula@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Azeem Shaikh <azeemshaikh38@gmail.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240316170513.1159724-1-sui.jingfeng@linux.dev>
References: <20240316170513.1159724-1-sui.jingfeng@linux.dev>
Subject: Re: [PATCH] drm: bridge: dw_hdmi: Switch to
 of_graph_get_remote_node()
Message-Id: <171077538075.2168000.12618964417804464733.b4-ty@linaro.org>
Date: Mon, 18 Mar 2024 16:23:00 +0100
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

On Sun, 17 Mar 2024 01:05:13 +0800, Sui Jingfeng wrote:
> To reduce boilerplate, use of_graph_get_remote_node() helper instead of
> the hand-rolling code.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm: bridge: dw_hdmi: Switch to of_graph_get_remote_node()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d576e5e235c9df1cdfe62db958b77c0b0023d08c

-- 
Neil


