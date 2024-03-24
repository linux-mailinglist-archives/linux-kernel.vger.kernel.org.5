Return-Path: <linux-kernel+bounces-115187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EF0888D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FDF294A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998A030A54F;
	Mon, 25 Mar 2024 01:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmWmZIZz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2C292B86;
	Sun, 24 Mar 2024 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324254; cv=none; b=O3XcE13lXPQf7z9DEjaGc67VK72T7r3PCTf0wl7KPcc4QQut85AGeJE4unJXhQvbwXkPUPIYmeENrQftTdO1gqPwQlCBNpqmhs3ufqvB56jMwX++0p/dtRTdxUioNeGsjbaIIaOoiwBFumMZPCBZPoyC827vBTB5HyYFjmRpkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324254; c=relaxed/simple;
	bh=Cl2+9RAXpiG4edPW2c0wWsSig5huvF3UphIRctKOF5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUh+WusRhrImDuY/nhXwXSY9UslSdmTa+YjGM1Yc7Q6eTY+n21AGDYyaj2bbM09DZCfrc31LS3IOvQY07k5f/NJ481SKxIEk2dtdZ+2Bgvs2Q0jOBXqNrKz72vTZvonCP7eXtVKUY8olqkskb2xkaX59htbtgJEj2ylhj7Ix/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmWmZIZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A98C43390;
	Sun, 24 Mar 2024 23:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324253;
	bh=Cl2+9RAXpiG4edPW2c0wWsSig5huvF3UphIRctKOF5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BmWmZIZz35nu3yz0Mq27OXutBbpNdeIYyZedgFCCIlTTjjC8am/f7R5Gqv8yVdBm/
	 3GguweXp0xSmQm33br4MvDajtpBx7Mt084dB9QY9eAb2v0Z30FJlVeLSzuXLoKIJX2
	 tjC4woc6xxEsvzlWIkWKM3HFGTeyn1dyKsSxEAQxGXvE4sM+OcJ7gPQgVvKybosVpN
	 lpGnPY4iaYVPz3+KSwDWmnJxk+XG6Sz05fWtqHXo7+qipojwHcMbH79QkDE5TprkXy
	 tgbA8pTPkYH3CRbewi5J69ZzqVYU+rw2gi8TWvbrtMQ47X4htHXmk2W367wPHkSecj
	 xklsPuitRvjeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Julian Calaby <julian.calaby@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/148] wifi: b43: Disable QoS for bcm4331
Date: Sun, 24 Mar 2024 19:48:18 -0400
Message-ID: <20240324235012.1356413-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 8d50ebdbeb1e5..6d18c01b18dd7 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -2605,7 +2605,8 @@ static void b43_request_firmware(struct work_struct *work)
 
 start_ieee80211:
 	wl->hw->queues = B43_QOS_QUEUE_NUM;
-	if (!modparam_qos || dev->fw.opensource)
+	if (!modparam_qos || dev->fw.opensource ||
+	    dev->dev->chip_id == BCMA_CHIP_ID_BCM4331)
 		wl->hw->queues = 1;
 
 	err = ieee80211_register_hw(wl->hw);
-- 
2.43.0


