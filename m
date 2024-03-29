Return-Path: <linux-kernel+bounces-124621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3B5891AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3321C2572D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4F615D5A9;
	Fri, 29 Mar 2024 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY0AB8Zr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1715CD73;
	Fri, 29 Mar 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715565; cv=none; b=Mx/ongL2qTAWiwwE9cKRsLf7njC/uT/jHjKtiWNmKA5uhP4wYuF3JORijuFzr/gJ71JSgd/ZrKdmO9X3V2c5rVItkS1nLknPz8mOqwQzoqLyxzFQGLHDoNfWjw67PKBVrm3KzZ3ah8J67D1WHP5LYp+ExlPoHxn69rsCXC8QC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715565; c=relaxed/simple;
	bh=L71kAJ31XL2R0p9Jjp/TNWJTYZ2KQR6EOvJiH99UwsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNiIhP8n4hh8tZD8mO+jIkRmkqw0Ga2egYxhHamZNtSZbHjOPDw5YRRWvsM+oXbZ2nLznnrEOF8QCqJpR8dA2Xrlq5cT3FU8MRKkL8iuTaOXYMarpf2Czl3Qa6qxV3aSLWzaBkNpR2xkXvtMV8/QP4L0DpNsAaBeR5CuZ2GMz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY0AB8Zr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD187C433B2;
	Fri, 29 Mar 2024 12:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715565;
	bh=L71kAJ31XL2R0p9Jjp/TNWJTYZ2KQR6EOvJiH99UwsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NY0AB8ZrlMgvjO/0F2aUUC3eDuQccAD1eoiU7NyQTPKUsOm21Z+0zVs8ZS4paf9CA
	 oPAM9JiP8grBNqF23zyL8H+KmjeJWM6z1yy6zW3DGN6NVS3zFh4+x8+Lql19DvdMud
	 /Jwp34EEqBJ4O0gN0rTFGhbUYUin0w8YLXVLPI/dF51Podf1sxA0FDsGBzlo8Ie+U7
	 vxTOBvw6iPs/SepU8/KKmBprsvEV+cdJZyd+uqM/CHraNTs+ZnN07hJoA6WmwAOWre
	 BhCQxkHr7asBGZLIu9To7Lvel3Cq3//vPdnvM5SvcXFIL8Hmg5ZN5I9w1FjWUAcDkO
	 yUPptpweVBb4g==
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
Subject: [PATCH AUTOSEL 6.1 18/31] net: pcs: xpcs: Return EINVAL in the internal methods
Date: Fri, 29 Mar 2024 08:31:37 -0400
Message-ID: <20240329123207.3085013-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 3f882bce37f42..d126273daab4f 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -262,7 +262,7 @@ static int xpcs_soft_reset(struct dw_xpcs *xpcs,
 		dev = MDIO_MMD_VEND2;
 		break;
 	default:
-		return -1;
+		return -EINVAL;
 	}
 
 	ret = xpcs_write(xpcs, dev, MDIO_CTRL1, MDIO_CTRL1_RESET);
@@ -904,7 +904,7 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 			return ret;
 		break;
 	default:
-		return -1;
+		return -EINVAL;
 	}
 
 	if (compat->pma_config) {
-- 
2.43.0


