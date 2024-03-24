Return-Path: <linux-kernel+bounces-114222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAC9888937
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45677282C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A9125286A;
	Sun, 24 Mar 2024 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq8xwZRK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F220931D;
	Sun, 24 Mar 2024 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321565; cv=none; b=s7jnKFTA+S5EAUVkPGwbT9VuKcsn5g4aBmm6PVXHKSTfCAsier3cwcuPNyiFuKCG+s4UJuY7wF935WGXImgt57FG/gyRCpivyeaSe9dYlF4BST1so7OEyBF/5Qu7PRKcM5Er6PK54b1u5K6yzr5KRBIeYCLKFfX0vm1NeZJnbak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321565; c=relaxed/simple;
	bh=pc24hiC309vacFRrZlWMKE7979a18upVKEad8E06QT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YX4pmz/r4+pTK4YK3TfCOe2iE4E+/KaGuu1mX5xPteCYEXFeLZoGdaN8/4SH0HRiH3j3y3a7IL2FP8Sd8yATo1tEPAL3LsHkYkhiEz1ylfYvKLruN8HsmiAS4noT1+Rc3zllgMiOht+C+oA/x9ZWaBpBJtL7+nEgCqftqK2J0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq8xwZRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE0AC43399;
	Sun, 24 Mar 2024 23:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321563;
	bh=pc24hiC309vacFRrZlWMKE7979a18upVKEad8E06QT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dq8xwZRKp+kVFGyDPLjXfSuXdnBmsMttyDGSHkzz5uFQteuy5b0WVnmX9Yphq6d5R
	 WbzOF92xbiF224Tay7pTl9i1/aPjUHa3l79SlKAUdg2PcyfRL2YgP6KBisaatE87xV
	 AvyMEuedAcMWQvFqAXlXhRsHYURTEqFVyMvL7MOwF2sIMhhk2IpF6OvNSQ6sf7XMaJ
	 2EiYtvY1Rv5dgk/cGK+Os6m3Pxl5X0z+XGRmCEVsNzBXeR8X1zM5lHlZBZGEAjvWuC
	 R5YVtS0GYVSjffP61AuZW73vNfqyPlO/c/UiTa6IP2RSqfWR8mYhlbpisSM792x8z1
	 A6BoLe+rvCC1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kees Cook <keescook@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 292/638] wifi: brcm80211: handle pmk_op allocation failure
Date: Sun, 24 Mar 2024 18:55:29 -0400
Message-ID: <20240324230116.1348576-293-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 6049f9a761d9d..df9c26593dbe1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4323,6 +4323,9 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct cfg80211_pmksa *pmksa,
 	int ret;
 
 	pmk_op = kzalloc(sizeof(*pmk_op), GFP_KERNEL);
+	if (!pmk_op)
+		return -ENOMEM;
+
 	pmk_op->version = cpu_to_le16(BRCMF_PMKSA_VER_3);
 
 	if (!pmksa) {
-- 
2.43.0


