Return-Path: <linux-kernel+bounces-63249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97D852CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FA01C2307D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C91524CA;
	Tue, 13 Feb 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mxbfYbLX"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B93D0D4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817308; cv=none; b=uno5tXV5J/tJcYGgj6xf2KvPValb8XuRpwqdIA6QSksFYHAp5Fw4p/MSA/V+jM/mzAoLiQdXPHkJWzBrvYk0/W4+P439yj5/g7OFBP9g9qcg/UGx0VK7MUIP/YWcfT87UWZYM5sH76DX4b+KgpNC1cWl6/Y37o+yjgoCCTmo2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817308; c=relaxed/simple;
	bh=+cx7uCdIjjcdxImi5aLciGuFRrSNN2LcXONA1R9FXrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XcYz1ZVs8vsL4nduNj35A7pAfvgpWuulXCkU+snf8hxkZnOUXhET3DboSlQ5s5h5Fzp/lYrbP43GM7C9lp9+fputpKhfvzqlcdT09FIN8yxlc/20pStgwzJKC8/Px+3plbIKYEfHQ67DUgiYndR6XENUH9sfMlGtlNRGN+GG6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=mxbfYbLX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so4773171fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707817304; x=1708422104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DX0f87HSAsoENN6G92H3MYTw5gEFb3bGk/lETsw33o=;
        b=mxbfYbLXXtNT9LjfEXoo/+BtQu2YTI7bS0BQ3UW207yfiZ0Ts+t8Vg+byrqg6mPtwq
         wden/ywycgIJAAcppIH1G2UC1qTAx19GIdXEBKsVnL88co2oZXjGHh3j6QQ7W1EN1nlp
         cOKqt072aoX82qS8mMTuNoOtQlIySo4fCvbgFSEcAezXXqiyAUmgo4L57Jm2144PKFkF
         fMPBNWmjRuZ8rCZrUrzOKOqxFwK19vFf1nD1OyJV/P7Vfg7YYIlpqhsy20sV9MHCVlj5
         SFujz8+sM/SqRf4c9VsYnekUFuoCa4sitD22/s4rWR3UXvW/75PujdYueAfWa1qucHKx
         Ty9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707817304; x=1708422104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DX0f87HSAsoENN6G92H3MYTw5gEFb3bGk/lETsw33o=;
        b=Ej0LfNb6VprnwwqeLxVV0xgcIVv4fFWzd9CqyLLJoZQswswcvADIbm3C+EjzCM8mE8
         a6LoPIvMCEZcApgX+K29PU4HNQmbQhT76+4AdNqzZsY8PBjFcEZZNk+5RvjMDlJ/zLN6
         8JffFGuKGzghKBLcUdRaDPsKQVkP/7p1gEIJJDgE+4JZyk2sAuWAPYyLd6xTwENO6NHX
         CHadXe/iLLSKfZepeNrAKcBI/mAQ+W90YBQyRjSS6aI1pR3LFf1s35boDYpX5zqI+xBE
         U6hLIYZrq2Lq4vgAPr5f+HtU/HjwBx3hPePMgJNv9JDXmlaTzJ9CGz6pzy6HFxDNzcZI
         I5Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVEtNINQc/pRv1+1YUtzXdGE5sdU8whQ2gKRot7EDhglZLs5mhSJuDcSAQLVvyI5pnGqa96nvUujATaArMceaASkJ0LDh8lHBh9rYct
X-Gm-Message-State: AOJu0Yx7D40BAvUE3R3VwD51yPa7FoSZUWUTaSeavp6rQcrnoP3BZjRd
	Q7qWbvbsNNLdD7EOuDXbSs2UN5NXeDfB9GskmgALPNAG0o9FagOMuWVlc8258Qc=
X-Google-Smtp-Source: AGHT+IG/Pz/dz6Uh1XvDWJg05ZDpCJAukujFAhY/cvu0p48u3JZ4tUXDL9llw3i0QzjsZ+DSNW+SSw==
X-Received: by 2002:a2e:a0c4:0:b0:2d0:9fac:bdf3 with SMTP id f4-20020a2ea0c4000000b002d09facbdf3mr5748134ljm.33.1707817304664;
        Tue, 13 Feb 2024 01:41:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzOvwLfxb6mc5IygbTF21uL/zVxJgyubcSOCZJpBmUb8xYYcieW6D96ISYX1OAhKHVVTGBmLdwDaIz5XEFSvoDrIRkmbiW7tpYV7K9/IHNl2mFR1vfPTnGR5gtwTeTadUy6OycuwwU25zU2v2Q1aVkyBzSAvm54MslEMCbEhFe+46b1WKbejYVyfstHY1+C3L+8QyLBa1G+z77KDCEQruUlTJuU1clswyeHaPx6giwB3ae9RUkU5c0zqDnA/QYL8uLymKjR10eUO0beDY/X2LLtpObTvuqYtiPym4WsevD/U1idNsbhkLWONpI5i+tPBqah8TG8FdzbeyVkevUQCr8CDcXrH7oX8MYp1SGj14XH3Pa+INv
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b00410232ffb2csm11207446wmb.25.2024.02.13.01.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:41:44 -0800 (PST)
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
Subject: [PATCH net-next v3 3/6] net: ravb: Return cached statistics if the interface is down
Date: Tue, 13 Feb 2024 11:41:07 +0200
Message-Id: <20240213094110.853155-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
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


