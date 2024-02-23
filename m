Return-Path: <linux-kernel+bounces-78171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCDE860FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDD01F22049
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB81E7B3F2;
	Fri, 23 Feb 2024 10:42:14 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54759651BA;
	Fri, 23 Feb 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684934; cv=none; b=Rvurd5wEhbO5Jc2bGvmpj4+RrGJxpXpDwcJS/vlUuqV7txfcdxwk5CTOIXXURMoF2Mk7u+R2UG4XRNMrJosEb/qQMmFL4KDBTtryQ5vODpIMO3altnlEPICHlNxXsX6pEKtH6qbS+GvC0uzerOAic/kP4krHd7GMfCwBE606uxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684934; c=relaxed/simple;
	bh=fB8+WnHBg1QU6ROizNqpYL5D/JABQshnFumNFCmdoLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hV2ZUsiC4keVX1B/KerGIR/WlGBz7AzzE9rrNlB+8DcF+oM1IY5CQKFHEVjZ47W1a37qaeUMY2Cd7eJ7YPz4PJaX2r9wMwsAeBwg5Vb6BaHjiChY0OTrcDX69TyhqHWkBD4yi0KSGmGSVnWAJC4bj30GTlWoHjpAT5TtVdUUS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Th65S67W4z9v7S;
	Fri, 23 Feb 2024 11:42:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pg9xp3HD-DPv; Fri, 23 Feb 2024 11:42:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Th65S5Tqlz9v7D;
	Fri, 23 Feb 2024 11:42:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B80078B76D;
	Fri, 23 Feb 2024 11:42:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 550-njgW4UnI; Fri, 23 Feb 2024 11:42:04 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.164])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B6738B764;
	Fri, 23 Feb 2024 11:42:04 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Erhard Furtner <erhard_f@mailbox.org>
Subject: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
Date: Fri, 23 Feb 2024 11:41:52 +0100
Message-ID: <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708684913; l=3489; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=fB8+WnHBg1QU6ROizNqpYL5D/JABQshnFumNFCmdoLs=; b=ewHGEcAM+BfGESz93+V5yJAp5oGhVF467F6K+RwKVnjk7Xp9QSmGFg3z3chzIUStrejUTBxWW EExYoIQDauoB8p1An/w4l0svR+I18EkV9P9dSrR7995G9aqluKy7sso
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit b38460bc463c ("kunit: Fix checksum tests on big endian CPUs")
fixed endianness issues with kunit checksum tests, but then
commit 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and
ip_fast_csum") introduced new issues on big endian CPUs. Those issues
are once again reflected by the warnings reported by sparse.

So, fix them with the same approach, perform proper conversion in
order to support both little and big endian CPUs. Once the conversions
are properly done and the right types used, the sparse warnings are
cleared as well.

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/checksum_kunit.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index 225bb7701460..bf70850035c7 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -215,7 +215,7 @@ static const u32 init_sums_no_overflow[] = {
 	0xffff0000, 0xfffffffb,
 };
 
-static const __sum16 expected_csum_ipv6_magic[] = {
+static const u16 expected_csum_ipv6_magic[] = {
 	0x18d4, 0x3085, 0x2e4b, 0xd9f4, 0xbdc8, 0x78f,	0x1034, 0x8422, 0x6fc0,
 	0xd2f6, 0xbeb5, 0x9d3,	0x7e2a, 0x312e, 0x778e, 0xc1bb, 0x7cf2, 0x9d1e,
 	0xca21, 0xf3ff, 0x7569, 0xb02e, 0xca86, 0x7e76, 0x4539, 0x45e3, 0xf28d,
@@ -241,7 +241,7 @@ static const __sum16 expected_csum_ipv6_magic[] = {
 	0x3845, 0x1014
 };
 
-static const __sum16 expected_fast_csum[] = {
+static const u16 expected_fast_csum[] = {
 	0xda83, 0x45da, 0x4f46, 0x4e4f, 0x34e,	0xe902, 0xa5e9, 0x87a5, 0x7187,
 	0x5671, 0xf556, 0x6df5, 0x816d, 0x8f81, 0xbb8f, 0xfbba, 0x5afb, 0xbe5a,
 	0xedbe, 0xabee, 0x6aac, 0xe6b,	0xea0d, 0x67ea, 0x7e68, 0x8a7e, 0x6f8a,
@@ -577,7 +577,8 @@ static void test_csum_no_carry_inputs(struct kunit *test)
 
 static void test_ip_fast_csum(struct kunit *test)
 {
-	__sum16 csum_result, expected;
+	__sum16 csum_result;
+	u16 expected;
 
 	for (int len = IPv4_MIN_WORDS; len < IPv4_MAX_WORDS; len++) {
 		for (int index = 0; index < NUM_IP_FAST_CSUM_TESTS; index++) {
@@ -586,7 +587,7 @@ static void test_ip_fast_csum(struct kunit *test)
 				expected_fast_csum[(len - IPv4_MIN_WORDS) *
 						   NUM_IP_FAST_CSUM_TESTS +
 						   index];
-			CHECK_EQ(expected, csum_result);
+			CHECK_EQ(to_sum16(expected), csum_result);
 		}
 	}
 }
@@ -598,7 +599,7 @@ static void test_csum_ipv6_magic(struct kunit *test)
 	const struct in6_addr *daddr;
 	unsigned int len;
 	unsigned char proto;
-	unsigned int csum;
+	__wsum csum;
 
 	const int daddr_offset = sizeof(struct in6_addr);
 	const int len_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr);
@@ -611,10 +612,10 @@ static void test_csum_ipv6_magic(struct kunit *test)
 		saddr = (const struct in6_addr *)(random_buf + i);
 		daddr = (const struct in6_addr *)(random_buf + i +
 						  daddr_offset);
-		len = *(unsigned int *)(random_buf + i + len_offset);
+		len = le32_to_cpu(*(__le32 *)(random_buf + i + len_offset));
 		proto = *(random_buf + i + proto_offset);
-		csum = *(unsigned int *)(random_buf + i + csum_offset);
-		CHECK_EQ(expected_csum_ipv6_magic[i],
+		csum = *(__wsum *)(random_buf + i + csum_offset);
+		CHECK_EQ(to_sum16(expected_csum_ipv6_magic[i]),
 			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
 	}
 #endif /* !CONFIG_NET */
-- 
2.43.0


