Return-Path: <linux-kernel+bounces-50432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DD284792B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA91B2EB0A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1211D15CB62;
	Fri,  2 Feb 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na8nKRuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461061308D2;
	Fri,  2 Feb 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899352; cv=none; b=ECeLdW15H/O+02LAOvtTojyoioG8c8yzYfpHWht0SCWm/Ip19AjOMZmJxgcW7lW4tlCwvwHiqFv0G8b/0KDCS3zbMaZobRKCEq0bA1dHD2OK0kZykkD8giIkmFtmBKuX2MYnz0DzdV8v/Pbsc6LtxasEDd1ki1bi+kM9lYqVhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899352; c=relaxed/simple;
	bh=9XSoArqLiKz3yhFYVD04GEitqqJghk8hzezLmEgg/OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMPE7Cm5Gbx6bxyK8vsYNV2c5xtrPo+9V0EC4wOnXbdbR7VVTxDmn0996w77P0vpRjOhUDI4Zk5cRKq8n47yQQpMKQXFy/w5g58w4kPDQklP0ypmQvR960CMNVqivOesINKPy3eDRucL/YAwMq3prz9X8YQqjvuoj3oBI7TXrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na8nKRuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91125C433F1;
	Fri,  2 Feb 2024 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899351;
	bh=9XSoArqLiKz3yhFYVD04GEitqqJghk8hzezLmEgg/OQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Na8nKRuNtWQWlmi/jhS7Y5lCkf4GWoWVVAo/mW0Pd5Omh1P0K7T8sI0ROnczh4lNR
	 sgOyQOuq1QqHj4Fkt90GxaDXixG+uJebulWSHUuf2mmbAnd0WeTgNK6sg3D8ibVrlA
	 CPgJhLo/Kwv7HFmkm8HLL0wXxbwYQ512dHxxPTWb9HGQT2AwS08DlKdXNpqEkZ/s8O
	 hnj6YGE8nd2WSDCpDt+97tU0BPU8WOD2jo69OXWTcchl8MBOCkpLwN5aVGD3FrB4H5
	 ifW8xur48Je6QsdgkvrqrfqV+vDSpfemuImKYJnJcHBr+TbMNdM5G84rXI4i98RlGp
	 2lNv/N+qbjbGA==
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
Subject: [PATCH AUTOSEL 4.19 1/5] wifi: cfg80211: fix missing interfaces when dumping
Date: Fri,  2 Feb 2024 13:42:22 -0500
Message-ID: <20240202184229.542298-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
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
index e33c1175b158..f79700e5d801 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2994,6 +2994,7 @@ static int nl80211_dump_interface(struct sk_buff *skb, struct netlink_callback *
 			if_idx++;
 		}
 
+		if_start = 0;
 		wp_idx++;
 	}
  out:
-- 
2.43.0


