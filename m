Return-Path: <linux-kernel+bounces-101966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A133187AD26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30204B22A42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1875C143733;
	Wed, 13 Mar 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5h+qGV3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819314262B;
	Wed, 13 Mar 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348175; cv=none; b=mp+wWBVS2/WkOMyfQFP/RetsHvnOWdJFtSmBWgx7v+h1PYYE816tRYqJOS8gaHuOhMWSD5vT/UnUOHYijnxO9QXnN+W8WtlwRTt4qs8M9vlH29KyLIUVozfKdMQnTNcrDqAq4N+kan4+wBQjhrEVlETrQ2SqAcEjP/44pes98Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348175; c=relaxed/simple;
	bh=6/1EAGfa4zAXJ6ZaPmxIK8PFTioJivkuGr5IEuxC0DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=le5DjEMW5Ed5HF1XK4ILMJYFi7t2/tKqB5yE37wcIOSV7ldMuQ1bMhSTaxNNDjNRXusPYLqD1ZqkMMQ2E7Y+k3v7EsIdbP5Xc3WUlqP/c4CmGr03Q/sxe66o7Z9Vc0sGw/Vr+n/LQCE4FXc1Rlaxp2L2dKfbWTooX0wkvI37jS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5h+qGV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A79C43390;
	Wed, 13 Mar 2024 16:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348175;
	bh=6/1EAGfa4zAXJ6ZaPmxIK8PFTioJivkuGr5IEuxC0DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5h+qGV3109rByx2IKOoqGuxJDvncs9nJvE6m50OegmvQPgx+jjexDvTnS1xhemq0
	 J1gcc3oLUXjXU/CJA+t4iMFnFQ2T9aY3u2OPBjLP8tMAMNvwFMGtWwCNj99RFfoatx
	 DwGqeEDt4eV3g9FdLERjVN2ZB03K00mBjuGJxP9aqIzZ0pK0MABvLmYjLTKHLOn5Tq
	 4+gB2pIxl6EEWWyCag1YMjXfMbUiV0+7SQ0SnVNcVthDs+jiV0/y7uwCFgTqc+ZNml
	 w/qsbxx8nI2tILQh8+i+etWTlwu3UrJ93DPU0TSGhvUoB5832FRPJeTV96/dy5OMPK
	 WjmVo+iAwMtTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 26/76] netrom: Fix a data-race around sysctl_netrom_link_fails_count
Date: Wed, 13 Mar 2024 12:41:33 -0400
Message-ID: <20240313164223.615640-27-sashal@kernel.org>
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

[ Upstream commit bc76645ebdd01be9b9994dac39685a3d0f6f7985 ]

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
index 56bec5b5b37c7..983c5ad9724f1 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -728,7 +728,7 @@ void nr_link_failed(ax25_cb *ax25, int reason)
 	nr_neigh->ax25 = NULL;
 	ax25_cb_put(ax25);
 
-	if (++nr_neigh->failed < sysctl_netrom_link_fails_count) {
+	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count)) {
 		nr_neigh_put(nr_neigh);
 		return;
 	}
-- 
2.43.0


