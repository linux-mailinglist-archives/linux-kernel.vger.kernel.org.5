Return-Path: <linux-kernel+bounces-139562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C268A0475
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30105283E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514D17C7F;
	Thu, 11 Apr 2024 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nUxgOLdj"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375017BA2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794108; cv=none; b=luARH+qLJ8jlU2KZZqGkr3fEEgWaNJmNQZpfkd3x5f4kxH9jCahhaJwQmavICmIidAkhdP4MYHZwJE9r1srIOx0QKxallsP+A3V/SXUE9IS1EMLWtvPzjM6UyZGKyobflFfFHiVbqAFjFh/StC3rKBf1U9+3fnJMH/Ae9/fOzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794108; c=relaxed/simple;
	bh=f7jwD7at3eRXjUvJMDfYkww4RoUkr2LuWcPC7rhOq1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T06Qv4bk+9BF6fET1omjFNVrKVBDg6x+O8j4Ljv5Ygj1d3A75I3SH+r//OoewWrIiN+iuiU1mDaIJbU1uVM8ehBhPXCJsWE5islI9rMH7IljiAAfTl12EAUok2pXhx08288zpbEejNTNJgbuqdrxbd8dbvmCkpEwvyuls5wPBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nUxgOLdj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3e56c9d2cso38855135ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794106; x=1713398906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ogf9r7p61Rc1oGw0oa8bhNwO/iV9jqlxUmzvsZGcz8=;
        b=nUxgOLdjHf+I2cpMr1wSKcvvthn+o7lI9qnZoKXpI+J5jWl8fKUPFQcSHYClmIA6RB
         FThnFI22F2JNf3k/atBr9ScKgZU0IBZaq4eiezVFXbdjTLOAkpYPt0w6/UVa6pyqW1Pf
         hKYNj+hVdHBqNPqej2UdiEckvU4Svbu+9znSonAsX4T+u7maEyizdDpHTjWQPHDNhjVO
         iBoa8vWQmNhODyoR4943RJzb52DxFxG4WToUotyVzULL5t+Zty8ELZSq5AxvaZ0xFMCx
         JPWT6lOB02boxaqtIoh24ql01ck2si/A0tcfXIalJTYRluNlbJA0qncCv4sYbC/NCSMo
         vGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794106; x=1713398906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ogf9r7p61Rc1oGw0oa8bhNwO/iV9jqlxUmzvsZGcz8=;
        b=BSNYDHjP+u10bKjVGXzLVvtaUKC/Z9ydaADepN104n5Yk4a3pAJRQNHHDRqlOshMFb
         TdmFNmRFtQd+h1rC6q/BKt7YJ2CChz7oXORTRFwvUVkJOzaLqXWoAe/0tbrtl80rjyyF
         1hVPDaOftIoTBY1QuYmV/PK3Jxu1tZUqFjuXVDX6uf3k29DrH5i+et+H+JjwDFx8YZsr
         dEVpOQBmficXAk6MaF92U1GYWrx/02N01X9pEi3iykr+Od/IYO88ONiF86IaNECfnA9Q
         F9a+78VeeGEbmSympEUIPZy8/PbFP3Pzf8jIQOeA0k/hSsz14rLN/kw8TIwt1phSAy3A
         PhUQ==
X-Gm-Message-State: AOJu0YxPbyNnN/iIKCm3Ebfrw4QKj+cFzr7ZTH8pQSMAtDqXZBTxfuhR
	DUiGdV9nCVj41uHvnHZ6zdS8ac1R0pT3L8PoN4bENneddN/8IpbeXadMQ12nzoZYgWvIn23pzPH
	2
X-Google-Smtp-Source: AGHT+IG/gd//TA1TkjWqM9vD82L3r8r0JszUDH21ZhI6QqZDs4OR9Y/ESBK0GgL0mQ8WNU4EjNB6Kg==
X-Received: by 2002:a17:902:c944:b0:1e4:911b:7a6b with SMTP id i4-20020a170902c94400b001e4911b7a6bmr5362603pla.61.1712794105838;
        Wed, 10 Apr 2024 17:08:25 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:25 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v6 07/24] RISC-V: Use the minor version mask while computing sbi version
Date: Wed, 10 Apr 2024 17:07:35 -0700
Message-Id: <20240411000752.955910-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per the SBI specification, minor version is encoded in the
lower 24 bits only. Make sure that the SBI version is computed
with the appropriate mask.

Currently, there is no minor version in use. Thus, it doesn't
change anything functionality but it is good to be compliant with
the specification.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index f31650b10899..935b082d6a6c 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
 static inline unsigned long sbi_mk_version(unsigned long major,
 					    unsigned long minor)
 {
-	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
-		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
+	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT
+		| (minor & SBI_SPEC_VERSION_MINOR_MASK));
 }
 
 int sbi_err_map_linux_errno(int err);
-- 
2.34.1


