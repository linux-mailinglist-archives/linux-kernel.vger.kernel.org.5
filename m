Return-Path: <linux-kernel+bounces-124604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A8C891A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876E91C25A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E381513E890;
	Fri, 29 Mar 2024 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW770FVO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13E13E6CD;
	Fri, 29 Mar 2024 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715528; cv=none; b=ajqKu2IG/wFmw20qRAQv9/YiGKtRaWEP534Rqb6BGEh++J7hRD+eBAnWZwGMqqSzS6iAsxrBWiNoZXRmHOq7+vrqdNV1X+zuOsGcRNQnE+c8NnM23lEmHyGsVpg/KG72+2jzFWP/Z3lTlyZh+/z3YzJhIeFUYHKmCcZ/Oz+2E5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715528; c=relaxed/simple;
	bh=Ra4UXu1BegVD/dxe6uYDNjPmp+4p/Ri+3qwVOVWo+MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PiiDGv4lADzXEmcl9G5PkYVkSUuwPwa53B6KD+U00RImy6Fczhlppqltcg22vrcUKKrAF8i3X/9IQpWUVQqQjoG03nMhmVrTxiJ1hYAP6UhJF2jEHcJiOhwg3xNC53/+Wnud/r7dJ8cELErtIC+V+oVJHddvdwTC4tcxAY8p7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW770FVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10BBC433C7;
	Fri, 29 Mar 2024 12:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715527;
	bh=Ra4UXu1BegVD/dxe6uYDNjPmp+4p/Ri+3qwVOVWo+MA=;
	h=From:To:Cc:Subject:Date:From;
	b=UW770FVO/AEPO7/ExPCZDbkSdJkZ9qtVrMJYgzm2UHoK6o/+k8Xjbz+e/RV9z9Rvl
	 SCio/CichN33Yj/4uGrhzJEHBx4mNB2qwZQZVzMhBvYQ+YPwMcLcmvEndXsLM4BlEc
	 69MoLawZC6s1gpj/NEwhxXeqHi5CnFhKvPyUr88Wjwm5+KnRaIn1DTeEhf9PknjG8M
	 GRivAFsU7anxDCRRL1G80UhodScWhEgpboVDqcL/u85zzEuS2IdTNrdbjBIf2gMLkU
	 VCkMUtbVmbKWiid+0DjSkrl9EOOpXN5srF1PXFXeK0klaGwa+Ngq2M9+jv4VkBLZCJ
	 dyik0HvrTwAzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/31] wifi: ath9k: fix LNA selection in ath_ant_try_scan()
Date: Fri, 29 Mar 2024 08:31:20 -0400
Message-ID: <20240329123207.3085013-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit d6b27eb997ef9a2aa51633b3111bc4a04748e6d3 ]

In 'ath_ant_try_scan()', (most likely) the 2nd LNA's signal
strength should be used in comparison against RSSI when
selecting first LNA as the main one. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20231211172502.25202-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/antenna.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/antenna.c b/drivers/net/wireless/ath/ath9k/antenna.c
index 988222cea9dfe..acc84e6711b0e 100644
--- a/drivers/net/wireless/ath/ath9k/antenna.c
+++ b/drivers/net/wireless/ath/ath9k/antenna.c
@@ -643,7 +643,7 @@ static void ath_ant_try_scan(struct ath_ant_comb *antcomb,
 				conf->main_lna_conf = ATH_ANT_DIV_COMB_LNA1;
 				conf->alt_lna_conf = ATH_ANT_DIV_COMB_LNA1_PLUS_LNA2;
 			} else if (antcomb->rssi_sub >
-				   antcomb->rssi_lna1) {
+				   antcomb->rssi_lna2) {
 				/* set to A-B */
 				conf->main_lna_conf = ATH_ANT_DIV_COMB_LNA1;
 				conf->alt_lna_conf = ATH_ANT_DIV_COMB_LNA1_MINUS_LNA2;
-- 
2.43.0


