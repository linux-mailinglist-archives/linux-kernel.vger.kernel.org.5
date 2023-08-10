Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3407773FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjHJJPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjHJJPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690352127;
        Thu, 10 Aug 2023 02:15:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E58BA612F0;
        Thu, 10 Aug 2023 09:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45835C433CB;
        Thu, 10 Aug 2023 09:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658917;
        bh=YhVm3D91GFk60mbhCwKIh8ODpcpzIPLgoAF+cMfYFa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUTW6o0exNR3VMnAmiAo1Ie6Z7i2rlGUwaOG2OKBzVaho2LsUHf4JccCny6xImN8P
         aQHh0YCVlaavKGdx5R5Wfk2nk3E03xT0PTBY8xppZ5vLk6BnTE5OFOqVpp38nkTwb4
         FT6aSyrNysZPqUJflWlBFD+HOyGHbIiWd3o4vPlhUQlZ9Qj+dFjLT3h4mOW/wGyOWD
         K0ln82LYyuX7DynjO3HT0KyRBjBThvHQgkKxOEEYoSenOv/BxMPdrFD/3BkHmTy7O5
         eUvRZWhakBFWaFQgwU9LhvamPAL9Tsuuq9xEqQV1lJHAh2oESfYNTetoJSy8FEXDSJ
         eoLMgym9ATVqw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 02/36] tty: ldisc: document that ldops are optional
Date:   Thu, 10 Aug 2023 11:14:36 +0200
Message-ID: <20230810091510.13006-3-jirislaby@kernel.org>
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

There is no need to provide any hook in struct tty_ldisc_ops. Document
that and write down that read/write return EIO in that case. The rest is
simply ignored.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/tty_ldisc.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 49dc172dedc7..62e089434995 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -71,7 +71,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	call to @receive_buf(). Returning an error will prevent the ldisc from
  *	being attached.
  *
- *	Can sleep.
+ *	Optional. Can sleep.
  *
  * @close: [TTY] ``void ()(struct tty_struct *tty)``
  *
@@ -80,7 +80,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	changed to use a new line discipline. At the point of execution no
  *	further users will enter the ldisc code for this tty.
  *
- *	Can sleep.
+ *	Optional. Can sleep.
  *
  * @flush_buffer: [TTY] ``void ()(struct tty_struct *tty)``
  *
@@ -88,6 +88,8 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	input characters it may have queued to be delivered to the user mode
  *	process. It may be called at any point between open and close.
  *
+ *	Optional.
+ *
  * @read: [TTY] ``ssize_t ()(struct tty_struct *tty, struct file *file,
  *		unsigned char *buf, size_t nr)``
  *
@@ -97,7 +99,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	an %EIO error. Multiple read calls may occur in parallel and the ldisc
  *	must deal with serialization issues.
  *
- *	Can sleep.
+ *	Optional: %EIO unless provided. Can sleep.
  *
  * @write: [TTY] ``ssize_t ()(struct tty_struct *tty, struct file *file,
  *		const unsigned char *buf, size_t nr)``
@@ -108,7 +110,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	characters first. If this function is not defined, the user will
  *	receive an %EIO error.
  *
- *	Can sleep.
+ *	Optional: %EIO unless provided. Can sleep.
  *
  * @ioctl: [TTY] ``int ()(struct tty_struct *tty, unsigned int cmd,
  *		unsigned long arg)``
@@ -120,6 +122,8 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	discpline. So a low-level driver can "grab" an ioctl request before
  *	the line discpline has a chance to see it.
  *
+ *	Optional.
+ *
  * @compat_ioctl: [TTY] ``int ()(struct tty_struct *tty, unsigned int cmd,
  *		unsigned long arg)``
  *
@@ -130,11 +134,15 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	a pointer to wordsize-sensitive structure belongs here, but most of
  *	ldiscs will happily leave it %NULL.
  *
+ *	Optional.
+ *
  * @set_termios: [TTY] ``void ()(struct tty_struct *tty, const struct ktermios *old)``
  *
  *	This function notifies the line discpline that a change has been made
  *	to the termios structure.
  *
+ *	Optional.
+ *
  * @poll: [TTY] ``int ()(struct tty_struct *tty, struct file *file,
  *		  struct poll_table_struct *wait)``
  *
@@ -142,6 +150,8 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	device. It is solely the responsibility of the line discipline to
  *	handle poll requests.
  *
+ *	Optional.
+ *
  * @hangup: [TTY] ``void ()(struct tty_struct *tty)``
  *
  *	Called on a hangup. Tells the discipline that it should cease I/O to
@@ -149,7 +159,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	but should wait until any pending driver I/O is completed. No further
  *	calls into the ldisc code will occur.
  *
- *	Can sleep.
+ *	Optional. Can sleep.
  *
  * @receive_buf: [DRV] ``void ()(struct tty_struct *tty,
  *		       const unsigned char *cp, const char *fp, int count)``
@@ -161,6 +171,8 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	character was received with a parity error, etc. @fp may be %NULL to
  *	indicate all data received is %TTY_NORMAL.
  *
+ *	Optional.
+ *
  * @write_wakeup: [DRV] ``void ()(struct tty_struct *tty)``
  *
  *	This function is called by the low-level tty driver to signal that line
@@ -170,11 +182,15 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	send, please arise a tasklet or workqueue to do the real data transfer.
  *	Do not send data in this hook, it may lead to a deadlock.
  *
+ *	Optional.
+ *
  * @dcd_change: [DRV] ``void ()(struct tty_struct *tty, bool active)``
  *
  *	Tells the discipline that the DCD pin has changed its status. Used
  *	exclusively by the %N_PPS (Pulse-Per-Second) line discipline.
  *
+ *	Optional.
+ *
  * @receive_buf2: [DRV] ``int ()(struct tty_struct *tty,
  *			const unsigned char *cp, const char *fp, int count)``
  *
@@ -186,6 +202,8 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	indicate all data received is %TTY_NORMAL. If assigned, prefer this
  *	function for automatic flow control.
  *
+ *	Optional.
+ *
  * @lookahead_buf: [DRV] ``void ()(struct tty_struct *tty,
  *			const unsigned char *cp, const char *fp, int count)``
  *
@@ -198,6 +216,8 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	same characters (e.g. by skipping the actions for high-priority
  *	characters already handled by ->lookahead_buf()).
  *
+ *	Optional.
+ *
  * @owner: module containting this ldisc (for reference counting)
  *
  * This structure defines the interface between the tty line discipline
-- 
2.41.0

