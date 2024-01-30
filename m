Return-Path: <linux-kernel+bounces-45181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EAB842C91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90AA1C24D93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C0971B43;
	Tue, 30 Jan 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alEOnOmq"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74947AE73
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642593; cv=none; b=WlTJUSRAhoqy8eovzFj0GuaHsKnThc0xgqeySHdoUm6s8pVcFDmoHmXB7BeB3g/mVl5vnvEq9+Y+4RhG79Acs3rbWSBmrCClUGpkQyfnWSU0u2mjafnQiCqOE/6LLmIj/urJy8LLGAaYPRwQ7GHK9o9Ppsxjv/3Fo98LB5bG6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642593; c=relaxed/simple;
	bh=g9izfX6XgkZla6GTE2GxGyabzh6/fiFAQsmyv6knGrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTgOeimlyu/Q0NQMJ5yTaK+h2P86B6zmhBAILeuLZxjdQYklyWH/x3XfWqWiyILsG/II8PlZVpHW2mt5ui5HZwug3I9+CackZ20F0Iom/1+4eRVUItQ69y/hphWPmxRzxaMok1WtDT2qz2iZV63zXVOiey+qYd3l3SZnzxsgCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=alEOnOmq; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3637fb0bd6cso6220045ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706642591; x=1707247391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxd3mG2/1IddsNcldBuZY2JUAVRlavlzaQzhHM61Xz0=;
        b=alEOnOmqjq1UULa2rY1Ay3VoibWPMNt5+gle6uBMCq2jUOFAZs6sZWQX4/GKZxt+4Y
         EhmwJDpiqNwcx7XEXZefQ3IGHOMF6YTplA1OeZdi61dydNHw12/R6XvlV5oM38nzQd/R
         fRlHsBcY1BQCwUS7Pf4P4y7JJrwVOu8+dSubYHdFn6Ftz5YsI2pvMoMFd17ewb+AHD/8
         7T9HFvJGKhfqh24D8Tn8dumdVL5yiAKhTlI4c7PbdYdXaH//KslnVA7aKQL8EBU1Q+ZM
         2kf4irW3yo0vO8+6C8xJ3rWOK3quDVj6KLzSOiK4I00Kzp6Fxjs5GXCNhh91WBInD97t
         oIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706642591; x=1707247391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxd3mG2/1IddsNcldBuZY2JUAVRlavlzaQzhHM61Xz0=;
        b=IIz9MZ+fGt8Rtw3p6SbXyqXqI74YJm4eZUSozggcr0T0OLNQMQRl8TL7puAU6q2Qaq
         V69MLmQ45tdbqz29CaExnzxa8Qf2R6VtuSfOgL/U61ULb5IbttOmkoPWOPNbymtO/s4r
         LVa2XnWJj8l2tjPu7Hkioc1QLMzSPWd/nrgZWP7PzcPsdxl7hQPFCmasda/rPKhPGfrS
         sc5flXrBUlSI0/BpKsKJi6GQYu0h8z7MeOAlt21bWE3ahxj+Cutdl7eDZz6K6GeGND+s
         TLWM/c3ZStaBxXNJ1Tf4PFGG1YoTRUpZyKrnPYrN6O4LNRqBr4weVjiXpXb4kULO0+/P
         43MA==
X-Gm-Message-State: AOJu0YwBN8wg1vR4SBBFdHdzKIuH6UrOQl0B/hyjwWyqYmtRt4WliZYS
	nl79x0mNFE94Ue819gTlnmgFZo7rXHOQTGQ1HozmZbDQR2gE0gJo1anxYcRh0WI=
X-Google-Smtp-Source: AGHT+IGTUT9Kd1uV0mrMasfE8zaevyiOyeAx68UVu3kMYHDIRVhqc81BZ423aoLmlOF8LIrSsiUJOg==
X-Received: by 2002:a92:2908:0:b0:363:812d:d6a6 with SMTP id l8-20020a922908000000b00363812dd6a6mr5290596ilg.3.1706642590790;
        Tue, 30 Jan 2024 11:23:10 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id t18-20020a92c912000000b003637871ec98sm2157762ilp.27.2024.01.30.11.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:23:10 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/7] net: ipa: begin simplifying TX queue stop
Date: Tue, 30 Jan 2024 13:22:59 -0600
Message-Id: <20240130192305.250915-3-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130192305.250915-1-elder@linaro.org>
References: <20240130192305.250915-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a number of flags used in the IPA driver to attempt to
manage race conditions that can occur between runtime resume and
netdev transmit.  If we disable TX before requesting power, we can
avoid these races entirely, simplifying things considerably.

This patch implements the main change, disabling transmit always in
the net_device->ndo_start_xmit() callback, then re-enabling it again
whenever we find power is active (or when we drop the skb).

The patches that follow will refactor the "old" code to the point
that most of it can be eliminated.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_modem.c | 41 +++++++++++++++++++++++-----------
 drivers/net/ipa/ipa_power.c | 44 ++++++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index a6f6cd149c1b6..c7a0b167c4326 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -110,13 +110,16 @@ static int ipa_stop(struct net_device *netdev)
 	return 0;
 }
 
-/** ipa_start_xmit() - Transmits an skb.
- * @skb: skb to be transmitted
- * @dev: network device
+/** ipa_start_xmit() - Transmit an skb
+ * @skb:	Socket buffer to be transmitted
+ * @netdev:	Network device
  *
- * Return codes:
- * NETDEV_TX_OK: Success
- * NETDEV_TX_BUSY: Error while transmitting the skb. Try again later
+ * Return: NETDEV_TX_OK if successful (or dropped), NETDEV_TX_BUSY otherwise
+
+ * Normally NETDEV_TX_OK indicates the buffer was successfully transmitted.
+ * If the buffer has an unexpected protocol or its size is out of range it
+ * is quietly dropped, returning NETDEV_TX_OK.  NETDEV_TX_BUSY indicates
+ * the buffer cannot be sent at this time and should retried later.
  */
 static netdev_tx_t
 ipa_start_xmit(struct sk_buff *skb, struct net_device *netdev)
@@ -136,7 +139,25 @@ ipa_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	if (endpoint->config.qmap && skb->protocol != htons(ETH_P_MAP))
 		goto err_drop_skb;
 
-	/* The hardware must be powered for us to transmit */
+	/* The hardware must be powered for us to transmit, so if we're not
+	 * ready we want the network stack to stop queueing until power is
+	 * ACTIVE.  Once runtime resume has completed, we inform the network
+	 * stack it's OK to try transmitting again.
+	 *
+	 * We learn from pm_runtime_get() whether the hardware is powered.
+	 * If it was not, powering up is either started or already underway.
+	 * And in that case we want to disable queueing, expecting it to be
+	 * re-enabled once power is ACTIVE.  But runtime PM and network
+	 * transmit run concurrently, and if we're not careful the requests
+	 * to stop and start queueing could occur in the wrong order.
+	 *
+	 * For that reason we *always* stop queueing here, *before* the call
+	 * to pm_runtime_get().  If we determine here that power is ACTIVE,
+	 * we restart queueing before transmitting the SKB.  Otherwise
+	 * queueing will eventually be enabled after resume completes.
+	 */
+	ipa_power_modem_queue_stop(ipa);
+
 	dev = &ipa->pdev->dev;
 	ret = pm_runtime_get(dev);
 	if (ret < 1) {
@@ -147,12 +168,6 @@ ipa_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 			goto err_drop_skb;
 		}
 
-		/* No power (yet).  Stop the network stack from transmitting
-		 * until we're resumed; ipa_modem_resume() arranges for the
-		 * TX queue to be started again.
-		 */
-		ipa_power_modem_queue_stop(ipa);
-
 		pm_runtime_put_noidle(dev);
 
 		return NETDEV_TX_BUSY;
diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index e223886123cea..f1802448ff447 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -233,28 +233,32 @@ void ipa_power_suspend_handler(struct ipa *ipa, enum ipa_irq_id irq_id)
 	ipa_interrupt_suspend_clear_all(ipa->interrupt);
 }
 
-/* The next few functions coordinate stopping and starting the modem
+/* The next few functions are used when stopping and starting the modem
  * network device transmit queue.
  *
- * Transmit can be running concurrent with power resume, and there's a
- * chance the resume completes before the transmit path stops the queue,
- * leaving the queue in a stopped state.  The next two functions are used
- * to avoid this: ipa_power_modem_queue_stop() is used by ipa_start_xmit()
- * to conditionally stop the TX queue; and ipa_power_modem_queue_start()
- * is used by ipa_runtime_resume() to conditionally restart it.
+ * Transmit can run concurrent with power resume.  When transmitting,
+ * we disable further transmits until we can determine whether power
+ * is ACTIVE.  If it is, future transmits are re-enabled and the buffer
+ * gets sent (or dropped).  If power is not ACTIVE, it will eventually
+ * be, and transmits stay disabled until after it is.
  *
- * Two flags and a spinlock are used.  If the queue is stopped, the STOPPED
- * power flag is set.  And if the queue is started, the STARTED flag is set.
- * The queue is only started on resume if the STOPPED flag is set.  And the
- * queue is only started in ipa_start_xmit() if the STARTED flag is *not*
- * set.  As a result, the queue remains operational if the two activites
- * happen concurrently regardless of the order they complete.  The spinlock
- * ensures the flag and TX queue operations are done atomically.
+ * Two flags and a spinlock are used when managing this.  If the queue
+ * is stopped, the STOPPED power flag is set.  And if the queue is
+ * started, the STARTED flag is set.
  *
  * The first function stops the modem netdev transmit queue, but only if
- * the STARTED flag is *not* set.  That flag is cleared if it was set.
- * If the queue is stopped, the STOPPED flag is set.  This is called only
- * from the power ->runtime_resume operation.
+ * the STARTED flag is *not* set.  This previously avoided a race where
+ * the TX path stops further transmits after power has become ACTIVE.
+ * The STARTED flag is cleared by this function.
+ *
+ * The second function starts the transmit queue, but only if the
+ * STOPPED flag is set.  This avoids enabling transmits repeatedly
+ * immediately after power has become ACTIVE (not really a big deal).
+ * If the STOPPED flag was set, it is cleared and the STARTED flag
+ * is set by this function.
+ *
+ * The third function enables transmits again and clears the STARTED
+ * flag in case it was set, to return it to initial state.
  */
 void ipa_power_modem_queue_stop(struct ipa *ipa)
 {
@@ -291,9 +295,13 @@ void ipa_power_modem_queue_wake(struct ipa *ipa)
 	spin_unlock_irqrestore(&power->spinlock, flags);
 }
 
-/* This function clears the STARTED flag once the TX queue is operating */
+/* This function is run after power has become ACTIVE.  It enables transmits
+ * again clears the STARTED flag to indicate the TX queue is operating and
+ * can be stopped again if necessary.
+ */
 void ipa_power_modem_queue_active(struct ipa *ipa)
 {
+	netif_wake_queue(ipa->modem_netdev);
 	clear_bit(IPA_POWER_FLAG_STARTED, ipa->power->flags);
 }
 
-- 
2.40.1


