Return-Path: <linux-kernel+bounces-115060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B018892F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A531F3121F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A32C13E417;
	Mon, 25 Mar 2024 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnEIyoi1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8F1802C7;
	Sun, 24 Mar 2024 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324035; cv=none; b=Fa5Wd9aXo5lpx8ufKtI7ro/UXX+2B+DqUI1tBzEt4gsbQEzt6sxAgWtMO+cpPoj1PHiypW5l1DX12EMjXedMzqmzTaGL6DxclTzngXzdCVA7UcmWTva34zDE4/fYJiIe0dDIFHUj0LcD8/40H9+bcDfsROFruiccCdW9SkYO7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324035; c=relaxed/simple;
	bh=yVN4Xq1hPzjmTAe9lqpsrKxthUFKTj3EMUvWmyoZXkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3w409eGH2OSfFRfvv958nEkv1inkU1cM1/FQvnsEl3gcP7Szx9Y0xZLxS1LLTKnCCtzvJQH0y+VQzgCkBJDch8TjyakuCX//LUUC55aBKEM7GvcI+gSTzepz4EQlwrP0sSTyNdEpR2Wi3f15cryRmlpb2IikugO9Af2yfUghBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnEIyoi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87894C433F1;
	Sun, 24 Mar 2024 23:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324034;
	bh=yVN4Xq1hPzjmTAe9lqpsrKxthUFKTj3EMUvWmyoZXkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnEIyoi1K6F3gyc7vwA7MKdupyhi7ti/3FQVZ366SkjyU9/U2AP5rN5WVG4QK09R3
	 UKirrFNyT3tdQZHTJ0jrIZKQxJg4N1OCZeoYIhRlqp+TiSAQmLywdWOWkQo5N2UGU3
	 vsCyQQM+kZzxYvbCsc8dhY5+oeln8bvISLQKgT1ocU0kPsVFh9Eq8tS6l+l5ZHoSPU
	 63tjcTjbc1Zggp7C4xq+wWjypxUP5pRdj7p6M9XSMvZplkqNdFb8pU+AsulPpvNThh
	 ZKb+YW24SFK4Yb3GRvDWl2QD1v6Un4tIkXTme0h9pjrOsIPDXTt+NXFzqiJifPlyO8
	 dgPUd/WU0lYyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Julian Calaby <julian.calaby@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 035/183] wifi: b43: Disable QoS for bcm4331
Date: Sun, 24 Mar 2024 19:44:08 -0400
Message-ID: <20240324234638.1355609-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <sergeantsagara@protonmail.com>

[ Upstream commit 09795bded2e725443fe4a4803cae2079cdaf7b26 ]

bcm4331 seems to not function correctly with QoS support. This may be due
to issues with currently available firmware or potentially a device
specific issue.

When queues that are not of the default "best effort" priority are
selected, traffic appears to not transmit out of the hardware while no
errors are returned. This behavior is present among all the other priority
queues: video, voice, and background. While this can be worked around by
setting a kernel parameter, the default behavior is problematic for most
users and may be difficult to debug. This patch offers a working out-of-box
experience for bcm4331 users.

Log of the issue (using ssh low-priority traffic as an example):
    ssh -T -vvvv git@github.com
    OpenSSH_9.6p1, OpenSSL 3.0.12 24 Oct 2023
    debug1: Reading configuration data /etc/ssh/ssh_config
    debug2: checking match for 'host * exec "/nix/store/q1c2flcykgr4wwg5a6h450hxbk4ch589-bash-5.2-p15/bin/bash -c '/nix/store/c015armnkhr6v18za0rypm7sh1i8js8w-gnupg-2.4.1/bin/gpg-connect-agent --quiet updatestartuptty /bye >/dev/null 2>&1'"' host github.com originally github.com
    debug3: /etc/ssh/ssh_config line 5: matched 'host "github.com"'
    debug1: Executing command: '/nix/store/q1c2flcykgr4wwg5a6h450hxbk4ch589-bash-5.2-p15/bin/bash -c '/nix/store/c015armnkhr6v18za0rypm7sh1i8js8w-gnupg-2.4.1/bin/gpg-connect-agent --quiet updatestartuptty /bye >/dev/null 2>&1''
    debug3: command returned status 0
    debug3: /etc/ssh/ssh_config line 5: matched 'exec "/nix/store/q1c2flcykgr4wwg5a6h450hxbk4ch589-bash-5.2-p15/bin/bash -c '/nix/store/c015armnkhr6v18za0r"'
    debug2: match found
    debug1: /etc/ssh/ssh_config line 9: Applying options for *
    debug3: expanded UserKnownHostsFile '~/.ssh/known_hosts' -> '/home/binary-eater/.ssh/known_hosts'
    debug3: expanded UserKnownHostsFile '~/.ssh/known_hosts2' -> '/home/binary-eater/.ssh/known_hosts2'
    debug2: resolving "github.com" port 22
    debug3: resolve_host: lookup github.com:22
    debug3: channel_clear_timeouts: clearing
    debug3: ssh_connect_direct: entering
    debug1: Connecting to github.com [192.30.255.113] port 22.
    debug3: set_sock_tos: set socket 3 IP_TOS 0x48

Fixes: e6f5b934fba8 ("b43: Add QOS support")
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20231231050300.122806-5-sergeantsagara@protonmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/b43/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index b4701846caf3e..e466324a1fd24 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -2585,7 +2585,8 @@ static void b43_request_firmware(struct work_struct *work)
 
 start_ieee80211:
 	wl->hw->queues = B43_QOS_QUEUE_NUM;
-	if (!modparam_qos || dev->fw.opensource)
+	if (!modparam_qos || dev->fw.opensource ||
+	    dev->dev->chip_id == BCMA_CHIP_ID_BCM4331)
 		wl->hw->queues = 1;
 
 	err = ieee80211_register_hw(wl->hw);
-- 
2.43.0


