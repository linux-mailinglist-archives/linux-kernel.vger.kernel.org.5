Return-Path: <linux-kernel+bounces-116036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0B0889579
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146C61F30AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762AC270C80;
	Mon, 25 Mar 2024 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7nb77+Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6EE2779F5;
	Sun, 24 Mar 2024 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323422; cv=none; b=ilkDm4bTMdq50/7RjqnOPxYT2b8pkc77yOvE9fs3rbH3urIJHWMPMGNUU0kZnqNmeeL/kZKUgC5xVDAR6+TASP1TrgzOn8Wj1VM/rJQqABn69BUXUp2Bxfxzd9thAmmCCb/8ue527tMVqex4GhtfZDVRviiNfA4JYQehKAlgMN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323422; c=relaxed/simple;
	bh=Cv9w4bOvSKRavjM5gb4NUer3PfrI7P2NyWfqZ31Y0Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayaKoahkalNUknDPYMCNSHSDsoVhMQpnZ0hFLwAZRg/OVmWI524s0M/iQVBucIpQajCG+QR3ovdRB/kJzJnWtvZpEOqwt3hrrTcAAcMg7i5JVuyXA8S5X3DsxemLObpsVuyAiwcJes7NCn9UOriVRA8IIlfEj4tpewSFtwzoT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7nb77+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BEFC43390;
	Sun, 24 Mar 2024 23:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323420;
	bh=Cv9w4bOvSKRavjM5gb4NUer3PfrI7P2NyWfqZ31Y0Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7nb77+ZGGjnhhZix2wFJkBC5wgXsyDRQWFspgj0cvjPxpZaufb7JCKIPhcuDMPV6
	 cEz+UXZQC6dwVa3C32ev/g00tNnLkDdIS1yKgLu0sOK4o/FvOkd/BJ7i9ztCyvMwXb
	 Jnts1NeCH3QlR9v19e7hOREn+CKVkF6sWQupBDcVY/K2Z/G0CNZti3q1tVjP1aW6lN
	 Ohwt61gPIODrJokDTn79xoicO4y4eFu3H5vF091rcXWHxJYugAsCycwfBIjU1AH0aR
	 iazUhX/oWl+aH3AeB8zP+kpaEuYkDEYauhvcso4ag2v1HnSeBCJ/I1MhkULkBnxhS4
	 bkjcbBEbxPNPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 123/317] wifi: rtw88: 8821c: Fix false alarm count
Date: Sun, 24 Mar 2024 19:31:43 -0400
Message-ID: <20240324233458.1352854-124-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit c238adbc578eeb70cbc8fdd1bef3666b0f585b13 ]

total_fa_cnt is supposed to include cck_fa_cnt and ofdm_fa_cnt, not just
ofdm_fa_cnt.

Fixes: 960361238b86 ("rtw88: 8821c: add false alarm statistics")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/f3cb6d17-e4e4-44a7-9c9b-72aed994b5c9@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 280602a34fe67..eb66f494382ae 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -667,9 +667,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
 
 	dm_info->cck_fa_cnt = cck_fa_cnt;
 	dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
+	dm_info->total_fa_cnt = ofdm_fa_cnt;
 	if (cck_enable)
 		dm_info->total_fa_cnt += cck_fa_cnt;
-	dm_info->total_fa_cnt = ofdm_fa_cnt;
 
 	crc32_cnt = rtw_read32(rtwdev, REG_CRC_CCK);
 	dm_info->cck_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
-- 
2.43.0


