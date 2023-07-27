Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE9E765AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjG0Rrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG0Rrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918C23582;
        Thu, 27 Jul 2023 10:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B49A61EEE;
        Thu, 27 Jul 2023 17:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96556C433C8;
        Thu, 27 Jul 2023 17:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690480052;
        bh=8hhmn8+Ux+A5/8bfiHx76Y+Keb0yncfBW6JKFFqonaI=;
        h=From:To:Cc:Subject:Date:From;
        b=PSmn3vIHdcE4YAvK30kxOfH+NwljypVDfa1Y/IjWI/dbuMd3C6YC/siSK6lnFtTpE
         gHws0kigPY53o+U/hFangapFoH2jflVmFyuN7YAMaoSlHYLROupPXxYWn3Gw6xc4W2
         eVKg3NYE7/jIkvU6lSugbZxMBFAfo5CA2Z6DyO8w8ja8rlq06BQXPp1i9N85fiJ+9x
         MayhU1yyZq0bKNmu4i2XQ4n6QJvT3bGbxZLW2kgCRSfz4MkhngfHUfu7rQsxP1fzqE
         HN3K4s6DkL9be5qiy8Wfw5UNRCcT9zVxD/nWarpKXEfBJv+RR4mKoDilXoYGwcIbb+
         FzzIKDIUrrDhg==
From:   SeongJae Park <sj@kernel.org>
To:     stable@vger.kernel.org
Cc:     M A Ramdhan <ramdhan@starlabs.sg>, gregkh@linuxfoundation.org,
        sashal@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hailmo@amazon.com,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>, SeongJae Park <sj@kernel.org>
Subject: [PATCH 4.14] net/sched: cls_fw: Fix improper refcount update leads to use-after-free
Date:   Thu, 27 Jul 2023 17:47:27 +0000
Message-Id: <20230727174727.55795-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: M A Ramdhan <ramdhan@starlabs.sg>

[ Upstream commit 0323bce598eea038714f941ce2b22541c46d488f ]

In the event of a failure in tcf_change_indev(), fw_set_parms() will
immediately return an error after incrementing or decrementing
reference counter in tcf_bind_filter().  If attacker can control
reference counter to zero and make reference freed, leading to
use after free.

In order to prevent this, move the point of possible failure above the
point where the TC_FW_CLASSID is handled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: M A Ramdhan <ramdhan@starlabs.sg>
Signed-off-by: M A Ramdhan <ramdhan@starlabs.sg>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Message-ID: <20230705161530.52003-1-ramdhan@starlabs.sg>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 net/sched/cls_fw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index 7f45e5ab8afcd..e63f9c2e37e50 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -225,11 +225,6 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_FW_CLASSID]) {
-		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
-		tcf_bind_filter(tp, &f->res, base);
-	}
-
 #ifdef CONFIG_NET_CLS_IND
 	if (tb[TCA_FW_INDEV]) {
 		int ret;
@@ -248,6 +243,11 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	} else if (head->mask != 0xFFFFFFFF)
 		return err;
 
+	if (tb[TCA_FW_CLASSID]) {
+		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
+		tcf_bind_filter(tp, &f->res, base);
+	}
+
 	return 0;
 }
 
-- 
2.40.1

