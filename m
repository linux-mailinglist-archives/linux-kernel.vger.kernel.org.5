Return-Path: <linux-kernel+bounces-49484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF0846AF6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE861F2356A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65BE5FDB5;
	Fri,  2 Feb 2024 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="L6utNQ+u"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A1D5FDDE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863319; cv=none; b=tA+ftwlYHs9SIQCpGN9hGJCqcRNWHNcojAZQjyb4U9xnw+T6UpeypMws/wYNRumUs41h310YPC+HxumELDQl0g5JwCTe5H+MFdn5uvPu03osXTFRR+0rr25tGzJMnJGSpb6a1HKYXhyLnPsVBeY2lxMJhIev5WoKaU53YWMzrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863319; c=relaxed/simple;
	bh=b56D2CY5bgg4QkrVUzroUfj/0+2LJ8RI6nI9KNFOMcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+r77DEu9aGlXtpD5yj1oMB2ZCglWYiOtrZ7arnVK5tKgyysnkEbI3Mv19XTn7ZcfOfdOhlhWPJSjtxyBvJNxBRVi2DSnPAvUwPTVpPmyQis3o+bS7ajl9P21bSV1XzHA0rD28AQTpc5gRFG/ShFjhqU3IW8SszJpc1JBSI65hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=L6utNQ+u; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a35b32bd055so237183666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706863315; x=1707468115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzGt+E15n9CkIZ0b5NiVKi9D2q0/fFc8ybljSM9HrP0=;
        b=L6utNQ+utTtHZ1bk0qxAIouJtFmh7SFKayws8R2qWPQMEsljKB0NJ9I7IYU/kjG359
         12TBxX7EVyJDH4WPBNYCfhKpsc5NVRONP4VezyE3+Q3ihol1Rt8Xlnd6gPx3OesoctEw
         6ok7wAXO7KpFwuLkjEswenn5jz09+K1ddeeE+2lmH9KHG9vrkV9Rr8J67WBks+DEg9yM
         GUyLpnKqnND2IaUuR9Z1y1XNcrBpmKKUGtuP/kYbKR0FXXmHqnCYeVp8uVbTpCPwRmWi
         AJYfsKsOv5FQSVrNkG2c7dOccLlXzXjgWSkr+dgxSsZXTZD2BAbDZwTq86W+raOPz58Q
         9Dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863315; x=1707468115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzGt+E15n9CkIZ0b5NiVKi9D2q0/fFc8ybljSM9HrP0=;
        b=XWNWTHADGI4sH1QgYZ302MkX//C4XainRnjlAqVC7c3GFtKgbnHj85Ii/yK7CorJKs
         GzvLVxZJVBeFnlwL6LNDsHBYm/S/IsSUUOfxbHpDC1YPoosAZp2BIvMNfqxXFTfoW/Rk
         c5ivDtkWFzITq2gJBT5yY8WWgIPAYcxFnS7qV8M5XNoUY+1XP7c2rvO3pq7kc41fTly/
         ItWCNpB6F1tN8qTrPQ3T/hVXqheKdEpB1qpSGmeeTwVLQiSkMhzr9kbzy4H1gZ1qUB+m
         /Mxc8tGQ6DLMoEexJEyvjzgps1QN8V3Z8fwEQKmrRtakyMOyC/FUfuR6bmsfFFTE26DY
         XdyQ==
X-Gm-Message-State: AOJu0YyPAyKekFT3mAqPWbRgA1ixfIn6Z2CElaxqXN0JmaiNo5kyv7Es
	pD6jb/UwJle6/X399ksOiBCANceO2ytjDuhjsAzW0tgk3cgsHSrMf57dtaxqCRs=
X-Google-Smtp-Source: AGHT+IE/pWJ574ClsrBeTk7aSvxb2/16S2ptiIy1yUNi6iNmqVmV3gn75wwbIVLVtrT+d481lsT/jw==
X-Received: by 2002:a17:907:86a3:b0:a31:8b26:47ee with SMTP id qa35-20020a17090786a300b00a318b2647eemr1334170ejc.55.1706863315094;
        Fri, 02 Feb 2024 00:41:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWAqdCcHyQcWt8vvzEoffySZ6yJH3Lr1cgLPpEFkCZo7AA50MSHHvBLXjml76UBdsAwtcsz8MZ44TC3Z670P+HueNHtoFI4O5I8eRgQqFWAh53lHtohU1yz9uQmCdbbBqTY3HcQm6yJeCgrP1EI0S0LVc7u55iTIZONqU8Z8BwO5vcSF+GLI4Xs9WXsynqGq6BoOfMo2FaF48kNejkzz43DqSso7rUIVabixSi5nQK+YljHsTaEyrGLsSqoHeMBKtzVSnrpFlPj9spNeQ3kLA+SAWMCHZcnUqBeZlVVC0F8xXQ+Ez4YSKwIY5galpiKeJc1dMlPtiWJtYYea9Mxf0WOgwxn1d1eEl6VW9SkNkEtsWdMGjCjZhyl8b92rlKL+SMrYrijTj2yZMZM3Q==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b00a361c1375absm631642ejc.133.2024.02.02.00.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:41:54 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v6 03/15] net: ravb: Make reset controller support mandatory
Date: Fri,  2 Feb 2024 10:41:24 +0200
Message-Id: <20240202084136.3426492-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On the RZ/G3S SoC the reset controller is mandatory for the IP to work.
The device tree binding documentation for the ravb driver specifies that
the resets are mandatory. Based on this, make the resets mandatory also in
driver for all ravb devices.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v6:
- re-arranged the tags as my b4 am/shazam placed the Rb tags
  before author's Sob tag

Change in v5:
- none

Changes in v4:
- select RESET_CONTROLLER
- dropped Geert Rb as I changed the patch again according to his
  indication
  
Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/net/ethernet/renesas/Kconfig     | 1 +
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/Kconfig b/drivers/net/ethernet/renesas/Kconfig
index d6136fe5c206..b03fae7a0f72 100644
--- a/drivers/net/ethernet/renesas/Kconfig
+++ b/drivers/net/ethernet/renesas/Kconfig
@@ -34,6 +34,7 @@ config RAVB
 	select MII
 	select MDIO_BITBANG
 	select PHYLIB
+	select RESET_CONTROLLER
 	help
 	  Renesas Ethernet AVB device driver.
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 3181fa73aa32..fd431f1a0b98 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2645,7 +2645,7 @@ static int ravb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
-- 
2.39.2


