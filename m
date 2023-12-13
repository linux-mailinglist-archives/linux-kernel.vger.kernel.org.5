Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38E2810E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjLMK1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjLMK1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:27:05 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650EDE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:27:09 -0800 (PST)
X-QQ-mid: bizesmtp79t1702463167tcr6ufva
Received: from [10.4.6.71] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 13 Dec 2023 18:26:02 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: hoArX50alxEwBXgz7H828rQPfU4yCvC4EsFNNxEEJw9G+Qj6wXQGud/XnpIeu
        gzsjzr7vzPbJdkTk7qpCyHhAXmN6jsoOMT6g5nDU/+/oXwJCQXaFLBKP2t52SEDxqnZV7jM
        LO7odQU8OgeMDCiBukYm3Qj3gDWvNQS00C5P3OYGX7XfzyTwW25djjB2AAAHwafzTGVBT42
        2GXhZMmLANroa6P8eXuDmRuHBW1qawrpw+WNDoYf7/02e0ySkvPrE9LdsBN0Jf9xxBE00lT
        Mp8i9YaSLZfixre13lDKyjJh63qGtZgJtYcGazaGhR0aIbH0cZP7SGovFgoSmg+4Y0pLMyL
        T6suoB3IITd8Y7IA1iXkYe8XM8v+UJYB87XFdVrn1p2Zo93qzlQ6351rbbH5Q==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2304332684790857452
Message-ID: <F2DEAEC9AF268DB2+dab1e766-962a-de7a-4b89-0498a43d177d@tinylab.org>
Date:   Wed, 13 Dec 2023 18:26:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V2 0/2] riscv: kexec_file: Support loading Image binary
 file
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, lihuafei1@huawei.com,
        conor.dooley@microchip.com, liaochang1@huawei.com,
        guoren@kernel.org, ajones@ventanamicro.com, alexghiti@rivosinc.com,
        evan@rivosinc.com, sunilvl@ventanamicro.com,
        xianting.tian@linux.alibaba.com, samitolvanen@google.com,
        masahiroy@kernel.org, apatel@ventanamicro.com, jszhang@kernel.org,
        duwe@suse.de, eric.devolder@oracle.com,
        emil.renner.berthing@canonical.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231016092006.3347632-1-songshuaishuai@tinylab.org>
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <20231016092006.3347632-1-songshuaishuai@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/16 17:20, Song Shuai 写道:
> Changes since V1:
> https://lore.kernel.org/linux-riscv/20230914020044.1397356-1-songshuaishuai@tinylab.org/
> 
> - Patch1: fix the build error due to the missing functions in machine_kexec_file.c
> - Patch2: use FIELD_GET() to get the flags's endianness as Emil proposed
> - Cover: update the kexec-tools link as this one[2] which is based on horms/kexec-tools main branch
ping ...
> 
> This series makes the kexec_file_load() syscall support to load Image binary file.
> At the same time, corresponding support for kexec-tools had been pushed to my repo[2].
> 
> Now, we can leverage that kexec-tools and this series to use the
> kexec_load() or kexec_file_load() syscall to boot both vmlinux
> and Image file, as seen in these combo tests:
> 
> ```
> 1. kexec -l vmlinux [other options] // or boot paniced kernel with -p
> 2. kexec -l Image
> 3. kexec -s -l vmlinux
> 4. kexec -s -l Image
> ```
> 
> Though all of the aforementioned tests had been passed in my RV64 Qemu-virt,
> it should be noted that tests 3 and 4 should be the emphasis for the current series.
> 
> ~~[1]: https://github.com/sugarfillet/kexec-tools/commits/rv-Image~~
> [2]: https://github.com/sugarfillet/kexec-tools/commits/main_rv
> 
> Song Shuai (2):
>    riscv: kexec_file: Split the loading of kernel and others
>    riscv: kexec_file: Support loading Image binary file
> 
>   arch/riscv/include/asm/kexec.h         |   6 +
>   arch/riscv/kernel/Makefile             |   2 +-
>   arch/riscv/kernel/elf_kexec.c          | 469 -------------------------
>   arch/riscv/kernel/kexec_elf.c          | 147 ++++++++
>   arch/riscv/kernel/kexec_image.c        |  98 ++++++
>   arch/riscv/kernel/machine_kexec_file.c | 344 ++++++++++++++++++
>   6 files changed, 596 insertions(+), 470 deletions(-)
>   delete mode 100644 arch/riscv/kernel/elf_kexec.c
>   create mode 100644 arch/riscv/kernel/kexec_elf.c
>   create mode 100644 arch/riscv/kernel/kexec_image.c
> 

-- 
Thanks
Song Shuai
