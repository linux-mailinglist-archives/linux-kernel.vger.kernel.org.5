Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E22770258
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjHDNzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHDNzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:55:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD0FCC;
        Fri,  4 Aug 2023 06:55:37 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RHRxG1MSSz1Z1S8;
        Fri,  4 Aug 2023 21:52:50 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 21:55:34 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yuehaibing@huawei.com>
Subject: [PATCH -next] xhci: Remove unused function declarations
Date:   Fri, 4 Aug 2023 21:55:20 +0800
Message-ID: <20230804135520.20964-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 674f8438c121 ("xhci: split handling halted endpoints into two steps")
remove xhci_cleanup_stalled_ring() but leave declaration.
And commit 25355e046d29 ("xhci: use generic command timer for stop endpoint commands.")
left behind xhci_stop_endpoint_command_watchdog().
Commit b17a57f89f69 ("xhci: Refactor interrupter code for initial multi interrupter support.")
leave xhci_free_erst() declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/usb/host/xhci.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7e282b4522c0..4cae1d4b7a86 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2084,7 +2084,6 @@ int xhci_alloc_erst(struct xhci_hcd *xhci,
 		gfp_t flags);
 void xhci_initialize_ring_info(struct xhci_ring *ring,
 			unsigned int cycle_state);
-void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst);
 void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
 		unsigned int ep_index);
@@ -2184,10 +2183,6 @@ int xhci_queue_reset_ep(struct xhci_hcd *xhci, struct xhci_command *cmd,
 		enum xhci_ep_reset_type reset_type);
 int xhci_queue_reset_device(struct xhci_hcd *xhci, struct xhci_command *cmd,
 		u32 slot_id);
-void xhci_cleanup_stalled_ring(struct xhci_hcd *xhci, unsigned int slot_id,
-			       unsigned int ep_index, unsigned int stream_id,
-			       struct xhci_td *td);
-void xhci_stop_endpoint_command_watchdog(struct timer_list *t);
 void xhci_handle_command_timeout(struct work_struct *work);
 
 void xhci_ring_ep_doorbell(struct xhci_hcd *xhci, unsigned int slot_id,
-- 
2.34.1

