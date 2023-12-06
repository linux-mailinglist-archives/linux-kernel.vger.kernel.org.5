Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D96806A69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346784AbjLFJLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346716AbjLFJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:11:11 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31FF11F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:11:16 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VxxSRQH_1701853874;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxxSRQH_1701853874)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 17:11:14 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, dhavale@google.com,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/5] erofs: fix up compacted indexes for block size < 4096
Date:   Wed,  6 Dec 2023 17:10:55 +0800
Message-Id: <20231206091057.87027-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the block size always equaled to PAGE_SIZE, therefore
`lclusterbits` couldn't be less than 12.

Since sub-page compressed blocks are now considered, `lobits` for
a lcluster in each pack cannot always be `lclusterbits` as before.
Otherwise, there is no enough room for the special value
`Z_EROFS_LI_D0_CBLKCNT`.

To support smaller block sizes, `lobits` for each compacted lcluster is
now calculated as:
   lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1)

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 7b55111fd533..9753875e41cb 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -82,29 +82,26 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 }
 
 static unsigned int decode_compactedbits(unsigned int lobits,
-					 unsigned int lomask,
 					 u8 *in, unsigned int pos, u8 *type)
 {
 	const unsigned int v = get_unaligned_le32(in + pos / 8) >> (pos & 7);
-	const unsigned int lo = v & lomask;
+	const unsigned int lo = v & ((1 << lobits) - 1);
 
 	*type = (v >> lobits) & 3;
 	return lo;
 }
 
-static int get_compacted_la_distance(unsigned int lclusterbits,
+static int get_compacted_la_distance(unsigned int lobits,
 				     unsigned int encodebits,
 				     unsigned int vcnt, u8 *in, int i)
 {
-	const unsigned int lomask = (1 << lclusterbits) - 1;
 	unsigned int lo, d1 = 0;
 	u8 type;
 
 	DBG_BUGON(i >= vcnt);
 
 	do {
-		lo = decode_compactedbits(lclusterbits, lomask,
-					  in, encodebits * i, &type);
+		lo = decode_compactedbits(lobits, in, encodebits * i, &type);
 
 		if (type != Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 			return d1;
@@ -123,15 +120,14 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 {
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	const unsigned int lomask = (1 << lclusterbits) - 1;
-	unsigned int vcnt, base, lo, encodebits, nblk, eofs;
+	unsigned int vcnt, base, lo, lobits, encodebits, nblk, eofs;
 	int i;
 	u8 *in, type;
 	bool big_pcluster;
 
 	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
-	else if (1 << amortizedshift == 2 && lclusterbits == 12)
+	else if (1 << amortizedshift == 2 && lclusterbits <= 12)
 		vcnt = 16;
 	else
 		return -EOPNOTSUPP;
@@ -140,6 +136,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
 			 (vcnt << amortizedshift);
 	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
 	eofs = erofs_blkoff(m->inode->i_sb, pos);
 	base = round_down(eofs, vcnt << amortizedshift);
@@ -147,15 +144,14 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 
 	i = (eofs - base) >> amortizedshift;
 
-	lo = decode_compactedbits(lclusterbits, lomask,
-				  in, encodebits * i, &type);
+	lo = decode_compactedbits(lobits, in, encodebits * i, &type);
 	m->type = type;
 	if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << lclusterbits;
 
 		/* figure out lookahead_distance: delta[1] if needed */
 		if (lookahead)
-			m->delta[1] = get_compacted_la_distance(lclusterbits,
+			m->delta[1] = get_compacted_la_distance(lobits,
 						encodebits, vcnt, in, i);
 		if (lo & Z_EROFS_LI_D0_CBLKCNT) {
 			if (!big_pcluster) {
@@ -174,8 +170,8 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 		 * of which lo saves delta[1] rather than delta[0].
 		 * Hence, get delta[0] by the previous lcluster indirectly.
 		 */
-		lo = decode_compactedbits(lclusterbits, lomask,
-					  in, encodebits * (i - 1), &type);
+		lo = decode_compactedbits(lobits, in,
+					  encodebits * (i - 1), &type);
 		if (type != Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 			lo = 0;
 		else if (lo & Z_EROFS_LI_D0_CBLKCNT)
@@ -190,8 +186,8 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 		nblk = 1;
 		while (i > 0) {
 			--i;
-			lo = decode_compactedbits(lclusterbits, lomask,
-						  in, encodebits * i, &type);
+			lo = decode_compactedbits(lobits, in,
+						  encodebits * i, &type);
 			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 				i -= lo;
 
@@ -202,8 +198,8 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 		nblk = 0;
 		while (i > 0) {
 			--i;
-			lo = decode_compactedbits(lclusterbits, lomask,
-						  in, encodebits * i, &type);
+			lo = decode_compactedbits(lobits, in,
+						  encodebits * i, &type);
 			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 				if (lo & Z_EROFS_LI_D0_CBLKCNT) {
 					--i;
-- 
2.39.3

