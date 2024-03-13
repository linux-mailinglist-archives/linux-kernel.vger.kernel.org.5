Return-Path: <linux-kernel+bounces-101579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A924087A8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A64B1F24E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615F74502C;
	Wed, 13 Mar 2024 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHQ8NwTz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3095744369
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338536; cv=none; b=HrNYrScMlPe+dENCCbTqT+3hgGIAp6ZOnLkpcOxas1rFABqr6F6wABFAd4fAqrHQ9EBcfTZ7nf5+gNPv+oZqUpMitV4miMEDpImc7kuIV53DuDWJUx1Zy8hEfP+uNUFS845N4RMT1liLrtLBMH8Ocsk496Abu0erI+pDWHhlnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338536; c=relaxed/simple;
	bh=SCZx7ld+0pZNGXKFkqD5Wl1gMgA6owvxSFCp49mEDiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sseYRpm6HQTAsnSdlmxkt7/NRYTNfjHrbAsgyL6qkI1ISif3h5lnwUlZyMEsRFErN6ax3rGzA+mRvD5VE97zysSIO/tCl6TGMbonCZv9FWZkabTsm0B0gvRrYny7cjUybfbj3J9KhQJFRceg/9WG7z70zyHKFb3gr/XPMuRPwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHQ8NwTz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710338534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q8MmG9ZfffEOvAQ5aBIJd7vUV/m+wEaVtyn6f6e6lQI=;
	b=cHQ8NwTzMkhi+iRo3tcdGELjXroCkXZp71yjHzZ+pAyShX0ldrsjBC8C29Be1zsMwX4Qcz
	80WCXsALzCeM1v1myxKqA2zb1BD8FP6vTkvBLA05vFCXGfdV4bj2Up8HE2z5VDlFQHM8pV
	lCcN2bQm7ghKUnarpsOUiaa2UXU0Tyo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-8A2WoyWRP4SgzGcEfk9i9Q-1; Wed, 13 Mar 2024 10:02:10 -0400
X-MC-Unique: 8A2WoyWRP4SgzGcEfk9i9Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0F928F4768;
	Wed, 13 Mar 2024 14:02:09 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.45.224.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DA48C492BC7;
	Wed, 13 Mar 2024 14:02:07 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Xi Wang <xi.wang@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: [PATCH bpf-next] arm64: bpf: zero upper bits after rev32
Date: Wed, 13 Mar 2024 15:02:05 +0100
Message-ID: <20240313140205.3191564-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Commit d63903bbc30c7 ("arm64: bpf: fix endianness conversion bugs")
added upper bits zeroing to byteswap operations, but it assumes they
will be already zeroed after rev32, which is not the case on some
systems at least:

[ 9757.262607] test_bpf: #312 BSWAP 16: 0x0123456789abcdef -> 0xefcd jited:1 8 PASS
[ 9757.264435] test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 ret 1460850314 != -271733879 (0x5712ce8a != 0xefcdab89)FAIL (1 times)
[ 9757.266260] test_bpf: #314 BSWAP 64: 0x0123456789abcdef -> 0x67452301 jited:1 8 PASS
[ 9757.268000] test_bpf: #315 BSWAP 64: 0x0123456789abcdef >> 32 -> 0xefcdab89 jited:1 8 PASS
[ 9757.269686] test_bpf: #316 BSWAP 16: 0xfedcba9876543210 -> 0x1032 jited:1 8 PASS
[ 9757.271380] test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 ret -1460850316 != 271733878 (0xa8ed3174 != 0x10325476)FAIL (1 times)
[ 9757.273022] test_bpf: #318 BSWAP 64: 0xfedcba9876543210 -> 0x98badcfe jited:1 7 PASS
[ 9757.274721] test_bpf: #319 BSWAP 64: 0xfedcba9876543210 >> 32 -> 0x10325476 jited:1 9 PASS

Fixes: d63903bbc30c7 ("arm64: bpf: fix endianness conversion bugs")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 arch/arm64/net/bpf_jit_comp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c5b461dda4385..e86e5ba74dca2 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -944,7 +944,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			break;
 		case 32:
 			emit(A64_REV32(is64, dst, dst), ctx);
-			/* upper 32 bits already cleared */
+			/* zero-extend 32 bits into 64 bits */
+			emit(A64_UXTW(is64, dst, dst), ctx);
 			break;
 		case 64:
 			emit(A64_REV64(dst, dst), ctx);
-- 
2.44.0


