Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899817BDAB1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346445AbjJIMKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346308AbjJIMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:10:32 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5485C99
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:10:30 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231009121026euoutp0171e879a36b519814c2c04d5766e5a9c0~MbzOTEjIM3187731877euoutp01K
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:10:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231009121026euoutp0171e879a36b519814c2c04d5766e5a9c0~MbzOTEjIM3187731877euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696853426;
        bh=+oeF9tduJROpDtEILgnH87XCwSDj3+xudliDOb9i4c0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JpYvnAD49jvrdbgZD5e7a6H8MuDp/a0YCS84UmjwewbqYI8jIGJuBo3sG0w5T7Wcf
         8M2cFksRLgj2usgPEy48M46SKMj+BTcBSogjDv1+5QKgMMbJTNX4otaNxvXQXgHsWh
         I/jP84wFGbE1ypNi8tMEs03fq26ha4jOGZWjpwWM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231009121026eucas1p1adad209218fa1a3c4958ca50071ebcad~MbzOFgJgu0583105831eucas1p1W;
        Mon,  9 Oct 2023 12:10:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BC.2B.11320.2BDE3256; Mon,  9
        Oct 2023 13:10:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231009121026eucas1p19ed2a6a88fa6b899ef9b915a73ad87b5~MbzNqHT6W1046310463eucas1p1H;
        Mon,  9 Oct 2023 12:10:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231009121026eusmtrp2daf61cd3394bda244624e4b47fc2aa5f~MbzNpQuTW0414604146eusmtrp2e;
        Mon,  9 Oct 2023 12:10:26 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-1f-6523edb292fb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 33.91.10549.2BDE3256; Mon,  9
        Oct 2023 13:10:26 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231009121025eusmtip124de06fbf785870495bda711da01db0c~MbzNS2WFR1780317803eusmtip1P;
        Mon,  9 Oct 2023 12:10:25 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: [PATCH] Input: cyapa - add missing input core locking to
 suspend/resume functions
Date:   Mon,  9 Oct 2023 14:10:18 +0200
Message-Id: <20231009121018.1075318-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduzned1Nb5VTDeb9VbFY9vgei8XhRS8Y
        LW5++sZqcXnXHDaLtUfusjuweuy4u4TRY+esu+wefVtWMXp83iQXwBLFZZOSmpNZllqkb5fA
        lfHufD9jwXfFinUd7WwNjF2yXYycHBICJhInN6xg6mLk4hASWMEocevXZHYI5wujxO6+hywQ
        zmdGiSeT+plhWma33GOGSCxnlPjc8ZsVruXytEssIFVsAoYSXW+72EBsEQFbiR0rpoMtYRbo
        Z5RYu2wvO0hCWCBGouXGdyYQm0VAVeLhopdgNq+AvcTp+59YINbJS+w/eJYZIi4ocXLmE7A4
        M1C8eetssDMkBDo5JF7uOMoG0eAi8X/GJShbWOLV8S3sELaMxP+d85kgGtoZJRb8vg/lTGCU
        aHh+ixGiylrizrlfQN0cQCs0Jdbv0ocIO0q0/NrLBBKWEOCTuPFWEOIIPolJ26YzQ4R5JTra
        hCCq1SRmHV8Ht/bghUtQJR4SDW3pIGEhgViJySvnMk1gVJiF5LNZSD6bhXDCAkbmVYziqaXF
        uempxUZ5qeV6xYm5xaV56XrJ+bmbGIEJ5fS/4192MC5/9VHvECMTB+MhRgkOZiURXt1ShVQh
        3pTEyqrUovz4otKc1OJDjNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkGJjNZOZ3z9Uf6
        tXcorzha/2b+/73NfUoPtS/oaxmuNauJLri5KdtmxWc7f2sJVs9NT+SrOCY0NyamJs1x3GIr
        e6iD9VlWwK/4y7LZ8V9Mtfktp9ztCj3Mr/u+dE3A2RXHfLnXzXwid/+x8tfX2w4pZDJf6zgk
        yfZap79tUp3b25cveT8+Ee5b+3Zb3Ix0/11GhYuUr31ZqBU91dNvaRd/h8Qfrhy19YV/Zdeo
        3ni2vZzN5v8jqUCnkne5Z1/bPF17wVH37+ysMoXatFyx3++LNnxMfLVSyvfWEUezNSu985vc
        YmWTnnNmqli5iZlanuX42OtRKs0mcqxNvHFyemyWrqlPeqrVNL4nu9y2dLApsRRnJBpqMRcV
        JwIAmx9H+JcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xu7qb3iqnGixdxmWx7PE9FovDi14w
        Wtz89I3V4vKuOWwWa4/cZXdg9dhxdwmjx85Zd9k9+rasYvT4vEkugCVKz6Yov7QkVSEjv7jE
        Vina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Pd+X7Ggu+KFes62tkaGLtk
        uxg5OSQETCRmt9xj7mLk4hASWMoocezJRHaIhIzEyWkNrBC2sMSfa11sEEWfGCX2n9rFCJJg
        EzCU6HoLkuDkEBGwlzj8Zg0LSBGzwERGiVX3m5lBEsICURKTJlwEs1kEVCUeLnrJBGLzAjWc
        vv+JBWKDvMT+g2eZIeKCEidnPgGLMwPFm7fOZp7AyDcLSWoWktQCRqZVjCKppcW56bnFhnrF
        ibnFpXnpesn5uZsYgYG87djPzTsY5736qHeIkYmD8RCjBAezkgivbqlCqhBvSmJlVWpRfnxR
        aU5q8SFGU6D7JjJLiSbnA2MpryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQim
        j4mDU6qByWNp9b+98zYdtPbOPN0UxPIz0iNj8waO117qb1O76gNZzt2fmN+neal12zUhz+LQ
        jUKKK/czuL+d05ggFSd8vrL3cmXo9+yqxlARMT6uOc0T2d64vziu2tu9/YhBxm7Th6I7+Y4o
        m7UZLvTemnJ2aU9nbmOE0Icq7t7/r1MWhKYreLSIcPIemlrwne3rTFb7sODX2m92h9kFnjtk
        rFK64/1CjjkzdOfcOd7V09JYcuawz6eDyY/Uky8z/uv/UCsn/eZNbs/chZ+8RI80ORT5fu3I
        lil02eD62FX58b9zDftiS668kOSYNKO9jO3l7SuxW44/umd+vz3ZWaXvtvGpFt6zFW9Vr6WK
        rHt1a+UnJZbijERDLeai4kQAxLaD4u0CAAA=
X-CMS-MailID: 20231009121026eucas1p19ed2a6a88fa6b899ef9b915a73ad87b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231009121026eucas1p19ed2a6a88fa6b899ef9b915a73ad87b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231009121026eucas1p19ed2a6a88fa6b899ef9b915a73ad87b5
References: <CGME20231009121026eucas1p19ed2a6a88fa6b899ef9b915a73ad87b5@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grab input->mutex during suspend/resume functions like it is done in
other input drivers. This fixes the following warning during system
suspend/resume cycle on Samsung Exynos5250-based Snow Chromebook:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1680 at drivers/input/input.c:2291 input_device_enabled+0x68/0x6c
Modules linked in: ...
CPU: 1 PID: 1680 Comm: kworker/u4:12 Tainted: G        W          6.6.0-rc5-next-20231009 #14109
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound async_run_entry_fn
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x58/0x70
 dump_stack_lvl from __warn+0x1a8/0x1cc
 __warn from warn_slowpath_fmt+0x18c/0x1b4
 warn_slowpath_fmt from input_device_enabled+0x68/0x6c
 input_device_enabled from cyapa_gen3_set_power_mode+0x13c/0x1dc
 cyapa_gen3_set_power_mode from cyapa_reinitialize+0x10c/0x15c
 cyapa_reinitialize from cyapa_resume+0x48/0x98
 cyapa_resume from dpm_run_callback+0x90/0x298
 dpm_run_callback from device_resume+0xb4/0x258
 device_resume from async_resume+0x20/0x64
 async_resume from async_run_entry_fn+0x40/0x15c
 async_run_entry_fn from process_scheduled_works+0xbc/0x6a8
 process_scheduled_works from worker_thread+0x188/0x454
 worker_thread from kthread+0x108/0x140
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xf1625fb0 to 0xf1625ff8)
...
---[ end trace 0000000000000000 ]---
...
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1680 at drivers/input/input.c:2291 input_device_enabled+0x68/0x6c
Modules linked in: ...
CPU: 1 PID: 1680 Comm: kworker/u4:12 Tainted: G        W          6.6.0-rc5-next-20231009 #14109
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound async_run_entry_fn
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x58/0x70
 dump_stack_lvl from __warn+0x1a8/0x1cc
 __warn from warn_slowpath_fmt+0x18c/0x1b4
 warn_slowpath_fmt from input_device_enabled+0x68/0x6c
 input_device_enabled from cyapa_gen3_set_power_mode+0x13c/0x1dc
 cyapa_gen3_set_power_mode from cyapa_reinitialize+0x10c/0x15c
 cyapa_reinitialize from cyapa_resume+0x48/0x98
 cyapa_resume from dpm_run_callback+0x90/0x298
 dpm_run_callback from device_resume+0xb4/0x258
 device_resume from async_resume+0x20/0x64
 async_resume from async_run_entry_fn+0x40/0x15c
 async_run_entry_fn from process_scheduled_works+0xbc/0x6a8
 process_scheduled_works from worker_thread+0x188/0x454
 worker_thread from kthread+0x108/0x140
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xf1625fb0 to 0xf1625ff8)
...
---[ end trace 0000000000000000 ]---

Fixes: d69f0a43c677 ("Input: use input_device_enabled()")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/input/mouse/cyapa.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index a84098448f5b..cf23f95b5f11 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1347,10 +1347,16 @@ static int cyapa_suspend(struct device *dev)
 	u8 power_mode;
 	int error;
 
-	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
+	error = mutex_lock_interruptible(&cyapa->input->mutex);
 	if (error)
 		return error;
 
+	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
+	if (error) {
+		mutex_unlock(&cyapa->input->mutex);
+		return error;
+	}
+
 	/*
 	 * Runtime PM is enable only when device is in operational mode and
 	 * users in use, so need check it before disable it to
@@ -1385,6 +1391,8 @@ static int cyapa_suspend(struct device *dev)
 		cyapa->irq_wake = (enable_irq_wake(client->irq) == 0);
 
 	mutex_unlock(&cyapa->state_sync_lock);
+	mutex_unlock(&cyapa->input->mutex);
+
 	return 0;
 }
 
@@ -1394,6 +1402,7 @@ static int cyapa_resume(struct device *dev)
 	struct cyapa *cyapa = i2c_get_clientdata(client);
 	int error;
 
+	mutex_lock(&cyapa->input->mutex);
 	mutex_lock(&cyapa->state_sync_lock);
 
 	if (device_may_wakeup(dev) && cyapa->irq_wake) {
@@ -1412,6 +1421,7 @@ static int cyapa_resume(struct device *dev)
 	enable_irq(client->irq);
 
 	mutex_unlock(&cyapa->state_sync_lock);
+	mutex_unlock(&cyapa->input->mutex);
 	return 0;
 }
 
-- 
2.34.1

