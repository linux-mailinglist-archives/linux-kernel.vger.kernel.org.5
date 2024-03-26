Return-Path: <linux-kernel+bounces-118502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9264788BBE2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D821F3A81F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7401339A6;
	Tue, 26 Mar 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeWbToD1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F302118C38;
	Tue, 26 Mar 2024 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440363; cv=none; b=TK5cAhDkreJG3Dg0vnYfALbxlS3FnQvGNvV+Jvd28XIA2flrmLe/Ez3brsfG+LABlA73JGVypSYMkezXn7t5A7xMfLRMWOxYufI64gV0PDzG6pDdZ/BiZxcbl6fpjARt3bkNyn1O+HLZ9jjCrB5CJxWRcaWhpWSPth612hXUcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440363; c=relaxed/simple;
	bh=E06+Y98eVhxip/iGCDTYLOwvEzjwrLzY+VAqA9LlH8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNq1Ke41rbzEWtjRGuSuUQnWKsdldnIrCEnKSJMD8yY2W3TN3Ki6ss16A/h3Ima8dQJ96/dbn8kVji7i0Q4eZkILMHdzMhD6k4r4zL3JGX/ML7+dXSaC39QKtRQFXILjIrNyn5eryan2vrTqj80tfadZWaE8tuUcUHZu4Ro8Umo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeWbToD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DBBC433C7;
	Tue, 26 Mar 2024 08:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711440362;
	bh=E06+Y98eVhxip/iGCDTYLOwvEzjwrLzY+VAqA9LlH8I=;
	h=From:To:Cc:Subject:Date:From;
	b=ZeWbToD1r6qK21HcGhAHETqjWPj3WIDVsb9pW+KvU97Lf2XDR9xkZzE5h9lvlc2vK
	 0bQnVuQEXwbHEiJOy8ZgCwEdD0iRPWZMBljqPwBS4CcT03FoVE+W4L5D/ia1IXUeIL
	 ZEKe2x15HVLiK3uy7K7laTN3Y/tQB4yR7wKGRt0R9+rDmYn/S40qROIBulSJD2CiMj
	 LFz+JnFpJ5HHlWBR5MA5Zy1aBEZOCFAngKpj1tO2zW1FcNDCHpBjjgeCzngoTZCz83
	 U7Jq9BQD4pRyjYpphoQjxFKbc2ZYN9bH+ryPvmueQsT6laW43e19d89CE4UFQtL8s9
	 2kqzYqFVCQT2w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
Date: Tue, 26 Mar 2024 01:02:58 -0700
Message-ID: <20240326080305.402382-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds new AES-XTS implementations that accelerate disk and
file encryption on modern x86_64 CPUs.

The largest improvements are seen on CPUs that support the VAES
extension: Intel Ice Lake (2019) and later, and AMD Zen 3 (2020) and
later.  However, an implementation using plain AESNI + AVX is also added
and provides a small boost on older CPUs too.

To try to handle the mess that is x86 SIMD, the code for all the new
AES-XTS implementations is generated from an assembly macro.  This makes
it so that we e.g. don't have to have entirely different source code
just for different vector lengths (xmm, ymm, zmm).

To avoid downclocking effects, zmm registers aren't used on certain
Intel CPU models such as Ice Lake.  These CPU models default to an
implementation using ymm registers instead.

This patchset increases the throughput of AES-256-XTS decryption by the
following amounts on the following CPUs:
                            
                          | 4096-byte messages | 512-byte messages |
    ----------------------+--------------------+-------------------+
    Intel Skylake         |        1%          |       11%         |
    Intel Ice Lake        |        92%         |       59%         |
    Intel Sapphire Rapids |       115%         |       78%         |
    AMD Zen 1             |        25%         |       20%         |
    AMD Zen 2             |        26%         |       20%         |
    AMD Zen 3             |        82%         |       40%         |
    AMD Zen 4             |       118%         |       48%         |

(The results for encryption are very similar to decryption.  I just tend
to measure decryption because decryption performance is more important.)

There's no separate kconfig option for the new AES-XTS implementations,
as they are included in the existing option CONFIG_CRYPTO_AES_NI_INTEL.

To make testing easier, all four new AES-XTS implementations are
registered separately with the crypto API.  They are prioritized
appropriately so that the best one for the CPU is used by default.

Open questions:

- Is the policy that I implemented for preferring ymm registers to zmm
  registers the right one?  arch/x86/crypto/poly1305_glue.c thinks that
  only Skylake has the bad downclocking.  My current proposal is a bit
  more conservative; it also excludes Ice Lake and Tiger Lake.  Those
  CPUs supposedly still have some downclocking, though not as much.

- Should the policy on the use of zmm registers be in a centralized
  place?  It probably doesn't make sense to have random different
  policies for different crypto algorithms (AES, Poly1305, ARIA, etc.).

- Are there any other known issues with using AVX512 in kernel mode?  It
  seems to work, and technically it's not new because Poly1305 and ARIA
  already use AVX512, including the mask registers and zmm registers up
  to 31.  So if there was a major issue, like the new registers not
  being properly saved and restored, it probably would have already been
  found.  But AES-XTS support would introduce a wider use of it.

Eric Biggers (6):
  x86: add kconfig symbols for assembler VAES and VPCLMULQDQ support
  crypto: x86/aes-xts - add AES-XTS assembly macro for modern CPUs
  crypto: x86/aes-xts - wire up AESNI + AVX implementation
  crypto: x86/aes-xts - wire up VAES + AVX2 implementation
  crypto: x86/aes-xts - wire up VAES + AVX10/256 implementation
  crypto: x86/aes-xts - wire up VAES + AVX10/512 implementation

 arch/x86/Kconfig.assembler           |  10 +
 arch/x86/crypto/Makefile             |   3 +-
 arch/x86/crypto/aes-xts-avx-x86_64.S | 796 +++++++++++++++++++++++++++
 arch/x86/crypto/aesni-intel_glue.c   | 263 ++++++++-
 4 files changed, 1070 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/crypto/aes-xts-avx-x86_64.S


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.44.0


