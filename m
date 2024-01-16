Return-Path: <linux-kernel+bounces-28007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C4082F8FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DF628A457
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926C928E07;
	Tue, 16 Jan 2024 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaspo8Dw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45D5C21D;
	Tue, 16 Jan 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434824; cv=none; b=PlKWp8T3Ckw7nK7hpyUZwkmaJGIEnErw1PCWdZp3QY++6nkRdag3rmNZZRlrEX9TM8td29UlHgxf6MiYEeDYhLWNaiUc+Z1dFSt+7Iz04OqUT0tx6yhgLoTloVE+vfjkw/7YbfhnPpIQy+epgjQL2ugI5yD67krBRf9x6RXJyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434824; c=relaxed/simple;
	bh=vOorb5RvrAicwYx6o5qfjkNj5zblLTyNxDLwkLDqWec=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=P+9MpqtFIsIM7UkDltFwJuXdv0+nMcHTAbUMb+TwafGwNZZkwbK8lobk0JiASN03w2Sp3+6TS2S7oyvhed11DRN2ztmBe0lPu+ha6RMXHndDLq5ZfU06bQFs+17lbSNETB2ieBbUpkyfWQkE23xtfvVKWbSZAlwB6vo1iC5Dui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaspo8Dw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F13C433F1;
	Tue, 16 Jan 2024 19:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434824;
	bh=vOorb5RvrAicwYx6o5qfjkNj5zblLTyNxDLwkLDqWec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaspo8DwIeAJN//ZzXbdME6KVeX5egoNOPMSVQ21SroCw0K0h8HFvVaAodHQwUHMu
	 lAvtSZXuDkdWrw4VirMfHwoszL9/pwRCaQ9CqCwWes1CpfC+pYJmbAdCVnqDAsMtyN
	 bXRgpgc1vefo6FPYZiSi2H4mCuQo8D4A0vmx9gL8LwEP395v2DUsKYQ2USDao0BK8i
	 9iXxFp3E/w5+scUSfYPpyjwSKxnnSE2Lm8vGFLrvByWeyD7G3STDbDTgmT4J9j7Hdv
	 NB4Ae3z5z3AOKk565xZ4YLPhab+2i8heKsRaLlTz9dmcjS+KstvoTVPbslGUdVcxmz
	 z1DZEsFGdrs+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: clancy shang <clancy.shang@quectel.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 095/104] Bluetooth: hci_sync: fix BR/EDR wakeup bug
Date: Tue, 16 Jan 2024 14:47:01 -0500
Message-ID: <20240116194908.253437-95-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: clancy shang <clancy.shang@quectel.com>

[ Upstream commit d4b70ba1eab450eff9c5ef536f07c01d424b7eda ]

when Bluetooth set the event mask and enter suspend, the controller
has hci mode change event coming, it cause controller can not enter
sleep mode. so it should to set the hci mode change event mask before
enter suspend.

Signed-off-by: clancy shang <clancy.shang@quectel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9e71362c04b4..5c4efa624625 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3800,12 +3800,14 @@ static int hci_set_event_mask_sync(struct hci_dev *hdev)
 	if (lmp_bredr_capable(hdev)) {
 		events[4] |= 0x01; /* Flow Specification Complete */
 
-		/* Don't set Disconnect Complete when suspended as that
-		 * would wakeup the host when disconnecting due to
-		 * suspend.
+		/* Don't set Disconnect Complete and mode change when
+		 * suspended as that would wakeup the host when disconnecting
+		 * due to suspend.
 		 */
-		if (hdev->suspended)
+		if (hdev->suspended) {
 			events[0] &= 0xef;
+			events[2] &= 0xf7;
+		}
 	} else {
 		/* Use a different default for LE-only devices */
 		memset(events, 0, sizeof(events));
-- 
2.43.0


