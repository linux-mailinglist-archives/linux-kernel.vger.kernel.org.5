Return-Path: <linux-kernel+bounces-115346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48283889AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C0A1C33A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EE11E88F4;
	Mon, 25 Mar 2024 02:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGIUOnfm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540A80612;
	Sun, 24 Mar 2024 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320547; cv=none; b=ouj5wKG91iePJdukynrN42OPwuWxbdHRlfD2+ItCJXoJXqt0oNiqMYJxFdLLsnUhaEsoIoNzNJSPD/M0gnjgC9/CFMV3mcahQ69+TF6NuNPx4vmpJ2kDk+tx/ld49iE86yLYdpVz16oL4SVi/kw7PRYgXsMzdOiJX/sM/uaDCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320547; c=relaxed/simple;
	bh=//otllxWTZARqxoMNJaZWiaXPi8swLKbFrMrfBueuy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHIBCPrPVNrdnXHDiCPECouP0ojwU/QUPA3H4GytM8mjB734krPMdTXPkM1jOX7gaw8ph6wqrXQmC7txnmzIh2iTwLx8FcOzbvohXsjFQCSadcGAxUKK3qrb5xM7HXHQe1dMytqNPIta/HhnKp8imfIDSwcMkf9xunvl0ffr8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGIUOnfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A4DC433F1;
	Sun, 24 Mar 2024 22:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320547;
	bh=//otllxWTZARqxoMNJaZWiaXPi8swLKbFrMrfBueuy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGIUOnfmCIreTtQW5eMttoK7GtJJtmZ+7W7kTCVPCwTv/HRe5wiI5CNs4MxrDOlhm
	 mn7c91LQq2U4jqllR35ADCYZFWp5xUDBtRmAGpR0jhUA1S6yJOf8kxjSLDS4e/7L/P
	 nKY2FtjGROavrBmKHJvFKe7tQ3UNrgHkxLMVFj7SoU/jAqodod95HWkuYxCxm5ZeqT
	 ZT5eunTm5N4wz4zMTs/dzBAWObkKCD1xVCMhv8yF9mLsmlg/Yu9cGT0tmH8HPxrBYa
	 pY846/RO+SfVpfopT2mbKa2U7tmj1Zky0pP/I4uaP30+4z2KwwH/zU2Sp77A/B1zdH
	 zyEVqpsHJZCjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 108/713] lib: memcpy_kunit: Fix an invalid format specifier in an assertion msg
Date: Sun, 24 Mar 2024 18:37:14 -0400
Message-ID: <20240324224720.1345309-109-sashal@kernel.org>
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


