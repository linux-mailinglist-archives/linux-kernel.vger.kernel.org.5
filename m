Return-Path: <linux-kernel+bounces-101788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6DD87AB95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187041C21A26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04E3651B7;
	Wed, 13 Mar 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNC0q05X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E452F87;
	Wed, 13 Mar 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347623; cv=none; b=FbFhKSrxFAOn+GvgP0BJHPDaAp33/edBtQPiSGiLu0MDhLW1dXp9Rv7NhNw8Pkm/WH3/u7MYXPsew/I92gADDZ6CIe1Qd6FXDZFfkU7c5wR7x6Z884qTYMhAsAT00B75nf+Ek94r6EmJGkcWNpJB+Pm2+K0frsPAJQhq8tOCdOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347623; c=relaxed/simple;
	bh=+AZaMiiAL0mBh+Pf4FRzfsSwn9gHp1DQ7GqNgpLXpkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZZYfU1n8O8QL6CtSIu/yc5wFswt8s8G4pPAS3z9eW9xh2pdLjKXhrKFCADfxWZtVDQZCpx/0st8r6U3v8WLveVGIKdnMCqySgcrQnyuUxg8iSONW4TvSBYsBv6c+83DWNOjOHo9Z7CxMZww+emky75Hmc1TnpUgJLjOsEyGB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNC0q05X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C59DC433F1;
	Wed, 13 Mar 2024 16:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347622;
	bh=+AZaMiiAL0mBh+Pf4FRzfsSwn9gHp1DQ7GqNgpLXpkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNC0q05X5HwUE5Mtp7ImW8CoU/yr2Kz7t+wTSsHzxKswRtYn0r5HmVUvyFf2zCQjQ
	 Jm5BgT/wLFMu5RFEZkEQ3qkVIagEgPkf1uSUpX4o16jTWYe0Fb8dKMCFQ+hOlxorUT
	 Z30MZzLRY2sfV6rMdwhkg9eVALyQIGpt2FLT0AYpTkInqEwiQ/JIcH6xIWke1EU3nV
	 kwRtOlEyexzBATEtviqWYJWNICIEWg1LEBcvTl2ldewBFAm6xVwvzupxDgooM9qEqN
	 POkDfRGh9Lf0NIumZRR5QguKW5HpqnhsQVOgfLzdBHX+Gv4z485fPLh/2uGesHQ/Ca
	 AmLUxUvlEzKAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 49/61] netrom: Fix a data-race around sysctl_netrom_transport_busy_delay
Date: Wed, 13 Mar 2024 12:32:24 -0400
Message-ID: <20240313163236.613880-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit 43547d8699439a67b78d6bb39015113f7aa360fd ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/af_netrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 8ada0da3c0e08..10eee02ef99ed 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -459,7 +459,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->n2     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
-		msecs_to_jiffies(sysctl_netrom_transport_busy_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
 		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
 	nr->window = sysctl_netrom_transport_requested_window_size;
-- 
2.43.0


