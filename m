Return-Path: <linux-kernel+bounces-115863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A95D889D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021A12A701A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FE4380800;
	Mon, 25 Mar 2024 03:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvjhK9sg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792A146004;
	Sun, 24 Mar 2024 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322067; cv=none; b=bFQdzwi4ORaNih4c6SlgivkxC01wKsvHvcixi8WXlEMfYrWiTAEzebYVnfY98nCr4qVTbeAgrvEOjygAD3UHEIrw2WfdQZEH+XiTl+ZhNgLMDAp31+qslc1bq6jebwoc37xwwgPbVEH7Y0KMeV26R+BWraZ0Pqc6l+O7bw+r3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322067; c=relaxed/simple;
	bh=jubhwmrQUsrVgFdJLK6lEL3+DBrHBzq3x+JNYFWCb2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNmU5dBe1viFt7uzrOu1VZLNwB/Tzi2NCsx/7d2B34MxTB4Nx5vtzYA9efgCeX8AyaoEey3fOdtWH5acqnNjfz523KvN/jcRHYXaet4OEIBZgKdNkpOifSuTcqeEk568BcAB7gu05PVEcvUjjsBJg5t7usRwFbBC31IE9aZ1nh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvjhK9sg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92613C43394;
	Sun, 24 Mar 2024 23:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322067;
	bh=jubhwmrQUsrVgFdJLK6lEL3+DBrHBzq3x+JNYFWCb2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BvjhK9sgmVNzJjOPD/T1jSIzwi/vEgMulMzArYwGMDECXCY50ZUKdGZgsadccEQKM
	 BRlPVOPtqjDBBSfuazn1TNLeUPRUV6TrLKebCnEv8qqEtBBnN+C3xJ81IN9GwbQGhF
	 DJp3w380H6ZwWblxx/s743Ecjn2S2X87x1RHR7kv3qBZ0z+yN1CH04WzG0EHA3mB7n
	 jBIKHgq9dKRxushHLF+lbv1Zyu8MNkF23gLAqNHl2V6K7S2xI0tq8+1QhSdXxV5cGH
	 5moRPE3QrqatfdPxOaO880gptXe9rrPhO6Y0wd28M2uXbQ6jCCSmpzxNw/EqywQWIl
	 ge+Ek4gBsprXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 140/451] ipv6: mcast: remove one synchronize_net() barrier in ipv6_mc_down()
Date: Sun, 24 Mar 2024 19:06:56 -0400
Message-ID: <20240324231207.1351418-141-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 566f3b7b957e9..a777695389403 100644
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


