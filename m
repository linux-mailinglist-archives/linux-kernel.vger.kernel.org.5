Return-Path: <linux-kernel+bounces-56211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD82384C766
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CB61F26A68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2E219E9;
	Wed,  7 Feb 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F84pdEGf"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D121112
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298359; cv=none; b=tPpQ4LHgV0rKHiTQQryqwVwQUWspUYEYp/tEyXrUXcJ2qBBvq5vYfGruRlJ08aJupf6QsSVpQKOlDtCZ8TEhzGQxuJI6azKRkdZxX2xe7zTbyvcg51mUb6dACSyz0Ue4CJ1GnetvKASgzdA+jbpTESGzFA6vvoUsQJyY7xrHJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298359; c=relaxed/simple;
	bh=kdLifE5+vi9NVE1VnFjcL8NvUd7d6otTYHIc5P8vu/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qH7a1OQNXVdjE/cXwP7W1do1JX8rlZ00538fnBTdA64d12GOH9BaERZPYJBhoKln7CbxuRQtiidUf0ntv/3r+xCNVC69jGXMSwwC23Jn9YkQL3Lmc+PhFuT8pVvnqwzqYxmw8nZ1kg1BDKvgsPvNX4uCilY3R3faR4JXIDk61LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F84pdEGf; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a372a3773a5so44500366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298356; x=1707903156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMSC3a9LZoI/QoYVZa72EO+oYUfJG09wFtMJdz3hQvY=;
        b=F84pdEGfbJmbDdoFJGX7ypCRXY2fRH0IfcsW4L05LfKeZS6TDHS8R+FeixKixmg/M8
         Vg4h9SAjcmyrgHwubf9SPtnpYaR7Vm/Ili97hWdxKI7iqda6Z+fzyfv6+mPNcdqtYLO6
         MGkssrR66uzVYGv7zibfmkj1RVq8iBDMjC27/Z5jfNzNISwMgys81D84UbyiquoIvShY
         Mc5Lb04BPN6/vY7/MDDGu7PoBaUr54rbd781r9lERws3xtup2prDA5TUYqA27Yqw/0W6
         9U1TZGtqmzz5oSMTrtB/bBzUoqBRz+ntRCDompc1BT36S7BAkHXtCB8leWumz/LpPW4e
         eJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298356; x=1707903156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMSC3a9LZoI/QoYVZa72EO+oYUfJG09wFtMJdz3hQvY=;
        b=PMZv9gL0ofbgxptc11TL+eYSyV/NWEGxfT8pQUh0ZDP9lukfD3qTsrPbaJ778tH4Vs
         pwsjwCEC9WY2UiyB54krlUkPMkcwRLwoWnUroBloi4swladXNECKrxc6Ek3gwnASVCq0
         OBNnUd39YwA0zHBKHM+1stgoL3HV1Q+1PAPFHGbzjaR53yaXxB3puhGJWqNx55DPcy7A
         lf6wlslc3YYcg1KZmQf0E+o6BtniNLUSL2kpjyIRojyHBmRY2mBBBRfvAKol83+NJiEo
         uk6hbK0SzRGhdx2/w4pg4MX22zl8NlOV6IOtlFZKuLdThDf4q6ZDv8EtWQmsKxWnPCyZ
         KCHg==
X-Gm-Message-State: AOJu0Ywt+KdL7y9rRIrhJYJSMObB/3MyKVP4k1kCSyWtNI1mXvu1p+yM
	DIUAbtfWed8vQ2bBrcNkt1VhJps439wFdAZdvrY/BiGD4AYA+yE9JmNN5E0FO4A=
X-Google-Smtp-Source: AGHT+IHGAMHEYzKOjvj2nu/7gcehdMXo2GCZQM92RvVoe7GOvKcigVHt7UYv/EnhKJvgerKSPwZxkQ==
X-Received: by 2002:a17:906:34cf:b0:a30:2690:5c48 with SMTP id h15-20020a17090634cf00b00a3026905c48mr4088620ejb.8.1707298356082;
        Wed, 07 Feb 2024 01:32:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhwaVRY5NtaqW5h+0TlVDeFkmaR0rwgTV19WqVeLA1lfQSr0AXEvTdQ4sfhCyMIPZYzLByLipXXB2LWQrB9wWRpy1nIeRNBWHnfVr3SP3I613BeSEVH+10MKW9oF+SFim7/y2rwWZCQAHYjt56o44m5bTgM/tiY5Z/4tqvArlSJMXhbZ+oq4h3Rdwqu20vbKcjjwdzYrg5OVCO7bHCwrAKa2bZjil/aXL8P2tG8xJi/YQAd9ScHZmhxT2PJZV8nO8T/ooULIcyf0atsifuPIdvOkhNGrt0qnmPVD0ZnMua8clG0QmCHwE6EsR/JF1//JedoQCexXhQqteH6pnjo4K5WrcPqQFP2s5LtL4adwhBtkiWKnh2dcDnXXLn/0rNduujHX0jZ8Yh4EMInnIvsmPEB5vd1yTSVl4jyBA1Wo160kz1OvyxOGtXGOEK
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:35 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 01/14] can: m_can: Start/Cancel polling timer together with interrupts
Date: Wed,  7 Feb 2024 10:32:07 +0100
Message-ID: <20240207093220.2681425-2-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207093220.2681425-1-msp@baylibre.com>
References: <20240207093220.2681425-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Interrupts are enabled/disabled in more places than just m_can_start()
and m_can_stop(). Couple the polling timer with enabling/disabling of
all interrupts to achieve equivalent behavior.

Cc: Judith Mendez <jm@ti.com>
Fixes: b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16ecc11c7f62..2395b1225cc8 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -418,6 +418,13 @@ static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
 
 static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 {
+	if (!cdev->net->irq) {
+		dev_dbg(cdev->dev, "Start hrtimer\n");
+		hrtimer_start(&cdev->hrtimer,
+			      ms_to_ktime(HRTIMER_POLL_INTERVAL_MS),
+			      HRTIMER_MODE_REL_PINNED);
+	}
+
 	/* Only interrupt line 0 is used in this driver */
 	m_can_write(cdev, M_CAN_ILE, ILE_EINT0);
 }
@@ -425,6 +432,11 @@ static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 {
 	m_can_write(cdev, M_CAN_ILE, 0x0);
+
+	if (!cdev->net->irq) {
+		dev_dbg(cdev->dev, "Stop hrtimer\n");
+		hrtimer_cancel(&cdev->hrtimer);
+	}
 }
 
 /* Retrieve internal timestamp counter from TSCV.TSC, and shift it to 32-bit
@@ -1417,12 +1429,6 @@ static int m_can_start(struct net_device *dev)
 
 	m_can_enable_all_interrupts(cdev);
 
-	if (!dev->irq) {
-		dev_dbg(cdev->dev, "Start hrtimer\n");
-		hrtimer_start(&cdev->hrtimer, ms_to_ktime(HRTIMER_POLL_INTERVAL_MS),
-			      HRTIMER_MODE_REL_PINNED);
-	}
-
 	return 0;
 }
 
@@ -1577,11 +1583,6 @@ static void m_can_stop(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
-	if (!dev->irq) {
-		dev_dbg(cdev->dev, "Stop hrtimer\n");
-		hrtimer_cancel(&cdev->hrtimer);
-	}
-
 	/* disable all interrupts */
 	m_can_disable_all_interrupts(cdev);
 
-- 
2.43.0


