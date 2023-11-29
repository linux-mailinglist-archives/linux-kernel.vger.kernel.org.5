Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18B27FCFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjK2H0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjK2HZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:25:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F521C9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:26:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E1FC433C7;
        Wed, 29 Nov 2023 07:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701242765;
        bh=biOcubOKNWe5u7s7FVXUwB6kp4z/tZ1yJjeXTA9SkOQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dKRwAHHxEK5oEbB4OuN7Qe996knj1kcl+SeUFrJixP7nogiWlhFUHk71ZWjMVQqF3
         Q3UCwTPnUgjH2npnOd/pG6pYmU/hqWwS4oyjTO9t6Kkf0LgWfaaFznmPjSVvhLGmd4
         hokbwNlSYWbf/3B8LBv31oNJYY/EucBnOWb6dwn/fTzDAtevKsN91fc+uJjEjXxXMf
         Rx91USHouCFSWsyWJJBAh0nW90HG8tFpnl5ycDkHUSYgKWI6EBGRLR1LOSIkJKBTBl
         J28CNT48lL24GGnIqubtUoGSFMhgMsnoNkW1fV4e8QIDwLJod+ko9SlSfnmL2bj2ZI
         TXNRfSRxghZug==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>,
        Samuel Holland <samuel.holland@sifive.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v4 0/2] riscv: Fix issues with module loading
In-Reply-To: <20231127-module_linking_freeing-v4-0-a2ca1d7027d0@rivosinc.com>
References: <20231127-module_linking_freeing-v4-0-a2ca1d7027d0@rivosinc.com>
Date:   Wed, 29 Nov 2023 08:26:01 +0100
Message-ID: <87bkbd9g1i.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Charlie Jenkins <charlie@rivosinc.com> writes:

> Module loading did not account for multiple threads concurrently loading
> modules. This patch fixes that issue. There is also a small patch to fix
> the type of a __le16 variable.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v4:
> - Make functions only used internally static
> - Free data structures on kmalloc failure (Andreas)
> - Link to v3: https://lore.kernel.org/r/20231122-module_linking_freeing-v=
3-0-8e9e412a3305@rivosinc.com
>
> Changes in v3:
> - Cleanup pointer passing (Samuel)
> - Correct indentation (Samuel)
> - Check for kmalloc failures (Samuel)
> - Link to v2: https://lore.kernel.org/r/20231121-module_linking_freeing-v=
2-1-974bfcd3664e@rivosinc.com
>
> Changes in v2:
> - Support linking modules concurrently across threads.
> - Link to v1: https://lore.kernel.org/r/20231120-module_linking_freeing-v=
1-1-fff81d7289fc@rivosinc.com
>
> ---
> Charlie Jenkins (2):
>       riscv: Safely remove entries from relocation list
>       riscv: Correct type casting in module loading

I got hit by this on QEMU for 6.7-rc3:
  | Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b6=
b83
  | Oops [#1]
  | Modules linked in:
  | CPU: 3 PID: 1 Comm: systemd Not tainted 6.7.0-rc3 #1
  | Hardware name: riscv-virtio,qemu (DT)
  | epc : process_accumulated_relocations+0x70/0x162
  |  ra : process_accumulated_relocations+0x96/0x162
  | epc : ffffffff8000c528 ra : ffffffff8000c54e sp : ff20000000023ab0
  |  gp : ffffffff8257fea0 tp : ff60000080860040 t0 : ff60000083934d68
  |  t1 : 0000000000000006 t2 : 0000000000000002 s0 : ff20000000023b30
  |  s1 : 6b6b6b6b6b6b6b6b a0 : ffffffff80ed48d8 a1 : 0000000000000000
  |  a2 : ff1c0000040a9610 a3 : 0000000000000000 a4 : 0000000000000000
  |  a5 : ff600000832d6990 a6 : ff1c0000040e4d10 a7 : 000000000bbb1d6d
  |  s2 : 0000000000000023 s3 : 0000000000000230 s4 : ffffffff0264dd40
  |  s5 : 000000000000003e s6 : ffffffff81401898 s7 : ffffffff0264d040
  |  s8 : ff60000083934e80 s9 : ffffffff825b7240 s10: ff60000083934de0
  |  s11: ff200000007a25b0 t3 : ffffffff0264d000 t4 : ffffffff0264d040
  |  t5 : 0000000000000017 t6 : ff60000083367eb8
  | status: 0000000200000120 badaddr: 6b6b6b6b6b6b6b83 cause: 0000000000000=
00d
  | [<ffffffff8000c528>] process_accumulated_relocations+0x70/0x162
  | [<ffffffff8000ca9a>] apply_relocate_add+0x142/0x37a
  | [<ffffffff800e79f0>] load_module+0x1720/0x227c
  | [<ffffffff800e8790>] init_module_from_file+0x82/0xba
  | [<ffffffff800e8940>] __riscv_sys_finit_module+0x178/0x300
  | [<ffffffff80ec9160>] do_trap_ecall_u+0xc6/0x142
  | [<ffffffff80ed5cac>] ret_from_exception+0x0/0x64
  | Code: 060d 3783 010d 3823 f804 3b83 018d 6384 8363 0a97 (a903) 0184=20
  | ---[ end trace 0000000000000000 ]---

This series resolved the issue for me.

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
