Return-Path: <linux-kernel+bounces-118503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401DB88BBE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB06B22EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0257E13440C;
	Tue, 26 Mar 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThzC7bMW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433221332BC;
	Tue, 26 Mar 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440363; cv=none; b=faiSmpPApR8Sor3Tg7PkvWiMpWJ3SZDugQZy5DMRR31CK7xCyi2qh4tx1mHUg9r1JhXoLKcHwK7e0PGKmmrcw7m8m7ne8lS2d3+kC8oavRZItU5HiKx8N97PN3GDRvstk0JuWo2jjTpkXTx8pc+cRuGpJbfGmEh6WkYZvu3BiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440363; c=relaxed/simple;
	bh=gUgld87S6b7a0jKCHf6oa5mjj1DMZIwYnPejvQVpIUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+/cWQMrctMa5UpjkwVvBHFDp+GbRRcLPDB7KVBhnIDTmwM+nxbaB+UbIWl+T1flyA2LC9JxJoi/9+IWkSs+ufg/1XZrKT1L+nG3toioI/z/l8ieFdar1nMQ4cK9fJBWJs8lli8PSDF0TpIsgHLYtnrm+GNQTlWliXVbpOBQIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThzC7bMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA0FC43394;
	Tue, 26 Mar 2024 08:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711440362;
	bh=gUgld87S6b7a0jKCHf6oa5mjj1DMZIwYnPejvQVpIUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ThzC7bMWrWwTwH5Lyw3J0i4Tw7Y3E6TlfgdtHmCECGaZxGBIA4xh6XV4zhvZh/vB5
	 2Fe73bXC/VLUUFcQ8J2FG1YlhvekxnKXqtoQtJzczp+/hoNqQewEWL8Yb+Lg07iTTg
	 7kyUPMOz8+uisZu+4Sr5DdperesocsCcQ9oNJGCuV4rniPb93y0VEUnH+P0I+HpOIf
	 eLTLXIK3yumnQbgRhlqi2rgKmRgNcom8Oq7tbjA+eGUkVzCO/HfV6GG4+dUXRhczS1
	 U4neS0ivz11QtIgenplqVYQJvtP1d6Z50jaOa+hRd6xdE1GsSpJTzIzGZADpRFcTcI
	 VS4S7m4ECNjTg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH 1/6] x86: add kconfig symbols for assembler VAES and VPCLMULQDQ support
Date: Tue, 26 Mar 2024 01:02:59 -0700
Message-ID: <20240326080305.402382-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326080305.402382-1-ebiggers@kernel.org>
References: <20240326080305.402382-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Add config symbols AS_VAES and AS_VPCLMULQDQ that expose whether the
assembler supports the vector AES and carryless multiplication
cryptographic extensions.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/Kconfig.assembler | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index 8ad41da301e5..59aedf32c4ea 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -23,9 +23,19 @@ config AS_TPAUSE
 config AS_GFNI
 	def_bool $(as-instr,vgf2p8mulb %xmm0$(comma)%xmm1$(comma)%xmm2)
 	help
 	  Supported by binutils >= 2.30 and LLVM integrated assembler
 
+config AS_VAES
+	def_bool $(as-instr,vaesenc %ymm0$(comma)%ymm1$(comma)%ymm2)
+	help
+	  Supported by binutils >= 2.30 and LLVM integrated assembler
+
+config AS_VPCLMULQDQ
+	def_bool $(as-instr,vpclmulqdq \$0x10$(comma)%ymm0$(comma)%ymm1$(comma)%ymm2)
+	help
+	  Supported by binutils >= 2.30 and LLVM integrated assembler
+
 config AS_WRUSS
 	def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
 	help
 	  Supported by binutils >= 2.31 and LLVM integrated assembler
-- 
2.44.0


