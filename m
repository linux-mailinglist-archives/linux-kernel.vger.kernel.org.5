Return-Path: <linux-kernel+bounces-61404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40658511F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B082B284E18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0703E383BF;
	Mon, 12 Feb 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uat5jhPa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB32556F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736576; cv=none; b=p0Apve79Gf8mB1aCW17SXhark6KLLzPyxn4aeVjVqm488oqczcVWGVIdH3kjYxokGpJSzd2WZ0ljpPGRqbQiMNF2AvF2Pqd/j/WPng7RtpPe9ffe9zVzzUaaEKTJq3lSPSoV7mxEex5f+A9ZvrxALQ1tXvT4gLT7f2G+DmnALDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736576; c=relaxed/simple;
	bh=JUd8RDIFqXlGYjM49KPBEs03On+rhHeulIrFh10Rab4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h7dNovvZrxKrkY4LfLMiC6m0/GPPRhcz52aNGWiHREA8Lp4DwXih5ahAliP97MKopgsW0LTQZSbO8KXM2Y2nzoleZmQTHunSUqXkikDedB0fOr90PhrRgbJZRfVf3hkoBRcr3X5w17J1cRmvX3yEhgxLCLqs4RR+pp32eTVzZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uat5jhPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9ADC433C7;
	Mon, 12 Feb 2024 11:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707736575;
	bh=JUd8RDIFqXlGYjM49KPBEs03On+rhHeulIrFh10Rab4=;
	h=From:To:Cc:Subject:Date:From;
	b=Uat5jhPaeUUrwYrIKBEryRRlqkfa88iUDMr1PYuLdACxfXQO34FSlFzP6SGV6PrcZ
	 7a/AFWdH+Ju2C+eaaCmn0hr+PZJEuhvMLKROYfBm9XNRwiSaamy3ipGQIvYLsKJq9h
	 0p0x7RVrs0oSUxsFjhLK2w1QJpnxXtuAIJ2v2ohf5bsPZEjm3JGf74tKmM2hYw2nWK
	 dqSfxfqxt4ib7Bfaq20e1Wq109Yulw3EiCvIVmu0DlO8dsclSnIaj2Ow4YZp8bD1mj
	 MZnFPGGhFcESTW92kZHzVutBN7H1xc+hRozLgyh+1SopSAHK2Fj6KHpSUDeLTtCpQg
	 4rwbDbFGf3L6g==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <adech.fo@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kasan/test: avoid gcc warning for intentional overflow
Date: Mon, 12 Feb 2024 12:15:52 +0100
Message-Id: <20240212111609.869266-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The out-of-bounds test allocates an object that is three bytes too
short in order to validate the bounds checking. Starting with gcc-14,
this causes a compile-time warning as gcc has grown smart enough to
understand the sizeof() logic:

mm/kasan/kasan_test.c: In function 'kmalloc_oob_16':
mm/kasan/kasan_test.c:443:14: error: allocation of insufficient size '13' for type 'struct <anonymous>' with size '16' [-Werror=alloc-size]
  443 |         ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
      |              ^

Hide the actual computation behind a RELOC_HIDE() that ensures
the compiler misses the intentional bug.

Fixes: 3f15801cdc23 ("lib: add kasan test module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/kasan/kasan_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 318d9cec111a..2d8ae4fbe63b 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -440,7 +440,8 @@ static void kmalloc_oob_16(struct kunit *test)
 	/* This test is specifically crafted for the generic mode. */
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
 
-	ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
+	/* RELOC_HIDE to prevent gcc from warning about short alloc */
+	ptr1 = RELOC_HIDE(kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL), 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
 
 	ptr2 = kmalloc(sizeof(*ptr2), GFP_KERNEL);
-- 
2.39.2


