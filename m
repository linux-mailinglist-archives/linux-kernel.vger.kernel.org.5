Return-Path: <linux-kernel+bounces-71788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2497585AA74
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF90B26500
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BB7481AA;
	Mon, 19 Feb 2024 17:55:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647547F5D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365345; cv=none; b=WA/Yu9YihAFVSHiXpHZ+CD/sSeklw3bnOP3LlpzxVrUsYiRB3Wa1TswifEUtR3rmfkByI+5WuBFPi+oW+2vbvqyAbsmgrnklfrGeOYHngvQdrUf03GH8Ao1JUeiPB+x/ZHTl5A/pPEkG+67WJ2oh4XDYclFwAnpIyviNovghwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365345; c=relaxed/simple;
	bh=qfOydnjc4xd5apD1j6GfVb1QZpeURA5RdZjrEJAGa3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V84YCKieuiPC5qJjn3lQqCvedyHHd3EMXyK9MYu7zYnRy/oxXGBbxHlTa/klgTn/IbmDWQnN0uDPPLtTV+dESSjFdJDiSa4VjMJ9pMrNcJHpHp0+vhO0xfprclixTReEIK1S/7z0yQFOAsCEzx6/fIfxc5txJmu+DCyuWXkaAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 064EAFEC;
	Mon, 19 Feb 2024 09:56:22 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDEBF3F73F;
	Mon, 19 Feb 2024 09:55:39 -0800 (PST)
Message-ID: <d2b00cf4-d5e2-4350-8043-8b6a4b4a0fb6@arm.com>
Date: Mon, 19 Feb 2024 17:55:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-GB
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ingo Molnar <mingo@redhat.com>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local> <87zfvwieli.ffs@tglx>
 <66a54c8b-2013-48d9-8114-6f3f72cd2871@arm.com>
 <20240219175103.GFZdOVBz8tcXVbjwkV@fat_crate.local>
From: James Morse <james.morse@arm.com>
In-Reply-To: <20240219175103.GFZdOVBz8tcXVbjwkV@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 17:51, Borislav Petkov wrote:
> On Mon, Feb 19, 2024 at 04:53:38PM +0000, James Morse wrote:
>> Thanks - I'm just putting a v10 together to fix this.
> 
> No need - I'll fold it in.

Thanks!

James

