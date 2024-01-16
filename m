Return-Path: <linux-kernel+bounces-26971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79282E8B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63051F23900
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E6513AFD;
	Tue, 16 Jan 2024 04:52:31 +0000 (UTC)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE93101D4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="134244450"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="134244450"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:20 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2F362D9DAC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:52:17 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 74176D9682
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:52:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0199A6B4CB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:52:16 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 7F7CC1A015F;
	Tue, 16 Jan 2024 12:52:15 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Joel Stanley <joel@jms.id.au>,
	Alistar Popple <alistair@popple.id.au>,
	Eddie James <eajames@linux.ibm.com>,
	linux-fsi@lists.ozlabs.org
Subject: [PATCH 08/42] drivers/fsi: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:17 +0800
Message-Id: <20240116045151.3940401-6-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116045151.3940401-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.005
X-TMASE-Result: 10--6.986000-10.000000
X-TMASE-MatchedRID: TWQD+6s80gM4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4Vf1Vj96FvVcuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVUilv
	Ab18i4hNTeKr01gQwdM4WYLmQfXYmpoPHQXywp1eeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8h+IC
	quNi0WJMSWg7TV5TLza2j6oPQpKW77e0LAmXYjTabIaK+IyDxAftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/fsi/fsi-master-ast-cf.c:1086:8-16: WARNING: please use sysfs_emit
> ./drivers/fsi/fsi-master-gpio.c:721:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Jeremy Kerr <jk@ozlabs.org>
CC: Joel Stanley <joel@jms.id.au>
CC: Alistar Popple <alistair@popple.id.au>
CC: Eddie James <eajames@linux.ibm.com>
CC: linux-fsi@lists.ozlabs.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/fsi/fsi-master-ast-cf.c | 3 +--
 drivers/fsi/fsi-master-gpio.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 812dfa9a9140..5740b2d9dace 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1083,8 +1083,7 @@ static ssize_t external_mode_show(struct device *dev,
 {
 	struct fsi_master_acf *master = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
-			master->external_mode ? 1 : 0);
+	return sysfs_emit(buf, "%u\n", master->external_mode ? 1 : 0);
 }
 
 static ssize_t external_mode_store(struct device *dev,
diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index ed03da4f2447..286fe1cddf99 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -718,8 +718,7 @@ static ssize_t external_mode_show(struct device *dev,
 {
 	struct fsi_master_gpio *master = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
-			master->external_mode ? 1 : 0);
+	return sysfs_emit(buf, "%u\n", master->external_mode ? 1 : 0);
 }
 
 static ssize_t external_mode_store(struct device *dev,
-- 
2.29.2


