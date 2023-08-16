Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEE677DFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244405AbjHPLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244423AbjHPLAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A0F26A8;
        Wed, 16 Aug 2023 04:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 874DA6661E;
        Wed, 16 Aug 2023 10:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E57C433C8;
        Wed, 16 Aug 2023 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183526;
        bh=wBnHhWo9xC8BiAE1Jfh8d+5rplf2+edVMoIbryon06M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQ705NI9+vcmhsFFFl87Wl0PuDeOFUjgyoXnjcrmIk53fNn+jpUgnD3FHiAsE9VHb
         o2tXwhytnTwFI8WiAhuZyE5mDjlXrX/ecZPcUb+ZIORowVjN2NddDIH8W2w3img6vT
         py6tkAZKCoF8eAuCwk+0ZdSdQm2Kc0z3WGzuld5gVYQ2GoT1p2it6gKQkDizYBsPMp
         c9Jo7/aFQAAdvuiDR+lAt3IStd6RFnNpOLEtj0lpH+HXS8u68CIJyRjleAASo1Xw26
         ZXEuBf/okZpMClTcLft5LKc+2zzXHBX8hmZ6HKARn4OobWJGADCDvAQleEZ17zJ7J7
         XDUp2ljGfFLyg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 10/14] tty: n_tty: simplify chars_in_buffer()
Date:   Wed, 16 Aug 2023 12:58:18 +0200
Message-ID: <20230816105822.3685-15-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105822.3685-1-jirislaby@kernel.org>
References: <20230816105822.3685-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'if' in chars_in_buffer() is misleadingly inverted. And since the
only difference is the head used for computation, cache the head using
ternary operator. And use that in return directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 875a2bbb51c3..3815201c220b 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -219,13 +219,9 @@ static void n_tty_kick_worker(const struct tty_struct *tty)
 static ssize_t chars_in_buffer(const struct tty_struct *tty)
 {
 	const struct n_tty_data *ldata = tty->disc_data;
-	ssize_t n = 0;
+	size_t head = ldata->icanon ? ldata->canon_head : ldata->commit_head;
 
-	if (!ldata->icanon)
-		n = ldata->commit_head - ldata->read_tail;
-	else
-		n = ldata->canon_head - ldata->read_tail;
-	return n;
+	return head - ldata->read_tail;
 }
 
 /**
-- 
2.41.0

