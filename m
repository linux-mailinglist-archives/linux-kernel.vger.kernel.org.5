Return-Path: <linux-kernel+bounces-162547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FFE8B5D22
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DC3281754
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BCF130AD2;
	Mon, 29 Apr 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="S528nEJJ"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D88130A48
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403205; cv=none; b=kZRe74N+rKIZVXKiyE8bU41cweRsdkJSyC14ws9VSYNMlP6bPefGJj7pLATNgiVVTmcTGkktm8wtEJcmBJUjsXudgrAd37Hd4E7xmC/VeM/Qf44AwY292oEyzmfNHFidWwTBhjxbQcC4fU2KFbX/QbHj/7x/BL9FPlJzjRZJj5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403205; c=relaxed/simple;
	bh=awZzvOfeihP/zQBwulZo2fkHpvheuFzo9+sGOB1HlhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ce7mT6RjuxVEBOgxMLwsG9ZO3NokFzKpEQS/3UhR5U6SW5EnPw4SnrsGC5QRNEsNdWZfLRfZrcRNdEMVmgv5rJiRfRJVbhTQjRGaO2AO4794Zgel54gdKq/161KhvwwdeGQEhDWzd8cL9vaBI8iW8b7LXWywnMgWSaKBjkcoSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=S528nEJJ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ddb69a9747so628811fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714403202; x=1715008002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQHXVYsUJGkXAyoSx2aDU2oA4c+tlzZFdLvDimlX5cw=;
        b=S528nEJJuVc/ifgNZ4CM3gYn0p5kQA7gZNENBrsSghE92Sj26A/1SSBJBqVhtZNeh/
         J9lEvaCTBbiXiGF4DxPLgU6bCabt/3ngfL7EJ2oAvRgMEEjulbAnuFvkVXtM3e3H1yAr
         gGMPtgjlfzCmST+gYzBzL7rGQQEj3KhLzLKpX60bQnC7XeK3SOQm4KKxIsSz0XckQd1K
         YZ4CFJvwik/xtvoz73aMdsEtUgljll5/qA95DYD+y/9ObG2GufT7Awxbi3S6/2cUR5ey
         tV6hfECq9+cEUGBo8QnNQyMGssrqnITCBFuVI0F69YZdsFFqwsQW+fc19lMke4SQdTB7
         XcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403202; x=1715008002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQHXVYsUJGkXAyoSx2aDU2oA4c+tlzZFdLvDimlX5cw=;
        b=Pk0hP1MxtoGnHpaL5KU0Qmg991Bp4OO/M5JPd2i0JdXG0ha00HBxnsPe1TlGD+Gr5V
         sT5QkBMW54EZp5aF8bEdht5zuLO50qQx1hr7wivqPVgZVhzXOPAlhXmPcCOo7atl9tvq
         8bbO7WN4BbAakd69gyHZzLhoDiYY4sz2UPcoy4q1rwpLuLBzH1dstP6Nx+WKlbop+0la
         uRQAzKCFCp6hEmRhcBclcFrYzrI1xGnjKAnygSsGNFpzqtyaETDU2SrkK3nRKVCtDH9/
         YS0jwBBOOvOqjKHz8OUBioQ+XLCY4jHoyp1ncUSYguwiaWSQZpMOyozwznZx2QPNEdlq
         nMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcXNfLvq4GPd9LFNHGSFq6+OUL1WcqYtCV/6T5tKVccYY/yu3FRO7Nfd5NY4ivcI6vilXOJnj7/NZJ5pw+0IZ2QNFjew50OsHaB2li
X-Gm-Message-State: AOJu0YzvVlBoABra6xnVhoJjYtXozfd7Ifhg32LL/zI+XtOs0f3DnbOr
	fAJ0Agb+FFUZTEwpX4XaW99hHpRMQ1gdPhdPJgrdpjDjRmePCh4EBpyyCFxDTFU=
X-Google-Smtp-Source: AGHT+IF5Vs0aqFA3oJjuIMNqrstrULWJr97uvIHCvJJ63TtvRmaJzQ2/6ase4AtbajSIDHGGP4F5Fw==
X-Received: by 2002:a2e:9ad4:0:b0:2de:1457:9d22 with SMTP id p20-20020a2e9ad4000000b002de14579d22mr7307292ljj.0.1714403200338;
        Mon, 29 Apr 2024 08:06:40 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:2fec:d20:2b60:e334])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b00418f99170f2sm39646638wms.32.2024.04.29.08.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:06:40 -0700 (PDT)
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
Subject: [PATCH v4 08/11] riscv: add ISA extension parsing for Zcmop
Date: Mon, 29 Apr 2024 17:05:01 +0200
Message-ID: <20240429150553.625165-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429150553.625165-1-cleger@rivosinc.com>
References: <20240429150553.625165-1-cleger@rivosinc.com>
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
index c74bdb9c0a9f..acd745bbf41f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -315,6 +315,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcb, RISCV_ISA_EXT_ZCB, riscv_ext_zca_depends),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcd, RISCV_ISA_EXT_ZCD, riscv_ext_zcd_validate),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcf, RISCV_ISA_EXT_ZCF, riscv_ext_zcf_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zcmop, RISCV_ISA_EXT_ZCMOP, riscv_ext_zca_depends),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
-- 
2.43.0


