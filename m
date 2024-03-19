Return-Path: <linux-kernel+bounces-107019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0D87F6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4397C282630
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2B4594C;
	Tue, 19 Mar 2024 05:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SDpGwL7V"
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49383E493;
	Tue, 19 Mar 2024 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827153; cv=none; b=ePiNLlZ1hdj47daxgkIZ34DGYGZIZiXYKXV4QbuEkqi+SrP6gk/a7I4UuZeG574WjqGF7ACx8W3Nr4HXMFRdB+dTHUQ3F0SvcSAAJP1gBl7J0WWK6+zrd0dTcTAOnJa/aU7uiznZjP+ZqUPd0cJkzqpZ8b7jnUshxTO/Hf2w1L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827153; c=relaxed/simple;
	bh=1kxte2Fz6zJqoIdHYkcuPkCFWbf1eHIi5bpBXCxGdhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CcPXk+whyHH57Z0xU3wnpeazldMdme7o3m9Xsp8ie9Zb30TUoU95R9IOIsNZB2LnJHGl2+WyWltAqO6/kmxvR0GUMzDUiAih2FQBbgenYFjcvs9hPFslodumD6Lw/1nyQWb7idLoWa5kCtEEDjp4fw1C9cebZguJEMNOU1PlkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SDpGwL7V; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710827151; x=1742363151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1kxte2Fz6zJqoIdHYkcuPkCFWbf1eHIi5bpBXCxGdhM=;
  b=SDpGwL7VPPb2IDrZQ1fAh8+yMpN87xi1/obPoPx2PHnNZ8EZbXsEePKA
   0+lo5uqeHDDGPwl2M2NS449L8iNvMjGgMPhAVsveejPQGPGUI3Tg9r9xI
   M78o49cCMWrrCruAErWNyoaO1R+NeqE3pUE9H5uKSJ774Km237AA/66yb
   Nr0c2E2tp1HFrJPT69W6gg3sTEWumaBHl0hDnLVBbm8diFNsmWWWJqeXG
   Cu2/Os0/rA5UrDLGrOsaYLg5PAHuifeYHelTm6SfMK946HkMRApFPj8/i
   bJZ5YElrXy7P7uzCSA4rlXcbS9fghwJIzX0tPJ1hQu2BYtcS08/Z6MHXs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="152721768"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="152721768"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 14:45:42 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E2EC9D3EAF;
	Tue, 19 Mar 2024 14:45:39 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 245972014B;
	Tue, 19 Mar 2024 14:45:39 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 770432009325C;
	Tue, 19 Mar 2024 14:45:38 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 954771A006B;
	Tue, 19 Mar 2024 13:45:37 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org
Subject: [PATCH v4 1/4] HID: hid-picolcd*: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 13:45:24 +0800
Message-Id: <20240319054527.1581299-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.005
X-TMASE-Result: 10--7.130100-10.000000
X-TMASE-MatchedRID: RKkR8WK0E1obO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/0swHSFcVJ6EekR3VSvOYVLhd
	6ma7WE8uEkt/L8HtAJ785xNkZcrN2ePWEUnWb98FBDn6Fjq77jvioIsi7Sa0gOhR0VsdhRrC/BR
	68O365bn9eOltIlLtrTAoJHN/wZk1+wAuSUWlj5HV7tdtvoibatMkiccRbz20GWfDd0b0zMaPFj
	JEFr+olSXhbxZVQ5H+OhzOa6g8KrUBiheCzxlZpV4cJTWRQ7ka1Dnyes5pzd2pamyppvmPPfGL9
	6pWTdQM=
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

CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: "Bruno Prémont" <bonbons@linux-vserver.org>
CC: Jiri Kosina <jikos@kernel.org>
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: linux-input@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V4:
   Kill 'if (ret >= PAGE_SIZE)' which is always false in this context and sysfs_emit_at() is able to handle this case. # CJ
V3:
   Convert more file(drivers/hid/hid-picolcd_fb.c) as suggested by Bruno

This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/hid/hid-picolcd_core.c | 6 +++---
 drivers/hid/hid-picolcd_fb.c   | 8 +++-----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index bbda231a7ce3..fa46fb6eab3f 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -256,9 +256,9 @@ static ssize_t picolcd_operation_mode_show(struct device *dev,
 	struct picolcd_data *data = dev_get_drvdata(dev);
 
 	if (data->status & PICOLCD_BOOTLOADER)
-		return snprintf(buf, PAGE_SIZE, "[bootloader] lcd\n");
+		return sysfs_emit(buf, "[bootloader] lcd\n");
 	else
-		return snprintf(buf, PAGE_SIZE, "bootloader [lcd]\n");
+		return sysfs_emit(buf, "bootloader [lcd]\n");
 }
 
 static ssize_t picolcd_operation_mode_store(struct device *dev,
@@ -301,7 +301,7 @@ static ssize_t picolcd_operation_mode_delay_show(struct device *dev,
 {
 	struct picolcd_data *data = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%hu\n", data->opmode_delay);
+	return sysfs_emit(buf, "%hu\n", data->opmode_delay);
 }
 
 static ssize_t picolcd_operation_mode_delay_store(struct device *dev,
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index d7dddd99d325..063f9c01d2f7 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -421,12 +421,10 @@ static ssize_t picolcd_fb_update_rate_show(struct device *dev,
 	size_t ret = 0;
 
 	for (i = 1; i <= PICOLCDFB_UPDATE_RATE_LIMIT; i++)
-		if (ret >= PAGE_SIZE)
-			break;
-		else if (i == fb_update_rate)
-			ret += scnprintf(buf+ret, PAGE_SIZE-ret, "[%u] ", i);
+		if (i == fb_update_rate)
+			ret += sysfs_emit_at(buf, ret, "[%u] ", i);
 		else
-			ret += scnprintf(buf+ret, PAGE_SIZE-ret, "%u ", i);
+			ret += sysfs_emit_at(buf, ret, "%u ", i);
 	if (ret > 0)
 		buf[min(ret, (size_t)PAGE_SIZE)-1] = '\n';
 	return ret;
-- 
2.29.2


