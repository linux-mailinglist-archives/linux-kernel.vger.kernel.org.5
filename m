Return-Path: <linux-kernel+bounces-119923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C9088CEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2C61F35D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0559E811F9;
	Tue, 26 Mar 2024 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pTMXWuGX"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981E5D465
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485025; cv=none; b=cdKLDQ+cj022OR8d3rfzDON4rJ1nsf86abzQKI23VZE01NnhruTWNn9nDubfGeZy1RCWC8q3djkTT1juu57OhjIE8qnFO7yg98GP6bxwIiyz0Kxpkl3nPesmwFJjjCjQs2Qb0FkBABNyoPxgtV+WLtl7b0nsrWtPY91yuU4nTpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485025; c=relaxed/simple;
	bh=1MIaNHF3ZPeWhpxgDesdwjpOmbC5x5fvawY27Hi/YKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Za/Af1nxH9Kj4M+UVXQWmQbQrpyz0TiNC8YKr2jBqbZO1Q0bYMQe4RWUtiQjW4T4IZEoBEegjDxd5p6juwYXOHzvvZwdMYuMXMwW4WBJj5BnCtgoqN+uW5blfSxMXQIZLkzQB+H650XMlRMzulKOJLhBgKJsvjQNBCtcXQnm4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pTMXWuGX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7705610a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711485021; x=1712089821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nOTCu2adkZyU4SASR+8mux3MN1uFKsv8RRVIr1/qVQg=;
        b=pTMXWuGXT8XIqWUy2nNVMoK3jALZ9b5sn/NoqDMzZAp6W8gnNbm9amcjFLEWJ56JuN
         cRtCvCtBlAr94K3sa75dFBqbP7GEYysKp+3CDIzEOi0AE5uP+RbnV1cm0P2Nmr54tJgs
         m4oi7iPaWqIBFeSG06y2vTcr8RhpsvcjduNCeJef4as5za+0bzzcs/xQ5VBD4vIp7JwN
         /4KnGBJWFCoLs90HvF3waJ0EtnVzuZraphi2B0nN+W0Cc4sZBE4dxUF4lfAxJyaRTSlG
         H/+dTHty2k7EBK9ESIlmW4MKgSWXqc2BDJghxDlyOiaBvGeJp00nZzNK6mubkjYdBD+2
         4SWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485021; x=1712089821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOTCu2adkZyU4SASR+8mux3MN1uFKsv8RRVIr1/qVQg=;
        b=WWL7bnnnWK6fF14wltJ86Xhz3KQcFVzrlnztfquQ0YBfdqkS8CqbuopLs/iiAAIY/1
         f7mhvxyIlSKthyrY8W2BV6Gi3rAcHUcM9RwnQpC9R0Ja3lIDpZ+AFDip2FSuw0PseZZD
         2FWYTc5tEiRCqFCgvZ6vyiIRSqQWFJfDUPrtuBC2i7dqLclyvDTX6/XjZEXtQO8g3yYK
         bivu4wjFsiAs+xlPg0kbl9wJMXziRIRlP6nr9DNkfharmnTcP8bhH7IZIHj9INautlW6
         vSxZV96c/Sf9Es4ywKK8yMwsjUBfdOIxbNK7XsaN3aB1MExbBiBfu4QBjtnHBHTcYn7K
         iEyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU462TVDkPmJiZVDsU4CXRjo2ubTbf7qmL6dKd7WP+Zyml9I9XWFSYIj8izz1qQ/fsCuxGgFxip1yQ2vPGolO4eVLyuMQx/3IUgUG00
X-Gm-Message-State: AOJu0YyK4kQzlpuZBUWLevdJfxHcrcvhSjDJnWhSK/BZvu7MBOT88y8P
	rgCksvxaEA6P9lGfNNr71P76Kom1hG0Na97Hg9KPajBe2Xm8o7Qad1oBFu+2AwA=
X-Google-Smtp-Source: AGHT+IGDCCJfg1K3FXIiSSOOGO99uhfcCCRDK5S7YUKDQOK6yXvBo4CUydKRMP0dyp1U6ZRkE8pBPg==
X-Received: by 2002:aa7:c48a:0:b0:56c:6cb:e7ad with SMTP id m10-20020aa7c48a000000b0056c06cbe7admr7158412edq.9.1711485021311;
        Tue, 26 Mar 2024 13:30:21 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2a02:8440:5240:d2b3:9657:7432:d88d:84a9])
        by smtp.gmail.com with ESMTPSA id ij5-20020a056402158500b0056c09fda4e6sm3097694edb.54.2024.03.26.13.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:30:20 -0700 (PDT)
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
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/2] ftrace fixes
Date: Tue, 26 Mar 2024 21:30:15 +0100
Message-Id: <20240326203017.310422-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both were reported recently as there are efforts ongoing to
reimplement ftrace on riscv and both are independent of this rework,
so here they are.

Alexandre Ghiti (2):
  riscv: Fix warning by declaring arch_cpu_idle() as noinstr
  riscv: Disable preemption when using patch_map()

 arch/riscv/kernel/patch.c   | 8 ++++++++
 arch/riscv/kernel/process.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.39.2


