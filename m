Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955937F0E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjKTIyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjKTIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:54:18 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 889A49F;
        Mon, 20 Nov 2023 00:54:14 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 9910763394DBD;
        Mon, 20 Nov 2023 16:54:05 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     tomas.winkler@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com
Cc:     Su Hui <suhui@nfschina.com>, alexander.usyskin@intel.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] misc: mei: client.c: fix some error code problem in mei_cl_write
Date:   Mon, 20 Nov 2023 16:53:45 +0800
Message-Id: <20231120085343.157381-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang static analyzer complains that value stored to 'rets' is never
read. Remove some useless code, and let 'buf_len = -EOVERFLOW' to make
sure we can return '-EOVERFLOW'.

mei_msg_hdr_init() return negative error code, rets should be
'PTR_ERR(mei_hdr)' rather than '-PTR_ERR(mei_hdr)'.

Fixes: 0cd7c01a60f8 ("mei: add support for mei extended header.")
Fixes: 8c8d964ce90f ("mei: move hbuf_depth from the mei device to the hw modules")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/misc/mei/client.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 9c8fc87938a7..00dac0a47da0 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -2011,7 +2011,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long time
 
 	mei_hdr = mei_msg_hdr_init(cb);
 	if (IS_ERR(mei_hdr)) {
-		rets = -PTR_ERR(mei_hdr);
+		rets = PTR_ERR(mei_hdr);
 		mei_hdr = NULL;
 		goto err;
 	}
@@ -2020,19 +2020,17 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long time
 
 	if (rets == 0) {
 		cl_dbg(dev, cl, "No flow control credentials: not sending.\n");
-		rets = buf_len;
 		goto out;
 	}
 
 	if (!mei_hbuf_acquire(dev)) {
 		cl_dbg(dev, cl, "Cannot acquire the host buffer: not sending.\n");
-		rets = buf_len;
 		goto out;
 	}
 
 	hbuf_slots = mei_hbuf_empty_slots(dev);
 	if (hbuf_slots < 0) {
-		rets = -EOVERFLOW;
+		buf_len = -EOVERFLOW;
 		goto out;
 	}
 
-- 
2.30.2

