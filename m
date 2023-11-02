Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB907DEA73
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbjKBBwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjKBBwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:52:16 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7727D121;
        Wed,  1 Nov 2023 18:52:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 72A4A60292B89;
        Thu,  2 Nov 2023 09:52:00 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     rpeterso@redhat.com, agruenba@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com
Cc:     Su Hui <suhui@nfschina.com>, gfs2@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] gfs2: remove dead code in __acquires
Date:   Thu,  2 Nov 2023 09:51:42 +0800
Message-Id: <20231102015141.1355762-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang static analyzer complains that value stored to 'gh' is never read.
The code of this line is useless after commit 0b93bac2271e
("gfs2: Remove LM_FLAG_PRIORITY flag"). Remove this code to save space.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/gfs2/glock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 3772a5d9e85c..347f8a020c82 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1524,7 +1524,6 @@ __acquires(&gl->gl_lockref.lock)
 		return;
 	}
 	list_add_tail(&gh->gh_list, insert_pt);
-	gh = list_first_entry(&gl->gl_holders, struct gfs2_holder, gh_list);
 	spin_unlock(&gl->gl_lockref.lock);
 	if (sdp->sd_lockstruct.ls_ops->lm_cancel)
 		sdp->sd_lockstruct.ls_ops->lm_cancel(gl);
-- 
2.30.2

