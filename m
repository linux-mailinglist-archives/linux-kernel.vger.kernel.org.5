Return-Path: <linux-kernel+bounces-118115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151D888B428
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461201C20E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0985812882C;
	Mon, 25 Mar 2024 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTrgMTzi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EED6E5E1;
	Mon, 25 Mar 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405803; cv=none; b=MLjmpJAU4WfBtSSaaR6SCXJ+RvYFXQGP1p2PpkoPSMVBtdCZUNL323GdyaWFlgRgBR1zCXxax8UkXT/bsb7Wk+aL4ucEatvjg3KXWpGrmZuoy4CCIFA0jg1KIjGtVPsEm3vMuJzNrwcF+sxPdXV5+vVoz5w4Iqj/XGojKZZyqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405803; c=relaxed/simple;
	bh=4KsogMxOnNi4o94Zor1uvaqS/A0cfHOQgy7yenfTfDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sE0fAersqYgF8Ypt9ha/HRVgd/EJjkEgL1Bq15IwSb80PNgR8+bROGrbYe7UqKZfnUkF+W+8PuZ1/YE9l8osxeTUzOW7tTdPidjxj3HQhsn1QT9WjUXMFClzi1vPY64BhRvzMEhvTqjGcaKdKSE6JKfxhlmJBLHURFBrcsZqfq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTrgMTzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FEFC433F1;
	Mon, 25 Mar 2024 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711405803;
	bh=4KsogMxOnNi4o94Zor1uvaqS/A0cfHOQgy7yenfTfDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZTrgMTzi4z13sOnAJDGuwJ5KfrodFzM9Z3f3xfczMrulYxBbWBMsvC8loPtYtubYI
	 +BDRQ+znulUNxSeI4O0UYI3k1ytrojfpDPB7/Sh0y9WIgDJ9cduRVcAbWzD1NBu/Z+
	 o1d50aQZHeK7zhaEWagboDxOCgSSFWE/PJmr0k/4vm2w9q02zdTMNj3ZP9ATjvJLSU
	 hJn8TijL6+4F6virrUKyxX+cySj19kQ0t73uIuk5bLyK7GxI7x5XXeqWh5VmxcCCnJ
	 AyQo5i8d7M7DfOZLc0c4LMPZBjzVzZ/kxAPp7uR2dr+SdVyE1L2CEN4g7PKyZFsJ6Q
	 gHK5LWy5/d/jA==
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
Subject: [PATCH 2/3] igb: Remove redundant runtime resume for ethtool_ops
Date: Mon, 25 Mar 2024 17:29:50 -0500
Message-Id: <20240325222951.1460656-3-helgaas@kernel.org>
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

749ab2cd1270 ("igb: add basic runtime PM support") added
ethtool_ops.begin() and .complete(), which used pm_runtime_get_sync() to
resume suspended devices before any ethtool_ops callback and allow suspend
after it completed.

Subsequently, f32a21376573 ("ethtool: runtime-resume netdev parent before
ethtool ioctl ops") added pm_runtime_get_sync() in the dev_ethtool() path,
so the device is resumed before any ethtool_ops callback even if the driver
didn't supply a .begin() callback.

Remove the .begin() and .complete() callbacks, which are now redundant
because dev_ethtool() already resumes the device.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 99977a22b843..61d72250c0ed 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3272,19 +3272,6 @@ static int igb_get_module_eeprom(struct net_device *netdev,
 	return 0;
 }
 
-static int igb_ethtool_begin(struct net_device *netdev)
-{
-	struct igb_adapter *adapter = netdev_priv(netdev);
-	pm_runtime_get_sync(&adapter->pdev->dev);
-	return 0;
-}
-
-static void igb_ethtool_complete(struct net_device *netdev)
-{
-	struct igb_adapter *adapter = netdev_priv(netdev);
-	pm_runtime_put(&adapter->pdev->dev);
-}
-
 static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
 {
 	return IGB_RETA_SIZE;
@@ -3508,8 +3495,6 @@ static const struct ethtool_ops igb_ethtool_ops = {
 	.set_channels		= igb_set_channels,
 	.get_priv_flags		= igb_get_priv_flags,
 	.set_priv_flags		= igb_set_priv_flags,
-	.begin			= igb_ethtool_begin,
-	.complete		= igb_ethtool_complete,
 	.get_link_ksettings	= igb_get_link_ksettings,
 	.set_link_ksettings	= igb_set_link_ksettings,
 };
-- 
2.34.1


