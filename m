Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E4B77740E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjHJJQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjHJJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B642696;
        Thu, 10 Aug 2023 02:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13911654C2;
        Thu, 10 Aug 2023 09:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DAAC433CA;
        Thu, 10 Aug 2023 09:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658931;
        bh=JI/gyP3Cm1MEGHxmTW2IZoSZ+iU2JTsNgxoLX4Jh4Ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9c2JSXUNhX4VtjROuDdB+IUdzlrOJwikdBhi0h8NpzN86Gb5r0AK/jqSvD2FlZl7
         qeyoab2oh6dbU9nvC5TjACeTGvzvtq5gvws6L7V7kB0g0kH9cKHBgC6eMHOVNhxj7y
         kWwgMaIzWbBw4QlrDuUbry17vI4OIcqU4RPaZPrTGy/pYl8kPSwJAR0NYOu+FYp3I+
         p1HCUvYO/zv7v4V1k+9fnkSkDdZB1uJHOmGRjoQLeb9u27RUOoFwCEdcmnQwVQpDe7
         dRd4/0x8r7MU93F58WY+GVLMOj/0sSL2tdHbclRY8IeXOR6aF8S9LPJxU6stk0eCzA
         xDBaIGcTAYg2g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 10/36] tty: make counts in tty_port_client_operations hooks size_t
Date:   Thu, 10 Aug 2023 11:14:44 +0200
Message-ID: <20230810091510.13006-11-jirislaby@kernel.org>
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

The counts in tty_port_client_operations hooks' are currently
represented by all 'int', 'unsigned int', and 'size_t'. Unify them all
to unsigned 'size_t' for clarity. Note that size_t is used already in
tty_buffer.c. So, eventually, it is spread for counts everywhere and
this is the beginning.

So the two changes namely:
* ::receive_buf() is called from tty_ldisc_receive_buf(). And that
  expects values ">= 0" from ::receive_buf(), so switch its rettype to
  size_t is fine. tty_ldisc_receive_buf() types will be changed
  separately.
* ::lookahead_buf()'s count comes from lookahead_bufs() and is already
  'unsigned int'.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c |  4 ++--
 drivers/tty/tty_port.c              | 11 +++++------
 include/linux/tty_port.h            |  6 +++---
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index f69ae27838e3..e3856814ce77 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -22,8 +22,8 @@ struct serport {
  * Callback functions from the tty port.
  */
 
-static int ttyport_receive_buf(struct tty_port *port, const u8 *cp,
-				const u8 *fp, size_t count)
+static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
+				  const u8 *fp, size_t count)
 {
 	struct serdev_controller *ctrl = port->client_data;
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 6bf58980c81d..7fd171b7c844 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -20,10 +20,9 @@
 #include <linux/serdev.h>
 #include "tty.h"
 
-static int tty_port_default_receive_buf(struct tty_port *port, const u8 *p,
-					const u8 *f, size_t count)
+static size_t tty_port_default_receive_buf(struct tty_port *port, const u8 *p,
+					   const u8 *f, size_t count)
 {
-	int ret;
 	struct tty_struct *tty;
 	struct tty_ldisc *ld;
 
@@ -35,15 +34,15 @@ static int tty_port_default_receive_buf(struct tty_port *port, const u8 *p,
 	if (!ld)
 		return 0;
 
-	ret = tty_ldisc_receive_buf(ld, p, (char *)f, count);
+	count = tty_ldisc_receive_buf(ld, p, (char *)f, count);
 
 	tty_ldisc_deref(ld);
 
-	return ret;
+	return count;
 }
 
 static void tty_port_default_lookahead_buf(struct tty_port *port, const u8 *p,
-					   const u8 *f, unsigned int count)
+					   const u8 *f, size_t count)
 {
 	struct tty_struct *tty;
 	struct tty_ldisc *ld;
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 726575743367..6b367eb17979 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -39,10 +39,10 @@ struct tty_port_operations {
 };
 
 struct tty_port_client_operations {
-	int (*receive_buf)(struct tty_port *port, const u8 *cp, const u8 *fp,
-			   size_t count);
+	size_t (*receive_buf)(struct tty_port *port, const u8 *cp, const u8 *fp,
+			      size_t count);
 	void (*lookahead_buf)(struct tty_port *port, const u8 *cp,
-			      const u8 *fp, unsigned int count);
+			      const u8 *fp, size_t count);
 	void (*write_wakeup)(struct tty_port *port);
 };
 
-- 
2.41.0

