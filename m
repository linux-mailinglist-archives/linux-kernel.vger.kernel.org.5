Return-Path: <linux-kernel+bounces-50426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D84C8478D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13931F23EA9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D3C15CD49;
	Fri,  2 Feb 2024 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKLqrCHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E4158340;
	Fri,  2 Feb 2024 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899338; cv=none; b=FGwa06CNN5ic2Ym3jUWMTtcnUWf3AWhoLWbQnBVzMP8/QnDK5lL/Aeyapcoobg+91pl2MKP2AaxaJ+xp3pqzhy7A/v4+9RC47uPFTGOOyoywnVU02Lqoq5wMtzdkOwahMHWmn/q0JoOK6EoVLNxpmssuxIva7O0QtpI7PtHdIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899338; c=relaxed/simple;
	bh=pfXGLPxKsKiECQhAzLCIyOfu7bxNOJVACkGYZnrW7TM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4FEbYgSaP0Ze8hMOPipMC8Ap6N7AV39mzgs1oexI5Dwn9tlO+Kej+ItIh/MTm6gyd+Sv38ip1JHnw+JHNZTry7+/MfxsS1ILDlLIVrDx4gjJr7DsN/EakMw6xxrhP7KnnkhLzj8Q4yAMGXQ4cC2gt1zHBNzSEaaKRmKQZ64pJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKLqrCHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0E4C433C7;
	Fri,  2 Feb 2024 18:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899338;
	bh=pfXGLPxKsKiECQhAzLCIyOfu7bxNOJVACkGYZnrW7TM=;
	h=From:To:Cc:Subject:Date:From;
	b=dKLqrCHwoEMLRXYZxeRk25MnaygxTjAW8e3TVkK59qgR2rL3zW/sGUdIUxls7D3s6
	 5vBx2fbdZvLrsLr1FwEqDjABGu/SKazdT/OSj1iiOKgZOmBFvaW0tRuTdDP0RMBt5v
	 IH/qiIYQa4+z9Ck4WmM8IWBPETzLWmpUmK9j9rhxXgtQFIrko88A28tf8pSoYWuC3+
	 RUDvLJEuLwwr3M+YOvs9s82736M9b7ZNXqMLx7j+r4f4NLKLmdZw9JEW4vmFtl9PAB
	 B05PssVIslXHiIw+JcftK84RyQMt5A6UpeoQtSwzdRFnDzxyPXnaViUWl/SLxIeDId
	 IQAygsn/TTGsg==
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
Subject: [PATCH AUTOSEL 5.4 1/6] wifi: cfg80211: fix missing interfaces when dumping
Date: Fri,  2 Feb 2024 13:42:07 -0500
Message-ID: <20240202184215.542162-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
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
index 0926a30bc739..494de0161d2f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3350,6 +3350,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 			if_idx++;
 		}
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
-- 
2.43.0


