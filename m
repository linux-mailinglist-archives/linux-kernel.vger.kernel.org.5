Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A463C802473
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 15:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjLCOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 09:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCOKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 09:10:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3DA90
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 06:10:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F48BC433C9;
        Sun,  3 Dec 2023 14:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701612627;
        bh=QZ+9c3MhqDU0C1Ei9+Fc5gRRLMVSExYSRe6oAlwtRlM=;
        h=From:To:Cc:Subject:Date:From;
        b=sglyprX5e81KPNAgEajlkRuYjgMk4GCbCkUVSK6gfxEzfdj9KE/RvF/zYZqgLpRe/
         GB3E565v+J9TjzAIgE66mkD9YNMIi7wvJylmWf8SzsYqMpPetVyxDErovpepry7G9f
         jZvuDMzTz1oIZdrLGIkJa6L3n5a+O47WqNTg5dRbeN5WJSLq8TjFn9Y8uWSCDyfgvh
         geZSbBmGWVPpYZpjxQ11SXyRwQLIvK7zTDAXfi876Mk+EA6LIOVT8ZKkSXGJspJvU7
         MDg02EBgqozaU0OZd8mOe24EDDUxykxUrsrYUU0v8A6L/+VIzEjvolKaTRIBo46YKq
         7P4MW0OkXmXZg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] riscv: enable EFFICIENT_UNALIGNED_ACCESS and DCACHE_WORD_ACCESS
Date:   Sun,  3 Dec 2023 21:57:51 +0800
Message-Id: <20231203135753.1575-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some riscv implementations such as T-HEAD's C906, C908, C910 and C920
support efficient unaligned access, for performance reason we want
to enable HAVE_EFFICIENT_UNALIGNED_ACCESS on these platforms. To
avoid performance regressions on non efficient unaligned access
platforms, HAVE_EFFICIENT_UNALIGNED_ACCESS can't be globally selected.

To solve this problem, runtime code patching based on the detected
speed is a good solution. But that's not easy, it involves lots of
work to modify vairous subsystems such as net, mm, lib and so on.
This can be done step by step.

So let's take an easier solution: add support to efficient unaligned
access and hide the support under NONPORTABLE.

patch1 introduces RISCV_EFFICIENT_UNALIGNED_ACCESS which depends on
NONPORTABLE, if users know during config time that the kernel will be
only run on those efficient unaligned access hw platforms, they can
enable it. Obviously, generic unified kernel Image shouldn't enable it.

patch2 adds support DCACHE_WORD_ACCESS when MMU and
RISCV_EFFICIENT_UNALIGNED_ACCESS.

Below test program and step shows how much performance can be improved:

 $ cat tt.c
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>

 #define ITERATIONS 1000000

 #define PATH "123456781234567812345678123456781"

 int main(void)
 {
         unsigned long i;
         struct stat buf;

         for (i = 0; i < ITERATIONS; i++)
                 stat(PATH, &buf);

         return 0;
 }

 $ gcc -O2 tt.c
 $ touch 123456781234567812345678123456781
 $ time ./a.out

Per my test on T-HEAD C910 platforms, the above test performance is
improved by about 7.5%.

Since v1:
  - fix typo in commit msg
  - fix build error if NOMMU

Jisheng Zhang (2):
  riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
  riscv: select DCACHE_WORD_ACCESS for efficient unaligned access HW

 arch/riscv/Kconfig                      | 13 +++++++++++
 arch/riscv/include/asm/asm-extable.h    | 15 ++++++++++++
 arch/riscv/include/asm/word-at-a-time.h | 27 +++++++++++++++++++++
 arch/riscv/mm/extable.c                 | 31 +++++++++++++++++++++++++
 4 files changed, 86 insertions(+)

-- 
2.42.0

