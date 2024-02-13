Return-Path: <linux-kernel+bounces-62698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9B685247F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6CBB225F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205517C6CE;
	Tue, 13 Feb 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6N3ix+n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594257C0A0;
	Tue, 13 Feb 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783774; cv=none; b=IUNfMCw3QOLJ7MJ43VbDmRgElh2q6jtq6uBIs8M4J+nSSF20cIwPOGECLck80JNMQRImVg6Rjq76AkxUGCqB/+Go+f2ut2EUJmRrMyjgWkxMNB6Wh6My51nZdFqMPm3wHem2fhNmf1ZAmJ55J02pBXv+JdtUwgYOX8kOzTIYswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783774; c=relaxed/simple;
	bh=OPznuU/1uRZw4VyTPJL3KM08fB/oDNRcBkKGUT9G1Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LefldOOaTC6XCBI8JBHpkD90+3ImG1tN1taAXHUmJwd7S4S2QxDpgONPU8+WCRpWxTkFE25q9IegfGellUlSTYIWHx4pLAAeqauGLregNuHd5rOmCoQbHRWik0Qy1ZjwV2R4QtYS54hM036Kyx6Akf6y75hl5t4agU8aKViXC1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6N3ix+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB96CC43399;
	Tue, 13 Feb 2024 00:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783774;
	bh=OPznuU/1uRZw4VyTPJL3KM08fB/oDNRcBkKGUT9G1Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6N3ix+niFR5CTYrMJ8OITxRQdW8Qzg0qJFKXMnzp0VrZClD/AQsbPA/Nl5wvlNf0
	 +p+OSm+s/cWRSPpVXhwGnxLDPfXiALrCe3Ym+zePYx8V1WBs4xVcCCboPYhvWdOWDN
	 Aya5SJJLj9xlQvz25gIM9Weaxr3lvhdxPiQyt/D+gWu+x4PJX20PKRWp5FuPpZ9LW6
	 cQGeGBjbyq/1YQDkLp5ey875TrlxbN0H498WNJBkW4D9X9i7RY+y/w0UTKdvl+YqBY
	 PqU0RUaIlHYVWy6FcvXn2jtq8puNDYzWHAP1+rYM6e8BSOtvHzjljQsQcQJcBh6Pd5
	 6jiJ4mXkzX3PA==
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
Subject: [PATCH AUTOSEL 6.1 14/28] wifi: mac80211: adding missing drv_mgd_complete_tx() call
Date: Mon, 12 Feb 2024 19:22:12 -0500
Message-ID: <20240213002235.671934-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index c07645c999f9..bc488092e0e6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7295,6 +7295,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.43.0


