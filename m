Return-Path: <linux-kernel+bounces-100711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E1B879C46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6407F2860CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515E2142652;
	Tue, 12 Mar 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A9UvRpPo"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145442E85C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271989; cv=none; b=TKq9qhrHNIQxWGpn1zY3piNe2p6PTTpCn09IK8dnK2oXXvuHMrGuLAGRka+6HAs5d0NIBMJZyA544xy/Qt3A5RVT9halITROA3zHwWzmIMw4YLO+3Flba7r4XpDr4yDSCep3Uvx8vdCRSrZOBaWH2X8Vl750WNpj3FvZoNZDV60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271989; c=relaxed/simple;
	bh=5U2+9lGF4FrJHQBBFO1tR3vs7XnJmNVzcpkEqWxS99o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V31pHkNY3mZhL/22XwGruF6J0M/Bmn3hZgUSAVzuuAfy3CL4f70SUB/pAl3pTRfE95HF8CBrRuqzUIVwAs16N5bNsePZcmUIu//lJi4+0nQ6bju5Jxv/pi9q8TgofqMN6RLyhVL6KR1uJ5meoBZRjfzztZFP/fbFGlHPixz7J3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=A9UvRpPo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd81aee2b4so32824105ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710271987; x=1710876787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ftTA/bI42ti4Fz3CgBot24iMh4CdOEErvPMHNFt7wY=;
        b=A9UvRpPoGFCIRKJtyPSfJNa6xuLZbwxt2WEL4dKJ/NiRtQxbxzfb+HOpZxSTccpU0Q
         WvNdFUJ+mDfZz9Xh5l4lmryJgffjNAusbKNvhy3Foy7j11voG7frNNssTmgUweWk7Md1
         ZY7YK3ZmQs6Jyiu8PDE4qoOZ6WdBMfi+dBvboWQHuQ6ap0bamHccaO/l/ggZuydyeCJZ
         +CQNyH5pO//g801aFYquqyW3HnnWgoYHnQ/gWu6sKx+PYTsUc//GPTUrBnlzalw2aKmO
         KGh4mAkCJ4KCV9Wpql/ZQLyyh1TN2w/YzGUU4e2Q1SJpEMTea1D+INQBn60bWxx0/WR2
         FHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710271987; x=1710876787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ftTA/bI42ti4Fz3CgBot24iMh4CdOEErvPMHNFt7wY=;
        b=NbNLxM2GlpLV9nzDMZOD6P/ocS3w9y+XdQs/dfQeW5tuB3jDHnXybHy1iuMrL5MFP5
         9R+83CZtMUKY4UB8MEB9K68orkQa9LVAZE2+tFi9XO375OTQo3+OJ5amVnlsIC0zthBf
         o0yVt2D1x8SQbOHZ3clvb8JVKy1onfI/MVgwWE9T5O9/YaDOXB/c7UAdvlW7o91wl6zp
         9Bxzyb0BMZZ8iU35TAHPxprr4mwlXVRS1jKZH1VUwG06GxuBNdARGxXJyLxBNSkXk+Ph
         TbpnwWVmhfTHP1sciscpDllahSCvsYkg/qlCG2Jp5nUQrqsw3I0Nr7+2WhWdTkOJ1JHg
         jGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFmZjJ7ybownP8VOXTwm0T4046ZNdy2B9SiG0oDTfZWQlnmihhae2xL+RqFj8Ie4ReZ9CP9mVId1VC+34/Mtuc281HjNmrx+rG5BVc
X-Gm-Message-State: AOJu0YzCUxL3F+7U7zeqUGjCExSUefCDs2ZqF6sQ3/4tPnT8wPW8Pz/l
	pZc2hPDibfHlt2hp79ryKcSIjZIhN96W4gfNLtovx+QElYYx1hzggkmTHu2+xAU=
X-Google-Smtp-Source: AGHT+IHMAaeTF22TajddSfUp+8UCNTmclqWbgeHaOV9+99pfD3RLiLJzSzhcL0gOzhuE960W3tWdnA==
X-Received: by 2002:a17:903:32c4:b0:1dd:998f:f21d with SMTP id i4-20020a17090332c400b001dd998ff21dmr8772872plr.22.1710271987305;
        Tue, 12 Mar 2024 12:33:07 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902b78400b001dcc3a46a6bsm7017385pls.262.2024.03.12.12.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 12:33:06 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] clocksource/drivers/timer-riscv: Drop extra CSR write
Date: Tue, 12 Mar 2024 12:32:47 -0700
Message-ID: <20240312193306.1814593-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On riscv32, the time comparator value is split across two CSRs. We write
both when stopping the timer, but realistically the time is just as
unlikely to reach 0xffffffff00000000 as 0xffffffffffffffff, so there is
no need to write the low CSR.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/clocksource/timer-riscv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index e66dcbd66566..eaaf01f3c34b 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -35,9 +35,10 @@ static bool riscv_timer_cannot_wake_cpu;
 static void riscv_clock_event_stop(void)
 {
 	if (static_branch_likely(&riscv_sstc_available)) {
-		csr_write(CSR_STIMECMP, ULONG_MAX);
 		if (IS_ENABLED(CONFIG_32BIT))
 			csr_write(CSR_STIMECMPH, ULONG_MAX);
+		else
+			csr_write(CSR_STIMECMP, ULONG_MAX);
 	} else {
 		sbi_set_timer(U64_MAX);
 	}
-- 
2.43.1


