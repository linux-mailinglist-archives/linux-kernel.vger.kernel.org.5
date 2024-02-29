Return-Path: <linux-kernel+bounces-87711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9BF86D810
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBEFFB21E69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FE413E7DB;
	Thu, 29 Feb 2024 23:56:08 +0000 (UTC)
Received: from regular1-06.263.net (regular1-06.263.net [211.150.70.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4842A8C;
	Thu, 29 Feb 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.150.70.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250967; cv=none; b=OOaR+kDUXyqOSVApXxUqPUL0dM8k6r7i49kOtF5G23AvSUgISoUxy2W1/h1J45Eh6sdrqFM48OQxiXZJeY7LD/dYN2ifhHgaEcDJhLVyROdwoZR2/0+ZtkQP+5V4+RobyQZuhea65twVGnYRWssduuzCNmUwQnCgOf2jO75Kdag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250967; c=relaxed/simple;
	bh=XSZhwMr9M5XqRVovzbNIdrRe0Vzc/jVfQbtwR0xjlOo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BbkuxHE6QHUDNTR24sY/E1JBaO+Xgkgijz5cvKI2NkPrT/pHNhJg7AybbBelNRSBZqswM044pQ4tYyVUfDGr5mBGmGToLdDxTqNZYv6X9rHQYok8lHI7FDjeJQapkj5NfImfwRukzF4kufpe3eHC0QDqT2xa2PcPGiTBEmOB2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techyauld.com; spf=pass smtp.mailfrom=techyauld.com; arc=none smtp.client-ip=211.150.70.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techyauld.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techyauld.com
Received: from localhost (unknown [192.168.167.69])
	by regular1-06.263.net (Postfix) with ESMTP id F0FA31DAB;
	Fri,  1 Mar 2024 07:52:30 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-ADDR-CHECKED4:1
X-SKE-CHECKED:1
X-ABS-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost (unknown [118.193.106.122])
	by smtp.263.net (postfix) whith ESMTP id P20140T140685814527744S1709250750224016_;
	Fri, 01 Mar 2024 07:52:30 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:yzheng@techyauld.com
X-SENDER:yzheng@techyauld.com
X-LOGIN-NAME:yzheng@techyauld.com
X-FST-TO:rogerq@kernel.org
X-RCPT-COUNT:6
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:118.193.106.122
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<49e5b54e442e7c9fdccf77e484b484ff>
X-System-Flag:0
Date: Fri, 1 Mar 2024 07:52:30 +0800
From: "Brock.Zheng" <yzheng@techyauld.com>
To: Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memory: omap-gpmc: fixup wrongly hierarchy of the sub-devices
Message-ID: <6fftq2zlkpaf7xptyff6ky63cinr76ziyvdbm5jhj2apubr5vf@l4gvbdax3l2e>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On TI-AM335x£¬my FPGA under GPMC local-bus can not work on 6.x kernel.

GPMC <--> FPGA  <--> sub-devices....

I found that the platform sub-devices is in wrongly organized
hierarchy.  The grandchildren are now under the GPMC device
directly, not under it's father(FPGA).

Signed-off-by: Brock.Zheng <yzheng@techyauld.com>
---
 drivers/memory/omap-gpmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 80d038884207..1f2568e43086 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2175,6 +2175,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
	int ret, cs;
	u32 val;
	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
+	struct platform_device *child_pdev = NULL;
 
	if (of_property_read_u32(child, "reg", &cs) < 0) {
		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
@@ -2330,11 +2331,12 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 no_timings:
 
	/* create platform device, NULL on error or when disabled */
-	if (!of_platform_device_create(child, NULL, &pdev->dev))
+	child_pdev = of_platform_device_create(child, NULL, &pdev->dev);
+	if (!child_pdev)
		goto err_child_fail;
 
	/* create children and other common bus children */
-	if (of_platform_default_populate(child, NULL, &pdev->dev))
+	if (of_platform_default_populate(child, NULL, &child_pdev->dev))
		goto err_child_fail;
 
	return 0;
-- 
2.44.0



