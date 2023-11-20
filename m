Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94C97F0AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjKTDVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjKTDVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:21:18 -0500
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D26194;
        Sun, 19 Nov 2023 19:21:10 -0800 (PST)
X-QQ-mid: bizesmtp78t1700450355t9vmqoeh
Received: from localhost.localdomain ( [183.211.219.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 20 Nov 2023 11:19:05 +0800 (CST)
X-QQ-SSF: 01400000000000807000000A0000000
X-QQ-FEAT: swyrzWPvyR3eYwFMS4ZuTZqaE5VECqJG2sDyi+/ZKc+iDJhV17Gi8UJfniNEZ
        UKdk5us6A2u9/FPZHzcekiTA7dZT9YvTWY400JmkgVE9ej+k5xjf0y56TfVl3Yh19KTDxgo
        D0WlmuHzsK2Hl/5+h1LAWYjPMuZm94QJiTGStCiWhjiQRWvLxyZn/OE+ByIM7bPEThbPbqh
        HfhgAeo/rmyxXUtrXdW0e9MwHr6hnSSDvxAyV4bUfNqK2gq+lfAUHGUBH8jbhdc3b8B52xG
        vqbpVuhUMhiK9vagf/K8hYbrt0uWvBKtUc+ncCB12dJZfKzg2sornVMjKYLAhi8D/Kr3VnZ
        l7ASSF8elCPHmROQ2Sm13rwkalUgzaBkbgrf/p4RqkPu47aBQKR9UC74Rag3Q2uy0K6sSrw
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10945035250043291984
From:   JianChunfu <chunfu.jian@shingroup.cn>
To:     alex.williamson@redhat.com, cohuck@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        shenghui.qu@shingroup.cn, JianChunfu <chunfu.jian@shingroup.cn>
Subject: [PATCH] vfio/pci: Separate INTx-enabled vfio_pci_device from unenabled to make the code logic clearer.
Date:   Mon, 20 Nov 2023 11:17:52 +0800
Message-Id: <20231120031752.522139-1-chunfu.jian@shingroup.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems a little unclear when dealing with vfio_intx_set_signal()
because of vfio_pci_device which is irq_none,
so separate the two situations.

Signed-off-by: JianChunfu <chunfu.jian@shingroup.cn>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 6069a11fb51a..b6d126c48393 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -468,6 +468,8 @@ static int vfio_pci_set_intx_trigger(struct vfio_pci_core_device *vdev,
 				     unsigned index, unsigned start,
 				     unsigned count, uint32_t flags, void *data)
 {
+	int32_t fd = *(int32_t *)data;
+
 	if (is_intx(vdev) && !count && (flags & VFIO_IRQ_SET_DATA_NONE)) {
 		vfio_intx_disable(vdev);
 		return 0;
@@ -476,28 +478,25 @@ static int vfio_pci_set_intx_trigger(struct vfio_pci_core_device *vdev,
 	if (!(is_intx(vdev) || is_irq_none(vdev)) || start != 0 || count != 1)
 		return -EINVAL;
 
-	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
-		int32_t fd = *(int32_t *)data;
+	if (!is_intx(vdev)) {
 		int ret;
+		if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
+			ret = vfio_intx_enable(vdev);
+			if (ret)
+				return ret;
 
-		if (is_intx(vdev))
-			return vfio_intx_set_signal(vdev, fd);
+			ret = vfio_intx_set_signal(vdev, fd);
+			if (ret)
+				vfio_intx_disable(vdev);
 
-		ret = vfio_intx_enable(vdev);
-		if (ret)
 			return ret;
-
-		ret = vfio_intx_set_signal(vdev, fd);
-		if (ret)
-			vfio_intx_disable(vdev);
-
-		return ret;
+		} else
+			return -EINVAL;
 	}
 
-	if (!is_intx(vdev))
-		return -EINVAL;
-
-	if (flags & VFIO_IRQ_SET_DATA_NONE) {
+	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
+		return vfio_intx_set_signal(vdev, fd);
+	} else if (flags & VFIO_IRQ_SET_DATA_NONE) {
 		vfio_send_intx_eventfd(vdev, NULL);
 	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 		uint8_t trigger = *(uint8_t *)data;
-- 
2.27.0

