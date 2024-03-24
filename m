Return-Path: <linux-kernel+bounces-113768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E845888682
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603671C25A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F91F30CF;
	Sun, 24 Mar 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqgAqi4i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B61465A6;
	Sun, 24 Mar 2024 22:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320781; cv=none; b=fNQ2wEf0p3ttQGpFYApYrJKLA2pF+p3t7barw5RKJi5qDOz+8LPlB4RBm1NJAA2lwstwcf95CtmEwRqYMRI8C8RBFBmRkAnxNSjjtxvLuMZm3S9vqHejevl+kME3obq9aOHwIImoU3m9HGRWzuTfdgmdI4Kf/QI/v42O+EvNJQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320781; c=relaxed/simple;
	bh=n0ZZGalvuA0PD6jzMmVDBM2mpyQqpmLP63G0KklBvQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNdTW1SYOrqDjJ1Coif0Iy5lHsNJNVixUyH0KUUfsniQoJ9s5g91y3q9hF+0UNnru5zO/fajBPPPfY2beW7/41v840TLPGSVaKnxWMbYHHgC01AoBKr5HtukNfPCsRiWlVceEC9/Hoyu+uZ1B9S/yz+LyCe7YDUTinklNgghISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqgAqi4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CD5C433C7;
	Sun, 24 Mar 2024 22:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320780;
	bh=n0ZZGalvuA0PD6jzMmVDBM2mpyQqpmLP63G0KklBvQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqgAqi4iTFYdfxkfkXE17OpgR8hrkLM80qZrs5UdRgkDAIvWLfS1WbJJjsZYIXNkv
	 IBgdo6krif8Gg7F/fPIeb9ClnOY85ws4DZoG26Iw+aTKEL03btzuxQwJ0481PYkBVa
	 WRlkVBs9Vpp3PBE9zdJVS5xyE2IzPuvINFSGhxZlOxCf2ORtvbGsWsN0EHiBHZkoRe
	 jSzljV6Q9V0zsDdAEY1x9WIw7lbkJ35LUfo2ABP2PbN1iEiNKeP7QZqEnBj8z6iUHv
	 j6pGksThphGS9dp2T/VMBn2/3cBklyhnDgIx3K5DrUV+nDVEYevyOZGm14AF7FpdRG
	 nDjrHmGMShXsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 343/713] Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
Date: Sun, 24 Mar 2024 18:41:09 -0400
Message-ID: <20240324224720.1345309-344-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jonas Dreßler <verdre@v0yd.nl>

[ Upstream commit 968667f2e0345a67a6eea5a502f4659085666564 ]

With commit cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED"),
the power off sequence got refactored so that this timeout was no longer
necessary, let's remove the leftover define from the header too.

Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bdee5d649cc61..f7918c7551834 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -437,7 +437,6 @@ enum {
 #define HCI_NCMD_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
-#define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 
-- 
2.43.0


