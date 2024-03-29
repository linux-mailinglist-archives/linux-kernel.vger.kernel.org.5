Return-Path: <linux-kernel+bounces-124086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F147891201
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C2A28B7FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2068A39FED;
	Fri, 29 Mar 2024 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ojtcnr9o"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153BE39FD7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682956; cv=none; b=IfA/Fcvoln4C0OVSqd17FY9aubUYPE/TCQxdB1MBC2v3UpYg6Yz2AlM2As7r8OxKIkjVKaK+NfIqYO1NAY2U/Mid4SQ/cyAlfm0lnFD6ZwPW8XTZwb0RiC8Ae+qCg6nMc8s6colKhhBq5GqQQot7ySOPBqUZh/cTpjeMCLoTLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682956; c=relaxed/simple;
	bh=dNfCnyYu6IRwrfNMDUHXM1j1+SDL3HQcYxuxumbPwlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7fvMIKUTK+tC0lklwMllartaTc33mS386u4KKDuBDXZa3T11+ll2I7a0gO+bRR1OpoGaIt1tElAyzsAHsXE46LLhCNbKXXQ+FecipaJhewWluO+PiZJprq3SHJpaCHTmo9TsGd5NKAd9xMWrOMJL3E5IAVGfJCH4rLVpeItLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ojtcnr9o; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36898a6f561so6602425ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711682954; x=1712287754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj1MXeANmDRLF3MEitp9MoX29tLTgbBs/EQT3G4Krt4=;
        b=Ojtcnr9oc1m/Nmu2KY/TRpqAq/NKugsXhGy9v3aGId/si6lz9M+YVlLw1hRn8QmxtH
         2vc60Y0r9SUDikFiUYalrF4H1nPTDJZftvF2+hvnkHgITBzDl6RUyCwftyH1HMsMsDjS
         1ipPpCd85iJsgPoh5fTldHuKkBek135+REbko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711682954; x=1712287754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj1MXeANmDRLF3MEitp9MoX29tLTgbBs/EQT3G4Krt4=;
        b=TABwLxRw09XpXdMHuG/4Zeju5T4euDLr2z5zaLfOmMZmXSA5da/w8/r6NkHPpmyqKt
         um039+maiKwyEL+vh5+12I6r3npRUWuFcJdFZH/OHJ4AoubMwUnXzTpKxh+xM4HxY8GW
         h+ZAthg61YU9I7aWwwYYrYQ0zv/nvod/zs2XO2FkGMAmN8yDFPbTESj19723rAXjKHKc
         bwD1qj8IJ0C9yWsFyNnk3Uocv0IaZlkM2SvhVpGkdf5RhcuZ3BFF9C3LRslmJV3frY/p
         8H8d/wW2rBN0RzBAQq++4VKOu4HPxcgoosF4tSizp9CaqsaLgG1qQ/TJk0Bh4tcAYRVB
         XeCw==
X-Forwarded-Encrypted: i=1; AJvYcCVVrkAnr5jFXsMvGiykUP0D7DkdvRhKyxvOc9xER/aWUdcmv9RkVaY3ktwRcu1y61JNELq7T9h6I6ChgL8mpEywsGBwycDeE+p7cCei
X-Gm-Message-State: AOJu0YwF6ztys+UFYof47jj/vP1Z58g4mdldtwVDAERg8braQ8pV12Qb
	ARQn9xHpX1JEdinxX8qtRMA4MphF3Qwqud40/M2sDlBlMkxtZmS6ZecOtYFFVg==
X-Google-Smtp-Source: AGHT+IHBhFtUhiYlCuiJ8vSmaWzsYvUsbY8e4AkQFg1uPMmLqjZTiVReHnzCvjKoN3uPKuij/fEP7A==
X-Received: by 2002:a05:6e02:b41:b0:365:1d57:6da0 with SMTP id f1-20020a056e020b4100b003651d576da0mr1077561ilu.26.1711682954344;
        Thu, 28 Mar 2024 20:29:14 -0700 (PDT)
Received: from chromium.org ([75.104.105.200])
        by smtp.gmail.com with ESMTPSA id l7-20020a056e021aa700b003685b574968sm815717ilv.51.2024.03.28.20.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 20:29:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Simon Glass <sjg@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 1/2] arm64: Add BOOT_TARGETS variable
Date: Fri, 29 Mar 2024 16:28:35 +1300
Message-Id: <20240329032836.141899-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329032836.141899-1-sjg@chromium.org>
References: <20240329032836.141899-1-sjg@chromium.org>
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


