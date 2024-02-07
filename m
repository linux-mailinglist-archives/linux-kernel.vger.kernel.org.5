Return-Path: <linux-kernel+bounces-56202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9696584C747
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E981C2105E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A602232C;
	Wed,  7 Feb 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHAXtVV3"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE622307
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297972; cv=none; b=QQ1syWSsYc+eysvg58wcSZgMAZgyeTqekuAGezDJh9/Ck4NT/6aR+v4VuLLcsJqEdWApt+NmLN5Xz1efUMgjIvkdkdpVMS+wUBnyyKxKl4S+kF3Dg5lyu+mw7yGgXbHXU0s3s1hJnfhVcu+tGqmxNDnUbLEDyLZ6z5VR6ykz66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297972; c=relaxed/simple;
	bh=UGFZ8j7IPyTjr/U/Om1Ufsbli7NY4LhALx3jix56Z9U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ki/xFVJ0SgFvagT0q5AtC6kTuekDfg5PM9IL0evE9PmGJWjikN3GbFGyAk4t3pHgMskasl0k4JQ5wdmWaH6+3V0YJiGtXFbzaJfV1r4HT6T6muWd3Wq8HzGo0Cp9VOPWhRd947TvJDcdh1kQLjOji8K2HT4nsBWh7IfLq6RPkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AHAXtVV3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0a0873404so4363341fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707297969; x=1707902769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5lRyRyAGgIvVUMWrUgNzjdeVU6fgp9K41rKwzb8l3g=;
        b=AHAXtVV33L1Pup8PS8e3uHNtaUmG+R+iWQ+oJTKlsIHRF5VIwo61IYEZlJJAp+8Xhm
         omYeylq2N0B//h/qmYyibAHZUCBW2RM/DoM/qZ/BFQ5lXGIVJvr/UfEHTw2T71VGj1MP
         RxSpNUnGjhRbTG7iPP+f35L4ksQC+OQr6wPoFywWHmIbFyQoGgVKtk9cpC8c4kHGO9sJ
         7hBEs+wI//dTa8b8VlvrX+4Zq6T4DQXhsOiohL69DHdcD4Jkfq97dKsD05on67RjalO6
         Wek/VU0C1//R8D+4AnS+LRrfFG/kx16dJrzE4gvfZhP1wypx1AnQa18u/RU0Zql9lGgD
         JNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297969; x=1707902769;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5lRyRyAGgIvVUMWrUgNzjdeVU6fgp9K41rKwzb8l3g=;
        b=vQgBM8U5rjKg8qOafjcQ7A6GcyTogN4Z6jZwaMXWqVAFoK9wir7v3Eum19PTUm71Rk
         E1vKM0gJT2l9i4Zqhvuw05FhHA4x/OQ3hGYVNxmyVNRsVqr6Y8VUNz3vfqVizGv6MCGX
         0WNkAbKgRyEJP7eS65aixHFA8/fm3FLP+hxmZgME/vdneGs885vocm8TCbPaMRZDXZM6
         wual42OoCjpCTM/9veaanYK6bGKXJWDc6vYvag9Tt9iZYTZF3v/JTvAdY+5X0YTf5bo1
         yZ81hD45dIhAdJYK9Lrq+pg/W0QGOlxQYMaj3aJaYqyRtV4T2LEcaRn4sPe0T+fJMOuk
         MeDg==
X-Gm-Message-State: AOJu0YyF2x9CqJH8ywTayD/3UiL/JG47xJ0mPTBp29dwSwwCLVfjQPcb
	IQmSeQF/EZ9bD8SS/gl/F5Gon+lsQ6o65fn+xlcFdy3ivk8aB26/dPzukI8UU40=
X-Google-Smtp-Source: AGHT+IHQZkoQ8ie8X7+XIZP1vYhStwCISbCepjeZhjzlFW4HT6fmHA7v8hsE6r+knaXuh9CqjMhrTQ==
X-Received: by 2002:a05:6512:404:b0:511:3a93:5b7a with SMTP id u4-20020a056512040400b005113a935b7amr3799131lfk.21.1707297968825;
        Wed, 07 Feb 2024 01:26:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWabLadlGXD3LaP2E0ytTHYtf7CDGcLu+M9AM/7lNkClQL5hK6nZxkdnTD1T613VPTgyKWb0QxQDsIaXKL+neI8lR7+Aj6esl4pMyn5aHJdABJuMbwKqP1T98Pr3W1RvvXif5K1Vgl5cRbWeALv7InOgxoP+LF9Nb8VQaIbOdv184dpcW+nUCiFmGjXcpSz/SYof9Nj0kGwhlruvIo3F5x/UGHEgrOrxVPqXc/S2ASdqudyCkq4DxHT8YqtTH3jCPvyLgzw5FbstJCpoe/0AeIlEhmzkh/naQItMx+kyWM+9msw3FzmWVaDKHh1v5ldUR64qnoc/NdcbV0KXgz9zA/1aakoxHajq3wbbHL11psq6UGzhUTdNSb3bTiWNf/BFucxgI2UH5+JW78z5CkwaHbOsl1sKVLv5msLckQNKOI4UmzKsyBnA9W33yk1mxtliFX/wvQ/9bNonrdVN2XuDv1N11V725+u//p0fa97rnq8Nrrrd8jhVlO4UE9RIVuuGTyYQZsvTFNC4oWNfKcOrQnWfNK/TRO44Uh6e+kDkQsxxtrA0VPZ7ceRALbRaFQZqIyXj605k/GsL5Hm1EZUG2WYvbcu4Xn5FsG7fgjRZx7sh+xWmmsfLWd+HLwr+45hXwGMn9huxx2IH4jECWMBNR56HZbV1iruE5SjRD2bmaX3frZYlEMKNLGPM2b1upJ88Z4EhY54zNEJTVs2RTAyP6ZcSRxCqktejFUS89vwZ8lG2A==
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b0040fe308ff25sm4593077wmq.24.2024.02.07.01.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:26:08 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, Adam Ford <aford173@gmail.com>
Cc: nathan@kernel.org, kernel test robot <lkp@intel.com>, 
 Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Lucas Stach <l.stach@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240207002305.618499-1-aford173@gmail.com>
References: <20240207002305.618499-1-aford173@gmail.com>
Subject: Re: [PATCH] drm/bridge: imx8mp-hdmi-pvi: Fix build warnings
Message-Id: <170729796773.1668186.17562131345712345176.b4-ty@linaro.org>
Date: Wed, 07 Feb 2024 10:26:07 +0100
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

On Tue, 06 Feb 2024 18:23:04 -0600, Adam Ford wrote:
> Two separate build warnings were reported.  One from an
> uninitialized variable, and the other from returning 0
> instead of NULL from a pointer.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: imx8mp-hdmi-pvi: Fix build warnings
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c4ae9fd0de44832cb01d36af14bfc7783472e631

-- 
Neil


