Return-Path: <linux-kernel+bounces-103092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF887BAE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1637281861
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C736DD0A;
	Thu, 14 Mar 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="pmYSFyXR"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D94316C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410664; cv=none; b=kqEViFLSCUpjtdZbc8zeXm7ZwLnTHD55OfVnVRmV3ztejlF5omgs8dNPwt1H5iA9ll9u18DkwqECeWErgxXkEvMH4eyyKXNIuAkh2WR/nrd+poTz1mXk+d6xZRxWt3/w5wswoXoVP5eiY4cli5ffyAXuvdmqLQxA+Ak9QR0LC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410664; c=relaxed/simple;
	bh=4i+sKuxlMF8pZDND7QTtUA9j1TU46pApBb3I3qXMLEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fwheddsog56OF4PvyasLQqER814MFGBGQO7hk+vkyQQw5UZdGTKLLuh74RByCvL+ouj1ZQAmErKLHKMzRjc/S8j8gazBaAkzXzhiG5eWdOBE7pOT3riDZwF2AgAn4ZeVmHps05uWWImbIEkJJHWbZLx/It8g4BrCbAjTrahWiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=pmYSFyXR; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710410662; x=1741946662;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4i+sKuxlMF8pZDND7QTtUA9j1TU46pApBb3I3qXMLEM=;
  b=pmYSFyXRzvh+esBcv6GIezEOpe7/YLvjpGU2c2eX/0A/Ui6JNwuGY/+M
   yWiv5g3EovLbCnX7N+7L1rSrfLwrmMQ1Jqux6994l6eWdVLMOsqOol2E1
   m/BqKx5NYZtv89zeXah2uq3g3KlwlL0cRX5fgYJqPfzCkjsURVld7TeFl
   Qpl+lhHLjoNd8cMLK/iXTRVbXj/E7TmwGBdzMbUbav2gg745vsG6mww/f
   W9N1DjdfFSfX3XJWjwmxCgXtJe5Omp0uaW3J+Yz/yi2MUZlO5kABJ1NgK
   4GKSEXJA1a/4E2HIrgNKolkERvtSQlXt02jWrvA6CrTj3tbnlbZOJNgte
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="139872652"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; 
   d="scan'208";a="139872652"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 19:04:19 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 757FBD4800
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:04:17 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6E333A2462
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:04:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id F02146B4D4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:04:15 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 451161A006B;
	Thu, 14 Mar 2024 18:04:15 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 1/2] clocksource: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 18:04:01 +0800
Message-Id: <20240314100402.1326582-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28250.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28250.006
X-TMASE-Result: 10--6.701400-10.000000
X-TMASE-MatchedRID: st9CF01730Y4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSIVybEvvop470swHSFcVJ6C99T+uJIleRfDo
	fTpsyCK+KztDhRgoFQW4suX2uLJTkj56IjTnLR+lO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BDIvl
	CZY6Ax8PdcQ4/ZOO0Rnagtny7ZPcQfE8yM4pjsD67rlQMPRoOCxEHRux+uk8h+ICquNi0WJJjgq
	BolfscaI4AjUPC9mC0GRcaW8ogMtd4gmUEv7qoxftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() will be converted as weel if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: John Stultz <jstultz@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index e5b260aa0e02..02abca6259b3 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1336,7 +1336,7 @@ static ssize_t current_clocksource_show(struct device *dev,
 	ssize_t count = 0;
 
 	mutex_lock(&clocksource_mutex);
-	count = snprintf(buf, PAGE_SIZE, "%s\n", curr_clocksource->name);
+	count = sysfs_emit(buf, "%s\n", curr_clocksource->name);
 	mutex_unlock(&clocksource_mutex);
 
 	return count;
-- 
2.29.2


