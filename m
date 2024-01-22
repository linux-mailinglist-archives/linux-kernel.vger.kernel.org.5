Return-Path: <linux-kernel+bounces-33895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A28837004
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FA11C257F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392955D75C;
	Mon, 22 Jan 2024 18:05:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE125D74F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946746; cv=none; b=T2fvaMUpuoXQX3P45Jv/HMuAEdwYqhmPQlVy/Pjmwu9jV2j9Nf2IW+jgDCYUOP3iQuV6RGXYy891kuagXNLBCu9Hw/aH6Gcp9EKBsDbWK248j1XTFBsgni2VjEXxwV2+2/JgdaeaPR0AuGNvjwH/kQjAgnhoddRlRi6KkS4CjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946746; c=relaxed/simple;
	bh=ywSMKNUpfoIudE9QTwBf2gl5hq63/kmu+8bfghyi3NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aK/EPzVyai9bbzef+vyhFkV6xr2rOqmnCgSjhQSp1PnVXMBQ15Sv445sy+8ILoi8N8fGZu4zvLuChunPVpbSPI9MZi2ORFmhjx3Qvf+JepdlsbxdWANdCCuafUZ6KxB0OJIkovSvcY2EeQKJuXmqhJ8bnFD/57UL69FzjWOH9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F818113E;
	Mon, 22 Jan 2024 10:06:30 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAEB43F5A1;
	Mon, 22 Jan 2024 10:05:41 -0800 (PST)
Message-ID: <6eecc051-8e8c-fae9-0889-af6998e10be4@arm.com>
Date: Mon, 22 Jan 2024 18:05:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 08/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
Content-Language: en-GB
To: Peter Newman <peternewman@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com,
 amitsinght@marvell.com
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-9-james.morse@arm.com>
 <CALPaoCi_3aPQ1cebtJLtnNEGjiAX8WjJcHP008wAOh0h+O=trQ@mail.gmail.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCi_3aPQ1cebtJLtnNEGjiAX8WjJcHP008wAOh0h+O=trQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Peter,

On 04/01/2024 19:13, Peter Newman wrote:
> On Fri, Dec 15, 2023 at 9:44 AM James Morse <james.morse@arm.com> wrote:
>>  void free_rmid(u32 closid, u32 rmid)
>> @@ -792,13 +813,33 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>>  static int dom_data_init(struct rdt_resource *r)
>>  {
>>         u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>> +       u32 num_closid = resctrl_arch_get_num_closid(r);

> Which resource is this again? Surely the one with the smallest number
> of CLOSIDs?

Today it's implicitly L3 because that is the only one resctrl supports monitoring on


> It's not much harm if the array is bigger than it needs to be, but

Heh, this use of this variable is behind those IS_ENABLED(), which means it gets removed
unless you are on an MPAM system. MPAM always has to sanitise these fields as not all the
hardware is exposed to resctrl.
(e.g. L3 and MB might support 16 CLOSID, but if there is an invisible system-cache in
between them that only supports 8 CLOSID, the system-wide value has to be 8, regardless of
what the hardware supports.)

The MPAM driver finds the system wide value here:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_devices.c?h=mpam/snapshot/v6.7-rc2#n757

And regardless of which resource you select, returns that value here:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_resctrl.c?h=mpam/snapshot/v6.7-rc2#n128

On x86 the helper returns the hardware num CLOSID so that the resctrl sanitisation does
the right thing.

I'll add a comment that this may over-allocate if the architecture isn't pre-sanitising
this field:
|                /*
|                 * If the architecture hasn't provided a sanitised value here,
|                 * this may result in larger arrays than necessary. Resctrl will
|                 * use a smaller system wide value based on the resources in
|                 * use.
|                 */


> I've become curious about how The Monitoring Resource is used in the
> code when there are later changes[1] which would cause this function
> to be called on RDT_RESOURCE_L3, RDT_RESOURCE_MBA, or both.

I need to digest Tony's series. Today the event names all have L3 in them - the MPAM
driver is ignoring both this and the resources, and relying on heuristics to pick
something to back these counters with. Something is better than nothing,.
I agree it can be improved as resctrl allows more things to be exposed.


> Given that we have hardware with event counters residing at different
> levels of the topology and possibly being associated with different
> rdt_resources, more attention needs to be paid to how these parameters
> are used in code related to monitoring.

Certainly there are likely to be weirdness in what the MPAM driver picks here. Those
patches are marked untested for a reason! I have nothing I can test the bandwidth counters on.

My intention here is that 'things that look like a Xeon' should behave equivalently as far
as resctrl can see. That gets any existing software working. Beyond that we can talk about
extending what we have to better cover the hardware people have built.

I'm coming to the conclusion that results vary depending on {ingress,egress} of {L3, SLC,
Memory-Side-Cache, Memory-Controller} - even when only one is implemented, and that hiding
this in resctrl isn't helpful. Using perf's platform-specific json files to identify
counters may be a better approach.


Thanks,

James

