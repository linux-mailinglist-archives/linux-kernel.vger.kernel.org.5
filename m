Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943E6771537
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjHFNIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjHFNIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:08:12 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF4D1B5;
        Sun,  6 Aug 2023 06:07:47 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RJfrH3Y00z9sTx;
        Sun,  6 Aug 2023 15:07:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691327263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRoPYzAKTnTbgFFEG+eJ+hkJL/BPQBe79b1oVFxR0W8=;
        b=QUA4bR2SmJicg6oPqu7yncuFitFk0JVnNHMBYjSA5nbjoKR7ztUOV0cV9xXnJuzMireE69
        ei3m8kvqNugiGqs5u9Iakuyp9+H6KE7Fi+ZiuPQ8dkhHmMXlTWVb3XZ/QVIj7F3cAtWQcP
        NY84/08Lay3Eks5ue6PvTzYWv7K0GYQHfVtLRkf35kcsrDB/Z+bkBZ2IHcihmo0ueaGSS9
        +NOiiSZOc6/S9ixY1ofb45GJ/cLWDyH0vxzmF/MtQ0GKBGHt+Raq+l+3qTde/exHDGTbdd
        g6gFblhVtaLWjyYtrUwZWYiqqyQeKTOw+WdON75DoT1Ib8eRfoUAv6EFhNXuwA==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 06 Aug 2023 15:06:56 +0200
Subject: [PATCH v5 11/11] clk: sunxi-ng: nkm: Prefer current parent rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-pll-mipi_set_rate_parent-v5-11-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=Z/IH5d/kFzjrhI6vdMr/b3JFwWV3Wz0iaYZ2ZX+Fbvo=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkz5sIPL+PUvFsAmdO56tAomWjb3FWkFagHuQca
 4MIo8ZEvU6JAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZM+bCAAKCRCaaaIIlErT
 x1CvC/9YsuJAfvcqyq17ZqNaRnt+r0NHAFSbCgN641KlVeFiKf6fgYVeMNFRLXK8C60AFWWoimY
 cXcg7iQAuMvhVHVRpZgt+qbdcQ5zmVgNvdp6+Nm2uoZEpiHHNkoDsZRklOB7K6FKEfsjeIkAAjc
 hoM8DuI1KiFSxkwJs1dhiFgPqzXxmphFbXRgg9X7JnzRW5oOIe8SJRCQSMqZMvhgiKXrnx/iCqA
 zkKoCvM0sqWWJceQMEVwD3+cC1Ah2y/HUZeZNl85bOdER+Yt99/DgRxVZL9JjXwaKym+QkkL+VQ
 rf7L+yhxzhjHGA+L7eIT695hC3y18ePMsX3MGz3O5H65L58ZKoDbQgorMPqO5excXIQovH+kRYn
 rdnPCE3ijB8JConJfFrlhh0/W6z40K0s36OoqOUWW+uu48nGsqPrcVQotKGgu4NdlyaV8TJt0Z1
 Xz+tpHrX/GXoAns3GFAT8CIX5CV6AX33CB7TxPy6Hvu6O/VzorAWvFyFdBQ8EM6C5DMss=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to ccu_mp, if the current parent rate allows getting the ideal
rate, prefer to not change the parent clock's rate.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 896bb1ef8642..1e49444817cf 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -35,7 +35,8 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common
 
 				tmp_rate = tmp_parent * _n * _k / _m;
 
-				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
+				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate) ||
+				    (tmp_parent == *parent && tmp_rate == best_rate)) {
 					best_rate = tmp_rate;
 					best_parent_rate = tmp_parent;
 					best_n = _n;

-- 
2.41.0

