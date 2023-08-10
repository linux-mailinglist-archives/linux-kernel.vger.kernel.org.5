Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA277741A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjHJJQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjHJJPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A7030DB;
        Thu, 10 Aug 2023 02:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51E5B654D8;
        Thu, 10 Aug 2023 09:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096AAC433C8;
        Thu, 10 Aug 2023 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658946;
        bh=fSUmlnJQsTpiIP5crYAypE9I7qk6gNFKotKWVO++3y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCyakgbFtRQKyRhFYlzeTOJpgKx9p6T4tCLVwLN+GYxT9xVt06wzwcRVLumWZL8Eh
         8DQUWrq0lBpU6EdslFvk8eKBM4RVoW1l+LVjM6yh/zB2VGrdoiA/qJeO4ToN1l7o8J
         RJT9BQKbslxFx5dAJAsVGFpati15dXn5Jabn9X8AFSDZdZTwxRrR1/xpofFte+FDwg
         qJtoqDR0MigUUa6pW32vW2PhGRVSEBYNdGG4Gg1ppReGl+Uu4ua4UiDaA4I9rPgENn
         Y4ZfaYO4qiRXnEk+Kn+uyfNNmsgqperUtbwmO4SgDXKG7VX58dyc0YNO+YtTQLPKxk
         YwUzEs/eRVGgA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 15/36] tty: make tty_ldisc_ops::*buf*() hooks operate on size_t
Date:   Thu, 10 Aug 2023 11:14:49 +0200
Message-ID: <20230810091510.13006-16-jirislaby@kernel.org>
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

Count passed to tty_ldisc_ops::receive_buf*(), ::lookahead_buf(), and
returned from ::receive_buf2() is expected to be size_t. So set it to
size_t to unify with the rest of the code.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: William Hubbs <w.d.hubbs@gmail.com>
Cc: Chris Brannon <chris@the-brannons.com>
Cc: Kirk Reiser <kirk@reisers.ca>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Max Staudt <max@enpas.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
---
 drivers/accessibility/speakup/spk_ttyio.c |  6 +++---
 drivers/bluetooth/hci_ldisc.c             |  2 +-
 drivers/input/serio/serport.c             |  3 ++-
 drivers/misc/ti-st/st_core.c              |  2 +-
 drivers/net/caif/caif_serial.c            |  2 +-
 drivers/net/can/can327.c                  |  4 ++--
 drivers/net/can/slcan/slcan-core.c        |  2 +-
 drivers/net/hamradio/6pack.c              |  2 +-
 drivers/net/hamradio/mkiss.c              |  2 +-
 drivers/net/mctp/mctp-serial.c            |  2 +-
 drivers/net/ppp/ppp_async.c               |  2 +-
 drivers/net/ppp/ppp_synctty.c             |  2 +-
 drivers/net/slip/slip.c                   |  2 +-
 drivers/tty/n_gsm.c                       |  2 +-
 drivers/tty/n_hdlc.c                      |  4 ++--
 drivers/tty/n_tty.c                       | 14 ++++++++------
 include/linux/tty_ldisc.h                 | 16 ++++++++--------
 net/nfc/nci/uart.c                        |  2 +-
 sound/soc/codecs/cx20442.c                |  2 +-
 19 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
index 5d4bafe118ec..736f622068ce 100644
--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -71,9 +71,9 @@ static void spk_ttyio_ldisc_close(struct tty_struct *tty)
 	kfree(tty->disc_data);
 }
 
-static int spk_ttyio_receive_buf2(struct tty_struct *tty,
-				  const unsigned char *cp,
-				  const char *fp, int count)
+static size_t spk_ttyio_receive_buf2(struct tty_struct *tty,
+				     const unsigned char *cp, const char *fp,
+				     size_t count)
 {
 	struct spk_ldisc_data *ldisc_data = tty->disc_data;
 	struct spk_synth *synth = ldisc_data->synth;
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 759472686831..3473c4b8751a 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -599,7 +599,7 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
  * Return Value:    None
  */
 static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
-				 const char *flags, int count)
+				 const char *flags, size_t count)
 {
 	struct hci_uart *hu = tty->disc_data;
 
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index a5d8953f5904..7fc6155131f8 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -115,7 +115,8 @@ static void serport_ldisc_close(struct tty_struct *tty)
  */
 
 static void serport_ldisc_receive(struct tty_struct *tty,
-		const unsigned char *cp, const char *fp, int count)
+				  const unsigned char *cp, const char *fp,
+				  size_t count)
 {
 	struct serport *serport = tty->disc_data;
 	unsigned long flags;
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 3b2145722bd7..c89024ab3d77 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -792,7 +792,7 @@ static void st_tty_close(struct tty_struct *tty)
 }
 
 static void st_tty_receive(struct tty_struct *tty, const unsigned char *data,
-			   const char *tty_flags, int count)
+			   const char *tty_flags, size_t count)
 {
 #ifdef VERBOSE
 	print_hex_dump(KERN_DEBUG, ">in>", DUMP_PREFIX_NONE,
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index 688075859ae4..feda04dbe837 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -159,7 +159,7 @@ static inline void debugfs_tx(struct ser_device *ser, const u8 *data, int size)
 #endif
 
 static void ldisc_receive(struct tty_struct *tty, const u8 *data,
-			const char *flags, int count)
+			  const char *flags, size_t count)
 {
 	struct sk_buff *skb = NULL;
 	struct ser_device *ser;
diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 4533dc00f215..4bf970df7e84 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -886,7 +886,7 @@ static bool can327_is_valid_rx_char(u8 c)
  * functions may be called in parallel.
  */
 static void can327_ldisc_rx(struct tty_struct *tty, const unsigned char *cp,
-			    const char *fp, int count)
+			    const char *fp, size_t count)
 {
 	struct can327 *elm = tty->disc_data;
 	size_t first_new_char_idx;
@@ -904,7 +904,7 @@ static void can327_ldisc_rx(struct tty_struct *tty, const unsigned char *cp,
 	while (count--) {
 		if (elm->rxfill >= CAN327_SIZE_RXBUF) {
 			netdev_err(elm->dev,
-				   "Receive buffer overflowed. Bad chip or wiring? count = %i",
+				   "Receive buffer overflowed. Bad chip or wiring? count = %zu",
 				   count);
 			goto uart_failure;
 		}
diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 371af9d17b14..63371563d8e2 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -776,7 +776,7 @@ static const struct net_device_ops slcan_netdev_ops = {
  */
 static void slcan_receive_buf(struct tty_struct *tty,
 			      const unsigned char *cp, const char *fp,
-			      int count)
+			      size_t count)
 {
 	struct slcan *sl = tty->disc_data;
 
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 9fb567524220..2089efb0d360 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -428,7 +428,7 @@ static void sixpack_write_wakeup(struct tty_struct *tty)
  * and sent on to some IP layer for further processing.
  */
 static void sixpack_receive_buf(struct tty_struct *tty,
-	const unsigned char *cp, const char *fp, int count)
+	const unsigned char *cp, const char *fp, size_t count)
 {
 	struct sixpack *sp;
 	int count1;
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index c251e04ae047..1efab6037c7e 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -875,7 +875,7 @@ static int mkiss_ioctl(struct tty_struct *tty, unsigned int cmd,
  * and sent on to the AX.25 layer for further processing.
  */
 static void mkiss_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-	const char *fp, int count)
+			      const char *fp, size_t count)
 {
 	struct mkiss *ax = mkiss_get(tty);
 
diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 9f9eaf896047..6761f4ff2e7c 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -392,7 +392,7 @@ static void mctp_serial_push(struct mctp_serial *dev, unsigned char c)
 
 static void mctp_serial_tty_receive_buf(struct tty_struct *tty,
 					const unsigned char *c,
-					const char *f, int len)
+					const char *f, size_t len)
 {
 	struct mctp_serial *dev = tty->disc_data;
 	int i;
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index f420bddb6a8c..79b8fca47edb 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -331,7 +331,7 @@ ppp_asynctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 /* May sleep, don't call from interrupt level or with interrupts disabled */
 static void
 ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
-		  const char *cflags, int count)
+		     const char *cflags, size_t count)
 {
 	struct asyncppp *ap = ap_get(tty);
 	unsigned long flags;
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 86dacef84c6c..767aca32b315 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -324,7 +324,7 @@ ppp_synctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 /* May sleep, don't call from interrupt level or with interrupts disabled */
 static void
 ppp_sync_receive(struct tty_struct *tty, const unsigned char *buf,
-		  const char *cflags, int count)
+		 const char *cflags, size_t count)
 {
 	struct syncppp *ap = sp_get(tty);
 	unsigned long flags;
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 6865d32270e5..39450bf748a5 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -686,7 +686,7 @@ static void sl_setup(struct net_device *dev)
  */
 
 static void slip_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-		const char *fp, int count)
+			     const char *fp, size_t count)
 {
 	struct slip *sl = tty->disc_data;
 
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c7a787f10a9c..2f85877b8ba1 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3490,7 +3490,7 @@ static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 }
 
 static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			      const char *fp, int count)
+			      const char *fp, size_t count)
 {
 	struct gsm_mux *gsm = tty->disc_data;
 	char flags = TTY_NORMAL;
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 46b09bfb6f3a..ce3c779f5c03 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -370,12 +370,12 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
  * interpreted as one HDLC frame.
  */
 static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
-			       const char *flags, int count)
+			       const char *flags, size_t count)
 {
 	register struct n_hdlc *n_hdlc = tty->disc_data;
 	register struct n_hdlc_buf *buf;
 
-	pr_debug("%s() called count=%d\n", __func__, count);
+	pr_debug("%s() called count=%zu\n", __func__, count);
 
 	if (count > maxframe) {
 		pr_debug("rx count>maxframesize, data discarded\n");
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0043cc84b91a..ee9b20dcbce6 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1480,7 +1480,7 @@ n_tty_receive_char_lnext(struct tty_struct *tty, unsigned char c, char flag)
 
 /* Caller must ensure count > 0 */
 static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const unsigned char *cp,
-				      const unsigned char *fp, unsigned int count)
+				      const unsigned char *fp, size_t count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	unsigned char flag = TTY_NORMAL;
@@ -1662,12 +1662,13 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
  *	claims non-exclusive %termios_rwsem
  *	publishes commit_head or canon_head
  */
-static int
+static size_t
 n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 			 const char *fp, int count, int flow)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int room, n, rcvd = 0, overflow;
+	size_t rcvd = 0;
+	int room, n, overflow;
 
 	down_read(&tty->termios_rwsem);
 
@@ -1744,13 +1745,14 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 }
 
 static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			      const char *fp, int count)
+			      const char *fp, size_t count)
 {
 	n_tty_receive_buf_common(tty, cp, fp, count, 0);
 }
 
-static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
-			      const char *fp, int count)
+static size_t n_tty_receive_buf2(struct tty_struct *tty,
+				 const unsigned char *cp, const char *fp,
+				 size_t count)
 {
 	return n_tty_receive_buf_common(tty, cp, fp, count, 1);
 }
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 62e089434995..f88529e6a783 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -162,7 +162,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	Optional. Can sleep.
  *
  * @receive_buf: [DRV] ``void ()(struct tty_struct *tty,
- *		       const unsigned char *cp, const char *fp, int count)``
+ *		       const unsigned char *cp, const char *fp, size_t count)``
  *
  *	This function is called by the low-level tty driver to send characters
  *	received by the hardware to the line discpline for processing. @cp is
@@ -191,8 +191,8 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *
  *	Optional.
  *
- * @receive_buf2: [DRV] ``int ()(struct tty_struct *tty,
- *			const unsigned char *cp, const char *fp, int count)``
+ * @receive_buf2: [DRV] ``ssize_t ()(struct tty_struct *tty,
+ *			const unsigned char *cp, const char *fp, size_t count)``
  *
  *	This function is called by the low-level tty driver to send characters
  *	received by the hardware to the line discpline for processing. @cp is a
@@ -205,7 +205,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	Optional.
  *
  * @lookahead_buf: [DRV] ``void ()(struct tty_struct *tty,
- *			const unsigned char *cp, const char *fp, int count)``
+ *			const unsigned char *cp, const char *fp, size_t count)``
  *
  *	This function is called by the low-level tty driver for characters
  *	not eaten by ->receive_buf() or ->receive_buf2(). It is useful for
@@ -256,13 +256,13 @@ struct tty_ldisc_ops {
 	 * The following routines are called from below.
 	 */
 	void	(*receive_buf)(struct tty_struct *tty, const unsigned char *cp,
-			       const char *fp, int count);
+			       const char *fp, size_t count);
 	void	(*write_wakeup)(struct tty_struct *tty);
 	void	(*dcd_change)(struct tty_struct *tty, bool active);
-	int	(*receive_buf2)(struct tty_struct *tty, const unsigned char *cp,
-				const char *fp, int count);
+	size_t	(*receive_buf2)(struct tty_struct *tty, const unsigned char *cp,
+				const char *fp, size_t count);
 	void	(*lookahead_buf)(struct tty_struct *tty, const unsigned char *cp,
-				 const unsigned char *fp, unsigned int count);
+				 const unsigned char *fp, size_t count);
 
 	struct  module *owner;
 };
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index c8249d95306d..c957ca6d2f87 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -296,7 +296,7 @@ static int nci_uart_default_recv_buf(struct nci_uart *nu, const u8 *data,
  * Return Value:    None
  */
 static void nci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
-				 const char *flags, int count)
+				 const char *flags, size_t count)
 {
 	struct nci_uart *nu = tty->disc_data;
 
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 43c0cac0ec9e..42cc863cbd53 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -259,7 +259,7 @@ static void v253_hangup(struct tty_struct *tty)
 
 /* Line discipline .receive_buf() */
 static void v253_receive(struct tty_struct *tty, const unsigned char *cp,
-		const char *fp, int count)
+			 const char *fp, size_t count)
 {
 	struct snd_soc_component *component = tty->disc_data;
 	struct cx20442_priv *cx20442;
-- 
2.41.0

