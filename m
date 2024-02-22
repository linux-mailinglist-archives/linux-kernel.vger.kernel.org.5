Return-Path: <linux-kernel+bounces-77023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF88860036
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF93128D6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE04F1586C3;
	Thu, 22 Feb 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND7LaGMG"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47592156961;
	Thu, 22 Feb 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624742; cv=none; b=bLOIQ+43Kfz4qgtjL4/0n3hP+Gvou/dAa4sHrN+Zu7e9neinvKABisugcnS/PmxDZCWAiJB9fZPPQGvRxFlavfcFuBd+I2JuwlZ0duAY3zo3ZEq33ne2TJltyv3H0GszhvWqOWwleCZj2CVHt1ZZwnifiev8ErL53pzMTv/RxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624742; c=relaxed/simple;
	bh=xivy3UlSQqvQmx57Qi8EAzpF57Mk2WtzBv+/+8Pqri0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmuYPXrPUALW0Oc7+liTja9EKqkFjh+EFnC1bTzCB1vlZs6Oo+CM5eYqD0VQ3tCaq6i3SjA06YT3Too63BZ05u/A/lH8BT2pmi6FyN+V1i7CtvkjFB10yNC/y1KJh1NZNNUQv3v0QNyLek80IAggOTFxs7b7CteI0HT3SChkRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ND7LaGMG; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d2305589a2so720531fa.1;
        Thu, 22 Feb 2024 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708624738; x=1709229538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOW9you0b0342rsDJpYsth5h/RvQ0i1KuZysF40tbO0=;
        b=ND7LaGMGGP4KJRUteYyehlGShGyC7clWpA5cMBWUeZd8jZVT5eKgtnQyHJ8+rVENPE
         VdDZxDjlFKMP5YSYLXr6H2WRINBwErRnqiHtTWc/6htsD/jRJGfXU+/snc+p1JhyotvI
         wOy9J698BVb52nBl4FPGXoEUztB+XjOsr6ybFKH0Hd/pRNt+aBRRiaxYq6qeL+bZw3kR
         qVoj38aizdu2h0GNWm4ncnVN6NcglNRn/za+VqyF2XGg+LrE3NxqXuRCiWjQMwRasGDl
         sWjBju+RG2/PcCtvpACnki3DnD3e8Y/9Okv2of8s1i4W+xvSoIG0IqgqWH6EoSR9UqNf
         CM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624738; x=1709229538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOW9you0b0342rsDJpYsth5h/RvQ0i1KuZysF40tbO0=;
        b=gRUwXvp/RRFu4fyAy6F9ONKQWaGpKwJUGtM+VkAaWjUieSPfiRId4M2nA8vv9FNZcS
         80jphcct+YoIDj5TdGjxtAgWR/7xvkvT92U58AgBeTo780/nophlEbxdso2/238ecSuY
         CJH20Pu5NMb1AkWCDR4u+zaR0PbkDiKn389jnxatwxefW4JoDHzpUABEOLMbFge8XlO1
         kGcSZ9mp03J04JWujTQI2akp8lkIMtQ+UC9xPx2a1sPnXTkTonVHga+yYHe37GfFVCNu
         2hb5zMgLZwwgcTLp/brl3RlKp9dmY3nX7EXpud5F8uQ6SI6Nj8goc14f+Re+FmTVLKYY
         bXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0lYxJ89VGMR5rL/dPpvOe8Evoe1A4tIy3HcH2aGcDYD+uIUKBwcS4nnXMGPhWQubM6JfoBe6tLkkwYi1sApgkBqD8zqS/Lh5bxHz3IP2pNnsU4fSXYNaJWlQKdAh5SPrumubR
X-Gm-Message-State: AOJu0Yw1MukSQoaZUQHp+NdAtGPxlNr85hWRq1KBBtGGA9IQd0nIvpvu
	MuXEahDV64UE8T/oi3NKMh59bsN+kwkyjSibLj6i/M3bkxoo6LEM
X-Google-Smtp-Source: AGHT+IGt49I5Sptvj945xk8GlYDZxwnj9/17uQP/A9B3F9aGMdn0iFrkB8SHmAKNpN7pw6Mp/sGMXA==
X-Received: by 2002:a05:651c:b0f:b0:2d2:64c8:49a6 with SMTP id b15-20020a05651c0b0f00b002d264c849a6mr1360670ljr.21.1708624738266;
        Thu, 22 Feb 2024 09:58:58 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id z33-20020a2ebe21000000b002d230f2e808sm2011743ljq.48.2024.02.22.09.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:58:57 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net-next v2 1/4] net: pcs: xpcs: Drop sentinel entry from 2500basex ifaces list
Date: Thu, 22 Feb 2024 20:58:20 +0300
Message-ID: <20240222175843.26919-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222175843.26919-1-fancer.lancer@gmail.com>
References: <20240222175843.26919-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are currently only two methods (xpcs_find_compat() and
xpcs_get_interfaces()) defined in the driver which loop over the available
interfaces. All of them rely on the xpcs_compat::num_interfaces field
value to get the total number of supported interfaces. Thus the interface
arrays are supposed to be filled with actual interface IDs and there is no
need in the dummy terminating ID placed at the end of the arrays.

Based on the above drop the PHY_INTERFACE_MODE_MAX entry from the
xpcs_2500basex_interfaces array and the PHY_INTERFACE_MODE_MAX-based
conditional statement from the xpcs_get_interfaces() method as redundant.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-xpcs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 31f0beba638a..dc7c374da495 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -130,7 +130,6 @@ static const phy_interface_t xpcs_1000basex_interfaces[] = {
 
 static const phy_interface_t xpcs_2500basex_interfaces[] = {
 	PHY_INTERFACE_MODE_2500BASEX,
-	PHY_INTERFACE_MODE_MAX,
 };
 
 enum {
@@ -636,8 +635,7 @@ void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 		const struct xpcs_compat *compat = &xpcs->id->compat[i];
 
 		for (j = 0; j < compat->num_interfaces; j++)
-			if (compat->interface[j] < PHY_INTERFACE_MODE_MAX)
-				__set_bit(compat->interface[j], interfaces);
+			__set_bit(compat->interface[j], interfaces);
 	}
 }
 EXPORT_SYMBOL_GPL(xpcs_get_interfaces);
-- 
2.43.0


