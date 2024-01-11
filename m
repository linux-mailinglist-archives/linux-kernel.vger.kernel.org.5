Return-Path: <linux-kernel+bounces-22977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AC882A5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4858A283653
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F6EBC;
	Thu, 11 Jan 2024 02:25:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20523A3C;
	Thu, 11 Jan 2024 02:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720CAC433C7;
	Thu, 11 Jan 2024 02:25:48 +0000 (UTC)
Message-ID: <81c07a13-305a-404b-b14c-3aff8fde3f67@linux-m68k.org>
Date: Thu, 11 Jan 2024 12:25:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Automated-testing] Call for nommu LTP maintainer [was: Re:
 [PATCH 00/36] Remove UCLINUX from LTP]
Content-Language: en-US
To: Rob Landley <rob@landley.net>, Petr Vorel <pvorel@suse.cz>,
 Tim Bird <tim.bird@sony.com>
Cc: Cyril Hrubis <chrubis@suse.cz>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>,
 "buildroot@buildroot.org" <buildroot@buildroot.org>,
 Niklas Cassel <niklas.cassel@wdc.com>
References: <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik> <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <20240110141455.GC1698252@pevik>
 <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry Rob, but I think you are wrong about a number of things here.
I know, I was there at the coal face so to speak during the early
years of uClinux and right up today. I feel I have to correct some of
the things you claim.


On 11/1/24 05:23, Rob Landley wrote:
> On 1/10/24 08:14, Petr Vorel wrote:
>> There is MAP_PRIVATE_EXCEPT_UCLINUX constant to avoid using MAP_PRIVATE on
>> uClinux, who knows if this is relevant on nommu?
> 
> MAP_PRIVATE creates a copy-on-write mapping, and doing copy-on-write requires an
> MMU. (You mark it read only in the page table, take a fault when they try to
> write, the fault handler allocates a new physical page, copies the old contents
> to it, marks it writeable, and returns allowing the write to complete to the new
> page.)
> 
> On NOMMU you can MAP_SHARED and MAP_ANON, but not MAP_PRIVATE.
> 
> Swap is implemented kind of similarly, except when you recycle pages you mark
> them as neither readable nor writeable in the page table, schedule the page's
> contents to be written to disk, suspend the process so the scheduler can go run
> something else, and then when you get the I/O completion interrupt you mark the
> page free so whatever else needed a page can use it. And then when the process
> tries to access the page the fault handler reverses the process, allocating a
> new physical page and load in the contents back in while the process is
> suspended waiting for that to finish. Can't do that without an MMU either.
> 
>>> 3) what the desired roadmap going forward would be, to continue to support this code.
>>
>> All LTP tests are being rewritten to use new API since 2016 (new API was
>> introduced in 20160510), thus we are loosing the support with old API going
>> away. Sure, I can hold on this patchset and we continue removing the
>> functionality tests manually. But sooner or later it's gone.
> 
> You can't fork() on nommu because copies of the mappings have different
> addresses, meaning any pointers in the copied mappings would point into the OLD
> mappings (belonging to the parent process), and fixing them up is 100%
> equivalent to the "garbage collection in C" problem. (It's AI-complete. Of the
> C3PO kind, not the "autocorrect with syntax checking" kind.) People get hung up
> on the "it would be very inefficient to do that because no copy-on-write"
> problem and miss the "the child couldn't FUNCTION because its pointer variables
> all contain parent addresses" problem.
> 
> So instead vfork() creates a child with all the same memory mappings (a bit like
> a thread) and freezes the parent process until that child discards those
> mappings, either by calling exec() or _exit(). (At which point the parent gets
> un-suspended.)

Just to be clear, vfork is not a uClinux invention. It dates way back to the
early BSD UNIX days. It just so happens that it fits in very nicely with
the no-MMU model of the world.


> The child can do quite a lot of setup before calling exec, it already has its
> own filehandle table for example, but it has to be really careful about MEMORY.
> Anything it writes to global variables the parent will see, any changes to the
> heap persist in the parent, and anything it writes to local variables the parent
> MAY see. (Systems have historically differed about whether the vfork() child
> gets a new stack like a thread would, or keeps using the parent's mapping since
> the new stack would be quickly discarded anyway. If you call into a new setup()
> function after vfork() it doesn't matter much either way, but do NOT return from
> the function that called vfork(): either your new stack hasn't got anything to
> return to or you'll corrupt the parent's stack by overwriting its return address
> so when the parent exits from its current function it jumps to la-la land.)
> 
> The OTHER fun thing about nommu is you can't run conventional ELF binaries,
> because everything is linked at fixed address. So you might be able to run ONE
> instance of the program as your init task, assuming those addresses were
> available even then, but as soon as you try to run a second one it's a conflict.
> 
> The quick and dirty work around is to make PIE binaries, which can relocate
> everything into available space, which works but doesn't scale. The problem with
> ELF PIE is that everything is linked contiguously from a single base pointer,
> meaning your text, rodata, data, and bss segments are all one linear blob. So if
> you run two instances of bash, you've loaded two copies of the test and the
> rodoata. This fills up your memory fast.
> 
> AND PIE requires contiguous memory, which nommu is bad at providing because it
> has no page tables to remap stuff. With an mmu it can coalesce scattered
> physical pages into a virtually contiguous range, but without an mmu you can
> have plenty of memory free but in tiny chunks, none big enough to satisfy an
> allocation request.
> 
> So they invented FDPIC, which is ELF with FOUR base pointers. Each major section
> (rodata, text, data, and bss) has its own base pointer, so you need to find
> smaller chunks of memory to load them into (and thus it can work on a more
> fragmented system), AND it means that two instances of the same program can
> share the read-only sections (rodata and text) so you only need new copies of
> the writeable segments (data and bss. And the heap. And the stack.)

It is worth noting that to run PIE style ELF binaries on no-MMU systems you
actually use the FDPIC ELF loader - not the traditional linux ELF loader (binfmt_elf).
Using this setup is going to become much easier now that uClibc has native
support for generating a relevant library and ld.so for noMMU linux (certainly
for m68k, arm and riscv at least) - as of version 1.0.45.


> (The earlier binflt format is an a.out variant with 4 base pointers. FDPIC is
> the ELF version of the same idea. Since a.out went bye-bye binflt is obsolete,
> but not everybody's moved off it yet because so many nommu people are still
> using 2.6 or even earlier, and also using gcc 3.x or 2.x toolchains.)

Flat format (binfmt_flat) is in no way related to a.out. It is not derived from
it and shares nothing with it. A.out being removed from the kernel in no way affects
flat format. It doesn't magically make it obsolete. It isn't going anywhere.

I don't see how this is related to versions of kernel or gcc or toolchains either.
Flat format works on every kernel up to todays v6.7. The conversion tool works
with the latest gcc and binutils (gcc-13.2 and bintuils-2.41 as of today) and many
versions going back for the best part of 20 years. Sure that elf2flt tool has been
forked a lot it has a spotty history of getting updated. But, hey, as of today it
looks pretty up to date across most architectures.


> Oh, the OTHER thing is none of this is deferred allocation, it's all up front.
> On systems with mmu you can populate large empty virtual mappings that read as
> zeroed but it's actually redundant copy-on-write instances of the zero page, and
> when you write to them it takes a soft fault and the fault handler allocates the
> page you dirtied when you dirty it. On nommu, if you want a 4 megabyte mapping
> you have to find 4 contiguous megabyte and allocate it immediately, or else the
> mmap() or malloc() returns failure. (On systems with mmu malloc() almost never
> returns NULL, because you've got virtual address space coming out of your ears
> and if you ACTUALLY run out of memory that's happens way later, the OOM killer
> triggers long after malloc() returned success. But on a nommu system, malloc()
> returns NULL all the time, even if you THINK you have enough memory, because
> what's left is too fragmented to contain a free chunk THAT BIG...)
> 
> This impacts the stack. On MMU Linux, the default stack size is 8 megs but it's
> seldom all used. On nommu linux, that would be RIDICULOUS because A) it would
> always be allocated to its full size right up front, B) you'd need contiguous
> memory for it. So instead you set the default stack size when building the
> linker (you can also set it on the ld command line), and common sizes range from
> 8k to maybe 256k depending on what you expect to be running. Toybox tries not to
> use more than 16k stack, although I usually test it with 32k on nommu. (There's
> no guard page to tell you when you went off the edge, because no MMU so no page
> faults, but you can check that the stack page at end-16k is still clean at exit
> if you like. Some nommu hardware has range registers, but Linux has never
> supported them that I'm aware of.)
> 
> There's not THAT much to learn about NOMMU. It could all be covered in an hour
> presentation at a conference, I expect?
> 
>> One can check files which had special handling in the old API:
>>
>> $ git grep -l UCLINUX 20160126 -- testcases/ | wc -l
>> 173
>>
>> What is supported now:
>>
>> $ git grep -l UCLINUX  -- testcases/  |wc -l
>> 55
> 
> UCLINUX is a long-dead distro. Linaro died in the dot-com crash and its founder
> Jeff Dionne moved to Japan for his next gig and never came back. On the way out
> he handed uclinux off to someone else, who didn't do a lot of work maintaining
> it. Most of the actual support went "upstream" into various packages (linux and
> busybox and gcc and so on) before the handoff, so you didn't NEED uclinux anymore.

Why do you keep claiming that "UCLINUX" (why all caps?) is a distro?
That is just not the case. uClinux has been used as an umbrella term for
patches, tools, packages relating to running Linux on a CPU with no MMU.

There was a build package called uclinux-dist that you might consider a distro.
But it has always been cleanly named as "uclinux-dist". For a long time that
was the goto starting point for anyone wanting to use Linux with no-MMU.
The collection of patches to the toolchains, kernel, libraries and application
packages was a pretty high mountain to climb to get started in those early
days (late 90's and early 2000's). But through the work of a _lot_ of people
much of that change has made its way into relevant packages across the board
(from gcc to kernel to creation of uClibc, etc).

But lets face it once no-MMU support was integrated into mainline linux as off
v2.5.46 it is really now just "Linux". The no-MMU support outgrew that trade marked
term. But the name has stubbornly stuck around.


> The real nail in the coffin is the inheritor of uclinux never migrated it off
> CVS, and then the disk holding the CVS archive crashed with no backup. He came
> out with a couple more releases after that by monkey-patching the last release's
> filesystem, but the writing was on the wall and it rolled to a stop.

No, the public facing CVS was never the master sources for the uclinux-dist.
The public facing CVS was only ever a copy of the tar ball releases.
Its loss was annoying to some who used it but had no real impact on the
development. Its development model was kind of "internal" and published
at random points in time. Today that is what probably most people would
call the "vendor" distro model.

That work was slowing down due to fact that it just wasn't really
needed any more. There are way more popular build systems (eg build-root)
for building complete firmware images from scratch.


> I did a triage of its last release (from 2014) as part of my toybox roadmap:

No, the last release was in 2016, see it archived at:
https://sourceforge.net/projects/uclinux/files/uClinux%20Stable/

But that is all kind of archeological now, relegated to history.

Regards
Greg


