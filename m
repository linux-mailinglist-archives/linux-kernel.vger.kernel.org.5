Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1E87AA372
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjIUVu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjIUVu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:50:27 -0400
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFE68CC94;
        Thu, 21 Sep 2023 10:42:40 -0700 (PDT)
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:131])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id C5AE629C3;
        Thu, 21 Sep 2023 16:36:59 +0200 (CEST)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 811F6201B4.AF3C2
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:140:242:ac11:1d])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 811F6201B4;
        Thu, 21 Sep 2023 16:36:37 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1695306997;
        bh=SwLD8/U7UN06+wHZP5wX9JtDvnWuIFp1Ea4q7cRJOXw=;
        h=From:To:Cc:Subject:Date;
        b=AGWlTrp+yggW3WYIVPHio+NHwV34PcxQNilk/051Mi/wcA4apl46GPuswjhfTJjMY
         us38ZuuB7QYP/fPzD97KxkKl7pCKPLpP2KuYfX49N4lnqGg/GcIDD3FZRCPMTkk+ye
         mqQmSqsj0MS+G6JoF8HHKGXPrkUxLs5cXrLHU6xU=
Received: from localhost.localdomain (ptr-82s0fs8p4onqm1q5sl7.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:c962:1db3:c9ed:fdfb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 4609ED4F30837;
        Thu, 21 Sep 2023 16:36:37 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v6 00/13] selftests/sgx: Fix compilation errors
Date:   Thu, 21 Sep 2023 16:35:51 +0200
Message-Id: <20230921143604.6561-1-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series ensures that all SGX selftests succeed when compiling with
optimizations (as tested with -O{0,1,2,3,s} for both gcc 11.3.0 and clang
14.0.0). The aim of the patches is to avoid reliance on undefined,
compiler-specific behavior that can make the test results fragile.

As far as I see, all commits in this series have now been acked/reviewed.
Please let me know if any concerns remain and I'd happily address them.

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

v6
  - Collect final ack/reviewed-by tags (Jarkko, Kai)

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

