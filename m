Return-Path: <linux-kernel+bounces-62654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A3A852408
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D920D1F23623
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4333F60DC8;
	Tue, 13 Feb 2024 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/fJToWj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE260DD5;
	Tue, 13 Feb 2024 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783681; cv=none; b=j2UPdkzMrJ2Rya7ZlgRtRJ0qcBT58JxCZutF65G/FZBMoXGJNO4ngXSoJPHkJQVhW85LuadGJo613taoFA+Bxh6oa0aC9JJtkEUkuvMwT4QfaNeXpjHFiRDyBP9RUukJxedC9vquZ3qnjqwusEv21pvp1SWQqhqyOs2uG4Wi1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783681; c=relaxed/simple;
	bh=Yq3FIRMhID6Gx/PM4CNAAcsJgnWMwmC6c5SBZ1ryYKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr7aKxqz4nDne1B+FsFx4XeKEwnj6V6Z+3fGMakAIyUhMAkb74krSW12H3hTJjzdY9EGdhNv6xZAoB3p7jD/GwW9drzOxbb7S5cgdAFIGQa7+A3niajjhelsFKilZPcGtcmgsht3pzSwEiaT276HwMBnoO4AqrQyABm8O+tBV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/fJToWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FCDC433F1;
	Tue, 13 Feb 2024 00:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783681;
	bh=Yq3FIRMhID6Gx/PM4CNAAcsJgnWMwmC6c5SBZ1ryYKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/fJToWjV14pYAqPP8J0+lcnhhnJoRu7FqeWpAe1PKhxt1qqP0CmeXre/EoT+IiPZ
	 TNfU3qaR0zCt7cOMHbL7VZV9nB2ymimphlvvQ7V+MQ9X1Dznj4gUBJqY9cO1MLDN/R
	 MCaCx5aeD2C5Juf9rb9PwaUprku+kJAU2xMoQSvfUbFl2J7Z85LA4SeDXfMUVoSwNi
	 0dRHcoQbX3v9R3fQ9rfnkh2EJLmDs/I9EddHQBuUQhwiwQSwdPpdleP0TvjZRtT1eu
	 7cWLuBliMpzBUy7jtSQaeJl/WeQBmvQvJD0MvUIIxzqUjH+CR3xBPiS/xvfNjSeNi3
	 3uAwFqIxVfTYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 23/51] wifi: mac80211: set station RX-NSS on reconfig
Date: Mon, 12 Feb 2024 19:20:00 -0500
Message-ID: <20240213002052.670571-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit dd6c064cfc3fc18d871107c6f5db8837e88572e4 ]

When a station is added/reconfigured by userspace, e.g. a TDLS
peer or a SoftAP client STA, rx_nss is currently not always set,
so that it might be left zero. Set it up properly.

Link: https://msgid.link/20240129155354.98f148a3d654.I193a02155f557ea54dc9d0232da66cf96734119a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f7cb50b0dd4e..daf5212e283d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1887,6 +1887,8 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					      sband->band);
 	}
 
+	ieee80211_sta_set_rx_nss(link_sta);
+
 	return ret;
 }
 
-- 
2.43.0


