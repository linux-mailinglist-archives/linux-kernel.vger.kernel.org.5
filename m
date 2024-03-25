Return-Path: <linux-kernel+bounces-118082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0787E88B36A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE241F64EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BDF73506;
	Mon, 25 Mar 2024 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+aSTtFZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29271B39;
	Mon, 25 Mar 2024 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404397; cv=none; b=QOeG5Lk5uozF6O8X0gZQi0OtJORQjUOyIBnDSW/mOgzMZ1tUjo8PmrgPypafOQ+2Zvcd5+1o2xFSfwWy1IO2hzkqhxLjFNNWP9N9u31kuGjU2eW2Xd5Clia1Uo7KfXW+IvLXvPCJpOXOVoOobNnzLBnAJ/GSyah/bp9ne9QjvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404397; c=relaxed/simple;
	bh=++5tZW3zuXGvT6hS7Mqh8whM8yX+K95vZmsamxvflek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cguLwMO0oU3nieGdBW8A8bl7FRPiMTo4AKYOv+rQ7hVUIdPxUFRhktXRmpPOF/9GcLvguFxW88j3NRN7LtdRY7COd1447m20PFfM525Qk9dUgoytt/wozLd0vMlQUbn4oXunsD73EsghzE75seAX8g5ICN6MOnyj8zHhSvKFoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+aSTtFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22740C43390;
	Mon, 25 Mar 2024 22:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711404397;
	bh=++5tZW3zuXGvT6hS7Mqh8whM8yX+K95vZmsamxvflek=;
	h=From:To:Cc:Subject:Date:From;
	b=e+aSTtFZ/A2aUOwkehWvStANDFdMiOTDFYR9aGLl7GRRD2mWvPw74d2rco3Js8Ph5
	 rx5Si1xhWA+eelgVFBsg7FL5HCNadud+wt6RgeZK2QDsSKMPNv7cou7kDWpt0AzMN0
	 Grxh9zaSkS/fjKyN2wV3WDm5B7VrukjOK2Q2X8BbLR5u/Q5JtY8IX3WRVFWYAeiYxH
	 N6okH1isRxgLSMmPp4Um0pcl026P81MW8HWjTpcCvoygKOpmRz7CJIHGyOqGK7RPNf
	 r/er89QqdcXX2GaF50tLdqrHgkHzCsc3QUxB2ezMbYOIohc6PszS4D4jXYMp/w5VBR
	 UEa8P9j3oFYyw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] net: amd8111e: Drop unused copy of pm_cap
Date: Mon, 25 Mar 2024 17:06:33 -0500
Message-Id: <20240325220633.1453180-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

The copy of pdev->pm_cap in struct amd8111e_priv is never used.  Drop it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/amd/amd8111e.c | 1 -
 drivers/net/ethernet/amd/amd8111e.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/amd8111e.c b/drivers/net/ethernet/amd/amd8111e.c
index ea6cfc2095e1..c1b5e9a94308 100644
--- a/drivers/net/ethernet/amd/amd8111e.c
+++ b/drivers/net/ethernet/amd/amd8111e.c
@@ -1796,7 +1796,6 @@ static int amd8111e_probe_one(struct pci_dev *pdev,
 	lp = netdev_priv(dev);
 	lp->pci_dev = pdev;
 	lp->amd8111e_net_dev = dev;
-	lp->pm_cap = pdev->pm_cap;
 
 	spin_lock_init(&lp->lock);
 
diff --git a/drivers/net/ethernet/amd/amd8111e.h b/drivers/net/ethernet/amd/amd8111e.h
index 9d570adb295b..305232f5476d 100644
--- a/drivers/net/ethernet/amd/amd8111e.h
+++ b/drivers/net/ethernet/amd/amd8111e.h
@@ -764,7 +764,6 @@ struct amd8111e_priv{
 	u32 ext_phy_id;
 
 	struct amd8111e_link_config link_config;
-	int pm_cap;
 
 	struct net_device *next;
 	int mii;
-- 
2.34.1


