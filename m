Return-Path: <linux-kernel+bounces-34022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B178371FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0577F1C2B0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B536557860;
	Mon, 22 Jan 2024 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="kWVsC4ZA"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA0D55C1C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949255; cv=none; b=Ai+ogtal02XFEn3LPmOertlQFtQ2JVA/j+l/Jn8s0JO4e9yki16snhaVa1hQGohDbKivOuo0xZgiHLwWcwXNZLf7oSILS8g+w6SVgl3p3eN3ReCle03bmgm0Nzb5b+/HBHlg/aeO9Z2yDldbJWUc9CB67K/9xNd7M6D0lNNmmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949255; c=relaxed/simple;
	bh=tjHCirRviu691Iq/+2VmbX+K0n9N3Wh5BIfiV11cvpU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=C5f8OlFLHxXCo2g2L4BXbL/KGatU2yECokpM8OknRfvIVKwHJhjIIQZdnR/1WbiexDe6UNSqaclk135Nq3nn9ZNgYy89s/Vk5pFtM393EGa8d2K66Q+rKV6rJsBySCej9co5PG5X0+ulEuhWb66ihoSTPtWZjfLZSUJVqQ7hAuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=kWVsC4ZA; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 13845 invoked from network); 22 Jan 2024 19:47:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1705949241; bh=CD8nft1vTI+i1RWT5qBpPo17pvQoCF+wFsIUA1FyrSM=;
          h=From:To:Subject;
          b=kWVsC4ZAV/Hqo6Pgj54d9GiY6ebPlOCLK1CXZ0Aby6sL2qdz/mF9sw3LbK+/RcSpB
           Sr2H4BnXRXjuFcY+1gLbthDlMDuQFA2/iwWHdBEoMvQ3Zf4O2ZjvytZGmhDHTvwlYA
           iMxN0x1yBKgqzS+hs2GoNNPp/zblfGfjTsHCyuSk=
Received: from 83.24.148.73.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.148.73])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <john@phrozen.org>; 22 Jan 2024 19:47:21 +0100
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: john@phrozen.org,
	tsbogend@alpha.franken.de,
	olek2@wp.pl,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: lantiq: register smp_ops on non-smp platforms
Date: Mon, 22 Jan 2024 19:47:09 +0100
Message-Id: <20240122184709.9625-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: a5644994fd3f850433b483831bffd5dc
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [4VPE]                               

Lantiq uses a common kernel config for devices with 24Kc and 34Kc cores.
The changes made previously to add support for interrupts on all cores
work on 24Kc platforms with SMP disabled and 34Kc platforms with SMP
enabled. This patch fixes boot issues on Danube (single core 24Kc) with
SMP enabled.

Fixes: 730320fd770d ("MIPS: lantiq: enable all hardware interrupts on second VPE")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 arch/mips/lantiq/prom.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index a3cf29365858..0c45767eacf6 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -108,10 +108,9 @@ void __init prom_init(void)
 	prom_init_cmdline();
 
 #if defined(CONFIG_MIPS_MT_SMP)
-	if (cpu_has_mipsmt) {
-		lantiq_smp_ops = vsmp_smp_ops;
+	lantiq_smp_ops = vsmp_smp_ops;
+	if (cpu_has_mipsmt)
 		lantiq_smp_ops.init_secondary = lantiq_init_secondary;
-		register_smp_ops(&lantiq_smp_ops);
-	}
+	register_smp_ops(&lantiq_smp_ops);
 #endif
 }
-- 
2.39.2


