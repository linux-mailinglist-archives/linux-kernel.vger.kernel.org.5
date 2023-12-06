Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF28068C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjLFHjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjLFHit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:38:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE711FEE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55489C43395;
        Wed,  6 Dec 2023 07:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848278;
        bh=Q04vqTxy1dsmgwziXnh2z+E07djY9pp2DTirob84VpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VnUYJE4WxrpV8oP6RIh0fSZ1s3YaiBSY+FPXAeMX5AD0B1pnY73aWQScG2TfWm0E2
         0N9agwCmSyijagcDcvp/YUSZDuad29IdpcHVF5fyhal8ACXmKkFz6RPAcpS5Q4s8ge
         wPrgJf0HYDEqLPs0B0XeZ8LHKUyFsfa1p0gEVQQyTB7Fiz/bOTFpmun8WM+eyB3LbV
         7slSLbYBb5AJulDKq1GiJLxXpRY0ODLwUKZ0Q+m1fbjKAx+oJZDpeqZM//1JhWjISB
         5W4PLxMGyNoR1Y5jDo2RFvQM/RJ0LZmRqexcj971xsv8iqi6w7ces6RZaoeJJuDOeu
         eHM5/dCLNo3KA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 19/27] tty: n_gsm: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:37:04 +0100
Message-ID: <20231206073712.17776-20-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
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

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_gsm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index a3ab3946e4ad..4036566febcb 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -124,8 +124,8 @@ struct gsm_msg {
 	u8 addr;		/* DLCI address + flags */
 	u8 ctrl;		/* Control byte + flags */
 	unsigned int len;	/* Length of data block (can be zero) */
-	unsigned char *data;	/* Points into buffer but not at the start */
-	unsigned char buffer[];
+	u8 *data;	/* Points into buffer but not at the start */
+	u8 buffer[];
 };
 
 enum gsm_dlci_state {
@@ -283,7 +283,7 @@ struct gsm_mux {
 	/* Bits for GSM mode decoding */
 
 	/* Framing Layer */
-	unsigned char *buf;
+	u8 *buf;
 	enum gsm_mux_state state;
 	unsigned int len;
 	unsigned int address;
@@ -2856,7 +2856,7 @@ static void gsm_queue(struct gsm_mux *gsm)
  *	Receive bytes in gsm mode 0
  */
 
-static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
+static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 {
 	unsigned int len;
 
@@ -2947,7 +2947,7 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
  *	Receive bytes in mode 1 (Advanced option)
  */
 
-static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
+static void gsm1_receive(struct gsm_mux *gsm, u8 c)
 {
 	/* handle XON/XOFF */
 	if ((c & ISO_IEC_646_MASK) == XON) {
@@ -3541,7 +3541,7 @@ static void gsmld_receive_buf(struct tty_struct *tty, const u8 *cp,
 			      const u8 *fp, size_t count)
 {
 	struct gsm_mux *gsm = tty->disc_data;
-	char flags = TTY_NORMAL;
+	u8 flags = TTY_NORMAL;
 
 	if (debug & DBG_DATA)
 		gsm_hex_dump_bytes(__func__, cp, count);
@@ -3711,7 +3711,7 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
 {
 	struct gsm_mux *gsm = tty->disc_data;
 	unsigned long flags;
-	int space;
+	size_t space;
 	int ret;
 
 	if (!gsm)
@@ -3909,8 +3909,7 @@ static void gsm_mux_net_tx_timeout(struct net_device *net, unsigned int txqueue)
 	net->stats.tx_errors++;
 }
 
-static void gsm_mux_rx_netchar(struct gsm_dlci *dlci,
-				const unsigned char *in_buf, int size)
+static void gsm_mux_rx_netchar(struct gsm_dlci *dlci, const u8 *in_buf, int size)
 {
 	struct net_device *net = dlci->net;
 	struct sk_buff *skb;
-- 
2.43.0

