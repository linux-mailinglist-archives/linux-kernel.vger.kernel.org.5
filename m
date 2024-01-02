Return-Path: <linux-kernel+bounces-14914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9550082246F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D9628207B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5618E3F;
	Tue,  2 Jan 2024 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DgRqkJoN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FB418C35
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so2569289a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704232901; x=1704837701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDpWqQ4mc+jX/Roh6ocibeJ1LmLlK7pqWIKc4/L4AE8=;
        b=DgRqkJoN7jmq4C8Mete+CRT6XrLFu/qo41dxk46PW9v6kz+g8QgJvnk6qO7xoHR+JN
         vm3DhCNlDOJ+DzdkuZPjd3T1BzPLejafjTfOLF9j0KNqj5ghgmvqV1dIWAECjHALDlXz
         LoMnfwTR1mPwilWyEifFn4whkLsUqDNqlxffLPsZvoNUXWF0ZBs/8p2SUuuj6DPLkbid
         W26tySgW6sKFChUQYQsKU8fT2ZkvAJFy4sgT6sK/1jihvVJEIOuLwvfcp4/JDOke5ggL
         ws9zS7AzG4voaTu2urPb1f2YSLkfXuO1DNTURKWFMuR5yrKzBI4NmEtEdoEZq8f0cxZp
         0VjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232901; x=1704837701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDpWqQ4mc+jX/Roh6ocibeJ1LmLlK7pqWIKc4/L4AE8=;
        b=WKqC4CvQFhUZbVjhiOCu5QGJDxhePG1vwLIRK771A9cfW8OiP8/JuwDnbWKuFCx00j
         UPJVyoaOTyMsZKyXEwC6Pm8evkOSTUAazrFypPTP0qP8N3Aw1IYSOGjX75juwUTqkyaR
         B/DAIcDDs8SjMVx43FY+uFprarfiOFN2Go1ni0KXQQ7sFvlZZOfykeleVj4QFxlP+7AQ
         IolhiN891P55EcsCgeccsgSxr/rvD7FyTEv9pQdy5SPqzeuo2azW2/sL6OwZRctgSE/r
         Sn9c8oXuNn4TlbR4215G0MyFsCZMFDzQWnnncK1E8tZFkUQNR2iFegVe1JNTtYRQP+7j
         HwCA==
X-Gm-Message-State: AOJu0YzkEUSkws0sJRqQAp4MihPl0FEzcQ41BcVUjEZNk0gClqldWGLt
	Rzabx5d94U8tpAvOu+ice3MOP9xdkfsENCZS4vkccVSGlE0=
X-Google-Smtp-Source: AGHT+IGhgK6idMxI6CkoCNiy9Y4cs5Xn9ml4r4H30wFrLDF3Z3r2uMsg0CAIjypKVmYj0k77Mk3d6A==
X-Received: by 2002:a17:90a:6ba6:b0:28c:640b:ce0b with SMTP id w35-20020a17090a6ba600b0028c640bce0bmr4536054pjj.33.1704232901387;
        Tue, 02 Jan 2024 14:01:41 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id r59-20020a17090a43c100b0028ce507cd7dsm101724pjg.55.2024.01.02.14.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:01:41 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 04/12] riscv: Only send remote fences when some other CPU is online
Date: Tue,  2 Jan 2024 14:00:41 -0800
Message-ID: <20240102220134.3229156-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240102220134.3229156-1-samuel.holland@sifive.com>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If no other CPU is online, a local cache or TLB flush is sufficient.
These checks can be constant-folded when SMP is disabled.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - New patch for v4

 arch/riscv/mm/cacheflush.c | 4 +++-
 arch/riscv/mm/tlbflush.c   | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 47c485bc7df0..f7933ae88a55 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -21,7 +21,9 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
-	if (riscv_use_sbi_for_rfence())
+	if (num_online_cpus() < 2)
+		return;
+	else if (riscv_use_sbi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 2f18fe6fc4f3..37b3c93e3c30 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -73,7 +73,9 @@ static void __ipi_flush_tlb_all(void *info)
 
 void flush_tlb_all(void)
 {
-	if (riscv_use_sbi_for_rfence())
+	if (num_online_cpus() < 2)
+		local_flush_tlb_all();
+	else if (riscv_use_sbi_for_rfence())
 		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
 	else
 		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
-- 
2.42.0


