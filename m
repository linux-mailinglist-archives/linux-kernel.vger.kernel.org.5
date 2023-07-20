Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9B75BA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGTWQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjGTWQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:16:45 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98B82719;
        Thu, 20 Jul 2023 15:16:38 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 6F6E720062.A8038
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 6F6E720062;
        Fri, 21 Jul 2023 00:16:36 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1689891396;
        bh=MUvkXaHJscXkn3soe3GHvbi/8r00sCGN7xscqa5tFX4=;
        h=From:To:Cc:Subject:Date;
        b=ZtI9/u/VaB1bl2vxl9lPiBV/JQ4/gCKu9eae9Njucv5FE0v/0gIe89lcZgQ6aZvm1
         mO0DtKQKRUYCg7/35gqZmZTBAeC/1VO/9Po1FfeHnkEcFrbeAChFVqd64flisBrTWW
         TTr/apM800E57Q7FBrn4wfNjuHe/z6PJgnU2VPjA=
Received: from librem.home (unknown [IPv6:2a02:1210:6c17:f000:92c2:ccf4:848b:6bf4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 15383D4EB0CF8;
        Fri, 21 Jul 2023 00:16:36 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v2 0/4] selftests/sgx: Harden test enclave
Date:   Fri, 21 Jul 2023 00:16:19 +0200
Message-Id: <20230720221623.9530-1-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series fixes several issues in the SGX example test enclave:

1. Adhere to enclave programming best practices by sanitizing untrusted
   user inputs (ABI registers and API pointer arguments).
2. Ensure correct behavior with compiler optimizations (gcc -O{1,2,3,s}).

Motivation
==========

While I understand that the bare-metal Intel SGX selftest enclave is
certainly not intended as a full-featured independent production runtime,
it has been noted on this mailing list before that "people are likely to
copy this code for their own enclaves" and that it provides a "great
starting point if you want to do things from scratch" [1]. Indeed, at least
one real-world SGX project (Alibaba Inclavare Containers) appears to build
directly on the Linux selftest enclave as a skeleton [2]. Thus, proper and
complete example code is vital for security-sensitive functionality,
like the selftest example enclave.

The purpose of this patch series is, hence, to make the test enclave adhere
to required enclave programming defensive measures by, to the extent
possible and practical, sanitizing attacker-controlled inputs through
minimal checks. Note that this is in line with the existing check in the
test enclave to guard against buffer overflow of the encl_op_array through
the op.type input.

Proposed changes
================

This patch series adds the minimally required sanitization checks, as well
as makes the test enclave compatible with gcc compiler optimizations. The
added functionality is separated in this patch series as follows:

1. Minimal changes in the enclave entry assembly stub as per the x86-64
   ABI expected by the C compiler. Particularly, sanitize the DF and AC
   bits in RFLAGS, which have been dangerously abused in prior SGX attack
   research [3,4]. Also add a test case to validate the sanitization.

   Note that, compiling the existing, unmodified test enclave on my machine
   (gcc v11.3.0) with -Os optimizations yields assembly code that uses the
   x86 REP string instructions for memcpy/memset. Hence, such a compiled
   test enclave would be directly vulnerable to severe memory-corruption
   attacks by trivially inverting RFLAGS.DF before enclave entry (similar
   to CVE-2019-14565 -- Intel SA-00293 [3]).

   Finally note that the proposed patch does currently _not_ sanitize the
   extended CPU state using XSAVE/XRSTOR, as has been shown in prior attack
   research to be necessary for SGX enclaves using floating-point
   instructions [5]. I found that prior versions of the selftest enclave
   _did_ partially cleanse extended CPU state, but that his functionality
   has been removed, as it was argued that "the test enclave doesn't touch
   state managed by XSAVE, let alone put secrets into said state" [6].
   However, I found that compiling the unmodified test enclave with gcc
   -O{2,3} optimization levels may still use the XMM registers to store
   some intermediate results (i.e., clobber them as allowed per the x86-64
   ABI). Hence, for now, add the -mno-sse compilation option to prevent
   this behavior and add a note to explicitly document the assumption that
   extended state should remain untouched in the selftest enclave.

   This may also be an argument to consider re-adding the XRSTOR
   functionality?

2. Make the selftest enclave aware of its protected ELRANGE: add a linker
   symbol __enclave_base at the start of the enclave binary and reserve
   space for __enclave_size to be filled in by the untrusted loader when
   determining the size of the final enclave image (depending on allocated
   heap etc.). The final value for __enclave_size is filled in before
   actual enclave loading and will be measured as part of MRENCLAVE,
   allowing to trust the size within the enclave validation logic. This
   approach is similar to how this is done in real-world enclave runtimes
   (e.g., Intel SGX-SDK).

3. Add minimal validation logic in the enclave C code to ensure that
   incoming pointer struct arguments properly point outside the enclave
   before dereference, preventing confused-deputy attacks. Use a C macro to
   copy struct arguments fully inside the enclave to avoid time-of-check to
   time-of-use issues for nested pointers. Note that the test enclave
   deliberately allows arbitrary reads/writes in enclave memory through the
   get_from_addr/put_to_addr operations for explicit testing purposes.
   Hence, add an explicit note for this case and only allow remaining
   unchecked pointer dereferences in these functions.

4. Ensure correct behavior under gcc compiler optimizations. Declare
   encl_op_array static to ensure RIP-relative addressing is used to access
   the function-pointer table and rebase the loaded function-pointer
   entries at runtime before jumping. Declare the secinfo structure as
   volatile to ensure the compiler passes an aligned address to ENCLU.

   To ensure future compatibility, it may also be worthwhile to rewrite the
   test framework to exhaustively execute all tests for test_encl.elf
   compiled with all possible gcc optimizations -O{0,1,2,3,s}?

Best,
Jo

[1] https://patchwork.kernel.org/comment/23202425/
[2] https://github.com/inclavare-containers/inclavare-containers/tree/master/rune/libenclave/internal/runtime/pal/skeleton
[3] https://jovanbulck.github.io/files/ccs19-tale.pdf
[4] https://jovanbulck.github.io/files/systex22-abi.pdf
[5] https://jovanbulck.github.io/files/acsac20-fpu.pdf
[6] https://patchwork.kernel.org/comment/23216515/

Changelog
---------

v2
  - Add explanation for added test cases (Jarkko)
  - Rename encl_size_pt and reverse xmas tree ordering (Jarkko)
  - Use static inline functions instead of C macros (Jarkko)

Jo Van Bulck (4):
  selftests/sgx: Harden test enclave ABI
  selftests/sgx: Store base address and size in test enclave
  selftests/sgx: Harden test enclave API
  selftests/sgx: Fix compiler optimizations in test enclave

 tools/testing/selftests/sgx/Makefile          |   2 +-
 tools/testing/selftests/sgx/load.c            |   3 +-
 tools/testing/selftests/sgx/main.c            |  62 ++++++
 tools/testing/selftests/sgx/test_encl.c       | 198 +++++++++++++-----
 tools/testing/selftests/sgx/test_encl.lds     |   1 +
 .../selftests/sgx/test_encl_bootstrap.S       |  29 +++
 6 files changed, 246 insertions(+), 49 deletions(-)

-- 
2.34.1

