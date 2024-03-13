Return-Path: <linux-kernel+bounces-101774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEC187AB75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19931C21C32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B261675;
	Wed, 13 Mar 2024 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6QQHvjc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C53960EDE;
	Wed, 13 Mar 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347602; cv=none; b=aJdvjF07hs4jFhkZONlwIXHn0XEhXd18K8IRnVHU0aK2Zx3SQGCEFKuQ1JUH7EIEgiC5LtTGmPlYvFXpPXntS62x0vpxW3RzZ+EffS712biHb8VudQ6DayzK5X2bJHWB+PFvnaoxZpwzEmrbsLrSjD+OtmLv5Dnnf8iFvowKlfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347602; c=relaxed/simple;
	bh=NfGB84W7kSIPl3PnIMLdf/TItkTQIHgCMbPF4hc6y78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XH1gTtT5yjgfo2XFqXB5WX8TiORcAAJaKNq9V+Zqp47Ix3yahqns0Fcxu0il+TK5I1ALzakzPjt3wUer1TvgvTgXXvnUIMRanGWm6EdknDeQa27sNHvGJlhVk0RRNxOZJ4DPBA4c6a2pvI+l/Z2nB8uWYjwMgJq3NyiC8Fei2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6QQHvjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD37FC433A6;
	Wed, 13 Mar 2024 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347601;
	bh=NfGB84W7kSIPl3PnIMLdf/TItkTQIHgCMbPF4hc6y78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6QQHvjcxN/vIEREE4BZ4Di904MgjlGp0XbZ69WtxC4gEyRsRxMymma4V6ryk/dZy
	 fldCVf6+8nuLDOgWKLf2O51V3HYYmBs3k/Qq0XG9mlYiw0I6XEwDxobpDFR4HHwnOW
	 dRIzvMK2VzJiaPyzuplt0hPuQA6A4NRFU+2dkd9A+vfmNbldzmZFkX0fOkPx55QlXw
	 SyhemljiesJnf5vTEePfwIZZKLUxOEUYRwtxIiBqb7VV4hNXSwyluktrSBpd6FclY6
	 Sa6RruMVfFk8FTZSSlusq5qOQjUAi+iY+yuUmbAvO/KDLavWykrwHVuPC9yQDRzdZs
	 lPBVhsWpFBl+w==
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
Subject: [PATCH 6.7 35/61] xdp, bonding: Fix feature flags when there are no slave devs anymore
Date: Wed, 13 Mar 2024 12:32:10 -0400
Message-ID: <20240313163236.613880-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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


