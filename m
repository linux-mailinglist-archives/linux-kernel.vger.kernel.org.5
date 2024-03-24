Return-Path: <linux-kernel+bounces-113068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07777888135
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FF51C21531
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B328149DEC;
	Sun, 24 Mar 2024 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAbPLGle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4991149016;
	Sun, 24 Mar 2024 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319876; cv=none; b=F6uabqV88RCW3vy89hBl9+PT4qIfLJJTJHqbfslzipoDwRNREsd4t8w1gztxV8PyWy/QV/FsBAyQjVUN7U50hLe5QrLvCgDim00xu1AKn5hQ2ihPPOraZ26HreLefyHalPs+zdzJ1Pf+1KJ95sOras1rc/L+XplCe8F8JI+C8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319876; c=relaxed/simple;
	bh=ATExb8dnzR1+3OF1sfOlEjOUy1xTMLsnkXvdaxfAZEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jV6D+vY7BRosyO6BguGGfRwk/p7ROlUSwEXQqtLmN2AqD0FnbZzUPtoJRUnHo6pXLiGR1YA0Uoxxz5xxgcMgQ7yg0ZMiY9+vZlpZXHI2NO+OtMbFzVAaKY49LRSJa+r36+EMLgfbnx955yPwzKgWygKh/SIbV8w9pw+Iw/8oSpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAbPLGle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7767C43399;
	Sun, 24 Mar 2024 22:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319876;
	bh=ATExb8dnzR1+3OF1sfOlEjOUy1xTMLsnkXvdaxfAZEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eAbPLGlejuyehHCaUA9F1MUk63O3VdhoAwqRhD4Lyysgs9SrWI/FzJ6aRKJEzDfIG
	 szRyZjzj6vTqDolKEWUijnC25H6DXgO1W5UnSCCtDDp3ISsrwjrQ0V+PpEMKvtdtub
	 2KQtKGv3v0CXu/6fP7QhZ4em5F4qF1uClp0ajFWfzAUqDnPHXmNzJifEdbigTGexs3
	 X8ruDmQWra17DPP6y31e8fKxBFCnSkMSyotWltqoIQwolQpEB15a9iOoc7rbQ6Ms1B
	 /kwYnGAw0LHy5vzr3vsPGpCt6uZnsPM7OWgp0lMKKeoiAbsAlo4J+KPLk9mifr60Uc
	 EZbGPZJj71DHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 181/715] ipv6: mcast: remove one synchronize_net() barrier in ipv6_mc_down()
Date: Sun, 24 Mar 2024 18:26:00 -0400
Message-ID: <20240324223455.1342824-182-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


