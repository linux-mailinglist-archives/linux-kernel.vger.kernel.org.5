Return-Path: <linux-kernel+bounces-32074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A90483560D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E12B1F22DCF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F7374C2;
	Sun, 21 Jan 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="NTxkNRpr"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528383C26;
	Sun, 21 Jan 2024 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847424; cv=none; b=kYFUMDa9aFQre6xS9uJvN5CU7fQ0gfXFyl/Oxnj82rNjeKAHgcFL4E3/XtRkH7GDt+cRvykx4e3D67tHRm0/F9k8Njsw1p9uiAM28d7pJxI+g1fM6TKKBqAndAbq8ktq5BYe4s1556EZGRSS4isLb2BB4QUCDblKaWN0U5AZQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847424; c=relaxed/simple;
	bh=ROOPfL0J6ngi897r/UdZbHSKZB2DdN3Hw5gHQ/zsnqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K57wmqb5iGA8jstEQiMEH7zNXeS5hNpTqOby9/+1b2CzmaGmTH9joUYIXQ5WMpGUEPgVksTBBvGb6/0E8wjg3Qqp5ykgszF8cPVI8Zb4fD+ieCMF2VeQfCpSBi9iXDGRcMforHr+xMBIq7IGsyecv0SBz1clPHEQ56BEDdkwSKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=NTxkNRpr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705847402; x=1706452202; i=erick.archer@gmx.com;
	bh=ROOPfL0J6ngi897r/UdZbHSKZB2DdN3Hw5gHQ/zsnqE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=NTxkNRprs2SBv/OSvlLRcN69DfsYjo/5fl2lc1vznHqj5JbsAqtQI6LeYBEdaEjo
	 b3s0bjvWLlXV2LY0qHXdY2xCHYOrSpEpj0VTqt36w7OWua9yyNBfVhLkpNTMg6VIC
	 bWNaYzSoeHO5QeMf19NgHU8W5ttlPTkylPcNh9Qc6zbkdOV70SrBFOQCoECNzKqMT
	 MP1dkSXLZ0ab7GYWe9xqSlFYXsThbWldkl5FfETm7sw35wCkp/QZdWup/IDr3lmCn
	 VOLU/+Fub9+6oNZPEkVLT8lCNcSsnDg8T2kGfvKyla7qny/iLmYP1E5dSVdLZ6wM/
	 Mt0E28iB6Q1hs1uA3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MPGW7-1rk4E03T8H-00PcNY; Sun, 21 Jan 2024 15:30:02 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Nick Alcock <nick.alcock@oracle.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] clk: hisilicon: Use devm_kcalloc() instead of devm_kzalloc()
Date: Sun, 21 Jan 2024 15:29:46 +0100
Message-Id: <20240121142946.2796-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mkG9QVQaqmmilRWlxaI8ilR/37NfHtuvfZE2ItkuEK0LrE0cxTc
 fe2/xScnOEf62uIBHC1DDmUsK6fnhtUjCZMRB5g0E55awQFef6PfB4QHbU/zPqQfBSOXpHK
 nho0C1EXxCkWac3hDUKh8KgD0+iaNEa3V6egzZLKIlOaWpYYITln9MPi4fHOswCCgKDtZam
 6+DVISAH1W5JatXHyY5qQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+sTATPOEqmI=;uvPCLLHlmcGb+V5VSuymptM8i7/
 kYERBUseMuCyPa/4QDzhT8zZAw1IIxtBWfnlf9kErYqEhOi8qzoPJm3S5VFqVZkS5ROUikq73
 +xiqeYQLzQQigXgmRVHzk8iAaie7Ov5fKZjQWa17sI/p+SKyt5uLPGnszBBZNdcKo1iRHiRX7
 j2pqrdNlvxIU2MfkkTBwwNYbkb7gjaGPw4rqYUd62TGZfqPfQdJU3S27MuzbK2QtW2qqk2gsF
 flYGfG2P/RfnJQJWbXTS4lVX1IGQ2Z2IUcbkdDUhwKUGgV6HR8V0QbudpFmUzDHY+kG9GN484
 usEZh/i+zvloXy/KaCelyX4xTg1lXXcsb4N8cwnLamvHUW0XQvStIwZhvtnnaBuGqonjxvcze
 YkvlmXkKkHLwVYX2yyQdRXCLn/+Z9bvqXGDWXlYfqa4DHOJBV8DBzWiScbppnCDiQqHXLkg3F
 bKeVjDmisoNESxmIO3Z55maiCY/C9JdhV2rJFdv/Z/33Wzqoeyf5sFxikCqApc1Wp/aujjLns
 5FGYMMKzVp7IHo0mCcs3wTHYJBLyry8iHg018a450PJmQ+T8rd/VbnEf9ODIneGY26eSfyYEk
 hssiFn05anjoM0NdmWwfdEgXgB41dymEjj4rpT98xltvR13uMMoaGBB4+tqDZ74v69zV+OhU3
 vvMott3tGS4AqLLFMBIPunYVV7K0kYaRVQAjGmPMPiFcj8t/GLiL4+PYmejHKXQZyzRbLA5Rk
 m8aKDawhVbMV00umLD9WRC8VfDr8jIr84YRAMytEy1YMiUPs0/8lL07iLjpOUXxpa0vAdgo8j
 UUAtzAj2WAj9srWtidyYUZB+/BwneICMhEjDMgr+UDWK9TILIkHdV2sW0Z629lhoz2qAGP3sZ
 zUd654IjDMWB9JN48Cj6ECFE4v1wCvQNIBbd4b8hxYIAwqKkBiF6mKMzwYt8i2sVMb73EbI8v
 7AAXy7/SgclrU4szShvSCOZCWhw=

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific devm_kcalloc() function instead of the
argument size * count in the devm_kzalloc() function.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/clk/hisilicon/clk-hi3559a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/c=
lk-hi3559a.c
index ff4ca0edce06..da476f940326 100644
=2D-- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -461,8 +461,7 @@ static void hisi_clk_register_pll(struct hi3559av100_p=
ll_clock *clks,
 	struct clk_init_data init;
 	int i;

-	p_clk =3D devm_kzalloc(dev, sizeof(*p_clk) * nums, GFP_KERNEL);
-
+	p_clk =3D devm_kcalloc(dev, nums, sizeof(*p_clk), GFP_KERNEL);
 	if (!p_clk)
 		return;

=2D-
2.25.1


