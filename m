Return-Path: <linux-kernel+bounces-124695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D7891B81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A186E1C21B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215EB17497E;
	Fri, 29 Mar 2024 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxkPTF5k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C9142E7E;
	Fri, 29 Mar 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715723; cv=none; b=JFpcvZqjHygUpx5mwCdSNEkjKz6cKF7N3gxDwK2IHdUzHlmjnuSehFORAiPmstBqML9CVFnPqtNe4V+ESPDXMSZFHk3FiYe80EtZ0FEbhoiVhG4QZ/v8jcpLdUpcXlx426QHflwXfEl4JFKhnxaU9fiWHvI5YzZVb+An3tfLSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715723; c=relaxed/simple;
	bh=1GtH/erExVGz0ScC+7d4AU7fiq+KxopxGG/bYX1DvK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MYEStWP4pUf8txFe25Hz1u39T6lD5IgIwkL8j76ZE9TiWVBICPTfEKgg/GBmNpuikSW/i+nAREpuxnsOo+lMzLa1iJCQSGxe46RgVDNJzsMiXpkz/mOchwMkn6RNZHZuN7PkadQ7KWpJq69Dyuvorw0D68HP2frcTT/qbhPJEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxkPTF5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C46C433C7;
	Fri, 29 Mar 2024 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715723;
	bh=1GtH/erExVGz0ScC+7d4AU7fiq+KxopxGG/bYX1DvK0=;
	h=From:To:Cc:Subject:Date:From;
	b=WxkPTF5kxRGQK4gckfr9rmYqqlqelPpURFcWf2EvcqJHzCx+5ZvQexAXN3oazrzTQ
	 9a0qBeeJPZJeqCWZ8BEwCXKXXdCabK8gwg1dBXtn/PB6VHAVoNX4UHMg9+bkbtTcit
	 0twwwlHmhEmFVtp1204LAZg8zM0HmRJuQ6aLYEkFG2WrAw37e1Huq7uJ0n3AvfIIZv
	 XMFXcYgnPMf/sBT2TwKEQZFARK/JkgFuEd370b2H9GQ2gEKgefgCpCEtf/vJlt2xVD
	 QyQ0RZ1JfwOeqCkOJTI2PrLV8dCbe1dSqbbww5/99OkC29qF5Loh3QzgdPaxL43A34
	 lCZA4WeJ/rzwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/11] wifi: ath9k: fix LNA selection in ath_ant_try_scan()
Date: Fri, 29 Mar 2024 08:35:07 -0400
Message-ID: <20240329123522.3086878-1-sashal@kernel.org>
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
X-stable-base: Linux 4.19.311
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
index a3668433dc02b..deac6184dd016 100644
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


