Return-Path: <linux-kernel+bounces-82218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BED8680AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B43293DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F31131735;
	Mon, 26 Feb 2024 19:13:30 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C4130AF3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974809; cv=none; b=DS/pgP+/wIl9MWfuTaNfTHPNCTDLGlGiJdl4tvWfYhfihPtvUP5UgEgI8pDL3wIQy5k5QbJTGzZLb3Oj9MvCw4IMJ3DcMOhn3EGUZZZXuFJBTZXpvWzOrA9TDVlEkjxkEke1vuBxkj9kVedfrX8U637uYpnU9L4boN3aI+nLurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974809; c=relaxed/simple;
	bh=E1OsgKPBvfp3gZK5Z9YheV3ogwQncmYEzQNRgaWN4iA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8PgEiG2WjeZl7sPgqEV3bVAbfT7dWXFjmfklrjgRaUsniPd2gBdrzN7Q568TQBF3Gqo55RTOA1+JqAlx+wQUQDoouJL1zEN8Y0qi28msSLDLQhtXg7gm6qJ8K5E9r5T0/rKvqh280wIUj5V2rAr8Sp6goZBk3vrP9Z2J5Cr2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-188-097-209-155.188.097.pools.vodafone-ip.de ([188.97.209.155] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1regPQ-001h9S-0w;
	Mon, 26 Feb 2024 20:13:04 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/3] lib/test_vmalloc.c: use unsigned long constant
Date: Mon, 26 Feb 2024 20:11:59 +0100
Message-Id: <20240226191159.39509-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226191159.39509-1-martin@kaiser.cx>
References: <20240226191159.39509-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use an unsigned long constant instead of an int constant and a cast. This
fixes the checkpatch warning

WARNING: Unnecessary typecast of c90 int constant - '(unsigned long) 1' could be '1UL'
+     align = ((unsigned long) 1) << i;

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 lib/test_vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index d0c0cbe1913d..4ddf769861ff 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -117,7 +117,7 @@ static int align_shift_alloc_test(void)
 	int i;
 
 	for (i = 0; i < BITS_PER_LONG; i++) {
-		align = ((unsigned long) 1) << i;
+		align = 1UL << i;
 
 		ptr = __vmalloc_node(PAGE_SIZE, align, GFP_KERNEL|__GFP_ZERO, 0,
 				__builtin_return_address(0));
-- 
2.39.2


