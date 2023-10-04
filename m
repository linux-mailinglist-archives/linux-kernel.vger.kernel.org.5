Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8D77B8393
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjJDP3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjJDP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:29:53 -0400
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8865D7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=To:Cc:Date:Message-Id:Subject:Mime-Version:Content-Transfer-Encoding:Content-Type:From; bh=/PgdQTmco8ZwpyZmEPAcxpSTMh9LHBn0yMtUsnep+HY=;
        b=Gb8mlIkUPXj65owXhrTnOGqrpVt6U++0wXK9H4GdNXjG4NcFkgAM+jKQhKj6uSDxsvNPWAeFzjdZEeFAjBoZX7bmNf0Y5Zb9PBzAWPgUC+rcgwHHxeW2TaHci4nhY9UWLnU3H35sZEAqONVSYJwvDS88EQNI1y1IJNEfBkpOgQY=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1qo3pQ-0007tA-IR; Wed, 04 Oct 2023 15:30:24 +0000
Received: from [192.168.2.109] (helo=smtpclient.apple)
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1qo3qM-0008Nm-Bu; Wed, 04 Oct 2023 15:31:23 +0000
From:   =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: [RFC] AMD Zen4 CPU bug? Spurious SMT Sibling Invalid Opcode
 Speculation
Message-Id: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
Date:   Wed, 4 Oct 2023 17:29:32 +0200
Cc:     Boris Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org, x86@vger.kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Score: -0.5 (/)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

during cross compiling our =E2=80=9CEmbedded=E2=80=9D Linux Distribution =
T2 (https://t2sde.org) I observers some random illegal instruction build =
errors since we got ourselves a Ryzen 7950x on launch day a year ago:

vendor_id : AuthenticAMD
cpu family : 25
model : 97
model name : AMD Ryzen 9 7950X 16-Core Processor
stepping : 2
microcode : 0xa601203

Initially I thought it must surely be some early system instability, and =
some DDR5 AGESA and microcode updates will eventually take care of that. =
Month after month passed and so far no BIOS update helped. So I finally =
started to investigate this over the last months, run the DDR5 memory at =
base clock, then disabled Precision Boost, and at the end run the CPU =
and RAM even below advertised base clock and the pseudo random illegal =
instructions at some gcc instances where still observed and I started to =
realized they where actually 99% quite identical around gcc user-space =
address 0xc0e0c0 (sometimes slightly off like 0xc08aaf):

during GIMPLE pass: switchlower
../src/intel/vulkan/anv_nir_lower_ubo_loads.c: In function =
'lower_ubo_load_instr':
../src/intel/vulkan/anv_nir_lower_ubo_loads.c:28:1: internal compiler =
error: Illegal instruction
   28 | lower_ubo_load_instr(nir_builder *b, nir_instr *instr, UNUSED =
void *_data)
      | ^~~~~~~~~~~~~~~~~~~~
0x1435c95 internal_error(char const*, ...)
        ???:0
0xc0e0c0 =
tree_switch_conversion::switch_decision_tree::try_switch_expansion(vec<tre=
e_switch_conversion::cluster*, va_heap, vl_ptr>&)
        ???:0
0xc0eb69 =
tree_switch_conversion::switch_decision_tree::analyze_switch_statement()
        ???:0

   0x0000000000c0e0b6 <+246>:   cmp    $0xffffffff,%r14d
   0x0000000000c0e0ba <+250>:   je     0xc0e190 =
<_ZN22tree_switch_conversion20switch_decision_tree20try_switch_expansionER=
3vecIPNS_7clusterE7va_heap6vl_ptrE+464>
   0x0000000000c0e0c0 <+256>:   mov    %rax,%rcx # <----- HERE -----!
   0x0000000000c0e0c3 <+259>:   cmpb   $0x0,0xa8(%r13)
   0x0000000000c0e0cb <+267>:   jne    0xc0e060 =
<_ZN22tree_switch_conversion20switch_decision_tree20try_switch_expansionER=
3vecIPNS_7clusterE7va_heap6vl_ptrE+160>
   0x0000000000c0e0cd <+269>:   mov    0xa0(%r13),%rsi
   0x0000000000c0e0d4 <+276>:   mov    $0x8,%eax

The illegal instructions only occur sometimes, so rebuilding a package =
is usually successful.
To rule out any software inherited instability, I booted the bit =
identical system copy (using rsync) on a Ryzen 5950x and could build all =
the system using the identical kernel and gcc binaries without any such =
spurious illegal instructions.

This appeared to mostly show up with gcc as cross compiled for sparc64, =
but that should not matter, as this ist just generic x86-64(-v1) code =
that in similar sequence, memory access and I/O pattern could likely =
appear in any other sophisticated and complex enough user-space program.

Trying to further narrow this down, and wether it is just one defect =
core, I patched the kernel to show the likely CPU. Not sure if this is =
the most reliable, but that is the patch:

--- linux-6.5/arch/x86/kernel/traps.c.orig      2023-10-02 =
11:53:47.413623693 +0200
+++ linux-6.5/arch/x86/kernel/traps.c   2023-10-02 11:53:58.580624927 =
+0200
@@ -294,8 +294,12 @@
 static inline void handle_invalid_op(struct pt_regs regs)
 #endif
 {
+       void __useraddr =3D error_get_trap_addr(regs);
+       int cpu =3D raw_smp_processor_id();
+       printk("INVALID OPCODE: %lx likely on CPU %d (core %d, socket =
%d)\n",
+               cpu, addr, topology_core_id(cpu), =
topology_physical_package_id(cpu));
        do_error_trap(regs, 0, "invalid opcode", X86_TRAP_UD, SIGILL,
ILL_ILLOPN, error_get_trap_addr(regs));
+                     ILL_ILLOPN, addr);
 }

This showed number over all cores and CCX to be affected:

[ 1901.688448] INVALID OPCODE: c0e0c0 likely on CPU 26 (core 10, socket =
0)
[ 1930.529211] INVALID OPCODE: c0e0c0 likely on CPU 21 (core 5, socket =
0)
[ 1971.898911] INVALID OPCODE: c0e0c0 likely on CPU 27 (core 11, socket =
0)
[ 2006.781557] INVALID OPCODE: c0e0c0 likely on CPU 19 (core 3, socket =
0)
[ 2054.672900] INVALID OPCODE: c0e0c0 likely on CPU 30 (core 14, socket =
0)
[ 2097.180969] INVALID OPCODE: c0e0c0 likely on CPU 27 (core 11, socket =
0)
[ 2140.558150] INVALID OPCODE: c0e0c0 likely on CPU 23 (core 7, socket =
0)
[ 2168.601674] INVALID OPCODE: c0e0c0 likely on CPU 15 (core 15, socket =
0)
=E2=80=A6

I sorted the result # dmesg | grep INVALID| sed 's/.*://' | cut -d ' ' =
-f 6| sort -n| uniq -c
      4 0
      2 1
      2 2
      2 3
      5 4
      5 5=20
      3 7=20
      4 8=20
      4 9=20
      2 10
      4 11
      3 12
      5 13
      5 14
      2 15
      6 16
      8 17
      2 18
      5 19
      5 20
      3 21
      7 22
      5 23
      3 24
      2 25
      2 26
      3 27
      4 28
      4 29
      6 30
      5 31

Already discussing this issue with some other folks and kernel developer =
it was suggested it could be TLB related, and we realized we were =
booting with mitigations=3Doff for a little higher all system =
compilation performance and I can report that without mitigations=3Doff =
this spurious illegal instructions do not appear. Also disabling SMT =
makes the problem disappear, too.

So I iterated over all the mitigation options and found =
spectre_v2_user=3Doff to be enough to make this bug reproducibly appear =
when loading most cores running this sparc64-t2-linux-gcc.

Now the good news is: running with modern security mitigations enabled =
hides this what to me looks like a Zen 4 SMT sibling processor state =
corruption bug or mis-speculation. However, I would argue, non malicious =
user-more programs should not exhibit spurious illegal instructions with =
an operating system running in a classic, high performance mode without =
any special security mitigations in place.

As this is very reproducible with GCC for sparc64 for me, I created an =
initrd with a pre-processed source file (from Mesa IIRC) setup to boot =
into a loop running sparc64-t2-linux-gcc on all cores (all grouped in =
usr/local) for others to test how widespread this issue is:

https://dl.t2sde.org/amd-zen4-smt-c0fefe/

Boot with:
spectre_v2_user=3Doff or mitigations=3Doff

It is even reproducible in qemu/kvm running on a host with this =
spectre_v2_user=3Doff:
qemu-system-x86_64 --enable-kvm -smp 32 -cpu host -m 4G -kernel =
vmlinuz-6.5.5-t2 -initrd initrd-6.5.5-t2.gz -nographic -append =
"console=3DttyS0"

To test on your system with chroot:
mkdir bug; cd bug; gunzip ../initrd-6.5.5-t2 | cpio -i
chroot . usr/local/init

With this reduced test case illegal instructions appear within an =
average of just 5 seconds on my Ryzen 7950x.

To rule out that this is some random linux kernel config and =
optimization fluke, I built the kernel with clang and gcc, without any =
change, and also downloaded the latest Intel Clear Linux kernel binary =
to double checked that it is affected in the same way, and sure it does.

After all this research, to me this looks like an Zen 4 CPU bug, but any =
other comments, hints, patches welcome!

I realize AMD has never microcode for Epyc server CPUs, if this is =
already fixed in some newer microcode, it would really be amazing (hint) =
if AMD would release microcode updates for $999 consumer CPUs in a more =
timely manner, and not only high end server SKUs via linux-firmware, ...

Thank you so much,

Ren=C3=A9 Rebe

--
ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
http://exactcode.com | http://exactscan.com | http://ocrkit.com

