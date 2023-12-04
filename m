Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0761802CA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjLDIFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjLDIFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:05:10 -0500
Received: from mail.nsr.re.kr (unknown [210.104.33.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AD8F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:05:14 -0800 (PST)
Received: from 210.104.33.70 (nsr.re.kr)
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128 bits))
        by mail.nsr.re.kr with SMTP; Mon, 04 Dec 2023 17:02:52 +0900
X-Sender: letrehee@nsr.re.kr
Received: from 192.168.155.188 ([192.168.155.188])
          by mail.nsr.re.kr (Crinity Message Backbone-7.0.1) with SMTP ID 319;
          Mon, 4 Dec 2023 17:02:47 +0900 (KST)
From:   Dongsoo Lee <letrehee@nsr.re.kr>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongsoo Lee <letrhee@nsr.re.kr>
Subject: [PATCH 0/5] crypto: LEA block cipher implementation
Date:   Mon,  4 Dec 2023 08:02:12 +0000
Message-Id: <20231204080217.9407-1-letrehee@nsr.re.kr>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongsoo Lee <letrhee@nsr.re.kr>

This submission contains a generic C implementation of the LEA cipher and test vectors for it. It also includes modifications to use the LEA in fscrypt.

The LEA algorithm is a lightweight block cipher that processes data blocks of 128-bits and has three different key lengths, each with a different number of rounds:

- LEA-128: 128-bit key, 24 rounds,
- LEA-192: 192-bit key, 28 rounds, and
- LEA-256: 256-bit key, 32 rounds.

The round function of LEA consists of 32-bit ARX (modular Addition, bitwise Rotation, and bitwise XOR) operations. See [2, 5, 7] for details.

LEA is a Korean national standard block cipher, described in "KS X 3246"[1] and is also included in the international standard, "ISO/IEC 29192-2:2019 standard"[2].

It is one of the approved block ciphers for the current Korean Cryptographic Module Validation Program (KCMVP).

At the time of submission, no successful attack on full-round LEA is known. As is typical for iterated block ciphers, reduced-round variants have been attacked. The best published attacks on LEA in the standard attack model (CPA/CCA with unknown key) are boomerang attacks and differential linear attacks. The security margin to the whole rounds ratio is greater than 29% against various existing cryptanalytic techniques for block ciphers. [3]

We expect that the first application of the patch would be the disk encryption on the Gooroom platform ('Gooroom' is a Korean word, meaning 'cloud') [4]. The Gooroom platform is a government-driven Debian-based Linux distribution in South Korea. In Korea, there are many crypto companies that want to bundle Linux into their products and sell them. They create their own Gooroom platforms by modifying the original Gooroom platform for their services. (Of course, the Gooroom platform is not mandatory, and companies wishing to use Linux are free to choose an appropriate distribution.) BTW, in Korea, many crypto companies want to use LEA, because LEA is one of the block ciphers of the KCMVP, a validation program for commercial crypto S/W to be delivered to the Korean government.

Currently, the Gooroom platform uses AES-XTS for disk encryption. The main reason for submitting this patch is to make disk encryption with LEA (e.g. LEA-XTS) available on there. If this submission is accepted, LEA can be used without any additional modifications in dm-crypt, a module that provides disk encryption functionality within the kernel.

This patch also includes a modification to enable LEA for use in fscrypt, another data-at-rest encryption method available within the kernel, and a modification to blk-crypto-fallback to enable the "inlinecrypt" mount option in fscrypt.

The Linux Crypto API already has another Korean block cipher, ARIA, also one of the block ciphers of the KCVMP. However, LEA is more widely used than ARIA in industry nowadays, because LEA is one of the lightweight cryptography standard of ISO/IEC [2] and performs well on low-end devices that support 32-bit operations. So we think they are complementary to each other.

In general, it's obvious that the hardware-accelerated AES is the best performer. However, there exist not only environments where the hardware-accelerated AES is not supported, but also situations where AES is not preferred for various reasons. In these cases, if someone wants to encrypt using a block cipher, LEA could be an alternative.

This submission includes a SIMD implementation for the x86-64 platform. The LEA cipher consists of 32-bit integer addition, rotation, and XOR operations, allowing for 4 blocks (XMM), 8 blocks (YMM), and 16 blocks (ZMM) of parallelism depending on the size of the registers. In addition, AVX2 and AVX-512F have more instructions to increase parallel encryption performance, which can be implemented differently even though they use the same registers. Therefore, lea-x86_64 selects the appropriate implementation in one glue code at module initialization. If additional SIMD instructions are added in the future, such as AVX10, this can be handled as well.

Below are the speedtest performed with the tcrypt module for AES, LEA, ARIA, and Adiantum on three different platforms (AMD Ryzen 9 5950X, Intel(R) Core(TM) i5-12600K, and Intel(R) Xeon(R) Gold 6254).

(4,096-byte block enc/decryption results in the tcrypt speedtest. Unit: cycles)

- AMD Ryzen 9 5950X (Virtual Machine)
  - aesni        ecb 128-bit key:  1,956 /   1,892
  - aesni        ecb 256-bit key:  2,086 /   2,098
  - lea-x86_64   ecb 128-bit key:  5,647 /   6,133
  - lea-x86_64   ecb 256-bit key:  6,702 /   7,444
  - aria-avx2    ecb 128-bit key:  8,316 /   8,153
  - aria-avx2    ecb 256-bit key: 10,539 /  10,550

  - aesni        cbc 128-bit key:  7,758 /   1,830
  - aesni        cbc 256-bit key: 10,660 /   2,071
  - lea-x86_64   cbc 128-bit key: 22,501 /   6,283
  - lea-x86_64   cbc 256-bit key: 28,125 /   7,592

  - aesni        ctr 128-bit key:  1,514 /   1,505
  - aesni        ctr 256-bit key:  1,884 /   1,867
  - lea-x86_64   ctr 128-bit key:  5,804 /   5,792
  - lea-x86_64   ctr 256-bit key:  6,958 /   6,951
  - aria-avx2    ctr 128-bit key:  8,819 /   8,736
  - aria-avx2    ctr 256-bit key: 11,101 /  10,636

  - adiantum(xchacha12-simd,...):  8,390 /   8,427
  - adiantum(xchacha20-simd,...):  9,698 /   9,732

  - aesni        xts 256-bit key:  2,177 /   2,165
  - aesni        xts 512-bit key:  2,589 /   2,527
  - lea-x86_64   xts 256-bit key:  6,488 /   6,745
  - lea-x86_64   xts 512-bit key:  7,484 /   8,083

  - aes-generic  ecb 128-bit key: 35,768 /  36,329
  - aes-generic  ecb 256-bit key: 35,785 /  35,237
  - lea-generic  ecb 128-bit key: 30,719 /  38,092
  - lea-generic  ecb 256-bit key: 35,373 /  46,941
  - aria-generic ecb 128-bit key:186,660 / 188,674
  - aria-generic ecb 256-bit key:247,919 / 245,527

- Intel(R) Core(TM) i5-12600K (microcode 0x15, AVX-512F Enabled)
  - aesni        ecb 128-bit key:  1,436 /   1,441
  - aesni        ecb 256-bit key:  1,984 /   1,987
  - lea-x86_64   ecb 128-bit key:  5,318 /   5,916
  - lea-x86_64   ecb 256-bit key:  6,209 /   7,071
  - aria-avx512  ecb 128-bit key:  4,786 /   4,799
  - aria-avx512  ecb 256-bit key:  5,988 /   5,989

  - aesni        cbc 128-bit key:  8,741 /   1,467
  - aesni        cbc 256-bit key: 11,803 /   1,995
  - lea-x86_64   cbc 128-bit key: 31,070 /   6,063
  - lea-x86_64   cbc 256-bit key: 39,117 /   7,173

  - aesni        ctr 128-bit key:  2,120 /   2,112
  - aesni        ctr 256-bit key:  2,588 /   2,595
  - lea-x86_64   ctr 128-bit key:  4,438 /   4,397
  - lea-x86_64   ctr 256-bit key:  5,217 /   5,196
  - aria-avx512  ctr 128-bit key:  6,270 /   6,272
  - aria-avx512  ctr 256-bit key:  7,469 /   7,473

  - adiantum(xchacha12-simd,...):  7,526 /   7,453
  - adiantum(xchacha20-simd,...):  8,983 /   8,892

  - aesni        xts 256-bit key:  2,234 /   2,241
  - aesni        xts 512-bit key:  2,525 /   2,538
  - lea-x86_64   xts 256-bit key:  6,687 /   7,333
  - lea-x86_64   xts 512-bit key:  7,626 /   8,457

  - aes-generic  ecb 128-bit key: 34,399 /  34,765
  - aes-generic  ecb 256-bit key: 48,568 /  49,245
  - lea-generic  ecb 128-bit key: 23,576 /  36,230
  - lea-generic  ecb 256-bit key: 31,715 /  50,461
  - aria-generic ecb 128-bit key:108,227 / 108,135
  - aria-generic ecb 256-bit key:146,669 / 145,993

- Intel(R) Xeon(R) Gold 6254 (Virtual Machine)
  - aesni        ecb 128-bit key:  3,390 /   3,396
  - aesni        ecb 256-bit key:  4,533 /   4,549
  - lea-x86_64   ecb 128-bit key:  5,500 /   6,594
  - lea-x86_64   ecb 256-bit key:  6,506 /   7,467
  - aria-avx2    ecb 128-bit key: 14,109 /  13,573
  - aria-avx2    ecb 256-bit key: 17,605 /  16,955

  - aesni        cbc 128-bit key: 12,559 /   3,544
  - aesni        cbc 256-bit key: 17,150 /   4,681
  - lea-x86_64   cbc 128-bit key: 33,471 /   5,900
  - lea-x86_64   cbc 256-bit key: 41,024 /   6,948

  - aesni        ctr 128-bit key:  3,099 /   3,095
  - aesni        ctr 256-bit key:  4,126 /   4,124
  - lea-x86_64   ctr 128-bit key:  5,054 /   4,909
  - lea-x86_64   ctr 256-bit key:  5,795 /   5,797
  - aria-avx2    ctr 128-bit key: 13,439 /  13,017
  - aria-avx2    ctr 256-bit key: 17,325 /  16,731

  - adiantum(xchacha12-simd,...):  9,064 /   9,006
  - adiantum(xchacha20-simd,...): 10,702 /  10,628

  - aesni        xts 256-bit key:  3,886 /   3,857
  - aesni        xts 512-bit key:  4,949 /   5,008
  - lea-x86_64   xts 256-bit key:  6,457 /   7,409
  - lea-x86_64   xts 512-bit key:  7,438 /   8,510

  - aes-generic  ecb 128-bit key: 49,438 /  48,803
  - aes-generic  ecb 256-bit key: 72,348 /  73,804
  - lea-generic  ecb 128-bit key: 30,300 /  45,072
  - lea-generic  ecb 256-bit key: 39,054 /  60,472
  - aria-generic ecb 128-bit key:189,850 / 175,073
  - aria-generic ecb 256-bit key:243,704 / 228,347

If this submission is accepted, future submissions may include an LEA implementation for aarch64 and an implementation with masks for AVX-512F.

Although the designers of LEA did not provide test vectors in their paper [5], the ISO/IEC standard [2] and the KS standard [1] do. Furthermore, the Block Cipher LEA Specification("블록암호 LEA 규격서", written in Korean) document on the LEA introduction page [6] and the Wikipedia article on LEA [7] show the same test vectors as in the standards.

The test vectors for ECB, CBC, CTR, and GCM modes included in the testmgr module are taken from the KCMVP Cryptographic Algorithm Verification Criteria V3.0("KCMVP 검증대상 암호알고리즘 검증기준 V3.0", written in Korean) [8]. Test vectors for the XTS mode were generated by ourselves, and we crosschecked them using Crypto++ [9] and testmgr on Linux.

The implementation was tested with kernel module tcrypt.ko and passed the selftest using the above-mentioned test vectors. It also has been tested with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS. The fscrypt patch was tested using a modified tool by forking https://github.com/google/fscrypt.

The AVX2 and AVX-512F implementations were tested on the device that performed the speedtest, while the SSE2 implementation was tested using QEMU's x86-64 binary emulation.

[1] KS X 3246, 128-bit block cipher LEA.
[2] ISO/IEC 29192-2:2019, Information security — Lightweight cryptography — Part 2: Block ciphers.
[3] Yi, Chen, et al. "Differential-Linear Approximation Semi-Unconstrained Searching and Partition Tree: Application to LEA and Speck", Asiacrypt 2023. (eprint 2023/1414)
[4] https://github.com/gooroom https://www.gooroom.kr/
[5] Hong, Deukjo, et al. "LEA: A 128-bit block cipher for fast encryption on common processors.", WISA 2013.
[6] https://seed.kisa.or.kr/kisa/algorithm/EgovLeaInfo.do
[7] https://en.wikipedia.org/wiki/LEA_(cipher)
[8] https://seed.kisa.or.kr/kisa/kcmvp/EgovVerification.do
[9] https://www.cryptopp.com/

Changelog:
v5:
- Added SSE2/AVX2/AVX-512F implementation
  - Single glue code to determine proper SIMD acceleration
- Adjusted ordering within structures to align with 16-byte boundaries.
- Added more test vectors.
  - Increased the maximum test-vector length to evaluate 16-block parallelism.
  - Added the CBC-CTS test vector.
v4:
- Removed documentation to describe LEAs in fscrypt.
v3:
- Added implementations to enable LEA in fscrypt and blk-crypt.
v2:
- Reimplemented the Generic C implementation as a Loop version.
  - The decryption code was adapted from an optimized implementation by Eric Biggers.
    https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?h=old/wip-lea&id=1d1cbba14380f8a1abc76baf939b9e51de047fb6
- Removed AVX2 SIMD implementation.
- Added comments for functions.
- Improved the description in Kconfig.
- Added test vectors from the standard documentation.

Dongsoo Lee (5):
  crypto: LEA block cipher implementation
  crypto: add LEA testmgr tests
  blk-crypto: Add LEA-256-XTS blk-crypto support
  fscrypt: Add LEA-256-XTS, LEA-256-CTS support
  crypto: LEA block cipher x86_64 optimization

 arch/x86/crypto/Kconfig            |   29 +
 arch/x86/crypto/Makefile           |    3 +
 arch/x86/crypto/lea-x86_64-asm.S   | 2272 +++++++++++++++++++++
 arch/x86/crypto/lea-x86_64-glue.c  |  820 ++++++++
 block/blk-crypto.c                 |    6 +
 crypto/Kconfig                     |   18 +
 crypto/Makefile                    |    1 +
 crypto/lea_generic.c               |  410 ++++
 crypto/tcrypt.c                    |   97 +
 crypto/testmgr.c                   |   38 +
 crypto/testmgr.h                   | 3022 ++++++++++++++++++++++++++++
 fs/crypto/fscrypt_private.h        |    2 +-
 fs/crypto/keysetup.c               |   15 +
 fs/crypto/policy.c                 |    4 +
 include/crypto/lea.h               |   44 +
 include/linux/blk-crypto.h         |    1 +
 include/uapi/linux/fscrypt.h       |    4 +-
 tools/include/uapi/linux/fscrypt.h |    4 +-
 18 files changed, 6787 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/crypto/lea-x86_64-asm.S
 create mode 100644 arch/x86/crypto/lea-x86_64-glue.c
 create mode 100644 crypto/lea_generic.c
 create mode 100644 include/crypto/lea.h

-- 
2.40.1
