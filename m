Return-Path: <linux-kernel+bounces-28078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FF882F9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841C128A5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF7414C599;
	Tue, 16 Jan 2024 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XItjDzgM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412092E648;
	Tue, 16 Jan 2024 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435052; cv=none; b=D5NNqO5jfLSB2EtUnJrAPG/zbpaCACPZkuPgq8NupflNoRugif/C5V+7LudTEkeigqQifDFhixDPnzTeLDN+BZct2sZJgoYzYHvusXOZcxOI7FfpK7eUOTK25pRhFJ7DQrqJw6Xpr1Pd5BvccmD4sF2L65BxD2Q0KRGsTcQOIUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435052; c=relaxed/simple;
	bh=VdmSXmsWNXxAdpawkiLaR4bgZsOc/F9dyghybrvjGU0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=BAdMUVtVmZdTF65s0TGGjIM2rMuNAOZr640uAleYQJOT5QXksRrQdxscpopZrOT0Pind+gASLOvSQ6MyrawReLEQcmzKBbaU6rU9mN1XynKkf9mWV3CdDykCzZMy3/zjFUKrBcWLehgl3ItoXgzCqGzYKHw+LKU1TVp0CclEKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XItjDzgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1693C433C7;
	Tue, 16 Jan 2024 19:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435052;
	bh=VdmSXmsWNXxAdpawkiLaR4bgZsOc/F9dyghybrvjGU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XItjDzgMZtXAYj8dTqujsfIr4u83kyq4wGAtLNBStpYbnX9xdusmWLESALdI9XMq5
	 Va8JGvHCqCHr+2y6eS8L9/CdmunRx/slERXhtd1UIm5XWZHMZ98BcjEl+33gqPDstK
	 wJc9iQDm7b77XvbhXd1Di65XTjZ9wvffMJjTh8BhKUr1b4Q/kWj0JpEkyi52yjLUVt
	 a7L59aB1GFyDZx5SKLxsPzGGEgA3EIMqWeXlEYjpCcn0DjOBvrjEdq8CcRx9XZ1kZE
	 6dYbUV61Nxs98RlEpfUt0aog80jF/q6G5Ox3qQNLvsfsOxsk7RQDx0xK1f3qdyPh0+
	 gbuT5cH2gI82A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 60/68] wifi: cfg80211: free beacon_ies when overridden from hidden BSS
Date: Tue, 16 Jan 2024 14:53:59 -0500
Message-ID: <20240116195511.255854-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 32af9a9e1069e55bc02741fb00ac9d0ca1a2eaef ]

This is a more of a cosmetic fix. The branch will only be taken if
proberesp_ies is set, which implies that beacon_ies is not set unless we
are connected to an AP that just did a channel switch. And, in that case
we should have found the BSS in the internal storage to begin with.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20231220133549.b898e22dadff.Id8c4c10aedd176ef2e18a4cad747b299f150f9df@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index b7e1631b3d80..86906557a04e 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1810,8 +1810,12 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 				list_add(&new->hidden_list,
 					 &hidden->hidden_list);
 				hidden->refcount++;
+
+				ies = (void *)rcu_dereference(new->pub.beacon_ies);
 				rcu_assign_pointer(new->pub.beacon_ies,
 						   hidden->pub.beacon_ies);
+				if (ies)
+					kfree_rcu(ies, rcu_head);
 			}
 		} else {
 			/*
-- 
2.43.0


