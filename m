Return-Path: <linux-kernel+bounces-62595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D93785236C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B305282987
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EB44207A;
	Tue, 13 Feb 2024 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpzPMr5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F228F3;
	Tue, 13 Feb 2024 00:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783550; cv=none; b=iWzB8n/q57bMz2lzYEDxg/b8GugMdqONqVxB5b6ICeuikGLlNa2QsuNQZFtWBsXkoAntZUOJleLZ86x9xDAUqpPeKIRUgxIcg5bWguBi8u2W268KSkg8rXyq2b480WFTdC2vuVmHTsigJ058cSzLls07Vf16Oy5Gq7d8QE8c5II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783550; c=relaxed/simple;
	bh=ARQFE/S8zX3kJYS/zVzXoG/q7ypCMrTmliFVk+ZDawY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQL4EsOTs8nvyoq7NCzGMtS67JuaHTFBYt4/MAMYKVayPle4SVbcRQrxU/wjabQPQFPLNxhcxQSBqoaIqDpH12sLuZ3y39XknusgSYNE3zzPHavemTCLq6iVYtkCJoGved57sHrSgSe4RW2JCgrkeMcXrd44AzTIrOcVjzYb9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpzPMr5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CADC43390;
	Tue, 13 Feb 2024 00:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783550;
	bh=ARQFE/S8zX3kJYS/zVzXoG/q7ypCMrTmliFVk+ZDawY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpzPMr5h46YDiPQrDYQ84vshiGYkQ97bpL1FsTPBGR0IfHLC0h4pHhq8K0MV2Pc9y
	 Vx9ZtX7fPCCbMeKTNSQfRWqL21nNmH0mntVowkoDOQmHKVPr3TpABaSfKt4iv4UUEX
	 yR0nAaBB31ysJ8XM1eildKHj0NoVgUP3v6i+gzMZjnzhiaI/Np3Yubq1pSsWMNj5oO
	 Di2MYWbaEOhhHivOXckjEOlD5ZGy/pH3qhJfQLH/LxZIaZA+mURei/luMf2p4nTU/2
	 0uXDV+5ZElGgX7tWpB5d6MH4dM7YRcjoQH9zibqE1kps6wq4Io+dMFgZhylgO+ZNuF
	 /qPoptlcojlLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 26/58] wifi: mac80211: set station RX-NSS on reconfig
Date: Mon, 12 Feb 2024 19:17:32 -0500
Message-ID: <20240213001837.668862-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit dd6c064cfc3fc18d871107c6f5db8837e88572e4 ]

When a station is added/reconfigured by userspace, e.g. a TDLS
peer or a SoftAP client STA, rx_nss is currently not always set,
so that it might be left zero. Set it up properly.

Link: https://msgid.link/20240129155354.98f148a3d654.I193a02155f557ea54dc9d0232da66cf96734119a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index eb1d3ef84353..f0450ee997e6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1869,6 +1869,8 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					      sband->band);
 	}
 
+	ieee80211_sta_set_rx_nss(link_sta);
+
 	return ret;
 }
 
-- 
2.43.0


