Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E61B782D20
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjHUPWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbjHUPWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF597E2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DE6960DB9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B758CC433CB;
        Mon, 21 Aug 2023 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692631357;
        bh=ynZnTfGNCO4mTd9MdNcmARd7SztGSRA/yI7ID5fgvvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tD3qMbD4+7opo/3MzmIdjEVSXZDbNCWIAtnbjqpvXCfTXPB2EgdAR/CmXyWb5VoG0
         vrV4RWS8wBcCSGP7/1ix8IEMPENKl+DGWV+SduMgnMQxOEjBguoOGdFU920zqE3Mhm
         Ds6JsapZJdIsDQ6SnSn+QuTYiFoneoMToWpVQfwBj3ZT49spwtGsTFR4JboektWYpM
         FmHX8MCRkzKpdmPGC8xSSyW6wPrQ1J1XmRDWQGqD8yPhkSAMzjfBFyUVpliiFShfk/
         N1gKrQljfse/UFWeOq9m1WyyCa7fDo4kTuixHqqHJSgK2dk+3/6+3LxYrjx1eNgvau
         4J2Hax6p1kkAQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: compress: fix to assign compress_level for lz4 correctly
Date:   Mon, 21 Aug 2023 23:22:25 +0800
Message-Id: <20230821152225.4086924-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230821152225.4086924-1-chao@kernel.org>
References: <20230821152225.4086924-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After remount, F2FS_OPTION().compress_level was assgin to
LZ4HC_DEFAULT_CLEVEL incorrectly, result in lz4hc:9 was enabled, fix it.

1. mount /dev/vdb
/dev/vdb on /mnt/f2fs type f2fs (...,compress_algorithm=lz4,compress_log_size=2,...)
2. mount -t f2fs -o remount,compress_log_size=3 /mnt/f2fs/
3. mount|grep f2fs
/dev/vdb on /mnt/f2fs type f2fs (...,compress_algorithm=lz4:9,compress_log_size=3,...)

Fixes: 00e120b5e4b5 ("f2fs: assign default compression level")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a067466a694c..8d9d2ee7f3c7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -591,7 +591,7 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
 	unsigned int level;
 
 	if (strlen(str) == 3) {
-		F2FS_OPTION(sbi).compress_level = LZ4HC_DEFAULT_CLEVEL;
+		F2FS_OPTION(sbi).compress_level = 0;
 		return 0;
 	}
 
-- 
2.40.1

