Return-Path: <linux-kernel+bounces-82217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66F78680A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71767293805
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED710130E4F;
	Mon, 26 Feb 2024 19:13:28 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E612FF8E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974808; cv=none; b=ZWvhc66Gw6/hU4Mv9CJOMwIa60N22bFCh8isLCqUal+5zNZy3wgOoWNkjlkXr/V3Pn44y405AArp/qrnKC7LC+TWpFYS0TuD1+oSofdyyC8qg+CKmRsXngtR2FFkWdIMkDw/2jVHKZoOfh9Q9BEl5eC9vR0scUjwPsI6aYeoxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974808; c=relaxed/simple;
	bh=EB1BnjvStlE/zAy+upOpHVeXAZqFpUO5iqpwHdU1S+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3nnahOEMY0iH53t38WL+3F9XWrtn/sB/pW2Hgi4jT2ETdn7L6Dx2SVYyrLy+QEr7ixqUquNeIZIzl3BYiaah+ruEDymWIjsGkT++FbN5V6UOo19gpKsCJSvephifK30K/+rVOSpqxXH9fkHXJ9ITyfBe3yNoBRldj0kK8Mc+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-188-097-209-155.188.097.pools.vodafone-ip.de ([188.97.209.155] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1regPP-001h9S-0g;
	Mon, 26 Feb 2024 20:13:03 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/3] lib/test_vmalloc.c: drop empty exit function
Date: Mon, 26 Feb 2024 20:11:58 +0100
Message-Id: <20240226191159.39509-3-martin@kaiser.cx>
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

The module is never loaded successfully. Therefore, it'll never be
unloaded and we can remove the exit function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 lib/test_vmalloc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 191b6bd5dff9..d0c0cbe1913d 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -600,12 +600,7 @@ static int vmalloc_test_init(void)
 	return -EAGAIN; /* Fail will directly unload the module */
 }
 
-static void vmalloc_test_exit(void)
-{
-}
-
 module_init(vmalloc_test_init)
-module_exit(vmalloc_test_exit)
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Uladzislau Rezki");
-- 
2.39.2


