Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1EE76A8A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjHAGFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjHAGFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:05:35 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46842127;
        Mon, 31 Jul 2023 23:05:32 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37164afZ001233;
        Tue, 1 Aug 2023 14:04:36 +0800 (+08)
        (envelope-from Yunlong.Xing@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RFPfR6L1pz2K1r9S;
        Tue,  1 Aug 2023 14:02:55 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 1 Aug 2023 14:04:33 +0800
From:   Yunlong Xing <yunlong.xing@unisoc.com>
To:     <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <joel@joelfernandes.org>,
        <enlin.mu@unisoc.com>
CC:     <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <enlinmu@gmail.com>, <yunlong.xing23@gmail.com>
Subject: [PATCH 1/1] pstore/ram: Check member of buffers during the initialization phase of the pstore
Date:   Tue, 1 Aug 2023 14:04:32 +0800
Message-ID: <20230801060432.1307717-1-yunlong.xing@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.5.32.15]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 37164afZ001233
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enlin Mu <enlin.mu@unisoc.com>

The commit 30696378f68a("pstore/ram: Do not treat empty buffers as valid")
would introduce the following issue:

When finding the buffer_size is zero, it would return directly.However, at
the same time, if the buffer's start is a illegal value, the others would
panic if access the buffer.

To avoid these happenning, check if the members are legal during the
initialization phase of the pstore.

Fixes: 30696378f68a ("pstore/ram: Do not treat empty buffers as valid")
Cc: stable@vger.kernel.org
Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
---
 fs/pstore/ram_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 85aaf0fc6d7d..eb6df190d752 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -519,7 +519,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 	sig ^= PERSISTENT_RAM_SIG;
 
 	if (prz->buffer->sig == sig) {
-		if (buffer_size(prz) == 0) {
+		if (buffer_size(prz) == 0 && buffer_start(prz) == 0) {
 			pr_debug("found existing empty buffer\n");
 			return 0;
 		}
-- 
2.25.1

