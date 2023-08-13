Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27BE77A898
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjHMQDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjHMQDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C9C1707;
        Sun, 13 Aug 2023 09:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 028BB6355D;
        Sun, 13 Aug 2023 16:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A24FC433C8;
        Sun, 13 Aug 2023 16:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942534;
        bh=u3tZlnViBXPWZo72eEOQVK/GqpY0PQqCjBhTqs7t65s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CUuz1mw1ZV937E3XxDx+YId4ivH2QMBTfycbDyqRZVxGH4v5v6pNN3rV7zs2DZfSp
         Ecd5rU8e2RYQifQpspimLeuqt7jyS8+KBgol0svswAa64bDkp/uPGwj2Cm8FZcRyc6
         +6krDQQVifole/WaSSW/bi59p5XxaAD8G/CYOJlkSnc7e1reLNI+lsE97EkfNisuuy
         1bSWTFdRfVlDoVVAN6R1pNJ4mBnV9uVH6N9iNai4Kv9/xAXH4OUyFr+lkdY6RfzUE4
         Auhp8cvuszfVdWodbIhx6joFpMAjCbE4G9F5I+RUtnEutjw1sAwXU6wX8QCNsAvRVU
         n/Jl2S5Wjw73Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 21/47] s390/dasd: use correct number of retries for ERP requests
Date:   Sun, 13 Aug 2023 11:59:16 -0400
Message-Id: <20230813160006.1073695-21-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit acea28a6b74f458defda7417d2217b051ba7d444 ]

If a DASD request fails an error recovery procedure (ERP) request might
be built as a copy of the original request to do error recovery.

The ERP request gets a number of retries assigned.
This number is always 256 no matter what other value might have been set
for the original request. This is not what is expected when a user
specifies a certain amount of retries for the device via sysfs.

Correctly use the number of retries of the original request for ERP
requests.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Link: https://lore.kernel.org/r/20230721193647.3889634-3-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_3990_erp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 81d283b3cd3bd..b8fa4eba1fe48 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2441,7 +2441,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 	erp->block    = cqr->block;
 	erp->magic    = cqr->magic;
 	erp->expires  = cqr->expires;
-	erp->retries  = 256;
+	erp->retries  = device->default_retries;
 	erp->buildclk = get_tod_clock();
 	erp->status = DASD_CQR_FILLED;
 
-- 
2.40.1

