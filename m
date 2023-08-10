Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96A3777AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjHJOYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjHJOYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE82E4B;
        Thu, 10 Aug 2023 07:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8238465DEC;
        Thu, 10 Aug 2023 14:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DA9C433C7;
        Thu, 10 Aug 2023 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677484;
        bh=8LWcx+IlJfknXjQL350GNL29AdKspQPSIRVhseS1lkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZfjDiGQ/9d8bPoEeZBIv+iyYTx5hnCYbQIEeb3M4lu45DFUtn3CcrUdNhk+j3MJB
         7mD1S394Bhufd1xc21NWQD1hYdbiGhezZIiXpOKCjt7qQ4CIFQSRrrV9fu7aEnuOny
         D6/+7soD9bU3TfolwdYQyGSoBLiFsIrsTBjwo9tJlHd6avApzTk0+9hncIb5smgVnQ
         Ucl2UrzjcepyCJzAHZasVd2Mj5SZyqlnWUPpqcedPLhyC1KhaHzmLfadjolf4D3cDw
         5REN5bve4WltLoI3gWeCQ2EuCQ/ht5QYvCcl8KksxWxnowvhylAOGxDNJbrgcaXI4D
         5ILQnPfkuftCg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Youling Tang <tangyouling@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Xin Li <xin3.li@intel.com>, Nhat Pham <nphamcs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off conditionally
Date:   Thu, 10 Aug 2023 16:19:34 +0200
Message-Id: <20230810141947.1236730-17-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I have cleaned up the -Wmissing-prototypes warnings for most of the major architectures
as well as all drivers that get enabled for CONFIG_COMPILE_TEST, so now these should be
close to fixed on x86, arm, arm64, powerpc, s390, and riscv.

The other architectures tend to have a lot of these warning in architecture specific
code, primarily from functions that are only called from assembler code and do
not otherwise need a declaration but still cause a warning without one. Other cases
are simply functions that should just be static or are missing an #include statement.

In order to be able to turn the warning on globally by default without breaking all
these architectures, add a list of exceptions for architecture directories that
can revert back to the old behavior of not warning based on a new
CONFIG_WNO_MISSING_PROTOTYPES option.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Below is the full list of warnings I see in defconfig builds for reference, these
do not need to be part of the changelog.

arch/alpha/include/asm/core_t2.h:465:20: error: no previous prototype for 't2_readb' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:476:21: error: no previous prototype for 't2_readw' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:491:21: error: no previous prototype for 't2_readl' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:502:21: error: no previous prototype for 't2_readq' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:515:22: error: no previous prototype for 't2_writeb' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:526:22: error: no previous prototype for 't2_writew' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:541:22: error: no previous prototype for 't2_writel' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:550:22: error: no previous prototype for 't2_writeq' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:562:31: error: no previous prototype for 't2_ioportmap' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:567:31: error: no previous prototype for 't2_ioremap' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:573:21: error: no previous prototype for 't2_is_ioaddr' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:578:21: error: no previous prototype for 't2_is_mmio' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:587:23: error: no previous prototype for 't2_ioread16' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:587:23: error: no previous prototype for 't2_ioread32' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:587:23: error: no previous prototype for 't2_ioread64' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:587:23: error: no previous prototype for 't2_ioread8' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:594:22: error: no previous prototype for 't2_iowrite16' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:594:22: error: no previous prototype for 't2_iowrite32' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:594:22: error: no previous prototype for 't2_iowrite64' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:594:22: error: no previous prototype for 't2_iowrite8' [-Werror=missing-prototypes]
arch/alpha/include/asm/core_t2.h:614:33: error: no previous prototype for 't2_iounmap' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:115:30: error: no previous prototype for 'jensen_local_inb' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:120:22: error: no previous prototype for 'jensen_local_outb' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:126:30: error: no previous prototype for 'jensen_bus_inb' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:135:22: error: no previous prototype for 'jensen_bus_outb' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:155:20: error: no previous prototype for 'jensen_inb' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:163:22: error: no previous prototype for 'jensen_outb' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:171:21: error: no previous prototype for 'jensen_inw' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:181:21: error: no previous prototype for 'jensen_inl' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:187:21: error: no previous prototype for 'jensen_inq' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:193:22: error: no previous prototype for 'jensen_outw' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:200:22: error: no previous prototype for 'jensen_outl' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:207:22: error: no previous prototype for 'jensen_outq' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:218:20: error: no previous prototype for 'jensen_readb' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:230:21: error: no previous prototype for 'jensen_readw' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:242:21: error: no previous prototype for 'jensen_readl' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:250:21: error: no previous prototype for 'jensen_readq' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:263:22: error: no previous prototype for 'jensen_writeb' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:271:22: error: no previous prototype for 'jensen_writew' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:279:22: error: no previous prototype for 'jensen_writel' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:287:22: error: no previous prototype for 'jensen_writeq' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:297:31: error: no previous prototype for 'jensen_ioportmap' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:302:31: error: no previous prototype for 'jensen_ioremap' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:308:21: error: no previous prototype for 'jensen_is_ioaddr' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:313:21: error: no previous prototype for 'jensen_is_mmio' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:322:23: error: no previous prototype for 'jensen_ioread16' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:322:23: error: no previous prototype for 'jensen_ioread32' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:322:23: error: no previous prototype for 'jensen_ioread64' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:322:23: error: no previous prototype for 'jensen_ioread8' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:329:22: error: no previous prototype for 'jensen_iowrite16' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:329:22: error: no previous prototype for 'jensen_iowrite32' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:329:22: error: no previous prototype for 'jensen_iowrite64' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:329:22: error: no previous prototype for 'jensen_iowrite8' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:348:33: error: no previous prototype for 'jensen_iounmap' [-Werror=missing-prototypes]
arch/alpha/include/asm/jensen.h:92:22: error: no previous prototype for 'jensen_set_hae' [-Werror=missing-prototypes]
arch/alpha/kernel/bugs.c:19:9: error: no previous prototype for 'cpu_show_meltdown' [-Werror=missing-prototypes]
arch/alpha/kernel/bugs.c:28:9: error: no previous prototype for 'cpu_show_spectre_v1' [-Werror=missing-prototypes]
arch/alpha/kernel/bugs.c:37:9: error: no previous prototype for 'cpu_show_spectre_v2' [-Werror=missing-prototypes]
arch/alpha/kernel/console.c:39:1: error: no previous prototype for 'locate_and_init_vga' [-Werror=missing-prototypes]
arch/alpha/kernel/console.c:72:1: error: no previous prototype for 'find_console_vga_hose' [-Werror=missing-prototypes]
arch/alpha/kernel/core_cia.c:284:1: error: no previous prototype for 'cia_pci_tbi_try2' [-Werror=missing-prototypes]
arch/alpha/kernel/core_cia.c:580:1: error: no previous prototype for 'cia_save_srm_settings' [-Werror=missing-prototypes]
arch/alpha/kernel/core_cia.c:606:1: error: no previous prototype for 'cia_restore_srm_settings' [-Werror=missing-prototypes]
arch/alpha/kernel/core_lca.c:481:1: error: no previous prototype for 'lca_clock_print' [-Werror=missing-prototypes]
arch/alpha/kernel/core_lca.c:498:1: error: no previous prototype for 'lca_get_clock' [-Werror=missing-prototypes]
arch/alpha/kernel/core_lca.c:508:1: error: no previous prototype for 'lca_clock_fiddle' [-Werror=missing-prototypes]
arch/alpha/kernel/io.c:654:1: error: no previous prototype for 'scr_memcpyw' [-Werror=missing-prototypes]
arch/alpha/kernel/irq.c:96:1: error: no previous prototype for 'handle_irq' [-Werror=missing-prototypes]
arch/alpha/kernel/irq_alpha.c:45:1: error: no previous prototype for 'do_entInt' [-Werror=missing-prototypes]
arch/alpha/kernel/pci.c:285:1: error: no previous prototype for 'pcibios_claim_one_bus' [-Werror=missing-prototypes]
arch/alpha/kernel/ptrace.c:322:26: error: no previous prototype for 'syscall_trace_enter' [-Werror=missing-prototypes]
arch/alpha/kernel/ptrace.c:334:1: error: no previous prototype for 'syscall_trace_leave' [-Werror=missing-prototypes]
arch/alpha/kernel/signal.c:205:1: error: no previous prototype for 'do_sigreturn' [-Werror=missing-prototypes]
arch/alpha/kernel/signal.c:233:1: error: no previous prototype for 'do_rt_sigreturn' [-Werror=missing-prototypes]
arch/alpha/kernel/signal.c:523:1: error: no previous prototype for 'do_work_pending' [-Werror=missing-prototypes]
arch/alpha/kernel/smc37c669.c:2434:1: error: no previous prototype for 'SMC37c669_dump_registers' [-Werror=missing-prototypes]
arch/alpha/kernel/smc37c669.c:2467:13: error: no previous prototype for 'SMC669_Init' [-Werror=missing-prototypes]
arch/alpha/kernel/smc37c93x.c:238:12: error: no previous prototype for 'SMC93x_Init' [-Werror=missing-prototypes]
arch/alpha/kernel/srmcons.c:272:1: error: no previous prototype for 'register_srm_console' [-Werror=missing-prototypes]
arch/alpha/kernel/srmcons.c:282:1: error: no previous prototype for 'unregister_srm_console' [-Werror=missing-prototypes]
arch/alpha/kernel/sys_nautilus.c:131:1: error: no previous prototype for 'nautilus_machine_check' [-Werror=missing-prototypes]
arch/alpha/kernel/sys_nautilus.c:201:1: error: no previous prototype for 'nautilus_init_pci' [-Werror=missing-prototypes]
arch/alpha/kernel/sys_nautilus.c:82:1: error: no previous prototype for 'nautilus_kill_arch' [-Werror=missing-prototypes]
arch/alpha/kernel/sys_sio.c:312:1: error: no previous prototype for 'sio_kill_arch' [-Werror=missing-prototypes]
arch/alpha/kernel/traps.c:210:1: error: no previous prototype for 'do_entArith' [-Werror=missing-prototypes]
arch/alpha/kernel/traps.c:232:1: error: no previous prototype for 'do_entIF' [-Werror=missing-prototypes]
arch/alpha/kernel/traps.c:399:1: error: no previous prototype for 'do_entDbg' [-Werror=missing-prototypes]
arch/alpha/kernel/traps.c:435:1: error: no previous prototype for 'do_entUna' [-Werror=missing-prototypes]
arch/alpha/kernel/traps.c:720:1: error: no previous prototype for 'do_entUnaUser' [-Werror=missing-prototypes]
arch/alpha/kernel/traps.c:975:1: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
arch/alpha/lib/checksum.c:145:9: error: no previous prototype for 'ip_fast_csum' [-Werror=missing-prototypes]
arch/alpha/lib/checksum.c:163:8: error: no previous prototype for 'csum_partial' [-Werror=missing-prototypes]
arch/alpha/lib/checksum.c:180:9: error: no previous prototype for 'ip_compute_csum' [-Werror=missing-prototypes]
arch/alpha/lib/checksum.c:45:9: error: no previous prototype for 'csum_tcpudp_magic' [-Werror=missing-prototypes]
arch/alpha/lib/checksum.c:54:8: error: no previous prototype for 'csum_tcpudp_nofold' [-Werror=missing-prototypes]
arch/alpha/lib/fpreg.c:129:1: error: no previous prototype for 'alpha_read_fp_reg_s' [-Werror=missing-prototypes]
arch/alpha/lib/fpreg.c:186:1: error: no previous prototype for 'alpha_write_fp_reg_s' [-Werror=missing-prototypes]
arch/alpha/lib/fpreg.c:20:1: error: no previous prototype for 'alpha_read_fp_reg' [-Werror=missing-prototypes]
arch/alpha/lib/fpreg.c:75:1: error: no previous prototype for 'alpha_write_fp_reg' [-Werror=missing-prototypes]
arch/alpha/lib/memcpy.c:153:8: error: no previous prototype for 'memcpy' [-Werror=missing-prototypes]
arch/alpha/mm/fault.c:85:1: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/alpha/mm/init.c:261:1: error: no previous prototype for 'srm_paging_stop' [-Werror=missing-prototypes]
arch/arc/kernel/ctx_sw.c:21:1: error: no previous prototype for '__switch_to' [-Werror=missing-prototypes]
arch/arc/kernel/devtree.c:20:21: error: no previous prototype for 'arc_early_base_baud' [-Werror=missing-prototypes]
arch/arc/kernel/irq.c:42:6: error: no previous prototype for 'arch_do_IRQ' [-Werror=missing-prototypes]
arch/arc/kernel/kprobes.c:193:15: error: no previous prototype for 'arc_kprobe_handler' [-Werror=missing-prototypes]
arch/arc/kernel/ptrace.c:344:16: error: no previous prototype for 'syscall_trace_entry' [-Werror=missing-prototypes]
arch/arc/kernel/ptrace.c:358:17: error: no previous prototype for 'syscall_trace_exit' [-Werror=missing-prototypes]
arch/arc/kernel/setup.c:498:13: error: no previous prototype for 'handle_uboot_args' [-Werror=missing-prototypes]
arch/arc/kernel/signal.c:401:6: error: no previous prototype for 'do_signal' [-Werror=missing-prototypes]
arch/arc/kernel/signal.c:434:6: error: no previous prototype for 'do_notify_resume' [-Werror=missing-prototypes]
arch/arc/kernel/stacktrace.c:116:1: error: no previous prototype for 'arc_unwind_core' [-Werror=missing-prototypes]
arch/arc/kernel/traps.c:110:6: error: no previous prototype for 'do_non_swi_trap' [-Werror=missing-prototypes]
arch/arc/kernel/traps.c:141:6: error: no previous prototype for 'do_insterror_or_kprobe' [-Werror=missing-prototypes]
arch/arc/kernel/traps.c:68:48: error: no previous prototype for 'do_privilege_fault' [-Werror=missing-prototypes]
arch/arc/kernel/traps.c:69:44: error: no previous prototype for 'do_extension_fault' [-Werror=missing-prototypes]
arch/arc/kernel/traps.c:70:48: error: no previous prototype for 'insterror_is_error' [-Werror=missing-prototypes]
arch/arc/kernel/traps.c:71:52: error: no previous prototype for 'do_memory_error' [-Werror=missing-prototypes]
arch/arc/kernel/traps.c:72:42: error: no previous prototype for 'trap_is_brkpt' [-Werror=missing-prototypes]
arch/arc/kernel/traps.c:73:44: error: no previous prototype for 'do_misaligned_error' [-Werror=missing-prototypes]
arch/arc/kernel/traps.c:74:56: error: no previous prototype for 'do_trap5_error' [-Werror=missing-prototypes]
arch/arc/kernel/traps.c:79:5: error: no previous prototype for 'do_misaligned_access' [-Werror=missing-prototypes]
arch/arc/kernel/traps.c:93:6: error: no previous prototype for 'do_machine_check_fault' [-Werror=missing-prototypes]
arch/arc/mm/cache.c:1085:22: error: no previous prototype for 'arc_ioc_setup' [-Werror=missing-prototypes]
arch/arc/mm/cache.c:1147:13: error: no previous prototype for 'arc_cache_init_master' [-Werror=missing-prototypes]
arch/arc/mm/cache.c:584:15: error: no previous prototype for 'slc_op_rgn' [-Werror=missing-prototypes]
arch/arc/mm/cache.c:647:15: error: no previous prototype for 'slc_op_line' [-Werror=missing-prototypes]
arch/arc/mm/fault.c:72:6: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/arc/mm/init.c:35:13: error: no previous prototype for 'arc_get_mem_sz' [-Werror=missing-prototypes]
arch/arc/mm/init.c:83:13: error: no previous prototype for 'setup_arch_memory' [-Werror=missing-prototypes]
arch/arc/mm/tlb.c:392:6: error: no previous prototype for 'create_tlb' [-Werror=missing-prototypes]
arch/arc/mm/tlb.c:723:6: error: no previous prototype for 'do_tlb_overlap_fault' [-Werror=missing-prototypes]
arch/csky/kernel/ptrace.c:320:16: error: no previous prototype for 'syscall_trace_enter' [-Werror=missing-prototypes]
arch/csky/kernel/ptrace.c:336:17: error: no previous prototype for 'syscall_trace_exit' [-Werror=missing-prototypes]
arch/csky/kernel/setup.c:116:34: error: no previous prototype for 'csky_start' [-Werror=missing-prototypes]
arch/csky/kernel/signal.c:255:17: error: no previous prototype for 'do_notify_resume' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:150:15: error: no previous prototype for 'do_trap_unknown' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:152:15: error: no previous prototype for 'do_trap_zdiv' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:154:15: error: no previous prototype for 'do_trap_buserr' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:157:17: error: no previous prototype for 'do_trap_misaligned' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:168:17: error: no previous prototype for 'do_trap_bkpt' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:187:17: error: no previous prototype for 'do_trap_illinsn' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:210:17: error: no previous prototype for 'do_trap_fpe' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:220:17: error: no previous prototype for 'do_trap_priv' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:230:17: error: no previous prototype for 'trap_c' [-Werror=missing-prototypes]
arch/csky/kernel/traps.c:57:13: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
arch/csky/kernel/vdso/vgettimeofday.c:12:5: error: no previous prototype for '__vdso_clock_gettime64' [-Werror=missing-prototypes]
arch/csky/kernel/vdso/vgettimeofday.c:18:5: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
arch/csky/kernel/vdso/vgettimeofday.c:24:5: error: no previous prototype for '__vdso_clock_getres' [-Werror=missing-prototypes]
arch/csky/kernel/vdso/vgettimeofday.c:6:5: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
arch/csky/mm/fault.c:187:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/ia64/kernel/acpi.c:715:5: error: no previous prototype for 'acpi_map_cpu2node' [-Werror=missing-prototypes]
arch/ia64/kernel/cyclone.c:18:13: error: no previous prototype for 'cyclone_setup' [-Werror=missing-prototypes]
arch/ia64/kernel/cyclone.c:38:12: error: no previous prototype for 'init_cyclone_clock' [-Werror=missing-prototypes]
arch/ia64/kernel/efi.c:971:1: error: no previous prototype for 'find_memmap_space' [-Werror=missing-prototypes]
arch/ia64/kernel/elfcore.c:10:12: error: no previous prototype for 'elf_core_extra_phdrs' [-Werror=missing-prototypes]
arch/ia64/kernel/elfcore.c:15:5: error: no previous prototype for 'elf_core_write_extra_phdrs' [-Werror=missing-prototypes]
arch/ia64/kernel/elfcore.c:44:5: error: no previous prototype for 'elf_core_write_extra_data' [-Werror=missing-prototypes]
arch/ia64/kernel/elfcore.c:63:8: error: no previous prototype for 'elf_core_extra_data_size' [-Werror=missing-prototypes]
arch/ia64/kernel/iosapic.c:265:1: error: no previous prototype for 'kexec_disable_iosapic' [-Werror=missing-prototypes]
arch/ia64/kernel/irq.c:128:6: error: no previous prototype for 'fixup_irqs' [-Werror=missing-prototypes]
arch/ia64/kernel/irq_ia64.c:429:1: error: no previous prototype for 'ia64_handle_irq' [-Werror=missing-prototypes]
arch/ia64/kernel/irq_ia64.c:512:6: error: no previous prototype for 'ia64_process_pending_intr' [-Werror=missing-prototypes]
arch/ia64/kernel/irq_ia64.c:587:1: error: no previous prototype for 'register_percpu_irq' [-Werror=missing-prototypes]
arch/ia64/kernel/mca.c:1284:1: error: no previous prototype for 'ia64_mca_handler' [-Werror=missing-prototypes]
arch/ia64/kernel/mca.c:504:1: error: no previous prototype for 'search_mca_table' [-Werror=missing-prototypes]
arch/ia64/kernel/mca.c:607:1: error: no previous prototype for 'ia64_mca_register_cpev' [-Werror=missing-prototypes]
arch/ia64/kernel/mca_drv.c:156:1: error: no previous prototype for 'mca_handler_bh' [-Werror=missing-prototypes]
arch/ia64/kernel/mca_drv.c:768:12: error: no previous prototype for 'mca_external_handler_init' [-Werror=missing-prototypes]
arch/ia64/kernel/mca_drv.c:782:13: error: no previous prototype for 'mca_external_handler_exit' [-Werror=missing-prototypes]
arch/ia64/kernel/module.c:245:1: error: no previous prototype for 'plt_target' [-Werror=missing-prototypes]
arch/ia64/kernel/process.c:156:1: error: no previous prototype for 'console_print' [-Werror=missing-prototypes]
arch/ia64/kernel/process.c:162:1: error: no previous prototype for 'do_notify_resume_user' [-Werror=missing-prototypes]
arch/ia64/kernel/process.c:405:17: error: no previous prototype for 'ia64_clone' [-Werror=missing-prototypes]
arch/ia64/kernel/process.c:559:1: error: no previous prototype for 'cpu_halt' [-Werror=missing-prototypes]
arch/ia64/kernel/ptrace.c:1158:1: error: no previous prototype for 'syscall_trace_enter' [-Werror=missing-prototypes]
arch/ia64/kernel/ptrace.c:1179:1: error: no previous prototype for 'syscall_trace_leave' [-Werror=missing-prototypes]
arch/ia64/kernel/ptrace.c:1994:6: error: no previous prototype for 'syscall_get_arguments' [-Werror=missing-prototypes]
arch/ia64/kernel/sal.c:43:29: error: cast between incompatible function types from 'long int (*)(void)' to 'struct ia64_sal_retval (*)(u64, ...)' {aka 'struct ia64_sal_retval (*)(long long unsigned int, ...)'} [-Werror=cast-function-type]
arch/ia64/kernel/salinfo.c:212:1: error: no previous prototype for 'salinfo_log_wakeup' [-Werror=missing-prototypes]
arch/ia64/kernel/signal.c:108:1: error: no previous prototype for 'ia64_rt_sigreturn' [-Werror=missing-prototypes]
arch/ia64/kernel/smpboot.c:190:1: error: no previous prototype for 'sync_master' [-Werror=missing-prototypes]
arch/ia64/kernel/smpboot.c:275:1: error: no previous prototype for 'ia64_sync_itc' [-Werror=missing-prototypes]
arch/ia64/kernel/smpboot.c:435:1: error: no previous prototype for 'start_secondary' [-Werror=missing-prototypes]
arch/ia64/kernel/smpboot.c:592:5: error: no previous prototype for 'migrate_platform_irqs' [-Werror=missing-prototypes]
arch/ia64/kernel/sys_ia64.c:161:1: error: no previous prototype for 'ia64_mremap' [-Werror=missing-prototypes]
arch/ia64/kernel/sys_ia64.c:171:1: error: no previous prototype for 'ia64_clock_getres' [-Werror=missing-prototypes]
arch/ia64/kernel/sys_ia64.c:71:1: error: no previous prototype for 'ia64_getpriority' [-Werror=missing-prototypes]
arch/ia64/kernel/sys_ia64.c:85:1: error: no previous prototype for 'sys_getpagesize' [-Werror=missing-prototypes]
arch/ia64/kernel/sys_ia64.c:91:1: error: no previous prototype for 'ia64_brk' [-Werror=missing-prototypes]
arch/ia64/kernel/time.c:260:6: error: no previous prototype for 'ia64_init_itm' [-Werror=missing-prototypes]
arch/ia64/kernel/traps.c:101:11: error: no previous prototype for 'ia64_bad_break' [-Werror=missing-prototypes]
arch/ia64/kernel/traps.c:35:1: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
arch/ia64/kernel/traps.c:387:1: error: no previous prototype for 'ia64_illegal_op_fault' [-Werror=missing-prototypes]
arch/ia64/kernel/traps.c:416:1: error: no previous prototype for 'ia64_fault' [-Werror=missing-prototypes]
arch/ia64/kernel/traps.c:43:1: error: no previous prototype for 'die' [-Werror=missing-prototypes]
arch/ia64/kernel/traps.c:93:1: error: no previous prototype for 'die_if_kernel' [-Werror=missing-prototypes]
arch/ia64/kernel/unaligned.c:1314:1: error: no previous prototype for 'ia64_handle_unaligned' [-Werror=missing-prototypes]
arch/ia64/kernel/uncached.c:177:15: error: no previous prototype for 'uncached_alloc_page' [-Werror=missing-prototypes]
arch/ia64/kernel/uncached.c:218:6: error: no previous prototype for 'uncached_free_page' [-Werror=missing-prototypes]
arch/ia64/kernel/unwind.c:1449:59: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
arch/ia64/kernel/unwind.c:2314:1: error: no previous prototype for 'sys_getunwind' [-Werror=missing-prototypes]
arch/ia64/kernel/unwind.c:862:56: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
arch/ia64/lib/checksum.c:38:1: error: no previous prototype for 'csum_tcpudp_magic' [-Werror=missing-prototypes]
arch/ia64/lib/checksum.c:49:1: error: no previous prototype for 'csum_tcpudp_nofold' [-Werror=missing-prototypes]
arch/ia64/lib/checksum.c:80:8: error: no previous prototype for 'csum_partial' [-Werror=missing-prototypes]
arch/ia64/lib/checksum.c:97:9: error: no previous prototype for 'ip_compute_csum' [-Werror=missing-prototypes]
arch/ia64/mm/discontig.c:631:6: error: no previous prototype for 'vmemmap_free' [-Werror=missing-prototypes]
arch/ia64/mm/extable.c:15:1: error: no previous prototype for 'ia64_handle_exception' [-Werror=missing-prototypes]
arch/ia64/mm/fault.c:66:1: error: no previous prototype for 'ia64_do_page_fault' [-Werror=missing-prototypes]
arch/ia64/mm/init.c:161:1: error: no previous prototype for 'free_initrd_mem' [-Werror=missing-prototypes]
arch/ia64/mm/init.c:309:6: error: no previous prototype for 'ia64_mmu_init' [-Werror=missing-prototypes]
arch/ia64/mm/tlb.c:369:6: error: no previous prototype for 'ia64_tlb_init' [-Werror=missing-prototypes]
arch/ia64/pci/pci.c:326:6: error: no previous prototype for 'pcibios_fixup_device_resources' [-Werror=missing-prototypes]
arch/loongarch/kernel/acpi.c:284:13: error: no previous prototype for 'acpi_numa_arch_fixup' [-Werror=missing-prototypes]
arch/loongarch/kernel/module-sections.c:103:5: error: no previous prototype for 'module_frob_arch_sections' [-Werror=missing-prototypes]
arch/loongarch/kernel/process.c:316:15: error: no previous prototype for 'arch_align_stack' [-Werror=missing-prototypes]
arch/loongarch/kernel/signal.c:1040:6: error: no previous prototype for 'arch_do_signal_or_restart' [-Werror=missing-prototypes]
arch/loongarch/kernel/signal.c:894:14: error: no previous prototype for 'get_sigframe' [-Werror=missing-prototypes]
arch/loongarch/kernel/signal.c:925:17: error: no previous prototype for 'sys_rt_sigreturn' [-Werror=missing-prototypes]
arch/loongarch/kernel/smp.c:501:17: error: no previous prototype for 'start_secondary' [-Werror=missing-prototypes]
arch/loongarch/kernel/smp.c:559:5: error: no previous prototype for 'setup_profiling_timer' [-Werror=missing-prototypes]
arch/loongarch/kernel/syscall.c:40:14: error: no previous prototype for 'do_syscall' [-Werror=missing-prototypes]
arch/loongarch/kernel/time.c:32:13: error: no previous prototype for 'constant_timer_interrupt' [-Werror=missing-prototypes]
arch/loongarch/kernel/topology.c:13:5: error: no previous prototype for 'arch_register_cpu' [-Werror=missing-prototypes]
arch/loongarch/kernel/topology.c:27:6: error: no previous prototype for 'arch_unregister_cpu' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:1012:25: error: no previous prototype for 'do_reserved' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:1031:17: error: no previous prototype for 'cache_parity_error' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:1040:25: error: no previous prototype for 'handle_loongarch_irq' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:1051:25: error: no previous prototype for 'do_vint' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:373:6: error: no previous prototype for 'show_registers' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:438:6: error: no previous prototype for 'force_fcsr_sig' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:457:5: error: no previous prototype for 'process_fpemu_return' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:492:25: error: no previous prototype for 'do_fpe' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:519:25: error: no previous prototype for 'do_ade' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:533:25: error: no previous prototype for 'do_ale' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:594:25: error: no previous prototype for 'do_bce' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:683:25: error: no previous prototype for 'do_bp' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:762:25: error: no previous prototype for 'do_watch' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:812:25: error: no previous prototype for 'do_ri' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:907:25: error: no previous prototype for 'do_fpu' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:924:25: error: no previous prototype for 'do_lsx' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:946:25: error: no previous prototype for 'do_lasx' [-Werror=missing-prototypes]
arch/loongarch/kernel/traps.c:981:25: error: no previous prototype for 'do_lbt' [-Werror=missing-prototypes]
arch/loongarch/mm/fault.c:256:27: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/loongarch/mm/hugetlbpage.c:56:5: error: no previous prototype for 'is_aligned_hugepage_range' [-Werror=missing-prototypes]
arch/loongarch/mm/ioremap.c:18:7: error: no previous prototype for 'early_memremap_ro' [-Werror=missing-prototypes]
arch/loongarch/mm/ioremap.c:23:7: error: no previous prototype for 'early_memremap_prot' [-Werror=missing-prototypes]
arch/loongarch/mm/tlb.c:264:6: error: no previous prototype for 'setup_tlb_handler' [-Werror=missing-prototypes]
arch/m68k/amiga/amisound.c:48:13: error: no previous prototype for 'amiga_init_sound' [-Werror=missing-prototypes]
arch/m68k/amiga/amisound.c:71:6: error: no previous prototype for 'amiga_mksound' [-Werror=missing-prototypes]
arch/m68k/apollo/config.c:111:5: error: no previous prototype for 'dn_serial_console_wait_key' [-Werror=missing-prototypes]
arch/m68k/apollo/config.c:118:6: error: no previous prototype for 'dn_serial_console_write' [-Werror=missing-prototypes]
arch/m68k/apollo/config.c:132:6: error: no previous prototype for 'dn_serial_print' [-Werror=missing-prototypes]
arch/m68k/apollo/config.c:240:6: error: no previous prototype for 'dn_dummy_waitbut' [-Werror=missing-prototypes]
arch/m68k/apollo/dn_ints.c:19:6: error: no previous prototype for 'apollo_irq_shutdown' [-Werror=missing-prototypes]
arch/m68k/apollo/dn_ints.c:29:6: error: no previous prototype for 'apollo_irq_eoi' [-Werror=missing-prototypes]
arch/m68k/apollo/dn_ints.c:43:13: error: no previous prototype for 'dn_init_IRQ' [-Werror=missing-prototypes]
arch/m68k/apollo/dn_ints.c:8:14: error: no previous prototype for 'apollo_irq_startup' [-Werror=missing-prototypes]
arch/m68k/atari/ataints.c:267:13: error: no previous prototype for 'atari_init_IRQ' [-Werror=missing-prototypes]
arch/m68k/atari/atakeyb.c:335:6: error: no previous prototype for 'ikbd_reset' [-Werror=missing-prototypes]
arch/m68k/atari/atasound.c:36:6: error: no previous prototype for 'atari_microwire_cmd' [-Werror=missing-prototypes]
arch/m68k/atari/atasound.c:53:6: error: no previous prototype for 'atari_mksound' [-Werror=missing-prototypes]
arch/m68k/atari/config.c:883:12: error: no previous prototype for 'atari_platform_init' [-Werror=missing-prototypes]
arch/m68k/atari/stram.c:118:12: error: no previous prototype for 'atari_stram_map_pages' [-Werror=missing-prototypes]
arch/m68k/atari/time.c:140:5: error: no previous prototype for 'atari_mste_hwclk' [-Werror=missing-prototypes]
arch/m68k/atari/time.c:199:5: error: no previous prototype for 'atari_tt_hwclk' [-Werror=missing-prototypes]
arch/m68k/atari/time.c:59:1: error: no previous prototype for 'atari_sched_init' [-Werror=missing-prototypes]
arch/m68k/bvme6000/config.c:133:13: error: no previous prototype for 'bvme6000_abort_int' [-Werror=missing-prototypes]
arch/m68k/hp300/time.c:101:13: error: no previous prototype for 'hp300_sched_init' [-Werror=missing-prototypes]
arch/m68k/kernel/ints.c:165:17: error: no previous prototype for 'handle_badint' [-Werror=missing-prototypes]
arch/m68k/kernel/process.c:115:16: error: no previous prototype for 'm68k_clone' [-Werror=missing-prototypes]
arch/m68k/kernel/process.c:136:16: error: no previous prototype for 'm68k_clone3' [-Werror=missing-prototypes]
arch/m68k/kernel/ptrace.c:275:16: error: no previous prototype for 'syscall_trace_enter' [-Werror=missing-prototypes]
arch/m68k/kernel/ptrace.c:288:17: error: no previous prototype for 'syscall_trace_leave' [-Werror=missing-prototypes]
arch/m68k/kernel/signal.c:1112:6: error: no previous prototype for 'do_notify_resume' [-Werror=missing-prototypes]
arch/m68k/kernel/signal.c:756:18: error: no previous prototype for 'do_sigreturn' [-Werror=missing-prototypes]
arch/m68k/kernel/signal.c:783:18: error: no previous prototype for 'do_rt_sigreturn' [-Werror=missing-prototypes]
arch/m68k/kernel/sys_m68k.c:378:1: error: no previous prototype for 'sys_cacheflush' [-Werror=missing-prototypes]
arch/m68k/kernel/sys_m68k.c:40:17: error: no previous prototype for 'sys_mmap2' [-Werror=missing-prototypes]
arch/m68k/kernel/sys_m68k.c:463:1: error: no previous prototype for 'sys_atomic_cmpxchg_32' [-Werror=missing-prototypes]
arch/m68k/kernel/sys_m68k.c:564:16: error: no previous prototype for 'sys_getpagesize' [-Werror=missing-prototypes]
arch/m68k/kernel/sys_m68k.c:569:26: error: no previous prototype for 'sys_get_thread_area' [-Werror=missing-prototypes]
arch/m68k/kernel/sys_m68k.c:574:16: error: no previous prototype for 'sys_set_thread_area' [-Werror=missing-prototypes]
arch/m68k/kernel/sys_m68k.c:580:16: error: no previous prototype for 'sys_atomic_barrier' [-Werror=missing-prototypes]
arch/m68k/kernel/traps.c:1140:17: error: no previous prototype for 'set_esp0' [-Werror=missing-prototypes]
arch/m68k/kernel/traps.c:1149:17: error: no previous prototype for 'fpsp040_die' [-Werror=missing-prototypes]
arch/m68k/kernel/traps.c:1155:17: error: no previous prototype for 'fpemu_signal' [-Werror=missing-prototypes]
arch/m68k/kernel/traps.c:754:17: error: no previous prototype for 'buserr_c' [-Werror=missing-prototypes]
arch/m68k/kernel/traps.c:968:6: error: no previous prototype for 'bad_super_trap' [-Werror=missing-prototypes]
arch/m68k/kernel/vectors.c:51:13: error: no previous prototype for 'base_trap_init' [-Werror=missing-prototypes]
arch/m68k/kernel/vectors.c:74:13: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
arch/m68k/lib/ashldi3.c:35:1: error: no previous prototype for '__ashldi3' [-Werror=missing-prototypes]
arch/m68k/lib/ashrdi3.c:35:1: error: no previous prototype for '__ashrdi3' [-Werror=missing-prototypes]
arch/m68k/lib/lshrdi3.c:35:1: error: no previous prototype for '__lshrdi3' [-Werror=missing-prototypes]
arch/m68k/lib/muldi3.c:82:1: error: no previous prototype for '__muldi3' [-Werror=missing-prototypes]
arch/m68k/mac/baboon.c:25:13: error: no previous prototype for 'baboon_init' [-Werror=missing-prototypes]
arch/m68k/mac/config.c:961:12: error: no previous prototype for 'mac_platform_init' [-Werror=missing-prototypes]
arch/m68k/mac/iop.c:235:13: error: no previous prototype for 'iop_init' [-Werror=missing-prototypes]
arch/m68k/mac/macboing.c:164:6: error: no previous prototype for 'mac_mksound' [-Werror=missing-prototypes]
arch/m68k/mac/misc.c:609:5: error: no previous prototype for 'mac_hwclk' [-Werror=missing-prototypes]
arch/m68k/mac/oss.c:37:13: error: no previous prototype for 'oss_init' [-Werror=missing-prototypes]
arch/m68k/mac/psc.c:76:13: error: no previous prototype for 'psc_init' [-Werror=missing-prototypes]
arch/m68k/mac/via.c:111:13: error: no previous prototype for 'via_init' [-Werror=missing-prototypes]
arch/m68k/mac/via.c:593:13: error: no previous prototype for 'via_init_clock' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_arith.c:310:1: error: no previous prototype for 'fp_fsglmul' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_arith.c:367:1: error: no previous prototype for 'fp_fsgldiv' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_log.c:102:1: error: no previous prototype for 'fp_fetoxm1' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_log.c:112:1: error: no previous prototype for 'fp_fetox' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_log.c:122:1: error: no previous prototype for 'fp_ftwotox' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_log.c:132:1: error: no previous prototype for 'fp_ftentox' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_log.c:142:1: error: no previous prototype for 'fp_flogn' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_log.c:152:1: error: no previous prototype for 'fp_flognp1' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_log.c:162:1: error: no previous prototype for 'fp_flog10' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_log.c:172:1: error: no previous prototype for 'fp_flog2' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_log.c:182:1: error: no previous prototype for 'fp_fgetexp' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_log.c:203:1: error: no previous prototype for 'fp_fgetman' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_log.c:29:1: error: no previous prototype for 'fp_fsqrt' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:102:1: error: no previous prototype for 'fp_ftanh' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:112:1: error: no previous prototype for 'fp_fatanh' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:122:1: error: no previous prototype for 'fp_fsincos0' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:130:1: error: no previous prototype for 'fp_fsincos1' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:138:1: error: no previous prototype for 'fp_fsincos2' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:146:1: error: no previous prototype for 'fp_fsincos3' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:154:1: error: no previous prototype for 'fp_fsincos4' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:162:1: error: no previous prototype for 'fp_fsincos5' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:170:1: error: no previous prototype for 'fp_fsincos6' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:178:1: error: no previous prototype for 'fp_fsincos7' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:22:1: error: no previous prototype for 'fp_fsin' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:32:1: error: no previous prototype for 'fp_fcos' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:42:1: error: no previous prototype for 'fp_ftan' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:52:1: error: no previous prototype for 'fp_fasin' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:62:1: error: no previous prototype for 'fp_facos' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:72:1: error: no previous prototype for 'fp_fatan' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:82:1: error: no previous prototype for 'fp_fsinh' [-Werror=missing-prototypes]
arch/m68k/math-emu/fp_trig.c:92:1: error: no previous prototype for 'fp_fcosh' [-Werror=missing-prototypes]
arch/m68k/mm/fault.c:22:5: error: no previous prototype for 'send_fault_sig' [-Werror=missing-prototypes]
arch/m68k/mm/fault.c:68:5: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/m68k/mm/hwtest.c:29:5: error: no previous prototype for 'hwreg_present' [-Werror=missing-prototypes]
arch/m68k/mm/hwtest.c:62:5: error: no previous prototype for 'hwreg_write' [-Werror=missing-prototypes]
arch/m68k/mm/motorola.c:418:13: error: no previous prototype for 'paging_init' [-Werror=missing-prototypes]
arch/m68k/mvme147/config.c:76:13: error: no previous prototype for 'mvme147_init_IRQ' [-Werror=missing-prototypes]
arch/m68k/mvme16x/config.c:208:6: error: no previous prototype for 'mvme16x_cons_write' [-Werror=missing-prototypes]
arch/m68k/q40/q40ints.c:112:6: error: no previous prototype for 'q40_mksound' [-Werror=missing-prototypes]
arch/m68k/q40/q40ints.c:152:6: error: no previous prototype for 'q40_sched_init' [-Werror=missing-prototypes]
arch/m68k/q40/q40ints.c:84:13: error: no previous prototype for 'q40_init_IRQ' [-Werror=missing-prototypes]
arch/m68k/sun3/idprom.c:86:6: error: no previous prototype for 'sun3_get_model' [-Werror=missing-prototypes]
arch/m68k/sun3x/config.c:29:6: error: no previous prototype for 'sun3_leds' [-Werror=missing-prototypes]
arch/m68k/sun3x/config.c:42:13: error: no previous prototype for 'config_sun3x' [-Werror=missing-prototypes]
arch/m68k/sun3x/dvma.c:179:6: error: no previous prototype for 'dvma_unmap_iommu' [-Werror=missing-prototypes]
arch/m68k/sun3x/prom.c:33:6: error: no previous prototype for 'sun3x_halt' [-Werror=missing-prototypes]
arch/microblaze/kernel/traps.c:21:6: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
arch/mips/kernel/ftrace.c:305:6: error: no previous prototype for 'prepare_ftrace_return' [-Werror=missing-prototypes]
arch/mips/kernel/jump_label.c:93:6: error: no previous prototype for 'jump_label_apply_nops' [-Werror=missing-prototypes]
arch/mips/kernel/linux32.c:102:20: error: no previous prototype for 'sys32_readahead' [-Werror=missing-prototypes]
arch/mips/kernel/linux32.c:108:17: error: no previous prototype for 'sys32_sync_file_range' [-Werror=missing-prototypes]
arch/mips/kernel/linux32.c:118:17: error: no previous prototype for 'sys32_fadvise64_64' [-Werror=missing-prototypes]
arch/mips/kernel/linux32.c:128:17: error: no previous prototype for 'sys32_fallocate' [-Werror=missing-prototypes]
arch/mips/kernel/machine_kexec.c:136:1: error: no previous prototype for 'machine_shutdown' [-Werror=missing-prototypes]
arch/mips/kernel/machine_kexec.c:152:1: error: no previous prototype for 'machine_crash_shutdown' [-Werror=missing-prototypes]
arch/mips/kernel/mips-cm.c:204:13: error: no previous prototype for '__mips_cm_l2sync_phys_base' [-Werror=missing-prototypes]
arch/mips/kernel/mips-mt-fpaff.c:157:17: error: no previous prototype for 'mipsmt_sys_sched_getaffinity' [-Werror=missing-prototypes]
arch/mips/kernel/mips-mt-fpaff.c:65:17: error: no previous prototype for 'mipsmt_sys_sched_setaffinity' [-Werror=missing-prototypes]
arch/mips/kernel/mips-mt.c:159:6: error: no previous prototype for 'mips_mt_set_cpuoptions' [-Werror=missing-prototypes]
arch/mips/kernel/mips-mt.c:50:6: error: no previous prototype for 'mips_mt_regdump' [-Werror=missing-prototypes]
arch/mips/kernel/signal.c:438:5: error: no previous prototype for 'setup_sigcontext' [-Werror=missing-prototypes]
arch/mips/kernel/signal.c:438:5: error: no previous prototype for 'setup_sigcontext' [-Werror=missing-prototypes]
arch/mips/kernel/signal.c:515:5: error: no previous prototype for 'restore_sigcontext' [-Werror=missing-prototypes]
arch/mips/kernel/signal.c:515:5: error: no previous prototype for 'restore_sigcontext' [-Werror=missing-prototypes]
arch/mips/kernel/signal.c:636:17: error: no previous prototype for 'sys_sigreturn' [-Werror=missing-prototypes]
arch/mips/kernel/signal.c:673:17: error: no previous prototype for 'sys_rt_sigreturn' [-Werror=missing-prototypes]
arch/mips/kernel/signal.c:673:17: error: no previous prototype for 'sys_rt_sigreturn' [-Werror=missing-prototypes]
arch/mips/kernel/signal.c:903:17: error: no previous prototype for 'do_notify_resume' [-Werror=missing-prototypes]
arch/mips/kernel/signal.c:903:17: error: no previous prototype for 'do_notify_resume' [-Werror=missing-prototypes]
arch/mips/kernel/signal32.c:33:16: error: no previous prototype for 'sys32_sigsuspend' [-Werror=missing-prototypes]
arch/mips/kernel/signal_n32.c:53:17: error: no previous prototype for 'sysn32_rt_sigreturn' [-Werror=missing-prototypes]
arch/mips/kernel/signal_o32.c:154:17: error: no previous prototype for 'sys32_rt_sigreturn' [-Werror=missing-prototypes]
arch/mips/kernel/signal_o32.c:256:17: error: no previous prototype for 'sys32_sigreturn' [-Werror=missing-prototypes]
arch/mips/kernel/smp.c:352:17: error: no previous prototype for 'start_secondary' [-Werror=missing-prototypes]
arch/mips/kernel/smp.c:352:17: error: no previous prototype for 'start_secondary' [-Werror=missing-prototypes]
arch/mips/kernel/smp.c:472:5: error: no previous prototype for 'setup_profiling_timer' [-Werror=missing-prototypes]
arch/mips/kernel/smp.c:472:5: error: no previous prototype for 'setup_profiling_timer' [-Werror=missing-prototypes]
arch/mips/kernel/spram.c:194:6: error: no previous prototype for 'spram_config' [-Werror=missing-prototypes]
arch/mips/kernel/spram.c:194:6: error: no previous prototype for 'spram_config' [-Werror=missing-prototypes]
arch/mips/kernel/syscall.c:51:16: error: no previous prototype for 'sysm_pipe' [-Werror=missing-prototypes]
arch/mips/kernel/syscall.c:51:16: error: no previous prototype for 'sysm_pipe' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1027:17: error: no previous prototype for 'do_bp' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1027:17: error: no previous prototype for 'do_bp' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1114:17: error: no previous prototype for 'do_tr' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1114:17: error: no previous prototype for 'do_tr' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1151:17: error: no previous prototype for 'do_ri' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1151:17: error: no previous prototype for 'do_ri' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1402:17: error: no previous prototype for 'do_cpu' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1402:17: error: no previous prototype for 'do_cpu' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1507:17: error: no previous prototype for 'do_msa_fpe' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1507:17: error: no previous prototype for 'do_msa_fpe' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1527:17: error: no previous prototype for 'do_msa' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1527:17: error: no previous prototype for 'do_msa' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1548:17: error: no previous prototype for 'do_mdmx' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1548:17: error: no previous prototype for 'do_mdmx' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1560:17: error: no previous prototype for 'do_watch' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1560:17: error: no previous prototype for 'do_watch' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1587:17: error: no previous prototype for 'do_mcheck' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1587:17: error: no previous prototype for 'do_mcheck' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1612:17: error: no previous prototype for 'do_mt' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1612:17: error: no previous prototype for 'do_mt' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1648:17: error: no previous prototype for 'do_dsp' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1648:17: error: no previous prototype for 'do_dsp' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1656:17: error: no previous prototype for 'do_reserved' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1656:17: error: no previous prototype for 'do_reserved' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1832:17: error: no previous prototype for 'cache_parity_error' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1832:17: error: no previous prototype for 'cache_parity_error' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1880:17: error: no previous prototype for 'do_ftlb' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1880:17: error: no previous prototype for 'do_ftlb' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1909:17: error: no previous prototype for 'do_gsexc' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1909:17: error: no previous prototype for 'do_gsexc' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1944:6: error: no previous prototype for 'ejtag_exception_handler' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1944:6: error: no previous prototype for 'ejtag_exception_handler' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1989:17: error: no previous prototype for 'nmi_exception_handler' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:1989:17: error: no previous prototype for 'nmi_exception_handler' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:370:6: error: no previous prototype for 'show_registers' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:370:6: error: no previous prototype for 'show_registers' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:447:17: error: no previous prototype for 'do_be' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:447:17: error: no previous prototype for 'do_be' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:752:17: error: no previous prototype for 'do_ov' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:752:17: error: no previous prototype for 'do_ov' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:874:17: error: no previous prototype for 'do_fpe' [-Werror=missing-prototypes]
arch/mips/kernel/traps.c:874:17: error: no previous prototype for 'do_fpe' [-Werror=missing-prototypes]
arch/mips/kernel/unaligned.c:1516:17: error: no previous prototype for 'do_ade' [-Werror=missing-prototypes]
arch/mips/kernel/unaligned.c:1516:17: error: no previous prototype for 'do_ade' [-Werror=missing-prototypes]
arch/mips/kvm/loongson_ipi.c:190:6: error: no previous prototype for 'kvm_init_loongson_ipi' [-Werror=missing-prototypes]
arch/mips/loongson64/dma.c:25:13: error: no previous prototype for 'plat_swiotlb_setup' [-Werror=missing-prototypes]
arch/mips/loongson64/pm.c:59:13: error: no previous prototype for 'setup_wakeup_events' [-Werror=missing-prototypes]
arch/mips/loongson64/pm.c:63:13: error: no previous prototype for 'mach_suspend' [-Werror=missing-prototypes]
arch/mips/loongson64/pm.c:67:13: error: no previous prototype for 'mach_resume' [-Werror=missing-prototypes]
arch/mips/mm/c-r4k.c:1588:6: error: no previous prototype for 'au1x00_fixup_config_od' [-Werror=missing-prototypes]
arch/mips/mm/c-r4k.c:1588:6: error: no previous prototype for 'au1x00_fixup_config_od' [-Werror=missing-prototypes]
arch/mips/mm/c-r4k.c:1703:6: error: no previous prototype for 'r4k_cache_init' [-Werror=missing-prototypes]
arch/mips/mm/c-r4k.c:1703:6: error: no previous prototype for 'r4k_cache_init' [-Werror=missing-prototypes]
arch/mips/mm/c-r4k.c:1831:12: error: no previous prototype for 'r4k_cache_init_pm' [-Werror=missing-prototypes]
arch/mips/mm/c-r4k.c:1831:12: error: no previous prototype for 'r4k_cache_init_pm' [-Werror=missing-prototypes]
arch/mips/mm/fault.c:323:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/mips/mm/fault.c:323:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/mips/mm/init.c:60:6: error: no previous prototype for 'setup_zero_pages' [-Werror=missing-prototypes]
arch/mips/mm/pgtable-64.c:101:6: error: no previous prototype for 'set_pmd_at' [-Werror=missing-prototypes]
arch/mips/mm/pgtable-64.c:92:7: error: no previous prototype for 'mk_pmd' [-Werror=missing-prototypes]
arch/mips/mm/sc-mips.c:255:5: error: no previous prototype for 'mips_sc_init' [-Werror=missing-prototypes]
arch/mips/mm/tlb-r4k.c:461:12: error: no previous prototype for 'add_temporary_entry' [-Werror=missing-prototypes]
arch/mips/mm/tlb-r4k.c:553:6: error: no previous prototype for 'tlb_init' [-Werror=missing-prototypes]
arch/mips/mm/tlb-r4k.c:553:6: error: no previous prototype for 'tlb_init' [-Werror=missing-prototypes]
arch/mips/mm/tlbex.c:2547:6: error: no previous prototype for 'build_tlb_refill_handler' [-Werror=missing-prototypes]
arch/mips/mm/tlbex.c:2547:6: error: no previous prototype for 'build_tlb_refill_handler' [-Werror=missing-prototypes]
arch/mips/mm/uasm.c:421:5: error: no previous prototype for 'uasm_in_compat_space_p' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:14:5: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:14:5: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:14:5: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:28:5: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:28:5: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:28:5: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:36:5: error: no previous prototype for '__vdso_clock_getres' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:36:5: error: no previous prototype for '__vdso_clock_getres' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:36:5: error: no previous prototype for '__vdso_clock_getres' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:42:5: error: no previous prototype for '__vdso_clock_gettime64' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:42:5: error: no previous prototype for '__vdso_clock_gettime64' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:42:5: error: no previous prototype for '__vdso_clock_gettime64' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:50:5: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:64:5: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
arch/mips/vdso/vgettimeofday.c:72:5: error: no previous prototype for '__vdso_clock_getres' [-Werror=missing-prototypes]
arch/nios2/kernel/irq.c:19:17: error: no previous prototype for 'do_IRQ' [-Werror=missing-prototypes]
arch/nios2/kernel/misaligned.c:66:17: error: no previous prototype for 'handle_unaligned_c' [-Werror=missing-prototypes]
arch/nios2/kernel/process.c:152:6: error: no previous prototype for 'dump' [-Werror=missing-prototypes]
arch/nios2/kernel/process.c:253:16: error: no previous prototype for 'nios2_clone' [-Werror=missing-prototypes]
arch/nios2/kernel/process.c:34:6: error: no previous prototype for 'arch_cpu_idle' [-Werror=missing-prototypes]
arch/nios2/kernel/process.c:43:6: error: no previous prototype for 'machine_restart' [-Werror=missing-prototypes]
arch/nios2/kernel/process.c:54:6: error: no previous prototype for 'machine_halt' [-Werror=missing-prototypes]
arch/nios2/kernel/process.c:66:6: error: no previous prototype for 'machine_power_off' [-Werror=missing-prototypes]
arch/nios2/kernel/setup.c:107:24: error: no previous prototype for 'nios2_boot_init' [-Werror=missing-prototypes]
arch/nios2/kernel/signal.c:101:16: error: no previous prototype for 'do_rt_sigreturn' [-Werror=missing-prototypes]
arch/nios2/kernel/signal.c:302:16: error: no previous prototype for 'do_notify_resume' [-Werror=missing-prototypes]
arch/nios2/kernel/sys_nios2.c:21:16: error: no previous prototype for 'sys_cacheflush' [-Werror=missing-prototypes]
arch/nios2/kernel/sys_nios2.c:57:16: error: no previous prototype for 'sys_getpagesize' [-Werror=missing-prototypes]
arch/nios2/kernel/time.c:200:13: error: no previous prototype for 'timer_interrupt' [-Werror=missing-prototypes]
arch/nios2/kernel/traps.c:109:17: error: no previous prototype for 'breakpoint_c' [-Werror=missing-prototypes]
arch/nios2/kernel/traps.c:147:17: error: no previous prototype for 'handle_illegal_c' [-Werror=missing-prototypes]
arch/nios2/kernel/traps.c:154:17: error: no previous prototype for 'handle_supervisor_instr' [-Werror=missing-prototypes]
arch/nios2/kernel/traps.c:161:17: error: no previous prototype for 'handle_diverror_c' [-Werror=missing-prototypes]
arch/nios2/kernel/traps.c:168:17: error: no previous prototype for 'unhandled_exception' [-Werror=missing-prototypes]
arch/nios2/kernel/traps.c:183:17: error: no previous prototype for 'handle_trap_1_c' [-Werror=missing-prototypes]
arch/nios2/kernel/traps.c:188:17: error: no previous prototype for 'handle_trap_2_c' [-Werror=missing-prototypes]
arch/nios2/kernel/traps.c:193:17: error: no previous prototype for 'handle_trap_3_c' [-Werror=missing-prototypes]
arch/nios2/kernel/traps.c:32:6: error: no previous prototype for 'die' [-Werror=missing-prototypes]
arch/nios2/lib/memcpy.c:160:7: error: no previous prototype for 'memcpy' [-Werror=missing-prototypes]
arch/nios2/lib/memcpy.c:194:7: error: no previous prototype for 'memcpyb' [-Werror=missing-prototypes]
arch/nios2/mm/dma-mapping.c:21:6: error: no previous prototype for 'arch_sync_dma_for_device' [-Werror=missing-prototypes]
arch/nios2/mm/dma-mapping.c:45:6: error: no previous prototype for 'arch_sync_dma_for_cpu' [-Werror=missing-prototypes]
arch/nios2/mm/dma-mapping.c:63:6: error: no previous prototype for 'arch_dma_prep_coherent' [-Werror=missing-prototypes]
arch/nios2/mm/dma-mapping.c:70:7: error: no previous prototype for 'arch_dma_set_uncached' [-Werror=missing-prototypes]
arch/nios2/mm/fault.c:43:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/nios2/mm/pgtable.c:53:8: error: no previous prototype for 'pgd_alloc' [-Werror=missing-prototypes]
arch/nios2/mm/pgtable.c:68:13: error: no previous prototype for 'pagetable_init' [-Werror=missing-prototypes]
arch/nios2/mm/tlb.c:167:6: error: no previous prototype for 'dump_tlb_line' [-Werror=missing-prototypes]
arch/nios2/mm/tlb.c:208:6: error: no previous prototype for 'dump_tlb' [-Werror=missing-prototypes]
arch/nios2/mm/tlb.c:216:6: error: no previous prototype for 'flush_tlb_pid' [-Werror=missing-prototypes]
arch/openrisc/kernel/process.c:100:6: error: no previous prototype for 'arch_cpu_idle' [-Werror=missing-prototypes]
arch/openrisc/kernel/process.c:240:21: error: no previous prototype for '__switch_to' [-Werror=missing-prototypes]
arch/openrisc/kernel/ptrace.c:191:17: error: no previous prototype for 'do_syscall_trace_enter' [-Werror=missing-prototypes]
arch/openrisc/kernel/ptrace.c:210:17: error: no previous prototype for 'do_syscall_trace_leave' [-Werror=missing-prototypes]
arch/openrisc/kernel/signal.c:227:5: error: no previous prototype for 'do_signal' [-Werror=missing-prototypes]
arch/openrisc/kernel/signal.c:293:1: error: no previous prototype for 'do_work_pending' [-Werror=missing-prototypes]
arch/openrisc/kernel/signal.c:68:17: error: no previous prototype for '_sys_rt_sigreturn' [-Werror=missing-prototypes]
arch/openrisc/kernel/time.c:111:25: error: no previous prototype for 'timer_interrupt' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:146:6: error: no previous prototype for 'nommu_dump_state' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:221:17: error: no previous prototype for 'die' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:239:17: error: no previous prototype for 'unhandled_exception' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:246:17: error: no previous prototype for 'do_fpe_trap' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:268:17: error: no previous prototype for 'do_trap' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:273:17: error: no previous prototype for 'do_unaligned_access' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:286:17: error: no previous prototype for 'do_bus_fault' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:462:17: error: no previous prototype for 'do_illegal_instruction' [-Werror=missing-prototypes]
arch/openrisc/kernel/traps.c:67:6: error: no previous prototype for 'show_registers' [-Werror=missing-prototypes]
arch/openrisc/mm/fault.c:44:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/openrisc/mm/tlb.c:188:13: error: no previous prototype for 'tlb_init' [-Werror=missing-prototypes]
arch/parisc/lib/ucmpdi2.c:12:5: error: no previous prototype for '__ucmpdi2' [-Werror=missing-prototypes]
arch/sh/kernel/cpu/init.c:99:29: error: no previous prototype for 'l2_cache_init' [-Werror=missing-prototypes]
arch/sh/kernel/cpu/init.c:99:29: error: no previous prototype for 'l2_cache_init' [-Werror=missing-prototypes]
arch/sh/kernel/cpu/sh4/fpu.c:389:6: error: no previous prototype for 'float_raise' [-Werror=missing-prototypes]
arch/sh/kernel/cpu/sh4/fpu.c:394:5: error: no previous prototype for 'float_rounding_mode' [-Werror=missing-prototypes]
arch/sh/kernel/hw_breakpoint.c:135:5: error: no previous prototype for 'arch_bp_generic_fields' [-Werror=missing-prototypes]
arch/sh/kernel/hw_breakpoint.c:135:5: error: no previous prototype for 'arch_bp_generic_fields' [-Werror=missing-prototypes]
arch/sh/kernel/return_address.c:49:7: error: no previous prototype for 'return_address' [-Werror=missing-prototypes]
arch/sh/kernel/return_address.c:49:7: error: no previous prototype for 'return_address' [-Werror=missing-prototypes]
arch/sh/kernel/sys_sh.c:58:16: error: no previous prototype for 'sys_cacheflush' [-Werror=missing-prototypes]
arch/sh/kernel/sys_sh.c:58:16: error: no previous prototype for 'sys_cacheflush' [-Werror=missing-prototypes]
arch/sh/kernel/traps_32.c:735:6: error: no previous prototype for 'per_cpu_trap_init' [-Werror=missing-prototypes]
arch/sh/kernel/traps_32.c:735:6: error: no previous prototype for 'per_cpu_trap_init' [-Werror=missing-prototypes]
arch/sh/mm/cache-sh2.c:85:13: error: no previous prototype for 'sh2_cache_init' [-Werror=missing-prototypes]
arch/sh/mm/cache-sh4.c:384:13: error: no previous prototype for 'sh4_cache_init' [-Werror=missing-prototypes]
arch/sh/mm/fault.c:389:27: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/sh/mm/flush-sh4.c:106:13: error: no previous prototype for 'sh4__flush_region_init' [-Werror=missing-prototypes]
arch/sh/mm/nommu.c:76:13: error: no previous prototype for 'kmap_coherent_init' [-Werror=missing-prototypes]
arch/sh/mm/nommu.c:80:7: error: no previous prototype for 'kmap_coherent' [-Werror=missing-prototypes]
arch/sh/mm/nommu.c:86:6: error: no previous prototype for 'kunmap_coherent' [-Werror=missing-prototypes]
arch/sh/mm/pgtable.c:10:6: error: no previous prototype for 'pgd_ctor' [-Werror=missing-prototypes]
arch/sh/mm/pgtable.c:32:8: error: no previous prototype for 'pgd_alloc' [-Werror=missing-prototypes]
arch/sh/mm/pgtable.c:37:6: error: no previous prototype for 'pgd_free' [-Werror=missing-prototypes]
arch/sh/mm/tlbex_32.c:22:1: error: no previous prototype for 'handle_tlbmiss' [-Werror=missing-prototypes]
arch/sparc/kernel/adi_64.c:124:21: error: no previous prototype for 'find_tag_store' [-Werror=missing-prototypes]
arch/sparc/kernel/adi_64.c:156:21: error: no previous prototype for 'alloc_tag_store' [-Werror=missing-prototypes]
arch/sparc/kernel/adi_64.c:299:6: error: no previous prototype for 'del_tag_store' [-Werror=missing-prototypes]
arch/sparc/kernel/pci_sun4v.c:258:15: error: no previous prototype for 'dma_4v_iotsb_bind' [-Werror=missing-prototypes]
arch/sparc/kernel/setup_64.c:615:13: error: no previous prototype for 'alloc_irqstack_bootmem' [-Werror=missing-prototypes]
arch/sparc/kernel/time_64.c:880:20: error: no previous prototype for 'sched_clock' [-Werror=missing-prototypes]
arch/sparc/kernel/traps_32.c:366:6: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
arch/sparc/kernel/traps_64.c:2034:6: error: no previous prototype for 'do_mcd_err' [-Werror=missing-prototypes]
arch/sparc/kernel/traps_64.c:2152:6: error: no previous prototype for 'sun4v_nonresum_error_user_handled' [-Werror=missing-prototypes]
arch/sparc/kernel/traps_64.c:252:6: error: no previous prototype for 'is_no_fault_exception' [-Werror=missing-prototypes]
arch/sparc/kernel/traps_64.c:2839:13: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
arch/sparc/kernel/uprobes.c:237:17: error: no previous prototype for 'uprobe_trap' [-Werror=missing-prototypes]
arch/sparc/lib/cmpdi2.c:6:11: error: no previous prototype for '__cmpdi2' [-Werror=missing-prototypes]
arch/sparc/lib/ucmpdi2.c:5:11: error: no previous prototype for '__ucmpdi2' [-Werror=missing-prototypes]
arch/sparc/mm/init_64.c:2644:6: error: no previous prototype for 'vmemmap_free' [-Werror=missing-prototypes]
arch/sparc/prom/misc_64.c:165:5: error: no previous prototype for 'prom_get_mmu_ihandle' [-Werror=missing-prototypes]
arch/sparc/prom/p1275.c:52:6: error: no previous prototype for 'prom_cif_init' [-Werror=missing-prototypes]
arch/sparc/vdso/vclock_gettime.c:254:1: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
arch/sparc/vdso/vclock_gettime.c:282:1: error: no previous prototype for '__vdso_clock_gettime_stick' [-Werror=missing-prototypes]
arch/sparc/vdso/vclock_gettime.c:307:1: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
arch/sparc/vdso/vclock_gettime.c:343:1: error: no previous prototype for '__vdso_gettimeofday_stick' [-Werror=missing-prototypes]
arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: error: no previous prototype for '__vdso_clock_gettime_stick' [-Werror=missing-prototypes]
arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: error: no previous prototype for '__vdso_gettimeofday_stick' [-Werror=missing-prototypes]
arch/sparc/vdso/vma.c:246:12: error: no previous prototype for 'init_vdso_image' [-Werror=missing-prototypes]
arch/xtensa/kernel/irq.c:34:17: error: no previous prototype for 'do_IRQ' [-Werror=missing-prototypes]
arch/xtensa/kernel/ptrace.c:545:5: error: no previous prototype for 'do_syscall_trace_enter' [-Werror=missing-prototypes]
arch/xtensa/kernel/setup.c:244:13: error: no previous prototype for 'init_arch' [-Werror=missing-prototypes]
arch/xtensa/kernel/signal.c:246:17: error: no previous prototype for 'xtensa_rt_sigreturn' [-Werror=missing-prototypes]
arch/xtensa/kernel/signal.c:525:6: error: no previous prototype for 'do_notify_resume' [-Werror=missing-prototypes]
arch/xtensa/kernel/stacktrace.c:263:15: error: no previous prototype for 'return_address' [-Werror=missing-prototypes]
arch/xtensa/kernel/traps.c:484:13: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
arch/xtensa/mm/fault.c:87:6: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
arch/xtensa/platforms/iss/network.c:204:16: error: no previous prototype for 'tuntap_protocol' [-Werror=missing-prototypes]
arch/xtensa/platforms/iss/network.c:444:6: error: no previous prototype for 'iss_net_user_timer_expire' [-Werror=missing-prototypes]


Cc: Matt Turner <mattst88@gmail.com>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Brian Cain <bcain@quicinc.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stafford Horne <shorne@gmail.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-openrisc@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 arch/alpha/Kbuild                  |  2 ++
 arch/alpha/lib/Makefile            |  1 +
 arch/arc/Kbuild                    |  2 ++
 arch/csky/Kbuild                   |  2 ++
 arch/hexagon/Kbuild                |  2 ++
 arch/ia64/Kbuild                   |  2 ++
 arch/ia64/lib/Makefile             |  1 +
 arch/loongarch/Kbuild              |  2 ++
 arch/m68k/Kbuild                   |  2 ++
 arch/m68k/lib/Makefile             |  1 +
 arch/microblaze/Kbuild             |  2 ++
 arch/mips/Kbuild                   |  2 ++
 arch/mips/boot/compressed/Makefile |  3 ++-
 arch/nios2/Kbuild                  |  2 ++
 arch/nios2/lib/Makefile            |  1 +
 arch/openrisc/Kbuild               |  2 ++
 arch/parisc/Kbuild                 |  2 ++
 arch/parisc/lib/Makefile           |  1 +
 arch/sh/Kbuild                     |  2 ++
 arch/sh/boot/compressed/Makefile   |  1 +
 arch/sparc/Kbuild                  |  2 ++
 arch/sparc/lib/Makefile            |  1 +
 arch/sparc/prom/Makefile           |  1 +
 arch/xtensa/Kbuild                 |  2 ++
 arch/xtensa/boot/lib/Makefile      |  2 ++
 init/Kconfig                       | 10 ++++++++++
 26 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/Kbuild b/arch/alpha/Kbuild
index 345d79df24bb9..283cb9d5b022c 100644
--- a/arch/alpha/Kbuild
+++ b/arch/alpha/Kbuild
@@ -4,3 +4,5 @@ obj-$(CONFIG_MATHEMU)	+= math-emu/
 
 # for cleaning
 subdir- += boot
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/alpha/lib/Makefile b/arch/alpha/lib/Makefile
index 1cc74f7b50efb..09e0be65caa93 100644
--- a/arch/alpha/lib/Makefile
+++ b/arch/alpha/lib/Makefile
@@ -5,6 +5,7 @@
 
 asflags-y := $(KBUILD_CFLAGS)
 ccflags-y := -Werror
+ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
 
 # Many of these routines have implementations tuned for ev6.
 # Choose them iff we're targeting ev6 specifically.
diff --git a/arch/arc/Kbuild b/arch/arc/Kbuild
index b94102fff68b4..9bc728209f747 100644
--- a/arch/arc/Kbuild
+++ b/arch/arc/Kbuild
@@ -4,3 +4,5 @@ obj-y += mm/
 
 # for cleaning
 subdir- += boot
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/csky/Kbuild b/arch/csky/Kbuild
index 0621eaea41962..1d4322ebc95e5 100644
--- a/arch/csky/Kbuild
+++ b/arch/csky/Kbuild
@@ -4,3 +4,5 @@ obj-y += kernel/ mm/
 
 # for cleaning
 subdir- += boot
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/hexagon/Kbuild b/arch/hexagon/Kbuild
index 8421baba13518..9aceffc706d4a 100644
--- a/arch/hexagon/Kbuild
+++ b/arch/hexagon/Kbuild
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += kernel/ mm/ lib/
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/ia64/Kbuild b/arch/ia64/Kbuild
index e77cc76d228cd..69e3c2dadde0e 100644
--- a/arch/ia64/Kbuild
+++ b/arch/ia64/Kbuild
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y				+= kernel/ mm/
 obj-$(CONFIG_IA64_SGI_UV)	+= uv/
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/ia64/lib/Makefile b/arch/ia64/lib/Makefile
index 081fcba01dc0c..03999c9f19bb3 100644
--- a/arch/ia64/lib/Makefile
+++ b/arch/ia64/lib/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for ia64-specific library routines..
 #
+ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
 
 lib-y := io.o __divsi3.o __udivsi3.o __modsi3.o __umodsi3.o		\
 	__divdi3.o __udivdi3.o __moddi3.o __umoddi3.o			\
diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
index b01f5cdb27e03..f3b89e5f79050 100644
--- a/arch/loongarch/Kbuild
+++ b/arch/loongarch/Kbuild
@@ -5,3 +5,5 @@ obj-y += vdso/
 
 # for cleaning
 subdir- += boot
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/m68k/Kbuild b/arch/m68k/Kbuild
index 7762af9f6defe..b2abbf427e8f2 100644
--- a/arch/m68k/Kbuild
+++ b/arch/m68k/Kbuild
@@ -18,3 +18,5 @@ obj-$(CONFIG_M68KFPU_EMU)	+= math-emu/
 obj-$(CONFIG_M68000)		+= 68000/
 obj-$(CONFIG_COLDFIRE)		+= coldfire/
 obj-$(CONFIG_VIRT)		+= virt/
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/m68k/lib/Makefile b/arch/m68k/lib/Makefile
index eca17f14b4d5e..3aea84ffa0db2 100644
--- a/arch/m68k/lib/Makefile
+++ b/arch/m68k/lib/Makefile
@@ -3,6 +3,7 @@
 #
 # Makefile for m68k-specific library files..
 #
+ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
 
 lib-y	:= ashldi3.o ashrdi3.o lshrdi3.o muldi3.o \
 	   memcpy.o memset.o memmove.o
diff --git a/arch/microblaze/Kbuild b/arch/microblaze/Kbuild
index 077a0b8e96157..b2799946ae01d 100644
--- a/arch/microblaze/Kbuild
+++ b/arch/microblaze/Kbuild
@@ -6,3 +6,5 @@ obj-y			+= boot/dts/
 
 # for cleaning
 subdir- += boot
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index af2967bffb73d..484cfda563b68 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -28,3 +28,5 @@ endif
 
 # for cleaning
 subdir- += boot
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 6cc28173bee89..58be7966d839f 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -11,9 +11,10 @@
 # Copyright (C) 2009 Lemote Inc. & DSLab, Lanzhou University
 # Author: Wu Zhangjin <wuzhangjin@gmail.com>
 #
-
 include $(srctree)/arch/mips/Kbuild.platforms
 
+ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
+
 # set the default size of the mallocing area for decompressing
 BOOT_HEAP_SIZE := 0x400000
 
diff --git a/arch/nios2/Kbuild b/arch/nios2/Kbuild
index fc2952edd2dec..5f79d266fd4ef 100644
--- a/arch/nios2/Kbuild
+++ b/arch/nios2/Kbuild
@@ -4,3 +4,5 @@ obj-y += kernel/ mm/ platform/ boot/dts/
 
 # for cleaning
 subdir- += boot
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/nios2/lib/Makefile b/arch/nios2/lib/Makefile
index 9d5bf1df520c1..9acc5a98760fa 100644
--- a/arch/nios2/lib/Makefile
+++ b/arch/nios2/lib/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for Nios2-specific library files.
 #
+ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
 
 lib-y += delay.o
 lib-y += memcpy.o
diff --git a/arch/openrisc/Kbuild b/arch/openrisc/Kbuild
index b0b0f2b03f872..ba60f445bf429 100644
--- a/arch/openrisc/Kbuild
+++ b/arch/openrisc/Kbuild
@@ -4,3 +4,5 @@ obj-y += boot/dts/
 
 # for cleaning
 subdir- += boot
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/parisc/Kbuild b/arch/parisc/Kbuild
index a6d3b280ba0c2..b825fb5cf9226 100644
--- a/arch/parisc/Kbuild
+++ b/arch/parisc/Kbuild
@@ -3,3 +3,5 @@ obj-y	+= mm/ kernel/ math-emu/
 
 # for cleaning
 subdir- += boot
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/parisc/lib/Makefile b/arch/parisc/lib/Makefile
index 7b197667faf6c..348a286ab68fe 100644
--- a/arch/parisc/lib/Makefile
+++ b/arch/parisc/lib/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for parisc-specific library files
 #
+ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
 
 lib-y	:= lusercopy.o bitops.o checksum.o io.o memset.o memcpy.o \
 	   ucmpdi2.o delay.o
diff --git a/arch/sh/Kbuild b/arch/sh/Kbuild
index 056efec72c2a0..df2cf06eea5f6 100644
--- a/arch/sh/Kbuild
+++ b/arch/sh/Kbuild
@@ -7,3 +7,5 @@ obj-$(CONFIG_HD6446X_SERIES)	+= cchips/hd6446x/
 
 # for cleaning
 subdir- += boot
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index b5e29f99c02c8..25000003c94eb 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -4,6 +4,7 @@
 #
 # create a compressed vmlinux image from the original vmlinux
 #
+ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
 
 OBJECTS := head_32.o misc.o cache.o piggy.o \
            ashiftrt.o ashldi3.o ashrsi3.o ashlsi3.o lshrsi3.o
diff --git a/arch/sparc/Kbuild b/arch/sparc/Kbuild
index 71cb3d934bf6c..320a4092b334e 100644
--- a/arch/sparc/Kbuild
+++ b/arch/sparc/Kbuild
@@ -12,3 +12,5 @@ obj-$(CONFIG_SPARC64) += vdso/
 
 # for cleaning
 subdir- += boot
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 063556fe2cb1d..2a5cba8e68dfd 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -4,6 +4,7 @@
 
 asflags-y := -ansi -DST_DIV0=0x02
 ccflags-y := -Werror
+ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
 
 lib-$(CONFIG_SPARC32) += ashrdi3.o
 lib-$(CONFIG_SPARC32) += memcpy.o memset.o
diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
index 397b79af77f7b..0a82ebb014130 100644
--- a/arch/sparc/prom/Makefile
+++ b/arch/sparc/prom/Makefile
@@ -4,6 +4,7 @@
 #
 asflags := -ansi
 ccflags := -Werror
+ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
 
 lib-y                 := bootstr_$(BITS).o
 lib-y                 += init_$(BITS).o
diff --git a/arch/xtensa/Kbuild b/arch/xtensa/Kbuild
index fd12f61745bad..f01d1ca727b97 100644
--- a/arch/xtensa/Kbuild
+++ b/arch/xtensa/Kbuild
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += kernel/ mm/ platforms/ boot/dts/
+
+subdir-ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/arch/xtensa/boot/lib/Makefile b/arch/xtensa/boot/lib/Makefile
index 0378a22a08e33..a9f1c1e139389 100644
--- a/arch/xtensa/boot/lib/Makefile
+++ b/arch/xtensa/boot/lib/Makefile
@@ -8,6 +8,8 @@ zlib	:= inffast.c inflate.c inftrees.c
 lib-y	+= $(zlib:.c=.o) zmem.o
 
 ccflags-y	:= -I $(srctree)/lib/zlib_inflate
+ccflags-$(CONFIG_WNO_MISSING_PROTOTYPES) := -Wno-missing-prototypes -Wno-missing-declarations
+
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_inflate.o = -pg
 CFLAGS_REMOVE_zmem.o = -pg
diff --git a/init/Kconfig b/init/Kconfig
index 639e8a3363c30..80cd67c0d7fa4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -170,6 +170,16 @@ config WERROR
 
 	  If in doubt, say Y.
 
+config WNO_MISSING_PROTOTYPES
+	bool "Hide -Wmissing-prototype warnings in arch code"
+	default WERROR || !COMPILE_TEST
+	help
+	  Some architectures have not yet eliminated all warnings for
+	  missing prototypes in their core code and will produce a lot
+	  of output for these. Ideally these should all be addresszed
+	  by individual bugfix patches, but in the meantime saying 'y'
+	  will skip that output.
+
 config UAPI_HEADER_TEST
 	bool "Compile test UAPI headers"
 	depends on HEADERS_INSTALL && CC_CAN_LINK
-- 
2.39.2

