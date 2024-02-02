Return-Path: <linux-kernel+bounces-49482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC407846AEF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8AE1F21946
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD85FEFD;
	Fri,  2 Feb 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="T85UdcKD"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207375FB8A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863314; cv=none; b=kjPniaT2y08Jx6J4sN6cA9i6iX6lN5JIVGRrBHbiVs1vaXAQQbI9rbQ9XjmsKFpSsL203lCA+Atq57HhGOm0y6gBtJdYmnGKMjFPiXq5WPs7OXC50zyb+V2AuD/0grATG+IsrYiBw1qnHj4fPjon1C5DSPF2B1ri2vk/YSH8STs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863314; c=relaxed/simple;
	bh=wUt008c4L4wlWChR09y86kFZe0k8vYYcMrzbja33YqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IIrPl/cnzZL+ko+auncCDqXi1YY3VyWLmmkvMiqI1zCBoA45AwKM++DC5QemVC3L/0hbKrBZMCHdOC09M/eg6/M7YIj4qsn5htwmJKIcI3xpTdY9pcDr5Uvh88NtXthqElCDHMwfc4H1sIarSW1Y8ZU2bOWQGvCxCzwnKrmrPD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=T85UdcKD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a370315191dso50604466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706863311; x=1707468111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE3Yoz85yiYAVvN91TcvWq86ovnNeno6HjqJQHeUHx8=;
        b=T85UdcKD+8vJ8yixlQP8Th3sYh7/jVZr5hLj/LkoAtEwgE8bgvNNL/vaatvbCbEGmQ
         BFJxT2Gu4t9nD56jnWHH/RaIHkVAAD9JU6B+2MQPCYPZo2sTXaZ8pBUGwaLXmExHYYCI
         JseBEL5hUab7c85530ethYFHH+spLePbz8rVm+XsaIQUcjnMPDXxa3FARPtjEBYR2fxK
         6dGFA4daOVZhaI/OIfxMxYD7eajP/2/hTAuR3laMeUTInpd6QYvR76nzSLf8C17s12zL
         +7s1YhTJb2eR0LNG84GoXvvDzx6hOlHhnYHIYgorSD9v+sbp+RV5XgzxCOGbSOcWOH9E
         o7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863311; x=1707468111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE3Yoz85yiYAVvN91TcvWq86ovnNeno6HjqJQHeUHx8=;
        b=Kmoj5H8blmafTj1qtmLldmJrZEOSafX6V507m0ECTXXeRQvzfdc0pJkN3/1LqdtFIJ
         6IZALbl4IS68tQ1mUbN6UbeHZgc0IkCHo0yE67LJknStmi71fMeMUEbIMwGleVCEeI79
         +KBxVOdMD5vjwfMDNDC60JCZYmdbAjMbLXCAgI/YtKS4MjnWyjJLzGITrpLBTIlkUWRb
         PSpbKbZwuI/34NIabkUQCrgX5l5dyU25KhGhB+Ai+nSEvu9H318nrJzx7U10mmk55tBW
         XkXG4SGO0xJBOKiSFK/0JgqtRZEUXRdN8WAyg7PXzAhuBFlMouEOXA0oPC5eSslGmzNv
         EyGw==
X-Gm-Message-State: AOJu0Ywk5yUhaL6U9/Auc4KGn2hzPqhSI/CIAtfTA6Yx8yCYSbXxsOPR
	9D4aWKiK9oCfH9YmsMmuJk+8TFubV0y6cR6k3PAsZV2o6zusPexszheEMDF1vxE=
X-Google-Smtp-Source: AGHT+IF8povdNsKSI35kMnRnKqE2z3dt93rHDNgUs8u51yEI5gUvxpyTHQLAX54KHZPCyKsMbiR06g==
X-Received: by 2002:a17:906:22d6:b0:a36:c845:86c2 with SMTP id q22-20020a17090622d600b00a36c84586c2mr2526641eja.51.1706863311112;
        Fri, 02 Feb 2024 00:41:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVeHQOh1G4LEVqjRkdvhRLVQzvENNq8LEhYiaIEyOycmk6CK1qYr9CNCrw6JOSTKXDnRw7lhb3ZTxKz8YA1cXWMnRvkNmkg10Bt5RyibQC1y2zJU11WEfStrcBcEEGL8UtSoKe685JjVbgobn5LanbWnA4cEeaLaL3Zb5HW+seY/3//isEubEGzfGZcCXX9bklqZQIHkBOOf7CgMNAdEqY13g5kyRYXgGTqnZV+RWN8xwNTCUwjVtjhpJOefzVO4bvFRWVT9DpvLJHhpZwa6uqruQEi78RWk2MHFRlCQ5xHmnh32qump0pIAvxyzkvwTWEMO52FWMIMKHc/eJfeLaY6P04ifPqXduXRv51ZiZhfDTT2rv6GGXBT5YCz7fW1TZ8Ehave8b7V2OOJHw==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b00a361c1375absm631642ejc.133.2024.02.02.00.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:41:50 -0800 (PST)
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
Subject: [PATCH net-next v6 01/15] net: ravb: Let IP-specific receive function to interrogate descriptors
Date: Fri,  2 Feb 2024 10:41:22 +0200
Message-Id: <20240202084136.3426492-2-claudiu.beznea.uj@bp.renesas.com>
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

ravb_poll() initial code used to interrogate the first descriptor of the
RX queue in case gPTP is false to determine if ravb_rx() should be called.
This is done for non-gPTP IPs. For gPTP IPs the driver PTP-specific
information was used to determine if receive function should be called. As
every IP has its own receive function that interrogates the RX descriptors
list in the same way the ravb_poll() was doing there is no need to double
check this in ravb_poll(). Removing the code from ravb_poll() leads to a
cleaner code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v6:
- re-arranged the tags as my b4 am/shazam placed the Rb tags
  before author's Sob tag

Changes in v5:
- none

Changes in v4:
 - none
 
Changes in v3:
- collected Sergey's tag

Changes in v2:
- addressed review comments and keep stale code out of this patch

 drivers/net/ethernet/renesas/ravb_main.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0e3731f50fc2..d371c4bed634 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1288,25 +1288,16 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	struct net_device *ndev = napi->dev;
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	bool gptp = info->gptp || info->ccc_gac;
-	struct ravb_rx_desc *desc;
 	unsigned long flags;
 	int q = napi - priv->napi;
 	int mask = BIT(q);
 	int quota = budget;
-	unsigned int entry;
 
-	if (!gptp) {
-		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->gbeth_rx_ring[entry];
-	}
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	if (gptp || desc->die_dt != DT_FEMPTY) {
-		if (ravb_rx(ndev, &quota, q))
-			goto out;
-	}
+	if (ravb_rx(ndev, &quota, q))
+		goto out;
 
 	/* Processing TX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
-- 
2.39.2


