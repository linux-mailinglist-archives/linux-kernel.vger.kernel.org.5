Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7DD785080
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjHWGS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjHWGSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:18:21 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAEE184;
        Tue, 22 Aug 2023 23:18:17 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37N6Hrli025198;
        Wed, 23 Aug 2023 14:17:53 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RVwtn5Bn2z2QM4RY;
        Wed, 23 Aug 2023 14:15:29 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 23 Aug
 2023 14:17:51 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <yuelin.tang@unisoc.com>, Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH V2 0/2] mmc: hsq: Dynamically adjust hsq_depth to improve performance
Date:   Wed, 23 Aug 2023 14:17:32 +0800
Message-ID: <20230823061734.27479-1-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37N6Hrli025198
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change in v2:
- Support for dynamic adjustment of hsq_depth.

Test
=====
I tested 3 times for each case and output a average speed.
Ran 'fio' to evaluate the performance:
1.Fixed hsq_depth
1) Sequential write:
Speed: 168 164 165
Average speed: 165.67MB/S

2) Sequential read:
Speed: 326 326 326
Average speed: 326MB/S

3) Random write:
Speed: 82.6 83 83
Average speed: 82.87MB/S

4) Random read:
Speed: 48.2 48.3 47.6
Average speed: 48.03MB/S

2.Dynamic hsq_depth
1) Sequential write:
Speed: 167 166 166
Average speed: 166.33MB/S

2) Sequential read:
Speed: 327 326 326
Average speed: 326.3MB/S

3) Random write:
Speed: 86.1 86.2 87.7
Average speed: 86.67MB/S

4) Random read:
Speed: 48.1 48 48
Average speed: 48.03MB/S

Based on the above data, dynamic hsq_depth can improve the performance of random writes.
Random write improved by 4.6%.

Test cmd
=========
1)write: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=write -bs=512K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64									
2)read: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=read -bs=512K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64									
3)randwrite: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randwrite -bs=4K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64									
4)randread: fio -filename=/dev/mmcblk0p72 -direct=1 -rw=randread -bs=4K -size=512M -group_reporting -name=test -numjobs=8 -thread -iodepth=64									


Wenchao Chen (2):
  mmc: queue: replace immediate with hsq->depth
  mmc: hsq: dynamic adjustment of hsq->depth

 drivers/mmc/core/queue.c   |  6 +-----
 drivers/mmc/host/mmc_hsq.c | 27 +++++++++++++++++++++++++++
 drivers/mmc/host/mmc_hsq.h |  8 ++++++++
 include/linux/mmc/host.h   |  1 +
 4 files changed, 37 insertions(+), 5 deletions(-)

-- 
2.17.1

