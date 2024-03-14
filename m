Return-Path: <linux-kernel+bounces-103083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C8B87BAD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9751B222DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55B76D1BC;
	Thu, 14 Mar 2024 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Jl+VqLv6"
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845416D1AB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410354; cv=none; b=tSskjPIKXJJnJfX7XYq6ibGt1z2EJwE8k86jaZCLrVNYda9Z+S52xGesbVee+yN991gDTRHP8e31PiNodElmNbxNfebgPT5aWH9C5vGYf0G8smDzzHd+Q6Q3y4A9n/U/KMkCD2d5YlojPmi2gMPAoGLMqEi3MbXUnqog7DVHTww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410354; c=relaxed/simple;
	bh=ExMN4fRP3peAG00SNEDYTXxXDdne2pybmXISai/Y8oM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ghaPjxbmRLUrWGyrsznFq7CUe26uCzHroXQ7uz/56shgmqaGjFdMKzxoROZF+M5z1kZ+xT2RlXHRSH0BKqxQ4SArfH15E/QAQsmP/93fXONcpjceZUYnR6SZ44xa22IyQ7KA/vXSh0OFA+/9C7Hn9AYVbpqf2tHtsc/ygQsVJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Jl+VqLv6; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710410351; x=1741946351;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ExMN4fRP3peAG00SNEDYTXxXDdne2pybmXISai/Y8oM=;
  b=Jl+VqLv6cUKrX6M3ETZ9MCqWD2cj7qoqLSpRJxjNW4enhsV8UT0qkR0E
   Zpz3Zx5JhNRSOCbZkZ0sE8fOVRFEaAxdw6jmqXIOcuBogWrJc/zEBrvXj
   6Dm3KpageCMXWRmhZJGm3zAmzb059U/VOD4VtjUP1mzSQsaLOJH46h8RP
   sNBhsFMyn6Hv73eNy+EL6pTy61Toan0ynYVYRcYdnqL7XASCumS9vi3HK
   encJanyQ/g14rUdPe+qiRBJ6P358DvGnqeyyzJsmR+EXkowDdujdVrqVY
   /gGSZol9wQ+aw9h8DaCxY/JCPAmrsnRpdheyQYZfSE6jsDQEI0CCw2hyD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="131625061"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; 
   d="scan'208";a="131625061"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:59:08 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C09BAD4802
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:59:06 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id E6954D40C9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:59:00 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 74FF26B4D3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:59:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id BD71E1A006B;
	Thu, 14 Mar 2024 17:58:59 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] vdpa: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 17:58:53 +0800
Message-Id: <20240314095853.1326111-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--7.076400-10.000000
X-TMASE-MatchedRID: ebEStOsB1eE4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbS7pujb8urdzZSuvtBzlaEqC99T+uJIleRfDo
	fTpsyCK+KztDhRgoFQW4suX2uLJTkj56IjTnLR+msxn4GpC3Y2sE5XPQnBzGXq8KsbROd9VSKW8
	BvXyLiE6ANl9QqNE6NhKK/bK+QypCR9GF2J2xqMxRFJJyf5BJeZVXUb4KTaXv6C0ePs7A07V9vM
	TaVNFNzVlNXZ4zxNCCPRPmWwzXHz5h70tmPyiUmkZR7Q/L+l1w=
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

CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: virtualization@lists.linux.dev
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index d0695680b282..7b82b9aa91e9 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -98,7 +98,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
+	len = sysfs_emit(buf, "%s\n", vdev->driver_override);
 	device_unlock(dev);
 
 	return len;
-- 
2.29.2


