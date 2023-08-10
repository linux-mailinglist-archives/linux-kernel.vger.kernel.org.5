Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C9777400
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjHJJPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjHJJPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6D726B6;
        Thu, 10 Aug 2023 02:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F332E612F0;
        Thu, 10 Aug 2023 09:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DF6C433C9;
        Thu, 10 Aug 2023 09:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658920;
        bh=YDWGPVyFFTBkDIsAMqAh/xIPdpc9bI1p2CZBhTV0lsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8Vjq2IySAIOqr+y9oQ+Lfam7x6S14t+ggiuKN9PFXr+Bj5Ka056zHITD6Kt0wqI9
         37tMNLz7+Ly6rb5I/kFkuBn44zM6jDzdia1TAVmXjZuQ1ht4XabobY+SXXDkgqqimL
         DB1C5eXcDuHXlcESRMY08Fzmp+sxfOp+AuVWSLE1W565DOGIVnl1z9WxS9qugG23K4
         PmL4PWzW/BLyq68A/YKV9X8UaFxs0hDr1Imp9Pr62QUDnOZxNRGGZYhtbWTsMw2Gfe
         BVEbq89LBW9wUBf5mkwEGFSYd9FB95cDL0EE2HfYDl5HNiYYFGlly8Xrgn7bR5moeF
         gg1BEHOk3VO8g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/36] tty: remove dummy tty_ldisc_ops::poll() implementations
Date:   Thu, 10 Aug 2023 11:14:37 +0200
Message-ID: <20230810091510.13006-4-jirislaby@kernel.org>
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

tty_ldisc_ops::poll() is optional and needs not be provided. It is equal
to returning 0. So remove all those from the code.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bluetooth/hci_ldisc.c | 7 -------
 drivers/net/ppp/ppp_async.c   | 8 --------
 drivers/net/ppp/ppp_synctty.c | 8 --------
 net/nfc/nci/uart.c            | 7 -------
 4 files changed, 30 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index a76eb98c0047..759472686831 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -819,12 +819,6 @@ static ssize_t hci_uart_tty_write(struct tty_struct *tty, struct file *file,
 	return 0;
 }
 
-static __poll_t hci_uart_tty_poll(struct tty_struct *tty,
-				      struct file *filp, poll_table *wait)
-{
-	return 0;
-}
-
 static struct tty_ldisc_ops hci_uart_ldisc = {
 	.owner		= THIS_MODULE,
 	.num		= N_HCI,
@@ -835,7 +829,6 @@ static struct tty_ldisc_ops hci_uart_ldisc = {
 	.write		= hci_uart_tty_write,
 	.ioctl		= hci_uart_tty_ioctl,
 	.compat_ioctl	= hci_uart_tty_ioctl,
-	.poll		= hci_uart_tty_poll,
 	.receive_buf	= hci_uart_tty_receive,
 	.write_wakeup	= hci_uart_tty_wakeup,
 };
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 15a179631903..f420bddb6a8c 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -328,13 +328,6 @@ ppp_asynctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	return err;
 }
 
-/* No kernel lock - fine */
-static __poll_t
-ppp_asynctty_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
-{
-	return 0;
-}
-
 /* May sleep, don't call from interrupt level or with interrupts disabled */
 static void
 ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
@@ -378,7 +371,6 @@ static struct tty_ldisc_ops ppp_ldisc = {
 	.read	= ppp_asynctty_read,
 	.write	= ppp_asynctty_write,
 	.ioctl	= ppp_asynctty_ioctl,
-	.poll	= ppp_asynctty_poll,
 	.receive_buf = ppp_asynctty_receive,
 	.write_wakeup = ppp_asynctty_wakeup,
 };
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 18283b7b94bc..86dacef84c6c 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -321,13 +321,6 @@ ppp_synctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	return err;
 }
 
-/* No kernel lock - fine */
-static __poll_t
-ppp_sync_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
-{
-	return 0;
-}
-
 /* May sleep, don't call from interrupt level or with interrupts disabled */
 static void
 ppp_sync_receive(struct tty_struct *tty, const unsigned char *buf,
@@ -371,7 +364,6 @@ static struct tty_ldisc_ops ppp_sync_ldisc = {
 	.read	= ppp_sync_read,
 	.write	= ppp_sync_write,
 	.ioctl	= ppp_synctty_ioctl,
-	.poll	= ppp_sync_poll,
 	.receive_buf = ppp_sync_receive,
 	.write_wakeup = ppp_sync_wakeup,
 };
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 082f94be0996..c8249d95306d 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -357,12 +357,6 @@ static ssize_t nci_uart_tty_write(struct tty_struct *tty, struct file *file,
 	return 0;
 }
 
-static __poll_t nci_uart_tty_poll(struct tty_struct *tty,
-				      struct file *filp, poll_table *wait)
-{
-	return 0;
-}
-
 static int nci_uart_send(struct nci_uart *nu, struct sk_buff *skb)
 {
 	/* Queue TX packet */
@@ -435,7 +429,6 @@ static struct tty_ldisc_ops nci_uart_ldisc = {
 	.close		= nci_uart_tty_close,
 	.read		= nci_uart_tty_read,
 	.write		= nci_uart_tty_write,
-	.poll		= nci_uart_tty_poll,
 	.receive_buf	= nci_uart_tty_receive,
 	.write_wakeup	= nci_uart_tty_wakeup,
 	.ioctl		= nci_uart_tty_ioctl,
-- 
2.41.0

