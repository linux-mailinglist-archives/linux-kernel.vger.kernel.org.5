Return-Path: <linux-kernel+bounces-134476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF12689B1F5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298771C20DEC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66746405FE;
	Sun,  7 Apr 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHDQdRvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F437131BB8;
	Sun,  7 Apr 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495630; cv=none; b=SqW7dWat/OjGuoF3g+HTXwt6+b1OJGBNCpKCn+PuSGq/aE5io0PZDmaiPtv6ZatJwxoWvK49jDVMnPYt00tM8ydP11b/J7fwMo8hUnasMAQVNN0vATUXUXZYxbXBnpwbh68uuuaUbZnkZY2YxQkmPl/QDFop8blEa3QYBzZh810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495630; c=relaxed/simple;
	bh=+EcHo/x5E2QDI3Ja4jWy0jGfWC3E+JUrJTZn+TZEOss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6RfX4sjfUwnfMGpDSXjS15vOGMqPAVxTVyQTzzLY2RStiazUP288a2c6VJ3kCiji1ByJ3MkWEfzNMN5lEYwIDF/J8RC26RaRkPDWA5tOjqao/EbSF6rgr2BbexHs1x8qpRw3Nm4KZi1Owji5yiiD2T0P6bUY6HWYB/DPjucsaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHDQdRvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483CBC43394;
	Sun,  7 Apr 2024 13:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495630;
	bh=+EcHo/x5E2QDI3Ja4jWy0jGfWC3E+JUrJTZn+TZEOss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHDQdRvtaNbojN6v2mnKSv31rSet9Pp8u7h5tZiiQiyTIGR7ev12hgRvquLoj6WgJ
	 hKLe/cmLJLq+tLpmkSmy58gRUgIw50uUg0qjmOuEe+94uFrLyzbk3ySz9+jdng+RH3
	 4YhqHQsBFld103xkb+FVJrN+db7qlKg4udqMUOMsOmX0G1+o6kdU2ZhfQidOohkxZH
	 iP/faxryaT1RPNmaqIleKVjx5b3z6neH0oWifNq9oInNdQlXazgf8+ldGPZa02ymKE
	 Q4e/4N6WdWZx4wKQHRD0nvIWgKZOqiUmhdGtLU0ed3fJsHr8tHKY/y5fAZ2HvA7D/k
	 fiNp92bRMbpMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/10] wifi: cfg80211: fix rdev_dump_mpp() arguments order
Date: Sun,  7 Apr 2024 09:13:36 -0400
Message-ID: <20240407131341.1052960-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131341.1052960-1-sashal@kernel.org>
References: <20240407131341.1052960-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

[ Upstream commit ec50f3114e55406a1aad24b7dfaa1c3f4336d8eb ]

Fix the order of arguments in the TP_ARGS macro
for the rdev_dump_mpp tracepoint event.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Link: https://msgid.link/20240311164519.118398-1-Igor.A.Artemiev@mcst.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 19b78d4722834..dafea8bfcf3cb 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -963,7 +963,7 @@ TRACE_EVENT(rdev_get_mpp,
 TRACE_EVENT(rdev_dump_mpp,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int _idx,
 		 u8 *dst, u8 *mpp),
-	TP_ARGS(wiphy, netdev, _idx, mpp, dst),
+	TP_ARGS(wiphy, netdev, _idx, dst, mpp),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
-- 
2.43.0


