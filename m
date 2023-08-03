Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD5176DE76
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjHCCrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjHCCrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:47:06 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753D29B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 19:46:59 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230803024657epoutp039a98167818338ae7e7d8ce44156cb488~3v5GkxRvo2923329233epoutp03y
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:46:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230803024657epoutp039a98167818338ae7e7d8ce44156cb488~3v5GkxRvo2923329233epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691030817;
        bh=PwO6EleDN2/9BZS0MgsO4FzRedJIuZjGAgP/GjGmsxM=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=ra7AdzDDRLI4/Hz9IZOsl3RVZm1PeV0qE8UeMShoWLh7/mr/uoH8GGCVaGH3w4QWI
         0ZRTnKjMNNodawEmPbMQE7IqzhGwemsd60iDyUh6yFOYRGhtDL83k5QynMTHWIfWZa
         rQy85oiVH6HJrSZr/+64GXGQ3P+lTyEUL45SP0XE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230803024656epcas2p21235592e87f645b38610e486af8f4979~3v5GKuIWJ1584415844epcas2p2V;
        Thu,  3 Aug 2023 02:46:56 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RGYCN2wlrz4x9Pv; Thu,  3 Aug
        2023 02:46:56 +0000 (GMT)
X-AuditID: b6c32a46-6fdfa70000009cc5-80-64cb15201a31
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.A1.40133.0251BC46; Thu,  3 Aug 2023 11:46:56 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v3 0/4] multi-page bvec configuration for integrity payload
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
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
Message-ID: <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
Date:   Thu, 03 Aug 2023 11:46:56 +0900
X-CMS-MailID: 20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmha6C6OkUg65mUYvVd/vZLGbdfs1i
        8fKQpsXpCYuYLCYdusZosfeWtsXlXXPYLJYf/8dkse71exYHTo/z9zayeGxeoeVx+Wypx6ZV
        nWweH5/eYvHo27KK0ePzJjmP9gPdTAEcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUC3KSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
        zAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM+5/fsZcsE2sYu6e64wNjCcFuxg5OSQETCQmn1rK
        3sXIxSEksINR4vfqB0xdjBwcvAKCEn93CIPUCAt4S8x8ep8RxBYSUJI4t2YWI0TcQKLldhsL
        iM0moCex4/lusDkiAnOYJS6tWcYKsYBXYkb7UxYIW1pi+/KtjBC2hsSPZb3MELaoxM3Vb9lh
        7PfH5kPViEi03jsLVSMo8eDnbqi4pMShQ1/ZQO6UEMiX2HAgECJcI9H26z1Uub7EtY6NYGt5
        BXwlHjw8BWazCKhKPG1bzARR4yKx7ttpsLXMAvIS29/OYQYZySygKbF+lz7EdGWJI7dYICr4
        JDoO/2WHeaph42+s7B3znjBBtKpJLGoyggjLSHw9PB+qxEOi6+RexgmMirMQwTwLyQmzEE5Y
        wMi8ilEstaA4Nz212KjACB6zyfm5mxjBaVTLbQfjlLcf9A4xMnEwHmKU4GBWEuGV/n08RYg3
        JbGyKrUoP76oNCe1+BCjKdDzE5mlRJPzgYk8ryTe0MTSwMTMzNDcyNTAXEmc917r3BQhgfTE
        ktTs1NSC1CKYPiYOTqkGpvoz9/1vHbrtVlVQ8oP/xDanU+Xr8lqrvEK2pC862v1vI7edhd2f
        QxM3XJv47lqnjZ/smi1KEpzN+xyY38ZxXdXeI/xSU2jxm4uXtc7ntBbXTVJwda7+eFs2s2px
        jH9+wo/c3UtSqlUfdeb4MUzdWZW4IVaV0di5ypQvRaZ+28LeyRInl8sK8VxIzrP9Esc1f7GZ
        1Gp316s7XRyeMiicOssbsOXvztYCScbQBpO/t88af09Wienjko3b/37+5ivr3BTdcj4HaPj6
        xbQHzLrdukyhyed4RG7BztNNwV1HdvdOUlWwq7l0Lqzzs0h87UvNfKZdMu+KPPSeHnEQLNh2
        JLy3/XHP3Ezf748FL+1SYinOSDTUYi4qTgQACBWlaywEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524
References: <CGME20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Changes to v2:
- apply review related to comment (by Christoph)

Changes to v1:
- add a patch to modify the location of the bi_size update code.
- split a patch (create multi-page bvecs in bio_integirty_add_page()).

Jinyoung Choi (4):
  block: make bvec_try_merge_hw_page() non-static
  bio-integrity: update the payload size in bio_integrity_add_page()
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
