Return-Path: <linux-kernel+bounces-115448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C34889B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C291F2B817
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15C421616E;
	Mon, 25 Mar 2024 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1A8Gm+e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69821E4A3B;
	Sun, 24 Mar 2024 22:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320815; cv=none; b=uVwMSXfRACplCusWvI/iqQVkiq4K2YuOdNNMdM4MAy1EEcS7HnStlXEFCOT2V25gHeBX0+Nda8+BN5UZWIFfKCZTOlKQ+KYcou/kYy66IEJOFbnzZlatUY/iOOpAcyCK9obHYSa1XlyzIKuZQL8fgz5WVpBMqMer+PbMCq5zTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320815; c=relaxed/simple;
	bh=OQsM+h49KmJCuY/Vc4xjJEjsD2hIGGvvSko+Q3j56jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InSeFWeJPMhhv3Fb6/ZMbVl9QrzbaTxKbI8IJmZCocKTrtBfklLy98MRDm6LaYvPJYodXo3BqSr2Y+ER+n1fuxMX6qr0qD12HCWY1uLe5e+iMZWGqfSKF2L+5/wXmCS3DE/sYykR7Nk0aNMOkTUn+iSCg034704icNnsV2BMcX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1A8Gm+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D439AC433C7;
	Sun, 24 Mar 2024 22:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320815;
	bh=OQsM+h49KmJCuY/Vc4xjJEjsD2hIGGvvSko+Q3j56jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1A8Gm+eCgoHnX43fBs7zSdREZL47udNJhabUfpVTEAfs2SgNfhh7IStahjJ2e+94
	 MA5LMwLHmmixXOQunNDWa2LNmCzn2jCV2VGMZLODCQp8PsfTwTS9/EbvqGJWQlfUsx
	 Pc1xAQFlzPMDg7Pcpj5TMYiuryiTGhVecplNM8xIz6DEo+KeKCS8D64nle+ATDJ6RS
	 ekmXFfXFa2aITM/fh+16LnJfQiE2pzbPfW2mSSu+5qQ8p6oInVjeSJ7LOgYLbKwxrp
	 kztlllbfinEZd8ziTuqutXvns9D6RUiN+j0jbsIrD+LVUd4XJjaxkQFfhgXZqafLoh
	 beyBa5QVbAsiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 380/713] l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt() function
Date: Sun, 24 Mar 2024 18:41:46 -0400
Message-ID: <20240324224720.1345309-381-sashal@kernel.org>
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

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

[ Upstream commit 955e9876ba4ee26eeaab1b13517f5b2c88e73d55 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")
Reviewed-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_ppp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index f011af6601c9c..6146e4e67bbb5 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1356,11 +1356,11 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	err = -ENOTCONN;
 	if (!sk->sk_user_data)
 		goto end;
-- 
2.43.0


