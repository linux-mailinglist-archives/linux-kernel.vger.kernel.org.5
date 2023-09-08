Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDC0798D8B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbjIHSWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245225AbjIHSVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:21:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECF22717;
        Fri,  8 Sep 2023 11:19:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2322C433CB;
        Fri,  8 Sep 2023 18:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197126;
        bh=YvR4knq0LQJhkdyDueZsyjbvvnvnk0YhCZr0x5mFc5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qa43kIakLZb4xCvsd/a+3fE74B20iSQ7D6zep1ONC5TwqIyQP56KIYXEpMIEWRS17
         1tPxuQCfUeg/8o4fIgQyxVV7XWR9L1F+IFLU1xhRZ2+4ISCItwQBB9q1Kt1wIk9UeM
         MT88l8zOVk/oM8ZEHm120VMZ1a20PnoOtU0iMBlWO0rf9nloY+SH7GSooWvWhGpfQv
         mK2nDsMwqJMcCLK/wvk4VAnIUHr93HzBIjbAPLATMJLlxbPFCvJ/gn0IoNj+dZhBz3
         txRqO1CW6HT4NR2Aj7/lYEGSuTS9T+e6fJ8KpjaR/i6AwN3fioNCWLL9E74Wnx4FYR
         xWLQgIncjXlJw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark O'Donovan <shiftee@posteo.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, zohar@linux.ibm.com
Subject: [PATCH AUTOSEL 6.1 13/26] crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()
Date:   Fri,  8 Sep 2023 14:17:51 -0400
Message-Id: <20230908181806.3460164-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181806.3460164-1-sashal@kernel.org>
References: <20230908181806.3460164-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark O'Donovan <shiftee@posteo.net>

[ Upstream commit 9e47a758b70167c9301d2b44d2569f86c7796f2d ]

During NVMeTCP Authentication a controller can trigger a kernel
oops by specifying the 8192 bit Diffie Hellman group and passing
a correctly sized, but zeroed Diffie Hellamn value.
mpi_cmp_ui() was detecting this if the second parameter was 0,
but 1 is passed from dh_is_pubkey_valid(). This causes the null
pointer u->d to be dereferenced towards the end of mpi_cmp_ui()

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/mpi/mpi-cmp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/mpi/mpi-cmp.c b/lib/mpi/mpi-cmp.c
index c4cfa3ff05818..0835b6213235e 100644
--- a/lib/mpi/mpi-cmp.c
+++ b/lib/mpi/mpi-cmp.c
@@ -25,8 +25,12 @@ int mpi_cmp_ui(MPI u, unsigned long v)
 	mpi_limb_t limb = v;
 
 	mpi_normalize(u);
-	if (!u->nlimbs && !limb)
-		return 0;
+	if (u->nlimbs == 0) {
+		if (v == 0)
+			return 0;
+		else
+			return -1;
+	}
 	if (u->sign)
 		return -1;
 	if (u->nlimbs > 1)
-- 
2.40.1

