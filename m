Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F42D7DB198
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJ2X5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjJ2X5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:57:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182A559FF;
        Sun, 29 Oct 2023 16:00:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FA5C41679;
        Sun, 29 Oct 2023 22:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620366;
        bh=WU0J97Fdli6EBxzCO48flt+kntH/ojIaUPc/tSonE2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJt9aIom7YQQFHGC5zZKFQ1iMtAzKGh6YjjkIVznO99I0nXvec45M+bmSMayeZCwx
         lChEct2QVj4j4p25DdVJHrLQMAPvm1nHWmEbLAf+V445LXAotpRBDm0bSPclizkNis
         bBaXPwGR1Y4fixRhyzdn077OMtDZSAoEUea1NQK3rJXL1EDHeLZiJ8P0rTsgqgjXfz
         EZkBAZKem1f5xtMLhTDmSeSKST5J37ovJN6TLSyzN4XL21nTZzYD8aAycCoF3HdzWL
         q1ZB71jlwhHy3Gn4iGhTknO/F76Uc/HTKCVdcoC08yNWdQkyy3RI7KxBDeCboP03+V
         OqhFiwsHsDY7Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 07/28] fs/ntfs3: Fix NULL pointer dereference on error in attr_allocate_frame()
Date:   Sun, 29 Oct 2023 18:58:42 -0400
Message-ID: <20231029225916.791798-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 9c689c8dc86f8ca99bf91c05f24c8bab38fe7d5f ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 321d55b3ca17d..1d5ac2164d94f 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1583,10 +1583,8 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			le_b = NULL;
 			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
 					      0, NULL, &mi_b);
-			if (!attr_b) {
-				err = -ENOENT;
-				goto out;
-			}
+			if (!attr_b)
+				return -ENOENT;
 
 			attr = attr_b;
 			le = le_b;
-- 
2.42.0

