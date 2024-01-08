Return-Path: <linux-kernel+bounces-19926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB98276E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7730F1F223D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBB856448;
	Mon,  8 Jan 2024 17:58:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1655762
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAFECC15;
	Mon,  8 Jan 2024 09:59:08 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFC303F73F;
	Mon,  8 Jan 2024 09:58:21 -0800 (PST)
Date: Mon, 8 Jan 2024 17:58:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Brandt, Oliver - Lenze" <oliver.brandt@lenze.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"will@kernel.org" <will@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: mm: disable PAN during caches_clean_inval_user_pou
Message-ID: <ZZw3uIyF-b9oSCIK@FVFF77S0Q05N>
References: <e6dc8a44a140d1e54bc1408c36704b581433ec10.camel@lenze.com>
 <ZZwa0msD9KSJg54-@FVFF77S0Q05N>
 <15b92eff2767926aa345e159964e342e3b7192ca.camel@lenze.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15b92eff2767926aa345e159964e342e3b7192ca.camel@lenze.com>

On Mon, Jan 08, 2024 at 04:37:37PM +0000, Brandt, Oliver - Lenze wrote:
> > On Mon, Jan 08, 2024 at 01:00:39PM +0000, Brandt, Oliver - Lenze wrote:
> > > Using the cacheflush() syscall from an 32-bit user-space fails when
> > > ARM64_PAN is used. We 'll get an endless loop:
> > > 
> > >       1. executing "dc cvau, x2" results in raising an abort
> > >       2. abort handler does not fix the reason for the abort and
> > >          returns to 1.
> > > 
> > > Disabling PAN for the time of the cache maintenance fixes this.
> > 
> > Hmm... the ARM ARM says PSTATE.PAN is not supposed to affect DC CVAU.
> > 
> > Looking at the latest ARM ARM (ARM DDI 0487J.a), R_PMTWB states:
> > 
> > > The PSTATE.PAN bit has no effect on all of the following:
> > > 
> > > o Instruction fetches.
> > > o Data cache instructions, except DC ZVA.
> > > o If FEAT_PAN2 is not implemented, then address translation instructions.
> > > o If FEAT_PAN2 is implemented, then the address translation instructions
> > >   other than AT S1E1RP and AT S1E1WP.
> > 
> > So IIUC, DC CVAU shouldn't be affected by PAN.
> 
> Ups... Sorry, didn't noticed this.

No worries; this is not at all obvious!

> > This could be a CPU bug; which CPU are you seeing this with?
> 
> I've stumbled about this while using Intel's simulator "Simics" with a
> model of the upcoming "Agilex5 socfpga". The "Agilex5" is a SoC
> containing two Cortex A76 and two Cortex A55.

Ah, so it could be a bug in Simics, then.

> We are expecting the real silicon in a couple of weeks. Seems to be a
> good idea to check the silicon first. Sorry to bother you with this.

Just to make sure I ran a quick test on an AML-905D3-CC board (quad-core
Cortex-A55), and AFAICT we're not taking unexpected faults. Log below,
including the test case.

If you do see problems on silicon, please let us know!

Mark.

---->8----
mark@flodeboller:~/test/aarch32-cacheflush$ sudo dmesg | grep -i access
[    0.010476] CPU features: detected: Privileged Access Never
mark@flodeboller:~/test/aarch32-cacheflush$ cat test.c
#include <stdio.h>

void cacheflush(void *start, size_t size)
{
        printf("Attempting flush of [%p..%p]\n", start, start + size);
        __builtin___clear_cache(start, start + size);
}

int main(int argc, char *argv[])
{
        static char buf[4096];

        cacheflush(buf, sizeof(buf));

        cacheflush(NULL, sizeof(buf));

        return 0;
}
mark@flodeboller:~/test/aarch32-cacheflush$ arm-linux-gnueabihf-gcc test.c -o test -O3
mark@flodeboller:~/test/aarch32-cacheflush$ file test
test: ELF 32-bit LSB pie executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, BuildID[sha1]=a53713f6b623b9b7c29cee4dc615fb7d43a0dcb6, for GNU/Linux 3.2.0, not stripped
mark@flodeboller:~/test/aarch32-cacheflush$ strace ./test
execve("./test", ["./test"], 0xffffd7e09890 /* 25 vars */ <unfinished ...>
[ Process PID=7682 runs in 32 bit mode. ]
strace: WARNING: Proper structure decoding for this personality is not supported, please consider building strace with mpers support enabled.
<... execve resumed>)                   = 0
brk(NULL)                               = 0x222b000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
statx(3, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|0644, stx_size=31402, ...}) = 0
mmap2(NULL, 31402, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7b0b000
close(3)                                = 0
openat(AT_FDCWD, "/lib/arm-linux-gnueabihf/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\3\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0i\344\1\0004\0\0\0"..., 512) = 512
statx(3, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFREG|0755, stx_size=1102644, ...}) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7b09000
mmap2(NULL, 1139660, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf79f2000
mmap2(0xf7afc000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x109000) = 0xf7afc000
mmap2(0xf7aff000, 37836, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7aff000
close(3)                                = 0
set_tls(0xf7b09ce0)                     = 0
set_tid_address(0xf7b09848)             = 7682
set_robust_list(0xf7b0984c, 12)         = 0
rseq(0xf7b09cc0, 0x20, 0, 0xe7f5def3)   = 0
mprotect(0xf7afc000, 8192, PROT_READ)   = 0
mprotect(0x572000, 4096, PROT_READ)     = 0
mprotect(0xf7b31000, 4096, PROT_READ)   = 0
ugetrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
munmap(0xf7b0b000, 31402)               = 0
statx(1, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, STATX_BASIC_STATS, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFCHR|0620, stx_size=0, ...}) = 0
getrandom("\x79\xe4\xe7\x57", 4, GRND_NONBLOCK) = 4
brk(NULL)                               = 0x222b000
brk(0x224c000)                          = 0x224c000
write(1, "Attempting flush of [0x573040..0"..., 41Attempting flush of [0x573040..0x574040]
) = 41
cacheflush(0x573040, 0x574040, 0)       = 0
write(1, "Attempting flush of [(nil)..0x10"..., 36Attempting flush of [(nil)..0x1000]
) = 36
cacheflush(0, 0x1000, 0)                = -1 EFAULT (Bad address)
exit_group(0)                           = ?
+++ exited with 0 +++ 

