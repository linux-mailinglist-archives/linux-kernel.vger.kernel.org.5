Return-Path: <linux-kernel+bounces-32221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536E78358B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5869A1C217EF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39F38FB5;
	Sun, 21 Jan 2024 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5nRf+t4"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E75374EA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705879176; cv=none; b=tVBohYa3MmVAhFkT7gELyMRkskJeC1fRVAII5b34aZy+yH2DxBCxIP+cPECqhXU40mXTxXhMtPTALdut2JA99HdrLGkJN4NNHGGKNyWUOkIdg4m1dc0cYTfm+rQgorSARIQoM5viVg3uny0EqqD2/9b65ttQdDtN68un+XFRnUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705879176; c=relaxed/simple;
	bh=jFGhe4INgpGrOcFfCFwWU2fFV4oMkP7+nz0nBhtuAqU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qIResKXUhLyLCabVsAMfOU1adqzNx4aFrdTEcUrpRr2l8z52zG+TlYBCFFLAH6Z7yBqgRAIcuiPZ0xHxty6r6u5FJ8kuboUQARVheYGNRwNTcwfmazRMi5w6GPNVXH/P7GjYVpoDTS6CHfBUTdwbBThLAIHtW9H6FMVQEBn0nLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5nRf+t4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso30678545e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 15:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705879172; x=1706483972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1vWYvNvYTnJx5QZ+pXmwciHkq+iQYu+51lYTFyVPoRM=;
        b=k5nRf+t4aPyxpWaqeq//N/3EuyPWgZa4VlPqgiHtBnCbXt1MaMy7aB9lBiTGGdz9pN
         lR82vbYh9clWdZdCBComZoyaQ9LcwXxHISkxJ7LRkV/Q1VzPdrwWJpk6EbuhxJA4dj8J
         nJ5wpLQwpH/SLlTz5UfDYYZvrc1TkISM6Ffvdh72nXugB5oVAYI4CkjaTlHSJII0Ofnf
         9GCE/mMGRqemwnlzpPsh6Jabfsr5pBjEwJElS8LYxM+JbmlH4J5HE/8uoQba+oOm2tin
         hUtulEKJd+RLEmIWEjFQTESKs61GDNbssKc8l9NV958JVkImXVcm3NPP7/+spAL1rb1m
         kd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705879172; x=1706483972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vWYvNvYTnJx5QZ+pXmwciHkq+iQYu+51lYTFyVPoRM=;
        b=bIDVteVIDGjK4cUjZd/YG1DXlCWVMxuVCYHHAExmpQLJ9T8Hn3M0dqKu35ClR/arSQ
         VU1XwXat/btzX3g8l92rVKCB/qi0Ssu0bw4+0pEqAS0EW87eLuj/O9OILWJXl+weiWzV
         cD5RqlZfrpKexkUHYjmRC2oGfIIrchDeGUpCrUj6mnoJ92JuX89fJItKxemqb/JnwcdK
         HNsmhUWnucQGTn1TBe0kXZtXtpf00Okp2i2QNkGc0/6Pj1pb51hKA/+rL34MYBw/M5qy
         BQRFwcIpV2qgmr9kmcPFYoKJdKix+yz0GxxIN+y7q5d/LB4Sv2kUXwplDZgENGjyMGA0
         btGw==
X-Gm-Message-State: AOJu0YzvGu3Hu0E3F87qXJvrHpWsrqofKIlNQr8viksbZS06QTOE1UrT
	mtudBH4xVZctJvNdTgokh+qAYO0SXqVw4AGRf6tytgF8tuahjPcU
X-Google-Smtp-Source: AGHT+IHqf2Ro5AlqXwlf0uoDGddTypFHqiWndBGNgKraeCJizhxj3aX3nT1ryYx+67yh5TEoE7iDcA==
X-Received: by 2002:a05:600c:4e47:b0:40e:abe1:388 with SMTP id e7-20020a05600c4e4700b0040eabe10388mr677911wmq.5.1705879172346;
        Sun, 21 Jan 2024 15:19:32 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k23-20020a05600c0b5700b0040e596320bfsm3349588wmr.0.2024.01.21.15.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 15:19:31 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: debug-ll: Document address for IPQ8064 Qcom UARTDM
Date: Mon, 22 Jan 2024 00:17:54 +0100
Message-ID: <20240121231915.28892-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document address for IPQ8064 Qcom UARTDM Debug LL Kernel config.

APQ8064 and IPQ8064 have pretty much the same register but on IPQ8064
SoC the most common configuration is to provide UART on GSBI4 hence
suggest the usage of GSBI4 PHY Address.

This has been tested on a Netgear R7800 while bisecting some problem
with the ARM decompressor confirming correct output with the Debug LL
configs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index fc2b41d41447..2f8d0a35853a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -795,6 +795,7 @@ choice
 		  ARCH      DEBUG_UART_PHYS   DEBUG_UART_VIRT
 		  APQ8064   0x16640000        0xf0040000
 		  APQ8084   0xf995e000        0xfa75e000
+		  IPQ8064   0x16340000        0xf78af000       # Common serial on GSBI4
 		  IPQ4019   0x078af000        0xf78af000
 		  MSM8X60   0x19c40000        0xf0040000
 		  MSM8960   0x16440000        0xf0040000
-- 
2.43.0


