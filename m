Return-Path: <linux-kernel+bounces-113548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC24888535
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CE9283437
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082071C322D;
	Sun, 24 Mar 2024 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL8Szldr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AAA1C3206;
	Sun, 24 Mar 2024 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320350; cv=none; b=nGOG4hjATWUtMDVMtKnQs5UQo4fl2AGvJtT3B8JNmlMOL4UA4TKcPaXe/GxoToXtkX3caY4+36l81MdUNd0hmWN2OoS6XbSIx+zTK0v/QtgwpWSbTsdpj1Nxnl8caoo7gOyb3aljDIpPBndGf/SuVZA6RmXFGuy+y8bsmJckq98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320350; c=relaxed/simple;
	bh=jyPUzGjrKorLgfAUq4D1EjtMEkByCrvPfO9D5cajMHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3xgO4/0g3yF/DzviP9LebqiulU20G2ikeJRnOXZuuTKDxnaJdyUHxrolZCRwlg9WsozQs424VSiuzXV6tKB4DuF4b7lbcRBdOWgJCs9Es7A3JkzIURr+5dz6NsH+aCxgub06T2CG/OBD1KL3CCBUW9oZ3AqNYJ6o+wAb7TPL00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL8Szldr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52685C433C7;
	Sun, 24 Mar 2024 22:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320350;
	bh=jyPUzGjrKorLgfAUq4D1EjtMEkByCrvPfO9D5cajMHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eL8Szldrq9ns+bgxmYBIrvTpCO/4RZADPSNenustqyt73AH4WRWBHZubuzs4ofjhF
	 D+bFxOuwvFU514l8yv/gi+xrYorNlDEC65X3GSkD3kcTJXkr4ENXIgfx4ZH74A5XWT
	 0/5fSVffTFyMCuq+T4LuGrbFT1OIiRN5UxQ6uxmcR5sz1mYuYniFW51z037FwabAVO
	 f6C5gwrM6bhKkYXepNRvKpksdNBEfuKOj+XiiH7+R3y9xb9UyNqguSFLcNnB9wW+Eo
	 OhGSuKeti6QheI6XgnzOvZ95mNw9QtqP+rfj2OeraBQxKzSoyXExlX9loFyzO0Pzct
	 04kcBu93aqfYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 657/715] net: txgbe: fix clk_name exceed MAX_DEV_ID limits
Date: Sun, 24 Mar 2024 18:33:56 -0400
Message-ID: <20240324223455.1342824-658-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Duanqiang Wen <duanqiangwen@net-swift.com>

[ Upstream commit e30cef001da259e8df354b813015d0e5acc08740 ]

txgbe register clk which name is i2c_designware.pci_dev_id(),
clk_name will be stored in clk_lookup_alloc. If PCIe bus number
is larger than 0x39, clk_name size will be larger than 20 bytes.
It exceeds clk_lookup_alloc MAX_DEV_ID limits. So the driver
shortened clk_name.

Fixes: b63f20485e43 ("net: txgbe: Register fixed rate clock")
Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Link: https://lore.kernel.org/r/20240313080634.459523-1-duanqiangwen@net-swift.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 1b84d495d14e8..29997e4b2d6ca 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -556,7 +556,7 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "i2c_designware.%d",
+	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
 		 pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
-- 
2.43.0


