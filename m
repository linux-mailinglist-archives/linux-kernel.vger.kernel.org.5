Return-Path: <linux-kernel+bounces-134445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC46889B195
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E22E281820
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DE47F7EE;
	Sun,  7 Apr 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiJLtH2C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177417F496;
	Sun,  7 Apr 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495567; cv=none; b=DR1a8TpQA/FKhDg9YyAhMWGJEpls5eCNtzoBn5Ly9qC+jtCFbsa3VZ+ptpCDpeCdWblNhO/FwO028hSsXuczeRsctDt3ML4xz2AbspTW6PAVKEYdiaqNneujZJr5jQ266ggY4JpzXgSB5QDQ/JreECNajBuPaWW6QCMilpJWqXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495567; c=relaxed/simple;
	bh=WcsQACYYUtYW0h5qqJxVzk4nOl+SikibxTkjw63AQIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljVoVzCl0zkNZK1qmqBfGfnTyOzSnhRJDrKQZeDv2mjz56RstspyzguvvLU7YBSbRDx0QDyyw3szaDGrr05WKgcN3W6VXEaIcysUZa0Bz6HeZ3bzeyFc5CIZhLYzQVbcWyu7CdVr0vWBCJKh2xANTf10fYE7DckLc3M0hmlu2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiJLtH2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684C2C433B2;
	Sun,  7 Apr 2024 13:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495566;
	bh=WcsQACYYUtYW0h5qqJxVzk4nOl+SikibxTkjw63AQIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiJLtH2CgMfxTdi5pYTfwJ8tz/sOAi7Fxg3YyHJAJOpLEU2cqJApwJcYmUI+x31ru
	 56zBdD0KYptSf6Hzt1emjM1JHs5PXWQ6ZpgD18uiAN4lZTA+TAMQtsRb16dVJxus37
	 W2cLy2+YP91lHhQTjG2Sv+BQ6hD9SLq8qAa36cBeCLwhn81NiaFynCOpOzMP5euBPh
	 dofvejAJFm/0IbIqHo9ELYOMBIC1TUeNfcBcRr0YbAkocy1f8Jd1HQrn7fdR201yJn
	 ytKZA/4Kv9mlY01pxj5QXWyo4ccS6U7bi88lwNdUAJ0co5eIaOIX7MZJeRsPJpYCi+
	 WK7v77QVKY97Q==
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
Subject: [PATCH AUTOSEL 6.6 10/22] wifi: cfg80211: fix rdev_dump_mpp() arguments order
Date: Sun,  7 Apr 2024 09:12:09 -0400
Message-ID: <20240407131231.1051652-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
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
index 617c0d0dfa963..e89443173c7b4 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1015,7 +1015,7 @@ TRACE_EVENT(rdev_get_mpp,
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


