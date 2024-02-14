Return-Path: <linux-kernel+bounces-65306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0852854AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBA21C22177
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AE058208;
	Wed, 14 Feb 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZI2P9KWM"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB2155E40
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919131; cv=none; b=Be/ToCv/SmFCui1o5KVvxr1/uKj4HIJ6L2xaECjCjcc9g9NVLjFuS/P4cF/tjXnuBKfqhY6630akc9pxuP0qEiCEdh4dyaiGPo7crfNkkaochGcSA4KoJLgWeOqRR9gZfW6fsQL+JKf2IoIeXkEw7M4gRwFhfXIHz/Kdf4RnL4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919131; c=relaxed/simple;
	bh=FjpT7HYwfIhvnqp4YHdZLJltiMOVfPS1cPTRRdMvPpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKC3zi4mBDz4FCfLDcUkZbqEO+P5aRmDQCzapNDdn5Yv/5EQxltDUWGXf/PEoCbj9EVJsgAahjlAYLRljxBFZUCunnl/qW/6eI4OyveWOxqCLK2s5C/5qMsXcUGD+8XLQQCqKMYEea6i9jyuOncwGDlG3fu3OjpdpVnkHY5/daQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZI2P9KWM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b2960ff60so485993f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707919128; x=1708523928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNOxk7ObMlNCb9z7bNPG/kiAHGWviZsSjwr9QNQkzTs=;
        b=ZI2P9KWM/nrONJ9toyahqSKqaKH3K3EHbiCBTl14drdBlIcdCbzfcZBs4l7LNcMp3L
         +0TZKoWidLpJaT1BBYgjgyXbFMVIVpzQLOjf5X+miC8z/TCOUGZyyAHF+zQFMjC5bgS6
         khbCpdNTWKy/gstAPW6AakaV3/1tCRcZU1LzJgN0S+ljPYSFzMjixoJnKLH6EXAN0MsB
         3B87yBQ1+5Uzq+CzjLkXcChqv4/sOHR711p9w0eboKMTVqkuA6i2pAbA1HcOk9Vs46oK
         Wbq6qaS295u9tOKL1cAfL7MFlgMqDnj7gvE6p6G+XAozNbeLcUAgthtojYUk6qk0c/Aw
         uksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919128; x=1708523928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNOxk7ObMlNCb9z7bNPG/kiAHGWviZsSjwr9QNQkzTs=;
        b=V5SrYWXY1Wkf/mNZogK0fixTCzWtjGWAG6j+Xyae0kWbFFXlZidI92UEmdxwQcXd6N
         k94aaavQINvCU7Lyj6Ta/VigR1AxTb4vxNrIZRrt/0HeBotwtMxcmCfx8zG4dnQY8Vd0
         IAY3teXJJjpvZKU4S9m5pzOzR/Z57BxO8cbipLLFMzNc9/lZkdcX+gW1SbEKCb6mPq/6
         3Oav8Z0MYh0exYH3hk5McRQ8Ktv3RjoESzLLsC4rupQoAnQB/K8HGThG6T83dykup0k1
         X1w3DBl75jdBGXmDo4pERmiluAV0PUId8R2MapGOgyHNmSgm08bGbLFT1uaw7LigM6R/
         PJYg==
X-Forwarded-Encrypted: i=1; AJvYcCVYk+/qrQNzI1HmD4qyueR5zPTUkRt0O2R1wQec8LPnQVtbm/BP+i6SI6je45F+WDaarkALPoFYv/7X9VkFvJXTfrdIFJfUvMDvJye+
X-Gm-Message-State: AOJu0Yz9CmTGyKPHEa6Wx7tKYaMY8B7s8r0K5nDvTCkrleK20+ebXCEK
	0AkqA+rSqLV9qb/8Iq7+vtwt1Ycgt1NbhMvxL+M+vSBqjGZdn6cA70s3Q944uMA=
X-Google-Smtp-Source: AGHT+IHK7iuy1qy6aGSYk+qSKN6o73sTYMtUh76iYC0dJvzAJbqMyr2Rgb+brY7G3+I0wM1w/gzVVA==
X-Received: by 2002:adf:ea8d:0:b0:33c:f29a:30ec with SMTP id s13-20020adfea8d000000b0033cf29a30ecmr911894wrm.25.1707919127685;
        Wed, 14 Feb 2024 05:58:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyOQ5GbcNIQ6rfjuLwMp8PqwHzicVvuuJ7S+f4wLP/0H/l8QubsaFrXRCoDnuP/8vwZAHZe0RD1Kvqm7bMILuvkso5XDDEL5Qf8B+OIYFuVakb3Yc426JUGj+ikTFZsmspp7WJKyZAnzdg5TmkXXxGkuctdedr6boDsaTxQAonlq6iUZNBs4ZCjnTuCz4kCsrXVXW3S56HM4aomL1329GtwZSwjLEx+8ICsAFIFpJXNNHb1vl60HT2EPRIL0s0GhzL2pt57YXzDXGBNECHF0pejcS45H46VUNocpeplHT65HrnXnvCbjjN2xljnuo5LfaYh7AuT5RaFsCcdkc5W+nXomvM5ljeD1U4tHAYPa/6xmVCSjhS
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id f15-20020adff58f000000b0033cdbebfda7sm4282140wro.14.2024.02.14.05.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:58:47 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	biju.das.jz@bp.renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v4 3/6] net: ravb: Return cached statistics if the interface is down
Date: Wed, 14 Feb 2024 15:57:57 +0200
Message-Id: <20240214135800.2674435-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Return the cached statistics in case the interface is down. There should be
no drawback to this, as cached statistics are updated in ravb_close().

In order to avoid accessing the IP registers while the IP is runtime
suspended pm_runtime_active() check was introduced. The device runtime
PM usage counter has been incremented to avoid disabling the device clocks
while the check is in progress (if any).

The commit prepares the code for the addition of runtime PM support.

Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tag

Changes since [2]:
- use pm_runtime_get_noresume() and pm_runtime_active()

Changes in v3 of [2]:
- this was patch 18/21 in v2
- use ndev->flags & IFF_UP instead of netif_running checks

Changes in v2 of [2]:
- none; this patch is new

[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c81cbd81826e..7a7f743a1fef 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2248,8 +2248,15 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device_stats *nstats, *stats0, *stats1;
+	struct device *dev = &priv->pdev->dev;
 
 	nstats = &ndev->stats;
+
+	pm_runtime_get_noresume(dev);
+
+	if (!pm_runtime_active(dev))
+		goto out_rpm_put;
+
 	stats0 = &priv->stats[RAVB_BE];
 
 	if (info->tx_counters) {
@@ -2291,6 +2298,8 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 		nstats->rx_over_errors += stats1->rx_over_errors;
 	}
 
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return nstats;
 }
 
@@ -2358,6 +2367,9 @@ static int ravb_close(struct net_device *ndev)
 	if (info->nc_queues)
 		ravb_ring_free(ndev, RAVB_NC);
 
+	/* Update statistics. */
+	ravb_get_stats(ndev);
+
 	/* Set reset mode. */
 	return ravb_set_opmode(ndev, CCC_OPC_RESET);
 }
-- 
2.39.2


