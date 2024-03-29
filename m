Return-Path: <linux-kernel+bounces-124467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D361D89186E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC54284D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAA885947;
	Fri, 29 Mar 2024 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="hqx3W9cS"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC78563A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714464; cv=none; b=cHwKRBUTx8P1ZIr0L9IK1jOw+dn2Rm4obkBw49YTC+YJ+iZKqB7bHQDPWz00C9qJRgE36eWMtG71DCVkSW5D1cETfpj4wLln1iMME46AAW+zRSwoq69LiTQhnkVsT6xi7o1y2zMPcXxDo4OzHmtF9T5lNHw7X5hw189/wLDKgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714464; c=relaxed/simple;
	bh=20n3uphUu7vKFqpng/oqZ/ejxV9ouGyCtBea+LyOPc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGRAVIy1r4eC+nyJUv16mePVb4oEdTGFMMwYx8Dte5dNs4X3NVQb936T4zM0wPNewuLdFhFpFrSo8evKtFSrmnmBEwK5G8DBe2xOvh+kg1mad7DbCjCYAZqrvPtklKXUU8zYXmg2KfOo/1XINl8UT0/i6ZdMKQ2NGiWdu3rCxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=hqx3W9cS; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4e39f5030dso45770466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1711714461; x=1712319261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MM8DGBGw5Z9hjdKjyp48iivo0mpxEJEAegbnu14CeWE=;
        b=hqx3W9cSGP/y1v3+injAm41/pAWWTLnOftSq+iWYTZR5uU7TBzG2QzrzZHf0je/EDh
         iRlfsXyQlHSRYES2c4jhO9XQChfxx2H6MWDwWH1qNT9NJ4snrvgJ8KDnxkSesPsh56Vu
         wD5zLxT8Uo5gZrFqSycqWe6gA8A9n+SyKnU3/rRlBM0RDqAZ3bixv2m7cYaKGV8dpeou
         8edCnqEcNUHI4JeFQSHZYvVDy9k4TDbrld7dxJGGFtRnzFCPA4uQKyXuCr76C8YCE6vn
         rbu4cv4RE7vRSYM2yyHj8XMYB/GZPdy24UI9/PUCukrivxtiJ/KxdHuvtZGiX8mCjUJZ
         C7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711714461; x=1712319261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MM8DGBGw5Z9hjdKjyp48iivo0mpxEJEAegbnu14CeWE=;
        b=BAAzzzDJrutFOxklKvwBkHZnDV9pvFDzwU6gSmpR8V05F8wAKDKL6qo5BHWvWB/7aT
         hji0FYHF8tmC571Iv7E7d870h/9Gog6svuhErpAbr3+ASr5fiiR3pZyNb+VySS5Q+E2z
         z7CBjY64VRaFvLOQs/e0D7EjgXRIvybksNNXs4AAGkfMKbdW+m4nlgzPKsK7xNzaXBb7
         1k9EcX7i7J6qsVIkOwHUFbPTt6i0DBQeAnuezJX2aZ4escyaiWkrNSqDAe1lKPMJoE0i
         YHQQXOtzcI911d8D6cf+bgqIqRE13y21yT73w94gmR+sHgZjGZOZLdYx1Z3RGzFVudFp
         MNxA==
X-Forwarded-Encrypted: i=1; AJvYcCUxb5k951OD3m9lH1QoMa01Ij1n8Geqii9kQ5iIFSf0cqj6BE/kLZT1E/LdXQSsi6xqMPXZAOOFQFP6pEuuoJLimk7VZJju4TOe1HCT
X-Gm-Message-State: AOJu0YxGbIvrjr6r9+6A6fDTh6Ocn/hINvub9pvhQBm6sEqg/MOd1Qxu
	p5TqLm2sTFsB2Q7VfkNsVjQ3MsWjT4VcxH76tRsh5m1cu8y8kawR4/z2jPmI/Xg=
X-Google-Smtp-Source: AGHT+IGjk+7FS0PQw7yadwU7Pio5rAktvOsGQmrrPhehd2eEKH/hcBBSiPPq+/a13+sXkfYmw13KxA==
X-Received: by 2002:a17:907:703:b0:a4e:3892:1d0b with SMTP id xb3-20020a170907070300b00a4e38921d0bmr1240083ejb.27.1711714461012;
        Fri, 29 Mar 2024 05:14:21 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b00a46dd1f7dc1sm1869942ejo.92.2024.03.29.05.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 05:14:20 -0700 (PDT)
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
	Alexandre Ghiti <alex@ghiti.fr>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH v2 2/2] riscv: T-Head: Test availability bit before enabling MAEE errata
Date: Fri, 29 Mar 2024 13:14:14 +0100
Message-ID: <20240329121414.688391-3-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329121414.688391-1-christoph.muellner@vrull.eu>
References: <20240329121414.688391-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

T-Head's MAEE mechanism (non-compatible equivalent of RVI's Svpbmt)
is currently assumed for all T-Head harts. However, QEMU recently
decided to drop acceptance of guests that write reserved bits in PTEs.
As MAEE uses reserved bits in PTEs and Linux applies the MAEE errata
for all T-Head harts, this broke the Linux startup on QEMU emulations
of the C906 emulation.

This patch attempts to address this issue by testing the MAEE bit
in the th.sxstatus CSR. This CSR is available in HW and can be
emulated in QEMU.

This patch also makes the MAEE probing mechanism reliable, because
a test for the right combination of mvendorid, marchid, and mimpid
is not sufficient to enable MAEE.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 arch/riscv/errata/thead/errata.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 8c8a8a4b0421..dfa007039208 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -19,6 +19,9 @@
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
 
+#define CSR_TH_SXSTATUS		0x5c0
+#define SXSTATUS_MAEE		_AC(0x200000, UL)
+
 static bool errata_probe_maee(unsigned int stage,
 			      unsigned long arch_id, unsigned long impid)
 {
@@ -28,11 +31,14 @@ static bool errata_probe_maee(unsigned int stage,
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


