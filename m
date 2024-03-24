Return-Path: <linux-kernel+bounces-115930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5355D8899CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59091B20AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779D938BD17;
	Mon, 25 Mar 2024 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAqsYNdQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52414227E1F;
	Sun, 24 Mar 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322124; cv=none; b=R+jH3rzbwlih142XBkR/mrcXi16lxVAYonjaU7LUAulzlYqqd6bfcDYZO9etywbyP1OMYYBEQG+nG0Hnscv/vGy3queyyiXWEn5YCDPikYhbv/VihEA5m7hg3zBHHEVgthgDmheaSR/X3sgaHPAPQ1qHI0InuV4N+/w2KAM3G84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322124; c=relaxed/simple;
	bh=N6bT4bWwxfuxl6esFfMfH/uw5uKXoOYPT/octj3dLsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRR5RcAJnKCac022sWyqND63Pufux9fyjrlhbXo4qfkvgnwGj2a0zEQmW72OcY6CkACCYvbBdPLHN+qx4Lzc3DZTxZ/xDwLyGFsWFUb4C9XYvutSUwu5jIGF0gtHYERxavmjwIEqv67+UY1FkP3sr6Bl3p5OmIjAgzAPb//fZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAqsYNdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4C7C433B2;
	Sun, 24 Mar 2024 23:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322123;
	bh=N6bT4bWwxfuxl6esFfMfH/uw5uKXoOYPT/octj3dLsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vAqsYNdQL3dw+i58SwNl3XVucN2zuwsSVKHj2X+dASyhbNo/cUPEuajp1WLpbrkye
	 Wn8H0EfEn566IMtOFh+zjIfHCymxE2ucVJKx7sZkRe8GOMh03PAlw3Cc/agRLR/6Si
	 x2OQ41ttkWlr/WGVbyt8iFV1ANWTMOjaFvnwBV8+eZxybOwt+J1x57Qw0hHfVbokGU
	 JUHkDfAct9uVIDcjzT2HD/5PpKWqrITUgdVtw48SW3yN0oO0YUSyevDwRqlA6ExszM
	 dk67VIEO1MFetzIpRVA+KeB6PW3xxx11t3R5GD3sZFy6DE6AWhvhxWjYFRyC6gwFoT
	 8CvC7hlGPbrQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Archie Pusaka <apusaka@chromium.org>,
	Ying Hsu <yinghsu@chromium.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 198/451] Bluetooth: Cancel sync command before suspend and power off
Date: Sun, 24 Mar 2024 19:07:54 -0400
Message-ID: <20240324231207.1351418-199-sashal@kernel.org>
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

From: Archie Pusaka <apusaka@chromium.org>

[ Upstream commit f419863588217f76eaf754e1dfce21ea7fcb026d ]

Some of the sync commands might take a long time to complete, e.g.
LE Create Connection when the peer device isn't responding might take
20 seconds before it times out. If suspend command is issued during
this time, it will need to wait for completion since both commands are
using the same sync lock.

This patch cancel any running sync commands before attempting to
suspend or adapter power off.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Ying Hsu <yinghsu@chromium.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 3 +++
 net/bluetooth/mgmt.c     | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a8932d449eb63..a7e6ce2e61c5e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2838,6 +2838,9 @@ int hci_suspend_dev(struct hci_dev *hdev)
 	if (mgmt_powering_down(hdev))
 		return 0;
 
+	/* Cancel potentially blocking sync operation before suspend */
+	__hci_cmd_sync_cancel(hdev, -EHOSTDOWN);
+
 	hci_req_sync_lock(hdev);
 	ret = hci_suspend_sync(hdev);
 	hci_req_sync_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a80bf9c42c2ef..a657dc1d4ec7a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1401,6 +1401,10 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
+	/* Cancel potentially blocking sync operation before power off */
+	if (cp->val == 0x00)
+		__hci_cmd_sync_cancel(hdev, -EHOSTDOWN);
+
 	err = hci_cmd_sync_queue(hdev, set_powered_sync, cmd,
 				 mgmt_set_powered_complete);
 
-- 
2.43.0


