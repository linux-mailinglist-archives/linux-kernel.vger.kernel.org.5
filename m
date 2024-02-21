Return-Path: <linux-kernel+bounces-74684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B55885D7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B851F22EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D74DA05;
	Wed, 21 Feb 2024 12:06:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A52B4E1B3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517213; cv=none; b=nneFwTO0Nrj+OkI2B9i9XwOmYqU9R80hZIeO/sPRrBv7DKaO7P61lj5vNz4e6VEpkzYi52Ju2qTcMWIQFdXHGItIHcn6o55easyqxNJdig4uP3JdjveDqV8f6+SC+RxYLvK41HQUI4UJHRsQu7fJrIRFVA5vKVILlffUE1HM84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517213; c=relaxed/simple;
	bh=TbXTSyKoJMZy0xDnmGuwLUxJ+iI+gkmKCkVN0X/w7UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAB83B4+V95+YbAiD3kzPlLh4RGGcwRWb/8gvqwychvqBgfnG9MgTnDVJdaYYoLZjGl0GffwbYwdqwBt0Rzc40ss6ygGlEbvmoGIWs14uE9370N1HcU4rD+HduXTsIXpq5MonM7OFCFYTUPlQwsy64sQJXiGqCeRuB8wiHpYteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 603DD1007;
	Wed, 21 Feb 2024 04:07:29 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBBD13F762;
	Wed, 21 Feb 2024 04:06:47 -0800 (PST)
Message-ID: <88097441-534d-4b81-9801-680334092ab8@arm.com>
Date: Wed, 21 Feb 2024 12:06:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix WARN in get_domain_from_cpu()
Content-Language: en-GB
To: Tony Luck <tony.luck@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
 "lcherian@marvell.com" <lcherian@marvell.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "amitsinght@marvell.com" <amitsinght@marvell.com>,
 David Hildenbrand <david@redhat.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local> <87zfvwieli.ffs@tglx>
 <ZdUSwOM9UUNpw84Y@agluck-desk3>
 <d409c32d-0f9a-4773-bc25-9d39de3c9e9b@intel.com>
 <SJ1PR11MB6083A759748EAF62EDF21D0FFC502@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZdVFDIJmctsNaGd2@agluck-desk3>
From: James Morse <james.morse@arm.com>
In-Reply-To: <ZdVFDIJmctsNaGd2@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tony,

On 21/02/2024 00:34, Tony Luck wrote:
> reset_all_ctrls() and resctrl_arch_update_domains() use
> on_each_cpu_mask() to call rdt_ctrl_update() on potentially
> one CPU from each domain.
> 
> But this means rdt_ctrl_update() needs to figure out which domain
> to apply changes to. Doing so requires a search of all domains
> in a resource, which can only be done safely if cpus_lock is
> held. Both callers do hold this lock, but there isn't a way
> for a function called on another CPU via IPI to verify this.
> 
> Fix by adding the target domain to the msr_param structure and
> calling for each domain separately using smp_call_function_single()

Cunning - this trades the memory allocation for multiple IPI. I think this is much better
for the case where only the local domains configuration is modified.

With the double-IPI when both CDP configurations are changed fixed:
Reviewed-by: James Morse <james.morse@arm.com>

I think we should rip out the false positive check, I'll post a patch to do that.
I'll double check this was the only IPI path, if so its safe again after this patch and we
can add lockdep_assert_cpus_held(). If anyone ever hits this during a bisect its should be
clear(er).


Thanks,

James

