Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140DC75E6A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjGXBWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjGXBVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E22EE79;
        Sun, 23 Jul 2023 18:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 633FE60DFE;
        Mon, 24 Jul 2023 01:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33233C433C9;
        Mon, 24 Jul 2023 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161654;
        bh=6iD99Cufx7k5KYzCnecOLp1bh1vCi1+1X8KahPPPjOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQhGBHYQR/ASC0WeX/BNVSmqEVbnDuRBZ+K1nPvzWGd6KKNrBz1xCAIyrtLm92DmX
         rCxqL09Ii3iqbewOlYvxt79X3hAbfFWoRJOfB8KsSc3zRec6P60eWsqk3snESvUVU3
         k7K/TdVbTrhx/LU7er3kYeNpYDQRUdVC+7Ud2kAq7dpqFXNslG683lJ8Q1u2ZMQiDV
         XNYr1L4z+gCCfyICY4ErvOwdyeyom2YzDZ5gTSwdPcBxSZkglws0rqcN+6FI06P0Py
         xGnxEnPD1Bl7dde2U/U4lQ1RZvonfz/FkxZ5K6i98F5ltNIp4KAgiV+5XZA80HQWry
         7jaG6h2HRrKLQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+cd311b1e43cc25f90d18@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, jack@suse.com
Subject: [PATCH AUTOSEL 6.4 53/58] udf: Fix uninitialized array access for some pathnames
Date:   Sun, 23 Jul 2023 21:13:21 -0400
Message-Id: <20230724011338.2298062-53-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
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

[ Upstream commit 028f6055c912588e6f72722d89c30b401bbcf013 ]

For filenames that begin with . and are between 2 and 5 characters long,
UDF charset conversion code would read uninitialized memory in the
output buffer. The only practical impact is that the name may be prepended a
"unification hash" when it is not actually needed but still it is good
to fix this.

Reported-by: syzbot+cd311b1e43cc25f90d18@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000e2638a05fe9dc8f9@google.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/unicode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
index 622569007b530..2142cbd1dde24 100644
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -247,7 +247,7 @@ static int udf_name_from_CS0(struct super_block *sb,
 	}
 
 	if (translate) {
-		if (str_o_len <= 2 && str_o[0] == '.' &&
+		if (str_o_len > 0 && str_o_len <= 2 && str_o[0] == '.' &&
 		    (str_o_len == 1 || str_o[1] == '.'))
 			needsCRC = 1;
 		if (needsCRC) {
-- 
2.39.2

