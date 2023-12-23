Return-Path: <linux-kernel+bounces-10146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A162081D0B6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67271C221AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84F235EFC;
	Sat, 23 Dec 2023 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NNsCpfSS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9451835EEA;
	Sat, 23 Dec 2023 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [172.20.10.67] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95DFD20AB176;
	Fri, 22 Dec 2023 16:00:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95DFD20AB176
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1703289602;
	bh=ExJOeP20TGJ35wMfC5w/mSmnbO/sjynwNmh04WxJI/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NNsCpfSSC+VbsrHhBb58jJiKib80Vyt86yaJf3rjrBLc6rm2IqP1noL7LYyjs9IIM
	 op6C3ND/GI4XdLHF2KIr8LDR0IluoLPA97Db3ncccRyvmLLOYvpGiQBI3TJxYfvcvb
	 KcjS2Q59jG8cEEk7ia/03tZ3r6lCwKsYER/Oexnw=
Message-ID: <6e7db718-65ec-4461-bab9-0ee4c96c25eb@linux.microsoft.com>
Date: Fri, 22 Dec 2023 16:00:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] acpi: Use access_width over register_width for
 system memory accesses
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Jarred White <jarredwhite@linux.microsoft.com>
Cc: Len Brown <lenb@kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20231216001312.1160-1-jarredwhite@linux.microsoft.com>
 <CAJZ5v0gZ39zJEGV7gQLg6Y0=ke1W7bctqtZ46K+SR9RT5Bx4Hg@mail.gmail.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <CAJZ5v0gZ39zJEGV7gQLg6Y0=ke1W7bctqtZ46K+SR9RT5Bx4Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 12/21/23 06:12, Rafael J. Wysocki wrote:
 > On Sat, Dec 16, 2023 at 1:13 AM Jarred White
 > <jarredwhite@linux.microsoft.com> wrote:
 >>
 >> To align with ACPI 6.3+, since bit_width can be any 8-bit value, we 
cannot
 >> depend on it being always on a clean 8b boundary.
 >
 > So presumably, there are systems out there in which the platform
 > firmware uses bit_width that is not on a clean 8-bit boundary.
 >
 > It would be good to mention them here.

The _CPC package resides in SystemMemory space for the Microsoft Azure 
Cobalt 100 platform that was recently announced.[1] Without this patch, 
the following kernel panic is seen:

Starting Securi[   22.713561] SError Interrupt on CPU26, code 0xbe000011 
-- SError
[   22.713565] CPU: 26 PID: 1510 Comm: systemd-udevd Not tainted 
5.15.2.1-13.cm2 #1
[   22.713567] Hardware name: MICROSOFT CORPORATION C2141/C2141, BIOS 
v1.10.1.0000_dda4ae5a  TfaVersion: v1.10.1.0053_3508b407  HspVersion: 
v1.10.1.164_38ccd
[   22.713569] pstate: 62400009 (nZCv daif +PAN -UAO +TCO -DIT -SSBS 
BTYPE=--)
[   22.713571] pc : cppc_get_perf_caps+0xec/0x410
[   22.713578] lr : cppc_get_perf_caps+0xe8/0x410
[   22.713579] sp : ffff8000155ab730
[   22.713580] x29: ffff8000155ab730 x28: ffff0080139d0038 x27: 
ffff0080139d0078
[   22.713583] x26: 0000000000000000 x25: ffff0080139d0058 x24: 
00000000ffffffff
[   22.713584] x23: ffff0080139d0298 x22: ffff0080139d0278 x21: 
0000000000000000
[   22.713586] x20: ffff00802b251910 x19: ffff0080139d0000 x18: 
ffffffffffffffff
[   22.713587] x17: 0000000000000000 x16: ffffdc7e111bad04 x15: 
ffff00802b251008
[   22.713588] x14: ffffffffffffffff x13: ffff013f1fd63300 x12: 
0000000000000006
[   22.713590] x11: ffffdc7e128f4420 x10: 0000000000000000 x9 : 
ffffdc7e111badec
[   22.713591] x8 : ffff00802b251980 x7 : 0000000000000000 x6 : 
ffff0080139d0028
[   22.713592] x5 : 0000000000000000 x4 : ffff0080139d0018 x3 : 
00000000ffffffff
[   22.713594] x2 : 0000000000000008 x1 : ffff8000155ab7a0 x0 : 
0000000000000000
[   22.713596] Kernel panic - not syncing: Asynchronous SError Interrupt
[   22.713597] CPU: 26 PID: 1510 Comm: systemd-udevd Not tainted 
5.15.2.1-13.cm2 #1
[   22.713599] Hardware name: MICROSOFT CORPORATION C2141/C2141, BIOS 
v1.10.1.0000_dda4ae5a  TfaVersion: v1.10.1.0053_3508b407  HspVersion: 
v1.10.1.164_38ccd
[   22.713600] Call trace:
[   22.713600]  dump_backtrace+0x0/0x1e0
[   22.713603]  show_stack+0x24/0x30
[   22.713604]  dump_stack_lvl+0x8c/0xb8
[   22.713607]  dump_stack+0x18/0x34
[   22.713608]  panic+0x16c/0x384
[   22.713612]  add_taint+0x0/0xc0
[   22.713618]  arm64_serror_panic+0x7c/0x90
[   22.713621]  arm64_is_fatal_ras_serror+0x34/0xa4
[   22.713622]  do_serror+0x50/0x6c
[   22.713623]  el1h_64_error_handler+0x40/0x74
[   22.713628]  el1h_64_error+0x7c/0x80
[   22.713630]  cppc_get_perf_caps+0xec/0x410
[   22.713632]  cppc_cpufreq_cpu_init+0x74/0x400 [cppc_cpufreq]
[   22.713635]  cpufreq_online+0x2dc/0xa30
[   22.713640]  cpufreq_add_dev+0xc0/0xd4
[   22.713642]  subsys_interface_register+0x134/0x14c
[   22.713647]  cpufreq_register_driver+0x1b0/0x354
[   22.713649]  cppc_cpufreq_init+0x1a8/0x1000 [cppc_cpufreq]
[   22.713651]  do_one_initcall+0x50/0x250
[   22.713654]  do_init_module+0x60/0x27c
[   22.713659]  load_module+0x2300/0x2570
[   22.713661]  __do_sys_finit_module+0xa8/0x114
[   22.713663]  __arm64_sys_finit_module+0x2c/0x3c
[   22.713665]  invoke_syscall+0x78/0x100
[   22.713669]  el0_svc_common.constprop.0+0x180/0x1a0
[   22.713671]  do_el0_svc+0x84/0xa0
[   22.713672]  el0_svc+0x2c/0xc0
[   22.713674]  el0t_64_sync_handler+0xa4/0x12c
[   22.713675]  el0t_64_sync+0x1a4/0x1a8
[   22.713677] SMP: stopping secondary CPUs
[   22.714457] Kernel Offset: 0x5c7e008d0000 from 0xffff800010000000
[   22.714458] PHYS_OFFSET: 0x80000000
[   22.714459] CPU features: 0x000001c1,fb337fdb
[   22.714460] Memory Limit: none

I apologize that we couldn't mention this before as the platform was not 
known publicly then.

 >
 >> Instead, use access_width
 >> to determine the size and use the offset and width to shift and mask the
 >> bits we want to read/write out. Make sure to add a check for system 
memory
 >> since pcc redefines the access_width to subspace id.
 >
 > And it would be good to add a comment to the code for it too.

Will do. Jarred is currently on vacation for the end of the year, but 
will respond to this and the comments below once he's back in the new year.

 >
 >>
 >> Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
 >> ---
 >> Original thread
 >> 
https://lore.kernel.org/all/20230925180552.76071-1-jarredwhite@linux.microsoft.com/
 >> ---
 >> changelog:
 >> v1-->v2:
 >>          1. Fixed coding style errors
 >>          2. Backwards compatibility with ioremapping of address still an
 >>             open question. Suggestions are welcomed.
 >>
 >>   drivers/acpi/cppc_acpi.c | 36 +++++++++++++++++++++++++++++++-----
 >>   1 file changed, 31 insertions(+), 5 deletions(-)
 >>
 >> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
 >> index 7ff269a78c20..fb37e1727bf8 100644
 >> --- a/drivers/acpi/cppc_acpi.c
 >> +++ b/drivers/acpi/cppc_acpi.c
 >> @@ -163,6 +163,13 @@ show_cppc_data(cppc_get_perf_caps, 
cppc_perf_caps, nominal_freq);
 >>   show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
 >>   show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, 
wraparound_time);
 >>
 >> +/* Use access_width to determine the total number of bits */
 >> +#define ACCESS_WIDTH_TO_BITS(reg) 8 << ((reg)->access_width - 1)
 >
 > Consider adding parens around the entire expression, or you may get
 > unexpected results.
 >
 >> +
 >> +/* Shift and apply the mask for CPC reads/writes */
 >> +#define MASK_VAL(val) (((val) >> reg->bit_offset) & 
    \
 >> +                                       GENMASK((reg->bit_width), 0))
 >
 > 'reg' should be an argument of the macro or it will be prone to 
subtle mistakes.
 >
 >> +
 >>   static ssize_t show_feedback_ctrs(struct kobject *kobj,
 >>                  struct kobj_attribute *attr, char *buf)
 >>   {
 >> @@ -777,6 +784,7 @@ int acpi_cppc_processor_probe(struct 
acpi_processor *pr)
 >>                          } else if (gas_t->space_id == 
ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 >>                                  if (gas_t->address) {
 >>                                          void __iomem *addr;
 >> +                                       size_t access_width;
 >>
 >>                                          if 
(!osc_cpc_flexible_adr_space_confirmed) {
 >>                                                  pr_debug("Flexible 
address space capability not supported\n");
 >> @@ -784,7 +792,8 @@ int acpi_cppc_processor_probe(struct 
acpi_processor *pr)
 >>                                                          goto out_free;
 >>                                          }
 >>
 >> -                                       addr = 
ioremap(gas_t->address, gas_t->bit_width/8);
 >> +                                       access_width = 
ACCESS_WIDTH_TO_BITS(gas_t) / 8;
 >
 > What would happen if the platform firmware incorrectly provided
 > reg->access_witdh == 0?
 >


<snip>

[1] 
https://azure.microsoft.com/en-us/blog/microsoft-azure-delivers-purpose-built-cloud-infrastructure-in-the-era-of-ai

-- 
Thanks,
Easwar


