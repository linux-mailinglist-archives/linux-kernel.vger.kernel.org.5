Return-Path: <linux-kernel+bounces-138233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EFA89EE83
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9CD1C222BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4E715F30E;
	Wed, 10 Apr 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bk/BFyIa"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111B15E80F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740285; cv=none; b=iJWyGfSV+9n50ZAMPg8AbsrqpPpv7eNWhrmj6zqd8jZMcSDeoa84dGxYkVFajyG1PGL+31YkwCiueUml5bTR2m9pLcnsnnovYBBl5B5kOAOszP20iT+UWExK4BF2lYcu6TcXm4qcnCxIhxTs01TjmkFqEtKokij9FY63oLbny+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740285; c=relaxed/simple;
	bh=boke7k+fuPr/buwvZEKJqr5O7FQgiL8dA2Us1JuDFEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKudIPZWa0plBv27Q0PW5VQVz7PIvwMMBLd6c1g4gezY5++DVWV/yglwJvLBRaUA6RsZfet7GeaSI+wSdxXS6mHTlqD40LGPYMcoZBITR6jFEpiInuLKs0xAt+73vIn5AziQ1j5To+qCS3/jNP8B7A8u8E5UEpUwOP2tjyiR+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bk/BFyIa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343c8d7064aso1125279f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712740280; x=1713345080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJJluMz+u6UTg8XM641LtNTBq3D7zPplm+46K1BBT3g=;
        b=bk/BFyIaHE0pO6HUdWxu55HzN+kp9JNMyY4GsAvDSZckF9Ju1VUV1E/Gy8YnCYEGxN
         RtODCTgwrJl55hEnic7oSFMPnfZa3HNezEHnNwlo1s6GiFMYE0xXbeb8FYukfGcaktQr
         +ySTMYqSmB10Ug2q8R7ezjkcpvoiv7lFaXoxby/iW/CJYiU4UXEBTf/FUlDw3mu7C8Kw
         cV4cKjvhFot6ji8EjitDunUEkDY/Hrk+l976EzrrR4ujELGoDCdlI4ughddOWu6b5rZi
         S2EBWzUjnWYrO4UutqLLLsdv3dDgF3SDvpYXfhyUqlLJPkwzAf3y+Uh/tmQ1dXeMJmZ9
         5iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740280; x=1713345080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJJluMz+u6UTg8XM641LtNTBq3D7zPplm+46K1BBT3g=;
        b=g1SBXLJZK0kwhvAi+1lxcH7QIIAlMRnAkAaIEy5VeFtAqohdYX9xzHB4l/glo69UqA
         Swpk/DRfIqULDfHO9xEdpwSJsWWEmJGmsLPApRRxyUcLTyhwmMXnFVb8XrNVtj9dAiH2
         YT+LIdLyKw3DRmUMtQmH/Z8jl4E9BCKjTKgtX6PW8wMphfsJFgBt9hU7pXjhbc+WVFbk
         1sdD21xj8/a8H034PJKpJ+XwJFjnk76/2QZVf32gxT4Ds+M2Wh7xhYE3QuRE6aqUOy4E
         dHOuzveyt5tE0nTUxMZEuXCF63xzupGmcXqImx4/21y+Eui4erkMqjbzI8lK097XFl1V
         8IYw==
X-Forwarded-Encrypted: i=1; AJvYcCVd9DbtP/qVYxiSL7xz0Co60gRHyFGHnV1Pqq+z1R/rnmcB/9kf/2gNFpfav8q0s+xIlF9zuaQeGTBo6g+Wy9xKslKB7r1Cri5SiHpk
X-Gm-Message-State: AOJu0YxLctyn9cilvn0BIPqckLSvJ3Z03lW0t1TJwpdihwE/uyCTuk8h
	E90lgE4A9rPFGyiwBIE6HRzpEjOmbdsQeUaK6qFSiOidLfGlgy/bl+DiRdzqvEs=
X-Google-Smtp-Source: AGHT+IEFPf1rw4WsvUPP4gQ49sbgG/8PoNAGTh7VbYh9f/s9CL9k/Q3vxX6P6qvCn28cWYP3BC7Kuw==
X-Received: by 2002:a5d:5982:0:b0:343:b9e4:ac2a with SMTP id n2-20020a5d5982000000b00343b9e4ac2amr1633081wri.4.1712740280271;
        Wed, 10 Apr 2024 02:11:20 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003456c693fa4sm9079086wrx.93.2024.04.10.02.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:11:19 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 07/10] riscv: add ISA extension parsing for Zcmop
Date: Wed, 10 Apr 2024 11:11:00 +0200
Message-ID: <20240410091106.749233-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410091106.749233-1-cleger@rivosinc.com>
References: <20240410091106.749233-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add parsing for Zcmop ISA extension which was ratified in commit
b854a709c00 ("Zcmop is ratified/1.0") of the riscv-isa-manual.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b7551bad341b..cff7660de268 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -86,6 +86,7 @@
 #define RISCV_ISA_EXT_ZCB		77
 #define RISCV_ISA_EXT_ZCD		78
 #define RISCV_ISA_EXT_ZCF		79
+#define RISCV_ISA_EXT_ZCMOP		80
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 09dee071274d..f1450cd7231e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -265,6 +265,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zcb, RISCV_ISA_EXT_ZCB),
 	__RISCV_ISA_EXT_DATA(zcd, RISCV_ISA_EXT_ZCD),
 	__RISCV_ISA_EXT_DATA(zcf, RISCV_ISA_EXT_ZCF),
+	__RISCV_ISA_EXT_DATA(zcmop, RISCV_ISA_EXT_ZCMOP),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
-- 
2.43.0


