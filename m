Return-Path: <linux-kernel+bounces-122999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5743D8900DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E1A2951F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C201272AC;
	Thu, 28 Mar 2024 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPK5V3Kg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD797F7DB;
	Thu, 28 Mar 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634127; cv=none; b=W9xc5Nzd5bvJJzlP2tc+WzOsgkk3U312x6QVxjnAFzIfho9H7pMl65ZAb62RlLxix/peAWKOiZYC9SO820mh2RxwUorm0/22EdSS6OiYyBgEflfjNSDddfn3ygE8JlcocHjnjKQ+zJ3lsOwWQf71uwFzfX4DW2qZeNZBZiL+UtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634127; c=relaxed/simple;
	bh=AU0EMWvZcfI57/ucjAuU6FCtNN0yNuSL0V35UAUAfX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4uWIzW1X7c16eTBBqe+PoL8xd7TBO4skQsBq5S81syNVvU3gS7McyXvP8P5aHuRQG34J3VtTZ1HTSWyk+7FHdLS96tMlQbvaYcA5hNa2ol6fimGMaqNvQ5qkj5ZOg33kWakV/LLBZ2WgmK6BvH+bvjVy9ZY6diUPLFPGe9Bw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPK5V3Kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2670C433F1;
	Thu, 28 Mar 2024 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634127;
	bh=AU0EMWvZcfI57/ucjAuU6FCtNN0yNuSL0V35UAUAfX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPK5V3KgPDkyj3iTIIBxKJxVjFdAg8jtYxbSd9SRHGKJqF8w4Rc8EqPC3TaKvjyU/
	 bgKo9GkSE1AFpeVXz2S9LbS7ORvv3ukXYjA6TyUqvX1b19xQsQcezSY9o5rIT9xsMH
	 +wIFLxweqQWOd/L+kX+B7DNCLQQCE4DX7rasYwQQcb30t+Hito2SggNYyfuOHU+8MY
	 KSU/6dNpRl/BXWOjKc+hAMA9d5WlJAlKAR+Fdjq4YQv5x1HbsyPqje5Ka4S3fGhv13
	 sOb/XQg90RWKyVj1SuNKMlqYPXiuA85o3kbQWnXp1cfwrUTtSR5ogA2hJhX9Lg0AXj
	 d3tcuroXYjCtw==
From: Arnd Bergmann <arnd@kernel.org>
To: Kees Cook <keescook@chromium.org>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Cc: linux-hardening@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [RESEND] wifi: carl9170: re-fix fortified-memset warning
Date: Thu, 28 Mar 2024 14:55:04 +0100
Message-Id: <20240328135509.3755090-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328135509.3755090-1-arnd@kernel.org>
References: <20240328135509.3755090-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The carl9170_tx_release() function sometimes triggers a fortified-memset
warning in my randconfig builds:

In file included from include/linux/string.h:254,
                 from drivers/net/wireless/ath/carl9170/tx.c:40:
In function 'fortify_memset_chk',
    inlined from 'carl9170_tx_release' at drivers/net/wireless/ath/carl9170/tx.c:283:2,
    inlined from 'kref_put' at include/linux/kref.h:65:3,
    inlined from 'carl9170_tx_put_skb' at drivers/net/wireless/ath/carl9170/tx.c:342:9:
include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  493 |                         __write_overflow_field(p_size_field, size);

Kees previously tried to avoid this by using memset_after(), but it seems
this does not fully address the problem. I noticed that the memset_after()
here is done on a different part of the union (status) than the original
cast was from (rate_driver_data), which may confuse the compiler.

Unfortunately, the memset_after() trick does not work on driver_rates[]
because that is part of an anonymous struct, and I could not get
struct_group() to do this either. Using two separate memset() calls
on the two members does address the warning though.

Fixes: fb5f6a0e8063b ("mac80211: Use memset_after() to clear tx status")
Link: https://lore.kernel.org/lkml/20230623152443.2296825-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I found this while testing randconfig builds, a .config that shows this
for me is at https://pastebin.com/yWFKvZYu

Sorry I failed to follow up to Kees' request for a reproducer when
I posted this last year.
---
 drivers/net/wireless/ath/carl9170/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index e902ca80eba7..0226c31a6cae 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -280,7 +280,8 @@ static void carl9170_tx_release(struct kref *ref)
 	 * carl9170_tx_fill_rateinfo() has filled the rate information
 	 * before we get to this point.
 	 */
-	memset_after(&txinfo->status, 0, rates);
+	memset(&txinfo->pad, 0, sizeof(txinfo->pad));
+	memset(&txinfo->rate_driver_data, 0, sizeof(txinfo->rate_driver_data));
 
 	if (atomic_read(&ar->tx_total_queued))
 		ar->tx_schedule = true;
-- 
2.39.2


