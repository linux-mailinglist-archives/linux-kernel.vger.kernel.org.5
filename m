Return-Path: <linux-kernel+bounces-102324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5CD87B0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1A22893D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553BA5C90B;
	Wed, 13 Mar 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mNvsk7lQ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206785B683
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352814; cv=none; b=jKwKLohqb1qG15oZHEQ0QuvGd4BurluwJIbVxhsXjMxRobx/m5X5N1oAPrsa8e6+VolHk4ZS+8wz9Sl6thcFxHH7+mVwpFCU12PFWMaQS9ZkIh8qzlX6tfJpSXdUORBRD1O3qpXP6aKB7yjYUds47gcgx38yBU9bEbYG3835k2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352814; c=relaxed/simple;
	bh=YKzKrITuyy5m7/HqaXwYbEubXCsSUytOaJG/u/ZsNNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TyBdEXLWAC2gQaC61oPXr199a59eVanvKVVFmfkTKy8fL20t12/XBgH+Ok9vtgvAmrXmCM3Vd4svij1Fvt9IXERiN98MwPowLgl/lFZzLO14AQ8qFdsrOZwXiN3BzItG/C7jrwTHYfSz7bgp1of9PQo8EevfAtxro0g30rDA0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mNvsk7lQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dddb160a37so686665ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710352812; x=1710957612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZTXOjAeT6pfaV7onHDV2gE4nP+owJ8waS/mbAbqu5c=;
        b=mNvsk7lQZlCPrwZmcKU/Ek/O72Ikvo51o0y+wx1R5aVHTN2AwpI7RD+0OCsLtAqr4W
         rzDIJKaOFHouGoUyVzI7lU19uiGdvZVG00vNvZFHmqehEzCOfX7jQXrPKviE2IdJp9va
         SHGsALPA2IYAm/jkxHLS5QkOFBOtFWE9Pv50+BHi2/73g8cjsy6Hb42kQFI/H81Ww5tU
         Ofv0PX3Lu24K4yLWd5lre+vtq6zDUt/xolIy9DJU+je2ga5CdOl2IQ4VlhzLmiLAgn+6
         6J8VJ7Vo9zZRE0GEbV1ekiuiqUkNooJ4dXmhYytyS8RoaXI1XAAQrZ1cIR4KosaW9cGV
         dQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710352812; x=1710957612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZTXOjAeT6pfaV7onHDV2gE4nP+owJ8waS/mbAbqu5c=;
        b=qzA6CznMhQmc0nhiQBdgCt0wVDF3magPQaygCS/2xCB89gM/FgYfggoIKFgFF2/lyT
         2J5wOZLRi9R94BgOunTtGvjgHdRiUfnVcBWMxoMuZ3zxBYoiSbCTl3cYWAfclWGmnmIF
         OU7l5++kvq3pygb1+ytxbREoPta3EO2sljyusTWk5mTT4wBSXkXhh5sQxBd82unZznDq
         dh6iLfBRRNLVwgQvTQs1ubnmcOAQ0mk4MXDw484WiP150rOqEpKpKKUJmawVGUmYt8wC
         5sLackthbsrheqzV/o3I5jAsWbgn7EqHUbjw7CCAujvJS1IoBShFmLOn/RjU47HNndOc
         U6hA==
X-Forwarded-Encrypted: i=1; AJvYcCWrwI8EmmnFZtWWUxB6WFGqOzH/jGhYhQGHK5oktCWrLiRIh1qAFArmi6CuIUAS5RFX9ReSfD23vefnuziVxhp+EaSsQT1Jjruanb3w
X-Gm-Message-State: AOJu0Yw/eKGDZetWrxA0u6U/uz972Kj5PImxbWt89vtGx0zhgmYnDk6N
	7Mw0NWeeB6KZYBHZa35we0usdZK2DkNXTTyP4THmE3kVMS85CmReFJCpcKM5uEA=
X-Google-Smtp-Source: AGHT+IEprNdyiuonWqVfClrX/ImBIkqo5fEQz/6Uu30hIGFkzozJm4o58O8tbMTGqua91ovBM0emxA==
X-Received: by 2002:a17:902:ac86:b0:1dc:4bf6:7eb4 with SMTP id h6-20020a170902ac8600b001dc4bf67eb4mr13452784plr.31.1710352812163;
        Wed, 13 Mar 2024 11:00:12 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001dc30f13e6asm8912264plb.137.2024.03.13.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:00:11 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Guo Ren <guoren@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Yangyu Chen <cyy@cyyself.name>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Date: Wed, 13 Mar 2024 10:59:43 -0700
Message-ID: <20240313180010.295747-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TASK_SIZE_MAX should be set to the largest userspace address under any
runtime configuration. This optimizes the check in __access_ok(), which
no longer needs to compute the current value of TASK_SIZE. It is still
safe because addresses between TASK_SIZE and TASK_SIZE_MAX are invalid
at the hardware level.

This removes about half of the references to pgtable_l[45]_enabled.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/pgtable-64.h | 1 +
 arch/riscv/include/asm/pgtable.h    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index b99bd66107a6..a677ef3c0fe2 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -17,6 +17,7 @@ extern bool pgtable_l5_enabled;
 #define PGDIR_SHIFT_L4  39
 #define PGDIR_SHIFT_L5  48
 #define PGDIR_SIZE_L3   (_AC(1, UL) << PGDIR_SHIFT_L3)
+#define PGDIR_SIZE_L5   (_AC(1, UL) << PGDIR_SHIFT_L5)
 
 #define PGDIR_SHIFT     (pgtable_l5_enabled ? PGDIR_SHIFT_L5 : \
 		(pgtable_l4_enabled ? PGDIR_SHIFT_L4 : PGDIR_SHIFT_L3))
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 6066822e7396..2032f8ac5fc5 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -867,6 +867,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 #ifdef CONFIG_64BIT
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
 #define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
+#define TASK_SIZE_MAX	(PGDIR_SIZE_L5 * PTRS_PER_PGD / 2)
 
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32	(_AC(0x80000000, UL))
-- 
2.43.1


