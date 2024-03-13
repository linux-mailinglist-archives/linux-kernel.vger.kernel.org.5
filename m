Return-Path: <linux-kernel+bounces-101896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E487AC86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE4F1F2D178
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964A6612F4;
	Wed, 13 Mar 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksFpzSfz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D806F7E798;
	Wed, 13 Mar 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348031; cv=none; b=Qemkt6kzFPiP2q7WXfmtrn2Cs3fzD8O/Lz6Tt+JZjncdMIy4du3ZkBWaZ61WRsCIPTdCNYRyHMGLOJIpkE9W0MsUGQXIYxlsivaxCBrvzy29VSLDysfgLwsQ1MVhIyaoTbZFbzX06WuYXq+9HV+Y/wG24Qk8q1DNss6zYQBcpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348031; c=relaxed/simple;
	bh=3AWhKptyhC8XfLyB3pmytWkHsxrKPkwi3z7ElI2NOhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h28OPzbVGdGL9GS0jkX0YjPYAZYzN+7si0xIGNFmVxXQ+zkCqRnWFWox7KjzCjFwAuMWyUh/NRpj7b3wrdJDhahauXptX9GrY6k1S3LgCP/eZIp1zg19s/3HygUrXMofQ1dkr3+jzBxlaT1VNEfe/vvmP+zu8WDL9AMZ/RSmJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksFpzSfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D966C43394;
	Wed, 13 Mar 2024 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348031;
	bh=3AWhKptyhC8XfLyB3pmytWkHsxrKPkwi3z7ElI2NOhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksFpzSfzBl2HwoplxWoVoDZxv+UowfplN6lXlVLf+Pdo7FICRiK5uc6HC2/IOq/2l
	 4UtHy9XRQ2cIEeR5eoNW/qxL5pdCjxixnC+WrofAn+dasujq5sM+pD3GLZPQTwhwQp
	 gOzVdkVeXj9/56D0VAuSxqMoiF8nVfs/7rUX2Iiz8r9CzLzeqh5Wfm8D9A3RDy6X/o
	 3ClElRKxUFB5D0CoDX44gsmpBqzHTqVwLTvEM4NlV3299AoxBThikGL6i2mY2+eLZj
	 KDkgk0OmBlOL+Stmu7cE8qbSiajBIcJK2gszA/i9dQVHBnAVOIV9aJ6M2sGYTRC209
	 jVjsSiVa7L1MA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 28/71] netrom: Fix a data-race around sysctl_netrom_routing_control
Date: Wed, 13 Mar 2024 12:39:14 -0400
Message-ID: <20240313163957.615276-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit b5dffcb8f71bdd02a4e5799985b51b12f4eeaf76 ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index b8ddd8048f352..89e12e6eea2ef 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -780,7 +780,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		return ret;
 	}
 
-	if (!sysctl_netrom_routing_control && ax25 != NULL)
+	if (!READ_ONCE(sysctl_netrom_routing_control) && ax25 != NULL)
 		return 0;
 
 	/* Its Time-To-Live has expired */
-- 
2.43.0


