Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE897CA3F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjJPJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjJPJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:22:12 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD96E5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:22:09 -0700 (PDT)
X-QQ-mid: bizesmtp85t1697448051t2qrh9s3
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 16 Oct 2023 17:20:49 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: +ynUkgUhZJlVc3kFfT+1lBpfK0izFpSoNY1pnrylEBByyYspKiXE/AgA3x7Ls
        yC72wOYrvN3mhA1pzeSi1pVqISzz9CMx4sfMzginYyIsvBnTXdKa6MkD3cmbjEMDP2YAOIP
        PzCE9tIe8ANyTd1+A7kgPRnByublFgi3aqk67Y/pSRz+9/P8jMD0EMKp5MPizV48oZNU+z+
        LWk1S3MIb/cpK9Mrmmbivt2C3Jno/PafxUxwOgoQ68hroRPBjGYoibZUXtz0TZcFJteCmZn
        WXuy1lLz40FSY5NT06iLkuxfd9c5NG5Sy2CzMQdyupSqRSZ8xoRcHiB9l38MOsVtx6/ORxd
        XFWPENX7QYjichTMVx1xTFsEOri2ZKKarEtlYA29kuG+AZ2+6ZTMBcV8btzkA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2059464602555490170
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, lihuafei1@huawei.com,
        conor.dooley@microchip.com, liaochang1@huawei.com,
        guoren@kernel.org, ajones@ventanamicro.com, alexghiti@rivosinc.com,
        evan@rivosinc.com, sunilvl@ventanamicro.com,
        xianting.tian@linux.alibaba.com, samitolvanen@google.com,
        masahiroy@kernel.org, apatel@ventanamicro.com, jszhang@kernel.org,
        duwe@suse.de, eric.devolder@oracle.com,
        emil.renner.berthing@canonical.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH V2 0/2] riscv: kexec_file: Support loading Image binary file
Date:   Mon, 16 Oct 2023 17:20:04 +0800
Message-Id: <20231016092006.3347632-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since V1:
https://lore.kernel.org/linux-riscv/20230914020044.1397356-1-songshuaishuai@tinylab.org/

- Patch1: fix the build error due to the missing functions in machine_kexec_file.c
- Patch2: use FIELD_GET() to get the flags's endianness as Emil proposed
- Cover: update the kexec-tools link as this one[2] which is based on horms/kexec-tools main branch

This series makes the kexec_file_load() syscall support to load Image binary file.
At the same time, corresponding support for kexec-tools had been pushed to my repo[2].

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

~~[1]: https://github.com/sugarfillet/kexec-tools/commits/rv-Image~~
[2]: https://github.com/sugarfillet/kexec-tools/commits/main_rv

Song Shuai (2):
  riscv: kexec_file: Split the loading of kernel and others
  riscv: kexec_file: Support loading Image binary file

 arch/riscv/include/asm/kexec.h         |   6 +
 arch/riscv/kernel/Makefile             |   2 +-
 arch/riscv/kernel/elf_kexec.c          | 469 -------------------------
 arch/riscv/kernel/kexec_elf.c          | 147 ++++++++
 arch/riscv/kernel/kexec_image.c        |  98 ++++++
 arch/riscv/kernel/machine_kexec_file.c | 344 ++++++++++++++++++
 6 files changed, 596 insertions(+), 470 deletions(-)
 delete mode 100644 arch/riscv/kernel/elf_kexec.c
 create mode 100644 arch/riscv/kernel/kexec_elf.c
 create mode 100644 arch/riscv/kernel/kexec_image.c

-- 
2.20.1

