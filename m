Return-Path: <linux-kernel+bounces-101957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2587487AD14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44A0284C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DDE13B7AC;
	Wed, 13 Mar 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="met0NpR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A0113AA39;
	Wed, 13 Mar 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348166; cv=none; b=R7ZdY3KdFUgApDbMH2wA6r/CEI6ISYyEQJBJrl0XJayTKYrEL/ln4sVRHSMPLLaecgJNlaaEa3nyym+z+m11kKw+mJfqPGg6e770QYvlY0crCH9vG7MagqMEBsnHnhrWA1yWpbEYhUiYBCUr2xASYqukdEizxy47wxnnhebyDP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348166; c=relaxed/simple;
	bh=8EiflNOk+oftE/DLdH6Lfvnb/5Rj6PubTRnwm9TnOBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVGRs1lMIMG2xEnYppvSzDipyfsndtsaXqxFe+Tr6BlYNWk8cIJUms/Ph9aYPEQt+bq/U/FDEYmPrwVtlcRnVW31K/IrV7HydCvPh5xeNBEb4BoFtnPMX6yFJcAAGTDoNvHOEyU0iMmcfy/mlXs+PW+fn4Z73GgFNRz6zXpsuIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=met0NpR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD8FC43394;
	Wed, 13 Mar 2024 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348166;
	bh=8EiflNOk+oftE/DLdH6Lfvnb/5Rj6PubTRnwm9TnOBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=met0NpR/CQ+bUeFa6h/GyzlyFuripGAZ3tUGPKWgtZpLwB/aNyvinRPjZYnqJChwb
	 eo7pb3UfQdUAGk3XyO2XvklxsW6z1F5TUgEASubhK6C6NAgZyEn+I1oaatqbdeF5P7
	 yv/46Ud74XAe7ua2ruQAOA5rqlvo13YLfv/sbcrrgmeVZsVk3jtaMHr7cTvyQGe2Ta
	 jF3rbvWJGQXQ1jE/FH+8FMQ8oVK/623LZWHD7foAWlnf7kQWAXRID2ktlxO/tftDLw
	 APsh5oum8A6QVLcOrkR3dWb/bLuXMrlT47BO88iQmoyysbYojkjd62rIM/MuLAfbMW
	 tR+qHKbbjPEtg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 17/76] netrom: Fix a data-race around sysctl_netrom_obsolescence_count_initialiser
Date: Wed, 13 Mar 2024 12:41:24 -0400
Message-ID: <20240313164223.615640-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit cfd9f4a740f772298308b2e6070d2c744fb5cf79 ]

We need to protect the reader reading the sysctl value
because the value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 55cd51977fbc2..e5d24462d5100 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -766,7 +766,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	if (ax25 != NULL) {
 		ret = nr_add_node(nr_src, "", &ax25->dest_addr, ax25->digipeat,
 				  ax25->ax25_dev->dev, 0,
-				  sysctl_netrom_obsolescence_count_initialiser);
+				  READ_ONCE(sysctl_netrom_obsolescence_count_initialiser));
 		if (ret)
 			return ret;
 	}
-- 
2.43.0


