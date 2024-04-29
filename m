Return-Path: <linux-kernel+bounces-162330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FED48B5976
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE921F226ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6986FE0D;
	Mon, 29 Apr 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qNsnniR9"
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881F481C7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396189; cv=none; b=TmAsZSfFsWlHEgkhqfLammbM2lsQwihNKdGkjMTxcjNw8eRJ7mcmYA98PUxZ3+9nuLk9ilpDQJJ8sIE4nvTrRLsSOI5/P7XySBzqMe0untjVL+bQFs966M5ytQYkYeXPEXCHOOaWjGl/QPgdhrEIRok0Db34sbCDUrpNYSqNEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396189; c=relaxed/simple;
	bh=G/CFiEQPBLvZ7poYbqwJYJrPoOi67Om8bQiF65fhYdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWImuc1gOabYG631rKuccYEU3Rj4K4+zCVacT7skLnxNuq9cE4FSzzdUEVPfJMzu+fWxQc+/FX4ra1AUUfQ4puMeMLlBh+aTcIkXbaNt3GExch0jGzVqoEsfA2kQ7g8vVRe4Q52JHx4gOBRVXNfDHPpviWX0H3OkNeOiJWMpO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qNsnniR9; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VSkFN68rjzGFv;
	Mon, 29 Apr 2024 15:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714396184;
	bh=G/CFiEQPBLvZ7poYbqwJYJrPoOi67Om8bQiF65fhYdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNsnniR953gMqqy/QjZcRxJ/zpeDoqtVqnrBv5GqYHGegNMoR/VMywB9jq5ieOAKc
	 KcD2cPMTIEI/gqQvK3fzZkJ41ORVIm9ljAUsKK6uWVOCffESElznBFqHWtwsJW+Qdr
	 bBbKRkPepYGoc74WNu20lrvDi8ZK5R7Sd/v9yDpI=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VSkFN1zrkzdKB;
	Mon, 29 Apr 2024 15:09:44 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 6/9] selftests/harness: Constify fixture variants
Date: Mon, 29 Apr 2024 15:09:28 +0200
Message-ID: <20240429130931.2394118-7-mic@digikod.net>
In-Reply-To: <20240429130931.2394118-1-mic@digikod.net>
References: <20240429130931.2394118-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

FIXTURE_VARIANT_ADD() types are passed as const pointers to
FIXTURE_TEARDOWN().  Make that explicit by constifying the variants
declarations.

Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Will Drewry <wad@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240429130931.2394118-7-mic@digikod.net
---

Changes since v1:
* Extract change from a bigger patch (suggested by Kees).
---
 tools/testing/selftests/kselftest_harness.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 9f04638707ae..8a7d899a75e0 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -338,7 +338,7 @@ static pid_t __attribute__((__unused__)) clone3_vfork(void)
  * variant.
  */
 #define FIXTURE_VARIANT_ADD(fixture_name, variant_name) \
-	extern FIXTURE_VARIANT(fixture_name) \
+	extern const FIXTURE_VARIANT(fixture_name) \
 		_##fixture_name##_##variant_name##_variant; \
 	static struct __fixture_variant_metadata \
 		_##fixture_name##_##variant_name##_object = \
@@ -350,7 +350,7 @@ static pid_t __attribute__((__unused__)) clone3_vfork(void)
 		__register_fixture_variant(&_##fixture_name##_fixture_object, \
 			&_##fixture_name##_##variant_name##_object);	\
 	} \
-	FIXTURE_VARIANT(fixture_name) \
+	const FIXTURE_VARIANT(fixture_name) \
 		_##fixture_name##_##variant_name##_variant =
 
 /**
-- 
2.44.0


