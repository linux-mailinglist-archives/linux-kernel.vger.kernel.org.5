Return-Path: <linux-kernel+bounces-58510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7669384E754
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96BA1C21724
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9A71292D7;
	Thu,  8 Feb 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfsCf+hv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB8128833;
	Thu,  8 Feb 2024 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415481; cv=none; b=DfVtkaixQaDa376Kx0opBnP67T7vJm6rV6HpUY8lPdfhQ+66lb0m5NIpguKweNYUiqUYbhol75fVBX+tSHsPAWyDS7r4nYmqCVjByLSml77tHmnuHlqQGjVGZUIaug09okOIQNMrgIFDDMjcd5jm+ZaCMRa7ZGdpjBkjAyKQCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415481; c=relaxed/simple;
	bh=NvTXRnuON6qPQNYuNjtmkLBaOdT6vLsUQt2KlMjwaRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hlalu6oY95u57LnyPAVQQI+KUD6pPjhcGV1cXSPXtCyIQAO0h5Dlr90L5uEo/nern3R9bSxtwsHLQFgZAtQ5ceKp/iB02/S4vr4ABMQhXf9M+0Nt+TwSxPdHqrV7S5mJZ1VAcvAMVpQ21Vf0GZ9lDk8MVGXUj3Rz26/ZCoAFB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfsCf+hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F90FC43399;
	Thu,  8 Feb 2024 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707415480;
	bh=NvTXRnuON6qPQNYuNjtmkLBaOdT6vLsUQt2KlMjwaRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AfsCf+hvzcWGGLz8s8ueraM6xG333BQf/2BM1uSkw3s2DmRiP758Un8yRR76tvNaO
	 w71OU7ffxu4lw41dLeeHBMWf1pzT/kUQUgDeKyoh3A2dAfU1ucqfxx2qXU9fOrIBkR
	 OfhwynHiDhDgUjRAW6d4dmj8rpotTmGZJurv/p1QJ6wQUBSrN7k5qOprNFoc3V9uly
	 synif8g6FoxJ4TEQ8EgVm4cPsnjaJGVUNv8Hcjn8fZMvEfWbekKqwLn86fTTKITxZa
	 BOfan8bj8G+SJ9+hyDak8Hs1Yq5uJAtVaLI8zBt3oSfS/LA+ZdAB2ECHjeb/2KBoEr
	 UmElN3vqcGwRg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 08 Feb 2024 19:03:53 +0100
Subject: [PATCH net 5/7] mptcp: check addrs list in
 userspace_pm_get_local_id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-5-f75cc5b97e5a@kernel.org>
References: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-0-f75cc5b97e5a@kernel.org>
In-Reply-To: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-0-f75cc5b97e5a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Kishen Maloor <kishen.maloor@intel.com>, 
 Florian Westphal <fw@strlen.de>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Dmytro Shytyi <dmytro@shytyi.net>, 
 Benjamin Hesmans <benjamin.hesmans@tessares.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8aCCu0yid68+GRgZ0xl8ByhW49kl62JqasxySjE1hiQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxRehMiBc0n4f5gHnwPOyMOq49tP8zHm2lFVkT
 cE0jZcZVGWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcUXoQAKCRD2t4JPQmmg
 cxntEADURwJIyiZOlgRgmGk5605OerW8KhB2LAduQSzURfaFwUvTMpY0gAlP1jNEPHikGDBNPiF
 uOL+nPGidIDA/aoBUA18uSMVjP3lW6Fo/f5eAwPyMnPQzp8zVGkvOWDf7mi5Z5W+3dufYQfggYk
 U9Buxrb/uZ5Qq1Mnlu1Q0WwFrHTUjfUWZRMvOw5K/8fY2kN7qg1JxHDLpspfHM+qqdhsyi+73nF
 VITEEcn0tF2QxUxwP72FP/RhxO3e/dXoz7nmwmqLO4BUzO7smxueGgWJtYJNROjKC+g739r5VQX
 zAtfaGgm+MwHw4ZTMhRDJ/TqHGjJ5qxVQD+LkjfXj4aTY61N9onisctTHJ+HvhgIMaPW8bJ/GM3
 5ymw4/GaknE8KN9ZmHjDvECOyFjfCoRYr8R2KnG4sN7TjMbMmrbfPLaXlocEwxjqUh9pLKkbLkQ
 l9lOr96uMF9YAU3HhgrpYZDjQLPGQ1R4F6Pi8U6IxQm7nzrFpcFgUFb705muBu4J1Lfe1vICjEX
 Y04hObPoIAElQd8fHfgLLRwyOqrCvvOsMWEpUaRLs17bVgYOR7Og5NFPurVFn4zB77d4qImkjYy
 a4b7uGx1pV7rx5xwie7qk+buNeYwnnQ1P1C+F5/xyGdnDOOQtyxS8ttuea2UY08zLE/Y90Zo7dd
 SqFfspoFmeCNIJQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang@kernel.org>

Before adding a new entry in mptcp_userspace_pm_get_local_id(), it's
better to check whether this address is already in userspace pm local
address list. If it's in the list, no need to add a new entry, just
return it's address ID and use this address.

Fixes: 8b20137012d9 ("mptcp: read attributes of addr entries managed by userspace PMs")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..4f3901d5b8ef 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -130,10 +130,21 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_addr_info *skc)
 {
-	struct mptcp_pm_addr_entry new_entry;
+	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&e->addr, skc, false)) {
+			entry = e;
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	if (entry)
+		return entry->addr.id;
+
 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
 	new_entry.addr = *skc;
 	new_entry.addr.id = 0;

-- 
2.43.0


