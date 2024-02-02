Return-Path: <linux-kernel+bounces-50344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024D18477C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39744B23554
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2735151457;
	Fri,  2 Feb 2024 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK/4OiNo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57D214D43B;
	Fri,  2 Feb 2024 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899170; cv=none; b=SHDmjFyTSAPeoInSFz0kU/sxj1hdDchcsIGi5XWym79beZmuLob/5Tl0iYRT0rOslq0UY4XYFX0Yv2/bvm3XC+NudKIdFABEOb3AvvHdUusrMIVIUTSdLNOw9WlHdzzn4jCJB6EVGwMVGwYh9/JYUBnb7gVEUkfDPkOLBnRi8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899170; c=relaxed/simple;
	bh=t5S/eAH8/FM1OQYgLHSTUblgnLQc9xQlrOkDTw2vM2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lECqeNEg/++sizFZbgfn3A8X8NXiU/7Io6IoW4f4n8FC6BUQp+RWeG4HZ6cMOl/uxHhpd5f/7g/Y51bVouvP7/ePmoBYjFLOgOYtuttnUq6hs0V7yMd2xMPd0zdMrdoEOk+jc0MaDTNSb/gL+2UnBkbJAXhZoF7siqVluvbXzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK/4OiNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275BEC433F1;
	Fri,  2 Feb 2024 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899169;
	bh=t5S/eAH8/FM1OQYgLHSTUblgnLQc9xQlrOkDTw2vM2w=;
	h=From:To:Cc:Subject:Date:From;
	b=bK/4OiNo6j8ePFrcittXKOf2OziFTqQZw3gmDB5xah1MlvKCFggt0mVU85kYPP0of
	 runQI2ladImA0nP2RrdS2ODc+5CiVqM13QyREcYPa+vttXjeFxaHaUMLLpMux6gRpm
	 QWzkSF65rIElQOOdlLvzdmN1PWJ9pQu0xB8P3dj0qcw9/fkZvzjo1AydAP4jaWYl1c
	 PfHORKzrZV2kG1aGvCr2Szcu+IcafWh1J2QQ1B/z+PbNUobU8WWwa5v74FFVTfXPPB
	 xUbUaVgDSuahcSbEbh5uzuuo6hB9n21uxNfPyseD5ZBvTpnjK6SHoYpegMIXWIgJ/k
	 Pq4VVAaVWo2Xw==
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
Subject: [PATCH AUTOSEL 6.7 01/23] wifi: cfg80211: fix missing interfaces when dumping
Date: Fri,  2 Feb 2024 13:38:57 -0500
Message-ID: <20240202183926.540467-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
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
index 1cbbb11ea503..fbf95b7ff6b4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4008,6 +4008,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 		}
 		wiphy_unlock(&rdev->wiphy);
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
-- 
2.43.0


