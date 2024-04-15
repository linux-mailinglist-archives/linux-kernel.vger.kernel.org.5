Return-Path: <linux-kernel+bounces-144509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574F88A473B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015431F22104
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121D91BF37;
	Mon, 15 Apr 2024 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PdLRgOU2"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFEAFC11;
	Mon, 15 Apr 2024 03:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713150919; cv=none; b=Ph+hOeEF/eQtBvCA43A44ePSStCvlsOnSLTFT4szAxf6UpcP5kHECBZHiY6o7xxGWTFJvDUv0jJKLgN0nmfz4XxHX2nlH6zavdN2qwNDgPdHWB4Ptk3YJ9mZdiiDxf2228A2KvESiUXJL/DcpS0ppdLTlotc9//1dMo00hfGgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713150919; c=relaxed/simple;
	bh=6A7i4BKRV2K8Hd11uqRXyWyCGbULTN3pcRLg5UbO2uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GQSI5gRxavPUGzqjfLl06aJwZexPWDG/IyIQaGT3BqIwUY8pNbYfxWcZ/f+CP5OwECfsQ9kWpfdV3inAEXO4sbth2lPtEVpIIy6BYoiA/qj0NlwliEXyaggUIGnrbUYW7StDKfsAgtqHmEuQLGlp9JrsiQ5lG0nvfjKia93moMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PdLRgOU2; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713150906; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kvKRBi2vy5d2TynLGK7fF4gLw2elcxxi2l75ttZ5EPg=;
	b=PdLRgOU2BuywBkTbV4ej+/8d8z1AJIl8sJVLlcSN+LAspi4Ch555ZADuC1sFRxHNG67LPBADscSPoy0rHp/I1ROaNGeEpVN/a2limmVMVk4GhrJTtu4NcR5p3WTAAknB3phSm5gEAqU02cy8vMtRaQekDOzcSKeKyX+IYjUFn8M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4UB1AB_1713150898;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4UB1AB_1713150898)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 11:15:06 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: elder@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] net: ipa: Remove unnecessary print function dev_err()
Date: Mon, 15 Apr 2024 11:14:56 +0800
Message-Id: <20240415031456.10805-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The print function dev_err() is redundant because
platform_get_irq_byname() already prints an error.

/drivers/net/ipa/ipa_interrupt.c:300:2-9: line 300 is redundant because platform_get_irq() already prints an error.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8756
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/ipa/ipa_interrupt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index c3e8784d51d9..c44ec05f71e6 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -291,16 +291,12 @@ void ipa_interrupt_deconfig(struct ipa *ipa)
 /* Initialize the IPA interrupt structure */
 struct ipa_interrupt *ipa_interrupt_init(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct ipa_interrupt *interrupt;
 	int irq;
 
 	irq = platform_get_irq_byname(pdev, "ipa");
-	if (irq <= 0) {
-		dev_err(dev, "DT error %d getting \"ipa\" IRQ property\n", irq);
-
+	if (irq <= 0)
 		return ERR_PTR(irq ? : -EINVAL);
-	}
 
 	interrupt = kzalloc(sizeof(*interrupt), GFP_KERNEL);
 	if (!interrupt)
-- 
2.20.1.7.g153144c


