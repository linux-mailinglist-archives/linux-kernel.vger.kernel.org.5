Return-Path: <linux-kernel+bounces-115207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1072D888DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C2D1C240D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFD51CB667;
	Mon, 25 Mar 2024 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7tUZDH0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406DF2944A9;
	Sun, 24 Mar 2024 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324286; cv=none; b=KbLnvjuiE0mW26Wwi+IFXK56SF6wj17IPpbg84v96LrrllHQ+NaB6z2uFihOpIajzB7q6o+sNQ8a73JjAOCn6VCHi31WPq+X9JHXliPD0+Z1PS1wMamhBjp8Ih8L9RhzVSAY9IEgis3Gfc0knc7QCwvX2QoBpZ+p9+MbMoNi90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324286; c=relaxed/simple;
	bh=8y2ALWR45OaPP3Yk7OH4re6Oss8mMCQwxJVebggh1Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ab5zgNKONiNwqYDYUwbMZkjC5nhBNsPzFmiU6JDcU3L5wntiNYZJPtkH68o37umqxT/rdKGlpZF3rfaFg0He0Dy2fADiyIFd8wwf3CyGbPJS7nMrgFmQxcHapfqvlqWh3xMfkSr/IyUiGKi1aCQOSdvmlLGAK5zNjRpmOdxMrVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7tUZDH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DFFC43394;
	Sun, 24 Mar 2024 23:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324285;
	bh=8y2ALWR45OaPP3Yk7OH4re6Oss8mMCQwxJVebggh1Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O7tUZDH0IL8g2nGp1D9zwpbQBdEwtfHH8KF/w8890dBPb4z9yMH/VqQgXxNGgWYx1
	 +2teSjcRURxO0ff01QQlcf0KfRTqMI8tBoMUOhU+Vp0EvCtlEbSiPJm8jjoipBPEAK
	 sxD/6lkqAAw7YLEzZ4/erZ6dvTXxplWfwXJGsil+tI52+hkBVNwwN3p68xnuJnB2+K
	 8AIhfFvTO3ncT9S06QHMkETaiLeSXtMuBxDvnZBwmA8Rva/iKvPUbihWJa5oAKA1Sp
	 i2tdtGS/Xp/0c8NkI1+52IqaJQsEQqu8Zx7DgM4Rf71Wqf0469GnQYPrbD7J1SzSaX
	 /C7LRkpie3fYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 061/148] net: kcm: fix incorrect parameter validation in the kcm_getsockopt) function
Date: Sun, 24 Mar 2024 19:48:45 -0400
Message-ID: <20240324235012.1356413-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

[ Upstream commit 3ed5f415133f9b7518fbe55ba9ae9a3f5e700929 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/kcm/kcmsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index a82892c288600..45450f0fd9acb 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1276,10 +1276,11 @@ static int kcm_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case KCM_RECV_DISABLE:
 		val = kcm->rx_disabled;
-- 
2.43.0


