Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6B97C4D39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345457AbjJKIdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjJKIdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:33:18 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EB694
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:33:15 -0700 (PDT)
X-QQ-mid: bizesmtp79t1697013121tlm25yi8
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 11 Oct 2023 16:31:58 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: C46Rb8GPIEdRSjq04tLpVIm4rBqIg5ZDlkNPqFv6Y1o3yJcnC8ZRmxn2xUPbG
        5aqHDTFlNXyfj9EkRqGPEVLCeEME8D4N5AzoJUCDAT3UjzV5Z0ci7+03OQwZkTZLsqT64MD
        T3ppIzbnyfGx1e8sgzAkoZrig0RpTYyQD70vxYnOf7jHBi+18d9R9W2t1SXwMwkehA42LUA
        epsjv/QxJYlIW/iExD63iNaVCDclscyD3+WHo4bG0As7W+VaJPI7hyDtJ8Oa8EPnaD3XSoS
        KixdppXwX0rrquohicpmRPgk0rYlV8M8UJVN2n6X81C8Q48pgjLEM90fTs3637yXkF2X+5w
        rwxmvRrV2vPyRNqALNrym8K18haX46uW0fzwoZlSB7pU00ib60YvCmV0srlyg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15077306528228941013
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        lihuafei1@huawei.com, songshuaishuai@tinylab.org,
        petr.tesarik.ext@huawei.com, duwe@suse.de, ribalda@chromium.org,
        akpm@linux-foundation.org, keescook@chromium.org, hi@alyssa.is,
        heiko@sntech.de, alexghiti@rivosinc.com, schwab@suse.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH V2 0/2] riscv: kexec: cleanup and fixups
Date:   Wed, 11 Oct 2023 16:31:30 +0800
Message-Id: <20231011083132.2428720-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [43.155.65.254 listed in list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.155.65.254 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [43.155.65.254 listed in bl.score.senderscore.com]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.155.65.254 listed in wl.mailspike.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since V1:
https://lore.kernel.org/linux-riscv/20230907103304.590739-1-songshuaishuai@tinylab.org/

- the old Patch2 in V1 had been merged to riscv/fixes, so take it out of this series  
- Patch1 : replace `.align 2` with `.balign 4` as Andreas suggested
- Patch2 : fix the conflict caused by commit a72ab0361110 ("riscv/purgatory: Disable CFI")


riscv: kexec: Cleanup riscv_kexec_relocate (Patch1)
==================================================

For readability and simplicity, cleanup the riscv_kexec_relocate code:

 - Re-sort the first 4 `mv` instructions against `riscv_kexec_method()`
 - Eliminate registers for debugging (s9,s10,s11) and storing const-value (s5,s6)
 - Replace `jalr` with `jr` for no-link jump

riscv: kexec: Remove -fPIE for PURGATORY_CFLAGS (Patch2 : the Patch3 in V1)
==========================================================================

With CONFIG_RELOCATABLE enabled, KBUILD_CFLAGS had a -fPIE option
and then the purgatory/string.o was built to reference _ctype symbol
via R_RISCV_GOT_HI20 relocations which can't be handled by purgatory.

As a consequence, the kernel failed kexec_load_file() with:

[  880.386562] kexec_image: The entry point of kernel at 0x80200000
[  880.388650] kexec_image: Unknown rela relocation: 20
[  880.389173] kexec_image: Error loading purgatory ret=-8

So remove the -fPIE option for PURGATORY_CFLAGS to generate
R_RISCV_PCREL_HI20 relocations type making puragtory work as it was.

Song Shuai (2):
  riscv: kexec: Cleanup riscv_kexec_relocate
  riscv: kexec: Remove -fPIE for PURGATORY_CFLAGS

 arch/riscv/kernel/kexec_relocate.S | 54 +++++++++++++-----------------
 arch/riscv/purgatory/Makefile      |  4 +++
 2 files changed, 28 insertions(+), 30 deletions(-)

-- 
2.20.1

