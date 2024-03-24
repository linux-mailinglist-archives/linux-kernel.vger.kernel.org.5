Return-Path: <linux-kernel+bounces-114164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B9D8888D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00511B21FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01B31552E5;
	Sun, 24 Mar 2024 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey1TELRN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFBE13540E;
	Sun, 24 Mar 2024 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321479; cv=none; b=N31irfbck3Pukkxe5SNPCJd2HlYxhYyi6SKu2FXrmHg8ig4LIRq9JCLLzbuw1yvNW1ZUzyLzkLtgak+eEksJ2UWeUe6RZoBkQmkw0mZG/JJWUEbf2Fpyq+zpoZTF1MqR3ls7w21dx60ol8x2l5uvJUdmeidVSFVnhj/ezF9XTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321479; c=relaxed/simple;
	bh=4sy4eq2T8L33zFLZ8FETfbnQqlhB56H99f02c8RLNa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gslm6oaWifOC6N2CU9JTXyeWKKHeYw5Ki0dcioJ1L9JVnOmmSZBNTEPHGmFxgA4pEutx/aOsG94PtNDMygdSBUSrlnDIHXSzGkC5YaB40TxRG3rl51hAOtMXDJOkz8N1EZS6PGYB6CiD9VlivsTIgl1G+95xoDBef2nS9mrcEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey1TELRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EE9C433F1;
	Sun, 24 Mar 2024 23:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321478;
	bh=4sy4eq2T8L33zFLZ8FETfbnQqlhB56H99f02c8RLNa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ey1TELRN2s9y8xJwctUSMnkLvcv+YIgdwBqarXfkeem4mQQJG/vFiCm+NWi2QYJ4z
	 6esNAUlpjJDA5zjHpl/lXxRa8kp3OzPFG/nbTFvvaFNnw1M85XEVHr0oC5t+QqXySO
	 rSTIKEtzmHVyqUSxntRwTmocAjResPIF4huAUG19o43Yx6n8J0kamTRwXgSQC07djT
	 IDV12LGhmiYpvXQGPlPNg7hjWaS5ja5fNNAOm8XZhOQiIt9s06iwmQ5lk+oaATAY6V
	 FMrtGQvTfNIr7gaam4I8crxXb2YyPLb52i6q2kAtZEwZ0c2sN/aPG79Q6ce4Vox7+p
	 cZMDh/7KmLcsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 203/638] ipv6: mcast: remove one synchronize_net() barrier in ipv6_mc_down()
Date: Sun, 24 Mar 2024 18:54:00 -0400
Message-ID: <20240324230116.1348576-204-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index f948cf7bfc448..fae30bdca9073 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2720,7 +2720,6 @@ void ipv6_mc_down(struct inet6_dev *idev)
 	/* Should stop work after group drop. or we will
 	 * start work again in mld_ifc_event()
 	 */
-	synchronize_net();
 	mld_query_stop_work(idev);
 	mld_report_stop_work(idev);
 
-- 
2.43.0


