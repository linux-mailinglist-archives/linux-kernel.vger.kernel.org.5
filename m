Return-Path: <linux-kernel+bounces-152030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CCB8AB7AB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0517D1F21D37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3B8143896;
	Fri, 19 Apr 2024 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OMD8wsZK"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E6143C55
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570480; cv=none; b=E9onzUmFnIJScF6ZbVyTZPnVv5aXRNbsyztqVr/t0jTJj7w1MoA4OL8+P2EgQa+g8gS3B+IMdj85MbAihpXQYj8AMeFRG/Au8H6x60E2m0GLsVfLFG7FLruDzZQaa/NQyZgSLwgb7gMssufoLD79DRuUhVP9Q1EZIFb7ww9wKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570480; c=relaxed/simple;
	bh=H8usdALoznAt2isX7oNnrfLpFcaNKxvOOWa8DDbamCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2JNVHMdDfmnxheTIUZ1vdPDH3g7971fA9h8UbrbOktCSqxC993zvjdhmXl7GA4PtiNhxQFiTvwfHcl2v8TUvzuF2TnQ6+OKj91Y+dpDwGJ6gM0CCcFXbb7+00bdIIuwRdup+XfUhbLnPdGlMqaPUErS1H4PR9Poj+fEzRKzupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OMD8wsZK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so1579319a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570477; x=1714175277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU9bTQzimBlb4bBeVGV64JD8vBjMh3ZSXWmumJprSMc=;
        b=OMD8wsZKCRdjJvZGYl+Ya9IqIPLUZN8Us5XJWfHNYzlhwyLm4likvuiWW6LVNW3IYE
         QU/Srx4vAkmXgdvUwKtwJaZWCykHAgaudHZKtq4SKk7HN63XIwXGxRpzofIGz3gbcCqO
         357XHJEuOzF/l+GTioGQAaLZuoS/lfAShwkiGc2PMHLF+EBfLUu2ac9wQwzCm7CfFEmG
         gNKJnSoRazQ7Yox/coXpMl++jZ0OW+T2J0q6yFtlaRwncB7uq/9qBwDk8c3ce8LZ10td
         C8qi/t2EQnGp7OFdkE5qUlQM3Xg3EsweW/ZuGLTY8NgW4A2nrc1gHBbJUl4DPUEmEP9Z
         zkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570477; x=1714175277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU9bTQzimBlb4bBeVGV64JD8vBjMh3ZSXWmumJprSMc=;
        b=MSPjLUFqotMlUofKKfkCme0LckUq54HrfiUC6gIIYMsbwd9+ZFqKxbsgtPUt1gDLb7
         fRZOm7l4aCeod1wyx4tVJFyKDSnSCwa+qMaYXg7e5SgCRWBnPlPflFuC+ueA4lAJAHo5
         YIcahSsnetMT8WJblK09mrRn5t311NITsonT6+61ZlPvZGamJStqDd3MbwsUThsO3CJz
         +YTRFTTBKlQYY/ds2q6mKwpyp/Q6ShouS6YxzLfh7IK8u5f2PWDeLzYtuPuJ50Z/ZGJ5
         k01Ikl4zGh7/GGbslgVaPeCmlnEfadvlewJ4AUhIUbhAE2dMynYfDvI4wIx4AjMbTB6G
         IcwQ==
X-Gm-Message-State: AOJu0Yy3T8Ak5p3syk+Vl0gaAvrPQpQMQeyFxefsCGooaIINfUkbZ6VE
	Z7Y83OKpW7vJHcU3njH4LDRwcYG7uDRuXfv9JZq3oOrNlenttHWCQmcbEhQwRHDRLuzEM9aUi9/
	g
X-Google-Smtp-Source: AGHT+IEp4LLA0ETVFj3v2NTREBIL9JwLMfd8wP55jjHsvOjY9dRaboqfqB73D1IRQCndgtBmMeDbdg==
X-Received: by 2002:a05:6a20:8422:b0:1a7:336c:555c with SMTP id c34-20020a056a20842200b001a7336c555cmr4805991pzd.60.1713570477483;
        Fri, 19 Apr 2024 16:47:57 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:57 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 07/24] RISC-V: Use the minor version mask while computing sbi version
Date: Sat, 20 Apr 2024 08:17:23 -0700
Message-Id: <20240420151741.962500-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
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

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index f31650b10899..112a0a0d9f46 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
 static inline unsigned long sbi_mk_version(unsigned long major,
 					    unsigned long minor)
 {
-	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
-		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
+	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT)
+		| (minor & SBI_SPEC_VERSION_MINOR_MASK);
 }
 
 int sbi_err_map_linux_errno(int err);
-- 
2.34.1


