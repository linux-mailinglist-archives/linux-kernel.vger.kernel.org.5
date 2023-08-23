Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37101785592
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjHWKlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjHWKk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:40:59 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCE2E52
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1692787253;
  x=1724323253;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=6LJ6BHzjxEmUNS9AR+aQcWxz25DB+rK6TaYI29lFdFE=;
  b=YHvU5wA6DeklNBntZuwpTBPlRekdW3X+bFZHRX7EMX7vHdaAQ5CXRqEv
   PBTVLDdcRUvNaKgI7gYgu06pMMT2bkGUvze4/AIQ8aaEweI07oDVB0vpu
   H3W3Iij9lFlZDQN/1ZDf/3zOdUmWQzEnRS4TwrWsvX27xgi/8+rodTJ29
   Qjf8cEHFWo11hLuvg5wMegOUVKbaoAomJVeGHTpgK9vbDKRazHwOtg6fX
   lHa2AehxussRz2zebMRB3gWc6VQ9VWEdy15xQ1rhgh15hhP5Mer0R5pAp
   BJPy2lQJYnmFAc30LWJ5L9aHNJMnFycyuRkOEeYhJGyCKO0yE0kHqGoHH
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Wed, 23 Aug 2023 12:40:44 +0200
Subject: [PATCH] um: virt-pci: fix missing declaration warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230823-uml-virt-pci-warn-v1-1-fd43183a10d6@axis.com>
X-B4-Tracking: v=1; b=H4sIACvi5WQC/x3MSQqAMAxA0atI1ga04oBXERe1phrQKqkTFO9uc
 fkW/wfwJEwe2iSA0MWeNxeRpwmYWbuJkMdoUJkqskYVeK4LXiwH7obx1uKwKgdt6rHR1lQQu13
 I8vM/u/59P4J7sxRjAAAA
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, kernel test robot <lkp@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this warning which appears with W=1 and without CONFIG_OF:

 warning: no previous declaration for 'pcibios_get_phb_of_node'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308230949.PphIIlhq-lkp@intel.com/
Fixes: 314a1408b79a ("um: virt-pci: implement pcibios_get_phb_of_node()")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/drivers/virt-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 7699ca5f35d4..ffe2ee8a0246 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -544,6 +544,7 @@ static void um_pci_irq_vq_cb(struct virtqueue *vq)
 	}
 }
 
+#ifdef CONFIG_OF
 /* Copied from arch/x86/kernel/devicetree.c */
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 {
@@ -562,6 +563,7 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 	}
 	return NULL;
 }
+#endif
 
 static int um_pci_init_vqs(struct um_pci_device *dev)
 {

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230823-uml-virt-pci-warn-65bac7d8afc6

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

