Return-Path: <linux-kernel+bounces-35234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E1B838E39
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E437C1C21BED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE55DF39;
	Tue, 23 Jan 2024 12:12:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23125DF2E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011961; cv=none; b=noHHqlC5+3GiKbWcgQJeWD38FMAEC6C7GclReUooKY5RvVFj6Oly3wrvyUM6kHuu5SpEKd40AO7x0Dyx4evaWOfo2wvx+yT5ITlu8nWOagGCFNhyIEHyEnYRbWQQ6qNcDoe0YgNFn73aLG32IlhM+Hu8Y/vtscxsbeiQVvFNKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011961; c=relaxed/simple;
	bh=83IcMC1FsbBJjNOk5uCGsdfZh2KxQTkHW2rC9MV6fsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7jFq7FDbVE/PIWExNgvMLReQ5NyvnF6QzAPGs6s2z07u7Eavw2BFUKS+DVbWbz4+9tUuk2GyHPnJ4m5EwMNmX3XZcvcOkDCVKKxxItZQ06YAJJVDWLvw0/2eSSmZf5HQxyGf5UzT2WGgnlyRhIKKbnp2eAPozYi/26QwY5kBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 846D01FB;
	Tue, 23 Jan 2024 04:13:24 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A11F3F762;
	Tue, 23 Jan 2024 04:12:37 -0800 (PST)
Message-ID: <b6ce3e79-aa4a-57e9-8b43-b5be45f75462@arm.com>
Date: Tue, 23 Jan 2024 12:12:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] x86/resctrl: Implement new mba_MBps throttling
 heuristic
Content-Language: en-GB
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 "Chatre, Reinette" <reinette.chatre@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>,
 Peter Newman <peternewman@google.com>, "x86@kernel.org" <x86@kernel.org>,
 Jamie Iles <quic_jiles@quicinc.com>, Babu Moger <babu.moger@amd.com>,
 "Shen, Xiaochen" <xiaochen.shen@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20240118214213.59596-1-tony.luck@intel.com>
 <45d2891e-989a-45c9-a527-8b14ff5f8748@intel.com>
 <SJ1PR11MB60837D4884419BDC2DCAA2D2FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <bfa5104f-b887-4cc4-a24c-0497b86d9dde@intel.com>
 <20240122182121.GBZa6yIYPtHQx44EU9@fat_crate.local>
 <11fc82e0-961f-4c8d-844f-ad4b99067eb3@intel.com>
 <20240122184755.GCZa64W02KXyeaVXJg@fat_crate.local>
 <SJ1PR11MB6083A27C628E17FB8BBC4922FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <SJ1PR11MB6083A27C628E17FB8BBC4922FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tony,

On 22/01/2024 20:58, Luck, Tony wrote:
>>> There is also one pending resctrl feature, the SNC work [1], that Tony
>>> plans to rebase on these fixes.
>>
>> Ack.
> 
> It looks like there is just one change in part 0004/0008 that doesn't apply automatically from git am.
> Super easy to resolve.
> 
> I need to grab an SNC system to re-check that everything still works when re-based.
> But right now, this looks like adding the SNC series will be easy (famous last words!).

Once you're ready - can you point me at something I can use as a stable branch to rebase onto?


Thanks,

James

