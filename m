Return-Path: <linux-kernel+bounces-103032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7BC87BA2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B67B2292C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11766CDAD;
	Thu, 14 Mar 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ipJKBy2Z"
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B36CDAA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407695; cv=none; b=JKozu8qhJ0pWbEvV/6HC8FTK1tW57FxT30Z4DSiCkP4yl1IE9ujsXub3NITF7h4xs5N1DXnFbv1gfVjc7tyXK+/Cn3Wtkr+ROgD2ZAysexkEHADS9uR50sqpLRb1BdlsUIBRpQ78tLdzXo2ZMdUzEq/zrqBRrNA46OqRnJ4rsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407695; c=relaxed/simple;
	bh=+M6Ia1pC6W9VmZp+4ZgiLGoiDoNAJCIK6ngh7x2MqCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YwYnuUxZTjfW7nNOD/V5N3mDavIAltjZ/NNXr+W39aSy4ih9OVAiusMJCokhJxlvFRe9z+R/vWyqGNlQ5yFmAfbTaOOqJ3GeykmvUr4IrhxzHkGu7tHBPGqSYyPZ7KGYXUnaSRcpljfn55E1Vhzky/oHfXoQpf0fF781hFj0nPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ipJKBy2Z; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710407693; x=1741943693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+M6Ia1pC6W9VmZp+4ZgiLGoiDoNAJCIK6ngh7x2MqCo=;
  b=ipJKBy2ZlFfTEN880MTmlco0LGqnibgWR3XIR5QI5yYei+A1atkiymF/
   98woSHgkOa8AWBW5o5G5Uqvl+5UddOGfFey+yNdGrSzjH7IpSvUZmMNcP
   3hG27D5uB73w8KmPqRqIJgIx4kh4Qtqu4a+dBaI1AlhXalThzrk+JLo+m
   gHgY7RvZOs/52P5dyuXVhGUbSRPU7Jgbdnx6iEth4t9qnHhD+Bvv9sIhm
   gnggp6JuTXyxsNYxG6B/q1tTSE9qVUZkCBiknoSayApTtO9Z2kghIFe4o
   u6JgPt0W2EV9+zdRjPlODuuiaNkM6FRxPg8GCg9Fe34AbqoiDKugnCcnG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="152237945"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="152237945"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:13:37 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id BD597FBD88
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:13:34 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0B7933483D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:13:34 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9E2C16B4CF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:13:33 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 44C671A006B;
	Thu, 14 Mar 2024 17:13:33 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] intel_th: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 17:13:26 +0800
Message-Id: <20240314091326.1323492-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--7.667100-10.000000
X-TMASE-MatchedRID: ebEStOsB1eE4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbS/sUSFaCjTLxN8rmPQRlvK7oFQ8GRC1Prs1w
	waYBQLgs9/vFVBxxqgB0XJlVTsEsboYY7KoErjW8ReM8i8p3vgEyQ5fRSh2656hUULKzHRgRjST
	BlHEhAJovs2FqH/pE7hKK/bK+QypCR9GF2J2xqMxRFJJyf5BJeGEkIgdGU7nX6C0ePs7A07b4iO
	wQQ4jNiGscX1rQ4Fn/mg7+nvJVJ8qbDNweYTUPQFW3EAdm/C5k=
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

CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/hwtracing/intel_th/gth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/gth.c b/drivers/hwtracing/intel_th/gth.c
index b3308934a687..3883f99fd5d5 100644
--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -154,9 +154,9 @@ static ssize_t master_attr_show(struct device *dev,
 	spin_unlock(&gth->gth_lock);
 
 	if (port >= 0)
-		count = snprintf(buf, PAGE_SIZE, "%x\n", port);
+		count = sysfs_emit(buf, "%x\n", port);
 	else
-		count = snprintf(buf, PAGE_SIZE, "disabled\n");
+		count = sysfs_emit(buf, "disabled\n");
 
 	return count;
 }
@@ -332,8 +332,8 @@ static ssize_t output_attr_show(struct device *dev,
 	pm_runtime_get_sync(dev);
 
 	spin_lock(&gth->gth_lock);
-	count = snprintf(buf, PAGE_SIZE, "%x\n",
-			 gth_output_parm_get(gth, oa->port, oa->parm));
+	count = sysfs_emit(buf, "%x\n",
+			   gth_output_parm_get(gth, oa->port, oa->parm));
 	spin_unlock(&gth->gth_lock);
 
 	pm_runtime_put(dev);
-- 
2.29.2


