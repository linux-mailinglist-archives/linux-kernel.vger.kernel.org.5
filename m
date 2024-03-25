Return-Path: <linux-kernel+bounces-118113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B56A688B425
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FA31C39E80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE386279;
	Mon, 25 Mar 2024 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atuGH1dk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6930882877;
	Mon, 25 Mar 2024 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405799; cv=none; b=Q6llhT98vO+r8XxRoN3sNEIxDvFMi+FDqYDW1GPQ6PrcVW+TXZmVKXNEdEfohq2lMFkC0i3T74slejnsZKTI8HFA4cTLABC58QfH3q7UOiSm0Xi8GuvGqUmgq/c3a6TXowpGAlb4vdUXWxR/LStD/muronbK2hd8KjhrT3tkbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405799; c=relaxed/simple;
	bh=s6f0H6C9JKUP0UFu/98JgZPoNS9zucvQkAEttBGZoDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rw+QsM9v4po1ktFuItSv4iCfS1RXafOxOWGjLOheNhwjaWywkc7SmYkm5aYZvY1vFWsThelmW8L/OHHUVnfl+HWO0M9eUy5TDc/Lb8KVdgkKU840etCPfsigKyZTKfSKxs2oLHcxCQhXJYgKB9T6ITHKiG4vIYVF00Y/nPFEr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atuGH1dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34CEC433F1;
	Mon, 25 Mar 2024 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711405799;
	bh=s6f0H6C9JKUP0UFu/98JgZPoNS9zucvQkAEttBGZoDY=;
	h=From:To:Cc:Subject:Date:From;
	b=atuGH1dkaJFc6beHU9/dXrtXnZVohJuLwacVykwe7JIcmAVH5e3J1KxmkEAbeugkF
	 DgKyPy0nETCy+CO7aO3A0AJYTPlWC3KigEur69U9yJeAL+t+vFhmxLHGhpCwj6WVdG
	 q//063yDQXIo1H1a/2ysO1wueZ5PFmVDV3eRSraUD4ixrraJ21iKzmL5chHT2dOVTB
	 3v/JzlB5MHuurUelrCGzwIZ/ZkMIqHgwxqyh6Yg0LmZ7bn3p+uTSk92LBsrcCZouDn
	 mlWOMaM3I0kyyM/qX2Bj68xJQfkAET8j8pwCSUGhVuORqd4t3lBwhksArarmov6ZRx
	 vY2vpxxClIVqg==
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
Subject: [PATCH 0/3] net/e1000e, igb, igc: Remove redundant runtime resume
Date: Mon, 25 Mar 2024 17:29:48 -0500
Message-Id: <20240325222951.1460656-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

e1000e, igb, and igc all have code to runtime resume the device during
ethtool operations.

Since f32a21376573 ("ethtool: runtime-resume netdev parent before ethtool
ioctl ops"), dev_ethtool() does this for us, so remove it from the
individual drivers.

Bjorn Helgaas (3):
  e1000e: Remove redundant runtime resume for ethtool_ops
  igb: Remove redundant runtime resume for ethtool_ops
  igc: Remove redundant runtime resume for ethtool ops

 drivers/net/ethernet/intel/e1000e/ethtool.c  | 62 ++------------------
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 15 -----
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 17 ------
 3 files changed, 6 insertions(+), 88 deletions(-)

-- 
2.34.1


