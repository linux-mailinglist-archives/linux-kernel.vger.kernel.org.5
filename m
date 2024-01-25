Return-Path: <linux-kernel+bounces-38777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B383C5D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D211C237C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718912CDBE;
	Thu, 25 Jan 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLLbpOF+"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045D12A15D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194240; cv=none; b=HsD7zO3FEr+xpwlx08OL7Sa5znq3yN/5ELrfzFhO7NOUkZvyN3k8SbjDM9ITqfPxSGnpjyLFC5WIZ9SJxQErE7eguvzvncjL/MSLOTtJNm+TnxDcMuRWaXF/QJbpzpHCu83ILuJ2POIYJ+5DkETkLrs4gblHIfA8YvHUmiTv1R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194240; c=relaxed/simple;
	bh=3Sscy4SIyyLUoLIoYgcWj2m0IaAGdXixvvR7f7b5ods=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1KiL8ymzep/wsD/Zjx9+ZGWiZIbFXrFMAl7tXDJxH2IJ/hKL+lLKZfQBlMTuQ5vXU2IUk68JLZrz2AU35RSWoKFD+ZMy+Cyp73MRlvyjVrpMpTSEwqGdOC/CSA6kkmFFMrLHAYEvaC/O5wetcTz+SY4a6BvAWYK9/DJPZMq99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rLLbpOF+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so74517195e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194236; x=1706799036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4aDiYMz53oQSBvKn2Ur1bqI8j5m6Uz7Sia7O2YMwFw=;
        b=rLLbpOF+ONoXE5ED77jjcufAhhoCz5wU2NmfsBgEHrC2evAxUjPHYWmN/cfOVJLMB7
         4R3QBx79YgCeZtkBYEL+cH1HlP88RcV47hlnKTuOxLqz7KoGWiCTfVElkViDxvJGu81f
         NwuTDJtdqUjnMMC9IBCR2mHqc1NDGXAxKr3UYR0gfy5ag8t991n2Q1C3r0lL1/XXgOcW
         IoTqVnRqQVD3mYXNDpN3iywmXk/L+uubsVrqNkg/RGp5F/93ryDns/aWp3jQyNFDUd8n
         jMbsNG9/eQvNSZE7kTMVo1Depdyh+gvpCWFiL3KbjJEt58sRlOOXH9maMpKx2bP442OM
         NKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194236; x=1706799036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4aDiYMz53oQSBvKn2Ur1bqI8j5m6Uz7Sia7O2YMwFw=;
        b=s58CXAatzqvictHcmOZppg1/BM96L8BGE3CKTmpvg/AjBO+wq/KhvnMouYydy0A61+
         v6Lfn1ROsZwVrxxxoGzc8M2XlWda/eaY/gnA9h3h+YbBqSD4Qwr0potfv+v1SkZsvEo/
         fDAaKBnnYCy2cgZ6mk+rI2of3JAjomEXfXpF/BBnBlnTTCCvu9bB3sYAE8s9PKFH7mf3
         uewjybTVqXNHDdVYiYkN6s2bPmywe/h+2SFslfVPWGHf328ZnW+SOFjBg4L75xFTDC3E
         Kq4X6R+N/tyUis6bCoqffC2Xp2Z0B+WWlRaIutgGZoTCwZ48rhAlG4i5RRDcae6ipEGD
         GnCg==
X-Gm-Message-State: AOJu0Yw+l9G2Mm4//+ZRN4vuOAqCAMQclFoOfs64Qy8hC32aTBwt44j2
	iTczVP5/2LoFq3FqSm7X2BLn0hQJZSkCsLTucmhxzzg2DGHCB1hRarVLImblPVI=
X-Google-Smtp-Source: AGHT+IE7/zbpGORnJLRqmbZzk50i5Tn1H9FBZ7QHo75PUDu0GzJbbvQE4kU1u7rK+rLs/4lIcENVtw==
X-Received: by 2002:a05:600c:a45:b0:40e:c309:55d1 with SMTP id c5-20020a05600c0a4500b0040ec30955d1mr383831wmq.91.1706194236022;
        Thu, 25 Jan 2024 06:50:36 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:35 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 28/28] MAINTAINERS: add Tudor Ambarus as R for the samsung SPI driver
Date: Thu, 25 Jan 2024 14:50:06 +0000
Message-ID: <20240125145007.748295-29-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm working with the samsung SPI driver and I'd like to review further
patches on this driver. Add myself as reviewer.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..b9cde7ed8489 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19404,6 +19404,7 @@ F:	include/linux/clk/samsung.h
 
 SAMSUNG SPI DRIVERS
 M:	Andi Shyti <andi.shyti@kernel.org>
+R:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-spi@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-- 
2.43.0.429.g432eaa2c6b-goog


