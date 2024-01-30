Return-Path: <linux-kernel+bounces-45186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B789842CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE511F253F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3957B3D4;
	Tue, 30 Jan 2024 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QeSnJgc2"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591E71B24
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642598; cv=none; b=IwjJtCk6vT4ZuVzzHBtYo0Au+IYFjt6PfgF4yoR57I9GcAfRa1fQPuSbI6j9RmFZ5S4VP0xl85BsW2r+T1A0wF86nU0WcV5DFPO8gPNm/KOGtl9m+86N17mHWV054Pe/WRonEFHsCaVhIAk6g9+WPd9H/NMJAxsnE6WBylSTgdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642598; c=relaxed/simple;
	bh=svy2Y/cgyQ7iZi2hQoEHT6Pbe1rIEc4pAjdeVhTs3Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gja3Et81hytD2ljktILchZ+vhTE1PVPpqIdhPdXmN9Z77tNytJIcXGqJtUUwp1U5z34SmG8Arsa1m6wLWPxYAGQMzAvYP4ckVTw7JMc5r7wx0jpqwAVtrQtfEKRJiTeziulDtVO19oGTHhi7kq7S7kPZHcB0kr1p9S3u+ei6Ep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QeSnJgc2; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3637860f03bso7994665ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706642596; x=1707247396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjtwPzfATFl6gd93BqfU7z6ovF0ULYud2+oCqQjCPeY=;
        b=QeSnJgc2CqUVatkdfVoNIwshLBxqYad2FXUlpqPdj5n3cfKBKplr7UswjUVL9bNShw
         4q2ckUOHvBMsrxyLQnPEz9Nvgu3TQ69SMJTQOONbFez9Wm94qZLP3bTlQl9E5fpukhEe
         pRM37nfIWLRLuvK0o8qyM/Wce5Hl4B8RLHcAfLGe6IyqedNEShK68P4PMzlzWHMhpl+C
         ucBO65MiXVLY4NXBag7Z49huPKpOBRD9UzqhBkqEudfwQgzqYvNyY1y7mtaJQi7ExyPL
         /ms1gnuQfVBWrntDSZ6nP45KJocZ8Sr0aSjKRZ2BDAMflLHeAiOTkRGur4ec5EOvekj7
         aYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706642596; x=1707247396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjtwPzfATFl6gd93BqfU7z6ovF0ULYud2+oCqQjCPeY=;
        b=P9QOfGHTDdvxffyOkjPONK3DhEUfnEzPxssL1jiz+wtF+MLG6JLsgyrQkiikwPH9wN
         vZ2eoUGSZ6L85G/fC/J3A/kkYnGA3IiqvcUbnEHrikCB59GDb3+fXjt2B0qUBbcOBo2Y
         z3WnJDqRMvHq6Pi6lBGpMG0j+e+C2SuXxueDdTdEQ12Ml5F2/4iQiEp819OB2nX9cSla
         ow5ynT1GAqT1JxqM+Vc/2QMewUAjJfBRsPrBTQJDhFFr2yQGFlIKfc61Rlr8of2s6w2I
         H34l3fASYuVqP1q/5YJvaxj/h3NoJsIYn5sjaahXA+ozIZmbD2tCliVip5F7gqHrrD74
         y40Q==
X-Gm-Message-State: AOJu0YxJ1wAdSvSNu3M6Jz9obdA08WgtVBPxQyMXRF/44oyA4jMEbbOQ
	w+fLOEFFHHHVBlCAvRyrvmGHyhriae3gj32OxgDA6w3bAzw4wIoGVu2hErFlwSU=
X-Google-Smtp-Source: AGHT+IGMJFkq2oSExjhyhojj9ERT7X94COzELPYpHP3ZGYxq79rTjtGtAIdVOacbYS0g3wHQy0Dalg==
X-Received: by 2002:a05:6e02:eeb:b0:363:90c2:228f with SMTP id j11-20020a056e020eeb00b0036390c2228fmr1764028ilk.27.1706642596134;
        Tue, 30 Jan 2024 11:23:16 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id t18-20020a92c912000000b003637871ec98sm2157762ilp.27.2024.01.30.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:23:15 -0800 (PST)
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
Subject: [PATCH net-next 7/7] net: ipa: kill ipa_power_modem_queue_wake()
Date: Tue, 30 Jan 2024 13:23:04 -0600
Message-Id: <20240130192305.250915-8-elder@linaro.org>
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

All ipa_power_modem_queue_wake() does is call netif_wake_queue()
on the modem netdev.  There is no need to wrap that call in a
trivial function (and certainly not one defined in "ipa_power.c").

So get rid of ipa_power_modem_queue_wake(), and replace its one
caller with a direct call to netif_wake_queue().  Determine the
netdev pointer to use from the private TX endpoint's netdev pointer.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_modem.c |  2 +-
 drivers/net/ipa/ipa_power.c | 13 -------------
 drivers/net/ipa/ipa_power.h |  6 ------
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 0c298060468eb..1d1be92fbebcb 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -277,7 +277,7 @@ static void ipa_modem_wake_queue_work(struct work_struct *work)
 {
 	struct ipa_priv *priv = container_of(work, struct ipa_priv, work);
 
-	ipa_power_modem_queue_wake(priv->ipa);
+	netif_wake_queue(priv->tx->netdev);
 }
 
 /** ipa_modem_resume() - resume callback for runtime_pm
diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index fd2abce043fa5..128a816f65237 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -227,19 +227,6 @@ void ipa_power_suspend_handler(struct ipa *ipa, enum ipa_irq_id irq_id)
 	ipa_interrupt_suspend_clear_all(ipa->interrupt);
 }
 
-/* Transmit can run concurrent with power resume.  When transmitting,
- * we disable further transmits until we can determine whether power
- * is ACTIVE.  If it is, future transmits are re-enabled and the buffer
- * gets sent (or dropped).  If power is not ACTIVE, it will eventually
- * be, and transmits stay disabled until after it is.  This function
- * starts the transmit queue and is used in the power resume path after
- * power has become ACTIVE.
- */
-void ipa_power_modem_queue_wake(struct ipa *ipa)
-{
-	netif_wake_queue(ipa->modem_netdev);
-}
-
 static int ipa_power_retention_init(struct ipa_power *power)
 {
 	struct qmp *qmp = qmp_get(power->dev);
diff --git a/drivers/net/ipa/ipa_power.h b/drivers/net/ipa/ipa_power.h
index dcd36a6a718f2..718aacf5e2b23 100644
--- a/drivers/net/ipa/ipa_power.h
+++ b/drivers/net/ipa/ipa_power.h
@@ -23,12 +23,6 @@ extern const struct dev_pm_ops ipa_pm_ops;
  */
 u32 ipa_core_clock_rate(struct ipa *ipa);
 
-/**
- * ipa_power_modem_queue_wake() - Possibly wake the modem netdev TX queue
- * @ipa:	IPA pointer
- */
-void ipa_power_modem_queue_wake(struct ipa *ipa);
-
 /**
  * ipa_power_retention() - Control register retention on power collapse
  * @ipa:	IPA pointer
-- 
2.40.1


