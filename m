Return-Path: <linux-kernel+bounces-56212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE484C768
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9ADFB21B99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF802420B;
	Wed,  7 Feb 2024 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TdrbNqjo"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53FE21A02
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298360; cv=none; b=FBzNLQBOcIE7vPlkXGL7JHfwyvdVZcNtaaC/N3vllRjTVugPUc8ggWHsOx4RO6FBMieqsNkPdFZGeqTlxR9tlTHLaqNZl+k/ePqkmtWqc3sPz/F8vQmDhS9Wj7yRpotZO4u8ErwRRaUpMq40tuKuUIY1La1MIzHqYFDmPZbWN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298360; c=relaxed/simple;
	bh=xKm31x/RdzKjtmNCaQqPULxnB/TjUDs1QrTh8HGx5EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKredWALZEIVf6C7P2QH2okkeKiWIu4EAGqbvpy8W098YJiJtYmVD+OFCjojG4+x4sLv9kyQmKLAS/OZKA0zuHfVWvPzK88zPn76Ycp9d0xqB9/jKUmsVflAevKaCUkoFp1qe9C0SV+HsKRVLmZODJDWdudeYVt3TlzhBj9Zkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TdrbNqjo; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a38392b9917so53008066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298357; x=1707903157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LasvPwar56cmUGpfIKyPUkfrzO6sViDcJ1By12B3aI=;
        b=TdrbNqjoU8Yir8KxBgsArNv812ClYWoEpIDK23B/C1otESJlUk0xFXAiHoo9jq8tpE
         nwSgYICUqETyzL9Qba3+f0golCnAm4JN4zKzmOAj3SOTgfJ7iH7x93r6phKs+UmcSzlL
         pWWC4Pz/S1Hnmmqm319Rv9sbydx0/U0Zp15xparAUcBiOqX2r+cb6sF9TRYsvIxQPEjU
         wg1838KOI9oDdl+KqxQdE3uaDmb74D98L4NkLCIora6b2Bv1zVXksaeL29yFRhZVnEYm
         w02PAtF6y7mumpdbPW5WbwVjo5QcO6TW3znapHb/fNnKjJC9JzFF6hlmjpZrR5zWSJNK
         l1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298357; x=1707903157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LasvPwar56cmUGpfIKyPUkfrzO6sViDcJ1By12B3aI=;
        b=f4tMEFyXYpE+xFH2gNVDujaNLHqUVjPUtmawNyt5ms6ck5VjY2BVi2YbiscLc0Wgrb
         ErfAS8lNIWqRVTwRrtoOAPNVn+i1nsQfDCCq8aUc78nuzP0yyGiKQaPEZvz33aOV6Tnf
         cCOeSNyfrO8eXJLC+QPNvnPVk1i60tRnAgJpR0gHh3IRUHEiTjO3UlRjfT3azjRzhagG
         7XYv+HfTnc1lL8ZlGZ0xvNuM9WmnwOVJrbyQtLrwJWOs8UGKwS7tPRNxlgzNZ42TN3Kb
         QdB7nM0u9lH1gEuHVD0g9p9J0XWaUItQHRYNlXjhyXXVUuitjNhRjfeTFiyjCYKD6lr3
         39Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVXhOXrRXJtJxV6cPVEryfn2L5Ns01yNgm+ZcPTiW5Nln/WOgwiySccWkyIIpPUjsybwKjjTWLnRwlh5NLxat4poOE+jJOaUqOOuSNI
X-Gm-Message-State: AOJu0YzLGXfVt3u8lTkVDtUjI9/2H9EV9QSnBTYngtwCzYc4JtD0zq2s
	tHN1jRdBPAu1cWP1X07QKpdNdUer72gpqYZoMZ1wWVydhKWKjGZ3cnrOVVlG/mQ=
X-Google-Smtp-Source: AGHT+IG55kdXvi0Z3Md9f2xm4G+MpDcJ9YEr11th4GSz59Inm4lWKUV4obYPl13NUgY9aDhqLtE71Q==
X-Received: by 2002:a17:906:acd:b0:a37:adee:509f with SMTP id z13-20020a1709060acd00b00a37adee509fmr4053526ejf.12.1707298357175;
        Wed, 07 Feb 2024 01:32:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVV6M49yfwmeZao0z9NZWCWgW1TbgNa9mmQo6YeMWH9S0oRB9l+W1LMKezrhQ/zib0uQlUqM+EJvPKLgwl62uSN0iQv1PIOSm+FeRGbIl7byM379mIHHy257MhqVjBVCBWSjLFYK+PBQK0NuxSLnJOHeur/CoWcQgOJ/04UB70kG8RnIW/Lp5XA06XAquEt/vTR4LUClb178PP0kmttpBvAQ59veDHJcvyUMZR7BIv5esU3HyGrT93W/UjaTvMvhVZjklUirn8GVjraVcRZNUVFapW+K1z7s5+8YdOd5uU1yxgZx8OIL2kn7wPRA9tIWyozB3xeXuN5QG7Rfg+71oxuNimp1e+y/ZzGQBqK0iW5QwfQcfcUxaNv9ZLxuanTum/C1w6ZD9vbiqz66rFdVxkbGXFUuvzqXIi7jujxutIXsghjXnzNc7T2w8IK
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:36 -0800 (PST)
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
Subject: [PATCH 02/14] can: m_can: Move hrtimer init to m_can_class_register
Date: Wed,  7 Feb 2024 10:32:08 +0100
Message-ID: <20240207093220.2681425-3-msp@baylibre.com>
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

The hrtimer_init() is called in m_can_plat_probe() and the hrtimer
function is set in m_can_class_register(). For readability it is better
to keep these two together in m_can_class_register().

Cc: Judith Mendez <jm@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c          | 6 +++++-
 drivers/net/can/m_can/m_can_platform.c | 4 ----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2395b1225cc8..45391492339e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2070,8 +2070,12 @@ int m_can_class_register(struct m_can_classdev *cdev)
 			goto clk_disable;
 	}
 
-	if (!cdev->net->irq)
+	if (!cdev->net->irq) {
+		dev_dbg(cdev->dev, "Polling enabled, initialize hrtimer");
+		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL_PINNED);
 		cdev->hrtimer.function = &hrtimer_callback;
+	}
 
 	ret = m_can_dev_setup(cdev);
 	if (ret)
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index cdb28d6a092c..ab1b8211a61c 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -109,10 +109,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
 			ret = irq;
 			goto probe_fail;
 		}
-	} else {
-		dev_dbg(mcan_class->dev, "Polling enabled, initialize hrtimer");
-		hrtimer_init(&mcan_class->hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_PINNED);
 	}
 
 	/* message ram could be shared */
-- 
2.43.0


