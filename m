Return-Path: <linux-kernel+bounces-31539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 096BA832FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F8FFB23F54
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056FD58205;
	Fri, 19 Jan 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGRnptxy"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5245788D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695256; cv=none; b=T7v7gqe8kRAQb4lWf6sgFHqUzli++ukOFpC6DFPBz+G/s71eedCEMzEK5CR7cyyXcgRu5YYFhyDjZaPMCUy9cN5p4vF0N1KPQXug87uS36oYoSKP13QumtKu8aagM3A3DK0INy6Etj07R0FhEACdERArktrnydJwHbqDqo3SiLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695256; c=relaxed/simple;
	bh=JxFs1rbHTLTpSL80XNLyDexMpSKcJsmi17aOK7u7oFE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKb4Eo0C+5PKaMWNaqZEQcwK1bx5WqpZHZbQIULixa8KqObXZ4V6ivESKoFVP0feAcVYvq1092YyjeFaUMEmWbd5hKKYBnZSe8zcd1p8UEwrEptwovCPndtMWuPdhxFocBjqEPHyHMSOvcrF1rP2tF4x1vtZqoy5EugeXbGeBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGRnptxy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-336c5b5c163so752976f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695250; x=1706300050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e35XnQv7+JeMDazmnVaku5/bw/ATFIlRQ/6xz7OKU3s=;
        b=OGRnptxynB6Mq+fBHTGbLaSOoyClsV9w28SPGfSqge01kSuQSJ3GZjTd6ejp+mq0G/
         LVXeLKeli4gvJ3H+TyrUM3/WtGz1oFKlOtICHiGVbvOiYtaccEhy+3OOrE6NeBmDFPKF
         o4vZ/4sZZ/srp/K9d7oqq9FssrKfhiQqNYBA3sr8RHOv5ZA2bRKmDcBMMeOWgfT/BkIB
         dIToUe/M9ocnJpnov9qYux0J9LnACZl9dTpVIoVlag0elTTL/6z4ZEzBX5BBFyx2JPxL
         zuehgd1CuyMTW8neMGUlUZ9Z1katciZCdYNVNSfmckJFIMt9cKw8xaE0ZIjBIkT7CS/C
         cjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695250; x=1706300050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e35XnQv7+JeMDazmnVaku5/bw/ATFIlRQ/6xz7OKU3s=;
        b=qIGVCO72rRtTcoSwHrhU5CjbmkTc4LgxDCY373GvYgtWEfwyF27HD/UwtWIrQ0LM7C
         hoGkBktlFoJP7VkI1fUja9F1ZhOscSZxpXL1WYG5wWYeiLnM7iZPxCV+A1b1QrAYRQ2W
         EJZzI+7S0eOOG1BunZqLi9P+6wVnkeJJfMNr3DS42pwQu/s1/IiKEoY+7jdu37MBY/05
         PmiACE9xmv3etEFGkXX845c4i+cqCShbqWATVhbDxjywieNPiYGjBeCc+F67hTPDZPo/
         5IvWLhuTUdS3OxoYEm27a3IUkY6SQ6qRJeHSERjWeVgnsgYA9qxnuzDRCIBifk0feSIb
         yrJw==
X-Gm-Message-State: AOJu0Yx5IxaQaxcYzqL2HIUI7i8XmJk7aTgL0hhhHOMBiRzsV9cZ0uft
	d/KnukGVUZqV697uShWHtaNIQRo9n5rnNKFu+TQ/7Vq8aAtifKQe
X-Google-Smtp-Source: AGHT+IFwN1VEXA51pQLlXmt/K6R/WGzdCtBOcilbAPksqwEOjCe5BbskxHNB7jfp5oXi4o+U0z8Wrw==
X-Received: by 2002:adf:fdcd:0:b0:337:d85d:87f2 with SMTP id i13-20020adffdcd000000b00337d85d87f2mr977177wrs.8.1705695249639;
        Fri, 19 Jan 2024 12:14:09 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm2084788wro.85.2024.01.19.12.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:14:09 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	John Crispin <john@phrozen.org>
Subject: [PATCH 1/2] ARM: decompressor: support memory start validation for appended DTB
Date: Fri, 19 Jan 2024 21:12:44 +0100
Message-ID: <20240119201356.7903-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119201356.7903-1-ansuelsmth@gmail.com>
References: <20240119201356.7903-1-ansuelsmth@gmail.com>
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
+		 * ATAGS stored at an offset from the same start of physical memory.
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


