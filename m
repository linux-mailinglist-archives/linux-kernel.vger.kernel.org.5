Return-Path: <linux-kernel+bounces-32232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A38708358EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A836B217F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4B136E;
	Mon, 22 Jan 2024 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSiMXi3d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23838360;
	Mon, 22 Jan 2024 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705882978; cv=none; b=MSEfEj7eESJZ5DCcE6G4rMKSHwVia6PNwX7he075oSesnrX5Zf5aNIEZPsp++7RUYJ1thlBgR138h2Iv6Mbu/oq9rJEKHpVLiZ+AG8RPkDL6X3rgIbGUaJSvGH6Cc3fSsc8Q/8Yge/2+KnsyCdHKcEyWpcF79EaHFicDJLTSRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705882978; c=relaxed/simple;
	bh=/98FyMHfNpcE20uREuwvTI8aEaiGp4Wx3e7AXQcREB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ucWKTQL00fDxj8wVJ1AT6fjJA0ZntKeFByLOqr8kqi92ZdRKkr7vuvAdBB4yNPl6YAIzhZzjzTRxLBThnFXBEl/DVBe8gJVCyWPxfVKm/DiUqrPZqJE2QOIW+5y/XlYA9khuqWOYyQhvoiiAZEs+jt1elDl+m6jCKXxazG+ajAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSiMXi3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03362C433F1;
	Mon, 22 Jan 2024 00:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705882977;
	bh=/98FyMHfNpcE20uREuwvTI8aEaiGp4Wx3e7AXQcREB8=;
	h=From:To:Cc:Subject:Date:From;
	b=cSiMXi3dT5GpQICa7Om7LNG5CODXq/A5eLQLot62CARYuv48uTEsKFbCUsiN/aK2v
	 s9uZxu7P3fbDu+6LfqSxjftwQ/QcWy37EZwTnoHtMjuasPfcu1t9F4/OALHYoVQQqZ
	 dOy0OsVn3VSEk2ucP4CrE2u5gasKrgU04YMIK19Ww/xIJHxRd99H+NTqZHejdVXXB8
	 laEOtzT7btvQ0yYcJOMpqmZPLwbrnbQ2graMl+UTIi4gjQF8l1dtaM63DO9NUPVWXw
	 hi/A8A1kiJovyJZkATF/D05ea2yE+fUWWRdtJBn4z3NmGyIvM69hmD5JdZTMBv+nts
	 AJ+QYb+emR7jg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	=?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	Heiko Stuebner <heiko@sntech.de>,
	Jerry Shih <jerry.shih@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Phoebe Chen <phoebe.chen@sifive.com>,
	hongrong.hsu@sifive.com
Subject: [PATCH v3 00/10] RISC-V crypto with reworked asm files
Date: Sun, 21 Jan 2024 16:19:11 -0800
Message-ID: <20240122002024.27477-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset, which applies to v6.8-rc1, adds cryptographic algorithm
implementations accelerated using the RISC-V vector crypto extensions
(https://github.com/riscv/riscv-crypto/releases/download/v1.0.0/riscv-crypto-spec-vector.pdf)
and RISC-V vector extension
(https://github.com/riscv/riscv-v-spec/releases/download/v1.0/riscv-v-spec-1.0.pdf).
The following algorithms are included: AES in ECB, CBC, CTR, and XTS modes;
ChaCha20; GHASH; SHA-2; SM3; and SM4.

In general, the assembly code requires a 64-bit RISC-V CPU with VLEN >= 128,
little endian byte order, and vector unaligned access support.  The ECB, CTR,
XTS, and ChaCha20 code is designed to naturally scale up to larger VLEN values.
Building the assembly code requires tip-of-tree binutils (future 2.42) or
tip-of-tree clang (future 18.x).  All algorithms pass testing in QEMU, using
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.  Much of the assembly code is derived from
OpenSSL code that was added by https://github.com/openssl/openssl/pull/21923.
It's been cleaned up for integration with the kernel, e.g. reducing code
duplication, eliminating use of .inst and perlasm, and fixing a few bugs.

This patchset incorporates the work of multiple people, including Jerry Shih,
Heiko Stuebner, Christoph Müllner, Phoebe Chen, Charalampos Mitrodimas, and
myself.  This patchset went through several versions from Heiko (last version
https://lore.kernel.org/linux-crypto/20230711153743.1970625-1-heiko@sntech.de),
then several versions from Jerry (last version:
https://lore.kernel.org/linux-crypto/20231231152743.6304-1-jerry.shih@sifive.com),
then finally several versions from me.  Thanks to everyone who has contributed
to this patchset or its prerequisites.  Since v6.8-rc1, all prerequisite kernel
patches are upstream.  I think this is now ready, and I'd like for it to be
applied for 6.9, either to the crypto or riscv tree (at maintainers' choice).

Below is the changelog for my versions of the patchset.  For the changelog of
the older versions, see the above links.

Changed in v3:
  - Fixed a bug in the AES-XTS implementation where it assumed the CPU
    always set vl to the maximum possible value.  This was okay for
    QEMU, but the vector spec allows CPUs to have different behavior.
  - Increased the LMUL for AES-ECB to 8, as the registers are available.
  - Fixed some license text that I had mistakenly changed when doing a
    find-and-replace of code.
  - Addressed a checkpatch warning by not including filename in file.
  - Rename some labels.
  - Constify a variable.

Changed in v2:
  - Merged the AES modules together to prevent a build error.
  - Only unregister AES algorithms that were registered.
  - Corrected walksize properties to match the LMUL used by asm code.
  - Simplified the CTR and XTS glue code slightly.
  - Minor cleanups.

Changed in v1:
  - Refer to my cover letter
    https://lore.kernel.org/linux-crypto/20240102064743.220490-1-ebiggers@kernel.org/

Eric Biggers (1):
  RISC-V: add TOOLCHAIN_HAS_VECTOR_CRYPTO

Heiko Stuebner (2):
  RISC-V: add helper function to read the vector VLEN
  RISC-V: hook new crypto subdir into build-system

Jerry Shih (7):
  crypto: riscv - add vector crypto accelerated AES-{ECB,CBC,CTR,XTS}
  crypto: riscv - add vector crypto accelerated ChaCha20
  crypto: riscv - add vector crypto accelerated GHASH
  crypto: riscv - add vector crypto accelerated SHA-{256,224}
  crypto: riscv - add vector crypto accelerated SHA-{512,384}
  crypto: riscv - add vector crypto accelerated SM3
  crypto: riscv - add vector crypto accelerated SM4

 arch/riscv/Kbuild                             |   1 +
 arch/riscv/Kconfig                            |   7 +
 arch/riscv/crypto/Kconfig                     |  93 +++
 arch/riscv/crypto/Makefile                    |  23 +
 arch/riscv/crypto/aes-macros.S                | 156 +++++
 arch/riscv/crypto/aes-riscv64-glue.c          | 550 ++++++++++++++++++
 .../crypto/aes-riscv64-zvkned-zvbb-zvkg.S     | 312 ++++++++++
 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S   | 146 +++++
 arch/riscv/crypto/aes-riscv64-zvkned.S        | 180 ++++++
 arch/riscv/crypto/chacha-riscv64-glue.c       | 101 ++++
 arch/riscv/crypto/chacha-riscv64-zvkb.S       | 294 ++++++++++
 arch/riscv/crypto/ghash-riscv64-glue.c        | 168 ++++++
 arch/riscv/crypto/ghash-riscv64-zvkg.S        |  72 +++
 arch/riscv/crypto/sha256-riscv64-glue.c       | 137 +++++
 .../sha256-riscv64-zvknha_or_zvknhb-zvkb.S    | 225 +++++++
 arch/riscv/crypto/sha512-riscv64-glue.c       | 133 +++++
 .../riscv/crypto/sha512-riscv64-zvknhb-zvkb.S | 203 +++++++
 arch/riscv/crypto/sm3-riscv64-glue.c          | 112 ++++
 arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S    | 123 ++++
 arch/riscv/crypto/sm4-riscv64-glue.c          | 107 ++++
 arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S   | 117 ++++
 arch/riscv/include/asm/vector.h               |  11 +
 crypto/Kconfig                                |   3 +
 23 files changed, 3274 insertions(+)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile
 create mode 100644 arch/riscv/crypto/aes-macros.S
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.S
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.S
 create mode 100644 arch/riscv/crypto/chacha-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/chacha-riscv64-zvkb.S
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.S
 create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
 create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.S
 create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S
 create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.43.0


