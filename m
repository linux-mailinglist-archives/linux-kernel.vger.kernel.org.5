Return-Path: <linux-kernel+bounces-115091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D78888CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FEC281320
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C32F8429;
	Mon, 25 Mar 2024 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmiQzhgV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D228BD28;
	Sun, 24 Mar 2024 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324083; cv=none; b=T1RILeDX2UzjqHEBBagPzv4PAolPtP/Nh2D84xQwDoDpfsArAYNMKW4gqEydSigi6BwG2DqWcSZYzNf4GCgFu3dEgUrjdtmOnEJdb+z5c6v3HcgHzOMRgeK3Ar6o9dSThWmAoonF1w3zi0Vuk9HT+H4TT7085tR5/LLrml3YPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324083; c=relaxed/simple;
	bh=ir/H48WBd9iJTs/xTH8Oz5/Qn+uxWcc9t3DZeEZ5L6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXBFmEYl9IM9beRawOnUXbtKWviq4ZQlGd5BbmwNB/M3wHrUrMwyXtR/7fBVwbzWqfmvLaeC11J+C7RwUi1mdlAB8u17bfGbM76A+7IL7tv1zaEEZnWlnqCkswvKP1Ati+HBG5kV97nubkv3PPQiwdmw0d/ME0kcLCqHI+PTELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmiQzhgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90280C43394;
	Sun, 24 Mar 2024 23:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324082;
	bh=ir/H48WBd9iJTs/xTH8Oz5/Qn+uxWcc9t3DZeEZ5L6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmiQzhgV8Pl9X32Wp5oBt3Njthn6tB+Z2KEaOIsaIyprQ/934nhu/2kWrdzIvBBlK
	 dBqOsg4Vh4/2JDI9VoFHoWlljfmWvIVe5MIte0IbKq4KYF/qXvfwwQ4DJ9Xj5g1fiZ
	 5bxC2iVG+VW1Ho9cbR4dod5bgWKIm4xbh8wBYHAnwfP7AUsZO8EpulEGpmSFV/5tvB
	 X6p4cWU631p1Cjh0V7Tz/MeMZ84MZP78qnVpZE3jfHCQqrPBrSdrjYMhq3qjGXwo1b
	 FD5UsDLDNvwD+RHi7o48hRsFC149ZIDFzS+suiauHZpcCnsKq5HA5O4220QQSBYL9b
	 livId0xoFXr1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 082/183] nfp: flower: handle acti_netdevs allocation failure
Date: Sun, 24 Mar 2024 19:44:55 -0400
Message-ID: <20240324234638.1355609-83-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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


