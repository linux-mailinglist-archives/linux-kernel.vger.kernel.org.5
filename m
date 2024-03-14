Return-Path: <linux-kernel+bounces-103073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838B587BAAE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A750B1C21345
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FBB6DD1D;
	Thu, 14 Mar 2024 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="f/LWmyu/"
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC26CDDD;
	Thu, 14 Mar 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409722; cv=none; b=T/7UmOY+POrVSmFrvkLcKsUq2kRi14/s4n6MSN8zD3lcqZNxX0/8ORh5fQdKXfACEWaeGnmkibKVlpmEbjuZzKPsjbcHVwabtTDfrokDNwKPgrsIYhCaz3GWB/UzlffodZXKJ3Ncf19E8dCKvyiXneL/3+ySWzF62CyUTj/Tmtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409722; c=relaxed/simple;
	bh=PZgtY/QaJ5AhE+dkBjqtaceUwoWYOLgrPub9Z/ina2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OSTSswjoQzvTfEgItQd+clhSWjHkbjZ7G3272QtGPd/RN+kbGJy1cwR3rzUj/YPK9omn9pmJ32QIVROtZWe89gauMKXs8k3SXXFfRmEJumW4eWqMMcaWYd5F2t1MVaCgesaCoSQM28gzgFWklATzGDGqCpiQ6WM7U0i6FKQcU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=f/LWmyu/; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710409721; x=1741945721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PZgtY/QaJ5AhE+dkBjqtaceUwoWYOLgrPub9Z/ina2E=;
  b=f/LWmyu/jMVqMmQ2wzalMuL7nSmJStaBmLZw937j7xS3Z85K0+LUyDnB
   mEqwnCP2Lrw21aNbO28gnDO576ZYj9RhDfG6/8iHKxS9C7RJ/fzStQ8JY
   bHsgqRVHXpXJxBoQEHxUgMw05hkdP+6G+8HtAnQRYbrxUQspoImao7bDZ
   vHn6lOoZ1J7X41Zvza77lpXCDxS+uPKzBVB7YQLvsRK5tOTfbv1bI79nQ
   nmhGMKy1vygkmfi67FjfCR+zMimGWKgW0azhZnVgbTqDw6Mm8gukb9hgx
   F83aFwc4/dAuD6RAYEH8h/o35dtGDTOEkNuBIWYF30jjnEYJd2DHnrDiS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="152290022"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; 
   d="scan'208";a="152290022"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:48:37 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 78A1FD772F;
	Thu, 14 Mar 2024 18:48:34 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id B0A25174A21;
	Thu, 14 Mar 2024 18:48:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2DD026B4D5;
	Thu, 14 Mar 2024 18:48:33 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 9A2721A006D;
	Thu, 14 Mar 2024 17:48:32 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	b43-dev@lists.infradead.org
Subject: [PATCH 2/3] net: b43: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 17:48:22 +0800
Message-Id: <20240314094823.1324898-2-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--3.595400-10.000000
X-TMASE-MatchedRID: APZBv0eB5fI4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSK0+leiJxLlf0swHSFcVJ6C+fNq7c31fg18a
	7/fBfKbtruPzTKuxCyQhBeNJICtc+zK2lwdvrNt2qH6mIBejVf2ItZ2e1geixEd+K6O5Nt53oKE
	r2irJf5CL637QCIVpi8vc3EUpCmrXqPfCtn+QRF99JA2lmQRNUawh2/JNn5dCBAXl9LkPp6TVka
	xwyOBfMjXnWb/ze2xPSM4dqF2PUP5H0YXYnbGozFEUknJ/kEl7dB/CxWTRRu+rAZ8KTspSznMvX
	P7A/YmSt/dXFI10ySicpsJ0mlkgCkJl9QIQjSU5yWMufYVlI8jltvYxr5GgZXZ7ViAqHGNCl44l
	VuJH6NcYJykdVteYvIcmnZRhVxyrE4HwnSlEuHInEpJmLAFfpC1FNc6oqYVV+3BndfXUhXQ==
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
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/net/wireless/broadcom/b43/sysfs.c       | 13 ++++---------
 drivers/net/wireless/broadcom/b43legacy/sysfs.c | 17 +++++++----------
 2 files changed, 11 insertions(+), 19 deletions(-)

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
index eec087ca30e6..b1c5ea4750fa 100644
--- a/drivers/net/wireless/broadcom/b43legacy/sysfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/sysfs.c
@@ -75,16 +75,15 @@ static ssize_t b43legacy_attr_interfmode_show(struct device *dev,
 
 	switch (wldev->phy.interfmode) {
 	case B43legacy_INTERFMODE_NONE:
-		count = snprintf(buf, PAGE_SIZE, "0 (No Interference"
-				 " Mitigation)\n");
+		count = sysfs_emit(buf, "0 (No Interference" " Mitigation)\n");
 		break;
 	case B43legacy_INTERFMODE_NONWLAN:
-		count = snprintf(buf, PAGE_SIZE, "1 (Non-WLAN Interference"
-				 " Mitigation)\n");
+		count = sysfs_emit(buf, "1 (Non-WLAN Interference"
+				   " Mitigation)\n");
 		break;
 	case B43legacy_INTERFMODE_MANUALWLAN:
-		count = snprintf(buf, PAGE_SIZE, "2 (WLAN Interference"
-				 " Mitigation)\n");
+		count = sysfs_emit(buf, "2 (WLAN Interference"
+				   " Mitigation)\n");
 		break;
 	default:
 		B43legacy_WARN_ON(1);
@@ -155,11 +154,9 @@ static ssize_t b43legacy_attr_preamble_show(struct device *dev,
 	mutex_lock(&wldev->wl->mutex);
 
 	if (wldev->short_preamble)
-		count = snprintf(buf, PAGE_SIZE, "1 (Short Preamble"
-				 " enabled)\n");
+		count = sysfs_emit(buf, "1 (Short Preamble" " enabled)\n");
 	else
-		count = snprintf(buf, PAGE_SIZE, "0 (Short Preamble"
-				 " disabled)\n");
+		count = sysfs_emit(buf, "0 (Short Preamble" " disabled)\n");
 
 	mutex_unlock(&wldev->wl->mutex);
 
-- 
2.29.2


