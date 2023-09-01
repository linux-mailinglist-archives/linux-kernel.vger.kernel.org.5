Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B27678FE59
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349762AbjIANfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243852AbjIANfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:35:52 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2994CDD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1693575349;
  x=1725111349;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=N6etfJze35By8LfXFdbrd19JU35OJUDOzD8xl1EMvVU=;
  b=g6J/z+eRoPn24Kcd48V58L2pgTYOz5TSCQPqEqab4msIinREYNZPlC2p
   RuYMY84KZMWM5fOsVkSOZnDr1QB4nE6XnRIji0P6QbztNtBjupRF7X9Rh
   qmd2dtC9ufDQqYvr9H4x2LTE4ZFxLVpPIkj++VbAGvkHU1X4OGqZwgwAJ
   XpOq5d7v/IiVfDZvHlRBl2xJNrYLSWGQGtnk7gR5/4MO2FM8/n1QV0e/d
   q1FoP3o1DQYSFjMucLEhlLp1foG1IEqJINyD7hC5X/vHHv0GmS7UJFsTI
   R4XCwb4KmA54E7eWVmSNB+C9vyo4i0suyATDO5hlwxItzrsbfTug2MvNU
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 1 Sep 2023 15:35:43 +0200
Subject: [PATCH] um: virt-pci: fix platform map offset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230901-uml-virt-offset-v1-1-5c1f320a037d@axis.com>
X-B4-Tracking: v=1; b=H4sIAK7o8WQC/x3MSQqAMAxA0atI1gZaJ6hXERfSJhpwotUiFO9uc
 fkW/ycI5IUC9EUCT1GCHHuGLguwy7TPhOKyoVJVrYzSeG8rRvEXHsyBLnSm0Ww7tk3rIFenJ5b
 nPw7j+34PfYvcYQAAAA==
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offset is currently always zero so the backend can't distinguish
between accesses to different ioremapped areas.

Fixes: 522c532c4fe7 ("virt-pci: add platform bus support")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/drivers/virt-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 7699ca5f35d4..2adcd14e1d74 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -969,7 +969,7 @@ static long um_pci_map_platform(unsigned long offset, size_t size,
 	*ops = &um_pci_device_bar_ops;
 	*priv = &um_pci_platform_device->resptr[0];
 
-	return 0;
+	return offset;
 }
 
 static const struct logic_iomem_region_ops um_pci_platform_ops = {

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230901-uml-virt-offset-d941fc6fc45d

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

