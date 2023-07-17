Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36B6756BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjGQSVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjGQSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2923E6C;
        Mon, 17 Jul 2023 11:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1095B611AC;
        Mon, 17 Jul 2023 18:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D958C4339A;
        Mon, 17 Jul 2023 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618044;
        bh=vYKb+aiy81aGannlId6zaPb2w6tBkokl0Gh0QHY/RfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QNL1lw22uq5lc7bBxJLhQ1H0YCsOe2FR/akZuVZJix1IRhu8N/6mpjZuyL3HmXNgS
         sbn+QBg6PoPJrRY52F88YJ0gLgtlP018emk9ACMke/CI9zY8bO3p5Gg4CqnjJ50cSj
         s0m6X+G5AjIEy7xzwXK8P0qefkIb3FE5wz4R5aV1ql2/L2dGqp9ppbzBEBY+hPt6+W
         4bsg/56I1S0EZi8VCDWqKZwYgPrV9R84HyXMB3wZu/qbCYsPTFuWg/GzhmIZPwHF/X
         34Z/KGxGh8Dcs8TBRRMq/RFimteNApVTISly5yfGoWyvz0/tt9bnsUL+udM3v9TdhS
         mG/YtZwjcP+jw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 971A4CE092F; Mon, 17 Jul 2023 11:20:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/9] torture: Move torture_shuffle() timeouts to hrtimers
Date:   Mon, 17 Jul 2023 11:20:39 -0700
Message-Id: <20230717182042.1098651-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
References: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
MIME-Version: 1.0
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

In order to gain better race coverage, move the CPU-migration timed
waits in torture_shuffle() to torture_hrtimeout_jiffies().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index fc873116a399..3ab4930b9fdb 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -560,9 +560,11 @@ static void torture_shuffle_tasks(void)
  */
 static int torture_shuffle(void *arg)
 {
+	DEFINE_TORTURE_RANDOM(rand);
+
 	VERBOSE_TOROUT_STRING("torture_shuffle task started");
 	do {
-		schedule_timeout_interruptible(shuffle_interval);
+		torture_hrtimeout_jiffies(shuffle_interval, &rand);
 		torture_shuffle_tasks();
 		torture_shutdown_absorb("torture_shuffle");
 	} while (!torture_must_stop());
-- 
2.40.1

