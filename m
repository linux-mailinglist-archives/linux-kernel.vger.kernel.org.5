Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C1979F78B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjINCHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjINCH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:07:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163904EE7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:02:51 -0700 (PDT)
X-QQ-mid: bizesmtp69t1694656877tkm2a5m8
Received: from localhost.localdomain ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 10:01:14 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: bGXn9C6ahgSFte9kYhPmrslHZ6ZrQ+TnZx/ZE2jZlE4PHgLAwcln8WNX1+A1c
        C1vyx8Oc6uEVovocZqkT/MoY5qndYu4a3nXAuvHwIkpMYiG9X0AAbsoREF3pkmuVmZrqd8L
        uNTQf8tW/tMk0GWnAXrtgwUQYTJt95HkP+Xa3Gg0h8/htQEIs+TVLjB/lsHmh60DgcS4vVZ
        jdVdz1AVhprtauD5HgZbMWMhSm3yhlXzeX6QutZRtSojm2nZx9CFyRcTrPjERlyXUhTmLxa
        hUSuj4w9Nhsmm6+gsKn/evcMHtsgh7wqkNQKHuCmDBwb9Twfk0VMqUDF10BgCRGj7IvClFT
        oMPLmf1R2iasSXKV8QMAzN6zznWKw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 930282796024689414
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, lihuafei1@huawei.com,
        conor.dooley@microchip.com, liaochang1@huawei.com,
        guoren@kernel.org, ajones@ventanamicro.com, alexghiti@rivosinc.com,
        evan@rivosinc.com, sunilvl@ventanamicro.com,
        xianting.tian@linux.alibaba.com, samitolvanen@google.com,
        masahiroy@kernel.org, apatel@ventanamicro.com, jszhang@kernel.org,
        duwe@suse.de, eric.devolder@oracle.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 0/2] riscv: kexec_file: Support loading Image binary file
Date:   Thu, 14 Sep 2023 10:00:42 +0800
Message-Id: <20230914020044.1397356-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series makes the kexec_file_load() syscall support to load Image binary file.
At the same time, corresponding support for kexec-tools had been pushed to my repo[1].

Now, we can leverage that kexec-tools and this series to use the
kexec_load() or kexec_file_load() syscall to boot both vmlinux 
and Image file, as seen in these combo tests:

```
1. kexec -l vmlinux [other options] // or boot paniced kernel with -p
2. kexec -l Image
3. kexec -s -l vmlinux
4. kexec -s -l Image
```

Though all of the aforementioned tests had been passed in my RV64 Qemu-virt, 
it should be noted that tests 3 and 4 should be the emphasis for the current series.

[1]: https://github.com/sugarfillet/kexec-tools/commits/rv-Image

Song Shuai (2):
  riscv: kexec_file: Split the loading of kernel and others
  riscv: kexec_file: Support loading Image binary file

 arch/riscv/include/asm/image.h         |   2 +
 arch/riscv/include/asm/kexec.h         |   6 +
 arch/riscv/kernel/Makefile             |   2 +-
 arch/riscv/kernel/elf_kexec.c          | 469 -------------------------
 arch/riscv/kernel/kexec_elf.c          | 147 ++++++++
 arch/riscv/kernel/kexec_image.c        |  97 +++++
 arch/riscv/kernel/machine_kexec_file.c |   8 +
 7 files changed, 261 insertions(+), 470 deletions(-)
 delete mode 100644 arch/riscv/kernel/elf_kexec.c
 create mode 100644 arch/riscv/kernel/kexec_elf.c
 create mode 100644 arch/riscv/kernel/kexec_image.c

-- 
2.20.1

