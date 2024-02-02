Return-Path: <linux-kernel+bounces-49487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 422D8846B01
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED131F21253
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC08629EA;
	Fri,  2 Feb 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="iTrYRCMS"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E461682
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863325; cv=none; b=uSv+R41hE+Olr6iV9KHHYyEWEqB8XHuGgbYVJnXHzJg1oAi+q6UamOoEwUYsOOmmoCnzNiHoAvBauLpYGHe0nQlnFRaTHs0SpjAjbFAHTPsEsvY/jiwViLqnKSk26J9Ccdvy/hak7c02tzWDSYKwihJcU1T8gYDA8tE0TKEnvGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863325; c=relaxed/simple;
	bh=F0bxqF2Bs1iyl0FY+5Twbfa3UZ4Z4U0JEOAmmYMmU2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AHU08NCZ/d3/ddW9Sq7EfsFLWYwZt32/A4x1NRW5aKRSIvfy/tfOx3tp+qcwhEJKKRbP5ESr12NpQVIFosOUTQgNqCnmfijwuz+xc0WweiniQraQw1iEhncXH7VTtJi/zlkUo6MClj5h4w9Zzugl9xy6TOfAn+XlUCcmNmKWKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=iTrYRCMS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so2515529a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706863322; x=1707468122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWxwGazwGxFm9RJ3W3AXRBZkyy08qk5mh8Ekn6FcMvw=;
        b=iTrYRCMSSkiXyJdzcEt3hWjfSwR4K1sVnyUGiif+4ReaDaxWlBm8HBC1EaLIp4X7ED
         NfNjUTNBViaIR2CfYyPFLPQ1Xr7ezt+YOwQaZAYZo/dccYskzQpGBBKH5ULtZwY3rNFm
         OLwvk8qP01pclstTdB/lEqR1es887YdounYZYrkjnua9JqRGDR0QDKrv1HTH0skSgJXi
         bLB/uJbTussSEqiiaocjcl33JdCl3jk1PbSQZQD/zigf+doMYp8hflUrpf/FKPcyYh2S
         VSN4/AQICK0T0v2MSdSpmHQDnHZR4qk9YG2x4bT5wmfm7qDolTaaPgi1WKVN6Pi1RiIt
         +dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863322; x=1707468122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWxwGazwGxFm9RJ3W3AXRBZkyy08qk5mh8Ekn6FcMvw=;
        b=G6YOOJPNFDQITVNNdpgVGzN6dHK4UrbPz+TZtIoP0c69cejESe3TwgMEsrU5oasw0N
         buYpssgrWrUbi45OTOrG6d9sUC6swvSXzThmhyjFVJMDAWIiU/HFi8MaAYEjgegxfhEN
         WiPuZBEOp4x98CvfBtwtzIOJQ7ZOfpvnL9EaPUkC+x8I+cBAtwGTyToSwFiCSUZn8gpk
         XEa08E1R4BVtjfR9mPHl7/TcTUXElC52Nb120j1XROkGDiV3EtKK4/wZahcTkuTSgtWe
         Wu5WT5ACzUU5iQsznIu/+6LbCLvMYW7+JYsR1GWJA3L11yyMG+azDw1zzF0KOd0+ks/n
         jl6g==
X-Gm-Message-State: AOJu0YxBES/jeE1dHk7GoV5sl7b8R6zcYTB2ZMqxQq3ZvW7R61VS/7VT
	xbh2DdaaN9xeKVSSwO4pTKwpXF6h68qNfcv+WNpDopwRE4MX1Lu9+lh/FN21Ozs=
X-Google-Smtp-Source: AGHT+IEfVsf2BVBIztAwkZyOv2y5pbCiGTnjLxqvG+uO5Y9meerLsa0ZMPZjfKW20FVajQTgjWP2gA==
X-Received: by 2002:a17:906:6d4c:b0:a35:6a40:b4cf with SMTP id a12-20020a1709066d4c00b00a356a40b4cfmr4641441ejt.19.1706863322413;
        Fri, 02 Feb 2024 00:42:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXwxLgk/J7vwLpbCP7gKuXZjoVSAZe65SJRtwC1O+341OqzcHNX4l3ZibHNNcJ4kz8EK8gIai+Yp5IFQocAWclZpoHZvagaDP9K11bH37oSTrJHzujj0z3mxShLgq1n36O9Xcmr7U/Jz2Dq5rG/WM8zA3ap7EvObKDt+YXP70HiRCTeQPavPnsHxzLPkuooGpi7YqqTiF27rWP9UmwbgO00k7WTZnw3TCjFERqEGd1mlaRVfbim8NHE/9+jnUY0TTOuMw1mmVpHafbKCeYu35vlf+JPmt6se7d74nu3pP7iaWvm383nS8b4MCks01liCufnbG9YcXFEuXRn0EM5QO0/xgiRPjvinkTTnhtQVtHiLoW/6MjwUsNFAt66VQXxVJhmkO903jblheQfkw==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b00a361c1375absm631642ejc.133.2024.02.02.00.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:42:01 -0800 (PST)
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
Subject: [PATCH net-next v6 06/15] net: ravb: Assert/de-assert reset on suspend/resume
Date: Fri,  2 Feb 2024 10:41:27 +0200
Message-Id: <20240202084136.3426492-7-claudiu.beznea.uj@bp.renesas.com>
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

RZ/G3S can go to deep sleep states where power to most of the SoC parts is
off. When resuming from such a state, the Ethernet controller needs to be
reinitialized. De-asserting the reset signal for it should also be done.
Thus, add reset assert/de-assert on suspend/resume functions.

On the resume function, the de-assert was not reverted in case of failures
to give the user a chance to restore the interface (e.g., bringing down/up
the interface) in case suspend/resume failed.

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
- collected tags

Changes in v2:
- fixed typos in patch description and subject
- on ravb_suspend() assert the reset signal in case interface is down;
  due to this the Sergey's Rb tag was left aside in this version
  
  
 drivers/net/ethernet/renesas/ravb_main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c05d4a2664eb..c2b65bdad13c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2978,7 +2978,7 @@ static int ravb_suspend(struct device *dev)
 	int ret;
 
 	if (!netif_running(ndev))
-		return 0;
+		goto reset_assert;
 
 	netif_device_detach(ndev);
 
@@ -2990,7 +2990,11 @@ static int ravb_suspend(struct device *dev)
 	if (priv->info->ccc_gac)
 		ravb_ptp_stop(ndev);
 
-	return ret;
+	if (priv->wol_enabled)
+		return ret;
+
+reset_assert:
+	return reset_control_assert(priv->rstc);
 }
 
 static int ravb_resume(struct device *dev)
@@ -2998,7 +3002,11 @@ static int ravb_resume(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	int ret = 0;
+	int ret;
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
 
 	/* If WoL is enabled set reset mode to rearm the WoL logic */
 	if (priv->wol_enabled) {
-- 
2.39.2


