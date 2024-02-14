Return-Path: <linux-kernel+bounces-64926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507188544BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9FEB27655
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC8A12B6E;
	Wed, 14 Feb 2024 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRVXHUpf"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954E412B68;
	Wed, 14 Feb 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901949; cv=none; b=aw6H2EFP8Pfs2GKgbtFSBHVaMkiusNuxQ+/icrwsZHsTLvSmlzO3HAPQ8tVb6HTO5mVfK68Ws4eysHJkRFQNQK4XL5KRo8Laap7wLCDt9Ss0tx1FVcr2IBI56JaZD6QNuqtgGHs2Wd/handkPQ1IGSdhL+IO4oVl8Y6anWgBIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901949; c=relaxed/simple;
	bh=yZxdr2dsDRt7puR0RK7vf8GPzQL3GlOUGyYoQ9A6MiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nc65tjhP0vlJL3SHRE/6MEeJPKLJdX0g+iMWqPHftess1JhBmjZeHoHlYByYCbQQvplFiGXDsp40cD2fU/D1jMTn7GiPhFvFRrIg50rq8WoTtVzNrZyhNUx/DUHLTCO8yAkfgKmFFO/6ocXLM6XrrtxdoqF7iGsbx2YJ8Ivp6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRVXHUpf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40efcb37373so41404875e9.2;
        Wed, 14 Feb 2024 01:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707901946; x=1708506746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95yg+DTXxQL4KdqLyvezyeLaZI+ZLzl6szC4BlO6nWQ=;
        b=HRVXHUpf6Q+ZjEdVojSGlJSqlHTX5KGZ4u8frUSi//XyYSBz7mJZbdxVtOL0Dq+1Hi
         1XyU/LuyHdkOhuCBW09X1O7NiFV/+wpW2hySRLqhvXgTMiU4O92G6b8bFN4qtrDUDHGI
         bJwWHJDhyts18bByI4cepwgVTSD2NIONLoKSbCgCnZR99Vt97oKk5V2g/kJXzf7CiFQ+
         TOGB4wop8xLYGZCI3ojvR1XRTQhGI2Y5+hdiYjGEDXrITlFP+JCzRlZdcXo9z8BPXw7z
         GEXxXc7WclwoyTwgjImf/oyhB2Xg+eAzInC78m3U5sj39oBavmHXMKkdzK+MarT/dU0i
         yUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707901946; x=1708506746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95yg+DTXxQL4KdqLyvezyeLaZI+ZLzl6szC4BlO6nWQ=;
        b=DCxO7sN84AbzsmREAfuvPAOi4L/owZL+3eft8A0PrshVqTEz2PgdeBvgtpu838zaO2
         DhwDTJUZktXpdnjJvN/lZL0SEKhRihEjOiXkOEm+Kms5DGMcKJ8fOqjNdwuxAAqOM1rW
         b0d6ZCZrUkiCxnLGpYQDUY3dIQhsGHHgjBZfhBAygBUjOqw6DJnQ0TVnReOL9u/yRCKX
         pXEJYHw+PBDHqv7El+IKcOUD9XyXwJHkyyLZ+2n/v/h4fcoSz9rzim+2AKGNUzzgX9Lj
         rvgfdBMv9ZT4eqyezVuXVA01UcnD6gSQoroVxxe3xSg2p5PG0j5uGSRVneLhgv0kP1Oa
         tLNA==
X-Forwarded-Encrypted: i=1; AJvYcCVtIphB5Nt6Gik1HUXpGPOnI9o7MJ3fzo8Ir2ZvMi9tSoOuBgN0F6ODu9qYsmAj+LdmFSPe2SI4Tms9FjWrE3nW262/BAmmJtrnpgJoKsskgVR6DsbcCWKalzkWEn/ojb2VXlz1PKGnnmHD5cepIZBgh1CzDOYWwVxGQy/X+1uAwRBTUzqVMsWvOac=
X-Gm-Message-State: AOJu0YwLSDk4E9BkHCWwdzN33Pv25E+MkEmN91wUyfSn1v2yd1XEqapB
	rqxcaqctQ9uwhOMIfgOUfICzfqz3GjE9W2HME+jm3Qtwor5oC7QB
X-Google-Smtp-Source: AGHT+IFGnSsO6rMqSaHxFvLZoPNgwamM25PjlGCoKORDBuZ8eTk/jE4xeb0UQ+NbjAVIqqe/EjnfHg==
X-Received: by 2002:a05:600c:3ba3:b0:411:d273:90e2 with SMTP id n35-20020a05600c3ba300b00411d27390e2mr1811419wms.3.1707901945821;
        Wed, 14 Feb 2024 01:12:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxOezHr9Ken6Qlj74dlNqC7gYnbf1Ft12W+R28mo1WJXagtOWt1QD87HMcOWVcGE+fK9DvZ6ajex5gx5QQ3H8XRSrOsTlZm7VWPidRT5b+7bl9gyHhALqUvmBw506UcPNlDWDb1tuPlrTEuFmtQksKWLh0Nr5ylNi/A6TDHVn75quXyLbRDog2isSMooWy/281eY/uU09/H7TjNRPFCD/ugfqIc2zUZTaUwzqLP7PXIgscaKAKUcil129ndsCMcESXH++aXmgGoLHbyIwZm0FWa/+XIJF6BWs+roxfmsEKLxky2G15Ckv+fYXQsHrdV2G/Kjy9Lokf59vILZpxOahErRwOdn5X78Kyhl7Fe7x22Jyr4eox9j7mTrM/q9xR+ipcbw==
Received: from xeon.. ([188.163.112.53])
        by smtp.gmail.com with ESMTPSA id ay7-20020a5d6f07000000b0033cf053fa1esm738376wrb.106.2024.02.14.01.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:12:25 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: arm: tegra: Add LG Optimus Vu P895 and Optimus 4X P880
Date: Wed, 14 Feb 2024 11:11:59 +0200
Message-Id: <20240214091201.17636-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240214091201.17636-1-clamor95@gmail.com>
References: <20240214091201.17636-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Schwalm <maxim.schwalm@gmail.com>

Add a compatible for the LG Optimus Vu P895 and Optimus 4X P880.

Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index fcf956406168..8fb4923517d0 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -64,6 +64,14 @@ properties:
       - items:
           - const: asus,tf700t
           - const: nvidia,tegra30
+      - description: LG Optimus 4X P880
+        items:
+          - const: lg,p880
+          - const: nvidia,tegra30
+      - description: LG Optimus Vu P895
+        items:
+          - const: lg,p895
+          - const: nvidia,tegra30
       - items:
           - const: toradex,apalis_t30-eval
           - const: toradex,apalis_t30
-- 
2.40.1


