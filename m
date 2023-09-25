Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD2F7AE1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjIYWeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIYWeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:34:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C2B120;
        Mon, 25 Sep 2023 15:33:57 -0700 (PDT)
X-QQ-mid: bizesmtp81t1695681226tcihg9u5
Received: from linux-lab-host.localdomain ( [116.30.124.152])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 26 Sep 2023 06:33:44 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000B00A0000000
X-QQ-FEAT: mRz6/7wsmIhEdtJxEM3+86IjQT+Q2BIK68FoSWVkt5uacFvPZnMVGdTic5nTs
        yFZ0ibzgKsflWJT5L40MNO8tEShlHRSZXfPwo1fDK1vqatDKo41I1IcSCrqiVhPV3R730IR
        pGGbPSYS+zsSxMPHTdxpa5tYEQ5bid0+GVFXPgKxc958NIK+3X2yS09DZdjKtvv+ZgGgu7o
        TjD9ZGoNdbjLgdkWbeFwPWuG3Ix9bFnm9YzgcMo2/xX+um7cPVbTgxCUiYcCO1ji2JSBSDg
        W1QAoXySxRkRiichVOSgMt1ehzqHAV2HQiK/pIpW8o7df+gBQPQwGFGwlddP3v0GSA2kNcT
        V2gskPCLhmWYivb0+S/GRjN4K3Tpg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1329585511254707149
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Cc:     falcon@tinylab.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        paulburton@kernel.org, paulmck@kernel.org,
        tsbogend@alpha.franken.de, w@1wt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Tim Bird <tim.bird@sony.com>
Subject: [PATCH v1 0/7] DCE/DSE: Add Dead Syscalls Elimination support, part1
Date:   Tue, 26 Sep 2023 06:33:44 +0800
Message-Id: <cover.1695679700.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

This series aims to add DCE based DSE support, here is the first
revision of the RFC patchset [1], the whole series includes three parts,
here is the Part1.

This Part1 adds basic DCE based DSE support.

Part2 will further eliminate the unused syscalls forcely kept by the
exception tables.

Part3 will add DSE test support with nolibc-test.c.

Changes from RFC patchset [1]:

- The DCE support [2] for RISC-V has been merged [3]
- The "nolibc: Record used syscalls in their own sections" [4] will be
  delayed to Part3

- Add debug support for DCE
- Further allows CONFIG_USED_SYSCALLS accept a file stores used syscalls
- Now, only accepts symbolic syscalls, not support integral number again
- Works with newly added riscv syscalls suffix: __riscv_
- Further trims the syscall tables by removing the tailing invalid parts

The nolibc-test based initrd run well on riscv64 kernel image with dead
syscalls eliminated:

    $ nm build/riscv64/virt/linux/v6.6-rc2/vmlinux | grep "T __riscv_sys" | grep -v sys_ni_syscall | wc -l
    48

These options should be enabled:

    CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
    CONFIG_LD_DEAD_CODE_DATA_ELIMINATION_DEBUG=y
    CONFIG_TRIM_UNUSED_SYSCALLS=y
    CONFIG_USED_SYSCALLS="sys_dup sys_dup3 sys_ioctl sys_mknodat sys_mkdirat sys_unlinkat sys_symlinkat sys_linkat sys_mount sys_chdir sys_chroot sys_fchmodat sys_fchownat sys_openat sys_close sys_pipe2 sys_getdents64 sys_lseek sys_read sys_write sys_pselect6 sys_ppoll sys_exit sys_sched_yield sys_kill sys_reboot sys_getpgid sys_prctl sys_gettimeofday sys_getpid sys_getppid sys_getuid sys_geteuid sys_brk sys_munmap sys_clone sys_execve sys_mmap sys_wait4 sys_statx"

The really used syscalls:

    $ echo "sys_dup sys_dup3 sys_ioctl sys_mknodat sys_mkdirat sys_unlinkat sys_symlinkat sys_linkat sys_mount sys_chdir sys_chroot sys_fchmodat sys_fchownat sys_openat sys_close sys_pipe2 sys_getdents64 sys_lseek sys_read sys_write sys_pselect6 sys_ppoll sys_exit sys_sched_yield sys_kill sys_reboot sys_getpgid sys_prctl sys_gettimeofday sys_getpid sys_getppid sys_getuid sys_geteuid sys_brk sys_munmap sys_clone sys_execve sys_mmap sys_wait4 sys_statx" | tr ' ' '\n' | wc -l
    40

Thanks to Yuan Tan, he has researched and verified the elimination of
the unused syscalls forcely kept by the exception tables, both section
group and section link order attributes of ld work. part2 will be sent
out soon to further remove another 8 unused syscalls and eventually we
are able to run a dead loop application on a kernel image without
syscalls.

Best Regards,
Zhangjin Wu

---
[1]: https://lore.kernel.org/lkml/cover.1676594211.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/lkml/234017be6d06ef84844583230542e31068fa3685.1676594211.git.falcon@tinylab.org/
[3]: https://lore.kernel.org/lkml/CAFP8O3+41QFVyNTVJ2iZYkB0tqnvdLTAoGShgGy-qPP1PHjBEw@mail.gmail.com/
[4]: https://lore.kernel.org/lkml/cbcbfbb37cabfd9aed6088c75515e4ea86006cff.1676594211.git.falcon@tinylab.org/

Zhangjin Wu (7):
  DCE: add debug support
  DCE/DSE: add unused syscalls elimination configure support
  DCE/DSE: Add a new scripts/Makefile.syscalls
  DCE/DSE: mips: add HAVE_TRIM_UNUSED_SYSCALLS support
  DCE/DSE: riscv: move syscall tables to syscalls/
  DCE/DSE: riscv: add HAVE_TRIM_UNUSED_SYSCALLS support
  DCE/DSE: riscv: trim syscall tables

 Makefile                                      |  3 +
 arch/mips/Kconfig                             |  1 +
 arch/mips/kernel/syscalls/Makefile            | 23 ++++++-
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/include/asm/unistd.h               |  2 +
 arch/riscv/kernel/Makefile                    |  7 +-
 arch/riscv/kernel/syscalls/Makefile           | 69 +++++++++++++++++++
 .../{ => syscalls}/compat_syscall_table.c     |  4 +-
 .../kernel/{ => syscalls}/syscall_table.c     |  4 +-
 init/Kconfig                                  | 49 +++++++++++++
 scripts/Makefile.syscalls                     | 29 ++++++++
 11 files changed, 182 insertions(+), 10 deletions(-)
 create mode 100644 arch/riscv/kernel/syscalls/Makefile
 rename arch/riscv/kernel/{ => syscalls}/compat_syscall_table.c (82%)
 rename arch/riscv/kernel/{ => syscalls}/syscall_table.c (83%)
 create mode 100644 scripts/Makefile.syscalls

-- 
2.25.1

