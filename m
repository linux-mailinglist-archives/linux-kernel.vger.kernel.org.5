Return-Path: <linux-kernel+bounces-103072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1453E87BAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C431C282AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3728E6D1CE;
	Thu, 14 Mar 2024 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RGpn/l4j"
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A146D1A0;
	Thu, 14 Mar 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409722; cv=none; b=P+T1ebl8u+iI+27OUH2loYTsaYVdduhUEHOnw7koMhdhIgqIedHRowvavfGmZiHPVkacP0ba/Y2iQFtyj1apIRAlrzD2EPXd/g6uJXf9fHLw0ydc6S34JOYVMjTZ+YvSWIiKxadLNO5Rc7tI1lD0ZuBML/diah2BPQhU6N441FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409722; c=relaxed/simple;
	bh=aNmEog2e7xmpj4UDLTsQ+K1MuB1rI9s+eD06tjLRMfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CXsjbxEqyTjW2oYEgu0vyFOZGZUJXhi3mTbNZJc2cx0TqLCwW7Fx7YXwwBPdUzsxOzXJuMU/hTNR+pHrd2vSKYqxbpCzN535SP/67HtZJjnArK1yYp8o5GNpANwo4G87GYRcZLeczFT5VBk5SoxOSPnbqJ6Mqc7S5LFQkc0HZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RGpn/l4j; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710409720; x=1741945720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aNmEog2e7xmpj4UDLTsQ+K1MuB1rI9s+eD06tjLRMfM=;
  b=RGpn/l4jKxyM92UfJJ23uaV/80qZsATYb1qcIGYP4E6cP8uc2SXqGpf3
   DQNOMJiMVG6dXN9MfaBVTSUqxpfwyd/cmeU/rQry3LSaFGUoCr3niRURy
   C6i6n2u9eKRzJ0LJtdZJHbdtCJ6AJoRtVU1tJRb1oyrsJcxbw8YjIg2EA
   f3gEGuMVpUEDazh+USe/sLm4pYF7GvgK7PUgCWoFQ1w4FZVKdPZvJaKbG
   4oK7vPRsq7Or0w2yr2yvuyAsZqzrdhpRacDFHvUPipVEP4PyDo7nZpcBl
   wvWlKLM84CB9c9YHkrCAq8sFRklxRZEKsv0Y+oOKmSoFNpR9mmr1Hapuy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="151712701"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; 
   d="scan'208";a="151712701"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:48:37 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id B1986EB462;
	Thu, 14 Mar 2024 18:48:34 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id E84A9D419F;
	Thu, 14 Mar 2024 18:48:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 75CF36B4D8;
	Thu, 14 Mar 2024 18:48:33 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 08BFC1A006B;
	Thu, 14 Mar 2024 17:48:33 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] net: ti: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 17:48:23 +0800
Message-Id: <20240314094823.1324898-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240314094823.1324898-1-lizhijian@fujitsu.com>
References: <20240314094823.1324898-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--4.932400-10.000000
X-TMASE-MatchedRID: st9CF01730Y4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSrMZ+BqQt2Nps/NNpVQ666i99T+uJIleRfDo
	fTpsyCK+KztDhRgoFQW4suX2uLJTkj56IjTnLR+lO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BDIvl
	CZY6Ax8AYneqSlSIC/h8LfmnrF5JeR9GF2J2xqMxRFJJyf5BJe3QfwsVk0UbvqwGfCk7KUs0hlc
	16YSiR/TrcJt9otOEa3Fo76xroEK7XsH+W6Je0/aK8EHI8yZD5W/yxi3wLIHEm0J0NAcVpR87g3
	I2Wf9kB5XPFpvWR7wSHJp2UYVccqxOB8J0pRLhyJxKSZiwBX6QtRTXOqKmFVftwZ3X11IV0=
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

CC: Kalle Valo <kvalo@kernel.org>
CC: linux-wireless@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/net/wireless/ti/wlcore/sysfs.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sysfs.c b/drivers/net/wireless/ti/wlcore/sysfs.c
index f0c7e09b314d..376afa3388a4 100644
--- a/drivers/net/wireless/ti/wlcore/sysfs.c
+++ b/drivers/net/wireless/ti/wlcore/sysfs.c
@@ -19,11 +19,9 @@ static ssize_t bt_coex_state_show(struct device *dev,
 	struct wl1271 *wl = dev_get_drvdata(dev);
 	ssize_t len;
 
-	len = PAGE_SIZE;
-
 	mutex_lock(&wl->mutex);
-	len = snprintf(buf, len, "%d\n\n0 - off\n1 - on\n",
-		       wl->sg_enabled);
+	len = sysfs_emit(buf, "%d\n\n0 - off\n1 - on\n",
+			 wl->sg_enabled);
 	mutex_unlock(&wl->mutex);
 
 	return len;
@@ -78,13 +76,11 @@ static ssize_t hw_pg_ver_show(struct device *dev,
 	struct wl1271 *wl = dev_get_drvdata(dev);
 	ssize_t len;
 
-	len = PAGE_SIZE;
-
 	mutex_lock(&wl->mutex);
 	if (wl->hw_pg_ver >= 0)
-		len = snprintf(buf, len, "%d\n", wl->hw_pg_ver);
+		len = sysfs_emit(buf, "%d\n", wl->hw_pg_ver);
 	else
-		len = snprintf(buf, len, "n/a\n");
+		len = sysfs_emit(buf, "n/a\n");
 	mutex_unlock(&wl->mutex);
 
 	return len;
-- 
2.29.2


