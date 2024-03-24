Return-Path: <linux-kernel+bounces-114505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37D2888ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901221F26332
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7F628BD2E;
	Sun, 24 Mar 2024 23:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pxiqv9uG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5201F1FB06E;
	Sun, 24 Mar 2024 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322128; cv=none; b=I5NbfLvIJng0BncyRZ8vNEHntB/IRi/QRxEy7L6g5zvD2bCBYZnqnletYHpR5kp3hkQyAMxaRw1V8vXkVcfrxTlONnC5J2eTfnJbH9dIlFWfi/Vg9bvTMq2AB/wTmPLtUhHmUxcmmHS5UeCf76B+J4uCu/eUSq9c+NR0qmFSUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322128; c=relaxed/simple;
	bh=rlp1zgqlFRMeFawMdpiyPgj39+3VtOtrSCQXyjJiH1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IATFCCfZ3u269S9eeS3wWfTcLDC8fNqTqX75EelhQqRdUDeKwtAs+AHkupuzxyNAI9+SAdsT3p1nQeDlWaMsshtet8q0LEoeA7Kr+80xR3CQgMblPePdFlCzRZiBAspuWFcglpIMwH8TnDlgJD6R6h/b77fJeuupfYK2/Qw68uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pxiqv9uG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ED1C43394;
	Sun, 24 Mar 2024 23:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322127;
	bh=rlp1zgqlFRMeFawMdpiyPgj39+3VtOtrSCQXyjJiH1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pxiqv9uGKca4d2dzdGQ1Lmg1QVGqIaXjf3lgPSSKRlorgLrt/TJoE4B8Qo6NmQilU
	 U8Uh0XN9AlTC3YUaopqAIH7nQPclRyw9FnmRKRXXcCeljaNQn6s5BEtmnSWwm8zipw
	 7J35u3cSxLVt3p0ijt4dPGHjKYyn/YBzynxg/EhPeesvdpRMGJxnhfzccLk9x7TyGi
	 2hW7hfAucfNYOGRcxhJRmWKq+XnsLZIiLkwwRZ9uor90/G+GfiwK4mGqrBFRf42Byk
	 Em4TVhG5rPslo5xVyjWLd7fOLmp0PwoYD26quLq5ILGsIhlZsuYmCx2QZOhlavpovM
	 PIFNc1QkaQzAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 203/451] Bluetooth: hci_core: Fix possible buffer overflow
Date: Sun, 24 Mar 2024 19:07:59 -0400
Message-ID: <20240324231207.1351418-204-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index e0c924df13b58..88e9d7e0865a2 100644
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


