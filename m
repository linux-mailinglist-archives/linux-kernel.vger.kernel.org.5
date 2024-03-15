Return-Path: <linux-kernel+bounces-104077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76687C8A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98653B21FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FBA1429B;
	Fri, 15 Mar 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="o+N57xuP"
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7B12E5D;
	Fri, 15 Mar 2024 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481956; cv=none; b=EOYlBP1JDbVT9ySWdOuvyzbLifOIHII89UxzI31K5/g5R47Jt7+LNdZZTeSBsnRhI3V9ofqbmn6c5R7CAG5dDWHHN2E8ewrcQQBQrV8XxmaF0X0UhabOw1tyddcELdDeUamt7O9jvPJlPbd822Xxsx6EmApsjF8KwG+q0km0n/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481956; c=relaxed/simple;
	bh=Qv6phc/4FuyjqrfYPdqCTnpCxBNfhp35atRySiUpzR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mu4ub+lwNQYImM7o5kcmE6uMcJnXGHhMYFJIGjXot8fxCL7rcRCD3HA8CnEMNGZfoOJbCoVSIrSHh6zBijixCoM/tLpB5WtK8iui3wPz6hEZeERPMcahJLr9TMf6S1QyShjdODJNYLiCuVuu3TRE4AE3losKlM8yHqYr1woC9YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=o+N57xuP; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710481953; x=1742017953;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qv6phc/4FuyjqrfYPdqCTnpCxBNfhp35atRySiUpzR8=;
  b=o+N57xuPi/Z7+TC/ISSCVVhAZ1hWGntvgTDA7tkJsTmZgZu4lcEIqXD8
   w+alt92cGw9Xc1+JQN7/GJV0ti1MHvOdNf9LOVrNnMsntc12SZUtgGavh
   IqobV0clTy/CmY+BS9wTAilAsonNEnn+/tWQjQ9Sta6FUGqeqarhQXLxb
   WPJ6G5ZIcXlW7ABaMVLBbqX7afzCTrhZ7+72J6Pa3FOU75OIsGrYECSmV
   NukKDZ+JkeEpX6OWLPcpM4kUGOFgZRKIsRN4K0Ha+qESc/xlGFi1AbgW7
   fCwhGZpQq5DdWNivnFTh//bIOIxXsXmg2dkroLpq2UpDgKtWB1bmHkVh8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="152383413"
X-IronPort-AV: E=Sophos;i="6.07,127,1708354800"; 
   d="scan'208";a="152383413"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 14:52:29 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3C36DF2647;
	Fri, 15 Mar 2024 14:52:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6609F10613D;
	Fri, 15 Mar 2024 14:52:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E188820097CFA;
	Fri, 15 Mar 2024 14:52:25 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1A9A31A006B;
	Fri, 15 Mar 2024 13:52:24 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath10k@lists.infradead.org
Subject: [PATCH v2 1/3] wifi: ath: Convert sprintf/snprintf to sysfs_emit
Date: Fri, 15 Mar 2024 13:52:09 +0800
Message-Id: <20240315055211.1347548-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
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
X-TMASE-Result: 10--3.370400-10.000000
X-TMASE-MatchedRID: /mcjwogdDrk4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSrMZ+BqQt2Nps/NNpVQ666hXsn8ikX6Gtzv0
	+UmYCZcMPNxz2EvpSIAhBeNJICtc+zK2lwdvrNt2qH6mIBejVf2ItZ2e1geixEd+K6O5Nt53oKE
	r2irJf5CL637QCIVpi8vc3EUpCmrV8M8QL/JCA9N9JA2lmQRNUrzl8sNiWClKbKItl61J/yZ+in
	TK0bC9eKrauXd3MZDXdPm6Zo4+L6rfjitlkYmpJaIu8tbWsF6z9+jPt2YyIEwSvEMdfhO/82WMg
	P9XH4iW61V4Xac0M7FrnjD0+bxg0N7Br+Gphn4yMa1PejsZJrBXFEH92Kf64nTtPxlIuIBW9Hzj
	86YHXBCnifx5AGfCL
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
CC: Jeff Johnson <jjohnson@kernel.org>
CC: linux-wireless@vger.kernel.org
CC: ath11k@lists.infradead.org
CC: ath10k@lists.infradead.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: subject updated

This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/net/wireless/ath/ath10k/thermal.c | 2 +-
 drivers/net/wireless/ath/ath11k/thermal.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/thermal.c b/drivers/net/wireless/ath/ath10k/thermal.c
index 31c8d7fbb095..8b15ec07b107 100644
--- a/drivers/net/wireless/ath/ath10k/thermal.c
+++ b/drivers/net/wireless/ath/ath10k/thermal.c
@@ -100,7 +100,7 @@ static ssize_t ath10k_thermal_show_temp(struct device *dev,
 	spin_unlock_bh(&ar->data_lock);
 
 	/* display in millidegree celsius */
-	ret = snprintf(buf, PAGE_SIZE, "%d\n", temperature * 1000);
+	ret = sysfs_emit(buf, "%d\n", temperature * 1000);
 out:
 	mutex_unlock(&ar->conf_mutex);
 	return ret;
diff --git a/drivers/net/wireless/ath/ath11k/thermal.c b/drivers/net/wireless/ath/ath11k/thermal.c
index 41e7499f075f..18d6eab5cce3 100644
--- a/drivers/net/wireless/ath/ath11k/thermal.c
+++ b/drivers/net/wireless/ath/ath11k/thermal.c
@@ -101,7 +101,7 @@ static ssize_t ath11k_thermal_show_temp(struct device *dev,
 	spin_unlock_bh(&ar->data_lock);
 
 	/* display in millidegree Celsius */
-	ret = snprintf(buf, PAGE_SIZE, "%d\n", temperature * 1000);
+	ret = sysfs_emit(buf, "%d\n", temperature * 1000);
 out:
 	mutex_unlock(&ar->conf_mutex);
 	return ret;
-- 
2.29.2


