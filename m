Return-Path: <linux-kernel+bounces-114992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88A2888C62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7422C2817E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8065A1C0164;
	Mon, 25 Mar 2024 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb0giwWT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5992D282A65;
	Sun, 24 Mar 2024 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323737; cv=none; b=E86YUOO096uMYT0wLpZJ0ijcKXDuArCbZtUoyMShvf6c7Ecdp/43Osvxu8XDkEXFLXs46AkOY2PSnW94ehhh2fai0dubEgj5VjX5G2DJCAhYwbLNKCYwzzKLb6ElQocQcTECNywlB8FNg/680zhaqEit1Ykv/OD8wUe0ZYKYDhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323737; c=relaxed/simple;
	bh=ir/H48WBd9iJTs/xTH8Oz5/Qn+uxWcc9t3DZeEZ5L6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilZAMUKu9FOiXnncUyIqmMLi88cPj9ObkWNGPdwe0BwTMovACP8xfCdUSwgP9rx2EhdiRvOdZxP0a1hPQQ3vyt+pBxcuqmcEKlZZ3DcPpDFQk565TDTQ6TCrNWGYzI9zMCz2q9cVPeC/BrBnfqQ57h3nVu5KSkq6gBaU5we/Lqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb0giwWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80781C433F1;
	Sun, 24 Mar 2024 23:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323736;
	bh=ir/H48WBd9iJTs/xTH8Oz5/Qn+uxWcc9t3DZeEZ5L6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eb0giwWTWOwi77p0b6ZD+ZZu+vlxq/ZEEYvX0V6Ngt+6fWvvNihq9BrPoi/O0Nlf4
	 /S0K0yR/SJvyKDFx0YUwX8tXl1kXf9Gzw05aNW2lpKj31r+Znz1Z1DSJBH3KhCXcoi
	 MPOFxtPA8e5+lzj3bvstvpnfDEsuPAwOwLybxNGEyCwNcWEmtobSidlSiw0BtscHzI
	 g57m5LtJa/XL7UXL3iZb3fjf0YMf/UGYwNkeMdL1N3/Oq/NpeQI4reBAA2VgbsAjlB
	 IRsyWVCEUG4DvozD3Bv/XX3vg7u96+390fJV2amXLlsrUbMA3c7g9gW+yVAFusqO9M
	 DLXmQ3Od7i5tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 110/238] nfp: flower: handle acti_netdevs allocation failure
Date: Sun, 24 Mar 2024 19:38:18 -0400
Message-ID: <20240324234027.1354210-111-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 84e95149bd341705f0eca6a7fcb955c548805002 ]

The kmalloc_array() in nfp_fl_lag_do_work() will return null, if
the physical memory has run out. As a result, if we dereference
the acti_netdevs, the null pointer dereference bugs will happen.

This patch adds a check to judge whether allocation failure occurs.
If it happens, the delayed work will be rescheduled and try again.

Fixes: bb9a8d031140 ("nfp: flower: monitor and offload LAG groups")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Louis Peens <louis.peens@corigine.com>
Link: https://lore.kernel.org/r/20240308142540.9674-1-duoming@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/flower/lag_conf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
index 63907aeb3884e..3167f9675ae0f 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
@@ -308,6 +308,11 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
 
 		acti_netdevs = kmalloc_array(entry->slave_cnt,
 					     sizeof(*acti_netdevs), GFP_KERNEL);
+		if (!acti_netdevs) {
+			schedule_delayed_work(&lag->work,
+					      NFP_FL_LAG_DELAY);
+			continue;
+		}
 
 		/* Include sanity check in the loop. It may be that a bond has
 		 * changed between processing the last notification and the
-- 
2.43.0


