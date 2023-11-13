Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FFE7EA2D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjKMSaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMSaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:30:09 -0500
X-Greylist: delayed 361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 10:30:05 PST
Received: from harvie.cz (harvie.cz [77.87.242.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 130A410EC;
        Mon, 13 Nov 2023 10:30:05 -0800 (PST)
Received: from anemophobia.amit.cz (unknown [31.30.84.130])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by harvie.cz (Postfix) with ESMTPSA id 2FA2B1802A6;
        Mon, 13 Nov 2023 19:24:02 +0100 (CET)
From:   Tomas Mudrunka <tomas.mudrunka@gmail.com>
Cc:     tomas.mudrunka@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] /proc/sysrq-trigger: accept multiple keys at once
Date:   Mon, 13 Nov 2023 19:22:19 +0100
Message-ID: <20231113182227.698989-1-tomas.mudrunka@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,
        SPOOF_GMAIL_MID,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just for convenience.
This way we can do:
`echo reisub > /proc/sysrq-trigger`
Instead of:
`for i in r e i s u b; do echo "$i" > /proc/sysrq-trigger; done;`

Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
---
 drivers/tty/sysrq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6b4a28bcf..bc5a679f6 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -1154,10 +1154,12 @@ EXPORT_SYMBOL(unregister_sysrq_key);
 static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
 				   size_t count, loff_t *ppos)
 {
-	if (count) {
+	size_t i;
+
+	for (i = 0; i < count; i++) {
 		char c;
 
-		if (get_user(c, buf))
+		if (get_user(c, buf+i))
 			return -EFAULT;
 		__handle_sysrq(c, false);
 	}
-- 
2.42.1

