Return-Path: <linux-kernel+bounces-163549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E28B6CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92101C22A98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9E71272C7;
	Tue, 30 Apr 2024 08:38:11 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E741C89;
	Tue, 30 Apr 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466290; cv=none; b=DlZ2AJngrLxkbBkw8Ba2JZa7i3d3PZpDZ6xT0ZYvVBDqgptJr49JW4xGIZ0Zd+KcVuiWnk32WBY7RsERybJnThDTxoLnR74eAu3oD3LQYr31qiuClAihaINW2/Vdsy9z7ByHAfSy7kpYi6iUgeUCvv56Y16pxl/L85enXiyliWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466290; c=relaxed/simple;
	bh=xNcZOSiAAXecA4vl6PK9ATXJbcLGbUIzFmTD/xGg1OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h89Fz8a4EqYQ8h62njpHrEhquMT8+T//+7v2NYDJKEOQbc20Fg+0tIRDrVylhk9Nr4RdQWmhbhk3wH5MHMW/3YGGkBDKYXHyfSUdqHOpiVYNFmJTRK3EVNsFt4kXuXd+99Yuq5PMeETaiJf2eVujJQZvbxX6v+vxBNcB8VqKqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA1E0C0005;
	Tue, 30 Apr 2024 08:37:59 +0000 (UTC)
Message-ID: <0049995a-07d0-4aaa-abc7-5bfc0dc22ace@ghiti.fr>
Date: Tue, 30 Apr 2024 10:37:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init: fix allocated page overlapping with PTR_ERR
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Joel Granados <j.granados@samsung.com>
Cc: Mike Rapoport <rppt@kernel.org>, Andreas Dilger <adilger@dilger.ca>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 linux-riscv@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "ndesaulniers @ google . com" <ndesaulniers@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
 Krister Johansen <kjlx@templeofstupid.com>,
 Changbin Du <changbin.du@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240418102943.180510-1-namcao@linutronix.de>
 <CGME20240429125236eucas1p24219f2d332e0267794a2f87dea9f39c4@eucas1p2.samsung.com>
 <20240429125230.s5pbeye24iw5aurz@joelS2.panther.com>
 <20240430073056.bEG4-yk8@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240430073056.bEG4-yk8@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Joel, Nam,

On 30/04/2024 09:31, Nam Cao wrote:
> On Mon, Apr 29, 2024 at 02:52:30PM +0200, Joel Granados wrote:
>> On Thu, Apr 18, 2024 at 12:29:43PM +0200, Nam Cao wrote:
>>> There is nothing preventing kernel memory allocators from allocating a
>>> page that overlaps with PTR_ERR(), except for architecture-specific
>>> code that setup memblock.
>>>
>>> It was discovered that RISCV architecture doesn't setup memblock
>>> corectly, leading to a page overlapping with PTR_ERR() being allocated,
>>> and subsequently crashing the kernel (link in Close: )
>>>
>>> The reported crash has nothing to do with PTR_ERR(): the last page
>>> (at address 0xfffff000) being allocated leads to an unexpected
>>> arithmetic overflow in ext4; but still, this page shouldn't be
>>> allocated in the first place.
>>>
>>> Because PTR_ERR() is an architecture-independent thing, we shouldn't
>>> ask every single architecture to set this up. There may be other
>>> architectures beside RISCV that have the same problem.
>>>
>>> Fix this one and for all by reserving the physical memory page that
>>> may be mapped to the last virtual memory page as part of low memory.
>>>
>>> Unfortunately, this means if there is actual memory at this reserved
>>> location, that memory will become inaccessible. However, if this page
>>> is not reserved, it can only be accessed as high memory, so this
>>> doesn't matter if high memory is not supported. Even if high memory is
>>> supported, it is still only one page.
>>>
>>> Closes: https://lore.kernel.org/linux-riscv/878r1ibpdn.fsf@all.your.base.are.belong.to.us
>>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>>> Cc: <stable@vger.kernel.org> # all versions
>>> ---
>>>   init/main.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/init/main.c b/init/main.c
>>> index 881f6230ee59..f8d2793c4641 100644
>>> --- a/init/main.c
>>> +++ b/init/main.c
>>> @@ -900,6 +900,7 @@ void start_kernel(void)
>>>   	page_address_init();
>>>   	pr_notice("%s", linux_banner);
>>>   	early_security_init();
>>> +	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE); /* reserve last page for ERR_PTR */
>>>   	setup_arch(&command_line);
>>>   	setup_boot_config();
>>>   	setup_command_line(command_line);
>>> -- 
>>> 2.39.2
>>>
>> I received a similar(ish) report recently
>> https://lore.kernel.org/oe-kbuild-all/202404211031.J6l2AfJk-lkp@intel.com/
>> regarding RISC-V in init/mail.c. Here is the meat of the report in case
>> you want to avoid going to the actual link:
> This issue doesn't look like it has anything to do with this patch: this
> patch is about overlapping of dynamically allocated memory, while I think
> the issue is about overlapping sections during linking (maybe something
> wrong with riscv linker script?)
>
> Also, FWIW, this patch is not going to be in mainline because of a
> regression.
>
> Nonetheless, I will have a look at this later.


The config shows that it is a XIP kernel that comes with its own 
limitations (text is limited to 32MB for example), so I'm not surprised 
to see those overlaps.

We already discussed the removal of randconfig builds on XIP configs, 
but IIRC it is not possible.

Alex


>
> Best regards,
> Nam
>
>> "
>> ...
>>     riscv64-linux-ld: section .data LMA [000000000099b000,0000000001424de7] overlaps section .text LMA [0000000000104040,000000000213c543]
>>     riscv64-linux-ld: section .data..percpu LMA [00000000024e2000,00000000026b46e7] overlaps section .rodata LMA [000000000213c580,000000000292d0dd]
>>     riscv64-linux-ld: section .rodata VMA [ffffffff8213c580,ffffffff8292d0dd] overlaps section .data VMA [ffffffff82000000,ffffffff82a89de7]
>>     init/main.o: in function `rdinit_setup':
>>>> init/main.c:613:(.init.text+0x358): relocation truncated to fit: R_RISCV_GPREL_I against symbol `__setup_start' defined in .init.rodata section in .tmp_vmlinux.kallsyms1
>>     net/ipv4/ipconfig.o: in function `ic_dhcp_init_options':
>>     net/ipv4/ipconfig.c:682:(.init.text+0x9b4): relocation truncated to fit: R_RISCV_GPREL_I against `ic_bootp_cookie'
>>     net/sunrpc/auth_gss/gss_krb5_mech.o: in function `gss_krb5_prepare_enctype_priority_list':
>>>> net/sunrpc/auth_gss/gss_krb5_mech.c:213:(.text.gss_krb5_prepare_enctype_priority_list+0x9c): relocation truncated to fit: R_RISCV_GPREL_I against `gss_krb5_enctypes.0'
>>     lib/maple_tree.o: in function `mas_leaf_max_gap':
>>>> lib/maple_tree.c:1512:(.text.mas_leaf_max_gap+0x2b8): relocation truncated to fit: R_RISCV_GPREL_I against `mt_pivots'
>>     lib/maple_tree.o: in function `ma_dead_node':
>>>> lib/maple_tree.c:560:(.text.mas_data_end+0x110): relocation truncated to fit: R_RISCV_GPREL_I against `mt_pivots'
>>     lib/maple_tree.o: in function `mas_extend_spanning_null':
>>>> lib/maple_tree.c:3662:(.text.mas_extend_spanning_null+0x69c): relocation truncated to fit: R_RISCV_GPREL_I against `mt_pivots'
>>     lib/maple_tree.o: in function `mas_mab_cp':
>>>> lib/maple_tree.c:1943:(.text.mas_mab_cp+0x248): relocation truncated to fit: R_RISCV_GPREL_I against `mt_pivots'
>>     lib/maple_tree.o: in function `mab_mas_cp':
>>>> lib/maple_tree.c:2000:(.text.mab_mas_cp+0x15c): relocation truncated to fit: R_RISCV_GPREL_I against `mt_pivots'
>>     lib/maple_tree.o: in function `mas_reuse_node':
>>>> lib/maple_tree.c:3416:(.text.mas_reuse_node+0x17c): relocation truncated to fit: R_RISCV_GPREL_I against `mt_slots'
>>     lib/maple_tree.o: in function `mt_free_walk':
>>>> lib/maple_tree.c:5238:(.text.mt_free_walk+0x15c): relocation truncated to fit: R_RISCV_GPREL_I against `mt_slots'
>>     lib/maple_tree.o: in function `mtree_lookup_walk':
>>     lib/maple_tree.c:3700:(.text.mtree_lookup_walk+0x94): additional relocation overflows omitted from the output
>> ...
>>
>> "
>>
>> Could the fix that you have posted here be related to that report?
>> Comments are greatly appreciated.
>>
>> Best
>> --
>>
>> Joel Granados
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

