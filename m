Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158AA788C74
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbjHYP2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242391AbjHYP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:28:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2C6213C;
        Fri, 25 Aug 2023 08:28:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9350265B67;
        Fri, 25 Aug 2023 15:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76982C433C7;
        Fri, 25 Aug 2023 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692977313;
        bh=Og+U/MtFwBTheabE1+SCfc/l83oqJcDNoCE6gOZICPE=;
        h=From:To:Cc:Subject:Date:From;
        b=e2cEn7UJ1xskNn3qBwUMs8ngwdimS+Kf6ZZC2scYHOnVpoUmWJ5CicvsXDAOAsQwu
         aAqSk4B0mrvr7SAo/wh3Ua5rUFhg5/FTTK+w2ByvVa/Hn7++1Vi+DyYnrEHtmZ3eYc
         nWcE7QGV3UrjyBWM95/LIpOVYqjMnuzNHMzBNVic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] tty: shrink the size of struct tty_struct by 40 bytes
Date:   Fri, 25 Aug 2023 17:28:20 +0200
Message-ID: <2023082519-cobbler-unholy-8d1f@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  94
X-Developer-Signature: v=1; a=openpgp-sha256; l=2564; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Og+U/MtFwBTheabE1+SCfc/l83oqJcDNoCE6gOZICPE=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkvTky+aL56DU+NcY3kWZ0k85UH85UX2x7k2hWgYCyvX FKQwvS+I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACYyx4JhflKPZKNh2qO1mu8n dbru71NkbN5ryzC/5ofM9wsS9nv2uqb3aa6rXjol2CMJAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
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

It's been a long time since anyone has looked at what struct tty_struct
looks like in memory, turns out there was a ton of holes.

So move things around a bit, change one variable (closing) from being an
int to a bool (it is only being tested for 0/1), and we end up saving 40
bytes per structure overall on x86-64 systems.

Before this patch:
	/* size: 696, cachelines: 11, members: 37 */
	/* sum members: 665, holes: 8, sum holes: 31 */
	/* forced alignments: 2, forced holes: 1, sum forced holes: 4 */
	/* last cacheline: 56 bytes */

After this change:
	/* size: 656, cachelines: 11, members: 37 */
	/* sum members: 654, holes: 1, sum holes: 2 */
	/* forced alignments: 2 */
	/* last cacheline: 16 bytes */

Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/tty.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index e8d5d9997aca..f002d0f25db7 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -192,13 +192,14 @@ struct tty_operations;
  */
 struct tty_struct {
 	struct kref kref;
+	int index;
 	struct device *dev;
 	struct tty_driver *driver;
+	struct tty_port *port;
 	const struct tty_operations *ops;
-	int index;
 
-	struct ld_semaphore ldisc_sem;
 	struct tty_ldisc *ldisc;
+	struct ld_semaphore ldisc_sem;
 
 	struct mutex atomic_write_lock;
 	struct mutex legacy_mutex;
@@ -209,6 +210,7 @@ struct tty_struct {
 	char name[64];
 	unsigned long flags;
 	int count;
+	unsigned int receive_room;
 	struct winsize winsize;
 
 	struct {
@@ -219,16 +221,16 @@ struct tty_struct {
 	} __aligned(sizeof(unsigned long)) flow;
 
 	struct {
-		spinlock_t lock;
 		struct pid *pgrp;
 		struct pid *session;
+		spinlock_t lock;
 		unsigned char pktstatus;
 		bool packet;
 		unsigned long unused[0];
 	} __aligned(sizeof(unsigned long)) ctrl;
 
 	bool hw_stopped;
-	unsigned int receive_room;
+	bool closing;
 	int flow_change;
 
 	struct tty_struct *link;
@@ -239,15 +241,13 @@ struct tty_struct {
 	void *disc_data;
 	void *driver_data;
 	spinlock_t files_lock;
+	int write_cnt;
+	unsigned char *write_buf;
+
 	struct list_head tty_files;
 
 #define N_TTY_BUF_SIZE 4096
-
-	int closing;
-	unsigned char *write_buf;
-	int write_cnt;
 	struct work_struct SAK_work;
-	struct tty_port *port;
 } __randomize_layout;
 
 /* Each of a tty's open files has private_data pointing to tty_file_private */
-- 
2.42.0

