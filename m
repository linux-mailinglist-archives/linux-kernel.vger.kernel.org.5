Return-Path: <linux-kernel+bounces-78084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23FF860EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088F21C24E50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9ED5D493;
	Fri, 23 Feb 2024 09:53:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7791D5D467;
	Fri, 23 Feb 2024 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681982; cv=none; b=RZEyYhJxdeFtfbCGJNfz5D/SpqTdE73Q/r3/0SOLqOR3KXnmJQwlH6o6s8O6K3ZVhyVLBmrWpZXD5tlRpjpTkdvtgjOjAz8OmQ2uhhS7O8jZADW4/J5HkUGCEvvkf3BkURgcY3MAQa0dl4nKBl+LHz2oXc3aPwMwv59/KBdHubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681982; c=relaxed/simple;
	bh=4wR5/b9Ppb8PrsM6uEfWu6D5FPvs3K+BXutqUdHWA/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTsnq2J9jPRut0Q8Yn1daJQBlCDJioNxtTbaWQz0Z4OQEnJ+WgMtyfwW9PmNU9jKxEoLXYU1nDCpyAtiGAhrc3i0mLkTHHfPLqhiVfzMz9PZjBbKlwBRQ/7+l+r7HzICkhe4rQruNyIrD7onfLUmPnJUEPN9x9A5Ua3gDgRXQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6504A1650;
	Fri, 23 Feb 2024 01:53:38 -0800 (PST)
Received: from [192.168.1.13] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0AE93F766;
	Fri, 23 Feb 2024 01:52:58 -0800 (PST)
Message-ID: <1ae5b9e6-9eb4-49a5-8cfc-46359c8d74c3@arm.com>
Date: Fri, 23 Feb 2024 10:52:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] v6.8-rc4-rt4
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20240214161130.ZT9RSWDc@linutronix.de>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240214161130.ZT9RSWDc@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Sebastian,,

On 2/14/24 17:11, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v6.8-rc4-rt4 patch set.
> 
> Changes since v6.8-rc4-rt3:
> 
>    - The previous releases introduced a compiler warning for i915 driver
>      in the !i915 case. Reported by the kernel test robot.
> 
>    - An update to the printk series by John Ogness:
> 
>      - document new nbcon console callbacks:
>      
>      - add "threadprintk" boot argument for !PREEMPT_RT users that want a
>        fully threaded printk.
>      
>      - use thread callback (instead of atomic callback) for legacy printing
>        in task context.
>      
>      - sync with recently reviewed printk series.
> 
> Known issues
>       Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
>       hist" as trigger. It is not yet understood. The report is at
> 	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

I recently tried to reproduce the issue using the same kernel version and platform,
but even after multiple resets and attempts to re-trigger it didn't show up.
As it doesn't seem anyone else reported anything similar, would it make sense
to drop the reference ?

Regards,
Pierre

