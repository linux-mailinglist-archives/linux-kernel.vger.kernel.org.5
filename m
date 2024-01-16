Return-Path: <linux-kernel+bounces-28095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB182FA22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998E41F269BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797811502A2;
	Tue, 16 Jan 2024 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuKdoxI/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8C15028D;
	Tue, 16 Jan 2024 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435132; cv=none; b=snJ6z2JJ8zx+NQ0yNcAUO9tqmt22SLKcIBs7fZ9zH8cAcCyj9iVG/x6lZE/nhY/VQbTOeFqQt6P1dJyRd9zPrWZ1qBaTFUyxmCmVNC0tmfX462BD6oyrHuRp0PieQRzY0bSoxkDdgJ7w+Lqibsko6t96vbEUwm4VfO6BskbaDPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435132; c=relaxed/simple;
	bh=X2c5sB66ypY25zuGe1D/JNBGH89hep8+SKqIsX/jOcI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=aspY97K1Qelc44uPz3JoM7lGGP2yTcLw3feDIjGUDbppBajo1fvkFtTKynM5WMHqmAK4PM96KMxLGHXtGyQfw1HEiat0SrglLvV9xvZ5SovJerCX//ttX7Ln7s1k85K/eVElnyFjf7yuKeWdQY+R5BPW/KXDrPQBedqO4IYFhx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuKdoxI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0A0C433F1;
	Tue, 16 Jan 2024 19:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435132;
	bh=X2c5sB66ypY25zuGe1D/JNBGH89hep8+SKqIsX/jOcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WuKdoxI/SraQsWnFLdh+OaE0tIkpU2nCijkT27EV1qmvkw0PTsqT5cIB4M/0BAdSw
	 N/6eNArXJmufWgFIrrTiB8rWOu4/SDP9oxsTQf9aiELtkUOA5egXro60fxJGFvjzei
	 3DC12AozjVtDGxwmZ13qHPM4UFRpwJFSY5VfUbnQOGHhNk4BWNDO9SHEvh3pa3n00O
	 qfPEC9fTARLemyMomTnv/VmnxGvLlf23xZE3ZCOBMIQaLYNUULYcjF3shsq89DeXoi
	 Z5vIaOVDjZxZlM9D/l+VoK+4LzQm1dWFbMpvFNiKcl7LKEu3nfVdihNXOUsCmoPQ72
	 TmYwcIOVE1RYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liam Kearney <liam.kearney@morsemicro.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/47] wifi: ieee80211: fix PV1 frame control field name
Date: Tue, 16 Jan 2024 14:57:11 -0500
Message-ID: <20240116195834.257313-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Liam Kearney <liam.kearney@morsemicro.com>

[ Upstream commit d3ca4ab4f16eb81dc3e7721251adcba49b229d54 ]

Update PV1 frame control field TODS to FROMDS to match 802.11 standard

Signed-off-by: Liam Kearney <liam.kearney@morsemicro.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Link: https://lore.kernel.org/r/20231025002755.1752983-1-liam.kearney@morsemicro.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 00ed7c17698d..32ea9b110055 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -170,11 +170,11 @@
 #define IEEE80211_SN_MODULO		(IEEE80211_MAX_SN + 1)
 
 
-/* PV1 Layout 11ah 9.8.3.1 */
+/* PV1 Layout IEEE 802.11-2020 9.8.3.1 */
 #define IEEE80211_PV1_FCTL_VERS		0x0003
 #define IEEE80211_PV1_FCTL_FTYPE	0x001c
 #define IEEE80211_PV1_FCTL_STYPE	0x00e0
-#define IEEE80211_PV1_FCTL_TODS		0x0100
+#define IEEE80211_PV1_FCTL_FROMDS		0x0100
 #define IEEE80211_PV1_FCTL_MOREFRAGS	0x0200
 #define IEEE80211_PV1_FCTL_PM		0x0400
 #define IEEE80211_PV1_FCTL_MOREDATA	0x0800
-- 
2.43.0


