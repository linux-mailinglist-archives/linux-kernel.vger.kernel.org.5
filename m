Return-Path: <linux-kernel+bounces-131829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5939898C46
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EBBAB2A7E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300871F947;
	Thu,  4 Apr 2024 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBL6v53J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037C1862F;
	Thu,  4 Apr 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248631; cv=none; b=t1RVzoG0KmYYWb2mJZD+GSIpf93Yi18eLwtYTSiBNBrIyg2NYd1XAqv1HvWyTmLuh6KlXtfJfPsCFtRUP0cYmxrHdomkr+KE0/DSfLGxn/o3nnYuePfNofWwoL8bSbP9poUQ3KLUkqWmb4uIcPO42gLeU9+1H4/4HfVJosBzANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248631; c=relaxed/simple;
	bh=S3DGuEYy5rg3RARDW98L/c2gSalXBmDUZgtrgI3deSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iyzdYgGwEOpe5cvFW/HPYKMZ1d1AIZAEw+axIp9HoEEk1PjP2e5Wby980Ccc16cdgcoxTMSAah3LeozeKZdvzewYdelAmnl8OP4pZyxjVjiq5ew14aeObS6kOY7mAIcX97cx8+8nlmuJd/RxHYBUAuJDQPFzw2YZ5sy8VNazlkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBL6v53J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3502C433F1;
	Thu,  4 Apr 2024 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712248630;
	bh=S3DGuEYy5rg3RARDW98L/c2gSalXBmDUZgtrgI3deSo=;
	h=From:To:Cc:Subject:Date:From;
	b=HBL6v53J/YooQATusMc6w3NQV5riqeQkRaExLnqVTohg8ZW0Xfzf5YgruEA13tNrv
	 wUO2iYUAjsfOdUVfwhT+8nLz7lY/3pYpmWO/cW1Bcnydfdo75seyOmDkeFp5ldpM9I
	 OnKXYyrqoxjrZ92expqAHuLP5glkeLSA9zwVY9UoUggSOyuVHxEHcIj+MUxknBNpOi
	 URxIAmCy9WrnUtlgsLCTc1gZMctLX8mOgmE49Z7j4q0eShWxCYJYMy2+Kp71/IpnJY
	 FOK534QpFKMFTp4664E0xjlNPs5oNgYUwprwwosoQRMRDGxJkZXde5Q5iCWPSYK3ux
	 LeCL077qNZG5g==
From: Arnd Bergmann <arnd@kernel.org>
To: netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Noah Goldstein <goldstein.w.n@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] lib: checksum: hide unused expected_csum_ipv6_magic[]
Date: Thu,  4 Apr 2024 18:36:45 +0200
Message-Id: <20240404163702.241706-1-arnd@kernel.org>
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
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
resending v2 to netdev

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


