Return-Path: <linux-kernel+bounces-35296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD2B838F29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2F6290790
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD1760271;
	Tue, 23 Jan 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="drS1tNZV"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306805FEFA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014782; cv=none; b=hQEJEx9ADKfcC4hgEJ3p3tdqwFoL8BHVNGMmR/XN9SuGijUZSO3iYzL0YlH8ZD6rT7MfT/gntRaD8Vp2A10F4ikqti8615FOqCoiHEba/Z26s0UaItwvH20ompuAQF+jD5sV6sntKVqoCEhYAkHLRVIkCA+vI08KQkkmcmYRDvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014782; c=relaxed/simple;
	bh=maodbjEw57TfdCtC7UkPQKmKKIQeLpeD2PctYOEaXpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nR+XN8kZOUtrjChtZ3Xlx6Ygu8eiImGvZbHQXkLhedWqjS+UQRcuOAlqaTWudrMdw+/qglCMF+tM62zNMg15gjkm4AcSdsEWL5Bk1ZdnDJIK0OOIwojwNsZOtYvPri3omXDxF4gHguKhmm5ORoLWyYxwfiY5zU1q7m7wGLN8B4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=drS1tNZV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-339237092dcso3044062f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706014779; x=1706619579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+pLMq6Khs7mZ9vOVBT9kJiU7zBTpG072yfzErDcfPw=;
        b=drS1tNZVIuCCH4tV9zJzSo58YS2sEo4n+Vu81sJB38JjonhBBFcT1zbmWXOuoXP/wb
         bPiWNIuVssAVaEWkLPkcWUcAM/gXzvJxtlhxCzgQha+B7mwUTetfZezzqhH77C68oGHP
         OTZguPt566OH6cHI7cB1TEYmOo5MFcrpxN9EZeR9OwebUG+bdWwlLC8JCfErXN5Y0cck
         ZmaIsFt/ewMoZkXp1LkM0bPwGTf/qBTXX7c+RKkakUkvZdgXrRb6p3d7bWkQxxvgu/Ke
         GZN8DfPM+TJ78OTEeV6UjiFQPRCZcEizhtYyYOPXAXw2MHa/q39NdsC4uOxvWElF2r26
         4VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014779; x=1706619579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+pLMq6Khs7mZ9vOVBT9kJiU7zBTpG072yfzErDcfPw=;
        b=eHNdf7AofLLRP60gcLPNZKiy2/K+Gx8dOqUtFy8sehdOJDnMGnok9BZ7KcgD72WPqm
         4/fOMsvyqDGXa1HcWYlAuPN+HnLS8UBndz6QLdksNXSqAlsXN1Laktd0YQL1KS60g/Wh
         biOGWiXpauOGB0UUjCq4601e9qQDA+BuxBZTUoKqsDK+NHyCXZYN5kjoMhgQ2lnkvg2j
         FRoZlT3XQ1DtmTc7XIyx58lVDOhHdwyPytkidcsjMs1OJJl4fqRXNHqlAIAD3CrUjFse
         73Eo2UrCkzEQumCZywb3F6gxabOe5Inkbvr6qyDSGLC8MfYHKIEPpxMp8Rp3NApWJeCr
         rWug==
X-Gm-Message-State: AOJu0Yxr0roEBbhrJqUXwpbq44k10hgSxUnbsolCY6U8Fcue22KC2F1J
	knApky8wA/BlM7lWsnJyw4j0Pfwupl2q+s0WrzUDUIDgM9FhT6CkfQ4S4mo70w8=
X-Google-Smtp-Source: AGHT+IElcyDJaakwQLs2lAr/rjSThcC/QYwKjl93ZAqd3m1IKmGJcHbJzlyKdBOTnbGFUBA0QeFuRg==
X-Received: by 2002:a05:600c:808e:b0:40e:62aa:88dc with SMTP id ew14-20020a05600c808e00b0040e62aa88dcmr111549wmb.127.1706014779609;
        Tue, 23 Jan 2024 04:59:39 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id s4-20020a05600c45c400b0040e6ff60057sm33655711wmo.48.2024.01.23.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:59:39 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v4 06/15] net: ravb: Assert/de-assert reset on suspend/resume
Date: Tue, 23 Jan 2024 14:58:20 +0200
Message-Id: <20240123125829.3970325-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
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

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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
index 0a27d2741e8d..9fc0e39e33c2 100644
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


