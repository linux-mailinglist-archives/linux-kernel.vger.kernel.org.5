Return-Path: <linux-kernel+bounces-113892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4795188872F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C300DB2159C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6520E62A;
	Sun, 24 Mar 2024 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igb0Ngjt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592C1DE12D;
	Sun, 24 Mar 2024 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320967; cv=none; b=riOwTA256LSreZ9AdoeYLauKjyfQRKh48b9h7mfPN7EkhmreiCKUrbmVjDA4w8YIUlpDlL5mkFMSGzcEJgjvTIJjgmCIk+yOaiLRy+O4u2lXKZkH/oLw2+fMBoizG9AOlLUR0gO0RuJa0y/KzwJTa9iel/0aZukcLfSwNNPVdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320967; c=relaxed/simple;
	bh=6d8vYBUrO4Vbhqa++pTzSboo0d76L1VMT2hA2lPcTZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZM0ktLJatT/DSC9tgCwAhCmAywvLebUCyRObTaMpId3H39ex4wQyxlWghzOqb1Ht5FViPE0rX8fdsXe+YPUniGDNxqCx2Hov0H8O0D6a7dx5nI2HBcsgqKWQgvITQjhSWfRL+iaebMrwm5KKNL34ArtD9FQdWszXjnJnDmXLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igb0Ngjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE74C43399;
	Sun, 24 Mar 2024 22:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320966;
	bh=6d8vYBUrO4Vbhqa++pTzSboo0d76L1VMT2hA2lPcTZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igb0Ngjt2StsmmdP4cGnMXA8g+jLYcZTieh8s9Mia0PRmRxfmlRxc+MIHbUhpmyYX
	 lfKwJVjT5bhZCA0JZmFm+EIuFpsEvwZ4isKmzRjYiDmDZ7zbMS/usnkkVvmTvsQaSS
	 Mv6v1ceUwoqD2XRq1gQXTbJPNelpi4aKy/1kOhhYYD/G1W2+TmJZAKu5XVY7fVYi6u
	 0EQ3rNfVHlYlvyBb+0YnjBUDVZcPDPQMiOs9qPOdOg9ApW/vgSEY24Y4QTD7gBE39c
	 O0iAvIza9tAjAVVs421Xav2R0tRfP4urnEF6wTUYFpuavZMOQjLgeJVsKr8rAyTrNi
	 d4RluC9PjMEkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qiheng Lin <linqiheng@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 529/713] powerpc/pseries: Fix potential memleak in papr_get_attr()
Date: Sun, 24 Mar 2024 18:44:15 -0400
Message-ID: <20240324224720.1345309-530-sashal@kernel.org>
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


