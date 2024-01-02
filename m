Return-Path: <linux-kernel+bounces-14089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBE18217C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A201C21262
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D623C3;
	Tue,  2 Jan 2024 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaaGec9u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC920F5;
	Tue,  2 Jan 2024 06:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CB4C433C8;
	Tue,  2 Jan 2024 06:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704178211;
	bh=FRVLdcULfQJ6wzht7zYhA2uTw6fe/0FkHYlgCcy8QM8=;
	h=From:To:Cc:Subject:Date:From;
	b=YaaGec9u7t15mBgJohV8I9Yvkcb1tSj0v21P62RlzL9oWigQfDFiepXYsUfUpuqwO
	 gggl+bz7dGJ+tF5D+oqbchmSLKoQ65/TcnQKFgRTE5LMCwb2VqjkpPHx1k8tjmoS6m
	 uGaq/drBxtmADSdFFXbZZ1EO083tJ6Wrif7Uxsr7Rm32rXp5KVjLdGxSC3jshMGczh
	 i7QggYhAuqW48W4Hm+6pkKeHmdCXe1CchvN21KxktDM7RarwZVXgbPIelr+D8stJxr
	 Aj+nDYGO9YNkFHsHcUuKZf0AAtsvA8A3g657BsYk9DuJrkqmNYKjzC755EDHUwprR4
	 qPF/hOTJFQ6qw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jerry Shih <jerry.shih@sifive.com>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Phoebe Chen <phoebe.chen@sifive.com>,
	hongrong.hsu@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>
Subject: [RFC PATCH 00/13] RISC-V crypto with reworked asm files
Date: Tue,  2 Jan 2024 00:47:26 -0600
Message-ID: <20240102064743.220490-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As discussed previously, the proposed use of the so-called perlasm for
the RISC-V crypto assembly files makes them difficult to read, and these
files have some other issues such extensively duplicating source code
for the different AES key lengths and for the unrolled hash functions.
There is/was a desire to share code with OpenSSL, but many of the files
have already diverged significantly; also, for most of the algorithms
the source code can be quite short anyway, due to the native support for
them in the RISC-V vector crypto extensions combined with the way the
RISC-V vector extension naturally scales to arbitrary vector lengths.

Since we're still waiting for prerequisite patches to be merged anyway,
we have a bit more time to get this cleaned up properly.  So I've had a
go at cleaning up the patchset to use standard .S files, with the code
duplication fixed.  I also made some tweaks to make the different
algorithms consistent with each other and with what exists in the kernel
already for other architectures, and tried to improve comments.

The result is this series, which passes all tests and is about 2400
lines shorter than the latest version with the perlasm
(https://lore.kernel.org/linux-crypto/20231231152743.6304-1-jerry.shih@sifive.com/).
All the same functionality and general optimizations are still included,
except for some minor optimizations in XTS that I dropped since it's not
clear they are worth the complexity.  (Note that almost all users of XTS
in the kernel only use it with block-aligned messages, so it's not very
important to optimize the ciphertext stealing case.)

I'd appreciate people's thoughts on this series.  Jerry, I hope I'm not
stepping on your toes too much here, but I think there are some big
improvements here.

This series is based on riscv/for-next
(https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=for-next)
commit f352a28cc2fb4ee8d08c6a6362c9a861fcc84236, and for convenience
I've included the prerequisite patches too.

Andy Chiu (1):
  riscv: vector: make Vector always available for softirq context

Eric Biggers (1):
  RISC-V: add TOOLCHAIN_HAS_VECTOR_CRYPTO

Greentime Hu (1):
  riscv: Add support for kernel mode vector

Heiko Stuebner (2):
  RISC-V: add helper function to read the vector VLEN
  RISC-V: hook new crypto subdir into build-system

Jerry Shih (8):
  crypto: riscv - add vector crypto accelerated AES
  crypto: riscv - add vector crypto accelerated AES-{ECB,CBC,CTR,XTS}
  crypto: riscv - add vector crypto accelerated ChaCha20
  crypto: riscv - add vector crypto accelerated GHASH
  crypto: riscv - add vector crypto accelerated SHA-{256,224}
  crypto: riscv - add vector crypto accelerated SHA-{512,384}
  crypto: riscv - add vector crypto accelerated SM3
  crypto: riscv - add vector crypto accelerated SM4

 arch/riscv/Kbuild                             |   1 +
 arch/riscv/Kconfig                            |   7 +
 arch/riscv/crypto/Kconfig                     | 108 +++++
 arch/riscv/crypto/Makefile                    |  28 ++
 arch/riscv/crypto/aes-macros.S                | 156 +++++++
 .../crypto/aes-riscv64-block-mode-glue.c      | 435 ++++++++++++++++++
 arch/riscv/crypto/aes-riscv64-glue.c          | 123 +++++
 arch/riscv/crypto/aes-riscv64-glue.h          |  15 +
 .../crypto/aes-riscv64-zvkned-zvbb-zvkg.S     | 300 ++++++++++++
 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S   | 146 ++++++
 arch/riscv/crypto/aes-riscv64-zvkned.S        | 180 ++++++++
 arch/riscv/crypto/chacha-riscv64-glue.c       | 101 ++++
 arch/riscv/crypto/chacha-riscv64-zvkb.S       | 294 ++++++++++++
 arch/riscv/crypto/ghash-riscv64-glue.c        | 170 +++++++
 arch/riscv/crypto/ghash-riscv64-zvkg.S        |  72 +++
 arch/riscv/crypto/sha256-riscv64-glue.c       | 137 ++++++
 .../sha256-riscv64-zvknha_or_zvknhb-zvkb.S    | 225 +++++++++
 arch/riscv/crypto/sha512-riscv64-glue.c       | 133 ++++++
 .../riscv/crypto/sha512-riscv64-zvknhb-zvkb.S | 203 ++++++++
 arch/riscv/crypto/sm3-riscv64-glue.c          | 112 +++++
 arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S    | 123 +++++
 arch/riscv/crypto/sm4-riscv64-glue.c          | 109 +++++
 arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S   | 117 +++++
 arch/riscv/include/asm/processor.h            |  14 +-
 arch/riscv/include/asm/simd.h                 |  48 ++
 arch/riscv/include/asm/vector.h               |  20 +
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/kernel_mode_vector.c        | 126 +++++
 arch/riscv/kernel/process.c                   |   1 +
 crypto/Kconfig                                |   3 +
 30 files changed, 3507 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile
 create mode 100644 arch/riscv/crypto/aes-macros.S
 create mode 100644 arch/riscv/crypto/aes-riscv64-block-mode-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.h
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
 create mode 100644 arch/riscv/include/asm/simd.h
 create mode 100644 arch/riscv/kernel/kernel_mode_vector.c


base-commit: f352a28cc2fb4ee8d08c6a6362c9a861fcc84236
-- 
2.43.0


