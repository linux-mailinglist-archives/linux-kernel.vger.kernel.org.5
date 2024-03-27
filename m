Return-Path: <linux-kernel+bounces-120314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4395188D598
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F242C233B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628002C1AE;
	Wed, 27 Mar 2024 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GFoncGkd"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A88836
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515061; cv=none; b=ZJpbDji8sK4U3HbBYg2tr3I1SmvzOsrsUnLmCPg8fC2Lsqfb8mKQumBc+xglUQK+RszlkuKX+XGgNltFdpUjShEmfzelabaeDNQvSiqkrg73w3o1KNNdl4wMfGym3Q7axxKgg4rZ0alJbenX9YazfAQNIUzp9DPNTqnzLLUpUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515061; c=relaxed/simple;
	bh=G1BXM2z6rQBc5K4wZw4N6I/e+joRY7yH/Z0Jdaxm+no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlHl7lyQJdNKb4vTzuk0qNylAC8tUaArTX4+btn/+feoOUHBQeemTuMxw0i+twEMmM+qLvypKWlYaIWB02iZE9VMJPtccIWS/vUGtpHyvc3lo1B7+dAGeTBizS4uR2j7oz621cSvnlFeM2bRVIvLb6puxv8KXWYtRGRQ4azQXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GFoncGkd; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a1b6800ba8so2230312eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515059; x=1712119859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wFLc5gcnBs285NRnicKVmmQVV53EnA/2rANcUM2uCA=;
        b=GFoncGkd4CnXjWpR6dZgceUdNTns+EkWUxgW1bzfHBUz6IYFilVgPq8ZuRAsiKohEN
         QKK9q8ehr/sXYPBNqXHwAsEm9BEuYFFBLxrN1Fe5HOM9OeKdt3MmGY0R0JmM93f6nxfx
         0AE0eQi0+UrnJa+TRSxIpKXNlrU4XSTw9n1lYCZkw2nDrP2ZDWAU+4UTwYn7ybN1PWKF
         JS98FZhB+JkRiKeUc2fGOK2VtNm+x896G3z5KQmYGUjFKzFJvW3w9/RMOxwOk53mneoS
         2sG8yhZDtds9lhwB0Kb8yBB3XLqurR+N2y3wVtUQnuV4In3RYGeFu+7X/5evOtOB8r/a
         5mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515059; x=1712119859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wFLc5gcnBs285NRnicKVmmQVV53EnA/2rANcUM2uCA=;
        b=qA+e7v4NelTjykLAvg2w6HzscsH0D+VjpfFMUdqlL7V37G2lu01JZU0OFKDtIx5uS8
         fMjfr41zXqGsse+Fylso+7P17CiPtEYVxAMZ6bC1qZhZfemrW0lar2xWt8M9/t9T7zDp
         JF8+tVIyRlv692wZhjMtuj+GF61uhWkb0Qdu9jLHsHspOhx7P7wUeJrsOoY4Pktcbfl6
         7DCD9VHgAc6h7NGlnc0T9WrWXdBfGt1Rsog/dGZqI5Mrc0zm1QzndycEKy9NPnehkxEY
         EXiyAiG3AJD1YwoGsyv+NuvcTaEjK2f2waYMWcXwQw0ujFiPAt8f376W0/1oes4aM2LA
         da1Q==
X-Gm-Message-State: AOJu0YybpLHMQ3xR/XbLdojXz13dQrX/VuQ724eooraRMhxXUT2sWQHP
	OK+feMLAIYkopULyauVPGJ0qGBUOoHjU7/gsNqhGDGa1pftAJOsixfWE3RnpzDc=
X-Google-Smtp-Source: AGHT+IFmC6K+A8yipt+L5BT3VYhAZMjFopo36khv4UzVVH+BHr/EbytiKBlOS5fSbYkXOITYtqGpvA==
X-Received: by 2002:a05:6358:320c:b0:17e:bb52:927f with SMTP id a12-20020a056358320c00b0017ebb52927fmr1922247rwe.1.1711515059146;
        Tue, 26 Mar 2024 21:50:59 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:50:58 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 11/13] riscv: mm: Make asid_bits a local variable
Date: Tue, 26 Mar 2024 21:49:52 -0700
Message-ID: <20240327045035.368512-12-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327045035.368512-1-samuel.holland@sifive.com>
References: <20240327045035.368512-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This variable is only used inside asids_init().

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/mm/context.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 5315af06cd4d..0bf6d0070a14 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -20,7 +20,6 @@
 
 DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 
-static unsigned long asid_bits;
 static unsigned long num_asids;
 
 static atomic_long_t current_version;
@@ -226,7 +225,7 @@ static inline void set_mm(struct mm_struct *prev,
 
 static int __init asids_init(void)
 {
-	unsigned long old;
+	unsigned long asid_bits, old;
 
 	/* Figure-out number of ASID bits in HW */
 	old = csr_read(CSR_SATP);
-- 
2.43.1


