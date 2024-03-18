Return-Path: <linux-kernel+bounces-106293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2338787EC0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8338B21993
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4150A83;
	Mon, 18 Mar 2024 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/HdrCO0"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8314F5F8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775387; cv=none; b=VH4qAd2a4gk6QUZX9U9Hre65TwjJ6GFb9xMcsDpQy3UCrkI2yWaiaIuDVo4kjinKwEgsj966/OU56HVb4+JoznBCUbW0HUx486YZTOieQm428O0xhHgY2a2Mbxlv1G8Esub2BMbyHVYUuDTtGuNdQZ5H5VEh2yMkeP/CMIHCUlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775387; c=relaxed/simple;
	bh=9VCugwr6Ce1zW0YQ9zzz6BwnYqAt5SKoWKZUr4yvkhQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kgnghFNF21s+kqklJhlUeCA2TPk1g9OqLQFjt3enO/ih129+4TAqg0P7wiGelwmXHDxTPrlTsRuvn4mS/DvNSuJBBXNoy3vnuBtlQzmffCqEzdIkHUuxePg+HqdNOaQPMWgGZFrnzVSAaho1V7fDl1WU91dCIeGEJ/+RSLXynNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z/HdrCO0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513dc9d6938so3452510e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710775384; x=1711380184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHYqxUZiYcMsHyyVaTfgVdhGSdNorfQ+WAKs2dhWXW0=;
        b=Z/HdrCO0eP8by3UM+RaBiY1Hc/Rt3qYsSxUO7pfs+QsnwaE1LIkvWzKvSY7CgKra+0
         lW+fN31hRPFzgi3CDjJ2Gxod+gEVdeBXssiSwd4vlj1HnmyrfT+Z2WQMwejgeCmxSN07
         PweGAu8dYZyt3GIQKJ1KX6XQLBqmi6b0JOTkmGCCvMYUWfFZsM6xO12FJyAWH8wUMdGJ
         k1ifHyAbl3AF9ueOuyV8BZhcC89JqtG+JIxbBdpHuu9/Ualz9Tqq42tCAAupo5ET6T8q
         fxsr23UCSlGQjxM9yne5BifZ3XOXrsoYnwaWAUqGqW1hUIUohyh40mJ5MBt5uJVmMz/p
         N6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710775384; x=1711380184;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHYqxUZiYcMsHyyVaTfgVdhGSdNorfQ+WAKs2dhWXW0=;
        b=QDOqA0REVIgyRXhIvy01K/L57G72CFusuKVkxyhxdNOTMQM7fRgICPKRCl/hN834wq
         hW6Ibn+Lcaw1V2oO3rZ9XEhxYiEguOULCTTaCAG8RChVabrvj5xWLH113KDihwl/JKK5
         EMBqCUtLn8zaDK9vYqucVCI0qz9enL+C+1kelfvlrnj4zdH3KGyznx2EqVdN9TSUGCjD
         VmcvBvmh3LYb+TznQVMoHil4wClaUVr6zeloiFPSTdlKx1aSQ2fH1vsBoEIKdPe+MYhQ
         xCExR/qQcWFnC7ZxA+koQeGkvZf7e8njsBJk4XNvW3bkX359Thk0vfDoD2XMBfikuF2U
         urvg==
X-Forwarded-Encrypted: i=1; AJvYcCXeCkismTA1NIlvTLbO6FOM94J97QMusqmTdw2wIqL2HpsEjup+42YmBGsUWyly9dwvtTIqub73ZLgxHLt3R6y0ngg1Hy9oItxCSyaO
X-Gm-Message-State: AOJu0Yy2XW3apL6jaH8Xovs1hF6rJ28ubwnfLSd8yUhMwNfeVraeqv4A
	53kQgpM4I/YwxIt4wixFgo/cUFanTSr+YahxJFps1eumiD2Cj92iUb1cbQ+sXIQ=
X-Google-Smtp-Source: AGHT+IGdW6Rs9fAb/f5/EuohFyICrbr9FOyNrbeWuCtyQ7XWcKBTHyHyNwheZWb/cVMxxMAURmY5WQ==
X-Received: by 2002:ac2:5b03:0:b0:513:bd72:a677 with SMTP id v3-20020ac25b03000000b00513bd72a677mr8323420lfn.19.1710775383623;
        Mon, 18 Mar 2024 08:23:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b00413294ddb72sm15047500wmo.20.2024.03.18.08.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:23:03 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240316172800.1168390-1-sui.jingfeng@linux.dev>
References: <20240316172800.1168390-1-sui.jingfeng@linux.dev>
Subject: Re: [PATCH] drm: bridge: thc63lvd1024: Switch to use
 of_graph_get_remote_node()
Message-Id: <171077538263.2168000.4639473590716964266.b4-ty@linaro.org>
Date: Mon, 18 Mar 2024 16:23:02 +0100
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

On Sun, 17 Mar 2024 01:28:00 +0800, Sui Jingfeng wrote:
> To reduce boilerplate, use of_graph_get_remote_node() helper instead of
> the hand-rolling code.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm: bridge: thc63lvd1024: Switch to use of_graph_get_remote_node()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/00084f0c01bf3a2591d007010b196e048281c455

-- 
Neil


