Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD19E7D7D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjJZHQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZHQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:16:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A891A18D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:16:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso841648a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698304568; x=1698909368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XE9K/zLmyjAI/eqnnXkydpu2Z1qLEJmMy+aUPHF96ls=;
        b=gJJN/Iz2BOQJKpQn0+rR/CippmRqtYSfBcbnmdhwaMfNQEOVVfYrkeHn5kuVoSB6lo
         QdqVOpWmAwk5bO1Qw+1L9rfdAsnqR1gjAeECjmZrsBzu04POABaIBpVSeadDkopeKRAi
         B3S0Fb4PLQGp+a2uOHojbaDcGMJ9S7371K6iFpIvITjKHaQlklRV/T11M0bSF6+Nas+s
         SDq/1xHHUIdhDP8bFzaX4nM9mLS66/f3E2Ub/xF4MZW5MFaJxedZdfdqXUfKDnThxeIT
         /ZZP58f/rCyUOZec8BmMPjG/I5TyJHTb8dOAx59Ae7ENSgNZIpfEO+OhIgem1yhZEJkp
         BAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698304568; x=1698909368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XE9K/zLmyjAI/eqnnXkydpu2Z1qLEJmMy+aUPHF96ls=;
        b=YrLJ63ycowSaQ5aCkmutIFEvnGSVBufRDqJaECkhsxuPyQufm+TcZokRp2z7aF9owF
         X2NDcrSuuJnhCoEZGZRN+s+IwoMtAXn5xI2NLjPUulJ9a49yUg4jIoQovhIpDhRtc7YR
         xCjCtCmu+z1q22MGcouQ2swgtp0D8GabtVuN59Gd17cGhFXw/Rd6SM9X83Oo39Qsxj9x
         suMvI2CusEKg0ME3Pv3zzqQXRwNT8C2EN4jgbSrjcKy/fkTQ56OKTnYy7ZhBojWVr2rI
         GYXDQ4oJQsYkya36ezLBMLH5VY4IW+X9jho8r9DjR92H6XMP3ypQ58ZAxt/iSWlmJJI+
         olxA==
X-Gm-Message-State: AOJu0YwM8wPtctIvBdcf/l2kkftp4P/WpnyZ0/JtYi/wFBKpBmWasq4c
        h0ozvvZvAq0dPlsqNtFf9pbWX79JDSuOOi6CO9k=
X-Google-Smtp-Source: AGHT+IG7HVWFmDZlQ4OjN9X3Rowm9DAorTwDMoPMqOFZgCZydOHrqviKTR2JkKhHG2vJ57fdE3nal8BE40d17b6TWEc=
X-Received: by 2002:a50:9ec5:0:b0:540:2a0c:97a2 with SMTP id
 a63-20020a509ec5000000b005402a0c97a2mr8907566edf.16.1698304567699; Thu, 26
 Oct 2023 00:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231012161237.114733-2-ubizjak@gmail.com> <202310261417.b269d37e-oliver.sang@intel.com>
In-Reply-To: <202310261417.b269d37e-oliver.sang@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 26 Oct 2023 09:15:56 +0200
Message-ID: <CAFULd4ZVBfQEGH0h8v1Br=3DbHteHA9V4u0+m2d5XQPLUu10mA@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/percpu: Use explicit segment registers in lib/cmpxchg{8,16}b_emu.S
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 9:01=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "general_protection_fault:#[##]" on:
>
> commit: 33c7952d925e905f7af1fb7628e48e03f59885da ("[PATCH 1/4] x86/percpu=
: Use explicit segment registers in lib/cmpxchg{8,16}b_emu.S")
> url: https://github.com/intel-lab-lkp/linux/commits/Uros-Bizjak/x86-percp=
u-Use-explicit-segment-registers-in-lib-cmpxchg-8-16-b_emu-S/20231017-11130=
4
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 92fe9bb77b=
0c9fade150350fdb0629a662f0923f
> patch link: https://lore.kernel.org/all/20231012161237.114733-2-ubizjak@g=
mail.com/
> patch subject: [PATCH 1/4] x86/percpu: Use explicit segment registers in =
lib/cmpxchg{8,16}b_emu.S
>
> in testcase: boot
>
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G

This problem was fixed in a -v3 version of the patch [1], that was
committed to the tip/percpu branch and later merged into tip/master.

[1] https://lore.kernel.org/lkml/20231017162811.200569-3-ubizjak@gmail.com/

Thanks,
Uros.

>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +------------------------------------------+------------+------------+
> |                                          | 92fe9bb77b | 33c7952d92 |
> +------------------------------------------+------------+------------+
> | boot_successes                           | 7          | 0          |
> | boot_failures                            | 0          | 7          |
> | general_protection_fault:#[##]           | 0          | 7          |
> | EIP:this_cpu_cmpxchg8b_emu               | 0          | 7          |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 7          |
> +------------------------------------------+------------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202310261417.b269d37e-oliver.san=
g@intel.com
>
>
> [    0.186570][    T0] stackdepot hash table entries: 65536 (order: 6, 26=
2144 bytes, linear)
> [    0.187499][    T0] Initializing HighMem for node 0 (0002ebfe:000bffe0=
)
> [    1.727965][    T0] Initializing Movable for node 0 (00000000:00000000=
)
> [    1.943274][    T0] Checking if this processor honours the WP bit even=
 in supervisor mode...Ok.
> [    1.944313][    T0] Memory: 2896220K/3145208K available (16182K kernel=
 code, 5537K rwdata, 11756K rodata, 816K init, 9720K bss, 248988K reserved,=
 0K cma-reserved, 2379656K highmem)
> [    1.947172][    T0] general protection fault: 0000 [#1] PREEMPT
> [    1.947900][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc1-=
00024-g33c7952d925e #1 8d4b014f9a0a85cc9a3f6a52ed8e88f1e431f74e
> [    1.949317][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 1.950480][ T0] EIP: this_cpu_cmpxchg8b_emu (kbuild/src/consumer/arch/x8=
6/lib/cmpxchg8b_emu.S:73)
> [ 1.951093][ T0] Code: ff ff ff 8d b4 26 00 00 00 00 66 90 83 c6 01 3c 3d=
 0f 95 c0 0f b6 c0 83 c0 01 e9 56 ff ff ff bf ff ff ff ff eb a6 cc cc 9c fa=
 <64> 3b 06 75 13 64 3b 56 04 75 0d 64 89 1e 64 89 4e 04 83 0c 24 40
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   ff                      (bad)
>    1:   ff                      (bad)
>    2:   ff 8d b4 26 00 00       decl   0x26b4(%rbp)
>    8:   00 00                   add    %al,(%rax)
>    a:   66 90                   xchg   %ax,%ax
>    c:   83 c6 01                add    $0x1,%esi
>    f:   3c 3d                   cmp    $0x3d,%al
>   11:   0f 95 c0                setne  %al
>   14:   0f b6 c0                movzbl %al,%eax
>   17:   83 c0 01                add    $0x1,%eax
>   1a:   e9 56 ff ff ff          jmp    0xffffffffffffff75
>   1f:   bf ff ff ff ff          mov    $0xffffffff,%edi
>   24:   eb a6                   jmp    0xffffffffffffffcc
>   26:   cc                      int3
>   27:   cc                      int3
>   28:   9c                      pushf
>   29:   fa                      cli
>   2a:*  64 3b 06                cmp    %fs:(%rsi),%eax          <-- trapp=
ing instruction
>   2d:   75 13                   jne    0x42
>   2f:   64 3b 56 04             cmp    %fs:0x4(%rsi),%edx
>   33:   75 0d                   jne    0x42
>   35:   64 89 1e                mov    %ebx,%fs:(%rsi)
>   38:   64 89 4e 04             mov    %ecx,%fs:0x4(%rsi)
>   3c:   83 0c 24 40             orl    $0x40,(%rsp)
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   64 3b 06                cmp    %fs:(%rsi),%eax
>    3:   75 13                   jne    0x18
>    5:   64 3b 56 04             cmp    %fs:0x4(%rsi),%edx
>    9:   75 0d                   jne    0x18
>    b:   64 89 1e                mov    %ebx,%fs:(%rsi)
>    e:   64 89 4e 04             mov    %ecx,%fs:0x4(%rsi)
>   12:   83 0c 24 40             orl    $0x40,(%rsp)
> [    1.953397][    T0] EAX: c3c01100 EBX: c3c01180 ECX: 00000004 EDX: 000=
00003
> [    1.954231][    T0] ESI: e52cd090 EDI: e52cd090 EBP: c2b4bf00 ESP: c2b=
4bec4
> [    1.955060][    T0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAG=
S: 00210082
> [    1.955949][    T0] CR0: 80050033 CR2: ffdeb000 CR3: 031b5000 CR4: 000=
00090
> [    1.956783][    T0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 000=
00000
> [    1.957641][    T0] DR6: fffe0ff0 DR7: 00000400
> [    1.958190][    T0] Call Trace:
> [ 1.958554][ T0] ? show_regs (kbuild/src/consumer/arch/x86/kernel/dumpsta=
ck.c:479)
> [ 1.959026][ T0] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstac=
k.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460)
> [ 1.959480][ T0] ? exc_general_protection (kbuild/src/consumer/arch/x86/k=
ernel/traps.c:697 kbuild/src/consumer/arch/x86/kernel/traps.c:642)
> [ 1.960101][ T0] ? exc_bounds (kbuild/src/consumer/arch/x86/kernel/traps.=
c:642)
> [ 1.960579][ T0] ? handle_exception (kbuild/src/consumer/arch/x86/entry/e=
ntry_32.S:1049)
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231026/202310261417.b269d37e-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
