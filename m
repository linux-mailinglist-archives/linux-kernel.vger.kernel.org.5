Return-Path: <linux-kernel+bounces-46024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8D184396E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7595F287997
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C83669D30;
	Wed, 31 Jan 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qK9X4mmE"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4BB69953
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690516; cv=none; b=ZspiNpqlV1MO4YQ0eBecTVmDmWyX8HS47/sI3fO2+SbpNF8Rj5TcfGK8jeJnt0ooui5d/a1o7gXvOWCW++ffHAYTIkDbYj1cy3+FgvJoNg4r1Rxh55hBp5SmZKWJXNMG1IL/2CH/eJKPg3KzeuhH/s5g85P70j1/bIkdnUQLuyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690516; c=relaxed/simple;
	bh=F/pQ43TZd0yxTybIVFp9YQ1lJIzC8KcINVjpd5TwZSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S5avkXc1GkguhdEbQrF6NPeRyab5aEKuq2/KeFl6l2Fa5onfETuTOlAnRzgbNzdWFPaRh1Pd+0w+fmBJ8k24xGdmgErv1BSDgmsKeJslJhkZiX8MxDvbq33pLKdaWUh3DcrhIy7iI2AlJsGUqMXme7rwSSalzcDM2/CT6Fh6e7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qK9X4mmE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55ef011e934so4243107a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706690512; x=1707295312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vYE6VGGaC6dDiCeRDs1uRAAsGK/Jz27M4TajzPwZTU=;
        b=qK9X4mmE5DLWMZWhaS9MWU+C2slURJijqI8YhKW/Q+vL34nR15YleS8d9UkD5vYNwO
         Dl0SXDQ3mQyHSj4ZEgq1M60xE9HTv1a2WKluPF9ykz+f0cbYWiFjST2lAnRVsSWLWN1U
         IFICrTWAI24bKUFDqHamoqngpLgPeEWK3T1b9pVqh9kuh5xg+jR5qmTjdiChL0CxOurm
         Crzqdf8HxOZaSe8ZcnBlSBupcU8Jjff0grup1QZPPq0yGZy8+4KBpMfEni3alSa4IdQk
         73UDiT2pJmspsAkoC8hoCb22zfT84OFsVegPNR3wY4zaRBWHCvVWWVuLjjDaKlHaLBjL
         au8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690512; x=1707295312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vYE6VGGaC6dDiCeRDs1uRAAsGK/Jz27M4TajzPwZTU=;
        b=De5OxQ2WSzftTI0oCaD6QcAQY7rWcDsa4NOlBqcIRBOE/ugefLMeLklRzaj/la77BJ
         K0tsZpzXmMacxo2FSK+UpM6rS1LdTk+kSr+80yFd5Gv8NualjLHvWD0pg8b4D+NDEvi8
         0b6obge6JHs33K0pr3l0Q3jLCinzBMZxceo8oKS1ZZVkN8e8aLRdOwaAmS033vSKb5Gs
         uaDY3GSN9QLmI1w4aTbMKXc23b4BWM6NheFhDjh7Z6BMxUs2lAw5VPfAJjlNAcHR+IW6
         A8tEzFI9oANa1AWz/teE2qcPTSBbeAw5quRuyQvlyRWr9kre76sj3PuLEHDIpf9e9Yw3
         8YTA==
X-Gm-Message-State: AOJu0YwzwDB3FSWKIP4YPrj19bAO1msz+ccfLG7rIbMrir2GTM/1kUgu
	pDJZH0MgyIZkmOdU5Ui9pnzsZBkmQdJ1mt4kQQpG/JCfA3+hWYtkXEJ/DhFb7l8=
X-Google-Smtp-Source: AGHT+IHLjjLm2buuFTHLorPXWtx/2gEZscx3uUOOI2BYIpDUfFOz4Fkpbg1fZxfpiKpoVOqiOswEgA==
X-Received: by 2002:a05:6402:64f:b0:55f:3cb:9cfa with SMTP id u15-20020a056402064f00b0055f03cb9cfamr628504edx.30.1706690512682;
        Wed, 31 Jan 2024 00:41:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV5j7LOeqH5BmenUWvzCmo2qCBc9iYVyjhYr3FrubKe3iWE6KVctdP7hRDi8vvMV1Q+Z/GBABR1kHRE/19Feaj8Tv5TKj2vG+Y1h7Qg9GWhLxmuK4SOiiCd/fg6jwaqha6DLNmRN3B7cvztCS5qZY7GmEejRWlMPHS1cLsERSl0poDKOuR/jUa+JK041ZemacvNbKxy0yi9aq+MpyN3f2QfeUjTJHHkcP+gTeTEFQEQGCxLgm3sPl03aXZtF/pcb0mVL6FH0Kus3Jouon0yMqSlipCYQlqwZCRx138lUr2e9CO+mP3SSzBkvOGbfyyvrKeKqP7866Ux+DnkG6x5ZCiEOwZ4sp0hg8Trf3Hkn576aEDaxhOZcH4+GtV4+LXf7qVxNfvm7/hiD8YvVxjOImQOYVomJYQu+BmCtsi7zStfwy3cMxo=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0055f02661ae2sm2863630edb.78.2024.01.31.00.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:41:52 -0800 (PST)
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
Subject: [PATCH net-next v5 05/15] net: ravb: Use tabs instead of spaces
Date: Wed, 31 Jan 2024 10:41:23 +0200
Message-Id: <20240131084133.1671440-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use tabs instead of spaces in the ravb_set_rate_gbeth() function.
This aligns with the coding style requirements.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/net/ethernet/renesas/ravb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 7ced5db04f75..c05d4a2664eb 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -96,13 +96,13 @@ static void ravb_set_rate_gbeth(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 
 	switch (priv->speed) {
-	case 10:                /* 10BASE */
+	case 10:		/* 10BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_10, GECMR);
 		break;
-	case 100:               /* 100BASE */
+	case 100:		/* 100BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_100, GECMR);
 		break;
-	case 1000:              /* 1000BASE */
+	case 1000:		/* 1000BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_1000, GECMR);
 		break;
 	}
-- 
2.39.2


