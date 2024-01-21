Return-Path: <linux-kernel+bounces-32012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5D8835546
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443D6281487
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D32364D8;
	Sun, 21 Jan 2024 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="i7rjG8Qk"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3365FEAF0;
	Sun, 21 Jan 2024 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705833649; cv=none; b=mR9fEAz1BqhLd8mqV/NTlhz56NqGTmxDr6Ubt+QYxKAkWpA4agtRna7lJ0oTuxCH7lmDg7PGn+K3UjlteTEb1Gb0j/P4XZrx7uPfpid4pvn4RHYD0Mm7x7C9norv0sOshj8bvIb73gc3NryIEhKuY9JEC+DNGXXll7PPIdV5Sn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705833649; c=relaxed/simple;
	bh=Y/aNKL9qun+wRAcg/kdmKlSDqC8Nm5NAprHi0zYwPC4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KStpfCnkG8K622GDqYnN50dH6HeP4uyc88bgEshAssUYANEcgvwL1fkhP/vj4bX1O8d+B9/90QQE8QoD3xoWsmZ5GX425wauNLiaL/KL27fJObkrG0RLxOsnMYrJ5XLIjVG5yImF9BcejaUDPlXwHYEowvTdaS4AMI8gVXoVROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=i7rjG8Qk; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1705833646; bh=Y/aNKL9qun+wRAcg/kdmKlSDqC8Nm5NAprHi0zYwPC4=;
	h=From:Subject:Date:To:Cc;
	b=i7rjG8Qkbtd+wkqWhFUQd2PtsJhanUASEliPL2d3GiKAq9lhCetjMVZNiww5kYeAx
	 +c6NbcudNrJQ3n8493caZXQJKoXs0KtQosDu2ByM08nZ/+nzwGkHXaNg1AZaMK0SiS
	 7MbgtYztt/lkBa/uyPcyYjmlr2arUO1VqsEQz88w=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/2] Add GPU support for MSM8226 (Adreno A305B)
Date: Sun, 21 Jan 2024 11:40:37 +0100
Message-Id: <20240121-msm8226-gpu-v2-0-77f4a6fbbca4@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKX0rGUC/23MSw6DIBSF4a2YOy4NXIyVjrqPxoFY0DsQDSjxE
 fZe6rjD/yTnOyEYTybAszjBm0iBJpcDbwV0Q+t6w+iTG5CjFEJyNoaxRqxYP6+sQ2vr8iFbZS3
 kx+yNpe3S3k3ugcIy+f3Co/it/50oGGeV1miFRmVK9TqkW9b7th/QpJS+KBREJqYAAAA=
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=Y/aNKL9qun+wRAcg/kdmKlSDqC8Nm5NAprHi0zYwPC4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlrPSqlwnLBQalHp1X9JLwPf7cZeE0GomrAUm6K
 4fEbfEopymJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZaz0qgAKCRBy2EO4nU3X
 VlKQD/4+0eIXBxbX6Pv7/0sI/ZIJ3MRALmu7yQ0Ch360aLiqn/kGiuo6SZgKPGlW2GXQZNcCoEh
 +slBN1T+cF8+43/nJ+ztdmP1Wyj/Xpq0CRv2AAdo+X09F3D5h2eTcxQvljvFv+2nhi5hZLTKAtb
 Jh19npcwW3j6QLIJbCBAB5RCvmOh+YeX0s9cI9oSXWoiuf6baMVbERcTCfckQ8LrQBuQuWVPCvR
 D0Y/upqe6rMSbzzNMfuWYIqLwhgsLWramH7iw0aoVkR4z0kKqzKNx/EVXheNJs+UfoPnBvutnha
 Ozt0/KT7kPxIQgmNgkT2j3Z2Z+VyJq7SBaIgmGCkPC4htGtEHJ6HOFznHhjVcIauKUUBPvMS02F
 u7+dyNqVEY5qBGo8rcGRZ3Py/OeMPmqfi8fQwFtQX2fMqh4W9XhTIYBK4G4fwBRQrgoKTI89tCd
 viNKJccZ/pdNNSFJYxVZ5IBGXzzT2EQ6+F1u4wvYM0X8riuFQIv68IBLueONNyR1nEhFNy21Gx1
 Jf+STDiUmUw001U9fLP3CcGWvlvO0PIeC2waXrMaUxACJYGHWENgYU081ow9wpb6VJiqmj3B1Fb
 3Z8iCWd3ZcMDg+JjjV1dzXE743VqDygQf0MGNMmRlFRLg9UWpMrHGNQAlmrhbE9ivjxuTTPKZK6
 cLFzuatSvVfZWYg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the necessary bits to bring up the GPU on msm8226.

Tested on apq8026-lg-lenok.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Drop applied patch
- Use "if (a305b || a306)" for writing REG_A3XX_RBBM_CLOCK_CTL
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20231130-msm8226-gpu-v1-0-6bb2f1b29e49@z3ntu.xyz

---
Luca Weiss (2):
      dt-bindings: display/msm: gpu: Allow multiple digits for patchid
      drm/msm/adreno: Add A305B support

 Documentation/devicetree/bindings/display/msm/gpu.yaml |  6 +++---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c                  | 13 ++++++++++---
 drivers/gpu/drm/msm/adreno/adreno_device.c             | 15 +++++++++++----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h                |  5 +++++
 4 files changed, 29 insertions(+), 10 deletions(-)
---
base-commit: bda7a2e04984237bc14ade7c9660f76fbc035686
change-id: 20231130-msm8226-gpu-c2ff8473a9ff

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


