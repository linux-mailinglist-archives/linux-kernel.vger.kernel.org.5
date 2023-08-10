Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC777740F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjHJJQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjHJJPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B695A271C;
        Thu, 10 Aug 2023 02:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 514B560BEF;
        Thu, 10 Aug 2023 09:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79965C433CB;
        Thu, 10 Aug 2023 09:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658929;
        bh=xDwMYMe8HeseN+qdggjFBBvydlF7Iv9hfK/CmBpqWAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2bBEfvBnTxgthuuR3wudqi9EKQl6CylSbnFle/QsLKgcj3wY4Vff8/o608x4CljK
         /kZohp4w54HTdc3idcnb+Iz9psT19tZs3SEkgZ4U61KS/bFVLMQdiXNH5HJW4/hhVb
         YsTEcoRUt4BDj5OgUaaf2INUPz0qhYyoGs8m7ExWncqBmbEp92WiqE86vmb3ifuRNp
         i5uy9SXtf2dyJlZuV/OBbStk6Ir8UdRtMZPjVaH6os4Gcu+BVfSILqMAyYV9B8lj/t
         hojUYeKosA6E75CoLVIMjLOnYMnvNOajEVu9zec+F72o1a7EbQVTc3s6XUrf6ylKra
         DT6U2Drc0t43Q==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 09/36] tty: make tty_port_client_operations operate with u8
Date:   Thu, 10 Aug 2023 11:14:43 +0200
Message-ID: <20230810091510.13006-10-jirislaby@kernel.org>
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

The parameters are already unsigned chars. So make them explicitly u8s,
as the rest is going to be unified to u8 eventually too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 4 ++--
 drivers/tty/tty_buffer.c            | 4 ++--
 drivers/tty/tty_port.c              | 9 ++++-----
 include/linux/tty_port.h            | 7 ++++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 8033ef19669c..f69ae27838e3 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -22,8 +22,8 @@ struct serport {
  * Callback functions from the tty port.
  */
 
-static int ttyport_receive_buf(struct tty_port *port, const unsigned char *cp,
-				const unsigned char *fp, size_t count)
+static int ttyport_receive_buf(struct tty_port *port, const u8 *cp,
+				const u8 *fp, size_t count)
 {
 	struct serdev_controller *ctrl = port->client_data;
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 2df86ed90574..42464c37125a 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -505,8 +505,8 @@ static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
 static int
 receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
 {
-	unsigned char *p = char_buf_ptr(head, head->read);
-	const char *f = NULL;
+	u8 *p = char_buf_ptr(head, head->read);
+	const u8 *f = NULL;
 	int n;
 
 	if (head->flags)
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index cda33dec73c3..6bf58980c81d 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -20,9 +20,8 @@
 #include <linux/serdev.h>
 #include "tty.h"
 
-static int tty_port_default_receive_buf(struct tty_port *port,
-					const unsigned char *p,
-					const unsigned char *f, size_t count)
+static int tty_port_default_receive_buf(struct tty_port *port, const u8 *p,
+					const u8 *f, size_t count)
 {
 	int ret;
 	struct tty_struct *tty;
@@ -43,8 +42,8 @@ static int tty_port_default_receive_buf(struct tty_port *port,
 	return ret;
 }
 
-static void tty_port_default_lookahead_buf(struct tty_port *port, const unsigned char *p,
-					   const unsigned char *f, unsigned int count)
+static void tty_port_default_lookahead_buf(struct tty_port *port, const u8 *p,
+					   const u8 *f, unsigned int count)
 {
 	struct tty_struct *tty;
 	struct tty_ldisc *ld;
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index edf685a24f7c..726575743367 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -39,9 +39,10 @@ struct tty_port_operations {
 };
 
 struct tty_port_client_operations {
-	int (*receive_buf)(struct tty_port *port, const unsigned char *, const unsigned char *, size_t);
-	void (*lookahead_buf)(struct tty_port *port, const unsigned char *cp,
-			      const unsigned char *fp, unsigned int count);
+	int (*receive_buf)(struct tty_port *port, const u8 *cp, const u8 *fp,
+			   size_t count);
+	void (*lookahead_buf)(struct tty_port *port, const u8 *cp,
+			      const u8 *fp, unsigned int count);
 	void (*write_wakeup)(struct tty_port *port);
 };
 
-- 
2.41.0

