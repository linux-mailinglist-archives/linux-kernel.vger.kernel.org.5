Return-Path: <linux-kernel+bounces-56218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1661284C77E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F32287E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF803309E;
	Wed,  7 Feb 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GLQ8EsSm"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BF2C6B0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298368; cv=none; b=TgdpqYqwtV1E05NaXayIMtENeRP8+RsFAz50zmwHeIO4fXii7AzqS6i3zI17yYqk4XKiXhEOZmluX7XUR9dvV62MJQsshxJT0SS/JcdhEsRaNkXBHmGRwlrIZLxuImy5GbX6os7C/QmrKu/6vEcJr7Ll12ytICpQh+o58OfDF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298368; c=relaxed/simple;
	bh=3bOx6w0LTuN8pcOfYHhxFGJ5/H17MO4GBppv0GaUmBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sY5lv+18Yp6trSryaD/W7ivVi7RHwNCicfVn1lMjKKpu1SnAyeFPjhNCAaVy+LYnbV4qbMtA5fwjQWmyLUicaE82ZIEEuHVfTLTIxogq59EJn0yxAAqpHCkuIlqvwlXOiQ1f3LfAFuRTwQpIyDsVRs1oYB/9Qt8arMgI106j4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GLQ8EsSm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3566c0309fso49215966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298364; x=1707903164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUP/ICSTgUrZXFT7bioEQjzIDbumAO5zjpvQT5yRgD4=;
        b=GLQ8EsSmvQ/wXg0UiyD9zmWuiUYlHG4GHWFuQF/JhV7s/04ACU2A168Gf8t2GAM7JT
         UclpxqvN9GK1cHyFK0yirJxqYr/30e8bXM0h/eUaltW2vkRSVibTC58XimLuK/WBtP0z
         r8vUAAI0J5t2dsRy9vBwBFecGH5rERL7yQFLUZsBxMCzi57YZ8Gb8uUuHjMyMFJmOLRH
         WBiEUsEEB+fjlfie64jfyd9D2SiPRvZIpop09MEq7TDjhUsiFWnMcUPYmROOP4cJJQat
         OieqKYgPTEdPL8DJBycgMcXmb9fHPIhDdvk0Ylf0gq11iCKvYdw7g2zwlrWtIL7SN6Cp
         zG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298364; x=1707903164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUP/ICSTgUrZXFT7bioEQjzIDbumAO5zjpvQT5yRgD4=;
        b=M7gkwEt4WP+DVNTYoG3ibEF8wSK+ODZjW5RH7Mv0PtXXz6veNkHYs+i/UquvGbeDxZ
         txyHQ/BakJ6juGjN3fiRdodEqPUG4+AthLgpw8Wn0GaMr8pZHxSb+5qOvoWCK2p/SZbx
         uV0MQIPjP5SVSeEJVD768S9r4pRjbNiNs6Zmz6iGcnjjQ//Mpl66c/ahV2K+Z2h7sL5j
         7A9RtcTLRThIdfmfeq+JzkHfNz11mK4emX4KdlQHlYHJRpv8DNuKjdOCWabJbRolGnNy
         2PUkD/7/K5Il47FsgFJfI8haJQBdgjFF4m0M9hWaESR9L3wzCapR2kv7GJSRn+zmsJMC
         v96g==
X-Forwarded-Encrypted: i=1; AJvYcCUbA22NAH5Kl8rLwaRg0D1dArx93Xxc/rTeCa7Rix/pPoN2NHs3D++/vlf3hrRIYNGyCftvB3Ff5EtD8/vJSg67iMLmm1zGrFKm+RVs
X-Gm-Message-State: AOJu0Yz3fWnt2nNznPiTGiUH4DgoZqVTVf+be7LzmXCxhp7mceuYiQQ0
	92JSCps1et8KR5huvDEmZ9PljhZy2hkX7z5yerOjADcw3Ralgk5JC4LRzOlP5Jk4tDBd3In4AxN
	8
X-Google-Smtp-Source: AGHT+IHK9IPkeDp33DRPPtDCbYtIAgI9YsCp7lpP9Vaga9kbgBw5dwf1+IBv3dC54jyBLhxpaDPKGA==
X-Received: by 2002:a17:906:7d83:b0:a37:a66b:b361 with SMTP id v3-20020a1709067d8300b00a37a66bb361mr3524242ejo.21.1707298364738;
        Wed, 07 Feb 2024 01:32:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUD0fnBBAqOWKl54sKKfHDzSLNwOsuRXN4OB4P5dEQHf2+fkGuifRlm/VbppuuKAWM9Vt8pq1b/xiw+HQBKCk7yaC5en261Y/cGMsWD/PnGQae1i7il6L/81aeE44FYoTZxk2cVNpaKsxqQkRzxEaEYaBZMYAnXVfJaP9bMRabavuOiIoEy1vMMTP4daU3OGXyu9HNEqgMyrDRtN86cCKi1CR56tTCZUqHEk6sqV6UUrYuALKKnvq5HXg89NpwkSublj2cLEIVHfOk5upTf9WPhJ/S1Olt0LIJFMZDgh/srQYwyAjlI42L+OWcEk6ic4nsLoi/D/QX0pedbGjy8was/yc4gXI46JpdF/kiCLSRILLAOMtqM3nJvAsHRHars5ZsWJ6PVtw/WcDDYxNACyqmqaBnbFJy57qUbNl2N+x67sX/HBfFnhNeUh4Pd10NT6SqakjaY9PPhAHDBRMbQhVi7Qg/ilO90
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:44 -0800 (PST)
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
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH 08/14] can: m_can: Use u32 for putidx
Date: Wed,  7 Feb 2024 10:32:14 +0100
Message-ID: <20240207093220.2681425-9-msp@baylibre.com>
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

putidx is not an integer normally, it is an unsigned field used in
hardware registers. Use a u32 for it.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b31df3e3ceeb..1b62613f195c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -486,7 +486,7 @@ static void m_can_clean(struct net_device *net)
 	struct m_can_classdev *cdev = netdev_priv(net);
 
 	if (cdev->tx_skb) {
-		int putidx = 0;
+		u32 putidx = 0;
 
 		net->stats.tx_errors++;
 		if (cdev->version > 30)
@@ -1695,12 +1695,12 @@ static int m_can_close(struct net_device *dev)
 	return 0;
 }
 
-static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
+static int m_can_next_echo_skb_occupied(struct net_device *dev, u32 putidx)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	/*get wrap around for loopback skb index */
 	unsigned int wrap = cdev->can.echo_skb_max;
-	int next_idx;
+	u32 next_idx;
 
 	/* calculate next index */
 	next_idx = (++putidx >= wrap ? 0 : putidx);
@@ -1719,7 +1719,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	u32 cccr, fdflags;
 	u32 txfqs;
 	int err;
-	int putidx;
+	u32 putidx;
 
 	cdev->tx_skb = NULL;
 
-- 
2.43.0


