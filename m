Return-Path: <linux-kernel+bounces-136272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31C489D226
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893C428257F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0857BAE4;
	Tue,  9 Apr 2024 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ogCu/JST"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD548763F1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643125; cv=none; b=pOdGaIvFVADYOVoSkvZslH+0cWsu4eTHARo7ikgmeyuBwEAIlGxEaCF9WY35yf/v+KYw+pDMI2RQHjfhrnkNg0+j3yi9jnrHwl9tTv3wxHvk0niv0QT7nz1z0apn3eB1byzfzM8oSiHnomzZhj/bOkPGcQ5q7ixBw4IRsqOZ6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643125; c=relaxed/simple;
	bh=n+EOKrjOyFwBtqRSR4DqiXVEGHHNMUiIaHIFFgQ4+cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1jBJrZhgICz12COYS5IhUt/kyhDlev1SwD15yHXtT30ajtR29997SpBgaYRDuq1iltb6V0UdIKrAZEvfYmFDcDtEInR9I6kww5X90m7SRB++WwEOc78vTNZEf9zCv4/q66ki+ze1b7u2S5QLIaCxKhGWBBNZQyH7mmM3kYCdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ogCu/JST; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e41f984d34so14582615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712643123; x=1713247923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otFFuZ99fXcVhYb8FNCR9GjZzpzmViSqESgMKU4iT8s=;
        b=ogCu/JSTZ7ojZc9SiheLY2LdXoJm1BGeK+WqR103g2efsgONfj2b1vfAYx60gvXG0N
         XYiMFQbMCN44M1meugtsxK4Y34XlAV88x78gQdlu9dQIRDK28kYvMjO3sgCjA77eEaZZ
         08oRUaR1uEp43FS+s2eVmZ6fJxbWDANGWgrP87tCESSN9kuRuzu25EKBF/x+WBKjM7JX
         wssuivG6B82EozGsktnuenC0DAbybD4n1pNPHzdb40OKJM65TM12BZTTJ5PNNItYnqTE
         YhK1+jBwJ9y+g+wfGZYQQojXDW99Gd0W53iyjFWnI92gzwmkeb0mAqn1lCkv3sGo/IL2
         KRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643123; x=1713247923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otFFuZ99fXcVhYb8FNCR9GjZzpzmViSqESgMKU4iT8s=;
        b=HwkleYU9clzkRQxEBjefXOp1CLRf2Kbpb3Xs+fIPgJI/AjMe9TYliWzIIa4Vch9gEv
         MUEdZVH8OYHLoOHcVS5WkB440CDgiM05uwsHUpr27p+IoZ5etOa0W17yL5O6RqCVjlJf
         QpOa0idiQve3c4OUuwlhYA5iFYqxbCzjf2rS6IjoLUQ+xE5ZGbc74ilgmk5efCiUNYIE
         zzqssexRNDxrwFTAoKPWlpRwCSLU4ybeO0Hsc+EZaftQO/esjUgi2k97mPYJhmh1l80s
         xOsYAtuLHfvb6sXbeBe/OcyoVTVNifyfezGUJUShvpiigmsE5DX2PYYx1XGm/OTxJbhd
         BOWg==
X-Forwarded-Encrypted: i=1; AJvYcCViZpp+XgwLimaorunJpi9ebfKR6aDMmYE7Su8AfIIo5Yek6iEmN49FOdxvB1/qnwYLtsjD2cLApJeiy3iYZPmfpkVb3g3++wFTmtCe
X-Gm-Message-State: AOJu0YzWfz6HytDVE0lIOyOfkWnH38PgARzLGz60OUTefXZsJD5xoPJj
	XpctEjLQqTI2ms7LTaz+vIlulOYRnehVhNCGCflTgsG+OY1iNnvtmeG4wmBU3jg=
X-Google-Smtp-Source: AGHT+IFyiikZL/hhay4BjKgWK3lEvoskg6V/4zLFxKB+Bpw4p7lBdSTWw7dgsT6Vm8oj6bbr2fXrdA==
X-Received: by 2002:a17:902:c40c:b0:1e4:62e2:fc86 with SMTP id k12-20020a170902c40c00b001e462e2fc86mr3254513plk.7.1712643123055;
        Mon, 08 Apr 2024 23:12:03 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001e3dd5972ccsm5775564plf.185.2024.04.08.23.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:12:02 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	andy.chiu@sifive.com,
	debug@rivosinc.com,
	hankuan.chen@sifive.com,
	guoren@kernel.org,
	greentime.hu@sifive.com,
	samitolvanen@google.com,
	cleger@rivosinc.com,
	apatel@ventanamicro.com,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	waylingii@gmail.com,
	sameo@rivosinc.com,
	alexghiti@rivosinc.com,
	akpm@linux-foundation.org,
	shikemeng@huaweicloud.com,
	rppt@kernel.org,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	willy@infradead.org,
	jszhang@kernel.org,
	leobras@redhat.com,
	songshuaishuai@tinylab.org,
	haxel@fzi.de,
	samuel.holland@sifive.com,
	namcaov@gmail.com,
	bjorn@rivosinc.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	falcon@tinylab.org,
	viro@zeniv.linux.org.uk,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	hca@linux.ibm.com,
	arnd@arndb.de,
	kent.overstreet@linux.dev,
	boqun.feng@gmail.com,
	oleg@redhat.com,
	paulmck@kernel.org,
	broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: [RFC PATCH 03/12] riscv: after saving expected landing pad (elp), clear elp state
Date: Mon,  8 Apr 2024 23:10:34 -0700
Message-Id: <20240409061043.3269676-4-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409061043.3269676-1-debug@rivosinc.com>
References: <20240409061043.3269676-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On trap entry, save expected landing pad state and subsequently clear it
in sstatus so that if there are traps later on in kernel and sret happens
back to same mode, cpu will start faulting.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 68a24cf9481a..be07355b9eff 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -56,7 +56,7 @@ SYM_CODE_START(handle_exception)
 	 * Disable the FPU/Vector to detect illegal usage of floating point
 	 * or vector in kernel space.
 	 */
-	li t0, SR_SUM | SR_FS_VS
+	li t0, SR_SUM | SR_FS_VS | SR_ELP
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
-- 
2.43.2


