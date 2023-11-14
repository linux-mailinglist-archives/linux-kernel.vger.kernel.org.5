Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3368B7EB88C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjKNVYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKNVYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:24:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA26E9D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:24:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BCCC433C8;
        Tue, 14 Nov 2023 21:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699997056;
        bh=Xg3Aq8eLknKwR53mKiNNcoHu3xpZPIqvXq+7lnhfHuE=;
        h=From:To:Cc:Subject:Date:From;
        b=KICe4scFNWNDvIMI8aCanOcqY/ivc4C1xjtVGG06F94sRN0kpvqyA2cZtgUiREMYM
         ExBjEfJLAJb/zJ/Aftrsy+DexxEps+vAiLUcHPqQUIHOjOyiOcQ/H7a6ZXqkORUiB8
         lkZqsQeiqKgV9WbEmQzZBYhZ+6p8d5vuo5mP8r7R+Q186yeOtRjxg7buYw4T+8uvEO
         WscsZfHi44cMJogwDcC77Eo74UXohsiQ6ECTVj7QBnWeaMPQCipBHnqJNrKfLrGpGg
         Vm0rpnsMaPL7q/O2UB2BmGYGouokvO7USre1sLHr0XIg4lhdTxjuFeoaw7E5LiJa2O
         QzKkJUDWBKE7g==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: skip adding a discard command if exists
Date:   Tue, 14 Nov 2023 13:24:14 -0800
Message-ID: <20231114212414.3498074-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
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

When recovering zoned UFS, sometimes we add the same zone to discard multiple
times. Simple workaround is to bypass adding it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 727d016318f9..f4ffd64b44b2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1380,7 +1380,8 @@ static void __insert_discard_cmd(struct f2fs_sb_info *sbi,
 			p = &(*p)->rb_right;
 			leftmost = false;
 		} else {
-			f2fs_bug_on(sbi, 1);
+			/* Let's skip to add, if exists */
+			return;
 		}
 	}
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

