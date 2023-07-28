Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E197665D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjG1Hzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjG1Hzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:55:43 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3636730EA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:55:41 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230728075539epoutp04c5c6f4c1bdafe5c75759c0313e3f9a77~1_O6ziZgI2198621986epoutp04D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:55:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230728075539epoutp04c5c6f4c1bdafe5c75759c0313e3f9a77~1_O6ziZgI2198621986epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690530939;
        bh=yUpcGFL91ifhUTlYDbflLFZWGIFU3cqbPQ0gntPnnws=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=sEm+KUr0/EH2VM/Vba+UHITaNHG6jgJePErXX/O5ZP2jaePAccdYNVAXGF7ChmEia
         l+H10U1COujtbnYqsgTaEDJQjCKSnvt3VGFKPCXSzyOmuVXEFyKbyGcWSvIlCGjFjj
         nqvHZzhGMPSu5QbOAMGhhfxH1SlIktTuPfseJqhk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230728075538epcas2p4eb05711ca66a592463cce43b3f885deb~1_O6MzqiS2694026940epcas2p4E;
        Fri, 28 Jul 2023 07:55:38 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RC0LL0ZZJz4x9QK; Fri, 28 Jul
        2023 07:55:38 +0000 (GMT)
X-AuditID: b6c32a43-2f3ff7000001d7ef-8e-64c3747909ff
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.D1.55279.97473C46; Fri, 28 Jul 2023 16:55:37 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 0/2] multi-page bvec configuration for integrity payload
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p1>
Date:   Fri, 28 Jul 2023 16:55:37 +0900
X-CMS-MailID: 20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmqW5lyeEUg2fNlhar7/azWcy6/ZrF
        4uUhTYuVq48yWfT2b2WzmHToGqPF3lvaFpd3zWGzWH78H5PFutfvWRy4PM7f28jicflsqcem
        VZ1sHrtvNrB5fHx6i8Wjb8sqRo/Pm+Q82g90MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7
        x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdqKRQlphTChQKSCwuVtK3synKLy1JVcjILy6x
        VUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIztg6tZu14JJQxZ6jig2MP/i6GDk5JARM
        JP7372LuYuTiEBLYwShxdvN+1i5GDg5eAUGJvzuEQWqEBTwktj04xwxiCwkoSZxbM4sRIm4g
        0XK7jQXEZhPQk9jxfDc7yBwRgQnMEps33WaGWMArMaP9KQuELS2xfflWRghbQ+LHsl6oGlGJ
        m6vfssPY74/Nh6oRkWi9dxaqRlDiwc/dUHFJiUOHvrKB3CkhkC+x4UAgRLhGou3Xe6hyfYlr
        HRvB1vIK+EpsmjcNrJVFQFVi9o6TrBA1LhIr2nvA4swC8hLb385hBhnJLKApsX6XPsR0ZYkj
        t1ggKvgkOg7/ZYd5qmHjb6zsHfOeMEG0qkksajKCCMtIfD08H6rEQ2LJrfmMExgVZyGCeRaS
        E2YhnLCAkXkVo1hqQXFuemqyUYEhPGKT83M3MYITqpbzDsYr8//pHWJk4mA8xCjBwawkwnsq
        4FCKEG9KYmVValF+fFFpTmrxIUZToOcnMkuJJucDU3peSbyhiaWBiZmZobmRqYG5kjjvvda5
        KUIC6YklqdmpqQWpRTB9TBycUg1MM0+YfNK67aCWlHBop8qVFZem5T5UjZsitWjjkyNdNq8k
        D834Y9ga9nV19pqby45kzFNnWbOpXs/7weHct6sONOyQ4rhs4VCzziXr1bz4pcaK+6PnLn3r
        skhQesp9c661kUuUlgl/We03eUmZ1rrWBYKv5Ja/2af9NdHb8v4B77PP/b6WfpzRa/Brxpye
        JJ2btoEvtwvyW5/8v02Hf1248ZQ3uw96FKzxZLL0n9Bkunbprw1n0zfwO7jMZZt4MFaFR2hp
        ikvv8d3vBXqi+mfauMyQXrTR/szfvWZz7xqdy0tmntb90HDJFE7eaMfjc/c4FF09eM64NzF9
        Bz+Hi8iykNK9lj+Ea46+3zrR0FJy8UMlluKMREMt5qLiRABojWzqMQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63
References: <CGME20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
As the bip configuration changed, the code related to sg_list was
also modified.

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

Jinyoung Choi (2):
  block: make bvec_try_merge_hw_page() non-static
  bio-integrity: create multi-page bvecs in bio_integrity_add_page()

 block/bio-integrity.c | 50 ++++++++++++++++++++++++-------------------
 block/bio.c           |  2 +-
 block/blk.h           |  4 ++++
 3 files changed, 33 insertions(+), 23 deletions(-)

-- 
2.34.1
