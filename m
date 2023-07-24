Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E46975E7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjGXBa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjGXBaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:30:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A13C3C20;
        Sun, 23 Jul 2023 18:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A799A60C7A;
        Mon, 24 Jul 2023 01:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646E7C433C9;
        Mon, 24 Jul 2023 01:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161874;
        bh=rNDAxkGPPzeevVaklHEvhQAXhEdGEgHOkBgXklDgEH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mm+vXgQ89kn0sW5mQsSIVT86O+z0nsV3u1XPjr2zDCR6Mee8nhnqeNCtvcpEdGJPx
         Y9+g3pG/c5fC6SsWQD9SCGwwD7FNCLzUrp7c1OSZoo7hY42WmLO4jEBPZmB32P+n3w
         uurvYycfcXaET8lG8zi9uh8jdM4S55S6eK8lAkV40ErdKTrF1Jdj1mu6G1L0mBAbQw
         vOlE2mZxAU/W7WPXpzKtCIfFhFRZ75xOxaHf+SeST0FXGnyXRiTOqR/FvR5FUVzgNv
         nPUdOrbuXtRgw3Vsv+tvsM0txsgtlY7c4YFqDy4kSLm1TMfBYfiEQHwCP88NnwZ0l6
         2C054Bhp40oyA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        syzbot+e633c79ceaecbf479854@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, jack@suse.com
Subject: [PATCH AUTOSEL 5.10 09/22] quota: Properly disable quotas when add_dquot_ref() fails
Date:   Sun, 23 Jul 2023 21:24:06 -0400
Message-Id: <20230724012419.2317649-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012419.2317649-1-sashal@kernel.org>
References: <20230724012419.2317649-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index ad255f8ab5c55..135984a1a52f4 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2415,7 +2415,8 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 
 	error = add_dquot_ref(sb, type);
 	if (error)
-		dquot_disable(sb, type, flags);
+		dquot_disable(sb, type,
+			      DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED);
 
 	return error;
 out_fmt:
-- 
2.39.2

