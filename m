Return-Path: <linux-kernel+bounces-36314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A063839F42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6201C2030A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519644695;
	Wed, 24 Jan 2024 02:36:05 +0000 (UTC)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C184684
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063764; cv=none; b=X5IHe2GANvkymVRrT7Mb6UERavDcfKdYV0AjNW0Ib5t3+qH2xJGZ8ILCqLaaPlBOm4IkFQMMR/+HSn/jkU59rfWhZBO/pEThQ4TMUOj3s4thlVp/LYpJUTOb1vBNx8JrpqO72eE+L+SbpLdHw/TDs2R972Y/DrWkYkNsdlW9O4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063764; c=relaxed/simple;
	bh=KW/fcIteZZR8DqE6qok87YKIwpmPPx24ajCl/Eq6ccI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LiFhjTarz1rUcWtqZppTlP1zxv3+ObWyXLNPC9EmsR8lRxU2WAPwu7tsQYGetM2QBjhOesyULh4GIZEgzaPkdkecK4mYOk5X4b2jvQ04o2wmmg83NE8FYY+t93F42D9q/5gQFhz+r7TS6mrMNytYFc/JSFFAuKfgX58RDK6RuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="146552226"
X-IronPort-AV: E=Sophos;i="6.05,215,1701097200"; 
   d="scan'208";a="146552226"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 11:34:49 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6BB1ECA240
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:34:47 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5E710D5CC6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:34:46 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id EF1C72007911B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:34:45 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 51F441A006A;
	Wed, 24 Jan 2024 10:34:45 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] arch/arm/mm: Convert snprintf to sysfs_emit
Date: Wed, 24 Jan 2024 10:34:42 +0800
Message-Id: <20240124023442.105333-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28138.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28138.004
X-TMASE-Result: 10--10.112700-10.000000
X-TMASE-MatchedRID: st9CF01730Y4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckIP+
	YDa/Dhu9O3wTUW8jWH5M0AWQBBcXdg8rYO92b9NmzYK5U+QI3O5MVCcj56k8htWM2x6EZ/S99vr
	PTUDmrVhVLU87vVnq1eZtbVQsdt0o0ekSi+00U24ReM8i8p3vgEyQ5fRSh265p8OlUPvzGP3Ivl
	CZY6Ax8PdcQ4/ZOO0Rnagtny7ZPcQfE8yM4pjsD67rlQMPRoOCxEHRux+uk8h+ICquNi0WJO261
	rahe0eoSLldSTV5Pef2pn+LVzkfoezQKsahjBoIftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./arch/arm/mm/cache-l2x0-pmu.c:346:8-16: WARNING: please use sysfs_emit or sysfs_emit_at

This patch is generated by
make coccicheck MODE=patch COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Russell King <linux@armlinux.org.uk>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: extract patch from the patch set[1] so that maintainer can accept it separately.
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 arch/arm/mm/cache-l2x0-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefdc167a..a9bd05b82003 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -343,7 +343,7 @@ static ssize_t l2x0_pmu_event_show(struct device *dev,
 	struct l2x0_event_attribute *lattr;
 
 	lattr = container_of(attr, typeof(*lattr), attr);
-	return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
+	return sysfs_emit(buf, "config=0x%x\n", lattr->config);
 }
 
 static umode_t l2x0_pmu_event_attr_is_visible(struct kobject *kobj,
-- 
2.29.2


