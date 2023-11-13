Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C77E97A7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjKMI2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMI2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:28:31 -0500
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1404610EB;
        Mon, 13 Nov 2023 00:28:26 -0800 (PST)
X-QQ-mid: bizesmtp85t1699863979tcxakaxm
Received: from localhost.localdomain ( [125.76.217.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 13 Nov 2023 16:26:17 +0800 (CST)
X-QQ-SSF: 01400000000000E0H000000A0000000
X-QQ-FEAT: qcKkmz/zJhxqbYcU5R90Rxyhm/T3t0XRpYz8RuWcrc7q8ZXXUvih9I2J7w3Zm
        TgGSA5p2t51eTivSBiFpYr6c6s5BMgl50zMLjblpN1qjb5G6ojofsyLTk8GUnkshxHyCwRE
        NIhLMCB9ZMgTmyRXRAHoNqbLbXqsbN1a5AsQXTE124zpH6KEtTyvPr4TzO9/a9TsGzm2nUU
        6ddfTxEDSZwJliX1o38SXMK5Unb2jIfwwcDlgCKVN4RJZUobgRu3pnbz/1yPUeT723tjGUm
        K3HCyqVt0GWvkDBvbuCUwZ4v2vhWaWCC4GT0DiAN/au/x6Uz+/kVCqmfjnSitfuJdJ0RApK
        n3BZe2Ia8vVww5lWrp4poRknTBQM33BoMlt5TL8EeHbg2y7Nbe6BR5zxsMF2QiPufA5qFJc
        rMMWK/vKBYY=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2065864653820567975
From:   Gou Hao <gouhao@uniontech.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        alex@clusterfs.com, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gouhaojake@163.com
Subject: [PATCH] ext4: improving calculation of 'fe_{len|start}' in mb_find_extent()
Date:   Mon, 13 Nov 2023 16:26:17 +0800
Message-Id: <20231113082617.11258-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After first execution of mb_find_order_for_block():

'fe_start' is the value of 'block' passed in mb_find_extent().

'fe_len' is the difference between the length of order-chunk and
remainder of the block divided by order-chunk.

And 'next' does not require initialization after above modifications.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/ext4/mballoc.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 454d5612641e..d3f985f7cab8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1958,8 +1958,7 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 static int mb_find_extent(struct ext4_buddy *e4b, int block,
 				int needed, struct ext4_free_extent *ex)
 {
-	int next = block;
-	int max, order;
+	int max, order, next;
 	void *buddy;
 
 	assert_spin_locked(ext4_group_lock_ptr(e4b->bd_sb, e4b->bd_group));
@@ -1977,16 +1976,12 @@ static int mb_find_extent(struct ext4_buddy *e4b, int block,
 
 	/* find actual order */
 	order = mb_find_order_for_block(e4b, block);
-	block = block >> order;
 
-	ex->fe_len = 1 << order;
-	ex->fe_start = block << order;
+	ex->fe_len = (1 << order) - (block & ((1 << order) - 1));
+	ex->fe_start = block;
 	ex->fe_group = e4b->bd_group;
 
-	/* calc difference from given start */
-	next = next - ex->fe_start;
-	ex->fe_len -= next;
-	ex->fe_start += next;
+	block = block >> order;
 
 	while (needed > ex->fe_len &&
 	       mb_find_buddy(e4b, order, &max)) {
-- 
2.20.1

