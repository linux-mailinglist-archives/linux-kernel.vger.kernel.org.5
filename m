Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199907821D3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 05:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjHUDef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 23:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjHUDed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 23:34:33 -0400
Received: from out-53.mta0.migadu.com (out-53.mta0.migadu.com [IPv6:2001:41d0:1004:224b::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AE9A1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 20:34:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692588867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8VMbBoJ73OofW8qjWYu7YkN64TyZ3Qgi4fe/POONZLg=;
        b=TULM3Kgfrajd6uesJBMCK3cJrSmDQjTNvfKSUkivpRsY8+rCYerctq6HT0FpP0wWDQYIVm
        jHTHozdJ5Btmo+yeNAaNLg1Kk9vS+hb1JflF7WXbUlu5nQRupxfa+I42aWkcqtzgnvE/dD
        cDWtlAY6lutzMe05l8bRGRVmaUR/3R4=
From:   Gang Li <gang.li@linux.dev>
To:     mkubecek@suse.cz
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, Gang Li <gang.li@linux.dev>
Subject: [PATCH RESEND ethtool] netlink: Allow nl_sset return -EOPNOTSUPP to fallback to do_sset
Date:   Mon, 21 Aug 2023 11:34:19 +0800
Message-Id: <20230821033419.59095-1-gang.li@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, nl_sset treats any negative value returned by nl_parser
(including -EOPNOTSUPP) as `1`. Consequently, netlink_run_handler
directly calls exit without returning to main and invoking do_sset
through ioctl_init.

To fallback to do_sset, this commit allows nl_sset return -EOPNOTSUPP.

Fixes: 392b12e ("netlink: add netlink handler for sset (-s)")
Signed-off-by: Gang Li <gang.li@linux.dev>
---
 netlink/settings.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/netlink/settings.c b/netlink/settings.c
index dda4ac9..2af933d 100644
--- a/netlink/settings.c
+++ b/netlink/settings.c
@@ -1244,6 +1244,9 @@ int nl_sset(struct cmd_context *ctx)
 	nlctx->devname = ctx->devname;
 
 	ret = nl_parser(nlctx, sset_params, NULL, PARSER_GROUP_MSG, msgbuffs);
+	if (ret == -EOPNOTSUPP)
+		return ret;
+
 	if (ret < 0) {
 		ret = 1;
 		goto out_free;
-- 
2.20.1

