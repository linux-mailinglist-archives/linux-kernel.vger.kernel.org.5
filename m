Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248EA7888BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245197AbjHYNdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245085AbjHYNdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:33:16 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [134.58.240.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7BF1FDE;
        Fri, 25 Aug 2023 06:33:14 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 49882201B7.AE660
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 49882201B7;
        Fri, 25 Aug 2023 15:33:09 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692970389;
        bh=vp8fkTfpj2pMBJhMKyDWMekB7qDxhVJsvFbpU7SdwIA=;
        h=From:To:Cc:Subject:Date;
        b=Hk8wwfmyaZ+4xbEIESYyXe4X9JkBqz482Q+7M9zBgTvBO51IQLD6dM/FMrGIbA7xr
         v+W5nXcls31Za+kwNCh6wwYy/BRvdrBDyYeVzWs4aTE52jHWglLjSqGzR2yYakgTmY
         yzKa+kvG//ChrUdw2NIv7Qf2OVEDC3vlhvyYpsc4=
Received: from localhost.localdomain (ptr-82s0fs8e775rpuqrs36.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:b56b:371:2317:a8f2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 03C15D4F7F13B;
        Fri, 25 Aug 2023 15:33:08 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v4 00/13] selftests/sgx: Fix compilation errors
Date:   Fri, 25 Aug 2023 15:32:39 +0200
Message-Id: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the fourth iteration of a patch series to ensure that all SGX selftests
succeed when compiling with optimizations (as tested with -O{0,1,2,3,s} for
both gcc 11.3.0 and clang 14.0.0). The aim of the patches is to avoid reliance
on undefined, compiler-specific behavior that can make the test results
fragile.

This series appends 4 new commits compared to the previous series (do let me
know if appending commits to this series is not the preferred way to handle
these?):

1. Another fix for possibly uninitialized pointer dereferences in
   encl_get_entry. Note that this was only brought up as a compiler warning
   when compiling the loader itself (i.e., not only the enclave) with
   optimizations. Also not that the uninitialized pointers shouldn't show up
   for "well-formed" enclave ELF files that properly contain a symbol table
   section, but I considered it is nevertheless good practice to harden the
   code against this (unlikely) case.
2. Split off the ".dyn*" and ".gnu.hash" discarding in a separate commit, as
   suggested by Kay [1].
3. Split off the removal of the redundant push/pop pair in a separate commit,
   as suggested by Kai [2].
4. Remove all (incomplete) CPU register cleansing assembly code on enclave
   exit, reflecting earlier discussions that highlight that the test enclave
   should *not* be confused with exemplary, security-hardened enclave code, and
   in line with Dave's suggestion to make the test enclave more *obviously*
   insecure [3].

If useful, I can also include an elementary wrapper shell script to compile and
run the tests for different compilers (gcc/clang) and optimization levels.
Reference output below:

.. Testing gcc   -O0    [OK]
.. Testing gcc   -O1    [OK]
.. Testing gcc   -O2    [OK]
.. Testing gcc   -O3    [OK]
.. Testing gcc   -Os    [OK]
.. Testing gcc   -Ofast [OK]
.. Testing gcc   -Og    [OK]
.. Testing clang -O0    [OK]
.. Testing clang -O1    [OK]
.. Testing clang -O2    [OK]
.. Testing clang -O3    [OK]
.. Testing clang -Os    [OK]
.. Testing clang -Ofast [OK]
.. Testing clang -Og    [OK]

Changelog
---------

v4
  - Remove redundant -nostartfiles compiler flag (Jarkko)
  - Split dynamic symbol table removal in separate commit (Kai)
  - Split redundant push/pop elimination in separate commit (Kai)
  - Remove (incomplete) register cleansing on enclave exit
  - Fix possibly uninitialized pointer dereferences in load.c

v3
  - Refactor encl_op_array declaration and indexing (Jarkko)
  - Annotate encl_buffer with "used" attribute (Kai)
  - Split encl_buffer size and placement commits (Kai)

v2
  - Add additional check for NULL pointer (Kai)
  - Refine to produce proper static-pie executable
  - Fix linker script assertions
  - Specify memory clobber for inline asm instead of volatile (Kai)
  - Clarify why encl_buffer non-static (Jarkko, Kai)
  - Clarify -ffreestanding (Jarkko)

References
----------

[1] https://lore.kernel.org/all/90ad8638bc1c26505e33b3f436fdbc22c8d74ba9.camel@intel.com/
[2] https://lore.kernel.org/all/71ad6389da7db8541dada0276db33f98e2a4fdcf.camel@intel.com/
[3] https://lore.kernel.org/all/da0cfb1e-e347-f7f2-ac72-aec0ee0d867d@intel.com/

Best,
Jo


Jo Van Bulck (13):
  selftests/sgx: Fix uninitialized pointer dereference in error path
  selftests/sgx: Produce static-pie executable for test enclave
  selftests/sgx: Handle relocations in test enclave
  selftests/sgx: Fix linker script asserts
  selftests/sgx: Include memory clobber for inline asm in test enclave
  selftests/sgx: Ensure test enclave buffer is entirely preserved
  selftests/sgx: Ensure expected location of test enclave buffer
  selftests/sgx: Separate linker options
  selftests/sgx: Specify freestanding environment for enclave
    compilation
  selftests/sgx: Fix uninitialized pointer dereferences
  selftests/sgx: Discard unsupported ELF sections
  selftests/sgx: Remove redundant enclave base address save/restore
  selftests/sgx: Remove incomplete ABI sanitization code in test enclave

 tools/testing/selftests/sgx/Makefile          | 14 ++--
 tools/testing/selftests/sgx/defines.h         |  2 +
 tools/testing/selftests/sgx/load.c            |  9 ++-
 tools/testing/selftests/sgx/sigstruct.c       |  5 +-
 tools/testing/selftests/sgx/test_encl.c       | 65 ++++++++++++-------
 tools/testing/selftests/sgx/test_encl.lds     | 10 +--
 .../selftests/sgx/test_encl_bootstrap.S       | 28 +++-----
 7 files changed, 76 insertions(+), 57 deletions(-)

-- 
2.25.1

