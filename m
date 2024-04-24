Return-Path: <linux-kernel+bounces-157828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30618B16EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A73A2896AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F274916F0DE;
	Wed, 24 Apr 2024 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JqJZdzQb"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B7216EC1A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000470; cv=none; b=uPw92ErazdVhi6QzYKbzDgLN/4OcqHAlsAQVfk/lcOlq9+8yKJX0f97ow7U96yW+cQS9vPXGgCuoO8TxrPZUhrU2eR1u0b+uCrBX1Vgmb0CVmhgsz31pSsrz1w1IVbXDjbXBSycpa20aHgBeHJ25FV9gYegcC8pR2CKSklXYdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000470; c=relaxed/simple;
	bh=nJNB/KulTbCbDLeJblQkEeFfKzMceokVHJqyrs68Oh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kxFPDBKZ4UZE6+/40DFz5uTIwaJkugAxPK43zu5pl2F1hs1facIiHTCSyBWkvLXaHB22hgEWk4vNKsqQzk67a2PIuptyYnJuPaZgbCibxrBlKrnKj6lnSIDPWpEv1Hb6owOB2wM5f5Wsb9O7ecIo4UdJdBQUBtQFYXdiDVowzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JqJZdzQb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6effe9c852eso379535b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714000468; x=1714605268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aunCHk/+21TGD3cC0MnOgjQi+s2AopaplDfw/uAJlwA=;
        b=JqJZdzQbSohu/89dhfXhTNj7gs5YdC8wjHzTqDNLdfrVgq3nyoMLWophfN5m2Bkp9U
         qK9/KC04TqYLYDnGkeyzNGUlOEDGzPrgJt4ShPN+lOZ0d06FVXMAGVAmiGvOa2D7QgIU
         X7Z0pe3Hsa746LArh/yCisnoDMFc4vTFPMM4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714000468; x=1714605268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aunCHk/+21TGD3cC0MnOgjQi+s2AopaplDfw/uAJlwA=;
        b=vnd9hFO0OZP/aZOSe13pBn/V+Waf3On1uyxjC5x6Nl8IPf0rFSA/riBV3Y7uLAweXd
         5vvDfOEMP++Co8j5JBhkdNuyaUdaUTveUOXOSCCEgygKErralhV9POsF4nkN6Z10in9s
         3g60NubfHiFwgwHyeUFAollq6Ueasq7iF3kg2aHpjG9qssiTtFT6WJJhZQHTv9XYlYJU
         SWuVwoUSxL4n2qDI2TVkqF2bZZ9h7exZTxRK1Qi7Sun3Li6yjtXSWqFUoSAMLGA0N7VG
         6FANOA22xM9ypV4O7eZGLdvqAAn4sm+LOfPMC3c2xniSaxmA5b+T+KHz6msfFEoZl5x/
         RuOQ==
X-Gm-Message-State: AOJu0Ywjz4F6xo6izpkyy7wZMpZCv5v/6t8OKNSRbUF1j1D3NKKr2guY
	taGtNNIq3Xv7cpiTxr0f4W1HMnIB7IK7eTtjOwF5f0Zz2X9BKMfwC6s6N6EQ4iM7E914W2w3PW3
	EfKUzJNh89ycuzRT/8YJLxmnDmQkroMX928AIhpqbJ3DzpZ99nT9S0FeuwMg36IlvyV3VSvgUCy
	e1EKN5fUCJGa09bHx1fRWQW3X0OMA6U4+/a01bglWlZl0JQVkZIXeN
X-Google-Smtp-Source: AGHT+IHHdzGAXQ8gL0olZCSpi68pN5CG8/dpakkeGHeT/XAiJRJCeztoRovHlbGUOJO8Jirtf9fuow==
X-Received: by 2002:a05:6a20:9c8f:b0:1a9:8836:ae37 with SMTP id mj15-20020a056a209c8f00b001a98836ae37mr4530009pzb.12.1714000467703;
        Wed, 24 Apr 2024 16:14:27 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([64.186.27.43])
        by smtp.gmail.com with ESMTPSA id n17-20020a170903111100b001e520495f51sm12383936plh.124.2024.04.24.16.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:14:27 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v9 1/8] x86/vmware: Correct macro names
Date: Wed, 24 Apr 2024 16:14:06 -0700
Message-Id: <20240424231407.14098-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <adcbfb9a-a4e1-4a32-b786-6c204d941e9f@broadcom.com>
References: <adcbfb9a-a4e1-4a32-b786-6c204d941e9f@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VCPU_RESERVED and LEGACY_X2APIC are not VMware hypercall commands.
These are bits in return value of VMWARE_CMD_GETVCPU_INFO command.
Change VMWARE_CMD_ prefix to GETVCPU_INFO_ one. And move bit-shift
operation to the macro body.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 11f83d07925e..f58c8d669bd3 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -49,10 +49,11 @@
 #define VMWARE_CMD_GETVERSION    10
 #define VMWARE_CMD_GETHZ         45
 #define VMWARE_CMD_GETVCPU_INFO  68
-#define VMWARE_CMD_LEGACY_X2APIC  3
-#define VMWARE_CMD_VCPU_RESERVED 31
 #define VMWARE_CMD_STEALCLOCK    91
 
+#define GETVCPU_INFO_LEGACY_X2APIC           BIT(3)
+#define GETVCPU_INFO_VCPU_RESERVED           BIT(31)
+
 #define STEALCLOCK_NOT_AVAILABLE (-1)
 #define STEALCLOCK_DISABLED        0
 #define STEALCLOCK_ENABLED         1
@@ -476,8 +477,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
-	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
-		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
+	return !(eax & GETVCPU_INFO_VCPU_RESERVED) &&
+		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-- 
2.39.0


