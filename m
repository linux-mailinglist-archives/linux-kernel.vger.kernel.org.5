Return-Path: <linux-kernel+bounces-116727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447288A1D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932901F3B95C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F0515FCF8;
	Mon, 25 Mar 2024 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKwoGm1e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981C16A1F6;
	Mon, 25 Mar 2024 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357192; cv=none; b=mgTfbMBK2A90PZVXxnRM+4PZIH/wvHDhNCKV81KdcmSVgazlZ897/mYtuSod44TcJrFwqzpP01o20zk1YtknzgwWrF3N4LThLZ9zqtjcAtS+dJC1poXuLiHvqi9H1F8Ad4rRGFbT0voPTe2nHTeIQ6JSha4MCNufPGC1T7NIgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357192; c=relaxed/simple;
	bh=gitG5l6H+I0HDmx8Fz/JaxY86nGEGMMjS/ARyj17ayk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Orl6y2HeNmLGm3VF3VGh2rM6CRpouQBu27LXqtClPhanBebkwdduwkcjFB395sMtKkNKFgjT1xao5xuO5EFt3ecvv5fIjEEY/QpqmclkkHL6mA7onKnqMiS0zlNPjEc78FYErfE7mtmqzkX0of5iB5hwAzwypDMrhrulfX4gZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKwoGm1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF71C433F1;
	Mon, 25 Mar 2024 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711357192;
	bh=gitG5l6H+I0HDmx8Fz/JaxY86nGEGMMjS/ARyj17ayk=;
	h=From:To:Cc:Subject:Date:From;
	b=dKwoGm1e2hYnW3jUqwNfZET6KZKcEkBAWbUfbqWUBc5IWpDawEj/854LRBsbkTWu+
	 3OhC/Kc+QeXrkFDCn9+rQmyVb1oQB2cgZOFIqXJ7AlUtJSUyokCl3J63MFMugWDvX6
	 07ZrLpNd0bHay8Vo+4YgQYf1L91GeO366GXhJyg0Xln5xS5W7Kz0tRh8LBS6fKrIff
	 HaZoJO5TcozsEYDL27pl5UUGLZyKk/e8mIjw/DGAwEo8SIU6Yk/qjkFTGYJVWmuuoT
	 DInNmOuvoFhhG2f3vqs48mqrZNaTgtpKTUqiC5Z+0oysf7fl8AF9TbiQkNBUkHYAzu
	 gr8OEJCAe1D6Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rogBS-000000006oo-2rDn;
	Mon, 25 Mar 2024 09:59:58 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] wifi: mac80211: fix mlme_link_id_dbg()
Date: Mon, 25 Mar 2024 09:59:48 +0100
Message-ID: <20240325085948.26203-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that the new mlme_link_id_dbg() macro honours
CONFIG_MAC80211_MLME_DEBUG as intended to avoid spamming the log with
messages like:

	wlan0: no EHT support, limiting to HE
	wlan0: determined local STA to be HE, BW limited to 160 MHz
	wlan0: determined AP xx:xx:xx:xx:xx:xx to be VHT
	wlan0: connecting with VHT mode, max bandwidth 160 MHz

Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 net/mac80211/debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/debug.h b/net/mac80211/debug.h
index 49da401c5340..35a8ba25fa57 100644
--- a/net/mac80211/debug.h
+++ b/net/mac80211/debug.h
@@ -158,7 +158,7 @@ do {									\
 			_sdata_dbg(print, sdata, "[link %d] " fmt,	\
 				   link_id, ##__VA_ARGS__);		\
 		else							\
-			_sdata_dbg(1, sdata, fmt, ##__VA_ARGS__);	\
+			_sdata_dbg(print, sdata, fmt, ##__VA_ARGS__);	\
 	} while (0)
 #define link_dbg(link, fmt, ...)					\
 	_link_id_dbg(1, (link)->sdata, (link)->link_id,			\
-- 
2.43.0


