Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E02A7BFA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjJJMB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjJJMBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:01:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0971318F;
        Tue, 10 Oct 2023 05:00:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D99C433CC;
        Tue, 10 Oct 2023 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939238;
        bh=PuTfWYxQLhTAjaDvea6gKVcCYIdp2RUj6VBNyhU8ZZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQofG2QVvUNyK5e1afjaX2K7+wJsDecGoeF2EOLKc1waVTQ2NUQR5M2tub1kMSWDZ
         tBofVRWhX+fs3G+Ey9mIwSnS8LxfdHUSYCGPbtILiVgY/8JKMEONZYjY+fkKxCnpJF
         jrETXvS3AoL2MJp2xYkVVgxUD+ZyJILy6jtaesiu6MF1XxzU6VXaZqkQSZglY3nHX7
         YJMQsVBQth82iwIHaXHtRiusoyP2hztsfrBwvVfzGUd6mcq04d3CVg9k/6vpbz5u+L
         6FMnqpPmyx2C7UzFC5EZexPqCQniTa/NoR6xzlg4zKKQvR6g/Z19zP9rQMwljJgYV+
         kaQtxp+EZhAyw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 23/23] locktorture: Check the correct variable for allocation failure
Date:   Tue, 10 Oct 2023 13:59:21 +0200
Message-Id: <20231010115921.988766-24-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

There is a typo so this checks the wrong variable.  "chains" plural vs
"chain" singular.  We already know that "chains" is non-zero.

Fixes: 7f993623e9eb ("locktorture: Add call_rcu_chains module parameter")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/locking/locktorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index a3abcd136f56..69d3cd2cfc3b 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -1075,7 +1075,7 @@ static int call_rcu_chain_init(void)
 	if (call_rcu_chains <= 0)
 		return 0;
 	call_rcu_chain = kcalloc(call_rcu_chains, sizeof(*call_rcu_chain), GFP_KERNEL);
-	if (!call_rcu_chains)
+	if (!call_rcu_chain)
 		return -ENOMEM;
 	for (i = 0; i < call_rcu_chains; i++) {
 		call_rcu_chain[i].crc_stop = false;
-- 
2.34.1

