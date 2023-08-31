Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5778EED0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345468AbjHaNmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345235AbjHaNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:42:10 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FD61A4;
        Thu, 31 Aug 2023 06:42:05 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: E34CEC1.A8AB2
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:139:242:ac11:1e])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id E34CEC1;
        Thu, 31 Aug 2023 15:42:00 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1693489320;
        bh=qV1ZdVqS533lQ+ieXmsTUkPt1KXg5W/quXEe7I7HjnE=;
        h=From:To:Cc:Subject:Date;
        b=NyB6oh2bHzyX0nGNrTayqCiHdeSgKBWy+4EBB2p+n6U+w1yvrMjPHd6WVME0HH4gc
         iHAIaVfzQADrCzQ8rvvYbXaceHOOd1TQoW7LdLr+jid211e9mtD/4rKPVCqjQxHp36
         uU5rHYV2ka0knpeZ5K+j2KqzelaN1t+GzEkltQ9U=
Received: from localhost.localdomain (unknown [10.45.168.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id A2B9CD4F6196E;
        Thu, 31 Aug 2023 15:42:00 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v5 00/13] selftests/sgx: Fix compilation errors
Date:   Thu, 31 Aug 2023 15:41:31 +0200
Message-Id: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the fifth iteration of a patch series to ensure that all SGX selftests
succeed when compiling with optimizations (as tested with -O{0,1,2,3,s} for
both gcc 11.3.0 and clang 14.0.0). The aim of the patches is to avoid reliance
on undefined, compiler-specific behavior that can make the test results
fragile.

Reference output below:

.. Testing   gcc   -O0    [OK]
.. Testing   gcc   -O1    [OK]
.. Testing   gcc   -O2    [OK]
.. Testing   gcc   -O3    [OK]
.. Testing   gcc   -Os    [OK]
.. Testing   gcc   -Ofast [OK]
.. Testing   gcc   -Og    [OK]
.. Testing   clang -O0    [OK]
.. Testing   clang -O1    [OK]
.. Testing   clang -O2    [OK]
.. Testing   clang -O3    [OK]
.. Testing   clang -Os    [OK]
.. Testing   clang -Ofast [OK]
.. Testing   clang -Og    [OK]

Changelog
---------

v5
  - Reorder patches (Jarkko, Kai)
  - Include fixes tag for inline asm memory clobber patch (Kai)
  - Include linker error in static-pie commit message (Kai)
  - Include generated assembly in relocations commit (Kai)

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

Best,
Jo

Jo Van Bulck (13):
  selftests/sgx: Fix uninitialized pointer dereference in error path
  selftests/sgx: Fix uninitialized pointer dereferences in
    encl_get_entry
  selftests/sgx: Include memory clobber for inline asm in test enclave
  selftests/sgx: Separate linker options
  selftests/sgx: Specify freestanding environment for enclave
    compilation
  selftests/sgx: Remove redundant enclave base address save/restore
  selftests/sgx: Produce static-pie executable for test enclave
  selftests/sgx: Handle relocations in test enclave
  selftests/sgx: Fix linker script asserts
  selftests/sgx: Ensure test enclave buffer is entirely preserved
  selftests/sgx: Ensure expected location of test enclave buffer
  selftests/sgx: Discard unsupported ELF sections
  selftests/sgx: Remove incomplete ABI sanitization code in test enclave

 tools/testing/selftests/sgx/Makefile          | 12 ++--
 tools/testing/selftests/sgx/defines.h         |  2 +
 tools/testing/selftests/sgx/load.c            |  9 ++-
 tools/testing/selftests/sgx/sigstruct.c       |  5 +-
 tools/testing/selftests/sgx/test_encl.c       | 67 +++++++++++++------
 tools/testing/selftests/sgx/test_encl.lds     | 10 +--
 .../selftests/sgx/test_encl_bootstrap.S       | 28 +++-----
 7 files changed, 77 insertions(+), 56 deletions(-)

-- 
2.25.1

