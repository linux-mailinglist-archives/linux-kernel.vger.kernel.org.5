Return-Path: <linux-kernel+bounces-31806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4948334DF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D55B21FB7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194EDFBE5;
	Sat, 20 Jan 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="NMAQ8/he"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2FDDA7;
	Sat, 20 Jan 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705758889; cv=none; b=GFhKKQsX+CtESqcGENuXC8lKMpeisxhJ+fI9JPYUoj2rxrvnR+BxbDZwes/I9G+OknQi2i/wFLxdRQKFADxw7RnwlhC7GGheEHaqrRTeXgpyVhilazAQqKF0ikp3z11CnLnrvxxK/SKkTFQrXKMae6k9ynA01iQeAC/KnUbfYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705758889; c=relaxed/simple;
	bh=sb6+RW/YLIs0NzptG579OSujb6BOPGBFSGWE+7kOOos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SS81DIbfYEAF4daDT8FTtVxcGMv6ZuIQtO4AbUh2vNj8M0Dk2lCBS5s4gPiUx8onM/8D6Jm31H4Kb/87ej1mRQa1hdcu9/xtZV3amXFvWP2rTgPU6kCy4tZr7jItmmiCPgycJf9BdsAUrwkC1U/TC+etO2c7xRUpWkQysu1DrLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=NMAQ8/he; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705758853; x=1706363653; i=erick.archer@gmx.com;
	bh=sb6+RW/YLIs0NzptG579OSujb6BOPGBFSGWE+7kOOos=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=NMAQ8/heKh2oHIoXl4qZXWLKYBcbUnrMHHYlBsHZe8A0WpJybyNVO/7xZynYxzU8
	 uS6aEx/UsScf7dn2SxS2cI9PTevN98Ss2pE023XnczRcipndN3yRd3f/RtIRuXup9
	 7AzW6SL1fCC/u4L7zdC/ZwEfKinnyi+pP4S73BTHoNEb7+Up+pgYyCIp82jrclmSS
	 ryZykkOJk/GcbJBPCxL3nVcEdygm/2adjJwfbP7TXpPs0/WBdbMNZNWleUC1GVSTy
	 eCTGPjgHSlMMws0QJGtIkzMFYwr5iYsXzobNOVA/IPzmVHcdB0rI5+ycdMtYDD8Bn
	 ZYg47Ek+kPVwLIOMgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N2V0H-1qyi672owh-013zTZ; Sat, 20 Jan 2024 14:54:12 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] riscv: Use kcalloc() instead of kzalloc()
Date: Sat, 20 Jan 2024 14:54:00 +0100
Message-Id: <20240120135400.4710-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F/INeGDiLTwJQvGhuOW0o1CH6INUohueeE9N+/dCf5bIjyxbYfu
 CeKgye7vZan3mCPuDg4xacW4kqh6xENZOPOdooyEEgfdFsfCRONp+p9sR15D68FpKV5xuVD
 T7NEwUDtJ/ap/xuTqwk6A9C5SJkTqHamVWdpJdpTD+0FYaKb8JpjFsJEBe/fwsdevGijsEo
 8SmrvAbOn7d/l328zVJ/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fwiyfGqDDDw=;qTRILBi3BkuJswYxQoUGatLIBaa
 vp8HGbRtvstX9X/BAvQBntItanH2FvgPOU+9d37r6FvA3PTjduk6hV4oW6bRVw8UFrrPWsUFJ
 fL9eOZvYSptF79/YR5D/v4eaeMhQfN7/GaU9Y+1pBbgZX7JjhpbtbwhohXEiMOxA1LK4Daslx
 +sLOR8IkA8qs+FzI8h89rISqogFpiqEeuUfKbm1p2aRU73CAAiEJ4yNCex0M9VzIPko6QOGWS
 lrHrDRriVvC0TdbMLQUMxR/daJ89S5vzhwqm6iz3t67k7q35Orh+M7zvfpvwRDUnnk9YwIZeb
 pxrJpYW4koW7S/Mr30NQ7LmnYqeC+8QcUdPeKHT/cEUeT7hLo8Y29VzHuGI9S75sabLmPzPqD
 SkSrUE+b8RqLgH7HVOoJ+6iyoqYRKLosZcUPu31LIToQJYVZiP1CAXWDlfeFO4wIyRFh/bxyZ
 4aXFGHZ04Nk+AZGjpKZqLE7GbRwY8EnvZVCQEDdEeRRA41ELzB3dNOCGv4IRk7t2XxjUAbkEl
 aEwckBa8ogjTRLwnZawMicL5Hy2R/497InZYRT9awexEddPNW3x6zPpgdOhadfx6KhOB8hhrP
 5qG2helCVJVd0qtASpJpY2LjJJAgI9Ju7Rl3Mu/JQsguufdJ/ZFHeuycu473Lwb96l7uRd7hi
 8QTwrTITgd6EEp38YgPWEr9vz7zz0TKWnEh9si+owfRGQx1lJREwaywAi2BF1IoomNYVHgULz
 a5oE8QkLPFsaXySd2oO/Zwv2kULDciEPVmjIRI7wz/8rsreu2utLG2Kxc1ChBdSepxB4C0xxz
 hx3a0AtjG+2tWgiAo9qZI+2WHk214z1B0EKCO6K+n4c2cCNYufPu0j+77R9UvXw3p1kHQIozH
 cQfGshpZJ2+Sjh2ElPD7/SQa9lFHTIIuoigUlw/kf6kqbekdq8cNJSJSCYcajltkq0r4KP+0N
 rWGF648w7jlAbENNtwYtidGcJOk=

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc() function instead of the argument
count * size in the kzalloc() function.

Also, it is preferred to use sizeof(*pointer) instead of sizeof(type)
due to the type of the variable can change and one needs not change the
former (unlike the latter).

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 arch/riscv/kernel/cpufeature.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature=
c
index 89920f84d0a3..549a76e34c4e 100644
=2D-- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -901,8 +901,7 @@ static int check_unaligned_access_all_cpus(void)
 {
 	unsigned int cpu;
 	unsigned int cpu_count =3D num_possible_cpus();
-	struct page **bufs =3D kzalloc(cpu_count * sizeof(struct page *),
-				     GFP_KERNEL);
+	struct page **bufs =3D kcalloc(cpu_count, sizeof(*bufs), GFP_KERNEL);

 	if (!bufs) {
 		pr_warn("Allocation failure, not measuring misaligned performance\n");
=2D-
2.25.1


