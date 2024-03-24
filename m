Return-Path: <linux-kernel+bounces-115811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BABD8898C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F03EB3F0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C561D37470E;
	Mon, 25 Mar 2024 03:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deb9pJ1b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF4145B06;
	Sun, 24 Mar 2024 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321998; cv=none; b=LovQtAl38V0xC9FzJ68ENpeVCqU+WZmAL9JkVKTDbnTrj6f+P7Kb2mufvTW5IzHJItsnOs/pLS4xzPbco+Yc7bzCeQR/mz5mtNeb5coK9hpkt43B8TZWvPO2vdMlwcjaNhSkeLHQ/LwaB24mDoKq8Ex42KkYx6SgFP5InUAlGP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321998; c=relaxed/simple;
	bh=aRaLv0aWTnLotsxN5UN9UBm7Px06ZsdF21YYz4MEXPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRcRscCIAnD5DTylEAn+0eeo07a0ACy43XFCJfEBlUj1/OL2cTLIXXLmxYuqclmu144JL82tIZk11wXsa4FAPb+hR30rVcEwEjNYwDdzkCCOPVVni/K8wuADG7Z2byti1FtSuvGPU39KMtBkLxjfMQ/QfJbRa4knQlchfjbCjgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deb9pJ1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46C9C433F1;
	Sun, 24 Mar 2024 23:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321997;
	bh=aRaLv0aWTnLotsxN5UN9UBm7Px06ZsdF21YYz4MEXPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deb9pJ1bxjwbAuVo3MJgaXIo3V45jKv0H+PHPrd4l+v0FwW1rEgP+6flG9hJmD1kq
	 yfuXTOxy8ES7FtdSJ3bOUpUx71k3OLRdPWh1/Se4uG3XZOruRRiqYycRv02xDBQAuo
	 huvLTKnkWWZqR2ReXgLum7tMWiaMYSYHZlsElzueFq05RFQL5zpPtns+pz0T73h+3x
	 km/r0VS7dESDN8RdR/DPnp/mHvQ4moEsUmEQPFdM8gbaMQsXDez5Ibhln971RlfDVU
	 /NQJM3G4d79C6KANIlSVdvltlejZ81x/561h7YOkpk163QsoUmSF2WwIyAPNvU3Pg4
	 E+Do4LSOA/fQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 069/451] lib: memcpy_kunit: Fix an invalid format specifier in an assertion msg
Date: Sun, 24 Mar 2024 19:05:45 -0400
Message-ID: <20240324231207.1351418-70-sashal@kernel.org>
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
index 2b5cc70ac53fc..dbedd99aa6163 100644
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


