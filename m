Return-Path: <linux-kernel+bounces-114600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76633888C37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 033BAB263DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844BE29F6D5;
	Sun, 24 Mar 2024 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+Dtugrh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62D2319F7;
	Sun, 24 Mar 2024 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322249; cv=none; b=r9HY57x/paxjwkh3BlHMmgW2wTP5i0CyViOq7GXtES6XZUflOoaRbicSLkl6kS5El0pcqVf8s2xAcISZo13q+3BQZzXlHRukTvKhNpTEggtqasGSwyrS3UA4KnUYCGL/kEVUv0ValNiGErkjTlwsni+U4wTIsSiwhqImnoX6aRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322249; c=relaxed/simple;
	bh=6d8vYBUrO4Vbhqa++pTzSboo0d76L1VMT2hA2lPcTZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3kMpb81CV1G7RcDQ1krd7JrZ8EDKSPTS4pLKiUZL1Lxq8KluYwdacrEFnj7eLv33QyOeVb398qmmfISaKE4CoAu/EkdQKAZxHSvBWipr55Y87liAx5BBU/UTTyhYZLMGJcLSpifgZvwFwaY7y5hLIHmiT/VfEJ3qaoiWke15Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+Dtugrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F64C433C7;
	Sun, 24 Mar 2024 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322249;
	bh=6d8vYBUrO4Vbhqa++pTzSboo0d76L1VMT2hA2lPcTZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+DtugrhqL8mbw9aqsJPbzIhjr8wlLhXHUsFbOcAmR6VpYLgnthbRaNKI6cwdP/lG
	 D17mw9WCJmTtJDa/XCwhGJ/5hJPc34bmrsTnnCguD0PO+ThJRX6tHfESeTrRJeyT0r
	 8GaY7VUEmcSXa2NL5WVhTLdQHR7NOxfrejySqkVXylNFivpc0EVoz/5EvEr+amb/ll
	 yjAeIpVVq+yCnlmuOsaTL77Fqw6wVLh2sUNL2MJFBCeSXVjpTixTgye6UWpBueHMZp
	 8rH41GsUzmgRkfrXzR22Tmc2OsIb313/GBW4tXoFHYCgNAEj5fob0quScdUUt23uMX
	 6hJ6lNJDXk16A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qiheng Lin <linqiheng@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 331/451] powerpc/pseries: Fix potential memleak in papr_get_attr()
Date: Sun, 24 Mar 2024 19:10:07 -0400
Message-ID: <20240324231207.1351418-332-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


