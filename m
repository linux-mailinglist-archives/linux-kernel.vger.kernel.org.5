Return-Path: <linux-kernel+bounces-124482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB568918B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F238B2363E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D0A128389;
	Fri, 29 Mar 2024 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObckFNdG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E585C44;
	Fri, 29 Mar 2024 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715214; cv=none; b=p46AoPGw+OTfopVs8ZSyAhdzxLFIPDXHx0G4nlaKsZ0lf9oDvUT+9I8cVN1H/BCm88FzZdP6lLqWpKqijbjwDeyVMsznXl03pu+Kmmyurdkpp5FbN5n2iXHbwBefu424y9wxTg7eEMu/SSvCRotOwrCYaIdDV56m+DEj52alQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715214; c=relaxed/simple;
	bh=Ra4UXu1BegVD/dxe6uYDNjPmp+4p/Ri+3qwVOVWo+MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IF1wrRPfJeAYdtVUiRO0vSTe25/Ca3fxzEUZ7LJ2CGZjePdh3x97bm2qBMXxSl14qfuQE4INQjBvfisa1hF3bnAjmf+S/J5FYmTMx4aQqLPXAKxaKHxg+aOie8jFu4SWCB6FEzLeGQty02BzITvOzlNpGAoBA9OHaDnKQ7Fiwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObckFNdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAA1C433C7;
	Fri, 29 Mar 2024 12:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715213;
	bh=Ra4UXu1BegVD/dxe6uYDNjPmp+4p/Ri+3qwVOVWo+MA=;
	h=From:To:Cc:Subject:Date:From;
	b=ObckFNdG+45nGWzKJi9c0jBsoSFdpTdIvGKeX/7Oon/znd1IuJJP9gwgzqxWJ91U5
	 y5r7gEpz20sYX07qCwA5U+/cSYX7HoOW1kBVVYqQ+GA3tNR+v1ApMh4C0rsW1CSEnl
	 S2FHj9TE+Ta92AkShhpcwPsZNIARVF3Lj4R6N9Yy3GpkrHbJWq5j9YaFf/dv6D5Rx1
	 jWginDVgZGsDYQNBW6tAFWtPinCtiTP63JPkd81j9IlgwnpZvF7RnYUtJR26FvhP57
	 7ySwT/qOSmWjLfR023f2Sb8IDpW6LQkh/RMy0j1HrIDUg7H3N3jgsffKmtdIxLQuhX
	 Cn0sMJqSM0qpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 01/68] wifi: ath9k: fix LNA selection in ath_ant_try_scan()
Date: Fri, 29 Mar 2024 08:24:57 -0400
Message-ID: <20240329122652.3082296-1-sashal@kernel.org>
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
X-stable-base: Linux 6.8.2
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


