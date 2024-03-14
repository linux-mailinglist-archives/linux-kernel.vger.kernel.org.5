Return-Path: <linux-kernel+bounces-103074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BA387BAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B45B1F2150A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D16E5E9;
	Thu, 14 Mar 2024 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="YI1oeMRO"
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC34C6CDDF;
	Thu, 14 Mar 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409723; cv=none; b=cn9BYad/ihGqtbOodWVcK9+z45M4AJoFKVSavG4qMkS9tusLHbB3ZhsUF/vl8e2+UKFVZ/yVEJ5pYiIT5KLeBnO1qpiqxlrhJMd6soxKPLvY5boFb2c6pACuw6BRR8MbZcUklPAfPKL7Noswqo7iuygwNWhlrvCopKzv7ZO7+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409723; c=relaxed/simple;
	bh=tXWoDv0MCVcjPegxH+LsuRrAuyb6Of1Y0FhIRJQ/Wsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IgiS+xD3oiQ1uzVmWpQzmwHavjH9xZYVhYqkd+HeNinGKsmEQVvzIqlfuVeIjue+zpGeiO6HXgqyb2abEHbtd3bwaKNi9iJIvod/QHZZQ3Ee9AmTrEim+u0YlzBpnnNwOUBpj/+Ok1aPpOZOyRt4WOfAiFub+Sz/H1NLQ9imUp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=YI1oeMRO; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710409719; x=1741945719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tXWoDv0MCVcjPegxH+LsuRrAuyb6Of1Y0FhIRJQ/Wsw=;
  b=YI1oeMRO7bg02fVIy+YWaheiQ1MxCvINdAvuGMmscYsuOh4uwvb8OL5P
   dXgzJxia4FuTh8mE9PUOg5J17zyRvHFKiNFBY0Y7uZPJ0S5yNHCVyIdoO
   cu7Pci6zSH3e5mW5p+BASbpYMoNTENWlzZba3tm9u+TP885pC5zjYwJGk
   4IRj1pf9QjczwIAfrOMXW04hbZo8OkL31wFyOBN1T39orzIGSbH+nP7ul
   CKC9QsUlFpxg5XPDpt/hpIe1ufvJ8/kS1g0rPR4o9A5V+qWJNEGSCEMnL
   Edb4xyxG1y/5g+zJVV8POaEhArjIL5QNhW8ZpJEo1EhKyOClzeGNYmNe6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="131570232"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; 
   d="scan'208";a="131570232"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:48:36 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id F10D99D107;
	Thu, 14 Mar 2024 18:48:33 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3A27DE6268;
	Thu, 14 Mar 2024 18:48:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id C1E5A6B4D4;
	Thu, 14 Mar 2024 18:48:32 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1D2AE1A006B;
	Thu, 14 Mar 2024 17:48:32 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath10k@lists.infradead.org
Subject: [PATCH 1/3] net: ath: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 17:48:21 +0800
Message-Id: <20240314094823.1324898-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--3.130400-10.000000
X-TMASE-MatchedRID: ebEStOsB1eE4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSrMZ+BqQt2Nps/NNpVQ666iXOD7ucKRbIQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/wmWvXEqQTm5wLkNMQzGl5B+Kr
	WCPbERPznpYPqS6jzxEi2pD9yuITrh15/JKUJo/p4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyHEqm
	8QYBtMO3LlEZYYZnW9rIyN56uP6NRM6ylMvEXGk1oRQBQClV4HA/0Gjnf5bBp2jOiFp3dpx6YyQ
	KoFjU2kssxlojaTXaZ9+GrWpP0BdW4wbpXTb5DJKKve1kh3RY37qSWrndbmQn0bOriG5BVc=
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


