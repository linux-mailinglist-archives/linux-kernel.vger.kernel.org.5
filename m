Return-Path: <linux-kernel+bounces-142374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFDE8A2ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5771F21D32
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA5853E14;
	Fri, 12 Apr 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMABSvo8"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D11353804;
	Fri, 12 Apr 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913497; cv=none; b=q9iZsQUv9N1F1xs+kFdIRbxumYI880FEWg8vHXqCk6bhvjmSoMPrkv9mo8rjcq6V35nWJce4H0ddfhoyQelvId/x8XfqNvPxOvnOd94fNhtplSGHFmoRmzgEPrDB9Y3Twh7MRLMDX9BfumIBtgp2q9lXTD/F51TqjWBgbq5habM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913497; c=relaxed/simple;
	bh=JKiYk0LR7yM+OlGvUuYEMLdDUknawu7uYlYpmKIx9Ik=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAltb6yuBUxUnxyPjmP7BGGpLiXhu+mUhf+VlkeCrwwN47DeqZFgIvpI4Abw9Bovl8P00RqRcR9hpoRt41byZpT0WUkcD65nF4ddA3pFZiqvtOwMbqTMuyTmUcrevQ2rNOtkMx0dI7Mam3kF8kxkflf5GXvfL1me37xBfm89LYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMABSvo8; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5aa25e99414so483815eaf.3;
        Fri, 12 Apr 2024 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913495; x=1713518295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mmt0UdSDV+w1BWZtmNFxfAxPy3KjCbVYZPCzBNdDlQ=;
        b=KMABSvo8hvazSUd2BHGqXGpYTBi5trzbpbOM2hqGo/k47hbjJ1ZoKxa9hyUyaYsflG
         6rG0W9Mn3fE6yT1R8W4xEJAngleXw8iM74P55ioTBShzX0ThBeumuKq57+vkBeM2sQO+
         YcUu6zbHlLoSmrC5NhKf+tvWGuKgiPUJREZHsyS+n4dnttQMwnijOsnfSSW53GaScSHR
         lsFRgRFN7Ji0E61fYXbvDVQJgc67owpGQzjwtBelb1Csa21vnYXMT1WaTAG7X+L+Md5d
         3oDU6b3wgI9HY8P6xqBMS994+gb5KA1iyDLIZ86HDYUty/9D0+d1SuqG3uXDpD43AkCg
         fgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913495; x=1713518295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mmt0UdSDV+w1BWZtmNFxfAxPy3KjCbVYZPCzBNdDlQ=;
        b=gwEjmvpLJVdL8laIPK0ooysR+1CH6o0qPiZ2n2BN6ZUb1KnsfguHolaIqe7cENaL0N
         mu2xag2dCb7UlmoN9PxXIfDr3f9nmizQnW634OkhD/pIwnEP/b3L7f8kpZ6hM7RQ0i5H
         fVz8fcRWLQ5x1lesjfNsxFT8mb4Wqvko3qjTJbwqXsILTx85y1ADvgH13V5oCIiww3zF
         vuIakJjS8xPOU3siPPGwraf2C7Z/1+6A/NLM6YimzdgvE2vPUuzRI8N/fYf0VgdeNjbW
         7JQY0JaYRo/hYiFUbHlgy0WxuBIDvLO4krXxIkv/vBkoNAQLnxvuuRHYIjvCkqTJla07
         8Iaw==
X-Forwarded-Encrypted: i=1; AJvYcCVDho1cBWtRhT2WIT8GDU31HQP2636wbza0bK6FyW3GBsoU1QmBnjyxo70VGvZGewgHNtDS/rKvSNtKhwMTtPdyq/5XjltegY5Q1AUPs3/5f21DDC+R1fnT3LJpVRrpqGGYb+cyMiK+Ng==
X-Gm-Message-State: AOJu0YxUox0jdz0Lmc9tSsObx4nRw5TJhiXbEO7asJnn24M3OdzW438Q
	mxbc7plZ/e/2ARAkVqaZV5sSh2Lj0YbPwpv6/VR35hIoWhLfauJ1
X-Google-Smtp-Source: AGHT+IFTZ+X0fi1cFZo+/AzTETlyhVl05mV1/xX3nQzSXyUyT5f8pq7FfXFJJb8hJrEzZy/Mxbq+OQ==
X-Received: by 2002:a05:6359:7906:b0:186:2b2b:c91e with SMTP id xc6-20020a056359790600b001862b2bc91emr1343502rwb.19.1712913495271;
        Fri, 12 Apr 2024 02:18:15 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm2332711pgf.30.2024.04.12.02.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:18:14 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/12] ARM: dts: aspeed: Harma: Add cpu power good line name
Date: Fri, 12 Apr 2024 17:15:52 +0800
Message-Id: <20240412091600.2534693-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
References: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a line name for cpu power good.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 5d692e9f541e..36aad01dda20 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -501,7 +501,7 @@ &sgpiom0 {
 	"","reset-control-cpu0-p1-mux",
 	"","reset-control-e1s-mux",
 	"power-host-good","reset-control-mb-mux",
-	"","reset-control-smb-e1s-0",
+	"power-cpu-good","reset-control-smb-e1s-0",
 	/*E0-E3 line 64-71*/
 	"","reset-control-smb-e1s-1",
 	"host-ready-n","reset-control-srst",
-- 
2.25.1


