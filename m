Return-Path: <linux-kernel+bounces-124277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD0B891501
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CC81F23152
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD44F482DB;
	Fri, 29 Mar 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6+93622"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB540877;
	Fri, 29 Mar 2024 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699560; cv=none; b=Ld+G2sGZhioGCQqWD9u/tAUhL3gbn5VZGZ2c2B8STP5jd//2v+55tPV7FQoWpneU5xwHM3yxw32UrDII028ffrdJ2O+/tOM4ChHBcHQqV3lFd2gbYHA1IEfh65I/2qzTtdxRkXK/xcWABKCUWQdcU+MtSusDnYdk7sqd8pacLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699560; c=relaxed/simple;
	bh=nQhSiQHqsTqoy4PgCflNVMBA/vpoRwWlQ4PYo1+RE9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lEVcaTFaHvQsa7qfjibAQ1DRmAPX54iFMHBMWpDL2XQhPXDfVjHvDnrva7NDtSBncjMnHmZeG8aMuZN/liQPko4JaATqPVFYCP2H4lm0ViQjLNfNbstZBcu/cHbZpCiiKMwrIU4zA/sAQPfmv8UfL1byxeBK+QlWQr8bLfQ51dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6+93622; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B60CC43394;
	Fri, 29 Mar 2024 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699559;
	bh=nQhSiQHqsTqoy4PgCflNVMBA/vpoRwWlQ4PYo1+RE9I=;
	h=From:To:Cc:Subject:Date:From;
	b=k6+93622EJeqydW4q4ft7UICfTYJKNrjq92x141w1c5CqEEGCgaWnIeGCQyfQUS/h
	 wLz2zcqH/qOybXNT6FF1vl+DviV9s3v3aF2xy6MLx799IWnJD+P88zCgYM7DCrCuBp
	 /OyDjH5a+uCO7mnBEDzU0/ueRM4VwB7yzkrfbnl30ZvIj/mFZguOZglfIZvcx6+gRt
	 SVcLbay9kRyXOhM79ZwU2SQ8W24WmnXLJQmCxLym5x3xw+4z5SGacdCP1IIe44ahmB
	 JrAWOvI2dzDXsGbKbTwkRLcdkI/cXGXs2pewG2d/x0vFnLYlGJFD7+jyR7P1gIwqD8
	 /EjhRFQ0ZQSFg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH v2 0/6] Faster AES-XTS on modern x86_64 CPUs
Date: Fri, 29 Mar 2024 01:03:48 -0700
Message-ID: <20240329080355.2871-1-ebiggers@kernel.org>
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
and provides a boost on older CPUs too.

To try to handle the mess that is x86 SIMD, the code for all the new
AES-XTS implementations is generated from an assembly macro.  This makes
it so that we e.g. don't have to have entirely different source code
just for different vector lengths (xmm, ymm, zmm).

To avoid downclocking effects, zmm registers aren't used on certain
Intel CPU models such as Ice Lake.  These CPU models default to an
implementation using ymm registers instead.

To make testing easier, all four new AES-XTS implementations are
registered separately with the crypto API.  They are prioritized
appropriately so that the best one for the CPU is used by default.

There's no separate kconfig option for the new implementations, as they
are included in the existing option CONFIG_CRYPTO_AES_NI_INTEL.

This patchset increases the throughput of AES-256-XTS by the following
amounts on the following CPUs:

                          | 4096-byte messages | 512-byte messages |
    ----------------------+--------------------+-------------------+
    Intel Skylake         |        6%          |       31%         |
    Intel Cascade Lake    |        4%          |       26%         |
    Intel Ice Lake        |       127%         |      120%         |
    Intel Sapphire Rapids |       151%         |      112%         |
    AMD Zen 1             |        61%         |       73%         |
    AMD Zen 2             |        36%         |       59%         |
    AMD Zen 3             |       138%         |       99%         |
    AMD Zen 4             |       155%         |      117%         |

To summarize how the XTS implementations perform in general, here are
benchmarks of all of them on AMD Zen 4, with 4096-byte messages.  (Of
course, in practice only the best one for the CPU actually gets used.)

    xts-aes-aesni                  4247 MB/s
    xts-aes-aesni-avx              5669 MB/s
    xts-aes-vaes-avx2              9588 MB/s
    xts-aes-vaes-avx10_256         9631 MB/s
    xts-aes-vaes-avx10_512         10868 MB/s

.. and on Intel Sapphire Rapids:

    xts-aes-aesni                  4848 MB/s
    xts-aes-aesni-avx              5287 MB/s
    xts-aes-vaes-avx2              11685 MB/s
    xts-aes-vaes-avx10_256         11938 MB/s
    xts-aes-vaes-avx10_512         12176 MB/s

Notes about benchmarking methods:

- All my benchmarks were done using a custom kernel module that invokes
  the crypto_skcipher API.  Note that benchmarking the crypto API from
  userspace using AF_ALG, e.g. as 'cryptsetup benchmark' does, is bad at
  measuring fast algorithms due to the syscall overhead of AF_ALG.  I
  don't recommend that method.  Instead, I measured the crypto
  performance directly, as that's what this patchset focuses on.

- All numbers I give are for decryption.  However, on all the CPUs I
  tested, encryption performs almost identically to decryption.

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

- Should we perhaps not even bother with AVX512 / AVX10 at all for now,
  given that on current CPUs most of the improvement is achieved by
  going to VAES + AVX2?  I.e. should we skip the last two patches?  I'm
  hoping the improvement will be greater on future CPUs, though.

Changed in v2:
  - Additional optimizations:
      - Interleaved the tweak computation with AES en/decryption.  This
        helps significantly on some CPUs, especially those without VAES.
      - Further optimized for single-page sources and destinations.
      - Used fewer instructions to update tweaks in VPCLMULQDQ case.
      - Improved handling of "round 0".
      - Eliminated a jump instruction from the main loop.
  - Other
      - Fixed zmm_exclusion_list[] to be null-terminated.
      - Added missing #ifdef to unregister_xts_algs().
      - Added some more comments.
      - Improved cover letter and some commit messages.
      - Now that the next tweak is always computed anyways, made it be
        returned unconditionally.
      - Moved the IV encryption to a separate function.

Eric Biggers (6):
  x86: add kconfig symbols for assembler VAES and VPCLMULQDQ support
  crypto: x86/aes-xts - add AES-XTS assembly macro for modern CPUs
  crypto: x86/aes-xts - wire up AESNI + AVX implementation
  crypto: x86/aes-xts - wire up VAES + AVX2 implementation
  crypto: x86/aes-xts - wire up VAES + AVX10/256 implementation
  crypto: x86/aes-xts - wire up VAES + AVX10/512 implementation

 arch/x86/Kconfig.assembler           |  10 +
 arch/x86/crypto/Makefile             |   3 +-
 arch/x86/crypto/aes-xts-avx-x86_64.S | 838 +++++++++++++++++++++++++++
 arch/x86/crypto/aesni-intel_glue.c   | 270 ++++++++-
 4 files changed, 1118 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/crypto/aes-xts-avx-x86_64.S


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.44.0


