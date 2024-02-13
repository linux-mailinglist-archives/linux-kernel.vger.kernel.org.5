Return-Path: <linux-kernel+bounces-62598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB82852378
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEFD280E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B534F524A9;
	Tue, 13 Feb 2024 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2TNoQN7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11751C46;
	Tue, 13 Feb 2024 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783556; cv=none; b=VKadteIHTvboyfb9lvAUFsshcURnah0qxGqsTfg/PGZ2I7VLStCw48wITZkbhSGudwCLm0zscO17Gq1s9b5PnZF4+FT2s+1f+cm6H5LDpLjab79hKoTblnVtzR8obT3yYRginxk2FiT0avIiR1CLJMhlnLKptiihrVMozsZbnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783556; c=relaxed/simple;
	bh=YS2EPhSBjCm2d5CHnxNbSoHJ8BE6utSupVU1OChLlFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z64wkLNFAhsUyrsyFd02rWmBY7V3pXOqA9N2F1S1VXZSzIbdamsMtXJS34EJgz0irvXaECdN1TjvhZKizipJQmpW8I8GuvTvGAZkUqOMjFhaK/3SvcLrgllq1bklTcB6UFabQaQLeyscjyGD3tYnsL3q73vOBkqOTTsUiVCKsl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2TNoQN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D84EC433C7;
	Tue, 13 Feb 2024 00:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783555;
	bh=YS2EPhSBjCm2d5CHnxNbSoHJ8BE6utSupVU1OChLlFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2TNoQN7BGG6jyH1pkK3BguThXj+JncOeqfg7N7DFAlOFd1ehvBndJc8ql+7ckfTR
	 cO+bOSzO1ilS5xW2HMfjw8EEz6BJx5pPAPH6xMbDJTCMTGVrJBXkUudI+RwT1rr5JN
	 MlX07OBJ2YH5zVSgfWNicqK10hugB9vBlG/LSpKKPEjki//B4vvqLhxZgmeOwBBixs
	 RzZEdAmA0gdgaN7s3XM6PaFkSqFWZqRQDyT486qDDNxMPYDs79xTK7LpDaL5eUCL4q
	 aL3Mzc98XN7JSoqQmc/ZJGNKDPZ0B7MPlMQd2LuIEgOEJU+kd72zvnFOPXQYxW7xxk
	 eHRRhYfvBt6Yw==
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
Subject: [PATCH AUTOSEL 6.7 29/58] wifi: mac80211: adding missing drv_mgd_complete_tx() call
Date: Mon, 12 Feb 2024 19:17:35 -0500
Message-ID: <20240213001837.668862-29-sashal@kernel.org>
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

[ Upstream commit c042600c17d8c490279f0ae2baee29475fe8047d ]

There's a call to drv_mgd_prepare_tx() and so there should
be one to drv_mgd_complete_tx(), but on this path it's not.
Add it.

Link: https://msgid.link/20240131164824.2f0922a514e1.I5aac89b93bcead88c374187d70cad0599d29d2c8@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a489aac653c8..56e964fdc20c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8057,6 +8057,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.43.0


