Return-Path: <linux-kernel+bounces-101833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2953687ABFD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF6B218EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753DE6E615;
	Wed, 13 Mar 2024 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA19S5L4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46496E604;
	Wed, 13 Mar 2024 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347868; cv=none; b=PCUj71L65+ch9bBQNQ2Waw0d8V5oPPDA9XYQxUFD/YvxmwPi0TqfnTbCEfQvIUyrJyxX/WTVpZh7pKUXAIIxUI5wg5xpWDQXeKjx72kPIhWl6UY0y42J8xR2RZWXb8cAZExunE9voDrvYntFZamsFVU5gvm2ZBKqBhAxLs6wOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347868; c=relaxed/simple;
	bh=NfGB84W7kSIPl3PnIMLdf/TItkTQIHgCMbPF4hc6y78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXnU/W1DcC+Z1Lz3qWP8tqiS5U0TmO302+NpHDqV6RkjBvxEZ3svfY82hPbg/N9DdtMX3PlcHPdxPuS/UAG/gtyFrIRzCvCyDSXFSaBa3FzkYYMS4fNHu6LGaeX810XHAzkN76JBTcXMiUQJAKwfEqI/LpH3lip3NrbeVvS1C2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA19S5L4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3ECC43394;
	Wed, 13 Mar 2024 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347868;
	bh=NfGB84W7kSIPl3PnIMLdf/TItkTQIHgCMbPF4hc6y78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DA19S5L42pqPUieHPB6Y3HoiECe5Qx8+UXwtJJ3qIgovUoNxme/YaNddxIgKMxzkT
	 9jScKs9W3P211lfshgI66+auAh4E5R4+yPXhWJLIL4HJetrVKMDrfrKT8D+0IORx4w
	 +DLNSM4a9267DQ6Icq2S6A5HAtAbc+hc6pArwve6GzTYzQolaFklvKAnWrnPV+OEM5
	 beyUgBFXBuN6tSVg0Q42NQwanuzqffPasl7Dnb0zSiT/YYygRWJR/TN+uOjyWr7y/X
	 JU5zAMMDcYJ8CtJ6i+OkoEUvi58ETiokHqVzeBoM/SqIPuO1fChsT1f5q+slcXf74d
	 bC0HKHqu2qlcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Prashant Batra <prbatra.mail@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 30/60] xdp, bonding: Fix feature flags when there are no slave devs anymore
Date: Wed, 13 Mar 2024 12:36:37 -0400
Message-ID: <20240313163707.615000-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit f267f262815033452195f46c43b572159262f533 ]

Commit 9b0ed890ac2a ("bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY")
changed the driver from reporting everything as supported before a device
was bonded into having the driver report that no XDP feature is supported
until a real device is bonded as it seems to be more truthful given
eventually real underlying devices decide what XDP features are supported.

The change however did not take into account when all slave devices get
removed from the bond device. In this case after 9b0ed890ac2a, the driver
keeps reporting a feature mask of 0x77, that is, NETDEV_XDP_ACT_MASK &
~NETDEV_XDP_ACT_XSK_ZEROCOPY whereas it should have reported a feature
mask of 0.

Fix it by resetting XDP feature flags in the same way as if no XDP program
is attached to the bond device. This was uncovered by the XDP bond selftest
which let BPF CI fail. After adjusting the starting masks on the latter
to 0 instead of NETDEV_XDP_ACT_MASK the test passes again together with
this fix.

Fixes: 9b0ed890ac2a ("bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: Prashant Batra <prbatra.mail@gmail.com>
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Message-ID: <20240305090829.17131-1-daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 6cf7f364704e8..b094c48bebc30 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1811,7 +1811,7 @@ void bond_xdp_set_features(struct net_device *bond_dev)
 
 	ASSERT_RTNL();
 
-	if (!bond_xdp_check(bond)) {
+	if (!bond_xdp_check(bond) || !bond_has_slaves(bond)) {
 		xdp_clear_features_flag(bond_dev);
 		return;
 	}
-- 
2.43.0


