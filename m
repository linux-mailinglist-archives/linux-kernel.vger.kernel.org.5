Return-Path: <linux-kernel+bounces-113392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0A58883F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E371F28F46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0D31A2857;
	Sun, 24 Mar 2024 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6SMgv2A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D506F074;
	Sun, 24 Mar 2024 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320193; cv=none; b=GFMPtp8i766ubwSrHF9Lp+FjZpR2VaHnBnShnXtGLpaNZ/KJyBypS0nEZ/zS4po5ioqGD6sSE9dzr2oPC9ni89aGNTsqESf6G5ew1D7KPIXwvpHlMlFuPr6IX07gae6AvlP8T8Ri2FcGnSrdHFsyH4kElt60IvZMWvlzeZYeK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320193; c=relaxed/simple;
	bh=6d8vYBUrO4Vbhqa++pTzSboo0d76L1VMT2hA2lPcTZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFZuWXyv0oU/AgmDuGODIQKd6wPdEtrmQATnk/wlAJ4+e5HZx8Gdg6h/VOuEjNAYDsBuPgTLgAX2ODOtMCT5ctqfkP2JSr/sLAvhPchCBJTBO/zYq920dLKUqF3LdQrMYVBHwxBN8gSMob3vlaeq0MeqE7eQ4N+yI7WuQh1lt48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6SMgv2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E286BC43141;
	Sun, 24 Mar 2024 22:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320193;
	bh=6d8vYBUrO4Vbhqa++pTzSboo0d76L1VMT2hA2lPcTZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6SMgv2AxAUGg/FvS/poh/v1WlXwF3p+zXR8jittdWzAwqATEMfTl1lv4s10KCga1
	 a1z5SNmCoj4LZ+MS3rNXEzOcCtc5QJrzYrbcpQluD9c7JEwxtE/UMuNg0kwPnsJ0j4
	 oma4KILAqqZMqg327KhGbUJgiJPnXQGp3CaKGe09NvPM2vEArCSaM8pmkhw+sYUXV5
	 gMWUIcERFYVgmEIq+iQjTTTpDhM9mSGE2LhjTe9Rj8L8DzciWdKTLaGu3xM+3W+v/7
	 ZSvcNgRCE2WIflJctI+YXpinHshnOac/eogGV4YX/6FGcrKz3Kx7kpSnyW7cI1M5iK
	 wwo9StYRg7BwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qiheng Lin <linqiheng@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 501/715] powerpc/pseries: Fix potential memleak in papr_get_attr()
Date: Sun, 24 Mar 2024 18:31:20 -0400
Message-ID: <20240324223455.1342824-502-sashal@kernel.org>
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

From: Qiheng Lin <linqiheng@huawei.com>

[ Upstream commit cda9c0d556283e2d4adaa9960b2dc19b16156bae ]

`buf` is allocated in papr_get_attr(), and krealloc() of `buf`
could fail. We need to free the original `buf` in the case of failure.

Fixes: 3c14b73454cf ("powerpc/pseries: Interface to represent PAPR firmware attributes")
Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20221208133449.16284-1-linqiheng@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/papr_platform_attributes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_platform_attributes.c b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
index 526c621b098be..eea2041b270b5 100644
--- a/arch/powerpc/platforms/pseries/papr_platform_attributes.c
+++ b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
@@ -101,10 +101,12 @@ static int papr_get_attr(u64 id, struct energy_scale_attribute *esi)
 		esi_buf_size = ESI_HDR_SIZE + (CURR_MAX_ESI_ATTRS * max_esi_attrs);
 
 		temp_buf = krealloc(buf, esi_buf_size, GFP_KERNEL);
-		if (temp_buf)
+		if (temp_buf) {
 			buf = temp_buf;
-		else
-			return -ENOMEM;
+		} else {
+			ret = -ENOMEM;
+			goto out_buf;
+		}
 
 		goto retry;
 	}
-- 
2.43.0


