Return-Path: <linux-kernel+bounces-114231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163E688894A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4809E1C27C20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EDB254091;
	Sun, 24 Mar 2024 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH9ZitlB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD3209E1E;
	Sun, 24 Mar 2024 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321580; cv=none; b=ayqDg1FkZ4g05RaY/+eeSF0NLFf2koM8kjrria/hodYEsFtRQFBP43VEhC/IOO+/W1aBssMRsK6Iy46NK0wDfsr+reciGgIXa/a+fmpXWgUsYMmcc5DJq01n7aqBQNisObMySyUYHQx+Oew5xrReR7JWkpd0gGkcVLZUpYsQSyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321580; c=relaxed/simple;
	bh=Ugg1J7IKQDMYXnCywrahvRSEfKqAl3Vln5nLujV8KfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0B3S2vsi/ljEsOIkBaq4UV+o8od/fhqVVQ9RxDun5jWEkdp5c+lFIxeviuFE3RdvmUYNXqfbyH27MSlSRSx7jG/tZeZDdgE0/x/9AMKJ3ktN8VisvAd7wlS3EN5kQnd9fZ9emyAmflj7ZQSIpjV0kQa3VE9+nZPA1MV3FV9Y5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH9ZitlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3057C433F1;
	Sun, 24 Mar 2024 23:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321579;
	bh=Ugg1J7IKQDMYXnCywrahvRSEfKqAl3Vln5nLujV8KfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EH9ZitlBaim/f5LdD/P2etPt1hbT3ndpZ67Y/cSF1sDJEYuIofSG/Iq+hDsvjFd1T
	 fxXf0ciN1RvF/0d9Mbk5OZ3ZGNZe0CnV1zasnzVbCM6MAPOIWXMpUIDd5Axr29xFtC
	 0SEgTFu2K0W80Qafez7E34yXA5iZQlMHdcoHl3Ylxyonuo62/AL4kdHVF7iY7BkgeU
	 pAakoL1k9tLb1C0kKdFsHxtk6xR2bJQBY5aT5XTFCuwSQ3fEwb4Y5xkl3ZjXqgNs3i
	 q3eYWNkNkcgZofxsYdhy00geIT52bILd2KpSSWppvjLAwIoQUaMzkLIoHtqaYgoh7l
	 oSZyXRTxwJYWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 308/638] Bluetooth: hci_core: Fix possible buffer overflow
Date: Sun, 24 Mar 2024 18:55:45 -0400
Message-ID: <20240324230116.1348576-309-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 81137162bfaa7278785b24c1fd2e9e74f082e8e4 ]

struct hci_dev_info has a fixed size name[8] field so in the event that
hdev->name is bigger than that strcpy would attempt to write past its
size, so this fixes this problem by switching to use strscpy.

Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 96707deef296b..85a91c438d721 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -908,7 +908,7 @@ int hci_get_dev_info(void __user *arg)
 	else
 		flags = hdev->flags;
 
-	strcpy(di.name, hdev->name);
+	strscpy(di.name, hdev->name, sizeof(di.name));
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x03) << 4);
 	di.flags    = flags;
-- 
2.43.0


