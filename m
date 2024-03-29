Return-Path: <linux-kernel+bounces-124586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6E891A43
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA79285C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C05C157477;
	Fri, 29 Mar 2024 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFR9aJsM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ECD157463;
	Fri, 29 Mar 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715472; cv=none; b=fw4ax9SHbASm/t3on6EvsuIMrqkmKF62VxanrSQbHg3RF4PrDAovsU2TJJwaScE2Gn476AUmjnB+FVl9Bos1BJavHcLdMsOjZXONgm7H8jTy9n4fKK8FcN1Dkc5oxMjFP7dXH0yuC/G52EuzBrItzVPbzxDJOidiFPXEAaY+dZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715472; c=relaxed/simple;
	bh=iZZqgKGHs4fdYu24nLgh2Il4+b4tK08w5DeGr+ZVQLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMscsTKzbsIuxGEcbms4Foacbeoe6MTbWV6fsxeBITygO1UAoI1aK8VaGxQ4AuXF5ZyjmMUwpyWkM1pHc8t1jD4B0YXa8dYWa3nsYwB2ExvTzcG5mI9xtJSMUHmpehDxxxONYt42sVA0M0C50IksldfhFM5WLnRCSSuhfwKWfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFR9aJsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F7EC433F1;
	Fri, 29 Mar 2024 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715472;
	bh=iZZqgKGHs4fdYu24nLgh2Il4+b4tK08w5DeGr+ZVQLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VFR9aJsMjvKjGA1823EkN1izx/leqtLWHP0ndgFKwt4W7F5IxvgglzyeNT/Hd0b2B
	 S1CGJyBP5EmW8fQulcvPEqF9Xuku4l1URIAm7fPZK7Wo4mVCywNfjafrr83axtKD9C
	 CaaKhb1f1F9bSPU2GGWF/oAzJ5k1XPjg959GfoovGuiNJgXgxfXuBSfhchGef1v2RO
	 NpjiVsP2KnTkyr1UP7NDd5+0++VvnpPWEKLteJ0/cl+/97UrvJ/IAXtxTgycagYhAI
	 irLnR/rhPtzQhson/hqpGh7FDjbta7wypqIcu8z6fRrsh1RXcAXrdCKeyt5bnYZEH+
	 1TKXGmZvQdGUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	Jose.Abreu@synopsys.com,
	hkallweit1@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 35/52] net: pcs: xpcs: Return EINVAL in the internal methods
Date: Fri, 29 Mar 2024 08:29:05 -0400
Message-ID: <20240329122956.3083859-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Serge Semin <fancer.lancer@gmail.com>

[ Upstream commit f5151005d379d9ce42e327fd3b2d2aaef61cda81 ]

In particular the xpcs_soft_reset() and xpcs_do_config() functions
currently return -1 if invalid auto-negotiation mode is specified. That
value might be then passed to the generic kernel subsystems which require
a standard kernel errno value. Even though the erroneous conditions are
very specific (memory corruption or buggy driver implementation) using a
hard-coded -1 literal doesn't seem correct anyway especially when it comes
to passing it higher to the network subsystem or printing to the system
log.  Convert the hard-coded error values to -EINVAL then.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/pcs/pcs-xpcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 4dbc21f604f20..f0f41e86a4fb3 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -293,7 +293,7 @@ static int xpcs_soft_reset(struct dw_xpcs *xpcs,
 		dev = MDIO_MMD_VEND2;
 		break;
 	default:
-		return -1;
+		return -EINVAL;
 	}
 
 	ret = xpcs_write(xpcs, dev, MDIO_CTRL1, MDIO_CTRL1_RESET);
@@ -891,7 +891,7 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 			return ret;
 		break;
 	default:
-		return -1;
+		return -EINVAL;
 	}
 
 	if (compat->pma_config) {
-- 
2.43.0


