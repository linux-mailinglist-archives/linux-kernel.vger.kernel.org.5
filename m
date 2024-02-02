Return-Path: <linux-kernel+bounces-50238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F85847623
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989551C275B1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67114C5B6;
	Fri,  2 Feb 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z7PwQ514"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E536614A4F2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895044; cv=none; b=b+YJmJeWcG/sAesP0PUYwQy1Z36+xxwP8G5QEJYspoAsRJo44+VR6DVVohoMgegNrdVyaIyBoHEMvDQRRdvrfSdMY2zIJWNQ9M+Xco8UQbZzCElvMd3U58EL9MWrQBthg4AOTAh7Rv0SVC5IFWri8sNajj726xShNTAIjrrsOBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895044; c=relaxed/simple;
	bh=yPuFc5Hx096mrPElw26CkIg8PftBQLpZhjMEh1Ai9Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sF/jYoEllqDSQE3det1HcaXELn4RSQSmVvyDQ6oWG8YOX/jQeIWxG+75AR7GbOprLZnOVAbzdJLGfdGIqVPVw1O4dWtpjWT0Wes6NT4SHPACTstPofBrg29fK2oX8hMSzykBClTze/g5LXDuOQlqB1mctAL/65L3PfQ32GTGcLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z7PwQ514; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3566c0309fso315718866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706895041; x=1707499841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzgmnc/dVe67zqThKg2HRZiMqYk93YXXRdjM9PXNfFY=;
        b=Z7PwQ514xyA/s+47Kcj4Zz1EKyOMm+aKZwdxJLJBIR5SvAhbc0NUTXjPhC3nxLvK14
         Kwq3bFFkbeA/Rdl/P23HG3pneSt9QAwLKs0Z5yO+X9eEilFITTFZ1jTkvW87Itz62PxM
         MyC0ML7TSmLFMoRWxW+NWCdogvW9p48xMCFHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895041; x=1707499841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tzgmnc/dVe67zqThKg2HRZiMqYk93YXXRdjM9PXNfFY=;
        b=oKAJAFO2b8RvGOLzKo8QfEgNCNnM6mYfayfpOrmf3AHZcjDxXIt0wNri0wxAajCsgD
         e8IpgKw0UWZAG4uGAsSpHmxLZC8vz0shnF9qbG9scOPWAT8WcNJS5kns+nWcJDB1LTGt
         E/Q/uV+R+WS0ztee57N+v6wGVoP+K9+EuFPe3TIo9nlVQPRukKylQmM8NU/0y7AqDw5N
         hjerrG11/gm+Iyi4V3N3Ld00+y6OeO4R1SKYyJm4fs/RgM2fFU1gphuvf3HMsW/AAhmZ
         fB5QUf+ZFz/8Dj03mJ+R8DE/8b5IrG0qCWBVMwl3kjZYtRfPelD9rKCUNZys9ZbuJn4e
         Jbqg==
X-Gm-Message-State: AOJu0YwoJwjvLI0eR+uPCvmeso51SGjrMIeD1sT1SMS0XMlELP12bsHe
	KzAuTyx8gIGXMA1oBqkAjJcIO1pcYDp4nRVavQ9ea73D6rd4U+VLAr3zR0EpXA==
X-Google-Smtp-Source: AGHT+IHP/5ZRaiYDK4PC6NOpbhF4S/tt6Owof3FS9hi+3Z07dQE03DFVssqBWWiemWc6kEze73Kx1g==
X-Received: by 2002:a17:906:3953:b0:a36:bc20:9a40 with SMTP id g19-20020a170906395300b00a36bc209a40mr4037025eje.48.1706895041195;
        Fri, 02 Feb 2024 09:30:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVB+aeDQCmsjLIJCF1+hLEAB2MNuxDgtEcELXJAQrzVS+FKMfLPsHVNuRO0/x/w2ifw58p98oInEOeEGBFF/BoteWFKMfzmLbWwwF+yXGN5t8EZcLqc2POFH42h1uQwwSuLnVaQdpOEivnGT6yndjNtKffsMy/xOY63No5NoFBQA5+/AIROegXmnUIb/JrIbajw2npi4/Iw43KUERPlznK5KkPo5ADrHLBagAy8HrwKygw=
Received: from chromium.org (66.224-78-194.adsl-static.isp.belgacom.be. [194.78.224.66])
        by smtp.gmail.com with ESMTPSA id hd34-20020a17090796a200b00a36f314daa6sm1083392ejc.46.2024.02.02.09.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:30:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Simon Glass <sjg@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/2] arm64: Add BOOT_TARGETS variable
Date: Fri,  2 Feb 2024 10:30:33 -0700
Message-Id: <20240202173034.221790-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202173034.221790-1-sjg@chromium.org>
References: <20240202173034.221790-1-sjg@chromium.org>
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
index 47ecc4cff9d2..83cd2b7234b9 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -150,6 +150,10 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 
+BOOT_TARGETS	:= Image vmlinuz.efi
+
+PHONY += $(BOOT_TARGETS)
+
 ifeq ($(CONFIG_EFI_ZBOOT),)
 KBUILD_IMAGE	:= $(boot)/Image.gz
 else
@@ -159,7 +163,7 @@ endif
 all:	$(notdir $(KBUILD_IMAGE))
 
 vmlinuz.efi: Image
-Image vmlinuz.efi: vmlinux
+$(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 Image.%: Image
-- 
2.34.1


