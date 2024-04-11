Return-Path: <linux-kernel+bounces-141706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1926D8A2234
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296581C22C91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094D647F64;
	Thu, 11 Apr 2024 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="amFCXyaU"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844584AED1;
	Thu, 11 Apr 2024 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877560; cv=none; b=NTOaNRr5R6WYaIiWauFv9EMDINRk2Hrte6BsAe4NA3d6G59LjTHaWE78eBsZ9SDN58/rXMS/5lFJrIA/fCZgxr0jTzIgrPKeNRKvtv6UEZ/ydompn7/7eojsnVHOn4NNX9sYeCbmcCy1Zi5/As1PsLVDjFKmmvaQdCuN6f7/V+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877560; c=relaxed/simple;
	bh=aNmoCty2E2taxbJGZXgC0zkBJXRsGV5eZ6MA4fcTBgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p9nZgl3cDmnOJEfT0RjjCheF9oPAS1WjqAvn2UbITGa1jlJg/KNddZS0Uy1MEI9Om8cnoPRHF27OHYjbT0dhyw5GfuxwNKMXHL4GKg0TXJC5QymbSlxRORqIskVDkbqrqTNjKjLnCKzJvbsqkqYyWc2Tv0N0NoODY4z9ivqjYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=amFCXyaU; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=c5Pzo
	m9ggE+lnrPwITXXUuzreNabMc9C3d5zN36J6+c=; b=amFCXyaUffXBkkMLeLToV
	JsIFN/Qm4MymU9dGml6IAyca4lHTkUtHFbzhsGjv1wSWHmjoQbGkRdQhdfN2L2J9
	uHNOntu12Fg3/vXXR8spzqbXE2tNbH4Xkjfi0r3/B+sF+/pkRxre47zBbsiEWH75
	AM+fIY9fJOOryPQUIJv234=
Received: from localhost.localdomain (unknown [101.86.127.38])
	by gzga-smtp-mta-g3-3 (Coremail) with SMTP id _____wD3H47CbxhmuzOoAA--.32437S4;
	Fri, 12 Apr 2024 07:18:51 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lizhe <sensor1010@163.com>
Subject: [PATCH] cpufreq: Fixed kernel crash caused by cpufreq issues
Date: Thu, 11 Apr 2024 16:18:18 -0700
Message-Id: <20240411231818.2471-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H47CbxhmuzOoAA--.32437S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1UAr1xWw1fKr4rJrW3trb_yoW3Crg_ur
	1rWr1xXr4Duw10vF17Cr4Svr1Yy3W3WrnavF18t39xJa4UAr9Yyw18Xrn3Xa4rX3yxGFZr
	XrWUtF1UCr1kGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRXyCLJUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiSBy9q2XAk244cQAAsT

When the cpufreq_driver does not provide an exit() function.
cpufreq offline operations can result in a kernel crash.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 04d349372de3..e8660bc7d232 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1739,7 +1739,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	}
 
 	/* We did light-weight exit earlier, do full tear down now */
-	if (cpufreq_driver->offline)
+	if (cpufreq_driver->offline && cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
 	up_write(&policy->rwsem);
-- 
2.25.1


