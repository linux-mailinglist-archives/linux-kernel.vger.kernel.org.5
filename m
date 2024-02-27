Return-Path: <linux-kernel+bounces-82469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4CE868506
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FAC2B207AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C145468E;
	Tue, 27 Feb 2024 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ga0uldrL"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F181F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994196; cv=none; b=C0gsq+8jWBAC/0goWjjEfhk6mqRtWMeOejM3gnLToU3pogsZBCsedGWi4+IPHouUJKCtvzC8OqBxRWeSnYTzuJzWKuoOllQ5bVB0QRWzMsvYBocl89ONBHiSQj76TjvXo54uh7B8Wt/OvEyNVa3TEammOkxUb2z/bSwqRamhTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994196; c=relaxed/simple;
	bh=sreB1pnRr5Jadz3cakW3nSmYitPedC09ULbGadTOM/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGhl9isyNBoJ0Foy6h1adSPYBmoC3ZW84X9FIyvpCWNUfuWlXBRyFvaxaSc8C1vTesj+/HU8sjI/BZZjnzNSA6RE33DwGEm7YFbhEpfT3olI3sjdbjNYjUnloUJ2lUs1+pFZ0XMkIq1Eg2x+MT0gvBSdJDAbfWv9E8XW0Qn0moQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ga0uldrL; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e445b4f80bso2103474a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708994194; x=1709598994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lRQpFKqbWbNQreMqz6Xcr3vDFL47RlEenB0ubeR/xU=;
        b=ga0uldrLkFlHSHnVwi2HJ3edK5EGl5iF+1lIPl0hKoXP0TLEqz97Jr4Q+V3RIPKiML
         sDJQ/CX7XPwEX8DqzXe/GYpHtCNkKPN2mVVqsPxASDqXdh7JVmnzcc7S0npy7DwQLOdZ
         CBJRPsSjz6Fgmx/3URexSBQT2YSN2UHhEy+uoeiIzv9m8kWMNeRqrjigxiVQelky188s
         Cuq+ZRz1Z4jyEloQ4X5AubWIwV7tSaDQY3EQndFEuUTbz4lWE4xHGi/BR0NffzVbFjBh
         9yfRn29uoWSSb2c7RdBA80hEM2lmIROl5LU8Jiv8V7mvzeJAolyG6qIqXAiBYHOfnAYU
         B9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708994194; x=1709598994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lRQpFKqbWbNQreMqz6Xcr3vDFL47RlEenB0ubeR/xU=;
        b=UgEInj/WaU2oOaVI4d8h9rPAya0QXaBWcVpLJU0oPfA6cGuo6rlV8KbIUDssKASVew
         PTfs0pdtVXPZ3KTRBJUXVPzh8HLNYfiOXC+Qxh2BQT9XEaqjJ4AX+SOcvMHkmo552Mzu
         P3yFvdYwbqR4MpI5tp1zm0UU6QyENJmSs4oRMvmkxlhh2khXpE+a0YcLbFPDnnYbsYnh
         hgk/VNFFTWbgjUv9Tn+foeBnp8cbu/UnJHUw3qMSGdpxGN50c3tVBZcEajI30wDecFRH
         0rbOmlApJnkPGmIy+nLEHzkRbOmnljdPINsKe4lA4HnFnfr07zWFNzXgSApRK32HoH1j
         PioQ==
X-Gm-Message-State: AOJu0Yykw2/ogeov5tKJ72Hsx7XbFTBuANWg2fTF5uB/c3ocGTLX+QKH
	ZCvYNsLEvymZ1I8v+P/ecfq9ksSpecu5WcAB5HqK+vtOG58AeWuPb4zQ2Rk7Dgs=
X-Google-Smtp-Source: AGHT+IETqa/FMi7iqDX9bT4O6ZZw50Wgo3XrJ3ohDt+qe+AARTjahlEi4fDnuqyU8dRL02wMEtDtwA==
X-Received: by 2002:a9d:7845:0:b0:6e4:85d3:3e65 with SMTP id c5-20020a9d7845000000b006e485d33e65mr9808993otm.8.1708994194200;
        Mon, 26 Feb 2024 16:36:34 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020a631919000000b005dc85821c80sm4504117pgl.12.2024.02.26.16.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:36:33 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 1/4] riscv: Fix TASK_SIZE on 64-bit NOMMU
Date: Mon, 26 Feb 2024 16:34:46 -0800
Message-ID: <20240227003630.3634533-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227003630.3634533-1-samuel.holland@sifive.com>
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On NOMMU, userspace memory can come from anywhere in physical RAM. The
current definition of TASK_SIZE is wrong if any RAM exists above 4G,
causing spurious failures in the userspace access routines.

Fixes: 6bd33e1ece52 ("riscv: add nommu support")
Fixes: c3f896dcf1e4 ("mm: switch the test_vmalloc module to use __vmalloc_node")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 0c94260b5d0c..a564a39e5676 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -882,7 +882,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 #define PAGE_SHARED		__pgprot(0)
 #define PAGE_KERNEL		__pgprot(0)
 #define swapper_pg_dir		NULL
-#define TASK_SIZE		0xffffffffUL
+#define TASK_SIZE		_AC(-1, UL)
 #define VMALLOC_START		_AC(0, UL)
 #define VMALLOC_END		TASK_SIZE
 
-- 
2.43.0


