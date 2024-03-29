Return-Path: <linux-kernel+bounces-124551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF668919CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26313286FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010013B5AF;
	Fri, 29 Mar 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFKojrdj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2CC13B599;
	Fri, 29 Mar 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715397; cv=none; b=oDJNF3I/Z2CFtYzFS4wqmQ/orLWVD9zvAYOmLIUKFDvYER3WfRTRa2fEhnGES4qqnJgYHpeTYu3zLOi98eVXE7hE8y+Cu1r7s1qMHC8ocXVTZ4zGHX0qcsSju+TnaJmy0H0bi8511lwjGBv39fr39VyXiRyXk3HMYcMjqBnymfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715397; c=relaxed/simple;
	bh=Ra4UXu1BegVD/dxe6uYDNjPmp+4p/Ri+3qwVOVWo+MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BObuwzj7DsgI8xHuhRcwxd5dOviLoQlboghyY0xVUoJamz/zNdvF/8lU/Ms3eiGNdmuNUv6IBpDcscSyne3OtglcBVNHxJKBc/pMS9yPrx/wR3kO/GCXZU3hwJwXHs+feC6ZYGZKFWokOGia2RJEcWJGuimOSV2LQMOdeosVNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFKojrdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A923C43394;
	Fri, 29 Mar 2024 12:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715397;
	bh=Ra4UXu1BegVD/dxe6uYDNjPmp+4p/Ri+3qwVOVWo+MA=;
	h=From:To:Cc:Subject:Date:From;
	b=BFKojrdjGbJCoTpGbw+mgQBNsnXJWd5ajkaFL8O0DV6WAcUmAM+N0pkNQVQkKdibC
	 AZp9AKdxRRWbW09dwQp7/GAN+DeE1VBznVfQMVGkfXvhGQPT9xXi1pHmqpKboV7GDS
	 j4FPwx0X62FncIauJgX2oT7yFgMyJrovxlN6ro4iIstJOdGKwfcFVEtXB/PGgwCv2h
	 yvmlFci+iQTAEmQCHqBNsHyRSw2FzZh2wZfPZbeG2XWdeSo0B7tTXcSmITHuUoNs9c
	 hVDVldT5eGF10PWa1B2Z8qHVQTM91OxG/vn3DIefqJfoQ0URazeiOFQqtDd35QjYi6
	 HpZkaDHLyGTGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/52] wifi: ath9k: fix LNA selection in ath_ant_try_scan()
Date: Fri, 29 Mar 2024 08:28:31 -0400
Message-ID: <20240329122956.3083859-1-sashal@kernel.org>
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
X-stable-base: Linux 6.6.23
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


