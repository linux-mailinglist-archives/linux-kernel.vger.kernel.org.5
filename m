Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9C67EB0F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjKNNdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjKNNdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:33:41 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B32E1B9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:33:37 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SV6c84nrcz1P7Vg;
        Tue, 14 Nov 2023 21:30:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 21:33:35 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <suzuki.poulose@arm.com>, <james.clark@arm.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>,
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 0/4] Fixed some issues and cleanup of ultrasoc-smb
Date:   Tue, 14 Nov 2023 21:33:42 +0800
Message-ID: <20231114133346.30489-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the Three issues listed below and use guards to cleanup
a) Fixed the BUG of atomic-sleep
b) Fixed uninitialized before use buf_hw_base
c) Fixed use unreset SMB buffer

Changes since V2:
 * Ignore the return value of smb_config_inport()

Link to V2: https://lore.kernel.org/lkml/20231021083822.18239-1-hejunhao3@huawei.com/

Changes since V1:
 * Add comment for remove lock from smb_read()
 * Move reset buffer to before register sink
 * Remove patch "simplify the code for check to_copy valid"
 * Add two new patches

Link to V1: https://lore.kernel.org/lkml/20231012094706.21565-1-hejunhao3@huawei.com/

Junhao He (4):
  coresight: ultrasoc-smb: Fix sleep while close preempt in enable_smb
  coresight: ultrasoc-smb: Config SMB buffer before register sink
  coresight: ultrasoc-smb: Fix uninitialized before use buf_hw_base
  coresight: ultrasoc-smb: Use guards to cleanup

 drivers/hwtracing/coresight/ultrasoc-smb.c | 108 +++++++--------------
 drivers/hwtracing/coresight/ultrasoc-smb.h |   6 +-
 2 files changed, 38 insertions(+), 76 deletions(-)

-- 
2.33.0

