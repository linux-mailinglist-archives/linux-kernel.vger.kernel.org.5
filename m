Return-Path: <linux-kernel+bounces-50391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F2847863
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDB61F2AFD2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963CC13A896;
	Fri,  2 Feb 2024 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNjKQmqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06513A877;
	Fri,  2 Feb 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899260; cv=none; b=lQ77pOevxxNXykWAw/frAYnrFUU1rK4KPwjWaovnW3Gc46G1GMMIDSPgSl+IbNO8AkJZjWpA0cmLHFb53ImtLr2d/+/qL2o/ZwXA9C76J9CkTFi7yApxHX/q6lZWuUOJ6ypfYOBduMzYJcjEu64X0btuMmjhNtiWobSsuCSMMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899260; c=relaxed/simple;
	bh=VLn1sO4pM34hjjpJhx+QTICPii2qOjfJcRQSyH4Ja6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/vWBGqgHZvfod4ah6pC2l4LwJwslFPKofMkhRX1C4lpeNDEQCd61orKrUvFkbBQ4IYbIshq3UDfYr2V8tqmPXqlO5bHQZMSF/c+btQVcD9MdxEoOjOx/0EwaaVYJdOp86UIyh8uAWd3vQiRTK+SizQ3Pdqq8zk3OtsJ0x1J1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNjKQmqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C03C433F1;
	Fri,  2 Feb 2024 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899260;
	bh=VLn1sO4pM34hjjpJhx+QTICPii2qOjfJcRQSyH4Ja6k=;
	h=From:To:Cc:Subject:Date:From;
	b=eNjKQmqSWLhE1tqo/6pNLCJ0fqCE6irgCuNctrziglEwac0coa8qc/t2gkqoFbn8s
	 Vq6lEhyJyUNADyC2f+3r5Vaz86V3ZfqvdlogkrTEPDSZ+Ur6KU16Dp4lfYrz4qeRjt
	 roQtQtL3yOF7sLptvMnrCxhOCPEXwCMMLU0cz8FverFfa0ehualeVh0mu6uuK754yG
	 2dheoCiRA3LlqyaxtE2qravvI7LwMqgDcdFhw7LSfaX5MUpTQ3jpR1joP4XyW/Hz3M
	 M0Hwu1lz8eBS1+WjLPo5Hp8oPtQfi6MfnHl/CqjLpo8VNN0KRvsjdVnB9x8GugPIg0
	 sYGD341k5ming==
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
Subject: [PATCH AUTOSEL 6.1 01/15] wifi: cfg80211: fix missing interfaces when dumping
Date: Fri,  2 Feb 2024 13:40:38 -0500
Message-ID: <20240202184057.541411-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.76
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
index 70fb14b8bab0..c259d3227a9e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3960,6 +3960,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 			if_idx++;
 		}
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
-- 
2.43.0


