Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBFD77D86B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbjHPC0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbjHPCZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:25:47 -0400
X-Greylist: delayed 124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 19:25:46 PDT
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1EF1FDF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:25:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="107589787"
X-IronPort-AV: E=Sophos;i="6.01,175,1684767600"; 
   d="scan'208";a="107589787"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 11:22:38 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E4C91CA1E4;
        Wed, 16 Aug 2023 11:22:35 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 28221D9491;
        Wed, 16 Aug 2023 11:22:35 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id AB77FE20ED;
        Wed, 16 Aug 2023 11:22:33 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Li Zhijian <lizhijian@fujitsu.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>
Subject: [PATCH] drivers/rnbd: restore sysfs interface to rnbd-client
Date:   Wed, 16 Aug 2023 10:22:10 +0800
Message-Id: <20230816022210.2501228-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27816.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27816.004
X-TMASE-Result: 10--2.244700-10.000000
X-TMASE-MatchedRID: lzIp1xaUHQqEYjs8p9Au+BFbgtHjUWLyG24YVeuZGmOpTkI0HK8zpb8F
        Hrw7frluf146W0iUu2tMCgkc3/BmTUkjllSXrjtQFEUknJ/kEl5q8/xv2Um1avoLR4+zsDTtiN2
        nYwbbDKyLv11DZK+EhB2bRrumTkUyY3hCj5vE5rvHPuDMDtTR7ZQJQ3x6r9Z6valsT8ESCZaSH6
        3OwKxoBLsdeAyRPdTvqgt4/4pGnbSGk+xUaqdMDwHEKwHwYevbwUSxXh+jiUgkww/gwY7hMA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 137380c0ec40 renamed 'rnbd-client' to 'rnbd_client', this changed
sysfs interface to /sys/devices/virtual/rnbd_client/ctl/map_device
from /sys/devices/virtual/rnbd-client/ctl/map_device.

CC: Ivan Orlov <ivan.orlov0322@gmail.com>
CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
CC: Jack Wang <jinpu.wang@ionos.com>
Fixes: 137380c0ec40 ("block/rnbd: make all 'class' structures const")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index c36d8b1ceeed..39887556cf95 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -25,7 +25,7 @@
 
 static struct device *rnbd_dev;
 static const struct class rnbd_dev_class = {
-	.name = "rnbd_client",
+	.name = "rnbd-client",
 };
 static struct kobject *rnbd_devs_kobj;
 
-- 
2.29.2

