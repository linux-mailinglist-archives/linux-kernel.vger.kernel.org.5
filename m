Return-Path: <linux-kernel+bounces-81061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D979866FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5FE1F23FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADFD5A107;
	Mon, 26 Feb 2024 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U661mhYt"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D658AA6;
	Mon, 26 Feb 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940051; cv=none; b=GSEu4V0rFWRpRCY6VoXIhIR9cM5x7WMQ3ARQNYX0plagjpRkLHpFA48ZOsCEbOKNGgYM0z5pI7PO6eOFtw2fI4kVaH9SjFcg6rLlyYMeaSgvlMzwmsGTf04MRGFVGSTCuNqj6X5s6NWua/ioetFPhiACixDzVYImKl4i66E9nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940051; c=relaxed/simple;
	bh=B5XmgnTQfmniREvPObTq626oj49TOQPaFFKPyJV8MWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oMy1Etxwxi8W4DHEJAU9cTGFIuBrt5NjSA3JJCfds6TQ6oVxLjw+6yngxwN1bdOGZhRjePG/0gZIE5I2jMmKoR42YOrROzofyRE2WdYMpJG/oNBg3MuhvEd4uTEfTbDweV59QzWW9hAuW4OgJfAh6XN8Tp7ALEy2FhpEN4S+wuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U661mhYt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso1891569f8f.0;
        Mon, 26 Feb 2024 01:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708940048; x=1709544848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLtF7BizwZvfZN5GuZUignuLCSNDd+sax5JxYiM+LhA=;
        b=U661mhYt+yxbagFzdkYhPwkALZo7ch3nZaO3fiYpVkrDq5hRg6A0pCKK09PlzXstqs
         iHMFzz3RNrj8jWFvw/o91mP7+pQGIraH3dGxUrJxs92D4Ko8l+N8WcmcipWAAAfyBjWU
         ULF+uBBDtFqrIJgv1cpNL2tHQCdCzEprBFrLujju5I2+x0c+g9Ba++cQ5tGlJQbrfE5Y
         116EYtLuCWA/kKg522xXt40OGbCKi/n2h1Kw3Yw5FP0sTgtob6hWpoXO81i/T2+ie/dK
         L2ZT4hC4U1v113QfetHCMXlmSR6jqKHItkf+d89acnpkDOoiv9N8F5h6K3XY3Lag6G1q
         x+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940048; x=1709544848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLtF7BizwZvfZN5GuZUignuLCSNDd+sax5JxYiM+LhA=;
        b=MWkuyShDuU/1Pym/vaMFtZN2hQ3o0VyjTosqnef5Kv1jS5f7sjKJzJ1N11+dB2KxwY
         X7BcuBBeFkND2UAZZMXE2CiLnDeoDuGY2AeGHjtZk0AJzdsohdngzVvXKXGFzo4+LB53
         Qn0kbCqLAZGjtG1LhDfe9aYW36R5FeCk2dpJrQ+rLr9Iy6oqRgX/TujFLJAWVZJ6mXXV
         8fbkCDu0K6dC3+Vhg7QECHdJbdHslCJie6Uinv1q/UKpZoxqfglG6kc2q+Fe2DdPxRdq
         AzbAH4a+suQ5E4N18WxkRmUR1wGuW+JpGvfrRiTqScIfmEli0GKuJLF3+oMSHo3Chqy/
         IvVA==
X-Forwarded-Encrypted: i=1; AJvYcCWStX0ILebTPF2klBWwFD/C2oYbPdyIcBf9yj3wpLMGh5DDQyy1dCJdQ5jn4rmmzcJ++GOgq0dXwUuQzbI2NNGhhpLOALpnSumL9GNfTD8spq0FlrsRRFfSN2pbPC9PKUorT/aC
X-Gm-Message-State: AOJu0Yw0UHvCiCPOFuN8O5LjWTBROx2VZYaMyaa8vms08287KAr1jK+Q
	FVw15+KLDyIzhFa1S37pQGq1msLlUGAwXCj7LRiL9ZncrKv59ah3
X-Google-Smtp-Source: AGHT+IEi6GB9us55+eZ6PLrMscsWzljtbO5rOv8g03rm2DGHxEr4TSML+Pwaf/AFQXl8ljBVN2nDEQ==
X-Received: by 2002:a05:6000:1752:b0:33d:3cd3:5ffd with SMTP id m18-20020a056000175200b0033d3cd35ffdmr5624541wrf.22.1708940047938;
        Mon, 26 Feb 2024 01:34:07 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:a92:c660:e2e4:db7a:f447:614])
        by smtp.gmail.com with ESMTPSA id bj20-20020a0560001e1400b0033db0c866f7sm7749527wrb.11.2024.02.26.01.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:34:07 -0800 (PST)
From: Piotr Wejman <piotrwejman90@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Piotr Wejman <piotrwejman90@gmail.com>
Subject: [PATCH v2] net: stmmac: fix rx queue priority assignment
Date: Mon, 26 Feb 2024 10:31:44 +0100
Message-Id: <20240226093144.31965-1-piotrwejman90@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver should ensure that same priority is not mapped to multiple
rx queues. Currently rx_queue_priority() function is adding
priorities for a queue without clearing them from others.

From DesignWare Cores Ethernet Quality-of-Service
Databook, section 17.1.29 MAC_RxQ_Ctrl2:
"[...]The software must ensure that the content of this field is
mutually exclusive to the PSRQ fields for other queues, that is,
the same priority is not mapped to multiple Rx queues[...]"

After this patch, rx_queue_priority() function will:
- assign desired priorities to a queue
- remove those priorities from all other queues
The write sequence of CTRL2 and CTRL3 registers is done in the way to
ensure this order.

Signed-off-by: Piotr Wejman <piotrwejman90@gmail.com>
---
Changes in v2:
  - Add some comments
  - Apply same changes to dwxgmac2_rx_queue_prio()
  - Revert "Rename prio argument to prio_mask"
  - Link to v1: https://lore.kernel.org/netdev/20240219102405.32015-1-piotrwejman90@gmail.com/T/#u

 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 42 +++++++++++++++----
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 40 ++++++++++++++----
 2 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 6b6d0de09619..76ec0c1da250 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -92,19 +92,43 @@ static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
 				     u32 prio, u32 queue)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 base_register;
-	u32 value;
+	u32 clear_mask = 0;
+	u32 ctrl2, ctrl3;
+	int i;
 
-	base_register = (queue < 4) ? GMAC_RXQ_CTRL2 : GMAC_RXQ_CTRL3;
-	if (queue >= 4)
-		queue -= 4;
+	ctrl2 = readl(ioaddr + GMAC_RXQ_CTRL2);
+	ctrl3 = readl(ioaddr + GMAC_RXQ_CTRL3);
+	
+	/* The software must ensure that the same priority
+	 * is not mapped to multiple Rx queues.
+	 */
+	for (i = 0; i < 4; i++)
+		clear_mask |= ((prio << GMAC_RXQCTRL_PSRQX_SHIFT(i)) &
+						GMAC_RXQCTRL_PSRQX_MASK(i));
 
-	value = readl(ioaddr + base_register);
+	ctrl2 &= ~clear_mask;
+	ctrl3 &= ~clear_mask;
 
-	value &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);
-	value |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
+	/* Assign new priorities to a queue and
+	 * clear them from others queues.
+	 * The CTRL2 and CTRL3 registers write sequence is done
+	 * in the way to ensure this order.
+	 */
+	if (queue < 4) {
+		ctrl2 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
 						GMAC_RXQCTRL_PSRQX_MASK(queue);
-	writel(value, ioaddr + base_register);
+
+		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
+		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
+	} else {
+		queue -= 4;
+
+		ctrl3 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
+						GMAC_RXQCTRL_PSRQX_MASK(queue);
+
+		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
+		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
+	}
 }
 
 static void dwmac4_tx_queue_priority(struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1af2f89a0504..7ad73e1d353e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -105,17 +105,43 @@ static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
 				   u32 queue)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value, reg;
+	u32 clear_mask = 0;
+	u32 ctrl2, ctrl3;
+	int i;
 
-	reg = (queue < 4) ? XGMAC_RXQ_CTRL2 : XGMAC_RXQ_CTRL3;
-	if (queue >= 4)
+	ctrl2 = readl(ioaddr + XGMAC_RXQ_CTRL2);
+	ctrl3 = readl(ioaddr + XGMAC_RXQ_CTRL3);
+	
+	/* The software must ensure that the same priority
+	 * is not mapped to multiple Rx queues.
+	 */
+	for (i = 0; i < 4; i++)
+		clear_mask |= ((prio << XGMAC_PSRQ_SHIFT(i)) &
+						XGMAC_PSRQ(i));
+
+	ctrl2 &= ~clear_mask;
+	ctrl3 &= ~clear_mask;
+
+	/* Assign new priorities to a queue and
+	 * clear them from others queues.
+	 * The CTRL2 and CTRL3 registers write sequence is done
+	 * in the way to ensure this order.
+	 */
+	if (queue < 4) {
+		ctrl2 |= (prio << XGMAC_PSRQ_SHIFT(queue)) &
+						XGMAC_PSRQ(queue);
+
+		writel(ctrl2, ioaddr + XGMAC_RXQ_CTRL2);
+		writel(ctrl3, ioaddr + XGMAC_RXQ_CTRL3);
+	} else {
 		queue -= 4;
 
-	value = readl(ioaddr + reg);
-	value &= ~XGMAC_PSRQ(queue);
-	value |= (prio << XGMAC_PSRQ_SHIFT(queue)) & XGMAC_PSRQ(queue);
+		ctrl3 |= (prio << XGMAC_PSRQ_SHIFT(queue)) &
+						XGMAC_PSRQ(queue);
 
-	writel(value, ioaddr + reg);
+		writel(ctrl3, ioaddr + XGMAC_RXQ_CTRL3);
+		writel(ctrl2, ioaddr + XGMAC_RXQ_CTRL2);
+	}
 }
 
 static void dwxgmac2_tx_queue_prio(struct mac_device_info *hw, u32 prio,
-- 
2.25.1


