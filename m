Return-Path: <linux-kernel+bounces-102054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9428287AE04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F871C20A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C0715530C;
	Wed, 13 Mar 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHR0qF0q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9741552F7;
	Wed, 13 Mar 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348433; cv=none; b=fiRzGkGgjtLY4lCRSMuZiD9WITKThaOwHpyRjV3UMzKs88LpEXQq8ltuGPCpMS9sgSbNBxOu21CtFp12HcOl6sX0TOtUL2UUc2+b1snKTOFKdjLngem2Ef0jbw2whpvNVe/mf2W3cU0qbImhIAV1wYBqK3Q+/upapQQDupyuLpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348433; c=relaxed/simple;
	bh=nKbi3WvYJpDkLVr2ny9cBIoQGrlxEb/UoWvrx+M1nTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOYQnIdb6sBTA/fnJMocqrcW8MXSquxanEe1qrvnfcgM1fIeCR331usRSOGnfgwe7G9fzh2kbnPeUAk8XGDUllX586LS2kRIbiF81+m5bcV7q9jxYsxK+FYExw3V8eEJQVjFMdE7c5+TjkeFZWCEvmDrWHJMZiqFaGUuEIKcsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHR0qF0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FDFC433C7;
	Wed, 13 Mar 2024 16:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348433;
	bh=nKbi3WvYJpDkLVr2ny9cBIoQGrlxEb/UoWvrx+M1nTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vHR0qF0q3PQGk3fZgl4eF0eqAkwPAOz31wtCeeYiVlNgzCtuuxcL/L7VHs+TEZper
	 1Fyx4WeOnGi1SzyLgIN7YBkGhJJXTOpbKEsZAD78ASs9UCvPi25IXRhQ1g0LNmVP8e
	 2DZ9bsnimLVFBpiJsxhbHJQbTHEaVzt587z41D9VRyEzV6poprXCfdEdlvxgXY82nK
	 bXZ27Wk84FOCXZWJc6s6Eyqg+SbNxjIUp9Dv76jdYSZ2dHkR+3LI8pWpKYl7lZYo1f
	 st0UpNZuRdfaHlxTkk6akcOSwsYeI90QcDn4k8qlsd/oQ7njBPcM4I6SsLOeysLw/l
	 7Mp6wK6NCN4Iw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 28/73] netrom: Fix a data-race around sysctl_netrom_link_fails_count
Date: Wed, 13 Mar 2024 12:45:55 -0400
Message-ID: <20240313164640.616049-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index 88c59bd0f7397..895702337c92e 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -725,7 +725,7 @@ void nr_link_failed(ax25_cb *ax25, int reason)
 	nr_neigh->ax25 = NULL;
 	ax25_cb_put(ax25);
 
-	if (++nr_neigh->failed < sysctl_netrom_link_fails_count) {
+	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count)) {
 		nr_neigh_put(nr_neigh);
 		return;
 	}
-- 
2.43.0


