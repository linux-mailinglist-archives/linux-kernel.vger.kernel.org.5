Return-Path: <linux-kernel+bounces-119928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6631588CF08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964591C38228
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910631411EF;
	Tue, 26 Mar 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JNBev4Xm"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E916613D89B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485161; cv=none; b=fB3H2DpCrdC/UtxGEBSXZqry0L27hJwOYfGw6kKYN3RijiXRVueKTjZpPjro9U0caULOhwKX3JqqLaoTs2jXFbsZ5q+WwOLDfPVu0zIMEhTdIsh5HQfi/7pWKWPlWtXf41Y+Zuk3Jn/JLpQzURsHo6QhxA2nEBFoFCKGjq4w668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485161; c=relaxed/simple;
	bh=o7Ismljs5kdN2ZKFTdylXCiqx/6WCg6NzZXI5LKLDRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFCUEAJCRjP4B0KOdvv3jheKX4z8W38tstd/o2drroJ8D9BMeHh2n3oQnvifJpCRhlCZSVtroKtA4I2tOK8Rf2kSVltUB27iohGzePusWJmOVcbXjDJ35tP8C4/m7JgkKJHx0aXbv3kdozf4mkxaj7uNls7F9Kdts1X4ZZcOV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JNBev4Xm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c08d1e900so3613162a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711485158; x=1712089958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwoTWlECTszcl/qxdYVc4t6fpZ8kE/2UkB07bRVsSm8=;
        b=JNBev4XmZ1jX89eLFA8IH8Qx/7zzIWPRuKXmPiwdvyPBC740K33WRPXxGATQ4cAGmI
         KvjPIDfVRkxEInMFuyxEAEwKy88H9f0Fz/e3DtfBb93gP9X/7AOT3Qf8rlz4B6v0BSFv
         xbUwhyIejk6HUuZXCOQ0+yoKU6qf3K26BYhxeoOm8uN9G1ulsbkl0qUEkR3GCRWBW/VA
         uX1ded1yHJFw9tCU5SPYZSNs40c7+oGyzbpWcV+a8SdNwDEfhZvdRdfO8B1IBQhG8kZm
         Kundqe0q96nDNa2oMJS9JI1QAcDCzVmgpyfKan0+rJlSSrIIoC7TWj3M2TNNl5Ei/mRj
         DCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485158; x=1712089958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwoTWlECTszcl/qxdYVc4t6fpZ8kE/2UkB07bRVsSm8=;
        b=sQ04GDsuZlyPRkViJhHzus9OhFMXolQR8ZELyAmJxIOqhO7KvCF5TRfmiztM4bt7Lx
         qdtiqCE8FDn2NxZvVYWLwdLq35q0IHXutmE7zaYj6xhABp5COsTuC8NaxtVRKggBQCc2
         whogmFPkUe8Mpsx2eJAAbWI9tmj55RaUYdpueHk+ll7ZeQCx+ap8zVNExKynm9HgTqGW
         bRBgd6OH7Q3C43V6fz6YDkakF10z1s5HWOtloQeWaPAEEk9XQAu0qn2I7QKMM7cpktSa
         n49XAxbQpM65/CVXn1qYf7yVqoVLUdUbsl7Asxjihv0NFDVCgbKRneMk/5c6FX2IfBHd
         d+kA==
X-Forwarded-Encrypted: i=1; AJvYcCUxiw2To2NsLMHmN7Btk3uDEiEzMIXliHDn8Hg2oomh1jrWOYgm9hYAzQWVMuzHlI6mE24Bxv+aan+cYEhqdZ0V7W00v3L5wvniXomp
X-Gm-Message-State: AOJu0YxiB4TSnn5BmP6iH1olRlscnXAkIrO7is9kK23P8pYWsE5R8EV3
	96hlKO/2oDDKu7K3JVDnmRXlEBYbdmqJ0Fm0xpqKpCnSZjLMd/KmR7I0e3/iqMY=
X-Google-Smtp-Source: AGHT+IENt7YBLnNtoUOQOQp272wkaUn+XI5a9KNpsaZCh2RNyyuvnhB+Bx/GceA3IeXjeVnoNmMyRA==
X-Received: by 2002:a50:8e12:0:b0:565:bb25:bb7a with SMTP id 18-20020a508e12000000b00565bb25bb7amr3175538edw.24.1711485157973;
        Tue, 26 Mar 2024 13:32:37 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2a02:8440:5240:d2b3:9657:7432:d88d:84a9])
        by smtp.gmail.com with ESMTPSA id da12-20020a056402176c00b0056b816e253esm4525782edb.13.2024.03.26.13.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:32:37 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Zong Li <zong.li@sifive.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrea Parri <andrea@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH 2/2] riscv: Disable preemption when using patch_map()
Date: Tue, 26 Mar 2024 21:30:17 +0100
Message-Id: <20240326203017.310422-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326203017.310422-1-alexghiti@rivosinc.com>
References: <20240326203017.310422-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

patch_map() uses fixmap mappings to circumvent the non-writability of
the kernel text mapping.

The __set_fixmap() function only flushes the current cpu tlb, it does
not emit an IPI so we must make sure that while we use a fixmap mapping,
the current task is not migrated on another cpu which could miss the
newly introduced fixmap mapping.

So in order to avoid any task migration, disable the preemption.

Reported-by: Andrea Parri <andrea@rivosinc.com>
Closes: https://lore.kernel.org/all/ZcS+GAaM25LXsBOl@andrea/
Reported-by: Andy Chiu <andy.chiu@sifive.com>
Closes: https://lore.kernel.org/linux-riscv/CABgGipUMz3Sffu-CkmeUB1dKVwVQ73+7=sgC45-m0AE9RCjOZg@mail.gmail.com/
Fixes: cad539baa48f ("riscv: implement a memset like function for text")
Fixes: 0ff7c3b33127 ("riscv: Use text_mutex instead of patch_lock")
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/patch.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 37e87fdcf6a0..30e12b310cab 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -80,6 +80,8 @@ static int __patch_insn_set(void *addr, u8 c, size_t len)
 	 */
 	lockdep_assert_held(&text_mutex);
 
+	preempt_disable();
+
 	if (across_pages)
 		patch_map(addr + PAGE_SIZE, FIX_TEXT_POKE1);
 
@@ -92,6 +94,8 @@ static int __patch_insn_set(void *addr, u8 c, size_t len)
 	if (across_pages)
 		patch_unmap(FIX_TEXT_POKE1);
 
+	preempt_enable();
+
 	return 0;
 }
 NOKPROBE_SYMBOL(__patch_insn_set);
@@ -122,6 +126,8 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
 	if (!riscv_patch_in_stop_machine)
 		lockdep_assert_held(&text_mutex);
 
+	preempt_disable();
+
 	if (across_pages)
 		patch_map(addr + PAGE_SIZE, FIX_TEXT_POKE1);
 
@@ -134,6 +140,8 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
 	if (across_pages)
 		patch_unmap(FIX_TEXT_POKE1);
 
+	preempt_enable();
+
 	return ret;
 }
 NOKPROBE_SYMBOL(__patch_insn_write);
-- 
2.39.2


