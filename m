Return-Path: <linux-kernel+bounces-124635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6ED891AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290392882B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E748140E40;
	Fri, 29 Mar 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzGuIZcx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B6A13FD89;
	Fri, 29 Mar 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715597; cv=none; b=Yr6GplXCaeLSUuLtBgjIJlGC0byt0HGkhtMPBeeASjSiqU/z1PU0X1Dh6L3nuFhi/uBDrs7BLOMvdYqMIknHmNWLtBmK+y8I8HcO/lAIUQ1lA4ptT0CQHZANRA4vUQ4YkqRGFf5IWno8g2gWVI5jAP0UrmJ51T9QvbUS7vMP6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715597; c=relaxed/simple;
	bh=Ra4UXu1BegVD/dxe6uYDNjPmp+4p/Ri+3qwVOVWo+MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P7LU7xFPWQlP/xPpCCF9ZGCi8oFx0plzpWk0bqTBq4ybZLtn0W/rTFyw3mV4TGa7DPzWG8wCg7C/99IIGCAiRp22MeZLeHHNbG7WUPeXDgROgzphJ87fRNSSdp9O1ua4g+PVOrFni7lfcDvGk8mzXSDlIFzKyYBb0Z/fTfdTc44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzGuIZcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80902C433F1;
	Fri, 29 Mar 2024 12:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715597;
	bh=Ra4UXu1BegVD/dxe6uYDNjPmp+4p/Ri+3qwVOVWo+MA=;
	h=From:To:Cc:Subject:Date:From;
	b=hzGuIZcxa4ANbItVlf+oST4DHvBaa+3p7pmMiltnYjoBjpjTIZl0Jy7UtPCdl4SR4
	 KZ534XrGK9LGglJ5UQQWFRcj+YHq3YnkYn0hNWimJFatEHAZE8+IL8p3Es/DPMHHPZ
	 wM8OukL1SYPBWFwAuK06Een1HijJFwdjAqpHeosR0hqG/HQ0JHAwYNsNNwU7mIBmGG
	 PMffvXxCXT/+Odi+czkvtAjq2RXW7e4k83/o48syUQVTcptLM7JI8S/j3scPWZYmj7
	 C12m4vs9SzPbIkl4YTaSGQEuWCVC087Wim/MoHy+hdZi3ETXvpHUVGnmO4zO4RbemN
	 kZ19ojNw9RwTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/20] wifi: ath9k: fix LNA selection in ath_ant_try_scan()
Date: Fri, 29 Mar 2024 08:32:49 -0400
Message-ID: <20240329123316.3085691-1-sashal@kernel.org>
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
X-stable-base: Linux 5.15.153
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


