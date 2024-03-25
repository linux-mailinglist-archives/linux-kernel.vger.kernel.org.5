Return-Path: <linux-kernel+bounces-118116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849AF88B42B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409E02E788C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447EF129A79;
	Mon, 25 Mar 2024 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGczMVKU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB41292EA;
	Mon, 25 Mar 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405805; cv=none; b=a1xp7dvjsN7Eh+5wi/XYgB9TU7WcgKKG9xk4Y4xbsR+vEdQ4jv49uye4qr6jKMUI32vQA6kPN3tkvtS1TLVZnjQlPI/MSB8diWkXXpIGK0A7c8oK2gd4Yjs9lmN/nW+GPiqNk7RW0b1EwfMBH2kcy8pdXNyhYoOuAbsx/ZpPhXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405805; c=relaxed/simple;
	bh=4AJOQf5vgvqX5cAii8ibKLW+VtEtnKWwBG0U8INKPUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJKg21rWLotSTwDJsfGVTDMkJr3543yJYzFqr0h7YTifWsWi2eQOuOwOHjhyFNKhEy2YbTeeebhkGPuOrgFr9pcW2cX+qB6ZDkvZT5JMdY0kNpoZ9V5alJw9up3b5PfkhDNb5yDBGzzuKCwAeCOsWEWC0Z+AGYZm2zritpKSgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGczMVKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA65DC43394;
	Mon, 25 Mar 2024 22:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711405805;
	bh=4AJOQf5vgvqX5cAii8ibKLW+VtEtnKWwBG0U8INKPUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGczMVKUkELSV29AyRnwTX8hePyzeb2qCzy6G4mjg61tAQG1npyzMJ83lMum8liUr
	 +S5FJejZQADYnJOttLOrD59NH6dqgcRIy9xr1dd9vqusmN/6NXPJMgcj96ECn+LxMr
	 XukBPnXyDvoUbfsjRVKMPa6M+8HZK+tA1DvWCEVxF5pJx5+hCWl9kBU+O2qpXoTdOf
	 8nF+Z+h2sDJXUj8J8iloxoW9iMkHgXVvatM+iujOAD8Hktn0ay8QIuz2YeMWcvKrXp
	 q3x+UNRas8WznH3e0LmXZNwbQtsynz7GKRZISSv3AazXVPEGSKCTRCu0uNvL5A1fVk
	 sW4I0FoCUhZEQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Konstantin Khlebnikov <khlebnikov@openvz.org>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/3] igc: Remove redundant runtime resume for ethtool ops
Date: Mon, 25 Mar 2024 17:29:51 -0500
Message-Id: <20240325222951.1460656-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325222951.1460656-1-helgaas@kernel.org>
References: <20240325222951.1460656-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

8c5ad0dae93c ("igc: Add ethtool support") added ethtool_ops.begin() and
complete(), which used pm_runtime_get_sync() to resume suspended devices
before any ethtool_ops callback and allow suspend after it completed.

Subsequently, f32a21376573 ("ethtool: runtime-resume netdev parent before
ethtool ioctl ops") added pm_runtime_get_sync() in the dev_ethtool() path,
so the device is resumed before any ethtool_ops callback even if the driver
didn't supply a .begin() callback.

Remove the .begin() and .complete() callbacks, which are now redundant
because dev_ethtool() already resumes the device.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 1a64f1ca6ca8..f2c4f1966bb0 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1711,21 +1711,6 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
 	return 0;
 }
 
-static int igc_ethtool_begin(struct net_device *netdev)
-{
-	struct igc_adapter *adapter = netdev_priv(netdev);
-
-	pm_runtime_get_sync(&adapter->pdev->dev);
-	return 0;
-}
-
-static void igc_ethtool_complete(struct net_device *netdev)
-{
-	struct igc_adapter *adapter = netdev_priv(netdev);
-
-	pm_runtime_put(&adapter->pdev->dev);
-}
-
 static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 					  struct ethtool_link_ksettings *cmd)
 {
@@ -2025,8 +2010,6 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.set_priv_flags		= igc_ethtool_set_priv_flags,
 	.get_eee		= igc_ethtool_get_eee,
 	.set_eee		= igc_ethtool_set_eee,
-	.begin			= igc_ethtool_begin,
-	.complete		= igc_ethtool_complete,
 	.get_link_ksettings	= igc_ethtool_get_link_ksettings,
 	.set_link_ksettings	= igc_ethtool_set_link_ksettings,
 	.self_test		= igc_ethtool_diag_test,
-- 
2.34.1


