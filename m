Return-Path: <linux-kernel+bounces-116028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6DE88950D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC8F29714B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8440F26B818;
	Mon, 25 Mar 2024 03:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6D15jeP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4C276C52;
	Sun, 24 Mar 2024 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323395; cv=none; b=OddUsV1bHiJvVTXwkHUSQxRmJRMeaEIXXDNUc+09J4ksZfLg+ZPpHcJoRwFb26NS7KUMD9xIQ4zjJ4qhfAq1x/GYDhy7c5YL2/2G+yFMIo5vTLLzaxVBD8EV4zw05hBEnuVi1uftIDV+2q5DQQwh7As8VOQmPvZkOPldRJdBTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323395; c=relaxed/simple;
	bh=zWlzrrm/5wQhSozp+1bHo/83+epwrXZElVWrst8o21k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQnh+YOgMH6ec0Lx9PI7mc3c0O8mVppaO/5rQfjXjHpQAHXsg0rolXdZMEZrScycdl0E6TP8jpVGg5d4S3fIEtBX1SNI3LFb8PQFwxoZ0YzuRX3hJ4WNkykwRQ+rvxHPEYtgSRO0wpZqkDvFcGrMG4/sTOu0yZjqG2Y9RzkJ3hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6D15jeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A98C433F1;
	Sun, 24 Mar 2024 23:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323395;
	bh=zWlzrrm/5wQhSozp+1bHo/83+epwrXZElVWrst8o21k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6D15jePQjHcjKyHOqEK9QdipMOL0uYc8UBeHY6GACXglxvJv02XDephX7eZ7yfyD
	 FMX2tQqbGVm90Q3XUWfBSCpG6z+1/KwZg+eiH8Jum09x3lfaLaZIfHixA3W/xqzVD2
	 3KgMceYiiS2s0eEqqAoROM6vWAwDln58lu4lV1XropV+VhFulFg/rDItxVegqHmjVb
	 gQhmNkUp3OFhCwus8HL0mxcjo4kg78LHymXOMMHrXkRXhFtlQ+LnjTIoJnEeocEQGE
	 ISitSVrME6zS+SDbZA/jz+xSZBouT5hvBEVHcDVD/9VAvt0tVWp5dWLJTHemc3V2Mi
	 tQE4aaxmp+95g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 096/317] ipv6: mcast: remove one synchronize_net() barrier in ipv6_mc_down()
Date: Sun, 24 Mar 2024 19:31:16 -0400
Message-ID: <20240324233458.1352854-97-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 17ef8efc00b34918b966388b2af0993811895a8c ]

As discussed in the past (commit 2d3916f31891 ("ipv6: fix skb drops
in igmp6_event_query() and igmp6_event_report()")) I think the
synchronize_net() call in ipv6_mc_down() is not needed.

Under load, synchronize_net() can last between 200 usec and 5 ms.

KASAN seems to agree as well.

Fixes: f185de28d9ae ("mld: add new workqueues for process mld events")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/mcast.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 0ea7d97cdc025..6e5d1ade48a89 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2722,7 +2722,6 @@ void ipv6_mc_down(struct inet6_dev *idev)
 	/* Should stop work after group drop. or we will
 	 * start work again in mld_ifc_event()
 	 */
-	synchronize_net();
 	mld_query_stop_work(idev);
 	mld_report_stop_work(idev);
 
-- 
2.43.0


