Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602CC7E05DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344063AbjKCP5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjKCP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:57:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB884D4E;
        Fri,  3 Nov 2023 08:57:39 -0700 (PDT)
X-QQ-mid: bizesmtp78t1699027037tibjddzq
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 03 Nov 2023 23:57:14 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: QityeSR92A0CP7ledumJcL/YcFg/S2vCRasLnx4V41TLMZugGiWPhdXyRvEjd
        NU48y/mVScgRq0fQozHdMCgD4Xnou/kbN39qvapr+jCESqwElCbQD54Ib/JBgMdsLkB96UB
        M3jhs9MFqlqy2shevC4BLkj/hf6npz1vl8J6spTtbn4BVbDAnNWUHTcXRHaW/ppO0M60ae3
        Js6L8NjWL5oHz8R3iTbMVYCFm5OMNnFgs7EM1Y0lH9RFylCi3Krfhdqc9Ktp4e9UlZ63HNs
        TrnY+TU8JL/R1brTVWiAb6dX7W7wXxfeSF0XwINpSFbxJjKtpPiOusLQjvWJLBZWQJ2c1zF
        XvDr/++U8V9kUDk7qZmnFbFnnW+xV+++Cbc13mk
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3192958384466937205
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 00/14] DCE/DSE: Add Dead Syscalls Elimination support, part2
Date:   Fri,  3 Nov 2023 23:56:35 +0800
Message-Id: <cover.1699025537.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

This series aims to add Dead Code Elimination(DCE) based Dead Syscalls
Elimination(DSE) support, here is the RFC patchset[1]. The whole series
includes three parts, here is the Part2.

Part1 adds basic DCE based DSE support [5].

Part3 will add DSE test support with nolibc-test.c.

This Part2 further eliminates the unused syscalls forcely kept by the
exception tables. This is just a preliminary approach and requires a lot
of discussion and modifications.

Some syscalls use put_user()/get_user() to access memory from
user-space, the exception tables are added for such memory addresses to
fixup potential exceptions fairily.

These exception tables are added by the simple '.pushsection' directive
and there is no explicit section relationship between them and their
syscall functions, So, all of such tables are explicitly kept by the
KEEP() directive in vmlinux.lds, but such forcely KEEP() operations
prevent DCE from eliminating their syscall functions for the tables used
some addresses in their syscall functions, the insn and fixup addresses
(arch/riscv/include/asm/asm-extable.h) are from their syscall functions,
as a result, the ownership reverses.

To further eliminate such syscalls, we must fix up this ownership
reversal issue. At first, the KEEP() operations must be removed from
vmlinux.lds, but at the same time, we must find a way to tell ld the
real ownership between the syscalls and their exceptions tables.

Fortunately, under the guidance of Zhangjin Wu, I discovered that both
SHF_GROUP and SHF_LINK_ORDER can be helpful for such targets ([6] [7]
[8]), but the former method triggers a warning from as. The binary files
compiled using both methods turn out to be identical. So maybe we just
choose the later one?

This series adds a very elementary level of patchset to demonstate how
to use them to drop KEEP() for all of the exception tables, only for
RISC-V currently.

This may also be a good start for us to rethink the widely used KEEP().
This approach can thoroughly eliminate orphan sections, providing the
compiler with more information. Eventually, most of the KEEP() calls
can be eliminated.

The nolibc-test based initrd run well on riscv64 kernel image with dead
syscalls eliminated:

    $ nm build/riscv64/virt/linux/v6.6-rc2/vmlinux | grep "T __riscv_sys" | grep -v sys_ni_syscall | wc -l
    40

These options should be enabled:

    CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
    CONFIG_LD_DEAD_CODE_DATA_ELIMINATION_DEBUG=y
    CONFIG_TRIM_UNUSED_SYSCALLS=y
    CONFIG_SECTION_SHF_LINK_ORDER_SUPPORT=y
    CONFIG_USED_SYSCALLS="sys_dup sys_dup3 sys_ioctl sys_mknodat sys_mkdirat sys_unlinkat sys_symlinkat sys_linkat sys_mount sys_chdir sys_chroot sys_fchmodat sys_fchownat sys_openat sys_close sys_pipe2 sys_getdents64 sys_lseek sys_read sys_write sys_pselect6 sys_ppoll sys_exit sys_sched_yield sys_kill sys_reboot sys_getpgid sys_prctl sys_gettimeofday sys_getpid sys_getppid sys_getuid sys_geteuid sys_brk sys_munmap sys_clone sys_execve sys_mmap sys_wait4 sys_statx"

Or using section group intead of section link order:

    CONFIG_SECTION_SHF_GROUP_SUPPORT=y

Thanks to Song Fangrui's idea [9] of SHF_LINK_ORDER. To be honest, this
part is hard to understand, and there may be some mistakes in my
solutions. Welcome your further advice. :)

Besides, I want to express my thanks to Zhangjin Wu, Zhiming Xu, Anqi
Xiao, Jun Kong, and Yuzhe Ling for their help during the investigation
stage.

Best Regards,
Yuan Tan

---
[1]: https://lore.kernel.org/lkml/cover.1676594211.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/lkml/234017be6d06ef84844583230542e31068fa3685.1676594211.git.falcon@tinylab.org/
[3]: https://lore.kernel.org/lkml/CAFP8O3+41QFVyNTVJ2iZYkB0tqnvdLTAoGShgGy-qPP1PHjBEw@mail.gmail.com/
[4]: https://lore.kernel.org/lkml/cbcbfbb37cabfd9aed6088c75515e4ea86006cff.1676594211.git.falcon@tinylab.org/
[5]: https://lore.kernel.org/lkml/cover.1695679700.git.falcon@tinylab.org/
[6]: https://maskray.me/blog/2021-07-25-comdat-and-section-group
[7]: https://maskray.me/blog/2021-01-31-metadata-sections-comdat-and-shf-link-order
[8]: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html
[9]: https://sourceware.org/pipermail/binutils/2023-July/128521.html

Yuan Tan (10):
  DCE/DSE: add HAVE_SECTION_SHF_LINK_ORDER_SUPPORT option
  DCE/DSE: add HAVE_SECTION_SHF_GROUP_SUPPORT option
  DCE/DSE: add HAVE_SECTION_NO_KEEP_SUPPORT option
  DCE/DSE: add choice of methods to build reference for orphan sections
  DCE/DSE: inhibit .size directive for SHF_GROUP
  DCE/DSE: riscv: make every ex_table's name unique
  DCE/DSE: riscv: build reference for .pushsection in C functions
  DCE/DSE: riscv: build reference for .pushsection in assembly
  DCE/DSE: add SECTION_NO_KEEP_SUPPORT option
  DCE/DSE: vmlinux.lds.h: allow NO_KEEP on __ex_table sections

Zhangjin Wu (4):
  DCE/DSE: allow keep unique bounded sections
  compiler: add a global __QUITE_UNIQUE_ID()
  compiler: add unique __SECTION_NAME()
  compiler: add unique LABEL_NAME()

 Makefile                             |  3 ++
 arch/riscv/include/asm/asm-extable.h | 43 +++++++++++++---
 arch/riscv/lib/uaccess.S             | 60 +++++++++++-----------
 include/asm-generic/vmlinux.lds.h    | 28 ++++++++---
 include/linux/compiler.h             | 25 ++++++++++
 include/linux/compiler_types.h       |  8 +--
 init/Kconfig                         | 74 ++++++++++++++++++++++++++++
 7 files changed, 193 insertions(+), 48 deletions(-)

-- 
2.34.1

