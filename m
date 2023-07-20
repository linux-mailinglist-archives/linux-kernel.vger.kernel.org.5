Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E88775AB17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGTJkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjGTJkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:40:14 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD87930EA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:36:33 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230720092959epoutp04aa0b8f0be0f7bf58abbc247b455ab904~ziW-75Zlu0876108761epoutp040
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:29:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230720092959epoutp04aa0b8f0be0f7bf58abbc247b455ab904~ziW-75Zlu0876108761epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689845399;
        bh=nGeZCbqTKt9GUpDssg640prX0TVeJcRGPnCQlXxuDF8=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=U8XincyAfZcUCI+XG+PFDNayJLbUCum0RTEa2mov4A6em9Cc9isnWCZNAnP7wMbQD
         tilFVJ/29kSiysiwIJgEWHSLZmIJHT7LLU0+D4N1YWVsUUlPGcVanLJm//sCg1gLsG
         iAo2+g8VBL0HEmmHP+06It8LAbD3m4H0q5Jv8sLw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230720092958epcas2p337adc17ec76a86125b70561a74631592~ziW-Q5fAI3131731317epcas2p3s;
        Thu, 20 Jul 2023 09:29:58 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R66pt01VKz4x9Px; Thu, 20 Jul
        2023 09:29:58 +0000 (GMT)
X-AuditID: b6c32a43-2f3ff7000001d7ef-00-64b8fe9563f7
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.B5.55279.59EF8B46; Thu, 20 Jul 2023 18:29:57 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] md/bitmap: Avoid protection error writing bitmap page
 with block integrity
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     "song@kernel.org" <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230720092957epcms2p6cbd0ecdf7f5bf0db3c04eefaf0a6644d@epcms2p6>
Date:   Thu, 20 Jul 2023 18:29:57 +0900
X-CMS-MailID: 20230720092957epcms2p6cbd0ecdf7f5bf0db3c04eefaf0a6644d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmhe7UfztSDP4vNrN4eUjTord/K5vF
        5V1z2Cza5+9itHg5K83i+PK/bA5sHptWdbJ5PDk3gdmjb8sqRo/Pm+QCWKKybTJSE1NSixRS
        85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAVisplCXmlAKFAhKLi5X0
        7WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjNWnYos2C9W8enu
        L+YGxqcCXYycHBICJhJ3OtexdDFycQgJ7GCUuDbpBmsXIwcHr4CgxN8dwiA1wgIJEm3LN7CA
        2EICShLn1sxihIgbSLTcbgOLswnoSex4vpsdxBYRWMoo8agbbD6zgLHE8tebmCF28UrMaH/K
        AmFLS2xfvpURwtaQ+LGsF6pGVOLm6rfsMPb7Y/OhakQkWu+dhaoRlHjwczdUXFLi0KGvbCAn
        SwjkS2w4EAgRrpFo+/Ueqlxf4lrHRrC1vAK+EkdfPAJrZRFQlejbsRVqlYvE/mXXmCFOlpfY
        /nYOM8hIZgFNifW79CGmK0scucUCUcEn0XH4LzvMUw0bf2Nl75j3hAmiVU1iUZMRRFhG4uvh
        +ewTGJVmIUJ5FpK1sxDWLmBkXsUollpQnJuemmxUYAiP1+T83E2M4ASo5byD8cr8f3qHGJk4
        GA8xSnAwK4nwPrq8LUWINyWxsiq1KD++qDQntfgQoynQwxOZpUST84EpOK8k3tDE0sDEzMzQ
        3MjUwFxJnPde69wUIYH0xJLU7NTUgtQimD4mDk6pBqY0HreiYl6f3xyfevb5/7yZNWlmo2vs
        zl28DEtstPY0TQpmSLob+Pttge5Bu/ZUKbV94g9nFjxqcfJQ5r6mt7zjY+7ibXPPRN/e3S8h
        ftTH7VngtYMPMn/4r8q9p2Z5/1MExx/Bu0/OyvY+cw7yZg8XniqvdeBRsOqlPT6cB/ednS/N
        MH19iM3Rx5fk+6RkFqh1/3U4bcNWtmvFg0kbF3uqX8uYNykgbJVusZbv2VYvDq09XqeLVpqt
        yZf50D7x5LJ+4XuOCo8Yv0cmLzwX2Rn+Z0qR2qyJU/72/T9acEVGsOP7e82XNw6VfA1bvvJh
        ypSglmx5adYoG6UDZvve3w0pv1kpFMu7tVNLgXH+YlklluKMREMt5qLiRADA68L5CQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230720092957epcms2p6cbd0ecdf7f5bf0db3c04eefaf0a6644d
References: <CGME20230720092957epcms2p6cbd0ecdf7f5bf0db3c04eefaf0a6644d@epcms2p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the bitmap page is also possible on the page where the DMA is
being performed or scheduled in the MD.

When configuring raid1 (mirror) with devices that support block integrity,
the same bitmap page is sent to the device twice during the resync process,
causing the following problems.
(When requeue is executed, integrity is not updated)

             [Func 1]                          [Func 2]

1     A(page) + a(integrity)
2        (sq doorbell)
3                                          A(page) -> A-1(page)
4  A-1(page-updated) + a(integrity)     A-1(page) + a-1(integrity)
5                                            (sq doorbell)
6           (DMA)                                (DMA)

       I/O Fail and retry N                   I/O Success
       To be Faulty Device

My Test Env: Two FIPS PM1743
- nvme format /dev/nvme2n1 --force -n 1 -i 1 -p 0 -m 0 -l 1 -r
- nvme format /dev/nvme3n1 --force -n 1 -i 1 -p 0 -m 0 -l 1 -r
- mdadm -C /dev/md0 -l 1 -n 2 /dev/nvme2n1 /dev/nvme3n1

The following is the log when a problem occurs. The problematic device
is in the faulty device state.

Log:
[  135.037253] md/raid1:md0: active with 2 out of 2 mirrors
[  135.038228] md0: detected capacity change from 0 to 7501212288
[  135.038270] md: resync of RAID array md0
[  151.252172] nvme2n1: I/O Cmd(0x1) @ LBA 16, 8 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[  151.252180] protection error, dev nvme2n1, sector 16 op 0x1:(WRITE) flags 0x10800 phys_seg 1 prio class 2
[  151.252185] md: super_written gets error=-84
[  151.252187] md/raid1:md0: Disk failure on nvme2n1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
[  151.267450] nvme3n1: I/O Cmd(0x1) @ LBA 16, 8 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[  151.267457] protection error, dev nvme3n1, sector 16 op 0x1:(WRITE) flags 0x10800 phys_seg 1 prio class 2
[  151.267460] md: super_written gets error=-84
[  151.268458] md: md0: resync interrupted.
[  151.320765] md: resync of RAID array md0
[  151.321205] md: md0: resync done.

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/md/md-bitmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 1ff712889a3b..dfb7418ba48a 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -467,6 +467,13 @@ void md_bitmap_update_sb(struct bitmap *bitmap)
 		return;
 	if (!bitmap->storage.sb_page) /* no superblock */
 		return;
+
+	/*
+	 * Before modifying the bitmap page and re-issue it, wait for
+	 * the requests previously sent to the device to be completed.
+	 */
+	md_bitmap_wait_writes(bitmap);
+
 	sb = kmap_atomic(bitmap->storage.sb_page);
 	sb->events = cpu_to_le64(bitmap->mddev->events);
 	if (bitmap->mddev->events < bitmap->events_cleared)
-- 
2.34.1
