Return-Path: <linux-kernel+bounces-28080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFAB82F9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0AC1F260E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFAA2E648;
	Tue, 16 Jan 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef01+Zlo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B114CCE3;
	Tue, 16 Jan 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435055; cv=none; b=atBIS5/aNd8imayDqXi8Tpx7+MlNsHNnSDc+uS1NOYRZDNnhTfxHQPaxNKQNZUXNYWWJGU6nZ930Jl+x4Z6wy9Hl5j/gOcWxnrNr9ff76uOjHc1mvZiQuWNFd6zWnk4sJqvxzWv9vsdovAzvzB43GvjpUmSzM3+ULCZBr/myNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435055; c=relaxed/simple;
	bh=fRlWzUmlvQbjQwf27FMkWblDODjRQnHCaPoIB/9Pm/8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=HwTdP1CQCWSe8ll7p7GUEJOwPlq/OM/iEA2/iwlIRzAU0a41D0nmvTnXgGByacTBBoBvK80X0brfUf6KNKDCUGX5QkHW7hms8xANVWAa2imB1Zsp0VXKZsSPQ75F5f10bkwnkT3nz1WRGMangEZtdjColLViDaLYdj2HNlzS9js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef01+Zlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225AAC433C7;
	Tue, 16 Jan 2024 19:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435055;
	bh=fRlWzUmlvQbjQwf27FMkWblDODjRQnHCaPoIB/9Pm/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ef01+ZloYNU0/Dahulp1BqVjpvRKZswnjjMuXvaMXxmPSCEHKME16cPg6HggWA+sB
	 YcZh1WEsPhEHT3mHXky3424a4ChduLbjelsVLzllhCcPkyMh5rE8gdD8O9654R4c1q
	 U0wGKqAbyADGI2T0/dXOcLi8kgeE145sl2yPXr7efnKzZDlQBoYVt3k4qRruNNDelg
	 2bLbNZuyZnc5NvpXw0ExkURWA9KA+JCZ/rnI7oiX64UWTcJss7IUIPSZHbjxufxxlV
	 E/g5qIYlxSoykaZuIuq04LSXpKMHb1j897wrXmiRHIId0OFLnWYF/zt3mbdDY22G1q
	 EGH/exKcyZW3Q==
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
Subject: [PATCH AUTOSEL 6.1 62/68] Bluetooth: hci_sync: fix BR/EDR wakeup bug
Date: Tue, 16 Jan 2024 14:54:01 -0500
Message-ID: <20240116195511.255854-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index d74fe13f3dce..45d19294aa77 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3780,12 +3780,14 @@ static int hci_set_event_mask_sync(struct hci_dev *hdev)
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


