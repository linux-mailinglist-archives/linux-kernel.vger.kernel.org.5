Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DB47A5CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjISIwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjISIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78249118;
        Tue, 19 Sep 2023 01:52:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED2DC433CB;
        Tue, 19 Sep 2023 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113524;
        bh=BvdjwcpcPhLEnEHfR1fGi9mX6MBPU/nHlNd6nWbNp7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/hWaIW57gq1bHreJEwVa8u+zQ1JfU3Cgx4sMFEtbKs7jbQGpUzY3HKV30OFnXa7j
         QQJUokrMPlxFEbAMHErWkHuvb+l3LgEU5/FOJPPCgD1NJlClqgVa4R3OzS2wGJSgb4
         G6Ccq6lylKyuJXUPZaiuOYfC/nCIHmJgTkAMkr4NDUoVO8v6uMz1tuxGUcLyoHFp/a
         ftJ/uJV7clfFlALb9Rla4OHKENtVp2lM8zcCjMKrpTxxeju32SkqeBadRLCKzJr+I2
         XDlMmeFb0Lg5WKP4mCiv+sNdhGdq5wOVzO2R0L1w5nzBiHO+T5n7L1UO9OezMT2HKE
         I0CkKIyFeyyug==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 03/15] tty: n_tty: use min3() in copy_from_read_buf()
Date:   Tue, 19 Sep 2023 10:51:44 +0200
Message-ID: <20230919085156.1578-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919085156.1578-1-jirislaby@kernel.org>
References: <20230919085156.1578-1-jirislaby@kernel.org>
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

n is a minimum of:
* available chars in the ring buffer
* available chars in the ring buffer till the end of the ring buffer
* requested number (*nr)

We can use min3() for that instead of two min()s.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e917faa0b84c..6a112910c058 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1965,8 +1965,7 @@ static bool copy_from_read_buf(const struct tty_struct *tty, u8 **kbp,
 	size_t head = smp_load_acquire(&ldata->commit_head);
 	size_t tail = MASK(ldata->read_tail);
 
-	n = min(head - ldata->read_tail, N_TTY_BUF_SIZE - tail);
-	n = min(*nr, n);
+	n = min3(head - ldata->read_tail, N_TTY_BUF_SIZE - tail, *nr);
 	if (n) {
 		u8 *from = read_buf_addr(ldata, tail);
 		memcpy(*kbp, from, n);
-- 
2.42.0

