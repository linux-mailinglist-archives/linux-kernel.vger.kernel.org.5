Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315EE7696BA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjGaMsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjGaMrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:47:48 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053281BEC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:47:29 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230731124711epoutp040672a0d3201dd87d4b2a1291523e4929~29JU51KzD0581105811epoutp04G
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:47:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230731124711epoutp040672a0d3201dd87d4b2a1291523e4929~29JU51KzD0581105811epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690807631;
        bh=nbKWEanf4a/xZ1MFCZC3I9H5fUDOvIaLAmXBrH8FUm4=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=lQFMLQsvnY+3X3aZF+mmUgxPJJ+YByKcPeIjME6amz4opjrzmoH217PBbrdvENKzd
         pZC+TmbeWfYOPCj1/ZoLIWTQp3+4QOldrGmN683321AQtoX9WSvFfiTe5W0TidVSy5
         JeUqPrjiv05ZRTzA1beM0fR27IUScQTwq2oht1yE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230731124711epcas2p49be822d336488e8f3ac50b3b360168ef~29JUlZgDZ2322123221epcas2p46;
        Mon, 31 Jul 2023 12:47:11 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RDygM0Hrfz4x9Pq; Mon, 31 Jul
        2023 12:47:11 +0000 (GMT)
X-AuditID: b6c32a46-6fdfa70000009cc5-94-64c7ad4eda76
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.AA.40133.E4DA7C46; Mon, 31 Jul 2023 21:47:10 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 0/4] multi-page bvec configuration for integrity payload
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p5>
Date:   Mon, 31 Jul 2023 21:47:10 +0900
X-CMS-MailID: 20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTQtdv7fEUg4d3rC1W3+1ns5h1+zWL
        xctDmhaTDl1jtNh7S9vi8q45bBbLj/9jslj3+j2LA4fH+XsbWTwuny312LSqk83j49NbLB59
        W1YxenzeJOfRfqCbKYA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
        1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWle
        ul5eaomVoYGBkSlQYUJ2xvaJj9kKPohWvDi9gqWBcZJgFyMHh4SAicS/5UAmF4eQwA5GifZz
        R1hB4rwCghJ/dwh3MXJyCAt4S9zYvYsNxBYSUJI4t2YWI0TcQKLldhsLiM0moCex4/ludpA5
        IgKfmSQu//jACpKQEOCVmNH+lAXClpbYvnwrI4StIfFjWS8zhC0qcXP1W3YY+/2x+VA1IhKt
        985C1QhKPPi5GyouKXHo0Fc2iPvzJTYcCIQI10i0/XoPVa4vca1jI9haXgFfidvvG8HuZxFQ
        lZi/cyITRI2LxIbHS8DizALyEtvfzmEGGcksoCmxfpc+xHRliSO3WCAq+CQ6Dv9lh3mqYeNv
        rOwd854wQbSqSSxqMoIIy0h8PTwfqsRDYtHMCUwTGBVnIYJ5FpITZiGcsICReRWjWGpBcW56
        arFRgRE8YpPzczcxglOmltsOxilvP+gdYmTiYDzEKMHBrCTCeyrgUIoQb0piZVVqUX58UWlO
        avEhRlOg5ycyS4km5wOTdl5JvKGJpYGJmZmhuZGpgbmSOO+91rkpQgLpiSWp2ampBalFMH1M
        HJxSDUzx5n+FDid9qZlke7ZRIeOVxHGuAK9HMw9+qjMueTxv4sXcV19jQ5c8fBi2RvXenzy9
        Wz4Pd8j96PMNbb/Kba73KH1Wos9S+b61EyZPPHUmKWvi0a83ZdbcdnE2DqsS4jZpCuTjPXRd
        6cHX7Rs3JDx40Nkx7V5/YMCfYomUrhQpzWLfwGKG22Xv418ubfn5enbr15wLE/fNz+ZZ9ZT/
        yroDrOGf/Msv26a+VvC4IZsSnnksiW3ioanNu8L7QntyldhWNj12LNsve5JDpO1/vPyFLqYY
        pYYt1bu5YgI4/uwQFs7Of+OptZHXY/asklM3rrnErrIq/XaqM6wta/7MxHgeqeTUrbsOcrUk
        Nf22yVJiKc5INNRiLipOBADp8VpVIgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5
References: <CGME20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p5>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of NVMe, it has an integrity payload consisting of one segment.
So, rather than configuring SG_LIST, it was changed by direct DMA mapping.

The page-merge is not performed for the struct bio_vec when creating 
a integrity payload in block.
As a result, when creating an integrity paylaod beyond one page, each 
struct bio_vec is generated, and its bv_len does not exceed the PAGESIZE.

To solve it, bio_integrity_add_page() should just add to the existing 
bvec, similar to bio_add_page() and friends. 

(ref: https://lore.kernel.org/linux-nvme/yq18rewbmay.fsf@ca-mkp.ca.oracle.com/T/#t)


Tested like this:

- Format (support pi)
$ sudo nvme format /dev/nvme2n1 --force -n 1 -i 1 -p 0 -m 0 -l 1 -r

- Run FIO
[global]
ioengine=libaio
group_reporting

[job]
bs=512k
iodepth=256
rw=write
numjobs=8
direct=1
runtime=10s
filename=/dev/nvme2n1

- Result
...
[   93.496218] nvme2n1: I/O Cmd(0x1) @ LBA 62464, 1024 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[   93.496227] protection error, dev nvme2n1, sector 62464 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
[   93.538788] nvme2n1: I/O Cmd(0x1) @ LBA 6144, 1024 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[   93.538798] protection error, dev nvme2n1, sector 6144 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
[   93.566231] nvme2n1: I/O Cmd(0x1) @ LBA 124928, 1024 blocks, I/O Error (sct 0x0 / sc 0x4)
[   93.566241] I/O error, dev nvme2n1, sector 124928 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
[   93.694147] nvme2n1: I/O Cmd(0x1) @ LBA 64512, 1024 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[   93.694155] protection error, dev nvme2n1, sector 64512 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
[   93.694299] nvme2n1: I/O Cmd(0x1) @ LBA 5120, 1024 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
[   93.694305] protection error, dev nvme2n1, sector 5120 op 0x1:(WRITE) flags 0x18800 phys_seg 3 prio class 2
...

Changes to v1:
- add a patch to modify the location of the bi_size update code.
- split a patch (create multi-page bvecs in bio_integirty_add_page()).

Jinyoung Choi (4):
  block: make bvec_try_merge_hw_page() non-static
  bio-integrity: Sets the payload size in bio_integrity_add_page()
  bio-integrity: cleanup adding integrity pages to bip's bvec.
  bio-integrity: create multi-page bvecs in bio_integrity_add_page()

 block/bio-integrity.c               | 49 ++++++++++++++++-------------
 block/bio.c                         |  2 +-
 block/blk.h                         |  4 +++
 drivers/md/dm-crypt.c               |  1 -
 drivers/nvme/host/ioctl.c           |  1 -
 drivers/nvme/target/io-cmd-bdev.c   |  3 +-
 drivers/target/target_core_iblock.c |  3 +-
 7 files changed, 35 insertions(+), 28 deletions(-)

-- 
2.34.1
