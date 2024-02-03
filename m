Return-Path: <linux-kernel+bounces-50935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3940848402
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 06:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5459D1F27C70
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA7111A8;
	Sat,  3 Feb 2024 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2UfFbP4"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21410A2B;
	Sat,  3 Feb 2024 05:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706938320; cv=none; b=NCygoOV79BFm5MCeUExdoFIYG89PWHoWAeGX3CK6F+WjmA+IRBSug1J8zlZsPd3QhRy31NJQ5SM2M3C0NF/MxtJSq95+G+XYknu883eKByVmHwVFpFa2tyCt+QS+y2ox4+ryCiSI+q9tyo4ZKgoHbATx4w9YcykYl0Arc8eMXD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706938320; c=relaxed/simple;
	bh=WJxpYYCPda5EiAQPzp3mBDj5MBX19w0yq2LTgnZaj9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DCEdEmRUTjVsS4a0t2VM6w4gMlEboryBlVNngT7jhYM6ieumfV8Fubeq65I6uuf+PkvO/GBKpjJTWjYZL4A1PEQd8cBxseRW83pPWi65HVM7AyrFZORcpgMqL//fDa3vI7lCuEhdpS3cjqnsBppz3vnXyDTvUoeNidY7/ZTslgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2UfFbP4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso2464230a12.0;
        Fri, 02 Feb 2024 21:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706938317; x=1707543117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VU5xgvL3cR0xNsh2zZS6yozISBYA1A6NcgWvOieC82Y=;
        b=B2UfFbP4uUSMeUYdgPAU5vkdWzrZ5AiBxAKHFdmqRJ73mQ7v/PfFayR1U0HZfanqoS
         H63HEOK6dvVRmHaolZfyrsMlJmI5k4CjuVnyJT8Q1HtrY1+0Tz80/S9Qbgs7n0tkMXzv
         4kGfKF9ClEcPeRHS4rMnPhJwv+OjnDWDqBvrHEV3zBkoQxkFnhmXzd9Ae4k2FNyprRhh
         Ys4RiQKCf9Ng1pV3emyRAzuB5905Kxo0N4+MDsdJjDuMswb7CSE7tbSUGnJ6kVpTKiIV
         rA8/3EUYuC0YRxkODwKfFnGJqoxxe5PakT1HZcEtiOwlf5/x488r+DgaDf1Lw/ZN0oIV
         +04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706938317; x=1707543117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VU5xgvL3cR0xNsh2zZS6yozISBYA1A6NcgWvOieC82Y=;
        b=DS8gY95AjY3OdV42fjmEcl5NRpaRCYNXesIPcT99TZIXzKvtAIQDWAuoS6if4bFeA0
         OVLaUbrkIPyWXN1vLDHObZ+w+tp+mB9TO0wBLSyeQpMEbMJz8me+g7ctuf29qhM9/WiC
         ntfPthBb0wsIrXi0Wv0Aayf8iqU/YRk28xstPzBoITgzVNLUSK7TFefBWInQL7PlOv2N
         QLOGSMS/smFK0thAyrV06qUYBrAC7kHGXIgwKRwcruzGskA4OCTfl1YmD43h3TtfAzwj
         j5mLIzbrV11vm+VE1bsN7YOwo7m8aHyCHo6a3fVrlxjtpqURW49pUjoxju0FUjZQse4Y
         UhdQ==
X-Gm-Message-State: AOJu0YyJaUEkzrnzJjnrOPMLn6TT7pl8+7aeSyGmSt37LjzQwvwsOE8s
	fUpHYoRGhLHwI91LYlIzNaCco0OORjsElygkccy6DgKXd3OJXhXd
X-Google-Smtp-Source: AGHT+IFWVqk1b0NST/97uJ2zgzmU7AmYZH/GXvS5SuXLfRb8AyJVkmN6i1eMozNxdaY3jAwfjnS4Qg==
X-Received: by 2002:a17:902:f68a:b0:1d8:fb17:a1f2 with SMTP id l10-20020a170902f68a00b001d8fb17a1f2mr14667824plg.34.1706938316894;
        Fri, 02 Feb 2024 21:31:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW/R92Ns9HBAWu7bG/hQmdzg+lbNaMtxd1B6bSQMgjyvZ4LykqfWtBvSlY2RA/gsNvsVgPHYho+rSngrGVondwbmV+ZHPARde3dhMZ7htzR/L4OSM5UAPKGefXjZIjEFNpEP08DlSOqISkTeXSf/HA8YhUofhJexVdmsVqdN50KNYGQT4fyz2Pk7q+SQgX+ox0CJYAuja8+vRvRx7ARtZ+YFSHRmxcWYAHJg6kP1nEUcPPfzyN8gdGmbqia3dahNPr9nQeqWNKlMbLbo+FWBoE8j3WY0d+rED8yr3LatP39NsjcaaGbH9DJByzMI1yvzXQ66wg8rvjsB8jwzWaIu4AxRShBlh3YLwpV0rNe9P9uegtppmeHAtfDI9x/oCJNEtXOWA5Y8bCfjcySAQ4jRxN4ac6jtiXOzqYA0ks/r/OIfnKlzpL2xwslLh3TVqJLrs3SLI3l7/twiDEwoWVxo4T0GcQV4u3IFLyvUDN3QuwP/euZ+rIMR5M2Kai4k4FgdKWFLKUiDPAiirSYkGYoBv+2OPNseHjw35Q=
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id v11-20020a170902d08b00b001d8f6b95dcbsm2507121plv.20.2024.02.02.21.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 21:31:56 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Simon Horman <horms@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net] net: stmmac: xgmac: fix a typo of register name in DPP safety handling
Date: Sat,  3 Feb 2024 13:31:33 +0800
Message-Id: <20240203053133.1129236-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DDPP is copied from Synopsys Data book:

DDPP: Disable Data path Parity Protection.
    When it is 0x0, Data path Parity Protection is enabled.
    When it is 0x1, Data path Parity Protection is disabled.

The macro name should be XGMAC_DPP_DISABLE.

Fixes: 46eba193d04f ("net: stmmac: xgmac: fix handling of DPP safety error for DMA channels")
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 5c67a3f89f08..6a2c7d22df1e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -304,7 +304,7 @@
 #define XGMAC_TXCEIE			BIT(0)
 #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
 #define XGMAC_MTL_DPP_CONTROL		0x000010e0
-#define XGMAC_DDPP_DISABLE		BIT(0)
+#define XGMAC_DPP_DISABLE		BIT(0)
 #define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
 #define XGMAC_TQS			GENMASK(25, 16)
 #define XGMAC_TQS_SHIFT			16
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 04d7c4dc2e35..323c57f03c93 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -928,7 +928,7 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
 	/* 5. Enable Data Path Parity Protection */
 	value = readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
 	/* already enabled by default, explicit enable it again */
-	value &= ~XGMAC_DDPP_DISABLE;
+	value &= ~XGMAC_DPP_DISABLE;
 	writel(value, ioaddr + XGMAC_MTL_DPP_CONTROL);
 
 	return 0;
-- 
2.34.1


