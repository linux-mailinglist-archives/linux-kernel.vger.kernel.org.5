Return-Path: <linux-kernel+bounces-102770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF9A87B71B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2731F22F87
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779278BFB;
	Thu, 14 Mar 2024 04:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nbvk6EqY"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAAE611A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710390508; cv=none; b=JnZ7LLnSHfTLq2FQ/BmXISxNTxc6RRjHtgYN6HdL62QMXOsfqIclekZw8o3NUKvWOHMuEy6z3+giGMOLHpiifZvooT7gPWJbHTMXRD0YEZwuKFgAar7anqRvv56ihX633lyES4l1X1qsQhwG1KZ+mHTt2yvlE/FJuTtzNPvYZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710390508; c=relaxed/simple;
	bh=dNfCnyYu6IRwrfNMDUHXM1j1+SDL3HQcYxuxumbPwlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rBL/LKDrpHnF5aVVkZhI/VJj57Qhhs7u3dy8wTn1+hnZjxIvl1INw/6LnUsmsmACFXcfmdM92/Z4JjVGBYgID6q8c8dotJHJMpV1X0kRJR7YvfQQdrnSjGA80mlzgIc9nK2AgQnENXzpWF3CpRDYRhc+Ke67qcPag8GTZHaXwtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nbvk6EqY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dd8f7d50c6so12618635ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710390507; x=1710995307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj1MXeANmDRLF3MEitp9MoX29tLTgbBs/EQT3G4Krt4=;
        b=Nbvk6EqYOxCdsE14WIpHDvSh/SAVZfw/QlZF8YujJv03OtGkSOLE/thrxPYEIhPWb3
         wGZlAPCzDOhNfp6l9KuZQPM/ZVF8sBP03HlATb4Ttuoy74ItCc5ZJ5NnmeJtrTSiEjpK
         xfmhumo4zOt00oPM8vmkvpsnlWOkMa42zlImM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710390507; x=1710995307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj1MXeANmDRLF3MEitp9MoX29tLTgbBs/EQT3G4Krt4=;
        b=mnDT3X8EmIDZ4e4YnDIQozdMcvdu7qJaZGQbZuzxerLAepGQs2Ec84ALWLSR6BHV2c
         xOuphcYt027i+mlZxfmQqDPCkQEmxz0nBINCl3ztnbCh/Vjj+PyAHiAwBYzDn7edgKaJ
         SYBC5qnjImiUe4jy15V7id50B+zP5ERxO9NIOPhh8/No6+lKb/HX2EoEbwDLFggf38wL
         koVmfwwveakYR1uMWI9e1Tge+JQ0n0luNrKXlgYAaxS5SskOG4WA623Z6yBFJpKoQnR+
         K5uD7/seeY9EPLVg6J+qUU3axmoPMwOpsqnBYOORaGDQgYnnZ5V3d7yQdb7LkL9Ct3Dc
         YDrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjN+UYXxJHi9X5LQu0+TTS/LCM8QSKqNxmZtj28oBArumkrOIlhNmGsshYjXIpooGTE07w3rFJ05KhqkFfWKFVDdvOaf224K4sbNZE
X-Gm-Message-State: AOJu0YwgQ3zduPLlgAtx6Gci1IwhEDQatYMC4Ji2XFJm50MVgbs3ylFG
	e0txlgxiGjpBYBiyWGxtREiysqmupSQLlVTLiiw39rfZ01SW+fLwf3iUtuT+zQ==
X-Google-Smtp-Source: AGHT+IGGQ7GdScbH3CvI6seZ6/6CyftsJCfDx8hL8rSVmYyHMWvrc7qxaObFDWDqWeqs47hyWv/jkQ==
X-Received: by 2002:a17:902:f612:b0:1dd:c938:8f8e with SMTP id n18-20020a170902f61200b001ddc9388f8emr1411096plg.10.1710390506692;
        Wed, 13 Mar 2024 21:28:26 -0700 (PDT)
Received: from chromium.org ([118.149.78.37])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b001dd98195371sm479200plh.181.2024.03.13.21.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 21:28:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/2] arm64: Add BOOT_TARGETS variable
Date: Thu, 14 Mar 2024 17:26:58 +1300
Message-Id: <20240314042659.232142-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314042659.232142-1-sjg@chromium.org>
References: <20240314042659.232142-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new variable containing a list of possible targets. Mark them as
phony. This matches the approach taken for arch/arm

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v7)

Changes in v7:
- Drop the kbuild tag

Changes in v6:
- Drop the unwanted .gz suffix

 arch/arm64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 0e075d3c546b..1217d97998ac 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -154,6 +154,10 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 
+BOOT_TARGETS	:= Image vmlinuz.efi
+
+PHONY += $(BOOT_TARGETS)
+
 ifeq ($(CONFIG_EFI_ZBOOT),)
 KBUILD_IMAGE	:= $(boot)/Image.gz
 else
@@ -163,7 +167,7 @@ endif
 all:	$(notdir $(KBUILD_IMAGE))
 
 vmlinuz.efi: Image
-Image vmlinuz.efi: vmlinux
+$(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 Image.%: Image
-- 
2.34.1


