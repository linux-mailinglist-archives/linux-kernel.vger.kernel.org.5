Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B8780E09E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbjLLBBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345607AbjLLBB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:01:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CB2D5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:01:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6BFC433D9;
        Tue, 12 Dec 2023 01:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702342894;
        bh=DrRCtSU9Med/4mNPeKjZBCg4NO0v5bfD2LI1x2498Ro=;
        h=From:To:Cc:Subject:Date:From;
        b=I2q6tOdUhiF2BJ+rjT9VpBsT14FW6c23EoiwvIA2L1t1MLNRdzr6H0s9UBVj4T7rB
         pY612ksKEzLFn+MUp5S0qyGRPpZGgonHLD53GTvgMXkg1z/3CsySAnxdp7fcO694fQ
         nRhWpUBP5x8xwn9kzCDpLlykJ2SIuub7ReJE+ts9wkcUzLuLIt4N5SV+FgsIjgHYGl
         /PRViobbNd6NMXEEBbp/BM27dzDUUvRL15qVetouptMuiZfL+pwubEPQ2zCqOiftg7
         A0Ro1AXWSgz28JivX75bUnaBndUAWKCFmpLn4X0OuaOJbwOYhNNTpxwvbI1UsTP2Zx
         8BdRdxWNGPxDA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 4/6] f2fs: don't set FI_PREALLOCATED_ALL for partial write
Date:   Tue, 12 Dec 2023 09:01:20 +0800
Message-Id: <20231212010120.252763-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_preallocate_blocks(), if it is partial write in 4KB, it's not
necessary to call f2fs_map_blocks() and set FI_PREALLOCATED_ALL flag.

Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- clean up codes
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 79d5b64c109c..026d05a7edd8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4567,7 +4567,8 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 	if (map.m_len > map.m_lblk)
 		map.m_len -= map.m_lblk;
 	else
-		map.m_len = 0;
+		return 0;
+
 	map.m_may_create = true;
 	if (dio) {
 		map.m_seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
-- 
2.40.1

