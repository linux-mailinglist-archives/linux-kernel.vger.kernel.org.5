Return-Path: <linux-kernel+bounces-52925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78B5849E6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D941C1C23D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872E832C91;
	Mon,  5 Feb 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jaTCArOJ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2EB2E62D;
	Mon,  5 Feb 2024 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147314; cv=none; b=jFpiuEArImuR/kIJJEIoFpwuWZK6tMpVWzDRxCYJ7nsyb9YPUHKfN1SeWbmh1jWDb72UL0keiZTdDtI/J/2wta/1AEKunhDOxFFBLsmtDmj07Kst966m0prqoTycxOXmJm6zrP/RjrLbmEngo75lOu8jqBcxqKHlXk7HnImaR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147314; c=relaxed/simple;
	bh=seWFh23w7ydoCuw+og2PCLynYdrB+dpA0lmRDxMvm3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+ufpHMMxLfUXDMtjLHVMdnz+EIcVNhSonLxARZ6KcOsZJv/405zYkLRcCFIugSUNFktquUcKAD2L3PSA701jp9ayyZYdKkTTPdfhx34g7Qf6S6W8JnTAETV3lG1G7Rsj5IMIHd9w7QRv1TVpcNcsMPOuQGJHRXMMLzP+ja398Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jaTCArOJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD7A01C0015;
	Mon,  5 Feb 2024 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707147310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esfeCMI7Pwpjz+uzSpSUDXn4KCrjxw72sDAlH2LRRks=;
	b=jaTCArOJUbwNw5HiAKOEX5uVtZ1sgVDqqQhs8RvBNz+tZCAClENSE1h3tjRDLbU56lHleX
	yceVEgesS4BoNf7fPq7dx/2u/Y82/PjZ4IXxAptaKIWo9M50MdH13jjpgAN8mo7MD5JEkL
	L+En+wNaMur8UHAihFC9x8H43d4rXNhM2yl+tZ3MfTngZDvr7M3XLfqY6NKjeQRjkwJzMG
	pUDFAGIGjIiUgP4kqffMG29+BKhWahnt/dcE5twYsLDce7S+Dz7kJ8OeEHxHHAgLh8xPpH
	EMXLdmr7DSFGTPq3KWZi6Y8c5u8jFjfscSuv9M0iY14hMAP5VJiKybGv353VGQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v7 04/14] MIPS: traps: Give more explanations if ebase doesn't belong to KSEG0
Date: Mon,  5 Feb 2024 16:34:50 +0100
Message-ID: <20240205153503.574468-5-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205153503.574468-1-gregory.clement@bootlin.com>
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

With the expanded support for placing the kernel in XPHYS rather than
just KSEG0, scenarios where ebase doesn't belong to KSEG0 are more
likely to occur. In such cases, we currently experience a substantial
and perplexing stack dump without any accompanying explanation. To
rectify this, we aim to replace the uninformative stack dump with a
warning that offers a clear explanation of the issue.

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/kernel/traps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 355d0f0709de8..911d2233d6d0b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2347,10 +2347,13 @@ void __init trap_init(void)
 		 * EVA is special though as it allows segments to be rearranged
 		 * and to become uncached during cache error handling.
 		 */
-		if (!IS_ENABLED(CONFIG_EVA) && !WARN_ON(ebase_pa >= 0x20000000))
+		if (!IS_ENABLED(CONFIG_EVA) && ebase_pa < 0x20000000)
 			ebase = CKSEG0ADDR(ebase_pa);
 		else
 			ebase = (unsigned long)phys_to_virt(ebase_pa);
+		if (ebase_pa >= 0x20000000)
+			pr_warn("ebase(%pa) should better be in KSeg0",
+				&ebase_pa);
 	}
 
 	if (cpu_has_mmips) {
-- 
2.43.0


