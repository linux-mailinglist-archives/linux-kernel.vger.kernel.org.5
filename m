Return-Path: <linux-kernel+bounces-124679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FEE891B50
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC8B28E93E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806931428E0;
	Fri, 29 Mar 2024 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+kXNEgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B31422DB;
	Fri, 29 Mar 2024 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715686; cv=none; b=lITTghMUsZaolSzDNo71JFkH4dtTntdfdR7jUHsg/sFZ6YAhQNGn46p9MYRuzb4QCpFWCsne2YYvlq2udRVQS9fIgBImcB79dQAVA0Jt6ivYy+j9fM/quyYuf8YbhXuzVY4+TymwoT06/tSUkDQ36UiSLUT2Lg55vhUQWPKzztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715686; c=relaxed/simple;
	bh=Ra4UXu1BegVD/dxe6uYDNjPmp+4p/Ri+3qwVOVWo+MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jBwuhzm/MCpZBGXiN9v1e8ihZp+nNDiliizpepbW1QQN23dUKkBczVtyQZ3+m2XhAlvxtQ6uyy9AdEnrJXDMkR+ZUXSerilggz6dbhf1ooIcbyqVCVDVcWJynVcaczF13AZ7RLhovnZKUN2WFEgq36O3RYFAhL67cEN+TTHdxVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+kXNEgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6202AC433C7;
	Fri, 29 Mar 2024 12:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715686;
	bh=Ra4UXu1BegVD/dxe6uYDNjPmp+4p/Ri+3qwVOVWo+MA=;
	h=From:To:Cc:Subject:Date:From;
	b=a+kXNEgkMcJJ1uQ/n/o6HCgBIs9LDUUHEE/Gsw7wrIsglmWsy0ykE/QLq4XGEoeY0
	 setr5u7IlrNduiZEy8cJ28pYvzOvr8fBKI6/HQq3+F+EubXpR0H8rUWdeLgb3In/2b
	 wHmnTqVvtPbf1yV1y56KS72XndmKZ06lQrdLblOMtQwEYcn4nmvn04gStdqzZ0jRrN
	 GQ1xLkHr9Ta+iJYuDJqEP0+Pp530FAxMDbZApTxNZqK9JVwQTrhU2AlVG8lVLUlWL5
	 SOOvlueaiEH41gsHdNGu0HBhW5j0ehs7pTI3RrGx2sq6mroaytvv/OXjXJXiDQRBMK
	 +bXniNafReEbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 01/15] wifi: ath9k: fix LNA selection in ath_ant_try_scan()
Date: Fri, 29 Mar 2024 08:34:24 -0400
Message-ID: <20240329123445.3086536-1-sashal@kernel.org>
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
X-stable-base: Linux 5.4.273
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


