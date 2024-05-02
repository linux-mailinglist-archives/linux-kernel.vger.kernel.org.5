Return-Path: <linux-kernel+bounces-166169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568908B9718
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8879C1C213EB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C333D535B5;
	Thu,  2 May 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KiZiDDi2"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA193535AF
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640624; cv=none; b=C6Ki5999RbjE+oASMP4t9P69OQt21dZ2Yz+mV7Qffrktw0j0dCVigsBl774fXABqqVBc6uexnwWh3RkLlloFr707xSgmJ8CrfZowmmecfT5xJRSWIE28nEBmN8RLKa5HxZj+MNnKSzTC0kY7JXGYrBC/RY+SSYcW90+mkihIwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640624; c=relaxed/simple;
	bh=B1/JsRHaRwh8xuvVCfPfE8zGZptpICAFi/tgmIGfjyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTkFmD+HQolH/Oj2IWJkQNond1H4KL9A0IIEmwm9HMvOs2SFdLQq5FezcYiLpL6LOU7/R8bANLnTZobp6IpvTYceTk3YmzpoC4aGbnZxiasBTzJ/pzJBHSGw25EJmT6jJJ0IISV+/SuDB51iWPs3MeOrv670Bj8xf1193gECMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KiZiDDi2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso7652595ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714640622; x=1715245422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9jftfW39bbIeQUfZAK90lWrNeaGnmPoobdnKBYyOfs=;
        b=KiZiDDi2ScPb+xCCcArPOQ0uW7fhi2rGWbqcKKTlbQYMXxSPvWPsHlasZ2C40wcaOa
         gFuHA5EFh0F9C9X5jpDGc3Mwc/Cvx80X//Cz7DtgdQTPWDR1F9H9mOgSbrTpXvq7SXPN
         V7QG5CboIUcojkkDdMZ/p3JG348nKaRcjtZZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714640622; x=1715245422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9jftfW39bbIeQUfZAK90lWrNeaGnmPoobdnKBYyOfs=;
        b=KNTKqfQqIvY6d1GTRIGCW0W2Z5gcTQNdAEKqpL5wW52lSfETxEeZLGI+MsOevM38iG
         WyqEePQ+vCZjWRna3hu+CmLQg3XC939AtMcUrDat9+mNRWUt1Mk1iDoYl5J3pTD80h0D
         +48lWxEIJrxD6I0zemdE4lTKtout5YzZ+wU78MShX5xZ2VArczbvEHeHjpJTSJb/Guon
         ey1ISYT1ZlzrN8vI7CAhXn6lq5Qg2IiJQuP9EgH0hjhw1U5dqwCQxD8wOZOWtaHKp1QP
         cOoSf75hqO5sBptBipp/LfeKUCfcZoprEKqk24RZYvHtVYGFy4U2i9udCOTk1AXOnz8J
         C5DA==
X-Forwarded-Encrypted: i=1; AJvYcCUSKVdoT6BzeRPIuemcZoh3zqamnsRh93BUVyXzP4kUs5Pg/le5MznyldgXWlUGxK8VxBB+su2zjcn7DM9ooHLhNUN2DkMp71Ta+6z+
X-Gm-Message-State: AOJu0YygLM+5cUT0U6NhK4ZEejegRiOsNFC3ZCHunDm3vJzj+pu5aq1m
	HJgCsWSOe1+BcHIRyL6J6rhgMbmUwVwaBD167RRefIYqAFI6/k4t+wKxRiyNXg==
X-Google-Smtp-Source: AGHT+IHkk47f/oaNwBy+tqBFBgyeA5BhGR8Bu0LMaWx3ZnBeZ9jL9N9vElMhu4nySP7qHeAXoZ246Q==
X-Received: by 2002:a17:902:bb17:b0:1e5:8769:aadc with SMTP id im23-20020a170902bb1700b001e58769aadcmr4864021plb.22.1714640622119;
        Thu, 02 May 2024 02:03:42 -0700 (PDT)
Received: from yuanhsinte1.c.googlers.com (150.221.124.34.bc.googleusercontent.com. [34.124.221.150])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b001ebd73f61fcsm764983plg.121.2024.05.02.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:03:41 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Thu, 02 May 2024 09:03:31 +0000
Subject: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add a perporty to
 change TDM setting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-anx-tdm-v1-1-894a9f634f44@chromium.org>
References: <20240502-anx-tdm-v1-0-894a9f634f44@chromium.org>
In-Reply-To: <20240502-anx-tdm-v1-0-894a9f634f44@chromium.org>
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

Add a perporty to indicate whether anx7625 should shift the first audio
data bit. The default TDM setting is to shift the first audio data bit.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 .../devicetree/bindings/display/bridge/analogix,anx7625.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index a1ed1004651b9..915d5d54a2160 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -82,6 +82,10 @@ properties:
     type: boolean
     description: let the driver enable audio HDMI codec function or not.
 
+  no-shift-audio-data:
+    type: boolean
+    description: Disable the first audio data bit shift in the TDM settings.
+
   aux-bus:
     $ref: /schemas/display/dp-aux-bus.yaml#
 

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


