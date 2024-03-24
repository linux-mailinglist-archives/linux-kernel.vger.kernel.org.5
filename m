Return-Path: <linux-kernel+bounces-113181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDDC88821A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7CD1C2246B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831A813C68C;
	Sun, 24 Mar 2024 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGC+aCQB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B013C66C;
	Sun, 24 Mar 2024 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319983; cv=none; b=ujX7NMHSJZTISTS9+11CLZfksMKxG3T0aqv/dxq26DsFOTLw4BqthS88cP9AsKqFQRZByYXAO0SK05Ox7RdqiM0R57axVMAG83LhNM0WlusNauQzjuodsQ75+hvfNwL2Oc9SPAzoF98EyxCRzguvhqJuYWJgpnbu76c6TK9z3Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319983; c=relaxed/simple;
	bh=ODNq6VjdTAkK9hE3MwH5qsHXBCQEHWswAoxlRaHG5z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qn//k86UjFZ9b3qnnb/Qf3pFU36eNmAalQjMSFrn17V6iDkbVKfkwd7etmCribzhBU50k80gLK163XIoMvYjaZmWYV+Ren80zj9d/dVZ6/COUf83U5J8Os6CW2Xj7sS0VmkKRZxycij3vxO0XFZoF0gXHzczXrFKrMY31jmNQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGC+aCQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD690C433F1;
	Sun, 24 Mar 2024 22:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319983;
	bh=ODNq6VjdTAkK9hE3MwH5qsHXBCQEHWswAoxlRaHG5z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OGC+aCQBfQSWjMCzEGOOAWofOuLso//5GwAhzAacjWORtT9oPJPNm+Dz8kA8h6jJe
	 Cy+eWxglBri+EsCiOIzfNjmS6zjhrq2+fcSDNDiqT5oYKuG25P1FiVJKFaSvhNH46m
	 fyOHqaYu8L5UhCN2qb2jGetWWWovBlYohlpv32dosqwveUxVzo7ojc/X0PXCI3BCV/
	 GONJlsfcpD3xwbkMXILjD87CKi3aOQro3D5OWPgpuqHkDhzz7bQ8itgj5/ZcmFYMEu
	 0cpUySwBM4OwgDhMHKUHFsg3A2P3+Nb7cQKCASMbksEgXjfXq1KifnEAiamvyGyX1K
	 PQi/bIPaCIRcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kees Cook <keescook@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 290/715] wifi: brcm80211: handle pmk_op allocation failure
Date: Sun, 24 Mar 2024 18:27:49 -0400
Message-ID: <20240324223455.1342824-291-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 28d6a30cc0106..1a5d7494f5e80 100644
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


