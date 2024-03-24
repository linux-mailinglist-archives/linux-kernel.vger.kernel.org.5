Return-Path: <linux-kernel+bounces-112917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 825FE887FBD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D171F2101D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31136EB51;
	Sun, 24 Mar 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feQg+1S9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE06E619;
	Sun, 24 Mar 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319729; cv=none; b=R/3c2TF6wXKgGCxPtCc619Iq+V14u/Do1zsJiP8A9ihVC0whtzT4mB7tevI3225FtWfYhPKzxDPVDou687B6ondSJJSzzGvz9ODMcEmqFXPd5t5IhcQNhWptldKOz7MePcPJqzMS8+06Q6nqMcKcrSo9v/cLLbpjlOANhThjRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319729; c=relaxed/simple;
	bh=//otllxWTZARqxoMNJaZWiaXPi8swLKbFrMrfBueuy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIBOccocdmWbIlgIhBR8bzk8/tbOgfgvGLXCMmwPY+E4CEeldCgpF60Ip3s5AkIku9ZFGYQ+Woqo7GMDbddUr4lu8ChZJpfXESL38Ws2iUp2DnMObqc5NVqIM0INohTuTx68WLb8EKuGP98CsUhIHuhrwLtHuqoVRx6PwGaANDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feQg+1S9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0869AC43390;
	Sun, 24 Mar 2024 22:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319728;
	bh=//otllxWTZARqxoMNJaZWiaXPi8swLKbFrMrfBueuy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=feQg+1S9dNPqbCXbdBZk/RbP+6arGQX+mIcw9qOKCI1jk//96gsj839QwMI1kLDat
	 ELBz6+3NtYNXTmo6ZGpVdL1sKEYoeTdotnO6tTRi+IClgOofPJuMdz0SaTmkrL6cnW
	 2+NGal4MM9Pa6MWoeHqQeozX+PKBX/ho/zCAkathd4PvF7vjCdx82m1IEdazpjAEej
	 yDBm+pm7+F/tzsybZB7p+sOWvgmS4TWfeX9dPPxmzdIzVBBvn1Dk91RwjZbqZnnmAK
	 NM8eFAt0d/1pRjTBGWQu0zXFknknhZm525heftVbTmDsz2WU4yRmxoSv68yL1fwhNi
	 d/eULWOCqQQbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 030/715] lib: memcpy_kunit: Fix an invalid format specifier in an assertion msg
Date: Sun, 24 Mar 2024 18:23:29 -0400
Message-ID: <20240324223455.1342824-31-sashal@kernel.org>
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

From: David Gow <davidgow@google.com>

[ Upstream commit 0a549ed22c3c7cc6da5c5f5918efd019944489a5 ]

The 'i' passed as an assertion message is a size_t, so should use '%zu',
not '%d'.

This was found by annotating the _MSG() variants of KUnit's assertions
to let gcc validate the format strings.

Fixes: bb95ebbe89a7 ("lib: Introduce CONFIG_MEMCPY_KUNIT_TEST")
Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/memcpy_kunit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 440aee705ccca..30e00ef0bf2e0 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -32,7 +32,7 @@ struct some_bytes {
 	BUILD_BUG_ON(sizeof(instance.data) != 32);	\
 	for (size_t i = 0; i < sizeof(instance.data); i++) {	\
 		KUNIT_ASSERT_EQ_MSG(test, instance.data[i], v, \
-			"line %d: '%s' not initialized to 0x%02x @ %d (saw 0x%02x)\n", \
+			"line %d: '%s' not initialized to 0x%02x @ %zu (saw 0x%02x)\n", \
 			__LINE__, #instance, v, i, instance.data[i]);	\
 	}	\
 } while (0)
@@ -41,7 +41,7 @@ struct some_bytes {
 	BUILD_BUG_ON(sizeof(one) != sizeof(two)); \
 	for (size_t i = 0; i < sizeof(one); i++) {	\
 		KUNIT_EXPECT_EQ_MSG(test, one.data[i], two.data[i], \
-			"line %d: %s.data[%d] (0x%02x) != %s.data[%d] (0x%02x)\n", \
+			"line %d: %s.data[%zu] (0x%02x) != %s.data[%zu] (0x%02x)\n", \
 			__LINE__, #one, i, one.data[i], #two, i, two.data[i]); \
 	}	\
 	kunit_info(test, "ok: " TEST_OP "() " name "\n");	\
-- 
2.43.0


