Return-Path: <linux-kernel+bounces-166168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD338B9714
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3ABF1F21014
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22F951016;
	Thu,  2 May 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QFFgRJJk"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C9547772
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640620; cv=none; b=OK0bFKY3gh3tji5lNeE3XjBmYhoKZnQ/7skek0ye4N7dB629oerHjnR1LDIDaQcOgjcD7oIl8YKJ9OaBl7CgJEqg5soWnFhQQU9Qg1SXBjm05QsS81MKIOoS62b/P+RPXU9PbYVYBgMdjwiCkRMDhi/VkzFZCCv7Vfr7zpTjv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640620; c=relaxed/simple;
	bh=Jglfs2pABPclxQGT7zvsJ9j6EY5ovQg0Zvjn16T8gxU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S67j5osCZ2I9STEEb4/TzpWwZGJZTv5/HelyRUZkCubgMx21/jQrVx90l/RlSrdXc6d/aYrf3TNDbsqYDIIvPDZQO6SUfLdo2iWRMP2vqX1AHLsDsVcmHZ/U0itoJBhr4/0Bv5TxzLvxl6Ysuf52HlZrSD+7s36zgGVcd/GcB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QFFgRJJk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec5387aed9so22520355ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714640618; x=1715245418; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4N8GU+d1mV2wTgjb+Tth4J8cXkQOLnlslwrqaEwJL4=;
        b=QFFgRJJkdpLiP3RVHcGXvHk9QNuYI4he1m9nc8qUwlb2+uNEEaLXgjakYIUJNFIEOW
         DWGTcNbvxWbN5LYTZXyKS0KgkWn21E1WYzZmihSKWZjM8CYc5nnKcHfRtJVpDbMw7ZIV
         VY9TrsZlVe1DYxQ3UIBTb3/rDSG8uY4bCYJgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714640618; x=1715245418;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4N8GU+d1mV2wTgjb+Tth4J8cXkQOLnlslwrqaEwJL4=;
        b=CDVnjOex8yhk3JqJR5xpUQqnr576wquB+JekBa9ycCgGSfIiAL1DWfH8YK1eVuXkmL
         8eP9vC/hLkioJgNGlZwOszksL2uWaiXIcG1IFaPX12y+mFoLt6sBFcvHq/qck61yKEo3
         GyFKqrJwYU+5vLs0fjOr6vmN/Bl9l3g6AZH3vPmkESVodxfsraMGxfrQkGHtVsXON5YN
         ZCfNp0akiBAMT10rwVT1GcxBKsztYGaueRLK5CUpilfmlsWmIpXUQxc7qkKhfN1P68Js
         wUTFsd6yQB3gZi5qb/brmqOV4v10QmPwOmetYRLTRrjM8QgTWFymgoo28IxkwelEf9ct
         jRmw==
X-Forwarded-Encrypted: i=1; AJvYcCUwYU7XHZcCJpWq4HrddfNL9yN2wmp8BZlMStpCl6L9jzbeyC0I3THB4DFr1kLPpwASnMQpoSnUzUBBxSp2EaYzUWvtMoXMa0UOhDoh
X-Gm-Message-State: AOJu0YxbUh6hzd60yWK3lb62i9WfO9kp/WBpVzhCpEnsacW/f3LD1s4z
	kR01MyhuZXYGgDrDQTTFdMCk5q7FUECuw5fOjOmV/uRiWgXiwxDrhluz3JKmoA==
X-Google-Smtp-Source: AGHT+IFRnWDNjDH+SOdNczIrPriuznm+C9bqK1WVko8EGJDcbadaa3IFubaLd6ulXbchx0tVQ9aiWQ==
X-Received: by 2002:a17:902:e551:b0:1dd:bf6a:2b97 with SMTP id n17-20020a170902e55100b001ddbf6a2b97mr5140711plf.60.1714640618092;
        Thu, 02 May 2024 02:03:38 -0700 (PDT)
Received: from yuanhsinte1.c.googlers.com (150.221.124.34.bc.googleusercontent.com. [34.124.221.150])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b001ebd73f61fcsm764983plg.121.2024.05.02.02.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:03:37 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: [PATCH 0/2] Add TDM setting support
Date: Thu, 02 May 2024 09:03:30 +0000
Message-Id: <20240502-anx-tdm-v1-0-894a9f634f44@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOJWM2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE2MD3cS8Ct2SlFxd8+RUE8NEg0RLA8MUJaDqgqLUtMwKsEnRsbW1AER
 23e1ZAAAA
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.12.4

The anx7625 supports two different TDM settings, which determine whether
or not the first audio data bit should be shifted. This series adds the
support for configuring TDM setting through a property in the device
tree.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Hsin-Te Yuan (2):
      dt-bindings: drm/bridge: anx7625: Add a perporty to change TDM setting
      drm/bridge: anx7625: Change TDM setting accroding to dt property

 .../devicetree/bindings/display/bridge/analogix,anx7625.yaml      | 4 ++++
 drivers/gpu/drm/bridge/analogix/anx7625.c                         | 8 ++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h                         | 1 +
 3 files changed, 13 insertions(+)
---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240430-anx-tdm-7ce41a0a901d

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


