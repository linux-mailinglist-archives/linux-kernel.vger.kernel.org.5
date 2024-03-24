Return-Path: <linux-kernel+bounces-113779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9297888868F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D19C28EA09
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A735C1F6184;
	Sun, 24 Mar 2024 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po/iMdFI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357131E3047;
	Sun, 24 Mar 2024 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320791; cv=none; b=LUk1ppco0mGHQc+2s13+7YM7mtPLpKZSLrZo6CChkghtMAkGcymrEUnqP90q8aU9uFgIzAHDz7y6VH3DKTtPXe10v7rboBFCIG2sirv25qfiCqOuH5ev3hX29hejcAk4i5bqtz6TBwz9oNVBdNtVIW9alKDiutsGs7nid9ewxDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320791; c=relaxed/simple;
	bh=Ugg1J7IKQDMYXnCywrahvRSEfKqAl3Vln5nLujV8KfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olcrsP9QF8fzJAwg3CP6WZEYVjHw61KMtgzlLERx5CyBHvAZdL75abqVP25skUfFhO8wzt784oq1BEG+Tw5w4Z4UoBr+ZrESKc8zxZvt1ue6JgWFLcWJusbZJILwiQQUk+dwUxzjucZ8pDNKtlKPL8iF0KtD5qYpdaUgpwL9eE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po/iMdFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8814BC433C7;
	Sun, 24 Mar 2024 22:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320790;
	bh=Ugg1J7IKQDMYXnCywrahvRSEfKqAl3Vln5nLujV8KfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Po/iMdFI6xzrVyB0QYkw0jHKP0mxhRobQcLFPUQDH0gQf9rdN0S3AzM44NVdDGh+J
	 iqw4ROBUmRcKqL+XaryKO9+YqGOEWtZ8VptiFa8Ubnr12CfLVSYu2h6EKTSdmovpt1
	 NoKEq4CiZ5wOC8JtfukZk4ywj20a/GTROSbwQYoFGGhy+HmyCxrTv6grRyjO1r8uIE
	 kegtqvnTD4XFImW6zyQylWQpz1f5V0bS6fRd/Od8QpyDKx3oyiuxE8aStA4jis5l8Z
	 PkafpxXEhtYIejtKG2n6a6iUv+JnIdOCeZJ/kk4u+Po8YigGxOCUEqWW25CQfxGEkT
	 WJh6P4WAh0xdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 353/713] Bluetooth: hci_core: Fix possible buffer overflow
Date: Sun, 24 Mar 2024 18:41:19 -0400
Message-ID: <20240324224720.1345309-354-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


