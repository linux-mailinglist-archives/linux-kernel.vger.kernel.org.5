Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F089975E74C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGXB0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjGXB0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561AF3C1D;
        Sun, 23 Jul 2023 18:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39AA460EF9;
        Mon, 24 Jul 2023 01:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA546C433BB;
        Mon, 24 Jul 2023 01:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161831;
        bh=PPENnfwyAeazDRdtN66ooDkywVMamO38yXbagVEW5yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ME6pWIYt9nfxiLUGR0XiOwCo8nln4LLUaIM28JB1hEVNgYi2fAoRj3OSLt+2cXs5O
         CK8uizwHdiPytuq/TqMi+BgW8RKIudj+2UIbMw9s/31c0P2aHx2AiA4FupPxuE2ciG
         g42VT+37y2LcbaGU7iptAqoDlhlDAPdcTsiiH/KzJhOpTb3rAM6jkbXG2f1Tc9Efr2
         m9Oq4pWz3cOnE6qKi+yNMIig/V1kGIdKq31Esyl+BhgyVvGgsJjKd9G8YwuKBxJrgB
         ZRpeZnIcx4tGfzobu3oCkohCM+vU4vqF90rGaDGHRjHqFzxH8WRglpaoI09Tsn0Lqd
         2U3SgejqbWVow==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        syzbot+e633c79ceaecbf479854@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, jack@suse.com
Subject: [PATCH AUTOSEL 5.15 07/23] quota: Properly disable quotas when add_dquot_ref() fails
Date:   Sun, 23 Jul 2023 21:23:18 -0400
Message-Id: <20230724012334.2317140-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012334.2317140-1-sashal@kernel.org>
References: <20230724012334.2317140-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 6a4e3363792e30177cc3965697e34ddcea8b900b ]

When add_dquot_ref() fails (usually due to IO error or ENOMEM), we want
to disable quotas we are trying to enable. However dquot_disable() call
was passed just the flags we are enabling so in case flags ==
DQUOT_USAGE_ENABLED dquot_disable() call will just fail with EINVAL
instead of properly disabling quotas. Fix the problem by always passing
DQUOT_LIMITS_ENABLED | DQUOT_USAGE_ENABLED to dquot_disable() in this
case.

Reported-and-tested-by: Ye Bin <yebin10@huawei.com>
Reported-by: syzbot+e633c79ceaecbf479854@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230605140731.2427629-2-yebin10@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index cddd07b7d1329..da6e53fac0c48 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2413,7 +2413,8 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 
 	error = add_dquot_ref(sb, type);
 	if (error)
-		dquot_disable(sb, type, flags);
+		dquot_disable(sb, type,
+			      DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED);
 
 	return error;
 out_fmt:
-- 
2.39.2

