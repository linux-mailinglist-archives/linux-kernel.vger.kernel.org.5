Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397D9777413
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjHJJQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjHJJPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBFE2D63;
        Thu, 10 Aug 2023 02:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AFD060BEF;
        Thu, 10 Aug 2023 09:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7346FC433CB;
        Thu, 10 Aug 2023 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658934;
        bh=ssoPI6gswdkKi9OGRHKTLnEGYWRZHoy8meC/8c63yRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTYL49ifTxa6dq1iu8jISKzAX21Tt9qMZ8SfcFaDTwx3YAEV73ExyoTY96IVaZtQI
         esyOW7DNSBZcMWm/hkpd2+LRbAXuzI/jy1poJMRguq5fOwaRxO+ysXE49Q/RvvBpJ4
         IjmUDcnv2qRKB8SE7KrN0PqKqy+rhBCdA/V7J7fBJ8USn6XXhQe89ifrutCODq7u7W
         VBcgEpvNq/gIgBgVdIIziiei/xJsrsJvm7mVcm9jZ0OVEAll6Affg5ynQj0YIi0Prd
         Fh77XHAMxFTkGyX+AZWjiBgTqqJfoiA2ch1NpGeFgGev1wWWE36+xwgxThePCUMvfI
         LME+TxzpUjesg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 12/36] tty: switch count in tty_ldisc_receive_buf() to size_t
Date:   Thu, 10 Aug 2023 11:14:46 +0200
Message-ID: <20230810091510.13006-13-jirislaby@kernel.org>
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

It comes from both paste_selection() and tty_port_default_receive_buf()
as unsigned (int and size_t respectively). Switch to size_t to converge
to that eventually.

Return the count as size_t too (the two callers above expect that).

Switch paste_selection()'s type of 'count' too, so that the returned and
passed type match.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_buffer.c   | 6 +++---
 drivers/tty/vt/selection.c | 2 +-
 include/linux/tty_flip.h   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 7182dab60fac..56f5732ce47f 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -450,13 +450,13 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
  *
  * Returns: the number of bytes processed.
  */
-int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
-			  const char *f, int count)
+size_t tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
+			     const char *f, size_t count)
 {
 	if (ld->ops->receive_buf2)
 		count = ld->ops->receive_buf2(ld->tty, p, f, count);
 	else {
-		count = min_t(int, count, ld->tty->receive_room);
+		count = min_t(size_t, count, ld->tty->receive_room);
 		if (count && ld->ops->receive_buf)
 			ld->ops->receive_buf(ld->tty, p, f, count);
 	}
diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 6ef22f01cc51..8967c3a0d916 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -376,7 +376,7 @@ int paste_selection(struct tty_struct *tty)
 {
 	struct vc_data *vc = tty->driver_data;
 	int	pasted = 0;
-	unsigned int count;
+	size_t count;
 	struct  tty_ldisc *ld;
 	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index bfaaeee61a05..09c4dbcd0025 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -41,8 +41,8 @@ static inline int tty_insert_flip_string(struct tty_port *port,
 	return tty_insert_flip_string_fixed_flag(port, chars, TTY_NORMAL, size);
 }
 
-int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
-		const char *f, int count);
+size_t tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
+			     const char *f, size_t count);
 
 void tty_buffer_lock_exclusive(struct tty_port *port);
 void tty_buffer_unlock_exclusive(struct tty_port *port);
-- 
2.41.0

