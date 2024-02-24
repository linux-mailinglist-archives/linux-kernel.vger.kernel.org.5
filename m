Return-Path: <linux-kernel+bounces-79604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51B58624A9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010EC1C219CC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435173A1B9;
	Sat, 24 Feb 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMTf/rSV"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32025775
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775145; cv=none; b=OZZmFYXIMDm73Fw+ITLqLSsjPDxNXPS7GL1FkD1km1GrcxWKY2CyUA8sx6kbXA9uIsaVnUsJ9PophR9mP8PsacWfPz/MuVlQJDYM4A3BxweGzpg0C7mDLVIno/avu00XcOZ18icBHy2QnB48Pvd5MPxqPQtYma7E7n3orD51A8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775145; c=relaxed/simple;
	bh=F+AI7i5rKfjspsGK2+mgDUMQZG0c9+Wwx+/HYfJ7OGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vB5dPcbU26GCbve95sP4RHbWmW/vlfO/MSmZpHnmz7XR+Tv+rjxMonAv50LMcCGSw3WczIWQ7GLcWwqIq6sbU4INjdTGhceOD+ktpGwbvCTitCZZmZ26GVTdxJYWuE/33W1kgrBOe4mwRYEcynVRWWABre8Jj+CfIheGHu3D7pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SMTf/rSV; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512f3e75391so205048e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775142; x=1709379942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wh2ymzOPVRAR/yzwJtBUdFQu1uqttH3VxrKrEqGY3XU=;
        b=SMTf/rSV0vFXHUr/q4t8KE5EDZmkRrhx9n2d7ot/Ps+RI9AD8ft94EWjlIIqYqjWYU
         nbOmubUhslnypoDHQharAhFeT+XOXIwkMu1K/yNd1YW4dP1cbVqClGW/jgAm/QHgaoAZ
         no26X1Fc8BAkkxnGF7BhzX3jwV08Zy8jIpyqYK9cOi2a7fJNW/BoUhjQqvQhooNEvheR
         N0cntoFLpDO6zsvGlaEZqZB/EBDFz6gmt9T7bz/zc+P/mMbonuscIn3A1QptWRxCD37b
         NIveMxntbw/2Ki7XzTG+ELL6nmlUCgVqrwOloH0GZEV6jJb4b/j5KlbGtp54s8bYVe6D
         5a/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775142; x=1709379942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wh2ymzOPVRAR/yzwJtBUdFQu1uqttH3VxrKrEqGY3XU=;
        b=MNs92/OaFrSyOR5ZH7a5tUFhJB1t8KWu4TGwc94YSEQ/pXRk0esE9b4vHLHGPfvjVU
         FhIOtEwGVKQM6ksAUWaoiMTVHC0xEWFcxbghJrb7xdzGkBlb02TWuEfA7pJEpoPOr1R+
         fE7sgXbJw9XwWrpoNg71Dy+BVT1um11hkIg16xDDBkIb6YClfMJYBFGYsYaburhHo6N9
         koY1pAi64erR19iuAb474s3xUju9Vb1ro3jIALZv8aJk+ORMsE5YrUhvv2v5/3fuiJ2L
         UngUa90wqrGRNJILhFtOl0WPMxdoj5a5sKnbOEJWZ6aA/+7GOuUT5zU+rJ41a7xl7E4Z
         Gjcw==
X-Gm-Message-State: AOJu0YxqBKjHwdnJKTFLVfTOtYL9xZkZgBUoDboro5u1LcMCz0FAWgEZ
	qmBEFHcu2q1dxHb5acB0b6PAVNX/t59FufCwI3otx4TpPlBkYvYT/zeQKRAN/gQ=
X-Google-Smtp-Source: AGHT+IE/GABPj9kIkTpMFFhYcL7XKS8tq3tSGXLMixhyy/qqZ6irMOwrxPb51//1LzhQXz+zBY3QfQ==
X-Received: by 2002:a19:2d10:0:b0:512:a741:95fb with SMTP id k16-20020a192d10000000b00512a74195fbmr1428978lfj.28.1708775141935;
        Sat, 24 Feb 2024 03:45:41 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a3e209b225asm517826ejb.43.2024.02.24.03.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:45:41 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/11] nvmem: fixed-cell: Simplify nested if/then schema
Date: Sat, 24 Feb 2024 11:45:06 +0000
Message-Id: <20240224114516.86365-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
References: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=+t8xb6FTxyUQaM/SqNPVlxBKCT9nYlThK/83CSBDAJw=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dbLhk0Dgc84279u/3UKyKxqUW6mSv9XPTh2I NPnCqzW6mCJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWywAKCRB6of1ZxzRV N5bNB/9QWzZyB7EQbSXQqdjCr2uCEbz1yU139uXYTO9vT2gOoxH4NjTml1lzVBnfAu53tBrylqg TriEehHVy5tZ7+4te3Ty1CNlk+Se5MlOAZzKFmNOI43oVIFYiywcltv5P6sqF+BkkOlNcbAHVcc EpdbRCzwIuzBqE4eICLcYkuoQiG9X5dtVB8GnTGFaqdO8SG1h46ungzE4qLOxqnAVtmrkgRdfrp Ee4rukCR397xissAMgkbrG3MdJ5Wa0lT1omSqRizSFFO9zbYA8tlIm+vNwFJt37d8DlvJksK40r Vfk3eFtF5iM7uqsTISWjVd4tC9lghMmwCkUeR+1TwHydfy5u
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Rob Herring <robh@kernel.org>

There's no reason to have a nested if/then schema as checking for compatible
being present and containing 'mac-base' can all be done in one 'if' schema.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/layouts/fixed-cell.yaml    | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
index ac2381e66027..8b3826243ddd 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
@@ -36,20 +36,18 @@ properties:
 
 allOf:
   - if:
+      properties:
+        compatible:
+          contains:
+            const: mac-base
       required: [ compatible ]
     then:
-      if:
-        properties:
-          compatible:
-            contains:
-              const: mac-base
-      then:
-        properties:
-          "#nvmem-cell-cells":
-            description: The first argument is a MAC address offset.
-            const: 1
-        required:
-          - "#nvmem-cell-cells"
+      properties:
+        "#nvmem-cell-cells":
+          description: The first argument is a MAC address offset.
+          const: 1
+      required:
+        - "#nvmem-cell-cells"
 
 required:
   - reg
-- 
2.25.1


