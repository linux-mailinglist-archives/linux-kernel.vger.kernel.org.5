Return-Path: <linux-kernel+bounces-116843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C496B88A473
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA5D28AECF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0CA143C75;
	Mon, 25 Mar 2024 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5PdTw9L"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865C16F834
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362980; cv=none; b=rGpXa79jZFaIvtJF6NpYsw+Lk6MNBhoRN6g1Rw9hgoQZdJ43c85+dZrPCFSr6tjeeyE9TykP5zWTTvoaMl/XsuZw5p8AyCfYGQqfZOfmLYT5KoBokRoeOF+WAWv1zWSeI1nT/ikntNvjktlJFvioOqNgFa86wQQbzMgzzNVzwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362980; c=relaxed/simple;
	bh=o8FkFMcnGCkErGN46EocDqCxv2FUm77R00EJGlA+8Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7uJzQ0nQw+p0W7ZsjLptJfwbvjvlfeLuDVUYXL1QYzkVBTA5MtV3OPvxSSi83rR0rwMUiEA/FmS9Vx3WICcsqsXt19JvR1LSDtolM6LFJ/bEfPlG89u5AOv3KG5qzwEYeHct/4GYMqwOd0rMEfRVtJgUoMH6ijNGhrahX+ALBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s5PdTw9L; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46cca2a979so243860366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711362976; x=1711967776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W09M8JIJtZCbNBhGe/AHRCcrRIGkrBwh+HJVwKRzmpo=;
        b=s5PdTw9LBvuIFiOkT/K7o3zSBFrUtD0G3ZXzQWlZ7mrfNVBTJO1pPB6P3XvqKI/UOV
         e2UqS9lGLz4j+G5AksmHUiIrCSN9mG1DfPaXeGuDzyNkFyoko4I3m+ZazSOy6k2y8O4L
         J55nz9Dp/e6zAn1nIEpGyc5K5ju8b+njndP0t1EDa1wvwzlyJBuXDpgJvcm3AojqoSak
         9hVCTE/fhekwcyBveJn5vvT9k2tzXO6HyRdQae9kEqqrvgYGgvnPQ19Pl3Lzt6Q2dgKQ
         rIh5Ncuow1sUd3bzJt0c/Y+h2dpJyJOzRSlxaxw699KXNJsPXuJMVKbmNBweqoq85bOJ
         0LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362976; x=1711967776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W09M8JIJtZCbNBhGe/AHRCcrRIGkrBwh+HJVwKRzmpo=;
        b=AT4pYn19+udyC23TYmx7z4dSzxPOwGswMR/vL4O0HKXc42nljaA4LZPXdiMXRVUczn
         UaWEo65hSDkz8d6N4wj92NMDjyksVqsajOJDLBhmIn0TnqG+5gCZry+p993Dm6qq0fud
         iXhZS2DuG8BXdD2p/g29qSD1rT3Cqx6RQnSPJpPttNJhMqKTFHfnSlMRNfeTon3lGi9n
         c315Oi9RgWJLT/sRJ8zQiBxW/D4dh4s4lMTEp4tOnpUr2jzgKycCBD91IpeuDUCXvG/R
         sE8A03WQl+8HrSYGZN3mZbZZ2NS1kzSyrBo1vsTXKvPnL5ef6BFUMQGgeMgxe9GnXyQZ
         alXA==
X-Forwarded-Encrypted: i=1; AJvYcCVfa2w4OMvk+V71e3jMNQa5yX8E1dxV3XprtbfO3jmMC0BZUL5G2cg9uVbXsNQNlAbh+78MH41yGdnRaMSIIZqbTutEFt/beYMmkG+a
X-Gm-Message-State: AOJu0YxJH1I3jEFN03FVz9lHv/ocPGyvkeqxHQFRd+DWeK5qbvHEsvQ1
	KuqOx6D18cUPwdVezOTopzA7dhREKN8UuHMEkB//tuL54/y3xl4b+oyLpvu67Iw=
X-Google-Smtp-Source: AGHT+IHmQpcP4djMqJlgyZNdnJK2o64l+ykSs8j6DoMBtPxwMAnnBzvrwX1Qg9HlK4MmGrHDb/DTZQ==
X-Received: by 2002:a50:8717:0:b0:568:abe3:52b2 with SMTP id i23-20020a508717000000b00568abe352b2mr6048218edb.23.1711362975826;
        Mon, 25 Mar 2024 03:36:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id dm28-20020a05640222dc00b0056b7ed75a46sm2827319edb.27.2024.03.25.03.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:36:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jianhua Lu <lujianhua000@gmail.com>,
	Del Regno <angelogioacchino.delregno@somainline.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v4 2/3] dt-bindings: display: novatek,nt35950: define ports
Date: Mon, 25 Mar 2024 11:36:10 +0100
Message-Id: <20240325103611.28240-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325103611.28240-1-krzysztof.kozlowski@linaro.org>
References: <20240325103611.28240-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The panel-common schema does not define what "ports" property is, so
bring the definition by referencing the panel-common-dual.yaml. Panels
can be single- or dual-link, thus require only one port@0.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v3:
1. Rb tag

Changes since v2:
1. Use panel-common-dual

Changes since v1:
1. Rework to add ports to device schema, not to panel-common.
---
 .../devicetree/bindings/display/panel/novatek,nt35950.yaml     | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
index 377a05d48a02..7cac93b20944 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
@@ -19,7 +19,7 @@ description: |
   either bilinear interpolation or pixel duplication.
 
 allOf:
-  - $ref: panel-common.yaml#
+  - $ref: panel-common-dual.yaml#
 
 properties:
   compatible:
@@ -59,6 +59,7 @@ required:
   - avee-supply
   - dvdd-supply
   - vddio-supply
+  - ports
 
 additionalProperties: false
 
-- 
2.34.1


