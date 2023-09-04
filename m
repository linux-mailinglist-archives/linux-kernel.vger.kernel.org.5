Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EDD790FCF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 04:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350643AbjIDCFu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 3 Sep 2023 22:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350541AbjIDCFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 22:05:47 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Sep 2023 19:05:42 PDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C105EA9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:05:42 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,225,1688400000"; 
   d="scan'208";a="64204715"
From:   Fang Xiang <fangxiang3@xiaomi.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <fangxiang3@xiaomi.com>
Subject: [PATCH] irqchip/gic-v3-its: Mark GIC as non-shareable by OF property
Date:   Mon, 4 Sep 2023 10:04:31 +0800
Message-ID: <20230904020431.27057-1-fangxiang3@xiaomi.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.237.8.20]
X-ClientProxiedBy: BJ-MBX05.mioffice.cn (10.237.8.125) To BJ-MBX15.mioffice.cn
 (10.237.8.135)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_SOFTFAIL,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GIC600/GIC700 integration in some platforms does not support the
sharability feature. Commit a8707f553884 ("irqchip/gic-v3: Add
Rockchip 3588001 erratum workaround") added flags to indicate the
integration design error, but the quirk is just applied with
RK3588/RK3588S and GIC600.

The property are named "force-non-shareable" to be vendor agnostic,
since apparently similar integration design errors exist in other
platforms and they can reuse the same property in their GIC ITS
device-node.

Signed-off-by: Fang Xiang <fangxiang3@xiaomi.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e0c2b10d154d..2e92eac1e5f3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5055,6 +5055,16 @@ static int __init its_compute_its_list_map(struct resource *res,
        return its_number;
 }

+static void its_of_update_shareability(struct its_node *its)
+{
+       if (!fwnode_property_present(its->fwnode_handle,
+                               "force-non-shareable"))
+               return;
+
+       its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
+       gic_rdists->flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+}
+
 static int __init its_probe_one(struct resource *res,
                                struct fwnode_handle *handle, int numa_node)
 {
@@ -5130,6 +5140,7 @@ static int __init its_probe_one(struct resource *res,
        its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;

        its_enable_quirks(its);
+       its_of_update_shareability(its);

        err = its_alloc_tables(its);
        if (err)
--
2.34.1

#/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
