Return-Path: <linux-kernel+bounces-32181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EF58357BC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8B41C20FDC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C138DDA;
	Sun, 21 Jan 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7v1UH+8"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EFCFC18
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705869028; cv=none; b=NGrCrGf1/FT7HHJJlJeLb8c4oEA863MN861Pc5p0CdGj2GEEmPSmb9EkH0kWtzm0AGcURRODwqFmJCJmeKEdVNz4+59Vbch7NeCf4AdDOe6pihJoIrDP4JUn3Q7Y3zR0REPdVpH5Dbrss//or5EKXDRQA60KSRoV8P58i5bgTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705869028; c=relaxed/simple;
	bh=lbVolXL2jsv30CBjCftFHgTQeUGMCTKUmhycYf9fn8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYmmNjRx8sp81W0f1B2CKZqUvYMOaviVJ692GY1/2o2XZFuxXrfqk4keRdp3iyw8UuaiYe7Zxn0RPr0SYTZWm9uHVTeAXI1ZsGnB9cWOvR+5KPdDNzjaQr0bmkUoyUzLtR5UVMDPHLVUvNN0nW5fL8S7bDcqYdd77Fsyu0KRRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7v1UH+8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e779f030aso14472795e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 12:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705869024; x=1706473824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFOh+wFZ3gZL48mISx80VE5NCNzEFuaISyyYFrZmaso=;
        b=H7v1UH+8yJxlhZ4Amnb4qsTiceyE3SzGdVj0c43swB6HtcccS0LJdN2OyRCw8sjWvO
         RhUITNdim3zLivrQ7H0EcOJTOoVswqYZ/ZlkhPWRt3ncP+GJe8quY4b5Q6msvrK9JzLy
         L3uddwoEluJ0NknDGPnNRmL1vzjmLpXEBi4FiZygcZZUkq+X5SlTCRIP1Ffr5HjJMrjG
         CRy9jPvAqByJUqsISes7D29/W/qSgVr/P2xfEeQhjPXLctDitO9Kp0WFAV5rC8BZVTVq
         Hbn9ZJnVH71j0XbzSHWi1Dmm/rnHDjBKzu73twODD4yjgIeVa0VLJYwPmAyxHM3GM6Nd
         TVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705869024; x=1706473824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFOh+wFZ3gZL48mISx80VE5NCNzEFuaISyyYFrZmaso=;
        b=dt31KLeUILApw0McP9gCcGX2VaFFMu5bUQxm3NrhoDYelzTeDmM2mHs6DJhpdVn4Iu
         y6vyfDogrZgevxM5s+YVirpM+9mMuBe83vdd6L4yqC4SEgr5T+3haLeJL0BieWmoxjee
         MYDEVnB+bDsAn8D2NU4vXKtwuNvIsVsvTrgnRy5n1f69mTnu+v4szEKyKewVMLVLIRtr
         zO1CsDnu+rhFA333BzP7Eq/szlUU4a3+bDlBOUoVKrvJDE1mXh63pB3haeq0d5v1rFz2
         uO+quAA5VZScVWC1lT9kAQkavTMPuqiIK9BHp8VLNr1i+JOkf0uOXh08xx2wPQ4brQ4g
         5/WA==
X-Gm-Message-State: AOJu0Yw91kYvT4QZFOD0WPGKJ5N3Lu+XhRgFuYubPXWAALQZGzrFrxGN
	xXMvzOkYXUZXP9ElrbO7z5UUnLQjG5/2tV3fPPH4v84ptdVkTQR3
X-Google-Smtp-Source: AGHT+IGa17ieGCLLHAfKtw0851dG8rPii45/t1n8te6xVLjBjl/hUzn13sgCBWZnrl1l/bWLAvPPLw==
X-Received: by 2002:a05:600c:a06:b0:40e:44bd:dc39 with SMTP id z6-20020a05600c0a0600b0040e44bddc39mr1314341wmp.84.1705869024443;
        Sun, 21 Jan 2024 12:30:24 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j5-20020a05600c1c0500b0040e9f7dadc6sm9021967wms.25.2024.01.21.12.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 12:30:24 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	John Crispin <john@phrozen.org>
Subject: [PATCH v2 1/2] ARM: decompressor: support memory start validation for appended DTB
Date: Sun, 21 Jan 2024 21:29:33 +0100
Message-ID: <20240121203009.9257-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240121203009.9257-1-ansuelsmth@gmail.com>
References: <20240121203009.9257-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is currently a problem with a very specific sets of kernel config
and AUTO_ZRELADDR.

For the most common case AUTO_ZRELADDR check the PC register and
calculate the start of the physical memory. Then fdt_check_mem_start is
called to make sure the detected value makes sense by comparing it with
what is present in DTB in the memory nodes and if additional fixup are
required with the use of linux,usable-memory-range in the chosen node to
hardcode usable memory range in case some reserved space needs to be
addressed. With the help of this function the right address is
calculated and the kernel correctly decompress and loads.

Things starts to become problematic when in the mix,
CONFIG_ARM_APPENDED_DTB is used. This is a particular kernel config is
used when legacy systems doesn't support passing a DTB directly and a
DTB is appended at the end of the image.

In such case, fdt_check_mem_start is skipped in AUTO_ZRELADDR iteration
as the appended DTB can be augumented later with ATAGS passed from the
bootloader (if CONFIG_ARM_ATAG_DTB_COMPAT is enabled).

The main problem and what this patch address is the fact that
fdt_check_mem_start is never called later when the appended DTB is
augumented, hence any fixup and validation is not done making AUTO_ZRELADDR
detection inconsistent and most of the time wrong.

Add support in head.S for this by checking if AUTO_ZRELADDR is enabled
and calling fdt_check_mem_start with the appended DTB and the augumented
values permitting legacy device to provide info in DTB instead of
disabling AUTO_ZRELADDR and hardcoding the physical address offsets.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/compressed/head.S | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 9f406e9c0ea6..2ff38a8df1f0 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -443,6 +443,28 @@ restart:	adr	r0, LC1
 		add	r6, r6, r5
 		add	r10, r10, r5
 		add	sp, sp, r5
+
+#ifdef CONFIG_AUTO_ZRELADDR
+		/*
+		 * Validate calculated start of physical memory with appended DTB.
+		 * In the first iteration for physical memory start calculation,
+		 * we skipped validating it as it could have been augumented by
+		 * ATAGs stored at an offset from the same start of physical memory.
+		 *
+		 * We now have parsed them and augumented the appended DTB if asked
+		 * so we can finally validate the start of physical memory.
+		 *
+		 * This is needed to apply additional fixup with
+		 * linux,usable-memory-range or to make sure AUTO_ZRELADDR detected
+		 * the correct value.
+		 */
+		sub	r0, r4, #TEXT_OFFSET	@ revert to base address
+		mov	r1, r8			@ use appended DTB
+		bl	fdt_check_mem_start
+
+		/* Determine final kernel image address. */
+		add	r4, r0, #TEXT_OFFSET
+#endif
 dtb_check_done:
 #endif
 
-- 
2.43.0


