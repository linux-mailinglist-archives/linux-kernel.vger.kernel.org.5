Return-Path: <linux-kernel+bounces-39404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D362983D076
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835091F296CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615712E72;
	Thu, 25 Jan 2024 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDnlj2/Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471BD12B8A;
	Thu, 25 Jan 2024 23:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224520; cv=none; b=h8+QP7W7UwYinQK6wOjK5m/0cCqXDSCzhmNmLCOT9Gjlu6rmfo3lDWSdrDrN0sLWSDkrb71HeJRur2gu/VZ0NeurrCxMg6lpS4h7DnSTHDBOwPtQcelP5XOYo8aBh2vcVHLV4zVXZSG4c+hy9bR2devgrUuVcWeDXMdtn37EMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224520; c=relaxed/simple;
	bh=d+oT/WUNGWywn59+jNCEnCZSa3hl6Z/rNAKSjHlpy1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeZI064cggri9keXZsPO5QWgLkJ3bHdClYKQWDEGkOdNt4Fln4NWXuFTE+mm8Ox5FgZrT+6CVDlBwrPp+8sDlQdb6+kKZYalXw1+ovdoU/Kp9jZLDz0Nt+hJ5pDMJiiLzMbcL+udMSX17K77CM9E62hEgTLssVKHbRMMr+jRAMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDnlj2/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21B3C433C7;
	Thu, 25 Jan 2024 23:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706224518;
	bh=d+oT/WUNGWywn59+jNCEnCZSa3hl6Z/rNAKSjHlpy1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jDnlj2/Qbq9OZq3roGlMPt9F2pstORi1pvBFFeM6oSpIVZ91jkVjXkJIegdjLHmJg
	 Vg9ObUj1YOA84SkkgIVCHN5W0/PTTyBam0aYgZNJcSs1i36+XkYgYKej3WgW1KeVYv
	 wqZ6VmUiOakGj31rkss/DyzLkcBVnJHRTQ9bC04crauN6Pi/n5730YnKfRp8l4KujL
	 MX11SVPW9KVWbLt7X6KlfOU3tIEnkXr/Mimw4AIuoMKidkJIhI3PPAyq32kEuR5P7X
	 Tx9ANdB/72rHNqVsF9wifuKRPFJbS9PgiF6uGu6IEXVXC7ECDTI07+wHRTTNndqC3l
	 2u01xBXsHYAGw==
Message-ID: <5e2b5f23-94f0-4bf0-80a6-48380c7dc730@kernel.org>
Date: Fri, 26 Jan 2024 08:15:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] softirq: fix memory corruption when freeing
 tasklet_struct
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
 Mike Snitzer <msnitzer@redhat.com>, Ignat Korchagin <ignat@cloudflare.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Hou Tao <houtao1@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com>
 <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
 <586ca4dd-f191-9ada-1bc3-e5672f17f7c@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <586ca4dd-f191-9ada-1bc3-e5672f17f7c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/24 07:04, Mikulas Patocka wrote:
> 
> 
> On Thu, 25 Jan 2024, Linus Torvalds wrote:
> 
>> On Thu, 25 Jan 2024 at 10:30, Mikulas Patocka <mpatocka@redhat.com> wrote:
>>>
>>> There's a problem with the tasklet API - there is no reliable way how to
>>> free a structure that contains tasklet_struct. The problem is that the
>>> function tasklet_action_common calls task_unlock(t) after it called the
>>> callback. If the callback does something that frees tasklet_struct,
>>> task_unlock(t) would write into free memory.
>>
>> Ugh.
>>
>> I see what you're doing, but I have to say, I dislike this patch
>> immensely. It feels like a serious misdesign that is then papered over
>> with a hack.
>>
>> I'd much rather see us trying to move away from tasklets entirely in
>> cases like this. Just say "you cannot do that".
> 
> OK. I will delete tasklets from both dm-crypt and dm-verity - it will 
> simplify them quite a bit.
> 
> BTW. Do you think that we should get rid of request-based device mapper as 
> well? (that's another thing that looks like code bloat to me)

That would force removing dm-multipath, which is I think the only DM driver
using requests. But given how widespread the use of dm-multipath is, killing it
would likely make a lot of people unhappy...

-- 
Damien Le Moal
Western Digital Research


