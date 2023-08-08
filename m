Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3793D774A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjHHUXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjHHUXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:23:24 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D9A1BC1;
        Tue,  8 Aug 2023 12:32:19 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 2786918.AE55E
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 2786918;
        Tue,  8 Aug 2023 21:32:16 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691523136;
        bh=ZwHoG1FSLPdwnjwsnFXl0cFqGgp/mVcR6JfBwdlbjPg=;
        h=From:To:Cc:Subject:Date;
        b=dwceqJXBvxulqechRxRhCXjvYjeUD7Dmhauu8vyfbk1Un8w+uRkYIiqENPV1slBJI
         5sq5I9JsuQMxijD21DnrnFbG1mNJVeUeqLX4Y+CFQfGp+ZqKe2ew7SDTbEWKefuffA
         jXOEiNMyf8uDiwN4BblLDyqbjVmxXNRajmoKTlrw=
Received: from localhost.localdomain (rrcs-24-123-120-98.central.biz.rr.com [24.123.120.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 90A87D4F79D27;
        Tue,  8 Aug 2023 21:32:14 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v2 0/8] selftests/sgx: Fix compilation errors
Date:   Tue,  8 Aug 2023 12:31:37 -0700
Message-Id: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second iteration of a patch series to ensure that all SGX selftests
succeed when compiling with optimizations (as tested with -O{0,1,2,3,s} for
both gcc 11.3.0 and clang 14.0.0). The aim of the patches is to avoid reliance
on undefined, compiler-specific behavior that can make the test results
fragile.

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

v2
  - Add additional check for NULL pointer (Kai)
  - Refine to produce proper static-pie executable
  - Fix linker script assertions
  - Specify memory clobber for inline asm instead of volatile (Kai)
  - Clarify why encl_buffer non-static (Jarkko, Kai)
  - Clarify -ffreestanding (Jarkko)

Best,
Jo

Jo Van Bulck (8):
  selftests/sgx: Fix uninitialized pointer dereference in error path
  selftests/sgx: Produce static-pie executable for test enclave
  selftests/sgx: Handle relocations in test enclave
  selftests/sgx: Fix linker script asserts
  selftests/sgx: Include memory clobber for inline asm in test enclave
  selftests/sgx: Ensure expected enclave data buffer size and placement
  selftests/sgx: Separate linker options
  selftests/sgx: Specify freestanding environment for enclave
    compilation

 tools/testing/selftests/sgx/Makefile          | 14 ++---
 tools/testing/selftests/sgx/sigstruct.c       |  5 +-
 tools/testing/selftests/sgx/test_encl.c       | 52 ++++++++++++-------
 tools/testing/selftests/sgx/test_encl.lds     | 11 ++--
 .../selftests/sgx/test_encl_bootstrap.S       | 12 ++---
 5 files changed, 56 insertions(+), 38 deletions(-)

-- 
2.34.1

