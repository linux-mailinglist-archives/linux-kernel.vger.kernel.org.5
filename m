Return-Path: <linux-kernel+bounces-113637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2279888E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6E7B2F087
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27111D790E;
	Sun, 24 Mar 2024 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyT1woi2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1EC13FD76;
	Sun, 24 Mar 2024 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320552; cv=none; b=sqWXWMx3j2ksVzHsW3jw++lDvsfbAuoSnBnjID8lEXjaZP/UdP2xE44tlVGdKkcv+Vx3SwzxVBg1lSKXpnZUGEiGwHn/ZoDhkQpGBGZN7lrmgDCm9+Azayp/tmdoIAPc132mOOfA/SPTse9lsbnbx45jtuzgujOQv0w7Bm9CPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320552; c=relaxed/simple;
	bh=vrxNdixPF1P+PaS8QLrMH1Ze7LzOwQIc98jq+2n817o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhMljgho8FKr71S4f6WtDMOca4agHEqhEEgC96wIa1XiGiAe7KCQvRg9JduNMI1cV06x8Aq59WJE0atOhJA7UiFqR8ArTaYEVuGcKtLsbrqa0uEp2HMPcqMIcfXgR1invpid8yArkuTaIzQid5lB2lgHHZs532orODHCDm+x8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyT1woi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0987C433C7;
	Sun, 24 Mar 2024 22:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320550;
	bh=vrxNdixPF1P+PaS8QLrMH1Ze7LzOwQIc98jq+2n817o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyT1woi2aPRuk7TeiWcgHTMDul46XctPBf1R9wtL4hDD8bwJEjgFRfXuzA9arbzw6
	 09BBiLsS1nW81MotxFzSPxncJljQBAhh3beJ8V/3FVY+9a+hnFlhtEGJnCru6oeCbR
	 OpQYMDKXp9Dhy2ngwbFy1gIs9IMu0yyQo72Gr5SpwNvJQ9YhsbjzgJD5a+QaYtgtEL
	 5CAAWl32NEhlMVIBNYOlzyyXtwY2reEL8Ej4kgJR5h7pNwUmmZrtg+ST1RxJ8mrgii
	 0N46PMJ6zHmpYS1OU7qOvexB2nAEhcsDGKy0ApvqVbUou3gAjEK8Wm4P4Gy3oswE21
	 RRA1qZgiJqjow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 111/713] net: test: Fix printf format specifier in skb_segment kunit test
Date: Sun, 24 Mar 2024 18:37:17 -0400
Message-ID: <20240324224720.1345309-112-sashal@kernel.org>
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

[ Upstream commit ff3b96f2c9e5c24fca12239cd519a8a18569e687 ]

KUNIT_FAIL() accepts a printf-style format string, but previously did
not let gcc validate it with the __printf() attribute. The use of %lld
for the result of PTR_ERR() is not correct.

Instead, use %pe and pass the actual error pointer. printk() will format
it correctly (and give a symbolic name rather than a number if
available, which should make the output more readable, too).

Fixes: b3098d32ed6e ("net: add skb_segment kunit test")
Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/gso_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/gso_test.c b/net/core/gso_test.c
index 4c2e77bd12f4b..358c44680d917 100644
--- a/net/core/gso_test.c
+++ b/net/core/gso_test.c
@@ -225,7 +225,7 @@ static void gso_test_func(struct kunit *test)
 
 	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
-		KUNIT_FAIL(test, "segs error %lld", PTR_ERR(segs));
+		KUNIT_FAIL(test, "segs error %pe", segs);
 		goto free_gso_skb;
 	} else if (!segs) {
 		KUNIT_FAIL(test, "no segments");
-- 
2.43.0


