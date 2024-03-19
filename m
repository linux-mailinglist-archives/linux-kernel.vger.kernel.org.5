Return-Path: <linux-kernel+bounces-107096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D887F77E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBA01C21646
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B157EEF0;
	Tue, 19 Mar 2024 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="uLS130A3"
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07854679;
	Tue, 19 Mar 2024 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829957; cv=none; b=EGdhWo6+TqmCmeapE16X7Uhk62kpauVTHgncIGymo/vhY5SZwmXJmaH9DSS3cUNzniHBb0hd8eWsF13o4egw0iTGOIaMHqbx0hr7JAHlq4tMdg8AR9xKVdvql7ldNVhdOJs8AmGEBquXpnwgr3/3HRZnW4CLNo6ndl6WoZv2Q4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829957; c=relaxed/simple;
	bh=8MR9WpIiAhMg2jOe7ce8CcmnxFjUGyFqc1Z6lfuPjdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NnUvJOtxhesn5qz76B8JUvMDrRxt0W1O7YKhZArh3Iu4ArKnz34RDWv+S1aYtL5Ph9Mwik8XEwPX2a9nGTjBrz+1xjkhmMyVHJry/vflv+JyZhDY9xSpddIhZ59LXSgsKJTgRQuep0X06zU2Dk0BrG5CS7Kho1WKvRtbNn235Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=uLS130A3; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829955; x=1742365955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8MR9WpIiAhMg2jOe7ce8CcmnxFjUGyFqc1Z6lfuPjdw=;
  b=uLS130A3MJOIwZ5iM4FWhsskrnLgN2NnPDHCBYK7g6lMbYwwtlfyMLdA
   kZwIweJM9XK3O37u7+nZnGt4CAl4kVLnThhD7gzkqxjXKkOOvalkezPM0
   Mw0pWjIWyizk7fQWCvHnpw147bPOStq59gn+J9UT+sxvd0u0+2X/YU7gS
   5/THWOCLC6XQUfeeNSvu3Pdzxa43tq4Gn+aWMUwoGq/tQkr2Lh5TD43en
   69MFYGnjKraMsUwdVZlUteEEegC3eUV61xGMQiL3SjSvpphQGSIy0kz1X
   hZROpRs5OM0N9fCWPboviwFvlwpddZDvIuX5pzzVwHAIh5so2uT1bRrT6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="154551209"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="154551209"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:29 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 67CA8FBD83;
	Tue, 19 Mar 2024 15:32:27 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A1C7CD7B7E;
	Tue, 19 Mar 2024 15:32:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 343C9227ABA;
	Tue, 19 Mar 2024 15:32:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id BDD771A006B;
	Tue, 19 Mar 2024 14:32:25 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 17/25] scsi: ncr53c8xx: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:24 +0800
Message-Id: <20240319063132.1588443-17-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240319063132.1588443-1-lizhijian@fujitsu.com>
References: <20240319063132.1588443-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.005
X-TMASE-Result: 10--6.881400-10.000000
X-TMASE-MatchedRID: xt1fvVgCaAwbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VRpRe
	zoWC5XLeR+RPF+XmyOXnkq6nWMKny+8LSisOUFN54CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyH4gK
	q42LRYkceGkeUm/IJ00Ef/oSJNEvayN+Ntyr+C6qVDeOEbwfw5+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() and scnprintf() will be converted as well if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/ncr53c8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index 35869b4f9329..2bd74620caf5 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -8031,7 +8031,7 @@ static ssize_t show_ncr53c8xx_revision(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct host_data *host_data = (struct host_data *)host->hostdata;
   
-	return snprintf(buf, 20, "0x%x\n", host_data->ncb->revision_id);
+	return sysfs_emit(buf, "0x%x\n", host_data->ncb->revision_id);
 }
   
 static struct device_attribute ncr53c8xx_revision_attr = {
-- 
2.29.2


