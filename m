Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ACC75FCC4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGXQ66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGXQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:58:54 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EBA10D3;
        Mon, 24 Jul 2023 09:58:52 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 808CF2005A.A7B65
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 808CF2005A;
        Mon, 24 Jul 2023 18:58:47 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1690217927;
        bh=NZrK4upsQWc72FgG2AZrNbv39CPwxqwV2mK7HIEmAnU=;
        h=From:To:Cc:Subject:Date;
        b=LElmUfDyabxN/V9rLKGCjMkn0ww8OCSM90pDY41Ol2audhjsib1n21WcvWooWIsi8
         4f8kCyWtJHvjqlUFMbS8dK6imDeeThrnT0R1yYMmQ6eboodGx++Z60XP7YO0/lSOdW
         K8PUC5LQjbaPt+F3AwHAwvU1CYPCz62mL2xWitZo=
Received: from librem.epfl.ch (eduroam-269-1-126.epfl.ch [192.33.197.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 4F129D4ECBC84;
        Mon, 24 Jul 2023 18:58:47 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 0/5] selftests/sgx: Fix compilation errors.
Date:   Mon, 24 Jul 2023 18:58:27 +0200
Message-Id: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series ensures that all SGX selftests succeed when compiling
with optimizations (as tested with -O{0,1,2,3,s} for both gcc 11.3.0 and
clang 14.0.0). The aim of the patches is to avoid reliance on undefined,
compiler-specific behavior that can make the test results fragile.

If deemed useful, I can also include an elementary wrapper shell script to
compile and run the tests for different compilers (gcc/clang) and
optimization levels.

Best,
Jo

Jo Van Bulck (5):
  selftests/sgx: Fix uninitialized pointer dereference in error path.
  selftests/sgx: Fix function pointer relocation in test enclave.
  selftests/sgx: Ensure correct secinfo struct alignment in test
    enclave.
  selftests/sgx: Ensure expected enclave data buffer size and placement.
  selftests/sgx: Enclave freestanding compilation + separate linker
    options.

 tools/testing/selftests/sgx/Makefile            | 12 +++++++-----
 tools/testing/selftests/sgx/sigstruct.c         |  2 +-
 tools/testing/selftests/sgx/test_encl.c         | 17 +++++++++++------
 tools/testing/selftests/sgx/test_encl.lds       |  2 ++
 .../testing/selftests/sgx/test_encl_bootstrap.S |  5 +++++
 5 files changed, 26 insertions(+), 12 deletions(-)


base-commit: ad0dbc1609ab4b01c9c423d3dd6bb6e4f19dee70
-- 
2.34.1

