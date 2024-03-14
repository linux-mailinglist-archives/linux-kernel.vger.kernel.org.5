Return-Path: <linux-kernel+bounces-103005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F3487B9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A6AB241F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6606E2AA;
	Thu, 14 Mar 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="d35bTzx4"
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AA96D1AB;
	Thu, 14 Mar 2024 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406114; cv=none; b=Tt8YdwW91zAQ+Fh6rN4pyP5w4FX0Y0CEA9VCvDPweNABDxfOkcXzwpruZlq496kqbHOK3N5COXq7gX4UCx7PELJrVba2eNSp1F/DUVmEf3V9fkfhPRjWpVzloE0zdhRjBtJxBYmZaoCKEB9Z41nqLa7mzqpTIg7ZPF4uT8S45lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406114; c=relaxed/simple;
	bh=Q8vZNZC7ofuZAu0PIrN0hz11gIxu5fpg4mhQ4e0WIDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qnrWUILmh7gw0xjE/wcdGvXnvIdlcXmOCHXH2LaIrn7dr3BxIf35xyTvbU8PrLtW0faCicV76+UoFHNfN4oS0i76SpjKPHvYKOLEH7wB6HiFgBKc6PrtaN+xqirb0TXcKDxFQ9JsC+P6YiI39LwkbDyUJ/1+VQ64KLXnSrm6VRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=d35bTzx4; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710406112; x=1741942112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q8vZNZC7ofuZAu0PIrN0hz11gIxu5fpg4mhQ4e0WIDE=;
  b=d35bTzx46eRdFKYgnWHuv48WgFdxJ+buJPbOfcEXuc43RF+5aTLxINyW
   zNOYk39t7il4Xvig1RxrIElLQxKyJ337S4cJzlpriNhm4OpMQnbhTaxc1
   Z0TMMlSt/PEnJ1TS4a8auBgmUB0g+dbqtYrGcHtpqZieaxM2qTFGEg3FJ
   iW+T3agk+v11mq3TFpC7btnZ69aXgKSG8AgldBsTyTS969D0KIC9bIivJ
   Nq6i7ajG50JfbjV4hUUHyXdfWTyWRb399i/tI3Ycs96P5MPO+G3Udwqhz
   kkGgoF1XlhtmOo9JsRg/VLLvgOSE/arEfPfQEIxGg83Io60CD7jIu0YZ6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="140240044"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="140240044"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 17:48:27 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id BEDF1D9F01;
	Thu, 14 Mar 2024 17:48:25 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0DCF6174A20;
	Thu, 14 Mar 2024 17:48:25 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 92BA96895D;
	Thu, 14 Mar 2024 17:48:24 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 0189E1A006D;
	Thu, 14 Mar 2024 16:48:23 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 2/4] HID: hid-sensor-custom: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 16:47:51 +0800
Message-Id: <20240314084753.1322110-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240314084753.1322110-1-lizhijian@fujitsu.com>
References: <20240314084753.1322110-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--5.056400-10.000000
X-TMASE-MatchedRID: O7jk9SsFe0MI7eJeU5hen5iHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/0swHSFcVJ6C99T+uJIleRfDo
	fTpsyCK+KztDhRgoFQW4suX2uLJTkj56IjTnLR+lO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BDIvl
	CZY6Ax8PdcQ4/ZOO0Rnagtny7ZPcQfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPBa0ifmLGDcAG2k2
	qIq/4e+WuKaCKJk1MODaTYOM0hTIJNEOnMbeTr1
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

CC: Jiri Kosina <jikos@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: linux-input@vger.kernel.org
CC: linux-iio@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/hid/hid-sensor-custom.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index d85398721659..ee1a118834f0 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -155,7 +155,7 @@ static ssize_t enable_sensor_show(struct device *dev,
 {
 	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", sensor_inst->enable);
+	return sysfs_emit(buf, "%d\n", sensor_inst->enable);
 }
 
 static int set_power_report_state(struct hid_sensor_custom *sensor_inst,
@@ -372,14 +372,14 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 				     sizeof(struct hid_custom_usage_desc),
 				     usage_id_cmp);
 		if (usage_desc)
-			return snprintf(buf, PAGE_SIZE, "%s\n",
-					usage_desc->desc);
+			return sysfs_emit(buf, "%s\n",
+					  usage_desc->desc);
 		else
-			return sprintf(buf, "not-specified\n");
+			return sysfs_emit(buf, "not-specified\n");
 	 } else
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t store_value(struct device *dev, struct device_attribute *attr,
-- 
2.29.2


