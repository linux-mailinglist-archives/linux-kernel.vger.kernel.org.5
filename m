Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A218134B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573896AbjLNPZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573831AbjLNPYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:24:40 -0500
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771CF10E9;
        Thu, 14 Dec 2023 07:15:15 -0800 (PST)
X-QQ-mid: bizesmtp65t1702566900tw788o8z
Received: from localhost.localdomain ( [125.76.217.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Dec 2023 23:14:58 +0800 (CST)
X-QQ-SSF: 01400000000000E0H000000A0000000
X-QQ-FEAT: kUim6XnhvqXLGVCGif12YpsOAXyfr323UC3dd/L/ZZMRExUmZKiKHx5oLDwbc
        LZzHsLq4aDfbgSQBoakNgqyPtoAG8ML/TL2OLcIplBRfcTGJV3PPVGtuuGQ8pxWx/vIbIwR
        5ZAFYsHnG0GHnlOQuCfHCgj5BCPU+Sp5ikANO2re6gi78KCC4oZ2SlOTAZZdmUfd/tpqRLx
        BCIp/8BX6nhxXydNyFpX4qd9MEtqTJO0gbbOdgkurPdXoX4elaPv0zkzjXbvy4mDwgJ+u5T
        SEbIvwlMP2On1e7fyOe2gsqtX6nCX33EzaxInBrs5an8wRXUQ4NmpffwfQHuFBCyyZKaakA
        IN5FFUpjE52KjRyGo9s3SmS9ZPTkBVhRvTH+JHNnfvuzTCtz8YlBuXkRf7qbUW64QU13N4m
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16267120763352956004
From:   Gou Hao <gouhao@uniontech.com>
To:     song@kernel.org, linux-raid@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gouhaojake@163.com
Subject: [PATCH] md/raid1: remove unnecessary null checking
Date:   Thu, 14 Dec 2023 23:14:58 +0800
Message-Id: <20231214151458.28970-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If %__GFP_DIRECT_RECLAIM is set then bio_alloc_bioset will always
be able to allocate a bio. See comment of bio_alloc_bioset.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 drivers/md/raid1.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 35d12948e0a9..e77dc95d4a75 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1126,8 +1126,6 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 
 	behind_bio = bio_alloc_bioset(NULL, vcnt, 0, GFP_NOIO,
 				      &r1_bio->mddev->bio_set);
-	if (!behind_bio)
-		return;
 
 	/* discard op, we don't support writezero/writesame yet */
 	if (!bio_has_data(bio)) {
-- 
2.34.1

