Return-Path: <linux-kernel+bounces-115665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DE6889D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095382A537A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198D135466F;
	Mon, 25 Mar 2024 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX67PqPb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D92A137C35;
	Sun, 24 Mar 2024 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321571; cv=none; b=j8xU3LFlbcvlmPWNHMlRrUU9ADlYfCCYwAb/yDVLvoJMj90wa+s4jSCKKyyYF6Pl5gTF1npE2Sv6wi999UDkzf2RAAH4WoB4jlAvP1T7ZtvWISviNFESSw294SDZ1cm6bF3NLHPx59NZZ3ykFLVoyJFJKbdSiJNoqGa/PlTAk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321571; c=relaxed/simple;
	bh=n0ZZGalvuA0PD6jzMmVDBM2mpyQqpmLP63G0KklBvQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPJIc+Uf6Ykls6mZ5BjY9nGrzg03sROS3nNkOf1evTJyhR6yoU/rATYvGaGx4jXdn7LXkJh+b659xfeDqTGAF9cgMj9SrvETVmuRvhHW6zWhiaCqeRXnvvkN5g1wyL6jEWuk2PTsHJjas0hcFvGa2QKc+cNHzqYO5yqAa/TZ6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX67PqPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD49C43390;
	Sun, 24 Mar 2024 23:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321570;
	bh=n0ZZGalvuA0PD6jzMmVDBM2mpyQqpmLP63G0KklBvQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SX67PqPbjR7C/DskaxLUyQ1HO23CGaD8b/B4O4mnrFvAQLGHAV0rHQCCjI2GSN0WC
	 t3AA7QxTM593winP0D13EUgGZPpOm+WjNL9aMtOh47OErTfFlw201ZMlZyFk3acoVq
	 MHJRrodPMlT36231v7u3/4btEYt7gu/3rrjWPtlYaDsd+4hwuKWgKR/8CtXGXq9RUj
	 +6qQTIFEjmiakuOh8qx7eNRpAIAM1fgc490rObM61CKF7LhW9QZmjihMc3deVYbxjx
	 8eJDDgC2WqRIpuYST92zlII6+vYPvSOtlcqTZJJhI2P5nBg1tew6qviTT+iOdFKB/Z
	 PDrQlxk3bIjog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 298/638] Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
Date: Sun, 24 Mar 2024 18:55:35 -0400
Message-ID: <20240324230116.1348576-299-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


