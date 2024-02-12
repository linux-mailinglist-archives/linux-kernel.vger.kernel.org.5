Return-Path: <linux-kernel+bounces-61921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE22585186D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8380C284500
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312D43CF5C;
	Mon, 12 Feb 2024 15:50:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D2E3CF45
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753045; cv=none; b=aZwmUCxrbTmliCJYbDrc6luJpWURgtpxHBNJFU+yVuhnEMgFBroM9tM15t5v9p3sIRvfAb3XddTwHQBCVJs6WiRwMTsPcCIOHCKQajTnenPIrWBhKRuxyClwZzydehgK6VCe/u4nAKYlpNxwQYH2SYLL5Gzaf0dsivZ0PaJYKpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753045; c=relaxed/simple;
	bh=vrGgvJfQTS4K1X4SOXsyg9VpF/qTU4L3lh3+frDDBfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pnrf23eBsijpFoXRjdX2jRNdAc/gmlGolptHrkk07ApJXQRHBqXyv8XI8HSEIJcEt+7PKtvxhg4kmEyNsFw1eYSiIF4S/jEaPnVsf3xCqixnmLKfPhbiPLjRdCVsGC8bpIel33pwbF/fQA1kU/73PuAGe1TVlMpvpHUS/ztnlak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3A8FDA7;
	Mon, 12 Feb 2024 07:51:24 -0800 (PST)
Received: from [10.57.8.197] (unknown [10.57.8.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A6F63F762;
	Mon, 12 Feb 2024 07:50:40 -0800 (PST)
Message-ID: <0a9afba6-2e25-44fa-b9d2-3e57cc6708ce@arm.com>
Date: Mon, 12 Feb 2024 15:50:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] Preparatory changes for Proxy Execution v8
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-team@android.com
References: <20240210002328.4126422-1-jstultz@google.com>
Content-Language: en-US
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20240210002328.4126422-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/02/2024 12:23 am, John Stultz wrote:
> After sending out v7 of Proxy Execution, I got feedback that the
> patch series was getting a bit unwieldy to review, and Qais
> suggested I break out just the cleanups/preparatory components of
> the patch series and submit them on their own in the hope we can
> start to merge the less complex bits and discussion can focus on
> the more complicated portions afterwards.
> 
> So for the v8 of this series, I’m only submitting those earlier
> cleanup/preparatory changes here. However work on the full series
> has continued, with some nice progress on the performance front.

I guess we can also cherry-pick 1st [1], 20th [2] and 22th [3] patches 
of v7 into this series?

[1] 
https://lore.kernel.org/lkml/20231220001856.3710363-9-jstultz@google.com/T/#m1e6ef390bf9044ca69818549bccec1ada221cd32
[2] 
https://lore.kernel.org/lkml/20231220001856.3710363-9-jstultz@google.com/T/#m638575b42057e1d2cc3a82d4bdea7308eb85b461
[3] 
https://lore.kernel.org/lkml/20231220001856.3710363-9-jstultz@google.com/T/#mafcb432d20c6b545998da56ba92fc51ba8a07b42

> 
> If you are interested, the full v8 series, it can be found here:
>    https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v8-6.8-rc3
>    https://github.com/johnstultz-work/linux-dev.git proxy-exec-v8-6.8-rc3

[...]


