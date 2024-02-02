Return-Path: <linux-kernel+bounces-49493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF0D846B12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979232954E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F695FEF1;
	Fri,  2 Feb 2024 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DZJZjDUr"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB386BB5C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863338; cv=none; b=M5J4pFoCLX9vYBGiP6+KTesui33J7lLeIBl7tnQ2/ZN2Us6HmvHRS9tmR75Eh431PSOSymnVbHqex3vzCfks6yTFNFDgt+P2M2tbCrs1CpD7QPY306UWaGc6/y4H9xBSfns85KUk+v43K94xJ31Si9QF9e8LalJAG/eQZCUXfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863338; c=relaxed/simple;
	bh=ga3nLsmlUPHxC6lprohW+AJrVuYSdcwOBoQLKkHF3cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gc3hREqDPq5P1lyJB1kUhdLZVG30mpMCOykf7sJPqchb4+W96Z0vOVahXySizr7D4RcRqmEgRR9/PEGXu6/OLRC5RX8s8lfN4yrYn1BF0E6jwznJUT/A0VjMJD/YjBmTJmaUgcSZD1xqXH0T8Xv/7duu7FyYs3bCjtJT5j2Jj94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DZJZjDUr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a350bfcc621so221506166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706863334; x=1707468134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdhJGQ6s9m0NV+6M+vVWcahgWKgGCVymWdzgAMvS+FE=;
        b=DZJZjDUrNOwJoLmuu1njocvKCskmiT+FgFJ4ytSOefX/kELwOhtaJXI0GOe4DqZTbb
         Pdf3qOn7xDZTX1b7zjPyfqI4SGD+txtX42BYSPMqntir4Wb5RbtheRfOzD4BTK7/hmQV
         rwA5iHi/zV63THi76zmwzYHMPqbngQet23RDTY1vwFxBkVE8T3Id982KC2smjlOOo4/I
         T56VCQ80R8ZQOSEcRefFjTuS63tCW/wYrk0eGSfdN3wFrwg7Dojj+68uUwm80cJU9S65
         O3+02uP9qFSGAvo2SiXKJJC/5ZSrEGNzHQ8uAxTid0HXKiuhXe8xyLeNyboTwkD5/dyH
         Z3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863334; x=1707468134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdhJGQ6s9m0NV+6M+vVWcahgWKgGCVymWdzgAMvS+FE=;
        b=s8bo2OwX+DVDvcJy91xaJmrKtHMfff7nIipPZCvQLT166qhXD+QRcYWGemXRKGeI4n
         AYfOSRjnfvKYP8jehIH6autkVfvVy/7LH9ZJCqabywbte7cndGVjIiAruNM58a8LaZY8
         1AuLp0RT6WVgR/tr8V7oEGeY1MCNq4H/+jMYvfDhfUjJhvDwu/fHlkyU9Ty8pcZCsKri
         YM3XWgQwE19Md7bR4AwfJRgiJvbkIqWvN66LR8luwXJ5TL83NOXNDjt4DHRfmF9H58G5
         DCwK02FlkoAVQ6mv8fPntNZj+D6ZK76BJb/3AfytXJc6jiKR+REwajv5hhNElBu3Re7x
         IFQQ==
X-Gm-Message-State: AOJu0YwAv/6NLzKP9O16L/QxYec4QccSsjHcV9ZVPD0WUDB0Fir5e4Cw
	uSzj2OQgLF0ADEXiQoOHDjmvXmzwSAVAGvPc4nz+zFFTqxy1OZ40mc/sVsh7zjg=
X-Google-Smtp-Source: AGHT+IHnXMNwzUo2Br1/N/+O9GPS3OoaSwlapRSfwmI6tY0ezHXdEiAppUdX9nbCdqrt8XHHoCgxZg==
X-Received: by 2002:a17:906:53cd:b0:a35:ad04:af7f with SMTP id p13-20020a17090653cd00b00a35ad04af7fmr1090979ejo.0.1706863334441;
        Fri, 02 Feb 2024 00:42:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV7uSh6uPMkU6fkq4gPzd3tNLJFMVKQ77Z+E4z7R4rS2P0qx+LV0rAsfKqUEMPt9jGqAwQ9TAribpLMglVgFtOl+5ay6lL5S0pnvPNz4b2X1yzzMGbwtaVxPwtC7vIZJH8pDyj/Ug4buSyfR5qau+TOwH8nnnPXEi2QxntsWbgBCe3aN3fDcIRAFZ3tSwTu9/1VmVfU4DeBG0BRyv+lpxZBI3duNQvkQ54DiDTh+tkRUPFdLjNxiB99no50iZLQcQ/b5ukV1RrUns60JFxIQsQyVIQLcnzapwmZ+acqEZ9C3rDRxy2c8JlzGAgA7kBN65XwmWjecHfdMXljZTtra/fb3nuaVJlx1mDmJlLMmpdv6TtUKX2rsJdHoBYnT7Dewx+cXSHm5+WNFsSsHw==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b00a361c1375absm631642ejc.133.2024.02.02.00.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:42:13 -0800 (PST)
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
Subject: [PATCH net-next v6 11/15] net: ravb: Move DBAT configuration to the driver's ndo_open API
Date: Fri,  2 Feb 2024 10:41:32 +0200
Message-Id: <20240202084136.3426492-12-claudiu.beznea.uj@bp.renesas.com>
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

DBAT setup was done in the driver's probe API. As some IP variants switch
to reset mode (and thus registers content is lost) when setting clocks
(due to module standby functionality) to be able to implement runtime PM
move the DBAT configuration in the driver's ndo_open API.

This commit prepares the code for the addition of runtime PM.

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
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e5805e0d8e13..318ab27635bb 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1865,6 +1865,7 @@ static int ravb_open(struct net_device *ndev)
 		napi_enable(&priv->napi[RAVB_NC]);
 
 	ravb_set_delay_mode(ndev);
+	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Device init */
 	error = ravb_dmac_init(ndev);
@@ -2808,7 +2809,6 @@ static int ravb_probe(struct platform_device *pdev)
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
-	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Initialise HW timestamp list */
 	INIT_LIST_HEAD(&priv->ts_skb_list);
-- 
2.39.2


