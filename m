Return-Path: <linux-kernel+bounces-50369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FD484781C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C941C22493
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8785412D749;
	Fri,  2 Feb 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZIGAeI9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A912C7F8;
	Fri,  2 Feb 2024 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899218; cv=none; b=IQOKV/6CuCy1YGIwOtjc0iPqav80PYYrKhoidl7zL8aYVQnXN2u9A0gb7drwNdioRatrosso1mZ4hENeEeVg8L39uWUHuIQ0IuW7/Pfnf91iw2Dc54QPfvaQiqfg1Nzs+965/XrWibn0ng+Tt6IWWu6vVyTAhuDOOawklpQJ2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899218; c=relaxed/simple;
	bh=4t8DjpdB+QHR7yIJIaxXvdAMCr78XlKCpw7mUAnf1z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBJTMByAHTUlI0dn83a4hXDIIudGQpbAdKcMghzP3NbUPZzS5uEIjiSVsnpD+GWjjTyjTf9XSUf49g317spazgS2NT7E5YWR8pw8FklTVznWovsjfy4cYhgbr5HEEEWWes2Jof1XBWtOY/VK0c9x0o8eoIqTjmGOXE6w0NbpbJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZIGAeI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC47C433F1;
	Fri,  2 Feb 2024 18:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899218;
	bh=4t8DjpdB+QHR7yIJIaxXvdAMCr78XlKCpw7mUAnf1z4=;
	h=From:To:Cc:Subject:Date:From;
	b=LZIGAeI9kqwQT97o9fF85FR0NRmaN+xHiWxGQeyK+QSZ2guvAuvvRpJnyCFMG0fIG
	 bSuG05yLxuTKd/jyK2HJJLgvqw/hNn4AGPjs/J64t3d1g3emfFD/p48vvmyHMomJo8
	 APLS3nqAJ1Rk2F3ovUI/Xf0fW8MjGAT9hAAaxn1h/OQbG5KlOMkMKk3nCW+EUr0h3/
	 1LYq7nVOf5odDAcTpuFmVk2iqN5oYmaJQ7zcY+3ymaVBRrxQLu4HWVM7s36ThG1g/s
	 EecahU/EFX92/9Oy1XrtWMmVCtVO7nfbZkkrSbAlL8gyXTNSnXl7ydbHY5p7yO0XrS
	 m6L8XrYUIR4hQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Kazior <michal@plume.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/21] wifi: cfg80211: fix missing interfaces when dumping
Date: Fri,  2 Feb 2024 13:39:48 -0500
Message-ID: <20240202184015.540966-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
Content-Transfer-Encoding: 8bit

From: Michal Kazior <michal@plume.com>

[ Upstream commit a6e4f85d3820d00694ed10f581f4c650445dbcda ]

The nl80211_dump_interface() supports resumption
in case nl80211_send_iface() doesn't have the
resources to complete its work.

The logic would store the progress as iteration
offsets for rdev and wdev loops.

However the logic did not properly handle
resumption for non-last rdev. Assuming a system
with 2 rdevs, with 2 wdevs each, this could
happen:

 dump(cb=[0, 0]):
  if_start=cb[1] (=0)
  send rdev0.wdev0 -> ok
  send rdev0.wdev1 -> yield
  cb[1] = 1

 dump(cb=[0, 1]):
  if_start=cb[1] (=1)
  send rdev0.wdev1 -> ok
  // since if_start=1 the rdev0.wdev0 got skipped
  // through if_idx < if_start
  send rdev1.wdev1 -> ok

The if_start needs to be reset back to 0 upon wdev
loop end.

The problem is actually hard to hit on a desktop,
and even on most routers. The prerequisites for
this manifesting was:
 - more than 1 wiphy
 - a few handful of interfaces
 - dump without rdev or wdev filter

I was seeing this with 4 wiphys 9 interfaces each.
It'd miss 6 interfaces from the last wiphy
reported to userspace.

Signed-off-by: Michal Kazior <michal@plume.com>
Link: https://msgid.link/20240116142340.89678-1-kazikcz@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0b0dfecedc50..c8bfacd5c8f3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4012,6 +4012,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 			if_idx++;
 		}
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
-- 
2.43.0


