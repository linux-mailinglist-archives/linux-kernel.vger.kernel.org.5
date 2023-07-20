Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9329D75A610
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGTGMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGTGMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:12:42 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6691985
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:12:39 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230720061235epoutp02192610bb6075c8165bed400a83f482dc~zfqp2XwXK0977809778epoutp024
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:12:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230720061235epoutp02192610bb6075c8165bed400a83f482dc~zfqp2XwXK0977809778epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689833555;
        bh=jRCTcYQ3x8TsVhHR1VkW9kuA47n0/TpzfMl7OvVgLfk=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=m9PmIjeXuJ6eodYgECzyKa/agjmgneIs+j+C95LeR3GdewCgw2WVrUdr7l9FbHHOo
         YdjG5fH9OwGFKQeI84S9rvJ6h0mRU9XbA+r0c237lEQ5VqDZZ51mvNojAmyZlzFwxR
         MUN9crcqOoLj9KS4sOg9UDKxV3TWyXgKQxW9GZZw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230720061235epcas2p21379436d6c9f3b6ac2ca235e5127cad5~zfqpdssSI1724817248epcas2p2u;
        Thu, 20 Jul 2023 06:12:35 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R62R65zKlz4x9Q2; Thu, 20 Jul
        2023 06:12:34 +0000 (GMT)
X-AuditID: b6c32a43-2f3ff7000001d7ef-57-64b8d05241f0
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.D7.55279.250D8B46; Thu, 20 Jul 2023 15:12:34 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] md/bitmap: Fix bitmap page writing problem when using block
 integrity
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "song@kernel.org" <song@kernel.org>, "shli@fb.com" <shli@fb.com>,
        "neilb@suse.com" <neilb@suse.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230720061234epcms2p32e02cd528fc834491816b379ae189012@epcms2p3>
Date:   Thu, 20 Jul 2023 15:12:34 +0900
X-CMS-MailID: 20230720061234epcms2p32e02cd528fc834491816b379ae189012
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTTDfowo4UgzOdMhYvD2la9PZvZbO4
        vGsOm0X7/F2MFp82xlos29nPYnF8+V82B3aPic3v2D02repk8+jbsorRY/2WqywenzfJBbBG
        ZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAB2hpFCW
        mFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjO
        OHjsDWPBE9GKNdc3sTUw7hHoYuTkkBAwkbh5oo+xi5GLQ0hgB6PEtMsPgRwODl4BQYm/O4RB
        aoQFIiS+ffrMBGILCShJnFszC6xEWMBA4lavOUiYTUBP4ueSGWwgY0QEnjNK/Jx4gAViPq/E
        jPanULa0xPblWxkhbA2JH8t6mSFsUYmbq9+yw9jvj82HqhGRaL13FqpGUOLBz91QcUmJQ4e+
        soHcICGQL7HhQCBEuEbi7fIDUCX6Etc6NoKt5RXwlTj37z4riM0ioCox7/cHJogaF4ldZ9aD
        jWcWkJfY/nYOM8hIZgFNifW79CGmK0scucUCUcEn0XH4LzvMUw0bf2Nl75j3hAmiVU1iUZMR
        RFhG4uvh+VAlHhLHH15gnMCoOAsRyrOQnDAL4YQFjMyrGMVSC4pz01OTjQoM4RGbnJ+7iRGc
        FrWcdzBemf9P7xAjEwfjIUYJDmYlEd5Hl7elCPGmJFZWpRblxxeV5qQWH2I0BXp+IrOUaHI+
        MDHnlcQbmlgamJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXAdLAgcukzHaFW
        0wybVpXpW+XF/cUfq2eJHPpk15rOsTw22bw8Mydqetw9pcddjJtCVig++8p9cuoFW8kFvwIt
        vvRPfq3LOe33Pu+vCRY8r7huFD66wGnH/Md/7dEctpSXlzvXHyxaJ3PaJlZLafveiqWpxfcl
        vc6d49oifWzL673/Dfx0VPdx5M32jZD+vdyJQ1D/w7PXUS9+8j0OzJy+niNlkpCz94/Yk4Z2
        y+fL+sxmCA9bfuZwnogki+cui1f7jn4WzjmT9iDpkOZc1Wk1V/S0bl5bZnr3FQ9Xc+k55YIg
        sYq3linLT8gtFY7x1gjU2bhMP/7lwjW/MlUC2lZvONk+Y3XcxGeSnfzX+KUYlFiKMxINtZiL
        ihMBlZaviBQEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230720061234epcms2p32e02cd528fc834491816b379ae189012
References: <CGME20230720061234epcms2p32e02cd528fc834491816b379ae189012@epcms2p3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be careful when changing the page to perform DMA.
Changing the bitmap page is also possible on the page where the DMA is
being performed or scheduled in the MD.

When configuring raid1(mirror) with devices that support block integrity,
the same bitmap page is sent to the device twice during the resync process,
causing the following problems.
(When requeue is executed, integrity is not updated)

             [Func 1]                         [Func 2]

1     A(page) + a(integrity)
2        (sq doorbell)
3                                         A(page) -> A-1(page)
4  A-1(page-updated) + a(integiry)     A-1(page) + a-1(integrity)
5      	                                    (sq doorbell)
6           (DMA)                               (DMA)

	I/O Fail and retry N                 I/O Success
	To be Faulty Device

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

Fixes: 85c9ccd4f026 ("md/bitmap: Don't write bitmap while earlier writes might be in-flight")
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
