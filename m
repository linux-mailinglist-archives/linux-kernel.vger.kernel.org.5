Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA777A6FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 02:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjITArJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 20:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjITArH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 20:47:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE16F83
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 17:47:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727C5C433C8;
        Wed, 20 Sep 2023 00:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695170821;
        bh=hIe7iSfzxlD1Ssky6t8tpNboP78N0LngZBkea2BN3Rk=;
        h=From:To:Cc:Subject:Date:From;
        b=D/+bENO1pwEuPTaRAaguImitaJz1Y0zXTJ8C+HrEyNgAQrd5QVA/RtTx2A1539PAy
         +lmO13z0FP6zQ/6XRni1I91F3+IWAPcDX6ByLfbHNeKjuV9XasIjZZ+mS7sPu4uHDc
         lA62UFazSBO1BFb4TbxND7gtfzhTSN7UpR9ZHV5ae+G4510Md4Z+dmYzkVxn/rxyYF
         jDc578zj+TQD477ASBCQeB0WYRHWF3UtUDM/aNc22i2eIEHU9WWqWEKQvlPE3Bu7Iz
         tWIkBXnGfV2s/Z3iSQdjCEKuOQjAA0xRB4/far3aKd4meEP2ehCgLbtFsQjgxQ9s8Y
         eV8PJq2+voe9A==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] f2fs: preload extent_cache for POSIX_FADV_WILLNEED
Date:   Tue, 19 Sep 2023 17:46:45 -0700
Message-ID: <20230920004645.1462354-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to preload extent_cache given POSIX_FADV_WILLNEED, which is
more useful for generic usecases.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 09716127e107..df7703c1f7d7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4858,6 +4858,8 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
 		filp->f_mode &= ~FMODE_RANDOM;
 		spin_unlock(&filp->f_lock);
 		return 0;
+	} else if (advice == POSIX_FADV_WILLNEED) {
+		f2fs_precache_extents(inode);
 	}
 
 	err = generic_fadvise(filp, offset, len, advice);
-- 
2.42.0.459.ge4e396fd5e-goog

