Return-Path: <linux-kernel+bounces-103029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829C387BA1E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F356284E32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185136CDAD;
	Thu, 14 Mar 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="lWDZU7oM"
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4577383B8;
	Thu, 14 Mar 2024 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407649; cv=none; b=cYuiAg+UK7AZ6RQanMfUNK30XUkhYjdEIlDwkD4bZdk201Za523eVooiWHfit6Nrv5zSayCXhNeIC60rER1jpYU74JRrJ8Kfuc6Yo2HJ6ttClx7NrVmgs3zRCxF1RGTa5DsGt5sGM0aNPcBOd6x2tG9kK2C6iQWOHSlsYlp+8pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407649; c=relaxed/simple;
	bh=MkPxD/mSb3e/nL1gcdizoWHAielr1Hx/WkR9sTx6OOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FIUzCAi8XlaiC7w+CGnjzTY3YZ9fEEkh02sME9uFnTX+oUk+CKfLsLa1vbp3x5Qye0FSyhz5AIyeVea6qt/7V6ogI66dPSs0SeXbes+awlGsc7HDMluuc1pTFMSwLBVKjU+HSYHYsYW1yKGDpO1QOPWNUK5D2unjKm6qSzli0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=lWDZU7oM; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710407647; x=1741943647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MkPxD/mSb3e/nL1gcdizoWHAielr1Hx/WkR9sTx6OOQ=;
  b=lWDZU7oMi99vwuuS6f6jMqw9xcfTz33hNjgD6/fW45caYLrbEk/s/Ft6
   4Lks+FC5TEGaq17RWCrVpTVn8fmAflCp3MuvyuF0kxE4dmD5ifiAWNBih
   QldsvLyrClmyRs8xMlc7T2aHyEOEEAwU/Aw+yOH2mWzmiN6ewOV1VDY/6
   7ejRoAFt0kcuACicLvgy5gJCzdoxhTjQNnOhWkzwdC9SbYyP12D+RH5Z5
   egzZBgDRPfHB3IabnZ8cKKvLfUG0T43MMugqxhxC+zdU3+CKwc5Iyz5PV
   8ucfVdj9ueOa3yzbDeaTCnPOMQoFMPDdQ9f5Wjo8g6JHgWn33DzHDC/ue
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="131621572"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="131621572"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:14:04 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id F00E5D4800;
	Thu, 14 Mar 2024 18:14:01 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 29753C19D7;
	Thu, 14 Mar 2024 18:14:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id BF6996B4C5;
	Thu, 14 Mar 2024 18:14:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4456D1A006B;
	Thu, 14 Mar 2024 17:14:00 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Subject: [PATCH] media: imon: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 17:13:57 +0800
Message-Id: <20240314091357.1323543-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--8.539700-10.000000
X-TMASE-MatchedRID: 84oovQVhL8E4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSfc0UG4EkZrGIkRP7M27eX2O0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSD3F
	7iC1Qm2oHA6IBd3vQsXVJYHPH571zy7SCinQLRVHaNJ/iTxXCafS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTtD12T7q2dIUu6sDUxK6Er+o+9qtuJlxp/NljbRoOK+isrHwmcFXVg/g==
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

CC: Sean Young <sean@mess.org>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: linux-media@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/media/rc/imon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 5719dda6e0f0..0b55314a8082 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -845,13 +845,13 @@ static ssize_t imon_clock_show(struct device *d,
 	mutex_lock(&ictx->lock);
 
 	if (!ictx->display_supported) {
-		len = snprintf(buf, PAGE_SIZE, "Not supported.");
+		len = sysfs_emit(buf, "Not supported.");
 	} else {
-		len = snprintf(buf, PAGE_SIZE,
-			"To set the clock on your iMON display:\n"
-			"# date \"+%%y %%m %%d %%w %%H %%M %%S\" > imon_clock\n"
-			"%s", ictx->display_isopen ?
-			"\nNOTE: imon device must be closed\n" : "");
+		len = sysfs_emit(buf,
+				 "To set the clock on your iMON display:\n"
+				 "# date \"+%%y %%m %%d %%w %%H %%M %%S\" > imon_clock\n"
+				 "%s", ictx->display_isopen ?
+				 "\nNOTE: imon device must be closed\n" : "");
 	}
 
 	mutex_unlock(&ictx->lock);
-- 
2.29.2


