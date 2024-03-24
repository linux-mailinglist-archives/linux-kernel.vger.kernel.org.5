Return-Path: <linux-kernel+bounces-113767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C75B88867E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83E728707D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B931F30A3;
	Sun, 24 Mar 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy4rf5wk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755E1E16A0;
	Sun, 24 Mar 2024 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320774; cv=none; b=Xb+/9KkHD+4iw7zdQH9CorKB6E9jUsgHcLilV+UbnuUWSIfskSXz8OfedSJ0Bs1SVFU9/xdH/6RJ7fPjPdSu/AAq0dpF2YoSvH9/eZAZ0Z/Z+MXHWj7kZi+wG6U/eZE3CbfPDmlkiVEB+R3s8vAlKXdhxt85nivL+V/ZfSnv/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320774; c=relaxed/simple;
	bh=g8KGzfYA/4PhED1+413GJMaRIZogAcuGh0s7OPJeDzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2bGlKfPBrCPINy9U8edXvNjZuiaxED1/tldxlmsUdJQWQnRxqtGBKeU/l4km26INRUhhwTKtcxMRXOaQakDsHmYyeAV+G9ycnDHkRyE/nkEn5bZUcdZKg0yHkxJgHY9Xfg0oSzjs+UvVMmqFhLc9qgmtZu5EkAD8CUfwqpAr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy4rf5wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972C5C433B1;
	Sun, 24 Mar 2024 22:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320773;
	bh=g8KGzfYA/4PhED1+413GJMaRIZogAcuGh0s7OPJeDzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hy4rf5wkI5bOYL4vlWGt+IiMgR0j95UurJBut9XENO4laEDvJ6vEJLfxhRT1ImTos
	 ywoeFU+byzKkxAqvrZY2ZHO9pyItI6cFG8jxx2ux9z/KLjlvo7RpoyiRQdMVsrEGWR
	 AhsddVTb/z8utyBWfdP6FVAfcTsZ4bEsv6ExGwd/Ep7vxCIok5urSNG9PFLZ68pLkF
	 aCddcMuoEPz9aGTkbeIb9Qf9yDk7npCDtAx5f+mXDXe+SB9qHIpulNdkmaJE1uTTti
	 LEg21yCLl5qU8awu3RK2e1F//uAUciBCagAaiRVJhTbhudNxk9FvFctW30WuM47KWN
	 eIdnkAY+KOFNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kees Cook <keescook@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 337/713] wifi: brcm80211: handle pmk_op allocation failure
Date: Sun, 24 Mar 2024 18:41:03 -0400
Message-ID: <20240324224720.1345309-338-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit b4152222e04cb8afeeca239c90e3fcaf4c553b42 ]

The kzalloc() in brcmf_pmksa_v3_op() will return null if the
physical memory has run out. As a result, if we dereference
the null value, the null pointer dereference bug will happen.

Return -ENOMEM from brcmf_pmksa_v3_op() if kzalloc() fails
for pmk_op.

Fixes: a96202acaea4 ("wifi: brcmfmac: cfg80211: Add support for PMKID_V3 operations")
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240229103153.18533-1-duoming@zju.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 44cea18dd20ed..8facd40d713e6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4322,6 +4322,9 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg80211_pmksa *pmksa,
 	int ret;
 
 	pmk_op = kzalloc(sizeof(*pmk_op), GFP_KERNEL);
+	if (!pmk_op)
+		return -ENOMEM;
+
 	pmk_op->version = cpu_to_le16(BRCMF_PMKSA_VER_3);
 
 	if (!pmksa) {
-- 
2.43.0


