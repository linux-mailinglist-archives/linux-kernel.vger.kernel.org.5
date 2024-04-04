Return-Path: <linux-kernel+bounces-131324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B709A89864E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70EB12879A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43D684D3B;
	Thu,  4 Apr 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox5FpK1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113184D10
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231108; cv=none; b=h1/nD4gYpmwYa64tUOWwIV72NNpan/HZcnETE+PMSt2AqxR0F3AbER7w3aaAKQxtzVv1txu7RkkYM8ax/FuRF3Q8M/vWQrr+ojmDGvihb0mN/aPFRying62osINcmubknXPceNFWkKnUGYPkPNOL5/CQZ2VWnhQjZFB5wHwutSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231108; c=relaxed/simple;
	bh=gv1Ocmcd5hUfsp3yAkdFPtRtCSZP9+xU7yTapbaEZQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ep0isesOP7EwXsBtYfSP5Q0FZ2s7gOXlbBJgoj+mO8gnH3gwW5tBobJyNG5zJVViEWwRjU3hJs5sIbc2rmJoPBiJ3hQJDHUmBlUwKR2LygNGUDp3tDIvzMVacelqMm88kz5oYj5QlnSi5yrlqcThslesSnc3YlHd79n1FKKmne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox5FpK1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F5EC433C7;
	Thu,  4 Apr 2024 11:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712231107;
	bh=gv1Ocmcd5hUfsp3yAkdFPtRtCSZP9+xU7yTapbaEZQs=;
	h=From:To:Cc:Subject:Date:From;
	b=Ox5FpK1A1fizasks/Iq6eFp655qD7PNJoT+wg1+aYw9yGUDpYJ200snt5IdeU1/8h
	 Fnp1aj9cD/WRXU7wCIJRVccTBJLiEK8ilU198qQuzOZkKUIgrgUDD5001Ih5/aM4un
	 UEly6LwRgSfOA3mrlAWC/y0PZBiUEHq9Z65PmWDf5rc0ksZQsJ6BZTtl4jQwE+MQUC
	 VN3/7ApTYYBMc0lbfDadwzx5o0HjqSMAxU5FHg+4q5BeRfxLI7k//4CrYZekoPrKnI
	 /Jw51s8Fc5oVIGGIYc3YEVZPxipvhWlGjkWbIoLX90VKci9cFvIDsHlg/0pzit/Woq
	 x+OJBVNXe+oBg==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Palmer Dabbelt <palmer@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Noah Goldstein <goldstein.w.n@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] lib: checksum: hide unused expected_csum_ipv6_magic[]
Date: Thu,  4 Apr 2024 13:44:33 +0200
Message-Id: <20240404114450.449683-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_NET is disabled, an extra warning shows up for this
unused variable:

lib/checksum_kunit.c:218:18: error: 'expected_csum_ipv6_magic' defined but not used [-Werror=unused-const-variable=]

Replace the #ifdef with an IS_ENABLED() check that makes the compiler's
dead-code-elimination take care of the link failure.

Fixes: f24a70106dc1 ("lib: checksum: Fix build with CONFIG_NET=n")
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/checksum_kunit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index bf70850035c7..404dba36bae3 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -594,13 +594,15 @@ static void test_ip_fast_csum(struct kunit *test)
 
 static void test_csum_ipv6_magic(struct kunit *test)
 {
-#if defined(CONFIG_NET)
 	const struct in6_addr *saddr;
 	const struct in6_addr *daddr;
 	unsigned int len;
 	unsigned char proto;
 	__wsum csum;
 
+	if (!IS_ENABLED(CONFIG_NET))
+		return;
+
 	const int daddr_offset = sizeof(struct in6_addr);
 	const int len_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr);
 	const int proto_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr) +
@@ -618,7 +620,6 @@ static void test_csum_ipv6_magic(struct kunit *test)
 		CHECK_EQ(to_sum16(expected_csum_ipv6_magic[i]),
 			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
 	}
-#endif /* !CONFIG_NET */
 }
 
 static struct kunit_case __refdata checksum_test_cases[] = {
-- 
2.39.2


