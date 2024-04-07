Return-Path: <linux-kernel+bounces-134649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C74689B418
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228181F2143D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2FB47F72;
	Sun,  7 Apr 2024 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="JH6ZEESO"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506544C85
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712525566; cv=none; b=GTHPSWfdm6sjgGEyQIQ+ELfKLbf4wzSqvh8gyFKzUKIPNCZzWv+KP+bYzppJKTuNsd1mLYZWLhtyhvmBxpfSSrG4m4MXoy+D+JSq8c0jkb9D29ZK3lWVDktC4NzvZgXRYyAJ55dJ8fz6m4/7+L/tznxiX+0U7DIZ/gRWVQbzLo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712525566; c=relaxed/simple;
	bh=PrvneksNVywBX9QBVW+e4qsjCsF+Bt3beRefKOIht/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+RAj4zuIJy62o8i9xOYu0uKH/SljXWpjj9qfJY3kDtS7N5ut/gTc/DAOYg23GrpxK+QZI1yFAf91MRj/wTHBQMA+7Q8NReMoYqeOr2pLH1VXMmCdITmYFRI1nJOajCKfNeLiDJljqZr09+VE0oqtqBgNGzGdxC8HqVuQDSu/IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=JH6ZEESO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d476d7972aso50176521fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 14:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1712525562; x=1713130362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cpsym7Sf/nHOWsd3i9dIJWLFXouR7iLMcrTGkY+MhkE=;
        b=JH6ZEESOBzikNz0D3qPxE0u+uBcqISo07Ku8US6GA5U5chXYFI/RDsgnUhPAn9oHu4
         QjQAqO4qRqOs9NdR67jnE+9tKgkfhnG4nleIS1xF42waEq2rWIvgEFN0NxfH+5VGTWlT
         c9jAJZVLRM35O5pICOADlKrlNvmCB+v3wTaMXWAr3U2eAq7tkO1n5ELtjpRXoN+ZXO2y
         H/Zn/bfMA9da+RYJ/BO/HIb3QVDNZjfE9lQbQB60N8K8bUx9byxkA2q9fvDU4LoC4Th2
         3KHC4880JT2A/sareWtAyNAmU5OwqWcF0stgl3ne9HA2Hqyme43IzHo5MADsYHuMhRN2
         JwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712525562; x=1713130362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cpsym7Sf/nHOWsd3i9dIJWLFXouR7iLMcrTGkY+MhkE=;
        b=j5yal9rEqR1DWuBPH2iqd6jgcOCH6sj1ip87Bq0KGIGv6kECOEcBZeuWT2ENy4trPF
         2YHoCtJsTrShjFli9oNuC18sTdQLxdZSFb2gal28bbYcMS3SWVfFF+CnW4nTlLjCK7u6
         S3uPPRT9e7MmQx5OfhqaauhuMQ4uFWDsZj7WdpggBNBTnu0RlVDYf6OFBftwe+S6eozm
         kjD4/TVysiyCOO0vdBjGb2VDv0OhYK/ayNlqG6U1BSM0qRd6raS30Zc9rB1N8vzpuFbK
         Ns3ZY7IJGGsgCosHJEVFGuukPhCsG1WtQXv/agBoKxzEYOkXbsoy3oogQvd66tdxqsXP
         uqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmIwDwBunv1iXY1CWkBf2tvJHNbe7E2vkHcrA/hBf1HhYrc0ZrTi1/hlizS+VvXffWLWtmyDw+AnNE9I3JZPV1Ky2hX25ZP1EQMzhL
X-Gm-Message-State: AOJu0YzOPpYHGBM2BfX7TB+qhK6pGmujUUH0kuCDs8VzUxdfCn/YVRVP
	+G58crlh4HpySSJkD5luQDiDM0deE0WY+txzqYeyoNoNDHkRfaLRrRbXceiF+i4=
X-Google-Smtp-Source: AGHT+IHu0pX2u2R5/xFiOzLKYemPhVeotLvlqxwy6j4sGwaJJZl/b8VeAR1RK5E1ty/vAsGXsDt7hA==
X-Received: by 2002:a2e:bb91:0:b0:2d6:c001:d87 with SMTP id y17-20020a2ebb91000000b002d6c0010d87mr4816723lje.8.1712525562496;
        Sun, 07 Apr 2024 14:32:42 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id i2-20020a50fc02000000b0056e22be831dsm3267562edr.42.2024.04.07.14.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 14:32:41 -0700 (PDT)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Cooper Qu <cooper.qu@linux.alibaba.com>,
	Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
	Huang Tao <eric.huang@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/2] riscv: T-Head: Test availability bit before enabling MAE errata
Date: Sun,  7 Apr 2024 23:32:36 +0200
Message-ID: <20240407213236.2121592-3-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240407213236.2121592-1-christoph.muellner@vrull.eu>
References: <20240407213236.2121592-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

T-Head's memory attribute extension (XTheadMae) (non-compatible
equivalent of RVI's Svpbmt) is currently assumed for all T-Head harts.
However, QEMU recently decided to drop acceptance of guests that write
reserved bits in PTEs.
As XTheadMae uses reserved bits in PTEs and Linux applies the MAE errata
for all T-Head harts, this broke the Linux startup on QEMU emulations
of the C906 emulation.

This patch attempts to address this issue by testing the MAE-enable bit
in the th.sxstatus CSR. This CSR is available in HW and can be
emulated in QEMU.

This patch also makes the XTheadMae probing mechanism reliable, because
a test for the right combination of mvendorid, marchid, and mimpid
is not sufficient to enable MAE.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 arch/riscv/errata/thead/errata.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 6e7ee1f16bee..bf6a0a6318ee 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -19,6 +19,9 @@
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
 
+#define CSR_TH_SXSTATUS		0x5c0
+#define SXSTATUS_MAEE		_AC(0x200000, UL)
+
 static bool errata_probe_mae(unsigned int stage,
 			     unsigned long arch_id, unsigned long impid)
 {
@@ -28,11 +31,14 @@ static bool errata_probe_mae(unsigned int stage,
 	if (arch_id != 0 || impid != 0)
 		return false;
 
-	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT ||
-	    stage == RISCV_ALTERNATIVES_MODULE)
-		return true;
+	if (stage != RISCV_ALTERNATIVES_EARLY_BOOT &&
+	    stage != RISCV_ALTERNATIVES_MODULE)
+		return false;
 
-	return false;
+	if (!(csr_read(CSR_TH_SXSTATUS) & SXSTATUS_MAEE))
+		return false;
+
+	return true;
 }
 
 /*
-- 
2.44.0


