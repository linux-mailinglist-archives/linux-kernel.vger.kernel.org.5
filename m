Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9A977740A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjHJJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjHJJP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F6268C;
        Thu, 10 Aug 2023 02:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8697F60BEF;
        Thu, 10 Aug 2023 09:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB10C433C9;
        Thu, 10 Aug 2023 09:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658925;
        bh=zzD47U2fiJ7atwg2ABdKRzZ/x41eZ5wq4Z5hTh7sf/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzPv3J2JOYMcq4zEIe3BKCs5R10ADkxsGRMhTIx4oOoK53k9NQLmKM3x5eAtPg260
         EMQZKGvv4KfXvl6bD/5J/sJPiULlEElLfDb3JwIgDgThwUBZs+wdwhPccr3hhnF89w
         Jjb3BKw9wJAAf0tS4EFZkuLSJVI7dST/7EW2eHPgpeWaJjLF5d09olRtG/fU8SNEmh
         56jne+kgCUfhbRMvcDn9vFcZBblyVeFMbUCmLDBtLM8y6aF41gtmIQ6cggdD7Qs5ty
         uxK6Y7pSWTfrYWHPQmRtfz5aOROPmlEsEdabN4OiHUmtf6Zk0oc304jl4HiiNtp/4K
         pJmJflvio4ZMw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/36] tty: tty_port: rename 'disc' to 'ld'
Date:   Thu, 10 Aug 2023 11:14:40 +0200
Message-ID: <20230810091510.13006-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
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

Line discipline variables are named 'ld' all over the tty code. Rename
these in tty_port, so that it is easier to grep for the code (namely for
"ld->ops").

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_port.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index a788a6bf487d..cda33dec73c3 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -26,19 +26,19 @@ static int tty_port_default_receive_buf(struct tty_port *port,
 {
 	int ret;
 	struct tty_struct *tty;
-	struct tty_ldisc *disc;
+	struct tty_ldisc *ld;
 
 	tty = READ_ONCE(port->itty);
 	if (!tty)
 		return 0;
 
-	disc = tty_ldisc_ref(tty);
-	if (!disc)
+	ld = tty_ldisc_ref(tty);
+	if (!ld)
 		return 0;
 
-	ret = tty_ldisc_receive_buf(disc, p, (char *)f, count);
+	ret = tty_ldisc_receive_buf(ld, p, (char *)f, count);
 
-	tty_ldisc_deref(disc);
+	tty_ldisc_deref(ld);
 
 	return ret;
 }
@@ -47,20 +47,20 @@ static void tty_port_default_lookahead_buf(struct tty_port *port, const unsigned
 					   const unsigned char *f, unsigned int count)
 {
 	struct tty_struct *tty;
-	struct tty_ldisc *disc;
+	struct tty_ldisc *ld;
 
 	tty = READ_ONCE(port->itty);
 	if (!tty)
 		return;
 
-	disc = tty_ldisc_ref(tty);
-	if (!disc)
+	ld = tty_ldisc_ref(tty);
+	if (!ld)
 		return;
 
-	if (disc->ops->lookahead_buf)
-		disc->ops->lookahead_buf(disc->tty, p, f, count);
+	if (ld->ops->lookahead_buf)
+		ld->ops->lookahead_buf(ld->tty, p, f, count);
 
-	tty_ldisc_deref(disc);
+	tty_ldisc_deref(ld);
 }
 
 static void tty_port_default_wakeup(struct tty_port *port)
-- 
2.41.0

