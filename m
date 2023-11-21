Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B177F28CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjKUJX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjKUJXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263B510C0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BFFC433BD;
        Tue, 21 Nov 2023 09:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558603;
        bh=+5n2mUpG4q3myzhvyd7KfFL/hxg0CFLJ/PmuTSTaY6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ljq1V0RC2KP6ws3XfIFi2ZR28B0v5Bfu38nZAOFsLytKLElqcxHwreJJQLxWZ+fri
         mWSMDDvPs64Aof9bEcPnM6TRuWBTy6YOzLt5yZUy3MqiUdh74Iyne4CQryja0MK6DC
         WW+HJ6KY+9qIRLpdDaiBqHyNQgxwzYbL+77WrZM2DtKVU824khjepG0Sfqt/9BCMb6
         Up2caehfFcZlTOCyI9KomPdNrrUHfY9h8wDItDtRiHa/2GIAw5UGnOtwrcUJh4Q1+j
         u/WCFpblEnv7exzQktl2l7+Y04/Xlv/eIRTeaQsfQh8IoFf1+L9BdNJg/d1Pcljsn/
         +rohHZM+ihVlg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/17] tty: hvc_console: use flexible array for outbuf
Date:   Tue, 21 Nov 2023 10:22:52 +0100
Message-ID: <20231121092258.9334-12-jirislaby@kernel.org>
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

This means:
* move outbuf to the end of struct hvc_struct and convert from pointer
  to flexible array (the structure is smaller now)
* use struct_size() at the allocation site
* align outbuf in the struct instead of ALIGN() at kzalloc()

And apart from the above, use u8 instead of char (which are the same
thanks to -funsigned-char). The former is now preferred over the latter.

It makes the code easier to understand.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/hvc/hvc_console.c | 4 +---
 drivers/tty/hvc/hvc_console.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 959fae54ca39..93b613e1f176 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -922,8 +922,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 			return ERR_PTR(err);
 	}
 
-	hp = kzalloc(ALIGN(sizeof(*hp), sizeof(long)) + outbuf_size,
-			GFP_KERNEL);
+	hp = kzalloc(struct_size(hp, outbuf, outbuf_size), GFP_KERNEL);
 	if (!hp)
 		return ERR_PTR(-ENOMEM);
 
@@ -931,7 +930,6 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 	hp->data = data;
 	hp->ops = ops;
 	hp->outbuf_size = outbuf_size;
-	hp->outbuf = &((char *)hp)[ALIGN(sizeof(*hp), sizeof(long))];
 
 	tty_port_init(&hp->port);
 	hp->port.ops = &hvc_port_ops;
diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index 9668f821db01..b718714bf399 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -37,7 +37,6 @@ struct hvc_struct {
 	spinlock_t lock;
 	int index;
 	int do_wakeup;
-	char *outbuf;
 	int outbuf_size;
 	int n_outbuf;
 	uint32_t vtermno;
@@ -48,6 +47,7 @@ struct hvc_struct {
 	struct work_struct tty_resize;
 	struct list_head next;
 	unsigned long flags;
+	u8 outbuf[] __aligned(sizeof(long));
 };
 
 /* implemented by a low level driver */
-- 
2.42.1

