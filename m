Return-Path: <linux-kernel+bounces-113203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9186A888247
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3326EB249AB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0188B17C6DE;
	Sun, 24 Mar 2024 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5TzMeFs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29617C6BF;
	Sun, 24 Mar 2024 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320006; cv=none; b=HcO4tGaPcCqjxW5Au5cyU46eGPHrFI+5UO1riEvvYwEAsNVUt9j8sWjBBgljvI0Dr1KmW2+lAI6ITYyMAtLWQexKWuTBw7aAeAZngWNvgP36P/aBvD/N+0OYliYo6FAiiHEiD9h8lLRHJu+x8iTaesgi8w+51XDBCd5VxsI8f5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320006; c=relaxed/simple;
	bh=Ugg1J7IKQDMYXnCywrahvRSEfKqAl3Vln5nLujV8KfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPVDOvCceebkJUQDcCWB0HlWnm9ckQL64kV1jdcRJxGPJvpZ7tBk4fi7txsLW1G3iZkF6VgFOStHbRA7w9gNs9XtDHH3nhVSF+aZn3K7RlCmT8o+aPgYvbwd2euQMj6HptC9l4XIn0EZPyrZjMu3pzfq0KHTUsWOXMOOvZkbRfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5TzMeFs reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126A0C433F1;
	Sun, 24 Mar 2024 22:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320005;
	bh=Ugg1J7IKQDMYXnCywrahvRSEfKqAl3Vln5nLujV8KfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5TzMeFsJtoT3Im4TEpQLTctddumqFkAN3up8sHX/MBLiTLDPOpWLXLrbsDabWtyq
	 SNoi5vGCIvp2ulKKugfTdxifn/x8ah7oKm/kJPnUbMxTytMugsqo0JejWCrBc5zDTi
	 iOeH0nznx2ZGm3KDTDyi25EsJjCZzElAWMZmz4vcWhlIDhqewucMEQW4RJ1X0kDrzT
	 UCJiDJXjFnZKwbEsL7AAWGDeyPYxIpnLDUPyNkYa4y2X+26aFh2Or8oS8mw1PG/JlZ
	 cjda5dCkbzoRbjoj76hr690HH11GgRAeJoqiMmkhYIlH6x0Vl/4sUt34BG4uQQHz55
	 fydaGgrLFpVNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 312/715] Bluetooth: hci_core: Fix possible buffer overflow
Date: Sun, 24 Mar 2024 18:28:11 -0400
Message-ID: <20240324223455.1342824-313-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


