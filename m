Return-Path: <linux-kernel+bounces-23646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678C82AF8D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287811F2172F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1069416407;
	Thu, 11 Jan 2024 13:19:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179215EBD;
	Thu, 11 Jan 2024 13:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C866C433F1;
	Thu, 11 Jan 2024 13:19:20 +0000 (UTC)
Message-ID: <d602919e-2cfb-455a-8a90-76f649d92b39@linux-m68k.org>
Date: Thu, 11 Jan 2024 23:19:18 +1000
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
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Landley <rob@landley.net>
Cc: Petr Vorel <pvorel@suse.cz>, Tim Bird <tim.bird@sony.com>,
 Cyril Hrubis <chrubis@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
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
 <CAMuHMdX5ACKVBQvEwMi7KHZkSVGZPJoocEC1wosfB7zc0u2mbA@mail.gmail.com>
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdX5ACKVBQvEwMi7KHZkSVGZPJoocEC1wosfB7zc0u2mbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/1/24 23:11, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Wed, Jan 10, 2024 at 8:17 PM Rob Landley <rob@landley.net> wrote:
>> You can't fork() on nommu because copies of the mappings have different
>> addresses, meaning any pointers in the copied mappings would point into the OLD
>> mappings (belonging to the parent process), and fixing them up is 100%
>> equivalent to the "garbage collection in C" problem. (It's AI-complete. Of the
>> C3PO kind, not the "autocorrect with syntax checking" kind.) People get hung up
>> on the "it would be very inefficient to do that because no copy-on-write"
>> problem and miss the "the child couldn't FUNCTION because its pointer variables
>> all contain parent addresses" problem.
> 
> Actually you can implement fork(), if you teach the compiler to use
> separate stacks for return addresses and data:
>    - The first stack would contain only absolute addresses, to be
>      relocated after copying,
>    - The second stack would contain integers and relative pointers
>      (see FDPIC below), which do not need relocation after copying.
> 
>> The OTHER fun thing about nommu is you can't run conventional ELF binaries,
>> because everything is linked at fixed address. So you might be able to run ONE
>> instance of the program as your init task, assuming those addresses were
>> available even then, but as soon as you try to run a second one it's a conflict.
>>
>> The quick and dirty work around is to make PIE binaries, which can relocate
>> everything into available space, which works but doesn't scale. The problem with
>> ELF PIE is that everything is linked contiguously from a single base pointer,
>> meaning your text, rodata, data, and bss segments are all one linear blob. So if
>> you run two instances of bash, you've loaded two copies of the test and the
>> rodoata. This fills up your memory fast.
>>
>> AND PIE requires contiguous memory, which nommu is bad at providing because it
>> has no page tables to remap stuff. With an mmu it can coalesce scattered
>> physical pages into a virtually contiguous range, but without an mmu you can
>> have plenty of memory free but in tiny chunks, none big enough to satisfy an
>> allocation request.
>>
>> So they invented FDPIC, which is ELF with FOUR base pointers. Each major section
>> (rodata, text, data, and bss) has its own base pointer, so you need to find
>> smaller chunks of memory to load them into (and thus it can work on a more
>> fragmented system), AND it means that two instances of the same program can
>> share the read-only sections (rodata and text) so you only need new copies of
>> the writeable segments (data and bss. And the heap. And the stack.)
> 
> Or Amiga LoadSeg() relocatable binaries and shared libraries ;-)
> As this supported splitting code, data, and bss in lots of smaller
> hunks, it could counter fragmented memory quite well.
> 
> BTW, can't you run and thus test nommu-binaries under normal Linux, too?

Yes, you can. The flat format loader can be built for MMU arm and m68k Linux.
It will happily load and run flat format binaries on normal VM Linux.
I test that often on m68k (on ColdFire platforms).

Regards
Greg


