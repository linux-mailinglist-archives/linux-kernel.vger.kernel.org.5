Return-Path: <linux-kernel+bounces-162548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337108B5D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E021C2082C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47FF130E2C;
	Mon, 29 Apr 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IphIGX5T"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68626130AF5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403209; cv=none; b=TLr9q0HE2b5eNbbvf2MJB+/IFl5qwD1pdiBe82dM/2fdc8LNIqKaX/aoglJinWhKddOGfrGXB+O4kHxChJ+zf0MBMziMcp7vVAonoxr0j1NYVLc3z00yj22NMUkEBxwLmMzkb7rQPVnWP+pKFcW2JLNgBG8Aj6uClGUg4gScX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403209; c=relaxed/simple;
	bh=VBYIkTZIleyOsUo3Vs7GTW09WzwtONhQK0/AstEMTYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N95kuo2S37fBcGXUolO8J/FgqfBEjYDLCBUD1ianN2ab445F+QgnHrHMX9pdfS3l+PqBk9WdXMmuPceDqKff+6XrueAHYTihZbReYgFgAVCUOZ2nSTxrkdO90vMvKuxtPlqfnyyfsbX/zfdQb2eGIL5bycxyBomc308q7lftzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IphIGX5T; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2db239711ebso11563611fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714403205; x=1715008005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdCfPjm06PN8DLWdVlWU7iGB8QhHqS8f5T3HQCXkkpY=;
        b=IphIGX5TTrUC/uFJ8BaxG7n8/RFvEhoIC1BHzQ5cRX4j563R/qMkGlkYwwjNsmKHdR
         MEL7whh8gGX7f4CAYyb3gFqCYoBemsR9mv4s+pbvSCixsCbnCzSkT6t+s782xWmGdyNt
         ggPSWugYJvgoMGISPiGycCiCAEeqk+/dtTVwSoV0OCF4l/jAY5znMGxfAwz/CNKGUky+
         0nC/VgZokiA26hgMhtnccWfHW7gCakVCErZqFKOE55adMQshJrJnHvBt+QLz/XkLjHRK
         GCWde5JnzlfPUiAvxqdhvKZItGRrZCckIrtebNLP5jshkMwhmOvJ6wJU/HnF3RPFVj4t
         f8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403205; x=1715008005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdCfPjm06PN8DLWdVlWU7iGB8QhHqS8f5T3HQCXkkpY=;
        b=AhCmhfAvd+delYuBGr4/LFuFwOtcrLjhDDRsC8S5af3ZwgBpbvrCgngK0swbtoKXpO
         8sno3L/WDCi/yewoIBvmKnvjMAbvvYfgKRkGcG+BdFcJEZkXo55bDvqcX1+fZrtQCGk2
         m9D/HEc2GcufmSl3yqQD+s3oyI8ryg8Kme4wkIeGoMeK056Yj4dA9c7S+mJf1/pFH1La
         zDwZrpKwQxEDgJXrkuGpnfW/EA/vCYR7M0HLiTes5ktc7O2Le6dQFIrCDjv02M6/JbWa
         WDmJDWPfT73nYFUQHuG65PaC7f0sJZXXrOlw+jcvjfQ4PagYBFnLpgiNbovuc4yS0Cbp
         pMAw==
X-Forwarded-Encrypted: i=1; AJvYcCWuYlpHDJbkUo4cemBJHS/HEEQjip9hH3Aa5DZDSAHvSMT9oFX/Sz58H+7R6VooQC5LvUvOvjtjrs5rq0Kuii7fAaVKPBKglVb4jmXe
X-Gm-Message-State: AOJu0YxkmaWUtj1cP1vY7KUN6WQy6IhY3xVeF0GnVb85RUXBlK62Ylv9
	tO3kfhBVZ8xILwcOocD/IZplouuCU5qw+5uLpX9LizBAszo4Qfv2Mz2C12Ze4EY=
X-Google-Smtp-Source: AGHT+IGj1uRjkxG+FV5WjycG0XJI9pmWuDAlxIOwFNFoM4jSpFSFb8mNeeM7/iNLVr5rfQAB/mcNDA==
X-Received: by 2002:a2e:9f46:0:b0:2df:b336:76e6 with SMTP id v6-20020a2e9f46000000b002dfb33676e6mr4355115ljk.5.1714403203714;
        Mon, 29 Apr 2024 08:06:43 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:2fec:d20:2b60:e334])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b00418f99170f2sm39646638wms.32.2024.04.29.08.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:06:42 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 09/11] riscv: hwprobe: export Zcmop ISA extension
Date: Mon, 29 Apr 2024 17:05:02 +0200
Message-ID: <20240429150553.625165-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429150553.625165-1-cleger@rivosinc.com>
References: <20240429150553.625165-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export Zcmop ISA extension through hwprobe.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 4 ++++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index bf96b4e8ba3b..e3187659a077 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -212,6 +212,10 @@ The following keys are defined:
        ("Zcf doesn't exist on RV64 as it contains no instructions") of
        riscv-code-size-reduction.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZCMOP`: The Zcmop May-Be-Operations extension is
+       supported as defined in the RISC-V ISA manual starting from commit
+       c732a4f39a4 ("Zcmop is ratified/1.0").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index dd4ad77faf49..d97ac5436447 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -64,6 +64,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCB		(1ULL << 38)
 #define		RISCV_HWPROBE_EXT_ZCD		(1ULL << 39)
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 40)
+#define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 41)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 2ffa0fe5101e..9457231bd1c0 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -114,6 +114,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZIMOP);
 		EXT_KEY(ZCA);
 		EXT_KEY(ZCB);
+		EXT_KEY(ZCMOP);
 
 		if (has_vector()) {
 			EXT_KEY(ZVBB);
-- 
2.43.0


