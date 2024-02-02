Return-Path: <linux-kernel+bounces-50407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BD2847896
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400611F25E6D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9948E14F9E6;
	Fri,  2 Feb 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYa1MMCm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434D14F9C4;
	Fri,  2 Feb 2024 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899293; cv=none; b=PWpK0wkuOc07F0W13e5JX0fuonNoZb6Xes/4hVeUOwRZDPz5FIitjZO3sHfIqs+D1YQI+18Yt+Nj3dvRZsIQZJRGHXkpxAtVf9ROKhWNGx1cH/euIz8VjpO1sU4vvHaKKdZXdfFuvEhjZ59FGf3Ws7nUWXN2TckgvRqNXrDgnvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899293; c=relaxed/simple;
	bh=5ISynWo/uGDEb3bjigGlvVmcBKeLKm95vVx31dqdCDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nb1usFbGgd15F7RLsmZar+W23iVTjD6ZbggFg7+NHuZfKIT50C/uQQ5s1K94H2yDNx5JKWxiSBtEroNHqiO/qMrnKHzifsrmtpkYcLM3+FqA+vtDwt6LTTzq/qdXC1NA2mBUF6vj6Rndi1gFR9Ih62zzML4y6VY5ynQxr7aJNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYa1MMCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1DDC433C7;
	Fri,  2 Feb 2024 18:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899293;
	bh=5ISynWo/uGDEb3bjigGlvVmcBKeLKm95vVx31dqdCDU=;
	h=From:To:Cc:Subject:Date:From;
	b=pYa1MMCmV8fiAxLQMdDJyFLPX1LBaOJDfmPjtufTziy2yoiMrfOOW3C7KFV95zH+j
	 gUjYrVG1L1UJZ3zYS0nUHw95vqSbhYBMxOSrTCCPkPXFQ9bFNq5zT7DsXA3Q+BK0Sn
	 TPomByGarMYawSXfk2wcfFfny8wJCjk5sKv7jY1AhfhKmLUM4oUE6QICSeLg8mR2S3
	 wav+VF0ndIVqj0f5Q4N/9mmdgEn/by6Vz6XFj7r5l4qT9G8eQ1/rGT9yzb5WS9JlTS
	 sZ+wWUHcEI0S/lTuQW+n8+rVXJ94/2S0J36txzq/f1vSNcfo52gVPA9bR7/Z2GLZBz
	 hvbc5NxaY+eqA==
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
Subject: [PATCH AUTOSEL 5.15 01/11] wifi: cfg80211: fix missing interfaces when dumping
Date: Fri,  2 Feb 2024 13:41:15 -0500
Message-ID: <20240202184130.541736-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 82b93380afec..4a8b701440eb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3737,6 +3737,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 			if_idx++;
 		}
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
-- 
2.43.0


