Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842A8793C77
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbjIFMS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjIFMS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:18:57 -0400
X-Greylist: delayed 124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Sep 2023 05:18:53 PDT
Received: from bgl-iport-3.cisco.com (bgl-iport-3.cisco.com [72.163.197.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C831BB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=953; q=dns/txt; s=iport;
  t=1694002733; x=1695212333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gES3+T26u+tLqP9cQSQIuVsJrE4pu6xWCWGay5+Pns8=;
  b=DPAtlSyfuvsO+Fl/JH4Nh2OJ6dZtCd31vrE//IrKx10G7MPpu2b+q1GN
   4w/M6A1yUVnY6s4ZrLwHL/sL7pYZU5NS9beCjVM1RDzugKmubJz3paBtU
   SuvIiHYA5kRO8lqxrzjspAHUCjtpPwnH7pZJ4aHR6UTr0T8zgnwttkt49
   c=;
X-CSE-ConnectionGUID: ppqVUXfZQb+dAzQaTInr6w==
X-CSE-MsgGUID: 8Dj8x8B8ThO3xaDuW4zREQ==
X-IronPort-AV: E=Sophos;i="6.02,231,1688428800"; 
   d="scan'208";a="17595644"
Received: from vla196-nat.cisco.com (HELO bgl-core-2.cisco.com) ([72.163.197.24])
  by bgl-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 12:15:40 +0000
Received: from bgl-ads-3413.cisco.com (bgl-ads-3413.cisco.com [173.39.60.50])
        by bgl-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 386CFepC020275
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Sep 2023 12:15:40 GMT
Received: by bgl-ads-3413.cisco.com (Postfix, from userid 1795984)
        id 61F15CC129C; Wed,  6 Sep 2023 17:45:40 +0530 (IST)
From:   Deepak Rathore <deeratho@cisco.com>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, deeratho@cisco.com
Subject: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
Date:   Wed,  6 Sep 2023 17:45:25 +0530
Message-Id: <20230906121525.3946250-1-deeratho@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 173.39.60.50, bgl-ads-3413.cisco.com
X-Outbound-Node: bgl-core-2.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]

In btsdio_probe, the data->work is bound with btsdio_work. It will be
started in btsdio_send_frame.

If the btsdio_remove runs with a unfinished work, there may be a race
condition that hdev is freed but used in btsdio_work. Fix it by
canceling the work before do cleanup in btsdio_remove.

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Deepak Rathore <deeratho@cisco.com>

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 795be33f2892..f19d31ee37ea 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -357,6 +357,7 @@ static void btsdio_remove(struct sdio_func *func)
 	if (!data)
 		return;
 
+	cancel_work_sync(&data->work);
 	hdev = data->hdev;
 
 	sdio_set_drvdata(func, NULL);
-- 
2.35.6

