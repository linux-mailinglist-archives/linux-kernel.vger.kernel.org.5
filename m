Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593B97F28C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjKUJXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjKUJXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C26124
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED9EC433C7;
        Tue, 21 Nov 2023 09:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558593;
        bh=diBYhCi9kUrJKVnjd9DDPQZOesiKDAPdnCFzVrk5K90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7pHbyN1kipEeAiP5eyb3QNVHhjVJF4v58x162jD4WQLSJpJoJdWhkVXwS/eqZDFm
         pkeLgM2theJsap7u7hBHAQfjM2gd01rkFbl7/52L6Oip9jzfbdAICc8Y9wC57tXDsa
         WgFvqB2CP16SRGTu4N1nfqbXjs55+8aV0y1OpyEFbnIr+UfZsz7BBGetIsx3sG7qR6
         HVuhnSNBr4Nu7+7YzMkQXyOJMzuvywcxoeqn59A8t4tOZSdTO0yNOfDt8Iae2Rgc9h
         IhgI6fF+4xPjYCNI09CMuoGcpzu1GPynvo8l3MNuzFJQABnKWiRVPPsU1NVQ7EX5Fe
         e2tnZt1gM47Zg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/17] tty: amiserial: use bool and rename overrun flag in receive_chars()
Date:   Tue, 21 Nov 2023 10:22:47 +0100
Message-ID: <20231121092258.9334-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
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

'oe' is a yes-no flag, switch it to boolean. And rename to overrun. All
for the code to be more obvious.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/amiserial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index b9580bb9afd3..a80f059f77bf 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -180,7 +180,7 @@ static void receive_chars(struct serial_state *info)
 	int serdatr;
 	unsigned char ch, flag;
 	struct	async_icount *icount;
-	int oe = 0;
+	bool overrun = false;
 
 	icount = &info->icount;
 
@@ -251,11 +251,11 @@ static void receive_chars(struct serial_state *info)
 	     * reported immediately, and doesn't
 	     * affect the current character
 	     */
-	     oe = 1;
+	     overrun = true;
 	  }
 	}
 	tty_insert_flip_char(&info->tport, ch, flag);
-	if (oe == 1)
+	if (overrun)
 		tty_insert_flip_char(&info->tport, 0, TTY_OVERRUN);
 	tty_flip_buffer_push(&info->tport);
 }
-- 
2.42.1

