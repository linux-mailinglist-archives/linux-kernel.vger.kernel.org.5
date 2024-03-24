Return-Path: <linux-kernel+bounces-113696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BF5888616
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41662905F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B453146A8D;
	Sun, 24 Mar 2024 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya//cRAj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52081DA158;
	Sun, 24 Mar 2024 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320673; cv=none; b=tpnkP6iAJIcTrcfucNmmhkJxxDD72Rnu1Fsqm8BI9wNmwW3pNZVn+hpvA49J2Rsgul3vT/hrTj0PjH3Nug3MF4ilk6F1YqojzGy6Y/7GE6A3VTNIOcrtNuxH/Qsgi+TZmVBWFzEgjMRcbQ9CdjTybtU8PkHzKr2DlN8u9G59czo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320673; c=relaxed/simple;
	bh=ATExb8dnzR1+3OF1sfOlEjOUy1xTMLsnkXvdaxfAZEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZF/KdfMOkDgAgFUoHkG3SBnQVo+vjvLnlG9HjiNO/d2657XoFIU9jUMrhhsceDGEegTA187fzg7dHRx9qS2DkbMkKa9APTyEDgYoDm4LoWSxzea27kwqPojHw5CJQdWYZBSnTgivSwJHn09Q1e0JMtj0WZ2ULyqwu0kQ5dJKCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya//cRAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D57C43390;
	Sun, 24 Mar 2024 22:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320672;
	bh=ATExb8dnzR1+3OF1sfOlEjOUy1xTMLsnkXvdaxfAZEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ya//cRAjyJZMrnClddYLGZA0OdD1wRGnJRzSUJvoV6xe9tPoeK8I5ww39sxjbQekr
	 TQ5jfFDmbLsZ3Jk694m9gkN+tLVMki5hK4qzj6aLnSRGUyseM5wuLOJ0tzNm5o3I2u
	 4li8eOiLCw85TPyKdskxIzEsg++47EZbVy/UX/K4FRYcKhoRNqbxeJ3SiCYSYr/dDj
	 iXferKxtOEe7hRDdGFycEiq62hqgsaZamWV2GVZy6kwT2dkE4505OH3hddLD/1Pu40
	 vxPFqhu6xk1GUSsD+gSFpJHezacE3ZH+AY8neA1Fs+cZBHnB3lArwUQu4iVcaHWV1V
	 iCeNBX1yW2X7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 235/713] ipv6: mcast: remove one synchronize_net() barrier in ipv6_mc_down()
Date: Sun, 24 Mar 2024 18:39:21 -0400
Message-ID: <20240324224720.1345309-236-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index bc6e0a0bad3c1..76ee1615ff2a0 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2719,7 +2719,6 @@ void ipv6_mc_down(struct inet6_dev *idev)
 	/* Should stop work after group drop. or we will
 	 * start work again in mld_ifc_event()
 	 */
-	synchronize_net();
 	mld_query_stop_work(idev);
 	mld_report_stop_work(idev);
 
-- 
2.43.0


