Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB8C7E0080
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjKCGwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjKCGwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:52:18 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC28D62
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:52:01 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id yo22qYVa0AjXCyo23qif6F; Fri, 03 Nov 2023 07:51:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698994319;
        bh=n3o0U+wAFJJNSDWSL3836YjnJRjiy8QhH+Wkq/Yn51o=;
        h=From:To:Cc:Subject:Date;
        b=diOpSTwXP/J+BlqjMz2GK0G4WL37Q0A9k7gZjINd9ID5+BcMHrMnLHajr04Y/yaTi
         24jR7sPTfQPOYIMXn0xrk4agCJg6SXzuIY2fsB11cMKYTCjB1Iw2R/BTErCj2XEXjJ
         BEJpvIqdUmL4yU3lD06geJdW86LJOMqflhEl8SUVNueC2ZfZ+UdX+uF5N0AuWavuB7
         bOl62rmtodGA6ENCwnGN4w7y+4MYSU56+IRQxl41tcOvkZowuKGrTr5nkMpdUE/NjX
         jBJFnD597guFynfG3xd+i9CyOmI6u2611RQbGm1hKYDZ3Klq/i/jdCGRSxsiLwfo9+
         3+0SrekV5Q6Ww==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 03 Nov 2023 07:51:59 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rostedt@goodmis.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, willy@infradead.org,
        senozhatsky@chromium.org
Cc:     list@mail.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] xhci: Shrink struct xhci_interval_bw
Date:   Fri,  3 Nov 2023 07:51:46 +0100
Message-Id: <cbce7d95783a259f11ab2dc917cbee49cb5b754d.1698994203.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct xhci_interval_bw can be reordered to shrink it from 40 to 32
bytes.
This makes sense because it is used in struct xhci_interval_bw_table in an
array of XHCI_MAX_INTERVAL (i.e. 16) values. So this struct is shrunk by
128 bytes and is more cacheline friendly.

On x86_64 we have:

struct xhci_interval_bw {
	unsigned int               num_packets;          /*     0     4 */

	/* XXX 4 bytes hole, try to pack */

	struct list_head           endpoints;            /*     8    16 */
	unsigned int               overhead[3];          /*    24    12 */

	/* size: 40, cachelines: 1, members: 3 */
	/* sum members: 32, holes: 1, sum holes: 4 */
	/* padding: 4 */
	/* last cacheline: 40 bytes */
};

After the change:
struct xhci_interval_bw {
	struct list_head           endpoints;            /*     0    16 */
	unsigned int               num_packets;          /*    16     4 */
	unsigned int               overhead[3];          /*    20    12 */

	/* size: 32, cachelines: 1, members: 3 */
	/* last cacheline: 32 bytes */
};

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/host/xhci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 3ea5c092bba7..0430646a3a05 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -956,13 +956,13 @@ enum xhci_overhead_type {
 };
 
 struct xhci_interval_bw {
-	unsigned int		num_packets;
 	/* Sorted by max packet size.
 	 * Head of the list is the greatest max packet size.
 	 */
 	struct list_head	endpoints;
 	/* How many endpoints of each speed are present. */
 	unsigned int		overhead[3];
+	unsigned int		num_packets;
 };
 
 #define	XHCI_MAX_INTERVAL	16
-- 
2.34.1

