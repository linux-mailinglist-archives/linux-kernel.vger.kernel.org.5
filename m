Return-Path: <linux-kernel+bounces-114701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902AC888CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322ADB226CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C157A15FCE4;
	Mon, 25 Mar 2024 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6LiakG/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8615FA86;
	Sun, 24 Mar 2024 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322354; cv=none; b=Hxl0OtD27hVITjkQg6kh9bxIsPymnoj98og9MxZdQP+19g3AStfkP5w3R8rXdbNhtAZJpfiqAZ5aoA2eDOIWK4oq78ogbBYDMZUBIz2l7B8Sv8ovW9zjFNAUf4Bt0q/usg7cOlazNhXPnaPcwgIHJKp4Yr+uyswrvK4kFKfGosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322354; c=relaxed/simple;
	bh=nJZ/aigk7V6NhgFPyvhOixWtqTeCEOdc8GJutmJugFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XplXjSO+12zjTYK4qQZ0wjYsjIhpmLbMBuEHs78UV9LmUeOMb3ZRXVCyf+d+mP6+NrKcTA291jO8hY+xyufrYCKlRu2ES6sKzHFME+96IFpASRMEn7ycihUeBFlS7qdE7115B89FtTbiWsyuC3CMNFI4bcShCR1NIXDSgxwEb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6LiakG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E30C43390;
	Sun, 24 Mar 2024 23:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322353;
	bh=nJZ/aigk7V6NhgFPyvhOixWtqTeCEOdc8GJutmJugFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6LiakG/1reUwugY+U9imJXrHJQc1Vvb2xkKt28tvBTbj3m/1l/3RQL+Pdi1ZzQKn
	 omRDvdiT3Nfi42iUmEWZ97EYOJgTymfRGTK5mCU/g4LIvfGWABKla4RE9gkErmrzwj
	 ymBMVmvtuXjXyIoZrcjqZbaKblv/R8VWKAe0AMZqTRC9nxBuiNkWVAwly1ordEj9O4
	 GuIYeln07+p449XtJwtqxpycf5/klFHpuqOuE7VGvhPP2fPvtsizRL6ksj3bTqbFzt
	 RI03ZuDVP25m5LKJbLbC9PHpw0O6jEqE/gBOsv6T0Vt9ROUtCDZmjUrBkf6HRfzTGA
	 uc1t962aBRjBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 435/451] octeontx2-pf: Send UP messages to VF only when VF is up.
Date: Sun, 24 Mar 2024 19:11:51 -0400
Message-ID: <20240324231207.1351418-436-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Subbaraya Sundeep <sbhatta@marvell.com>

[ Upstream commit dfcf6355f53b1796cf7fd50a4f27b18ee6a3497a ]

When PF sending link status messages to VF, it is possible
that by the time link_event_task work function is executed
VF might have brought down. Hence before sending VF link
status message check whether VF is up to receive it.

Fixes: ad513ed938c9 ("octeontx2-vf: Link event notification support")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index a6c5f6a2dab07..7e2c30927c312 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3062,6 +3062,9 @@ static void otx2_vf_link_event_task(struct work_struct *work)
 	vf_idx = config - config->pf->vf_configs;
 	pf = config->pf;
 
+	if (config->intf_down)
+		return;
+
 	mutex_lock(&pf->mbox.lock);
 
 	dwork = &config->link_event_work;
-- 
2.43.0


