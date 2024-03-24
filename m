Return-Path: <linux-kernel+bounces-115928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D66889C44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9930FB21BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B3538C54F;
	Mon, 25 Mar 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="durK70k0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112C149003;
	Sun, 24 Mar 2024 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322120; cv=none; b=bNJgHrlMqta9lB2DiPVfqEix+91iL0JNECeeqz0a25uadG6/QFUIv7jx4c+IsGE/argtyGJH9Iya/jkZxftCtnx76ha9Rzfr2oKhoFW+pKWWHVDvW9WfuED3wSdO/dIPV59m0ddhqpjAbMIkTBmUXWvfeu/waJ6G4J4+5m0m1Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322120; c=relaxed/simple;
	bh=McDveSi4SWayjEssORUvws97Uwz2dL9h7T4A/DSVdMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2AV86+LmTwbYGIp06ny8RnYCY/PIVvcp9fn2Ioi2kllQfx2g+SENT7w+TNS2Kr82okWexphJunTx3hjjrj5zTwitZDnsunYjbPifcYkMzlAK2sW0P3iLHd5QvxxyDrGH1zPcNYFvu0dyiq/zCU60k0wS26mFndp0B5s3aNtY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=durK70k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F4AC433F1;
	Sun, 24 Mar 2024 23:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322119;
	bh=McDveSi4SWayjEssORUvws97Uwz2dL9h7T4A/DSVdMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=durK70k0hCE1OmCJ9xfCDn4OkBHxHuJty19QeI2h0E9WZHMjC5f8jf6Tkxp7c7Ob0
	 qAh0PR1TOl96OZc5cNJ43PUx/f8ugqPoV72BJ2HnlEt7KYJOoXWA3dO5U6ivm6mf2m
	 31tVUGlySoTj+XGxJc4RO6aOxLKbWZB68XJTwmJ0Fi1dbXEpHJwovIt2i1jRtV2Fm3
	 0hJNmeTtU4vJtbHqZZFQ2Q965hTgTYXVpvVJmeiAAoSlobiWqBhHO52JAFxLJ0+EEu
	 qwcFuHPTEWfopZIdjAp20o/qY4CuRxYvg+LNyYpttHcbPEyr3gIdsIzG4xVaMJumlq
	 SXATX72HqPf6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 194/451] Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
Date: Sun, 24 Mar 2024 19:07:50 -0400
Message-ID: <20240324231207.1351418-195-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index a674221d151db..c69e09909449f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -416,7 +416,6 @@ enum {
 #define HCI_NCMD_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
-#define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 
-- 
2.43.0


