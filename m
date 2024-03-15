Return-Path: <linux-kernel+bounces-104076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA8D87C8A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4133B21EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50C13ADA;
	Fri, 15 Mar 2024 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XlcMPOtS"
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE3912E63;
	Fri, 15 Mar 2024 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481955; cv=none; b=SAfOdYPBWcZ77DxW8LEOJTIk5VWwWqpUveELVEj+shxyhSnBBnP49vEYGXJN1R6lqbGjP+v89YvfRciT+5P6BLbaWK/28Z0qZI/Cvdkpv0g/HEHcqDSPmY2uagJo0rA/lu8wGwi1mNvWQJt+wruerDgTrfwnHSrulQl/zoOXvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481955; c=relaxed/simple;
	bh=CiPT7Tebx6aLcsDUlO8+2vRvufZYRCatvwZilYy8IT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mg93ts0U+n17ZWgEuPUAEbpWHa23FcqHAEOTYhlo+bxUc9kGn51AiSdeGtBYK11hloFwXxpj80O1nfEt09PvKyHheB2h/A28IjY0w12AX6FVsfw45jk+uXYpk0dU6Nt2EzXWD6I+DuY/YasGFyu9VdzMMog+Dc4DpfvoBcvOxA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XlcMPOtS; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710481953; x=1742017953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CiPT7Tebx6aLcsDUlO8+2vRvufZYRCatvwZilYy8IT0=;
  b=XlcMPOtS7djygQ9t+cXmg2Bpe8rHuYcmwX8oqTH47/QrTJYKEKNlx+Ch
   6JHuAzk/t7NJYqFouil/6908dl6RslAtC/fmysozMVHEpwISc8Qi5H/3s
   VKBaKwIBhEh9ZZvSftFrqO3qCnrytnu+roEKJv50CIpi5aFND2xyGtSzc
   bib3m0bi0Uxx+U1xhiN258cbJUwZrx+nWXzOH/s90dWdJmSgP60lD8cq1
   k+7+6JJ+QjH9A3gkw30tPsMGFVp1FequAsD54qixIljrfH943/R01/8OO
   KFBbUTee9G/uUNqLID0lAa+x9QB2imiQ86QzCmV601XYlCNUCnfz6hJzV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="152221217"
X-IronPort-AV: E=Sophos;i="6.07,127,1708354800"; 
   d="scan'208";a="152221217"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 14:52:29 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6AF38141205;
	Fri, 15 Mar 2024 14:52:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9331BD9C43;
	Fri, 15 Mar 2024 14:52:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 31D4020097CFA;
	Fri, 15 Mar 2024 14:52:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 94B541A006C;
	Fri, 15 Mar 2024 13:52:25 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	b43-dev@lists.infradead.org
Subject: [PATCH v2 2/3] wifi: b43: Convert sprintf/snprintf to sysfs_emit
Date: Fri, 15 Mar 2024 13:52:10 +0800
Message-Id: <20240315055211.1347548-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240315055211.1347548-1-lizhijian@fujitsu.com>
References: <20240315055211.1347548-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28252.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28252.004
X-TMASE-Result: 10--3.135400-10.000000
X-TMASE-MatchedRID: NwgUWlK30I84ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSK0+leiJxLlf0swHSFcVJ6C+fNq7c31fg18a
	7/fBfKbtsH3yLH3eS2KM07FLsxDxnV/iiNsapK9v+xRIVoKNMvE3yuY9BGW8rugVDwZELU+uzXD
	BpgFAuCz3+8VUHHGqAepi+JVYshcq1UOlz1sLXchF4zyLyne+ATJDl9FKHbrkDBQ+XBh4YJeK5f
	hRxt1aAaqQjB20KvEp0R7kGywzHs4SasxSwyoX8Zj7E6vHnuNavOXyw2JYKUpsoi2XrUn/J8m+h
	zBStanuKNyKr3HDyRSdET58jp62Se1tzlfEsCEjf6Uj/7wqoheeV309kYPkCJqS9dJdH2q3RQR/
	GKLsybD7TTdZXIbZlE9X3mtYh1QrW0XXTT4K+7uG9IZU1A0HawGC8e6520fKw0PJt06oJaHpaQl
	5xviY7wxgWdRvK9Un9g+oMf9KM6Q==
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

CC: Larry Finger <Larry.Finger@lwfinger.net>
CC: Kalle Valo <kvalo@kernel.org>
CC: linux-wireless@vger.kernel.org
CC: b43-dev@lists.infradead.org
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
  subject updated and wrap line style

This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/net/wireless/broadcom/b43/sysfs.c       | 13 ++++---------
 drivers/net/wireless/broadcom/b43legacy/sysfs.c | 16 ++++++----------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/sysfs.c b/drivers/net/wireless/broadcom/b43/sysfs.c
index 0679d132968f..261b2b746a9c 100644
--- a/drivers/net/wireless/broadcom/b43/sysfs.c
+++ b/drivers/net/wireless/broadcom/b43/sysfs.c
@@ -53,19 +53,14 @@ static ssize_t b43_attr_interfmode_show(struct device *dev,
 
 	switch (wldev->phy.g->interfmode) {
 	case B43_INTERFMODE_NONE:
-		count =
-		    snprintf(buf, PAGE_SIZE,
-			     "0 (No Interference Mitigation)\n");
+		count = sysfs_emit(buf, "0 (No Interference Mitigation)\n");
 		break;
 	case B43_INTERFMODE_NONWLAN:
-		count =
-		    snprintf(buf, PAGE_SIZE,
-			     "1 (Non-WLAN Interference Mitigation)\n");
+		count = sysfs_emit(buf,
+				   "1 (Non-WLAN Interference Mitigation)\n");
 		break;
 	case B43_INTERFMODE_MANUALWLAN:
-		count =
-		    snprintf(buf, PAGE_SIZE,
-			     "2 (WLAN Interference Mitigation)\n");
+		count = sysfs_emit(buf, "2 (WLAN Interference Mitigation)\n");
 		break;
 	default:
 		B43_WARN_ON(1);
diff --git a/drivers/net/wireless/broadcom/b43legacy/sysfs.c b/drivers/net/wireless/broadcom/b43legacy/sysfs.c
index eec087ca30e6..d988fe541bf7 100644
--- a/drivers/net/wireless/broadcom/b43legacy/sysfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/sysfs.c
@@ -75,16 +75,14 @@ static ssize_t b43legacy_attr_interfmode_show(struct device *dev,
 
 	switch (wldev->phy.interfmode) {
 	case B43legacy_INTERFMODE_NONE:
-		count = snprintf(buf, PAGE_SIZE, "0 (No Interference"
-				 " Mitigation)\n");
+		count = sysfs_emit(buf, "0 (No Interference Mitigation)\n");
 		break;
 	case B43legacy_INTERFMODE_NONWLAN:
-		count = snprintf(buf, PAGE_SIZE, "1 (Non-WLAN Interference"
-				 " Mitigation)\n");
+		count = sysfs_emit(buf,
+				   "1 (Non-WLAN Interference Mitigation)\n");
 		break;
 	case B43legacy_INTERFMODE_MANUALWLAN:
-		count = snprintf(buf, PAGE_SIZE, "2 (WLAN Interference"
-				 " Mitigation)\n");
+		count = sysfs_emit(buf, "2 (WLAN Interference Mitigation)\n");
 		break;
 	default:
 		B43legacy_WARN_ON(1);
@@ -155,11 +153,9 @@ static ssize_t b43legacy_attr_preamble_show(struct device *dev,
 	mutex_lock(&wldev->wl->mutex);
 
 	if (wldev->short_preamble)
-		count = snprintf(buf, PAGE_SIZE, "1 (Short Preamble"
-				 " enabled)\n");
+		count = sysfs_emit(buf, "1 (Short Preamble enabled)\n");
 	else
-		count = snprintf(buf, PAGE_SIZE, "0 (Short Preamble"
-				 " disabled)\n");
+		count = sysfs_emit(buf, "0 (Short Preamble disabled)\n");
 
 	mutex_unlock(&wldev->wl->mutex);
 
-- 
2.29.2


