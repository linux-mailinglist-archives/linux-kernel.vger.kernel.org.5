Return-Path: <linux-kernel+bounces-65309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E98854AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A681C2171A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9759B46;
	Wed, 14 Feb 2024 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MqYS4Ijb"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF185813A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919133; cv=none; b=Xo7nrMHqYb2p2huyfIPqAgm1nxqg3yWVpRF/AgbuX8qZ8IOgQfFv16b6G+QJTTPLAjqr+XKOmS7eOkuyCE15E8EEjq9INpGPWZ+mq4TXea7pKRJth2QFiq3689zM1X/+OWw3KsPLLSg0Tuqt9I1k1G6JadrvGvj0t8jTymVHSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919133; c=relaxed/simple;
	bh=rcPnG5KBmIB3G2fdjvqQyKleIdh/hUEQXg7DZEDQHKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRalqDbKyygtZqP7zDsFEPJ/VA0N3+HyUEk7h+kudnM3FnDKlhdKJjyytrgeA4BywbqkwLL2ow18tMQ/M74mLCk2MU4CCXh0Fc0fdQ3UybzSKuNfhignwLCU8Lsm0L+A78TwolKTVuqJJS0AEcKoGi1PE64Y3kwl2fWJtLiy8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MqYS4Ijb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b66a7f859so2165985f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707919130; x=1708523930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUpbsmqd6qgdpA6pLSTrT7SxbTG5IveZrPaHGowSSOA=;
        b=MqYS4IjbfWEb8jRHuHI3wSkWZbM/ok8qD0atTWnExWJnZv7x/R2C+QQIUEtf43hXD7
         iOb3G/shRdiQQpj/kJEihSrYv3pN0UhMOJEgSdlAF06XvlwOM/PEkNAqa1X5eK/AF29Z
         gnKDkmtxssOB3b8VPmU/+nGXyW6vvaqTLTeqFFqKE1xf8K3MnbT7gVaV/U6LJhNOt0SY
         8+eHeZncN+HtUs1ZPpMvzLtNG8oMLZX0L20QJKYPHl1GNslxBu2kieg9nofr+4EKCccg
         tWZAy89pfGxKU81vuDbYp2cMlIknIwTVtMJ+fXGFIwtFzaU4tI6exYGag+kBsksdAp+U
         FVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919130; x=1708523930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUpbsmqd6qgdpA6pLSTrT7SxbTG5IveZrPaHGowSSOA=;
        b=b3qsbOP2HBAuuQYBKLni346cxN8oSt21SQQWGDD+fQ3ogC6NFQaT7gfrGuat6sF6tF
         YRAMba1OjiP/Tyx9HmjIY08jTM3wCkRskuxUnklGVZjJ968A9es4d8iGTrS3GQCCoXzn
         2vUgLDB1U6Bvj997GnOzB6cOhBh1VEMCQpmBCTMFUVLu0UYK2GhefLdhzeYVMGAsDmuK
         Op6P4xL1yOzm2ZwUgUp2VnRcmnD2vUqj9aeKPCTzH5YmFh2pr/plwxc4ltkt3ZdrFd1l
         9BrffLgnSaAJne1XWKYfv0mbT3UIeQkkiJiEEdMXicqGKTXtf3Y+UUJBBIP6lsU0oqUN
         mYlg==
X-Forwarded-Encrypted: i=1; AJvYcCVqq9vrHIOmm9VbGH4QLbp/FaoleXaew9nSFtQum5+nUgjLX/OrFLjv53LuXa65EMJAy4tqlDgYDvUN37q1OSTnxvn3AQhQBc8M7p+s
X-Gm-Message-State: AOJu0YzWd8bPF9LNLt8+aAlv84Z8qerEtzYgshZ5z+cnz+HyyIqvIQk8
	lhzmQzTx7D9upHN1xr3O9ubvSy5g8rzlj2KVBkJfo1MjCydpHe98Zycn2eId7LE=
X-Google-Smtp-Source: AGHT+IE/6fQ4te5HlXdAOPn/bIV62FpzVqhYUoxEsHgbh6FfbDRDVInPNvw9FWgWNlyU5DYewxn1Jg==
X-Received: by 2002:adf:d1e6:0:b0:33c:ee7c:c433 with SMTP id g6-20020adfd1e6000000b0033cee7cc433mr1602489wrd.22.1707919130208;
        Wed, 14 Feb 2024 05:58:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2GDfa5HsntXhjNa5oc85h5mHyVdzd1lkbvs0rAtM9EkIBcdVPip7bn6ioIOM4tjncSIsfAFbFUrbWizDwBOpXrJ9jSCfsXC3Qq+hRXYE5dsOqMX/G6EAS2wltMCSeP17FpT4YSl5zAG3gc+ugE2HDnxifnAozbNf1SrTWJhizPrhKwjW5NnTkKkmDdnn99mw+hhQ79bUp+VHuqcjwKXg7GaWOaq8/JrreCqIx9394bRT53hw0EfzP/P879OIthzUuctr0EllTu6/FLESsv9l1ijZw5osk2wAQw7EfG0Vwbj3Cm+prWSEBh/mNW7Pbvz2S5JJV2AOhWijd4Xm2hrRuVCUh39FMvKfcBzkt6jLIrwBvNX3x
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id f15-20020adff58f000000b0033cdbebfda7sm4282140wro.14.2024.02.14.05.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:58:49 -0800 (PST)
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
Subject: [PATCH net-next v4 5/6] net: ravb: Do not apply features to hardware if the interface is down
Date: Wed, 14 Feb 2024 15:57:59 +0200
Message-Id: <20240214135800.2674435-6-claudiu.beznea.uj@bp.renesas.com>
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

Do not apply features to hardware if the interface is down. In case runtime
PM is enabled, and while the interface is down, the IP will be in reset
mode (as for some platforms disabling the clocks will switch the IP to
reset mode, which will lead to losing register contents) and applying
settings in reset mode is not an option. Instead, cache the features and
apply them in ravb_open() through ravb_emac_init().

To avoid accessing the hardware while the interface is down
pm_runtime_active() check was introduced. Along with it the device runtime
PM usage counter has been incremented to avoid disabling the device clocks
while the check is in progress (if any).

Commit prepares for the addition of runtime PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- simplified the code
- didn't collect the Sergey's tag as the code was changed

Changes in v3:
- updated patch title and description
- updated patch content due to patch 4/6

Changes in v2:
- fixed typo in patch description
- adjusted ravb_set_features_gbeth(); didn't collect the Sergey's Rb
  tag due to this 

Changes since [2]:
- use pm_runtime_get_noresume() and pm_runtime_active() and updated the
  commit message to describe that
- fixed typos
- s/CSUM/checksum in patch title and description

Changes in v3 of [2]:
- this was patch 20/21 in v2
- fixed typos in patch description
- removed code from ravb_open()
- use ndev->flags & IFF_UP checks instead of netif_running()

Changes in v2 of [2]:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ac23779d1cc5..6f0677d1adee 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2564,9 +2564,18 @@ static int ravb_set_features(struct net_device *ndev,
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = &priv->pdev->dev;
 	int ret;
 
-	ret = info->set_feature(ndev, features);
+	pm_runtime_get_noresume(dev);
+
+	if (pm_runtime_active(dev))
+		ret = info->set_feature(ndev, features);
+	else
+		ret = 0;
+
+	pm_runtime_put_noidle(dev);
+
 	if (ret)
 		return ret;
 
-- 
2.39.2


