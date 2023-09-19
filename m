Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8197A5D04
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjISIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjISIw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E27185;
        Tue, 19 Sep 2023 01:52:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D09C433C7;
        Tue, 19 Sep 2023 08:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113531;
        bh=lWPoGywOM03VfQQuL+QKz4uiL36Kr7BFDG2Svs58fQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7eWl4Gq2fCReDoCLPf+NE0Lu21uz1n1yfWtoI0Fwv2cfhQU7Eq4rE4WF1Jg1/EbT
         2tcDe0K1KSv41Qf9WbTbKdfiBW1GyjfQT+qzVvqE8aZRD0/D+bAWm6SzKbdNygKiE8
         IFOUoD4X5WQfbMF069HmOnSradNhh5y2Sjmish7fWAsY2LMvkknC0JbGgb0xRd3jf5
         DGALeraenZZwIS5EZ+OwgnxoMhlfK3RD9/c5boH8I0vGxVJad7DF27Q4UGzu51n7sr
         q151OanDXlPCg3pH+8e5ioNjo6imdDuCujkbSFe1odbFdYgyKSv6Fitc9M6uvp7eYS
         5ervjHJbe3z+A==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 08/15] tty: fix up and plug in tty_ioctl kernel-doc
Date:   Tue, 19 Sep 2023 10:51:49 +0200
Message-ID: <20230919085156.1578-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919085156.1578-1-jirislaby@kernel.org>
References: <20230919085156.1578-1-jirislaby@kernel.org>
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

The ioctl helpers are well documented, except they are not plugged in
the Documentation. So fix up the minor issues in the kernel-doc and plug
it in.

The minor issues include:
* bad \t on every line (sphinx misinterprets the description otherwise)
* missing colon after Return
* superfluous \n after the comment
* make some struct members and constants a hyperlink
* and so on

Perhaps better to use --word-diff if one wants to see the "real"
changes.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 Documentation/driver-api/tty/index.rst     |   1 +
 Documentation/driver-api/tty/tty_ioctl.rst |   7 +
 drivers/tty/tty_ioctl.c                    | 218 ++++++++++-----------
 3 files changed, 115 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/driver-api/tty/tty_ioctl.rst

diff --git a/Documentation/driver-api/tty/index.rst b/Documentation/driver-api/tty/index.rst
index 2d32606a4278..b490da11f257 100644
--- a/Documentation/driver-api/tty/index.rst
+++ b/Documentation/driver-api/tty/index.rst
@@ -36,6 +36,7 @@ In-detail description of the named TTY structures is in separate documents:
    tty_struct
    tty_ldisc
    tty_buffer
+   tty_ioctl
    tty_internals
 
 Writing TTY Driver
diff --git a/Documentation/driver-api/tty/tty_ioctl.rst b/Documentation/driver-api/tty/tty_ioctl.rst
new file mode 100644
index 000000000000..9b0be79fc15e
--- /dev/null
+++ b/Documentation/driver-api/tty/tty_ioctl.rst
@@ -0,0 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+TTY IOCTL Helpers
+=================
+
+.. kernel-doc:: drivers/tty/tty_ioctl.c
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index fb2f1ac5172f..42c793e9d131 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -38,16 +38,13 @@
 #define TERMIOS_TERMIO	BIT(2)
 #define TERMIOS_OLD	BIT(3)
 
-
 /**
- *	tty_chars_in_buffer	-	characters pending
- *	@tty: terminal
+ * tty_chars_in_buffer - characters pending
+ * @tty: terminal
  *
- *	Return the number of bytes of data in the device private
- *	output queue. If no private method is supplied there is assumed
- *	to be no queue on the device.
+ * Returns: the number of bytes of data in the device private output queue. If
+ * no private method is supplied there is assumed to be no queue on the device.
  */
-
 unsigned int tty_chars_in_buffer(struct tty_struct *tty)
 {
 	if (tty->ops->chars_in_buffer)
@@ -57,16 +54,15 @@ unsigned int tty_chars_in_buffer(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_chars_in_buffer);
 
 /**
- *	tty_write_room		-	write queue space
- *	@tty: terminal
+ * tty_write_room - write queue space
+ * @tty: terminal
  *
- *	Return the number of bytes that can be queued to this device
- *	at the present time. The result should be treated as a guarantee
- *	and the driver cannot offer a value it later shrinks by more than
- *	the number of bytes written. If no method is provided 2K is always
- *	returned and data may be lost as there will be no flow control.
+ * Returns: the number of bytes that can be queued to this device at the present
+ * time. The result should be treated as a guarantee and the driver cannot
+ * offer a value it later shrinks by more than the number of bytes written. If
+ * no method is provided, 2K is always returned and data may be lost as there
+ * will be no flow control.
  */
- 
 unsigned int tty_write_room(struct tty_struct *tty)
 {
 	if (tty->ops->write_room)
@@ -76,12 +72,12 @@ unsigned int tty_write_room(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_write_room);
 
 /**
- *	tty_driver_flush_buffer	-	discard internal buffer
- *	@tty: terminal
+ * tty_driver_flush_buffer - discard internal buffer
+ * @tty: terminal
  *
- *	Discard the internal output buffer for this device. If no method
- *	is provided then either the buffer cannot be hardware flushed or
- *	there is no buffer driver side.
+ * Discard the internal output buffer for this device. If no method is provided,
+ * then either the buffer cannot be hardware flushed or there is no buffer
+ * driver side.
  */
 void tty_driver_flush_buffer(struct tty_struct *tty)
 {
@@ -91,18 +87,17 @@ void tty_driver_flush_buffer(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_driver_flush_buffer);
 
 /**
- *	tty_unthrottle		-	flow control
- *	@tty: terminal
+ * tty_unthrottle - flow control
+ * @tty: terminal
  *
- *	Indicate that a tty may continue transmitting data down the stack.
- *	Takes the termios rwsem to protect against parallel throttle/unthrottle
- *	and also to ensure the driver can consistently reference its own
- *	termios data at this point when implementing software flow control.
+ * Indicate that a @tty may continue transmitting data down the stack. Takes
+ * the &tty_struct->termios_rwsem to protect against parallel
+ * throttle/unthrottle and also to ensure the driver can consistently reference
+ * its own termios data at this point when implementing software flow control.
  *
- *	Drivers should however remember that the stack can issue a throttle,
- *	then change flow control method, then unthrottle.
+ * Drivers should however remember that the stack can issue a throttle, then
+ * change flow control method, then unthrottle.
  */
-
 void tty_unthrottle(struct tty_struct *tty)
 {
 	down_write(&tty->termios_rwsem);
@@ -115,16 +110,15 @@ void tty_unthrottle(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_unthrottle);
 
 /**
- *	tty_throttle_safe	-	flow control
- *	@tty: terminal
+ * tty_throttle_safe - flow control
+ * @tty: terminal
  *
- *	Indicate that a tty should stop transmitting data down the stack.
- *	tty_throttle_safe will only attempt throttle if tty->flow_change is
- *	TTY_THROTTLE_SAFE. Prevents an accidental throttle due to race
- *	conditions when throttling is conditional on factors evaluated prior to
- *	throttling.
+ * Indicate that a @tty should stop transmitting data down the stack.
+ * tty_throttle_safe() will only attempt throttle if @tty->flow_change is
+ * %TTY_THROTTLE_SAFE. Prevents an accidental throttle due to race conditions
+ * when throttling is conditional on factors evaluated prior to throttling.
  *
- *	Returns true if tty is throttled (or was already throttled)
+ * Returns: %true if @tty is throttled (or was already throttled)
  */
 bool tty_throttle_safe(struct tty_struct *tty)
 {
@@ -146,15 +140,15 @@ bool tty_throttle_safe(struct tty_struct *tty)
 }
 
 /**
- *	tty_unthrottle_safe	-	flow control
- *	@tty: terminal
+ * tty_unthrottle_safe - flow control
+ * @tty: terminal
  *
- *	Similar to tty_unthrottle() but will only attempt unthrottle
- *	if tty->flow_change is TTY_UNTHROTTLE_SAFE. Prevents an accidental
- *	unthrottle due to race conditions when unthrottling is conditional
- *	on factors evaluated prior to unthrottling.
+ * Similar to tty_unthrottle() but will only attempt unthrottle if
+ * @tty->flow_change is %TTY_UNTHROTTLE_SAFE. Prevents an accidental unthrottle
+ * due to race conditions when unthrottling is conditional on factors evaluated
+ * prior to unthrottling.
  *
- *	Returns true if tty is unthrottled (or was already unthrottled)
+ * Returns: %true if @tty is unthrottled (or was already unthrottled)
  */
 bool tty_unthrottle_safe(struct tty_struct *tty)
 {
@@ -176,14 +170,14 @@ bool tty_unthrottle_safe(struct tty_struct *tty)
 }
 
 /**
- *	tty_wait_until_sent	-	wait for I/O to finish
- *	@tty: tty we are waiting for
- *	@timeout: how long we will wait
+ * tty_wait_until_sent - wait for I/O to finish
+ * @tty: tty we are waiting for
+ * @timeout: how long we will wait
  *
- *	Wait for characters pending in a tty driver to hit the wire, or
- *	for a timeout to occur (eg due to flow control)
+ * Wait for characters pending in a tty driver to hit the wire, or for a
+ * timeout to occur (eg due to flow control).
  *
- *	Locking: none
+ * Locking: none
  */
 
 void tty_wait_until_sent(struct tty_struct *tty, long timeout)
@@ -229,16 +223,15 @@ static void unset_locked_termios(struct tty_struct *tty, const struct ktermios *
 }
 
 /**
- *	tty_termios_copy_hw	-	copy hardware settings
- *	@new: New termios
- *	@old: Old termios
+ * tty_termios_copy_hw - copy hardware settings
+ * @new: new termios
+ * @old: old termios
  *
- *	Propagate the hardware specific terminal setting bits from
- *	the old termios structure to the new one. This is used in cases
- *	where the hardware does not support reconfiguration or as a helper
- *	in some cases where only minimal reconfiguration is supported
+ * Propagate the hardware specific terminal setting bits from the @old termios
+ * structure to the @new one. This is used in cases where the hardware does not
+ * support reconfiguration or as a helper in some cases where only minimal
+ * reconfiguration is supported.
  */
-
 void tty_termios_copy_hw(struct ktermios *new, const struct ktermios *old)
 {
 	/* The bits a dumb device handles in software. Smart devices need
@@ -251,14 +244,15 @@ void tty_termios_copy_hw(struct ktermios *new, const struct ktermios *old)
 EXPORT_SYMBOL(tty_termios_copy_hw);
 
 /**
- *	tty_termios_hw_change	-	check for setting change
- *	@a: termios
- *	@b: termios to compare
+ * tty_termios_hw_change - check for setting change
+ * @a: termios
+ * @b: termios to compare
  *
- *	Check if any of the bits that affect a dumb device have changed
- *	between the two termios structures, or a speed change is needed.
+ * Check if any of the bits that affect a dumb device have changed between the
+ * two termios structures, or a speed change is needed.
+ *
+ * Returns: %true if change is needed
  */
-
 bool tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
 {
 	if (a->c_ispeed != b->c_ispeed || a->c_ospeed != b->c_ospeed)
@@ -270,11 +264,10 @@ bool tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
 EXPORT_SYMBOL(tty_termios_hw_change);
 
 /**
- *	tty_get_char_size	-	get size of a character
- *	@cflag: termios cflag value
+ * tty_get_char_size - get size of a character
+ * @cflag: termios cflag value
  *
- *	Get the size (in bits) of a character depending on @cflag's %CSIZE
- *	setting.
+ * Returns: size (in bits) of a character depending on @cflag's %CSIZE setting
  */
 unsigned char tty_get_char_size(unsigned int cflag)
 {
@@ -293,13 +286,14 @@ unsigned char tty_get_char_size(unsigned int cflag)
 EXPORT_SYMBOL_GPL(tty_get_char_size);
 
 /**
- *	tty_get_frame_size	-	get size of a frame
- *	@cflag: termios cflag value
+ * tty_get_frame_size - get size of a frame
+ * @cflag: termios cflag value
  *
- *	Get the size (in bits) of a frame depending on @cflag's %CSIZE, %CSTOPB,
- *	and %PARENB setting. The result is a sum of character size, start and
- *	stop bits -- one bit each -- second stop bit (if set), and parity bit
- *	(if set).
+ * Get the size (in bits) of a frame depending on @cflag's %CSIZE, %CSTOPB, and
+ * %PARENB setting. The result is a sum of character size, start and stop bits
+ * -- one bit each -- second stop bit (if set), and parity bit (if set).
+ *
+ * Returns: size (in bits) of a frame depending on @cflag's setting.
  */
 unsigned char tty_get_frame_size(unsigned int cflag)
 {
@@ -317,16 +311,15 @@ unsigned char tty_get_frame_size(unsigned int cflag)
 EXPORT_SYMBOL_GPL(tty_get_frame_size);
 
 /**
- *	tty_set_termios		-	update termios values
- *	@tty: tty to update
- *	@new_termios: desired new value
+ * tty_set_termios - update termios values
+ * @tty: tty to update
+ * @new_termios: desired new value
  *
- *	Perform updates to the termios values set on this terminal.
- *	A master pty's termios should never be set.
+ * Perform updates to the termios values set on this @tty. A master pty's
+ * termios should never be set.
  *
- *	Locking: termios_rwsem
+ * Locking: &tty_struct->termios_rwsem
  */
-
 int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 {
 	struct ktermios old_termios;
@@ -439,18 +432,19 @@ __weak int kernel_termios_to_user_termios(struct termios __user *u,
 #endif /* TCGETS2 */
 
 /**
- *	set_termios		-	set termios values for a tty
- *	@tty: terminal device
- *	@arg: user data
- *	@opt: option information
+ * set_termios - set termios values for a tty
+ * @tty: terminal device
+ * @arg: user data
+ * @opt: option information
  *
- *	Helper function to prepare termios data and run necessary other
- *	functions before using tty_set_termios to do the actual changes.
+ * Helper function to prepare termios data and run necessary other functions
+ * before using tty_set_termios() to do the actual changes.
  *
- *	Locking:
- *		Called functions take ldisc and termios_rwsem locks
+ * Locking: called functions take &tty_struct->ldisc_sem and
+ * &tty_struct->termios_rwsem locks
+ *
+ * Returns: 0 on success, an error otherwise
  */
-
 static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
 {
 	struct ktermios tmp_termios;
@@ -622,16 +616,16 @@ static void set_sgflags(struct ktermios *termios, int flags)
 }
 
 /**
- *	set_sgttyb		-	set legacy terminal values
- *	@tty: tty structure
- *	@sgttyb: pointer to old style terminal structure
+ * set_sgttyb - set legacy terminal values
+ * @tty: tty structure
+ * @sgttyb: pointer to old style terminal structure
  *
- *	Updates a terminal from the legacy BSD style terminal information
- *	structure.
+ * Updates a terminal from the legacy BSD style terminal information structure.
  *
- *	Locking: termios_rwsem
+ * Locking: &tty_struct->termios_rwsem
+ *
+ * Returns: 0 on success, an error otherwise
  */
-
 static int set_sgttyb(struct tty_struct *tty, struct sgttyb __user *sgttyb)
 {
 	int retval;
@@ -733,14 +727,17 @@ static int set_ltchars(struct tty_struct *tty, struct ltchars __user *ltchars)
 #endif
 
 /**
- *	tty_change_softcar	-	carrier change ioctl helper
- *	@tty: tty to update
- *	@enable: enable/disable CLOCAL
+ * tty_change_softcar - carrier change ioctl helper
+ * @tty: tty to update
+ * @enable: enable/disable %CLOCAL
  *
- *	Perform a change to the CLOCAL state and call into the driver
- *	layer to make it visible. All done with the termios rwsem
+ * Perform a change to the %CLOCAL state and call into the driver layer to make
+ * it visible.
+ *
+ * Locking: &tty_struct->termios_rwsem.
+ *
+ * Returns: 0 on success, an error otherwise
  */
-
 static int tty_change_softcar(struct tty_struct *tty, bool enable)
 {
 	int ret = 0;
@@ -760,16 +757,15 @@ static int tty_change_softcar(struct tty_struct *tty, bool enable)
 }
 
 /**
- *	tty_mode_ioctl		-	mode related ioctls
- *	@tty: tty for the ioctl
- *	@cmd: command
- *	@arg: ioctl argument
+ * tty_mode_ioctl - mode related ioctls
+ * @tty: tty for the ioctl
+ * @cmd: command
+ * @arg: ioctl argument
  *
- *	Perform non line discipline specific mode control ioctls. This
- *	is designed to be called by line disciplines to ensure they provide
- *	consistent mode setting.
+ * Perform non-line discipline specific mode control ioctls. This is designed
+ * to be called by line disciplines to ensure they provide consistent mode
+ * setting.
  */
-
 int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 {
 	struct tty_struct *real_tty;
-- 
2.42.0

