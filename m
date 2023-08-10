Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4867577741E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjHJJRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbjHJJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB53A85;
        Thu, 10 Aug 2023 02:15:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47B29654D7;
        Thu, 10 Aug 2023 09:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A1DC433CB;
        Thu, 10 Aug 2023 09:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658958;
        bh=a7DejRUSxlNnBadrd2jMRp2gSoThnGpBetrYCz8Ioq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpZ2Kfve0zX92mhppetzNNBoizINBzH+zztrdvaxejyaf2dfAxH8mDaYBQCg+6jqV
         pMTtzJNwDgqJYMWHnFgRfO07qBABlORM0SuOuz44g33RWjHeCNUyJ36EskeA3Yishj
         VXJqDfqJPN66KYIUoiEuvn6EjjRfZBl35e/qdoJLRZ6B1j05TPMPgRvaI8VYZJDSVf
         kFztk5rhcBql2B7FN2geG8rHs57VxXDr/1q2r9a0rLlSzlVFqr9P2WVfHVDNVgmmov
         5aiGQPZQeb96EpixO6QNB00oHLVvSwozBIwC4/MbWmUD0koqIBQYXZJLXjmtnfScmn
         tq7B9/83p4mOQ==
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
Subject: [PATCH 17/36] tty: use u8 for flags
Date:   Thu, 10 Aug 2023 11:14:51 +0200
Message-ID: <20230810091510.13006-18-jirislaby@kernel.org>
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

This makes all those 'char's an explicit 'u8'. This is part of the
continuing unification of chars and flags to be consistent u8.

This approaches tty_port_default_receive_buf().

Note that we do not change signedness as we compile with
-funsigned-char.

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
 drivers/accessibility/speakup/spk_ttyio.c |  2 +-
 drivers/bluetooth/hci_ldisc.c             |  2 +-
 drivers/input/serio/serport.c             |  2 +-
 drivers/misc/ti-st/st_core.c              |  2 +-
 drivers/net/caif/caif_serial.c            |  2 +-
 drivers/net/can/can327.c                  |  2 +-
 drivers/net/can/slcan/slcan-core.c        |  2 +-
 drivers/net/hamradio/6pack.c              |  2 +-
 drivers/net/hamradio/mkiss.c              |  2 +-
 drivers/net/mctp/mctp-serial.c            |  2 +-
 drivers/net/ppp/ppp_async.c               |  7 +++---
 drivers/net/ppp/ppp_synctty.c             |  6 ++---
 drivers/net/slip/slip.c                   |  4 ++--
 drivers/tty/n_gsm.c                       |  2 +-
 drivers/tty/n_hdlc.c                      |  2 +-
 drivers/tty/n_tty.c                       | 28 +++++++++++------------
 drivers/tty/tty_buffer.c                  |  8 +++----
 drivers/tty/tty_port.c                    |  2 +-
 include/linux/tty_buffer.h                |  4 ++--
 include/linux/tty_flip.h                  | 10 ++++----
 include/linux/tty_ldisc.h                 | 12 +++++-----
 net/nfc/nci/uart.c                        |  2 +-
 sound/soc/codecs/cx20442.c                |  2 +-
 23 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
index dd683a079c08..4c0a6e1f019d 100644
--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -72,7 +72,7 @@ static void spk_ttyio_ldisc_close(struct tty_struct *tty)
 }
 
 static size_t spk_ttyio_receive_buf2(struct tty_struct *tty, const u8 *cp,
-				     const char *fp, size_t count)
+				     const u8 *fp, size_t count)
 {
 	struct spk_ldisc_data *ldisc_data = tty->disc_data;
 	struct spk_synth *synth = ldisc_data->synth;
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 3473c4b8751a..3e11fc06a932 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -599,7 +599,7 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
  * Return Value:    None
  */
 static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
-				 const char *flags, size_t count)
+				 const u8 *flags, size_t count)
 {
 	struct hci_uart *hu = tty->disc_data;
 
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 8bf79d39964d..5ce8d9f10f3e 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -115,7 +115,7 @@ static void serport_ldisc_close(struct tty_struct *tty)
  */
 
 static void serport_ldisc_receive(struct tty_struct *tty, const u8 *cp,
-				  const char *fp, size_t count)
+				  const u8 *fp, size_t count)
 {
 	struct serport *serport = tty->disc_data;
 	unsigned long flags;
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 0ce4e46ff161..4467c5b94ae8 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -792,7 +792,7 @@ static void st_tty_close(struct tty_struct *tty)
 }
 
 static void st_tty_receive(struct tty_struct *tty, const u8 *data,
-			   const char *tty_flags, size_t count)
+			   const u8 *tty_flags, size_t count)
 {
 #ifdef VERBOSE
 	print_hex_dump(KERN_DEBUG, ">in>", DUMP_PREFIX_NONE,
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index feda04dbe837..ed3a589def6b 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -159,7 +159,7 @@ static inline void debugfs_tx(struct ser_device *ser, const u8 *data, int size)
 #endif
 
 static void ldisc_receive(struct tty_struct *tty, const u8 *data,
-			  const char *flags, size_t count)
+			  const u8 *flags, size_t count)
 {
 	struct sk_buff *skb = NULL;
 	struct ser_device *ser;
diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index a054f5fd0d43..24af63961030 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -886,7 +886,7 @@ static bool can327_is_valid_rx_char(u8 c)
  * functions may be called in parallel.
  */
 static void can327_ldisc_rx(struct tty_struct *tty, const u8 *cp,
-			    const char *fp, size_t count)
+			    const u8 *fp, size_t count)
 {
 	struct can327 *elm = tty->disc_data;
 	size_t first_new_char_idx;
diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index fe5671dbeb77..24c6622d36bd 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -775,7 +775,7 @@ static const struct net_device_ops slcan_netdev_ops = {
  * in parallel
  */
 static void slcan_receive_buf(struct tty_struct *tty, const u8 *cp,
-			      const char *fp, size_t count)
+			      const u8 *fp, size_t count)
 {
 	struct slcan *sl = tty->disc_data;
 
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 9a1f2a3f3b4f..6ed38a3cdd73 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -428,7 +428,7 @@ static void sixpack_write_wakeup(struct tty_struct *tty)
  * and sent on to some IP layer for further processing.
  */
 static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
-				const char *fp, size_t count)
+				const u8 *fp, size_t count)
 {
 	struct sixpack *sp;
 	int count1;
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 26dbcf49bfa6..5f38a002bd9e 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -875,7 +875,7 @@ static int mkiss_ioctl(struct tty_struct *tty, unsigned int cmd,
  * and sent on to the AX.25 layer for further processing.
  */
 static void mkiss_receive_buf(struct tty_struct *tty, const u8 *cp,
-			      const char *fp, size_t count)
+			      const u8 *fp, size_t count)
 {
 	struct mkiss *ax = mkiss_get(tty);
 
diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 5f809a18d308..5bf6fdff701c 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -391,7 +391,7 @@ static void mctp_serial_push(struct mctp_serial *dev, unsigned char c)
 }
 
 static void mctp_serial_tty_receive_buf(struct tty_struct *tty, const u8 *c,
-					const char *f, size_t len)
+					const u8 *f, size_t len)
 {
 	struct mctp_serial *dev = tty->disc_data;
 	int i;
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index a661ccdea6ab..cfd5cb609d99 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -98,7 +98,7 @@ static int ppp_async_send(struct ppp_channel *chan, struct sk_buff *skb);
 static int ppp_async_push(struct asyncppp *ap);
 static void ppp_async_flush_output(struct asyncppp *ap);
 static void ppp_async_input(struct asyncppp *ap, const unsigned char *buf,
-			    const char *flags, int count);
+			    const u8 *flags, int count);
 static int ppp_async_ioctl(struct ppp_channel *chan, unsigned int cmd,
 			   unsigned long arg);
 static void ppp_async_process(struct tasklet_struct *t);
@@ -330,7 +330,7 @@ ppp_asynctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 
 /* May sleep, don't call from interrupt level or with interrupts disabled */
 static void
-ppp_asynctty_receive(struct tty_struct *tty, const u8 *buf, const char *cflags,
+ppp_asynctty_receive(struct tty_struct *tty, const u8 *buf, const u8 *cflags,
 		     size_t count)
 {
 	struct asyncppp *ap = ap_get(tty);
@@ -819,8 +819,7 @@ process_input_packet(struct asyncppp *ap)
    other ldisc functions but will not be re-entered */
 
 static void
-ppp_async_input(struct asyncppp *ap, const u8 *buf, const char *flags,
-		int count)
+ppp_async_input(struct asyncppp *ap, const u8 *buf, const u8 *flags, int count)
 {
 	struct sk_buff *skb;
 	int c, i, j, n, s, f;
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 2a5cf6be9591..164c9053f73b 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -93,7 +93,7 @@ static int ppp_sync_ioctl(struct ppp_channel *chan, unsigned int cmd,
 static void ppp_sync_process(struct tasklet_struct *t);
 static int ppp_sync_push(struct syncppp *ap);
 static void ppp_sync_flush_output(struct syncppp *ap);
-static void ppp_sync_input(struct syncppp *ap, const u8 *buf, const char *flags,
+static void ppp_sync_input(struct syncppp *ap, const u8 *buf, const u8 *flags,
 			   int count);
 
 static const struct ppp_channel_ops sync_ops = {
@@ -323,7 +323,7 @@ ppp_synctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 
 /* May sleep, don't call from interrupt level or with interrupts disabled */
 static void
-ppp_sync_receive(struct tty_struct *tty, const u8 *buf, const char *cflags,
+ppp_sync_receive(struct tty_struct *tty, const u8 *buf, const u8 *cflags,
 		 size_t count)
 {
 	struct syncppp *ap = sp_get(tty);
@@ -655,7 +655,7 @@ ppp_sync_flush_output(struct syncppp *ap)
  * frame is considered to be in error and is tossed.
  */
 static void
-ppp_sync_input(struct syncppp *ap, const u8 *buf, const char *flags, int count)
+ppp_sync_input(struct syncppp *ap, const u8 *buf, const u8 *flags, int count)
 {
 	struct sk_buff *skb;
 	unsigned char *p;
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 7bfa90724e7b..e4280e37fec9 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -685,8 +685,8 @@ static void sl_setup(struct net_device *dev)
  * in parallel
  */
 
-static void slip_receive_buf(struct tty_struct *tty, const u8 *cp,
-			     const char *fp, size_t count)
+static void slip_receive_buf(struct tty_struct *tty, const u8 *cp, const u8 *fp,
+			     size_t count)
 {
 	struct slip *sl = tty->disc_data;
 
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 86d89bbbaa16..a3bd1fc52aed 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3490,7 +3490,7 @@ static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 }
 
 static void gsmld_receive_buf(struct tty_struct *tty, const u8 *cp,
-			      const char *fp, size_t count)
+			      const u8 *fp, size_t count)
 {
 	struct gsm_mux *gsm = tty->disc_data;
 	char flags = TTY_NORMAL;
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index c86be060baed..9be0932d07e0 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -370,7 +370,7 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
  * interpreted as one HDLC frame.
  */
 static void n_hdlc_tty_receive(struct tty_struct *tty, const u8 *data,
-			       const char *flags, size_t count)
+			       const u8 *flags, size_t count)
 {
 	register struct n_hdlc *n_hdlc = tty->disc_data;
 	register struct n_hdlc_buf *buf;
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index d770007e5215..1053b2adb04c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1480,7 +1480,7 @@ n_tty_receive_char_lnext(struct tty_struct *tty, unsigned char c, char flag)
 
 /* Caller must ensure count > 0 */
 static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const u8 *cp,
-				      const unsigned char *fp, size_t count)
+				      const u8 *fp, size_t count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	unsigned char flag = TTY_NORMAL;
@@ -1520,11 +1520,11 @@ n_tty_receive_buf_real_raw(const struct tty_struct *tty, const u8 *cp,
 }
 
 static void
-n_tty_receive_buf_raw(struct tty_struct *tty, const u8 *cp,
-		      const char *fp, int count)
+n_tty_receive_buf_raw(struct tty_struct *tty, const u8 *cp, const u8 *fp,
+		      int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	char flag = TTY_NORMAL;
+	u8 flag = TTY_NORMAL;
 
 	while (count--) {
 		if (fp)
@@ -1537,8 +1537,8 @@ n_tty_receive_buf_raw(struct tty_struct *tty, const u8 *cp,
 }
 
 static void
-n_tty_receive_buf_closing(struct tty_struct *tty, const u8 *cp,
-			  const char *fp, int count, bool lookahead_done)
+n_tty_receive_buf_closing(struct tty_struct *tty, const u8 *cp, const u8 *fp,
+			  int count, bool lookahead_done)
 {
 	char flag = TTY_NORMAL;
 
@@ -1551,11 +1551,11 @@ n_tty_receive_buf_closing(struct tty_struct *tty, const u8 *cp,
 }
 
 static void n_tty_receive_buf_standard(struct tty_struct *tty, const u8 *cp,
-				       const char *fp, int count,
+				       const u8 *fp, int count,
 				       bool lookahead_done)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	char flag = TTY_NORMAL;
+	u8 flag = TTY_NORMAL;
 
 	while (count--) {
 		u8 c = *cp++;
@@ -1589,8 +1589,8 @@ static void n_tty_receive_buf_standard(struct tty_struct *tty, const u8 *cp,
 	}
 }
 
-static void __receive_buf(struct tty_struct *tty, const u8 *cp,
-			  const char *fp, int count)
+static void __receive_buf(struct tty_struct *tty, const u8 *cp, const u8 *fp,
+			  int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	bool preops = I_ISTRIP(tty) || (I_IUCLC(tty) && L_IEXTEN(tty));
@@ -1664,8 +1664,8 @@ static void __receive_buf(struct tty_struct *tty, const u8 *cp,
  *	publishes commit_head or canon_head
  */
 static size_t
-n_tty_receive_buf_common(struct tty_struct *tty, const u8 *cp,
-			 const char *fp, int count, int flow)
+n_tty_receive_buf_common(struct tty_struct *tty, const u8 *cp, const u8 *fp,
+			 int count, int flow)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t rcvd = 0;
@@ -1746,13 +1746,13 @@ n_tty_receive_buf_common(struct tty_struct *tty, const u8 *cp,
 }
 
 static void n_tty_receive_buf(struct tty_struct *tty, const u8 *cp,
-			      const char *fp, size_t count)
+			      const u8 *fp, size_t count)
 {
 	n_tty_receive_buf_common(tty, cp, fp, count, 0);
 }
 
 static size_t n_tty_receive_buf2(struct tty_struct *tty, const u8 *cp,
-				 const char *fp, size_t count)
+				 const u8 *fp, size_t count)
 {
 	return n_tty_receive_buf_common(tty, cp, fp, count, 1);
 }
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 9db42e6ed45b..684d099cbe11 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -317,7 +317,7 @@ EXPORT_SYMBOL_GPL(tty_buffer_request_room);
  * Returns: the number added.
  */
 int tty_insert_flip_string_fixed_flag(struct tty_port *port, const u8 *chars,
-		char flag, size_t size)
+				      u8 flag, size_t size)
 {
 	int copied = 0;
 	bool flags = flag != TTY_NORMAL;
@@ -356,7 +356,7 @@ EXPORT_SYMBOL(tty_insert_flip_string_fixed_flag);
  * Returns: the number added.
  */
 int tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
-		const char *flags, size_t size)
+				 const u8 *flags, size_t size)
 {
 	int copied = 0;
 
@@ -390,7 +390,7 @@ EXPORT_SYMBOL(tty_insert_flip_string_flags);
  * Queue a single byte @ch to the tty buffering, with an optional flag. This is
  * the slow path of tty_insert_flip_char().
  */
-int __tty_insert_flip_char(struct tty_port *port, u8 ch, char flag)
+int __tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag)
 {
 	struct tty_buffer *tb;
 	bool flags = flag != TTY_NORMAL;
@@ -449,7 +449,7 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
  *
  * Returns: the number of bytes processed.
  */
-size_t tty_ldisc_receive_buf(struct tty_ldisc *ld, const u8 *p, const char *f,
+size_t tty_ldisc_receive_buf(struct tty_ldisc *ld, const u8 *p, const u8 *f,
 			     size_t count)
 {
 	if (ld->ops->receive_buf2)
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 7fd171b7c844..624d104bd145 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -34,7 +34,7 @@ static size_t tty_port_default_receive_buf(struct tty_port *port, const u8 *p,
 	if (!ld)
 		return 0;
 
-	count = tty_ldisc_receive_buf(ld, p, (char *)f, count);
+	count = tty_ldisc_receive_buf(ld, p, f, count);
 
 	tty_ldisc_deref(ld);
 
diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index 6f2966b15093..b11cc8c749d2 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -27,9 +27,9 @@ static inline u8 *char_buf_ptr(struct tty_buffer *b, int ofs)
 	return ((u8 *)b->data) + ofs;
 }
 
-static inline char *flag_buf_ptr(struct tty_buffer *b, int ofs)
+static inline u8 *flag_buf_ptr(struct tty_buffer *b, int ofs)
 {
-	return (char *)char_buf_ptr(b, ofs) + b->size;
+	return char_buf_ptr(b, ofs) + b->size;
 }
 
 struct tty_bufhead {
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index a0fcffeaaa25..d33aed2172c7 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -11,14 +11,14 @@ int tty_buffer_set_limit(struct tty_port *port, int limit);
 unsigned int tty_buffer_space_avail(struct tty_port *port);
 int tty_buffer_request_room(struct tty_port *port, size_t size);
 int tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
-				 const char *flags, size_t size);
+				 const u8 *flags, size_t size);
 int tty_insert_flip_string_fixed_flag(struct tty_port *port, const u8 *chars,
-				      char flag, size_t size);
+				      u8 flag, size_t size);
 int tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size);
 void tty_flip_buffer_push(struct tty_port *port);
-int __tty_insert_flip_char(struct tty_port *port, u8 ch, char flag);
+int __tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag);
 
-static inline int tty_insert_flip_char(struct tty_port *port, u8 ch, char flag)
+static inline int tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag)
 {
 	struct tty_buffer *tb = port->buf.tail;
 	int change;
@@ -39,7 +39,7 @@ static inline int tty_insert_flip_string(struct tty_port *port,
 	return tty_insert_flip_string_fixed_flag(port, chars, TTY_NORMAL, size);
 }
 
-size_t tty_ldisc_receive_buf(struct tty_ldisc *ld, const u8 *p, const char *f,
+size_t tty_ldisc_receive_buf(struct tty_ldisc *ld, const u8 *p, const u8 *f,
 			     size_t count);
 
 void tty_buffer_lock_exclusive(struct tty_port *port);
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 5551c4400e59..a661d7df5497 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -162,7 +162,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	Optional. Can sleep.
  *
  * @receive_buf: [DRV] ``void ()(struct tty_struct *tty, const u8 *cp,
- *		       const char *fp, size_t count)``
+ *		       const u8 *fp, size_t count)``
  *
  *	This function is called by the low-level tty driver to send characters
  *	received by the hardware to the line discpline for processing. @cp is
@@ -192,7 +192,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	Optional.
  *
  * @receive_buf2: [DRV] ``ssize_t ()(struct tty_struct *tty, const u8 *cp,
- *			const char *fp, size_t count)``
+ *			const u8 *fp, size_t count)``
  *
  *	This function is called by the low-level tty driver to send characters
  *	received by the hardware to the line discpline for processing. @cp is a
@@ -205,7 +205,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	Optional.
  *
  * @lookahead_buf: [DRV] ``void ()(struct tty_struct *tty, const u8 *cp,
- *			 const char *fp, size_t count)``
+ *			 const u8 *fp, size_t count)``
  *
  *	This function is called by the low-level tty driver for characters
  *	not eaten by ->receive_buf() or ->receive_buf2(). It is useful for
@@ -256,13 +256,13 @@ struct tty_ldisc_ops {
 	 * The following routines are called from below.
 	 */
 	void	(*receive_buf)(struct tty_struct *tty, const u8 *cp,
-			       const char *fp, size_t count);
+			       const u8 *fp, size_t count);
 	void	(*write_wakeup)(struct tty_struct *tty);
 	void	(*dcd_change)(struct tty_struct *tty, bool active);
 	size_t	(*receive_buf2)(struct tty_struct *tty, const u8 *cp,
-				const char *fp, size_t count);
+				const u8 *fp, size_t count);
 	void	(*lookahead_buf)(struct tty_struct *tty, const u8 *cp,
-				 const unsigned char *fp, size_t count);
+				 const u8 *fp, size_t count);
 
 	struct  module *owner;
 };
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index c957ca6d2f87..93775c540287 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -296,7 +296,7 @@ static int nci_uart_default_recv_buf(struct nci_uart *nu, const u8 *data,
  * Return Value:    None
  */
 static void nci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
-				 const char *flags, size_t count)
+				 const u8 *flags, size_t count)
 {
 	struct nci_uart *nu = tty->disc_data;
 
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 6d4938e3cbad..9d54141a0cd1 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -258,7 +258,7 @@ static void v253_hangup(struct tty_struct *tty)
 }
 
 /* Line discipline .receive_buf() */
-static void v253_receive(struct tty_struct *tty, const u8 *cp, const char *fp,
+static void v253_receive(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 			 size_t count)
 {
 	struct snd_soc_component *component = tty->disc_data;
-- 
2.41.0

