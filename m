Return-Path: <linux-kernel+bounces-93584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AE9873210
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F4E1F21E14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5695FB88;
	Wed,  6 Mar 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SO7DT2+X"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD815FB82
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715401; cv=none; b=c05KAFzuyzsllcmMZFynhZRnreB49uU2KTtEju6m4YRMaA8Qm/0/i5EqfubzyHaIShvOGd+RF6nKQW8EK0xQL57kRJmfOKzJXTl4Uz/N3Ev/m8tVuCTwAq4Ms2ZgG0S993OlqhWimH08s0eLErzn2VH4HuxRyWgQ/hr2+z47FFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715401; c=relaxed/simple;
	bh=ALSPsCpVA0CNK2wGtP8VKCF7ZyFy6s/GtdM0fjyQOjM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=bAxTudJqEruoHLGQADCZl8meORppE4BmPqZS2ysXwHRJbwcb19LYrLCrSkpN4dqyrRSN4kkX6Zd1xIsdXBBSzswOYGik1R+ePW0cHShQYjEnmLqSAMtIrqh419ae/lC9fBNnlphC3MQgX4qKHNKbDYoxtbGLubUELhCJEuMSD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SO7DT2+X; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e56787e691so465647b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709715398; x=1710320198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=miJgmmft5IPBYmaXSyen84BtDBnhdyu7bBvtRv7/vGE=;
        b=SO7DT2+XR1Z4OLsN6CO25OwBa9XsaFkp7GP2lSemHoJuYgPyp4JLPBLuXky1AEsR6G
         qPFkCZlsPtANynBTpWZbfM2S3FHfS0KFlU0TdY0POs907lM4gizQeIA3+Mmo+0/c9NJj
         3xq+aS03liXzgMe+rEOUuufNOvGmOtqvkASbUaTm+GQ66S2GjQ4QhKN7oOCkZX0ddi/v
         7tZU5tC0Q384JKC22tsiCy8OVg8s74Pt9ZyVd81BR+rnO+ORAUWasnxqkeylKFaGZmvq
         pUlrPAdHIt9b/vzIlzftBqwPF/RmOmN1E0n3Sa7Eq4JHI6PlnSVkMU0WJyfLxNkSqAhq
         uwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709715398; x=1710320198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miJgmmft5IPBYmaXSyen84BtDBnhdyu7bBvtRv7/vGE=;
        b=CEZZmyNt9AZ85I8NfFtr04F7TY9OsqlSpxw5x7pSIGXeZzrsmyTfOJ++PLfkJm2c0P
         tF6IPn0vQzYgjyEDcv52LBt7uHz99BCpvCVFNsEcm/AHaiVc7C1SBVgPOZICo+OeA4OJ
         tyvQWqvI/+O8ZAA/hXhlSU35yFMJsO6IOu4XxLPKNfCnRdapO+6V/lGdBzbd9awqMFmZ
         7W203Fxx5QrO5d7XP+YiwG+OSpfLi09Gxg0KfIDz5X6yw++Ddt+2fZ6xlkVovARC/Re3
         oZYoy2hq7W/Jqzc5oFcokxlu/HEk1EqGmwZLPxOlH47IYv4GqNA/Gc6WEz3lkIWzhhZ4
         AD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9BQj5+xWADlBNEohhGPTXnOigvS9BMGeo6oHw7LnBFg0K4AaEm61DY+IzFfSUuEvNw/Fcy0l0r9/a5wNJAlyniIfWiD602qrR86NR
X-Gm-Message-State: AOJu0Yw4vo0B5dpia8nTAaUWtwBNqnfLvX81Dno1XZz+MNh306C9Dr7v
	fqJDz7smt2ypOqf+7tuD5ejYccq5nMkga2v/M5VH9m39LQDghPZWjHtRRFaIwlg=
X-Google-Smtp-Source: AGHT+IHSPWMWnSqJ94igWDFx0dxlS6jl64WPFzIgP3y43hLTZHJR/pVyi5tFhE8JE9eK2c3TtONwHQ==
X-Received: by 2002:a05:6a20:1442:b0:1a0:eb43:421b with SMTP id a2-20020a056a20144200b001a0eb43421bmr5447236pzi.28.1709715397698;
        Wed, 06 Mar 2024 00:56:37 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id o74-20020a62cd4d000000b006e58663dd0asm10740071pfg.110.2024.03.06.00.56.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Mar 2024 00:56:37 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	cuiyunhui@bytedance.com,
	xuzhipeng.1973@bytedance.com,
	alexghiti@rivosinc.com,
	samitolvanen@google.com,
	bp@alien8.de,
	xiao.w.wang@intel.com,
	jan.kiszka@siemens.com,
	kirill.shutemov@linux.intel.com,
	nathan@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 1/3] Revert "riscv/efistub: Ensure GP-relative addressing is not used"
Date: Wed,  6 Mar 2024 16:56:20 +0800
Message-Id: <20240306085622.87248-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 31eb1e287ce1..475f37796779 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
 				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
-cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax
+cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE
 cflags-$(CONFIG_LOONGARCH)	+= -fpie
 
 cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
-- 
2.20.1


