Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4282075E5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 02:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjGXAQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 20:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXAQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 20:16:05 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AFDA1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 17:16:01 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E40B3240027
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1690157757; bh=Hg8+Ie5zk1+PShUsC8fZxv3X5pNkB2BeLLwMP1rWmCU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=sBBbeiakXr27M7ivOxfE/BgSC+dbgyQWJJMeduwlCz6HZTxfBZHYRV2D1JHsAXwdF
         3mzlRUB8qvyl09hcJQD9seimcZZLhvPPatkl1OeqYidSDrP8GlxjLkNIe4IegLlazT
         WcKsuqnaqjrEP6E249TBLKsaUo1xhRetVe+d8ay9cc2MpfXvPpaDXDutHScbL46oBa
         sCYfpNq7bKDLJFPm8LrvWP8frJiZ8sBA4vX5/onf+ydZOYifjntOrP5QkcLA3FdwWm
         4OCan+DGBOjII2yncezKlhFDKbPwYwMkkO6HN7V0Du1qn6p40P1TUZAVx8QcUUrRj9
         nNXIyvgnnvkPQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4R8LKl6WB3z6v1M;
        Mon, 24 Jul 2023 02:15:55 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     ebiggers@google.com, herbert@gondor.apana.org.au,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH] lib/mpi: avoid null pointer deref in mpi_cmp_ui()
Date:   Mon, 24 Jul 2023 00:07:27 +0000
Message-Id: <20230724000727.3281733-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During NVMeTCP Authentication a controller can trigger a kernel
oops by specifying the 8192 bit Diffie Hellman group and passing
a correctly sized, but zeroed Diffie Hellamn value.
mpi_cmp_ui() was detecting this if the second parameter was 0,
but 1 is passed from dh_is_pubkey_valid(). This causes the null
pointer u->d to be dereferenced towards the end of mpi_cmp_ui()

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 lib/mpi/mpi-cmp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/mpi/mpi-cmp.c b/lib/mpi/mpi-cmp.c
index c4cfa3ff0581..0835b6213235 100644
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
2.39.2

