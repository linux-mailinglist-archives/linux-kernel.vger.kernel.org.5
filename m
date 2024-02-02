Return-Path: <linux-kernel+bounces-50418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 098FE8478B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7B01F2100C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0722815444D;
	Fri,  2 Feb 2024 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2RQ9jvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42751152BF7;
	Fri,  2 Feb 2024 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899319; cv=none; b=iN1AUQWFgim7cqN+ogQNmAFz3YhiaOmqHgsm6dK8eM5a3UT+XpN5XP6fUzEFwGgtAN9Tjc0One3IVRsmThaniPCx9K+N5x/wSbHazO4b5UcDxpkPuMqo+uJ0gOBj8vmH/+EA+X/He4ODHfzCPPudZm7vMEJls16hY82jwCLolz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899319; c=relaxed/simple;
	bh=+pZVXQBoHZiesEuCj9Ii8XYYPDu5xCRWSbttrOfQF08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J6dpkUAJb3ctq9EiPnoRTWiG6JWt/Ybd8+Agql1VURU074fByLyiehC8SmRhWK0Vk/xDDp1djP4uRsoQb79Ie5mHFkXwAGYmCLqQSIYR7SJ+i5fnSPinqsyzikZKAi4nuIqSKlvZXtHebMXjFAlHP12KFIGus8Wj9Rq+/63Qb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2RQ9jvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED44C433F1;
	Fri,  2 Feb 2024 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899318;
	bh=+pZVXQBoHZiesEuCj9Ii8XYYPDu5xCRWSbttrOfQF08=;
	h=From:To:Cc:Subject:Date:From;
	b=b2RQ9jvtI+V3bBPXtcoCEIrC0r4zFmSzn+FL6VS6NCfheTOYBmJMIrdab8/KsmHSp
	 DYjkzLfByC9McIL7+J46HWHkM3u0LTHbg5OJMmhsVL1Yvigq0C4kSShYsNMnu+SxXa
	 RupbAHdytNNksxSR2dhmCHeteZNxawwL1GLku9QekQfPBNqC2Za+89d9pwTXcZuO4T
	 NIIHcMH1+/gJrtynztE47dZYh1lRnHmjKDRTdP3K/ElnhfDvYavbDC2auHnk1vF/J2
	 0k0R0/SgU6syW8JX83ByGvAju7bhcWOmVkDV+BYgl6P/XTJHuD4Ytus+71l/UykgvL
	 RvJEwhmx3YOUw==
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
Subject: [PATCH AUTOSEL 5.10 1/8] wifi: cfg80211: fix missing interfaces when dumping
Date: Fri,  2 Feb 2024 13:41:45 -0500
Message-ID: <20240202184156.541981-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index 0ac829c8f188..279f4977e2ee 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3595,6 +3595,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 			if_idx++;
 		}
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
-- 
2.43.0


