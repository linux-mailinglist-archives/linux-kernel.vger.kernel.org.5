Return-Path: <linux-kernel+bounces-82958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D0A868C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266FC28B4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6EF136679;
	Tue, 27 Feb 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2ydSR2i"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939D130E27;
	Tue, 27 Feb 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026169; cv=none; b=qji4ViD9dKirfT8G58osz6pBMcHqulnRZZ9mJji9VPbsOmPMawBJbPZAepDxXB9hBVXQYHxoHLjSJfbTZHlcyggMMX2aACKTNUNvBqSmOh0DXC5qJoLuOLNaxGxzJaJgPn5EEz2TMEekspVHy8b0SwIBxmYyUzkSVkGAh2lknlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026169; c=relaxed/simple;
	bh=od4XU1hdyTJ3rvIirIZtnplulWhNmn6d0C0ZRUqZYM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WtdIuEFz80IUaOpoNlO6oJtHDwhBriPwk5XyFKsDDm0zbG0OwNysvcvjAEok3xeOB7d91HBghXoEAN0UBLcgFezAZ2t7PEFDuXqkLk51Dysgenx2zBZeeHq/W96bjl63/Kak6lrEEQ87zQRZXPF2/mP27M1/zbPjiAqecS8Z4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2ydSR2i; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e544f927d4so573846b3a.0;
        Tue, 27 Feb 2024 01:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709026168; x=1709630968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=canrtwhVAgevvzPaKnrmGzi3BBVp/VV3jvjlMXIMo5M=;
        b=J2ydSR2i3/91YRV8nLWodVlnLy2Ddq4vUZ1yWjwnHgzp+xw98j5FedmvWLFKbF3y7U
         k0KW40YHZZMg/aM8YuRHEGxS02ghGyLyU76eIUPkWH2vd1LO0IAyK1Eg7VJtrYEXL2H0
         8bjDCkML4VT4LFbCWDVfj6BQ43TYGbTjCEPYQypFnH5k7hFdyp612cKy4U1l5+xclXJ3
         MvX6Iv3aLAxTH3vPB9peb7PdYHzrFc5LSFdSASUlyyOKuTZhJT6+kunSV6I/zJlzulAw
         y4aDUpQqoXv3Dtj0I6idHHCsN03Z17Jzc6ATIkJbVqOq1Cz/PzWowJJ9HxPx4HUcm01H
         JFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709026168; x=1709630968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=canrtwhVAgevvzPaKnrmGzi3BBVp/VV3jvjlMXIMo5M=;
        b=qaICt5I9zBi5y0Zc7f84uhmIz5825hTJnyCiFkxbNl8YsBFnhoykqTu50GYzLCk1ox
         7Rt45kXaMMCc2GKLyX81/gXiwcTvoEPIjNHDJmczOqgYZDpR/jFMRFcKTfqlBQQO2T9M
         DXAVEVHRD6pwOG6Sm8CmKt41arWPDEfwLPgv40kOijSaD4G7h6nDf8hLJo/HhuL3mHHg
         kXkIva38IqRtaISw8N4vYyqmcmms7BuPF6171eUigEacvZ7nIH+3uocx/t+8kDujjJDN
         oEHnn1Wr0zQ6QjJYTTsroO1jk4ynLmBla/zL0AXuswjJe7oCv5/YqX4OpTtQ/BBsJMK6
         +uxw==
X-Forwarded-Encrypted: i=1; AJvYcCVrWT+4NUPJLsVxhKFJnkIDDeQ6Ev4lOUGqH6UOQom3d0Q4qkCLsj9XI3bjjLV0i6ucnh9dIz5F9qBLGtWX9e9p4eavcwB6DQLWg7Q8Sd9NQjxj7cbZ1jhQ9WeYkcokEu9FyytQooVUug==
X-Gm-Message-State: AOJu0YwPaUzZ2OKTEEVjSiF06a3Xsg53b3pSrDegmDnUSkXeCV6JvXlj
	JlKOvFTyK4ku5HHQ2Cyk6CHeJ30FArntncCOkukPpKEOyk4dTJcPCjWJW3hjBAc=
X-Google-Smtp-Source: AGHT+IF2cuiK/7Cs5xtPRW97LK4Jz/nL7N1txsyOo2PjySUhueK8cbGMj9jrU/+BSRvH8k1lsdEhKA==
X-Received: by 2002:a05:6a00:1883:b0:6e4:8294:e0e5 with SMTP id x3-20020a056a00188300b006e48294e0e5mr13670221pfh.6.1709026167895;
        Tue, 27 Feb 2024 01:29:27 -0800 (PST)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id g6-20020a62f946000000b006e53cc789c3sm2167169pfm.107.2024.02.27.01.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 01:29:27 -0800 (PST)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kelly_hung@asus.com,
	Allenyy_Hsu@asus.com,
	Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Date: Tue, 27 Feb 2024 17:29:21 +0800
Message-Id: <20240227092922.1734998-1-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on ASUS X4TF.

Changelog
Changes in v3
- correct string to asus,x4tf-bmc

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3..0d72a1a9d 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
-- 
2.25.1


