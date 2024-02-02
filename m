Return-Path: <linux-kernel+bounces-50732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F20847D65
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB69F1F26045
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BAB12D742;
	Fri,  2 Feb 2024 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bW3IiDqn"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA912C80A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918097; cv=none; b=ZPxTCnXKb5XLZuMDFwdtbB9AveY+k70pSZOkYoBjF0cjPlZ4hB7Z2VLdgKBKunhvJyxXOnWWrjU+iHtge1Y1kAnyECfn5ixzlCo9G4GGu3FsDk+GJRbd5qYfePn6hdYClFaDOYv+EteVKqw+dnEVVSU0tpQ2xtEQfDe0IfodQbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918097; c=relaxed/simple;
	bh=0xbrQ7dU8s/DO/vYKW8uWrhcAt8ul7TZYujjtbD0uls=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=puNZmUEKWAduTIqD9HiQGyx/ostVmb4iDnjIXmXCkJUYc3awwyv4iK1ZdzZpBdDCGfNm0TP6l1wivlu1i8bYHsTivv2ejNjDuQ1tToh5X6bpQTY+1RK39K+/8vxZzdZluAejq4k83lOeuOvF+up6faMBNCNW5Bx21BZR6Ai9Cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bW3IiDqn; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1955329a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706918094; x=1707522894; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cB2tFVOKVxTeJSZexMtqa/UnSmD6oQiVHBBq312ozek=;
        b=bW3IiDqnC2QkigMfYe3QHXBhLMg0oqTE4eJnUQ2lY1nqbFc69VOOKJ43Fi9QD2NoBL
         R/CbETgWevzrI3MwWlnMcD69mxDs2+XMYYZXsYxn5n5jjFu1TLxLjeN261uEtGUt9cOv
         QqpAbDBbz9JAjA7ElywZdLAO0s73kYsIq1MABh+b1qoaPlIlEQN6MubBYUQOb+F0KT3B
         XKceiteZ1YOajy68GKwiebT+ES3XAfYYdwDWiYtf3kWmH3IjVGKkELilVPZz+G4rCinc
         EoIcFANyL1sttCCn2Vo//tyCJyhigv21jFoaPsVFhpLIOKKRG10Pct++muZxCwsJeI8h
         Cq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706918094; x=1707522894;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cB2tFVOKVxTeJSZexMtqa/UnSmD6oQiVHBBq312ozek=;
        b=gWakv875LDf3/cV+P6+tlrk/UuQwJPOse5nxCld6Zq74oRjiETsyhTr5+oCQ5gdW2F
         y4ZEJ1O5LR7wQi3wDyYbbCOfZ+6yzOt0sTo8SXi6ZBxHdbgn2IpnFw/gzrT8hlPXSeV9
         cOqU4VLZnVy205QHbf3372Oq/AqKeb0z+mYXj+NQxRib+Eu+/MvhE5UQd8KLG/T5wWcm
         kQaB5Ma6ThyXtKHfeiISVaqEp8rxFHAxH+F/SC+8HtJ7hQFomPyPu8g7ypDk92uQWar6
         bF3j4AAeXqB9InSiUfXiK9GePKLM50/yJZVqoQ5XmTKmVjVE3XneVluwuXLLIkxddmtR
         MTvA==
X-Gm-Message-State: AOJu0YxruotJvHfmRAIfITkdPOm65vqbqtA+lDRWwKLBS6m4DZR1pm/K
	OnExouBuyIGYoXhIdSHPGpT2lNBLbrRTuQVv2L+dKgBj4R5iMrnQwbty9p9sWAY=
X-Google-Smtp-Source: AGHT+IGLgtA3E1LDzO/LZZVS/RWVQ5xYoH2SpNXNrhjNq/+CgtvwgDQ697+VSVKAlRlVIbFY+Vk/yQ==
X-Received: by 2002:a17:902:c94b:b0:1d9:8e37:56d6 with SMTP id i11-20020a170902c94b00b001d98e3756d6mr24686pla.40.1706918094688;
        Fri, 02 Feb 2024 15:54:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU3+EXKr5vkEi7B65f4rJCfn25LtJsju5OTbujLL6Rhwkf+mo7rwdkg1Ls1605PbAxDFmTUgI7ejfFUQmsTgmuMmEFv8nHSXPkKNm3RhsonISnHEDY44ly/WL1z1cU4GNhcVUumBjw60ORNwpyI3uCmmN595/Xsz1x2aUbxM5LGWrI5qJUwDF1hDQkLL+DSZmiWhY+/AkyYsdHtcpdTlkZRmG70LEF4DyHAsbmFl4GR4ITnC6hTkA9niYdVFXdo1kPTekPLKyRpyqu7l8ZjTQ2CJmp9GpMljk457CbyKLoa/3EbUpsP/LC+5TSSXj5PycstgBk67FOFUg==
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090282c100b001d8f81ece98sm2133607plz.104.2024.02.02.15.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 15:54:54 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 0/2] riscv: Use CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 to set misaligned access speed
Date: Fri, 02 Feb 2024 15:54:51 -0800
Message-Id: <20240202-disable_misaligned_probe_config-v3-0-c44f91f03bb6@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMuAvWUC/43NywqDMBCF4VeRrJuSi1btqu9RiuQy6oBNJCmhR
 Xz3RjeFrlwN/yy+s5AIASGSa7GQAAkjepdDngpiRuUGoGhzE8FEybjk1GJUeoLume+EgwPbzcF
 r6Ix3PQ6UlVKBknXVt5JkZQ7Q43tfuD9yjxhfPnz2wcS373E7ccpo21heVdAaq5pbwOQjOnM2/
 kk2PokfKdgBUmSyro28NBpsrcUfua7rF4l32skkAQAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706918093; l=1713;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=0xbrQ7dU8s/DO/vYKW8uWrhcAt8ul7TZYujjtbD0uls=;
 b=v0l5aXNQvH2VsUmoq5qlzgcz8zo1xqLL0XudiHNz3LWPiY/mYq5kNEs5OS90//u5rt+ErwxlJ
 uVUSfjHU6nlBta8MlZuIaHGIbcEIYEDq50ZRWcPdyboL3LNnhgiEQBr
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is enabled, no time needs to
be spent in the misaligned access speed probe. Disable the probe in this
case and set respective uses to "fast" misaligned accesses. On riscv,
this config is selected if RISCV_EFFICIENT_UNALIGNED_ACCESS is selected,
which is dependent on NONPORTABLE.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v3:
- Revert change to csum (Eric)
- Change ifndefs for ifdefs (Eric)
- Change config in Makefile (Elliot/Eric)
- Link to v2: https://lore.kernel.org/r/20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com

Changes in v2:
- Move around definitions to reduce ifdefs (Clément)
- Make RISCV_MISALIGNED depend on !HAVE_EFFICIENT_UNALIGNED_ACCESS
  (Clément)
- Link to v1: https://lore.kernel.org/r/20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com

---
Charlie Jenkins (2):
      riscv: lib: Introduce has_fast_misaligned_access function
      riscv: Disable misaligned access probe when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS

 arch/riscv/Kconfig                          |   1 +
 arch/riscv/include/asm/cpufeature.h         |  22 ++-
 arch/riscv/kernel/Makefile                  |   3 +
 arch/riscv/kernel/cpufeature.c              | 255 --------------------------
 arch/riscv/kernel/misaligned_access_speed.c | 265 ++++++++++++++++++++++++++++
 arch/riscv/kernel/sys_hwprobe.c             |   4 +
 arch/riscv/lib/csum.c                       |   7 +-
 7 files changed, 292 insertions(+), 265 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240131-disable_misaligned_probe_config-043aea375f93
-- 
- Charlie


