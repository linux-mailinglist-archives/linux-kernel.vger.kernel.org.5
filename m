Return-Path: <linux-kernel+bounces-153023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900108AC7D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBE41C21921
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CC35491A;
	Mon, 22 Apr 2024 08:50:48 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057D4CB55
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775848; cv=none; b=brsWEFYmv7dyNBW3jHYnhEfWaVyp3IYk/aRch0goPLSQuQ3PzNlvUljI1MaA5nLdbhdTR1LjSqkXxD0cnN207bb2vebE7kRkV76nzKwmVH1JnPv76i6TXpK8dYbLQjNd3Cv7LUyrOZDjeb7f1Agx89tuWZk7KKwL8LvuEidj1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775848; c=relaxed/simple;
	bh=tMuArfUg4yNP9rpwT19TkytDu+F4m2XaxBWxDO8wEtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWhgEhJ86jbyiLRHFFR25dUhxPJOi+FlaaEjDvefE4W+lKububpZtWR20Qoxk9BieMKA8AJNo2eOn4TTRSWSmD+x3sWwbqqOBD3p9+ZuN15WV8S82/7vluXBF04mgJKfZklHj7o4gos6NGWWoQ8vLMyI8JJ7XAGjF6kX/LEC1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C3796000C;
	Mon, 22 Apr 2024 08:50:34 +0000 (UTC)
Message-ID: <f6488073-b93f-4945-9d30-1ceb548d6bb4@ghiti.fr>
Date: Mon, 22 Apr 2024 10:50:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Merge arm64/riscv hugetlbfs contpte support
Content-Language: en-US
To: Will Deacon <will@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: alexghiti@rivosinc.com, ryan.roberts@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
 akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org
References: <CAHVXubiH64beFuB_GHSq5BKCus=O_+bqYTCwWQ+=2Q-F=T=ctQ@mail.gmail.com>
 <mhng-911ba065-e6c8-4d42-978c-e47897bcb493@palmer-ri-x1c9a>
 <20240419110306.GA2972@willie-the-truck>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240419110306.GA2972@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi,

On 19/04/2024 13:03, Will Deacon wrote:
> On Thu, Apr 18, 2024 at 03:11:56PM -0700, Palmer Dabbelt wrote:
>> On Fri, 01 Mar 2024 03:29:18 PST (-0800), alexghiti@rivosinc.com wrote:
>>> On Fri, Mar 1, 2024 at 11:45 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>> I confess I haven't looked at the patches yet, but this cover letter raises a
>>>> few quesions for me. I'll aim to look at the actual patches in due course.
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> in case someone wants to pick them up via a generic tree.  I'm happy to take
>> them via the RISC-V tree if folk want, no rush on my end I'm just scrubbing
>> through old stuff.
> I'd definitely like to take the arm64 parts via the arm64 tree (on a
> shared branch), as it's a non-trivial amount of mm code which may end up
> conflicting. I'd also like to see Ryan's Ack on the changes before these
> end up in -next.
>
> Will


The rebase on top of the contpte mTHP support changed quite a few 
things, I have something working and will send it soon, so no need to 
review this patchset.

Thanks,

Alex


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

