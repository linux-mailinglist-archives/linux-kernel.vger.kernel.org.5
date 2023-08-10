Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DF7777588
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjHJKM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjHJJP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3942708;
        Thu, 10 Aug 2023 02:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24BA0654DA;
        Thu, 10 Aug 2023 09:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34216C433CC;
        Thu, 10 Aug 2023 09:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658952;
        bh=y3qgT3kvuw3uk7irqLKuOjjktV0zJheH9xsbWdRcR7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DauGo5jSqHP8IoE2XRXYTh3+4b5dj7PnzeZ+Afh2903QymJFezoTKsJC2lDh6/fl7
         bf5Sh7EtAxGZURvVqpBnQijeyBq3XEeBUZa6XdVQRjTiS7cBs+e0Zvn+2UQC+/jxMd
         ozv/SNulUmExprpTW/k665H1CmBnEtKg7gFvxmSlSMLkGwLJIT9+LaJWDXcc/QmPTa
         uyVCi4DO7sRkwJ/XgGYEpYsjAwX3yuXjNVtBXQlgt/0xHk7DU8wJsJDslQ2BkJJfcY
         TYOTG25Tg2DkajtIqJGafyPcN3s42Rt0TYb19QYgBGfPKqbI7pkK4o9MEA9D9j47qZ
         nDKER39Zg+/DQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: [PATCH 16/36] tty: use u8 for chars
Date:   Thu, 10 Aug 2023 11:14:50 +0200
Message-ID: <20230810091510.13006-17-jirislaby@kernel.org>
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

This makes all those 'unsigned char's an explicit 'u8'. This is part of
the continuing unification of chars and flags to be consistent u8.

This approaches tty_port_default_receive_buf(). Flags to be next.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: William Hubbs <w.d.hubbs@gmail.com>
Cc: Chris Brannon <chris@the-brannons.com>
Cc: Kirk Reiser <kirk@reisers.ca>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Max Staudt <max@enpas.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 drivers/accessibility/speakup/spk_ttyio.c |  5 ++--
 drivers/input/serio/serport.c             |  5 ++--
 drivers/misc/ti-st/st_core.c              |  2 +-
 drivers/net/can/can327.c                  |  2 +-
 drivers/net/can/slcan/slcan-core.c        |  5 ++--
 drivers/net/hamradio/6pack.c              |  4 ++--
 drivers/net/hamradio/mkiss.c              |  2 +-
 drivers/net/mctp/mctp-serial.c            |  3 +--
 drivers/net/ppp/ppp_async.c               |  8 +++----
 drivers/net/ppp/ppp_synctty.c             | 11 ++++-----
 drivers/net/slip/slip.c                   |  2 +-
 drivers/tty/n_gsm.c                       |  2 +-
 drivers/tty/n_hdlc.c                      |  2 +-
 drivers/tty/n_tty.c                       | 28 +++++++++++------------
 drivers/tty/tty.h                         |  2 +-
 drivers/tty/tty_buffer.c                  | 21 ++++++++---------
 include/linux/tty_buffer.h                |  4 ++--
 include/linux/tty_flip.h                  | 22 ++++++++----------
 include/linux/tty_ldisc.h                 | 18 +++++++--------
 sound/soc/codecs/cx20442.c                |  4 ++--
 sound/soc/ti/ams-delta.c                  |  2 +-
 21 files changed, 73 insertions(+), 81 deletions(-)

diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
index 736f622068ce..dd683a079c08 100644
--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -71,9 +71,8 @@ static void spk_ttyio_ldisc_close(struct tty_struct *tty)
 	kfree(tty->disc_data);
 }
 
-static size_t spk_ttyio_receive_buf2(struct tty_struct *tty,
-				     const unsigned char *cp, const char *fp,
-				     size_t count)
+static size_t spk_ttyio_receive_buf2(struct tty_struct *tty, const u8 *cp,
+				     const char *fp, size_t count)
 {
 	struct spk_ldisc_data *ldisc_data = tty->disc_data;
 	struct spk_synth *synth = ldisc_data->synth;
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 7fc6155131f8..8bf79d39964d 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -114,9 +114,8 @@ static void serport_ldisc_close(struct tty_struct *tty)
  * 'interrupt' routine.
  */
 
-static void serport_ldisc_receive(struct tty_struct *tty,
-				  const unsigned char *cp, const char *fp,
-				  size_t count)
+static void serport_ldisc_receive(struct tty_struct *tty, const u8 *cp,
+				  const char *fp, size_t count)
 {
 	struct serport *serport = tty->disc_data;
 	unsigned long flags;
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index c89024ab3d77..0ce4e46ff161 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -791,7 +791,7 @@ static void st_tty_close(struct tty_struct *tty)
 	pr_debug("%s: done ", __func__);
 }
 
-static void st_tty_receive(struct tty_struct *tty, const unsigned char *data,
+static void st_tty_receive(struct tty_struct *tty, const u8 *data,
 			   const char *tty_flags, size_t count)
 {
 #ifdef VERBOSE
diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 4bf970df7e84..a054f5fd0d43 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -885,7 +885,7 @@ static bool can327_is_valid_rx_char(u8 c)
  * This will not be re-entered while running, but other ldisc
  * functions may be called in parallel.
  */
-static void can327_ldisc_rx(struct tty_struct *tty, const unsigned char *cp,
+static void can327_ldisc_rx(struct tty_struct *tty, const u8 *cp,
 			    const char *fp, size_t count)
 {
 	struct can327 *elm = tty->disc_data;
diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 63371563d8e2..fe5671dbeb77 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -774,9 +774,8 @@ static const struct net_device_ops slcan_netdev_ops = {
  * be re-entered while running but other ldisc functions may be called
  * in parallel
  */
-static void slcan_receive_buf(struct tty_struct *tty,
-			      const unsigned char *cp, const char *fp,
-			      size_t count)
+static void slcan_receive_buf(struct tty_struct *tty, const u8 *cp,
+			      const char *fp, size_t count)
 {
 	struct slcan *sl = tty->disc_data;
 
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 2089efb0d360..9a1f2a3f3b4f 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -427,8 +427,8 @@ static void sixpack_write_wakeup(struct tty_struct *tty)
  * a block of 6pack data has been received, which can now be decapsulated
  * and sent on to some IP layer for further processing.
  */
-static void sixpack_receive_buf(struct tty_struct *tty,
-	const unsigned char *cp, const char *fp, size_t count)
+static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
+				const char *fp, size_t count)
 {
 	struct sixpack *sp;
 	int count1;
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 1efab6037c7e..26dbcf49bfa6 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -874,7 +874,7 @@ static int mkiss_ioctl(struct tty_struct *tty, unsigned int cmd,
  * a block of data has been received, which can now be decapsulated
  * and sent on to the AX.25 layer for further processing.
  */
-static void mkiss_receive_buf(struct tty_struct *tty, const unsigned char *cp,
+static void mkiss_receive_buf(struct tty_struct *tty, const u8 *cp,
 			      const char *fp, size_t count)
 {
 	struct mkiss *ax = mkiss_get(tty);
diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 6761f4ff2e7c..5f809a18d308 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -390,8 +390,7 @@ static void mctp_serial_push(struct mctp_serial *dev, unsigned char c)
 	}
 }
 
-static void mctp_serial_tty_receive_buf(struct tty_struct *tty,
-					const unsigned char *c,
+static void mctp_serial_tty_receive_buf(struct tty_struct *tty, const u8 *c,
 					const char *f, size_t len)
 {
 	struct mctp_serial *dev = tty->disc_data;
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 79b8fca47edb..a661ccdea6ab 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -330,8 +330,8 @@ ppp_asynctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 
 /* May sleep, don't call from interrupt level or with interrupts disabled */
 static void
-ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
-		     const char *cflags, size_t count)
+ppp_asynctty_receive(struct tty_struct *tty, const u8 *buf, const char *cflags,
+		     size_t count)
 {
 	struct asyncppp *ap = ap_get(tty);
 	unsigned long flags;
@@ -819,8 +819,8 @@ process_input_packet(struct asyncppp *ap)
    other ldisc functions but will not be re-entered */
 
 static void
-ppp_async_input(struct asyncppp *ap, const unsigned char *buf,
-		const char *flags, int count)
+ppp_async_input(struct asyncppp *ap, const u8 *buf, const char *flags,
+		int count)
 {
 	struct sk_buff *skb;
 	int c, i, j, n, s, f;
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 767aca32b315..2a5cf6be9591 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -93,8 +93,8 @@ static int ppp_sync_ioctl(struct ppp_channel *chan, unsigned int cmd,
 static void ppp_sync_process(struct tasklet_struct *t);
 static int ppp_sync_push(struct syncppp *ap);
 static void ppp_sync_flush_output(struct syncppp *ap);
-static void ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
-			   const char *flags, int count);
+static void ppp_sync_input(struct syncppp *ap, const u8 *buf, const char *flags,
+			   int count);
 
 static const struct ppp_channel_ops sync_ops = {
 	.start_xmit = ppp_sync_send,
@@ -323,8 +323,8 @@ ppp_synctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 
 /* May sleep, don't call from interrupt level or with interrupts disabled */
 static void
-ppp_sync_receive(struct tty_struct *tty, const unsigned char *buf,
-		 const char *cflags, size_t count)
+ppp_sync_receive(struct tty_struct *tty, const u8 *buf, const char *cflags,
+		 size_t count)
 {
 	struct syncppp *ap = sp_get(tty);
 	unsigned long flags;
@@ -655,8 +655,7 @@ ppp_sync_flush_output(struct syncppp *ap)
  * frame is considered to be in error and is tossed.
  */
 static void
-ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
-		const char *flags, int count)
+ppp_sync_input(struct syncppp *ap, const u8 *buf, const char *flags, int count)
 {
 	struct sk_buff *skb;
 	unsigned char *p;
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 39450bf748a5..7bfa90724e7b 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -685,7 +685,7 @@ static void sl_setup(struct net_device *dev)
  * in parallel
  */
 
-static void slip_receive_buf(struct tty_struct *tty, const unsigned char *cp,
+static void slip_receive_buf(struct tty_struct *tty, const u8 *cp,
 			     const char *fp, size_t count)
 {
 	struct slip *sl = tty->disc_data;
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 2f85877b8ba1..86d89bbbaa16 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3489,7 +3489,7 @@ static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 	gsm->tty = NULL;
 }
 
-static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
+static void gsmld_receive_buf(struct tty_struct *tty, const u8 *cp,
 			      const char *fp, size_t count)
 {
 	struct gsm_mux *gsm = tty->disc_data;
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index ce3c779f5c03..c86be060baed 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -369,7 +369,7 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
  * Called by tty low level driver when receive data is available. Data is
  * interpreted as one HDLC frame.
  */
-static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
+static void n_hdlc_tty_receive(struct tty_struct *tty, const u8 *data,
 			       const char *flags, size_t count)
 {
 	register struct n_hdlc *n_hdlc = tty->disc_data;
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index ee9b20dcbce6..d770007e5215 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1479,7 +1479,7 @@ n_tty_receive_char_lnext(struct tty_struct *tty, unsigned char c, char flag)
 }
 
 /* Caller must ensure count > 0 */
-static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const unsigned char *cp,
+static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const u8 *cp,
 				      const unsigned char *fp, size_t count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1500,8 +1500,8 @@ static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const unsigned cha
 }
 
 static void
-n_tty_receive_buf_real_raw(const struct tty_struct *tty,
-			   const unsigned char *cp, int count)
+n_tty_receive_buf_real_raw(const struct tty_struct *tty, const u8 *cp,
+			   int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t n, head;
@@ -1520,7 +1520,7 @@ n_tty_receive_buf_real_raw(const struct tty_struct *tty,
 }
 
 static void
-n_tty_receive_buf_raw(struct tty_struct *tty, const unsigned char *cp,
+n_tty_receive_buf_raw(struct tty_struct *tty, const u8 *cp,
 		      const char *fp, int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1537,7 +1537,7 @@ n_tty_receive_buf_raw(struct tty_struct *tty, const unsigned char *cp,
 }
 
 static void
-n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
+n_tty_receive_buf_closing(struct tty_struct *tty, const u8 *cp,
 			  const char *fp, int count, bool lookahead_done)
 {
 	char flag = TTY_NORMAL;
@@ -1550,14 +1550,15 @@ n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
 	}
 }
 
-static void n_tty_receive_buf_standard(struct tty_struct *tty,
-		const unsigned char *cp, const char *fp, int count, bool lookahead_done)
+static void n_tty_receive_buf_standard(struct tty_struct *tty, const u8 *cp,
+				       const char *fp, int count,
+				       bool lookahead_done)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	char flag = TTY_NORMAL;
 
 	while (count--) {
-		unsigned char c = *cp++;
+		u8 c = *cp++;
 
 		if (fp)
 			flag = *fp++;
@@ -1588,7 +1589,7 @@ static void n_tty_receive_buf_standard(struct tty_struct *tty,
 	}
 }
 
-static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
+static void __receive_buf(struct tty_struct *tty, const u8 *cp,
 			  const char *fp, int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1663,7 +1664,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
  *	publishes commit_head or canon_head
  */
 static size_t
-n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
+n_tty_receive_buf_common(struct tty_struct *tty, const u8 *cp,
 			 const char *fp, int count, int flow)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1744,15 +1745,14 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 	return rcvd;
 }
 
-static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
+static void n_tty_receive_buf(struct tty_struct *tty, const u8 *cp,
 			      const char *fp, size_t count)
 {
 	n_tty_receive_buf_common(tty, cp, fp, count, 0);
 }
 
-static size_t n_tty_receive_buf2(struct tty_struct *tty,
-				 const unsigned char *cp, const char *fp,
-				 size_t count)
+static size_t n_tty_receive_buf2(struct tty_struct *tty, const u8 *cp,
+				 const char *fp, size_t count)
 {
 	return n_tty_receive_buf_common(tty, cp, fp, count, 1);
 }
diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index 2751ac3946e7..e31cd9f281de 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -115,6 +115,6 @@ static inline void tty_audit_tiocsti(const struct tty_struct *tty, char ch)
 ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
 
 int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
-		const unsigned char *chars, size_t cnt);
+					   const u8 *chars, size_t cnt);
 
 #endif
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 56f5732ce47f..9db42e6ed45b 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -316,8 +316,8 @@ EXPORT_SYMBOL_GPL(tty_buffer_request_room);
  *
  * Returns: the number added.
  */
-int tty_insert_flip_string_fixed_flag(struct tty_port *port,
-		const unsigned char *chars, char flag, size_t size)
+int tty_insert_flip_string_fixed_flag(struct tty_port *port, const u8 *chars,
+		char flag, size_t size)
 {
 	int copied = 0;
 	bool flags = flag != TTY_NORMAL;
@@ -355,8 +355,8 @@ EXPORT_SYMBOL(tty_insert_flip_string_fixed_flag);
  *
  * Returns: the number added.
  */
-int tty_insert_flip_string_flags(struct tty_port *port,
-		const unsigned char *chars, const char *flags, size_t size)
+int tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
+		const char *flags, size_t size)
 {
 	int copied = 0;
 
@@ -390,7 +390,7 @@ EXPORT_SYMBOL(tty_insert_flip_string_flags);
  * Queue a single byte @ch to the tty buffering, with an optional flag. This is
  * the slow path of tty_insert_flip_char().
  */
-int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag)
+int __tty_insert_flip_char(struct tty_port *port, u8 ch, char flag)
 {
 	struct tty_buffer *tb;
 	bool flags = flag != TTY_NORMAL;
@@ -421,8 +421,7 @@ EXPORT_SYMBOL(__tty_insert_flip_char);
  * Returns: the length available and buffer pointer (@chars) to the space which
  * is now allocated and accounted for as ready for normal characters.
  */
-int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
-		size_t size)
+int tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size)
 {
 	int space = __tty_buffer_request_room(port, size, false);
 
@@ -450,8 +449,8 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
  *
  * Returns: the number of bytes processed.
  */
-size_t tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
-			     const char *f, size_t count)
+size_t tty_ldisc_receive_buf(struct tty_ldisc *ld, const u8 *p, const char *f,
+			     size_t count)
 {
 	if (ld->ops->receive_buf2)
 		count = ld->ops->receive_buf2(ld->tty, p, f, count);
@@ -489,7 +488,7 @@ static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
 		}
 
 		if (port->client_ops->lookahead_buf) {
-			unsigned char *p, *f = NULL;
+			u8 *p, *f = NULL;
 
 			p = char_buf_ptr(head, head->lookahead);
 			if (head->flags)
@@ -620,7 +619,7 @@ EXPORT_SYMBOL(tty_flip_buffer_push);
  * Returns: the number added.
  */
 int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
-		const unsigned char *chars, size_t size)
+					   const u8 *chars, size_t size)
 {
 	struct tty_bufhead *buf = &port->buf;
 	unsigned long flags;
diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index 6ceb2789e6c8..6f2966b15093 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -22,9 +22,9 @@ struct tty_buffer {
 	unsigned long data[];
 };
 
-static inline unsigned char *char_buf_ptr(struct tty_buffer *b, int ofs)
+static inline u8 *char_buf_ptr(struct tty_buffer *b, int ofs)
 {
-	return ((unsigned char *)b->data) + ofs;
+	return ((u8 *)b->data) + ofs;
 }
 
 static inline char *flag_buf_ptr(struct tty_buffer *b, int ofs)
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 09c4dbcd0025..a0fcffeaaa25 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -10,17 +10,15 @@ struct tty_ldisc;
 int tty_buffer_set_limit(struct tty_port *port, int limit);
 unsigned int tty_buffer_space_avail(struct tty_port *port);
 int tty_buffer_request_room(struct tty_port *port, size_t size);
-int tty_insert_flip_string_flags(struct tty_port *port,
-		const unsigned char *chars, const char *flags, size_t size);
-int tty_insert_flip_string_fixed_flag(struct tty_port *port,
-		const unsigned char *chars, char flag, size_t size);
-int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
-		size_t size);
+int tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
+				 const char *flags, size_t size);
+int tty_insert_flip_string_fixed_flag(struct tty_port *port, const u8 *chars,
+				      char flag, size_t size);
+int tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size);
 void tty_flip_buffer_push(struct tty_port *port);
-int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag);
+int __tty_insert_flip_char(struct tty_port *port, u8 ch, char flag);
 
-static inline int tty_insert_flip_char(struct tty_port *port,
-					unsigned char ch, char flag)
+static inline int tty_insert_flip_char(struct tty_port *port, u8 ch, char flag)
 {
 	struct tty_buffer *tb = port->buf.tail;
 	int change;
@@ -36,13 +34,13 @@ static inline int tty_insert_flip_char(struct tty_port *port,
 }
 
 static inline int tty_insert_flip_string(struct tty_port *port,
-		const unsigned char *chars, size_t size)
+		const u8 *chars, size_t size)
 {
 	return tty_insert_flip_string_fixed_flag(port, chars, TTY_NORMAL, size);
 }
 
-size_t tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
-			     const char *f, size_t count);
+size_t tty_ldisc_receive_buf(struct tty_ldisc *ld, const u8 *p, const char *f,
+			     size_t count);
 
 void tty_buffer_lock_exclusive(struct tty_port *port);
 void tty_buffer_unlock_exclusive(struct tty_port *port);
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index f88529e6a783..5551c4400e59 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -161,8 +161,8 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *
  *	Optional. Can sleep.
  *
- * @receive_buf: [DRV] ``void ()(struct tty_struct *tty,
- *		       const unsigned char *cp, const char *fp, size_t count)``
+ * @receive_buf: [DRV] ``void ()(struct tty_struct *tty, const u8 *cp,
+ *		       const char *fp, size_t count)``
  *
  *	This function is called by the low-level tty driver to send characters
  *	received by the hardware to the line discpline for processing. @cp is
@@ -191,8 +191,8 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *
  *	Optional.
  *
- * @receive_buf2: [DRV] ``ssize_t ()(struct tty_struct *tty,
- *			const unsigned char *cp, const char *fp, size_t count)``
+ * @receive_buf2: [DRV] ``ssize_t ()(struct tty_struct *tty, const u8 *cp,
+ *			const char *fp, size_t count)``
  *
  *	This function is called by the low-level tty driver to send characters
  *	received by the hardware to the line discpline for processing. @cp is a
@@ -204,8 +204,8 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *
  *	Optional.
  *
- * @lookahead_buf: [DRV] ``void ()(struct tty_struct *tty,
- *			const unsigned char *cp, const char *fp, size_t count)``
+ * @lookahead_buf: [DRV] ``void ()(struct tty_struct *tty, const u8 *cp,
+ *			 const char *fp, size_t count)``
  *
  *	This function is called by the low-level tty driver for characters
  *	not eaten by ->receive_buf() or ->receive_buf2(). It is useful for
@@ -255,13 +255,13 @@ struct tty_ldisc_ops {
 	/*
 	 * The following routines are called from below.
 	 */
-	void	(*receive_buf)(struct tty_struct *tty, const unsigned char *cp,
+	void	(*receive_buf)(struct tty_struct *tty, const u8 *cp,
 			       const char *fp, size_t count);
 	void	(*write_wakeup)(struct tty_struct *tty);
 	void	(*dcd_change)(struct tty_struct *tty, bool active);
-	size_t	(*receive_buf2)(struct tty_struct *tty, const unsigned char *cp,
+	size_t	(*receive_buf2)(struct tty_struct *tty, const u8 *cp,
 				const char *fp, size_t count);
-	void	(*lookahead_buf)(struct tty_struct *tty, const unsigned char *cp,
+	void	(*lookahead_buf)(struct tty_struct *tty, const u8 *cp,
 				 const unsigned char *fp, size_t count);
 
 	struct  module *owner;
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 42cc863cbd53..6d4938e3cbad 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -258,8 +258,8 @@ static void v253_hangup(struct tty_struct *tty)
 }
 
 /* Line discipline .receive_buf() */
-static void v253_receive(struct tty_struct *tty, const unsigned char *cp,
-			 const char *fp, size_t count)
+static void v253_receive(struct tty_struct *tty, const u8 *cp, const char *fp,
+			 size_t count)
 {
 	struct snd_soc_component *component = tty->disc_data;
 	struct cx20442_priv *cx20442;
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 1028b5efcfff..371943350fdf 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -336,7 +336,7 @@ static void cx81801_hangup(struct tty_struct *tty)
 }
 
 /* Line discipline .receive_buf() */
-static void cx81801_receive(struct tty_struct *tty, const unsigned char *cp,
+static void cx81801_receive(struct tty_struct *tty, const u8 *cp,
 		const char *fp, int count)
 {
 	struct snd_soc_component *component = tty->disc_data;
-- 
2.41.0

