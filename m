Return-Path: <linux-kernel+bounces-119269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECDB88C666
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B8D2C5F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5C813C69A;
	Tue, 26 Mar 2024 15:11:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ADF12B82
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465897; cv=none; b=YScv9ezgiulkwCo5Ck7lQ1ldnHAukVlgrmbxMuVHDl9TqlMUQvb5fCGWyF3hGXe+1wBIeMH1BXY0rmYcUOnHxpU/KG+V1gZXhMMO+RsSJrZXylNJ4VYrZ9fH7x1MbI7V8FIFn/aJYE4t3VMgoLhxGDDvh5pQ48D1040MEGzuPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465897; c=relaxed/simple;
	bh=nPXqd/Tu7w5BMdmJLMP73PDxLrkZ9KP73/J8go7AqyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAB/KxolL3649emBca4aOCKU74+t8XkJOgVOoT8QA32sGE0twqKdcc4rdNuuJg9n3Q7M4fsUXlL88FiKLI98KtYXqJA+s5kq/fl0ENDGEdSkaUCING23kOjZQQeWAQqS9JkEAXqfIl57ROXUbunfK0ExsIzqrOwnm3VO5ATACXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F22812F4;
	Tue, 26 Mar 2024 08:12:08 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AE273F694;
	Tue, 26 Mar 2024 08:11:33 -0700 (PDT)
Message-ID: <6c1eed8f-455f-4612-be4e-02876f35e37e@arm.com>
Date: Tue, 26 Mar 2024 16:11:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Simplify continue_balancing for newidle
Content-Language: en-US
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, vincent.guittot@linaro.org, qyousef@layalina.io,
 linux-kernel@vger.kernel.org, vschneid@redhat.com, joshdon@google.com,
 riel@surriel.com
References: <20240325153926.274284-1-sshegde@linux.ibm.com>
 <ZgKCXrUbBIxp6+mu@gmail.com>
 <7e6789d6-1e85-4945-8a7b-02cadc95cfa5@linux.ibm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <7e6789d6-1e85-4945-8a7b-02cadc95cfa5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 10:00, Shrikanth Hegde wrote:
> 
> On 3/26/24 1:37 PM, Ingo Molnar wrote:
>>
>> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>

[...]

>> Is this actually true? Any change to behavior invalidates such a sentence.
> 
> From what i think, code path is same and I don't see any functionality changing. 
> Correct me if i am wrong. 
> 
> Currently, sched_balance_newidle does the same check to bail out as the
> should_we_balance check in case of newidle.  i.e  
> 
> should_we_balance
> 	if (env->dst_rq->nr_running > 0 || env->dst_rq->ttwu_pending)
> 			return 0;
> 
> sched_balance_newidle
> 		if (pulled_task || this_rq->nr_running > 0 ||
> 			this_rq->ttwu_pending)
> 			break;
> 		}

LGTM. Commit 792b9f65a568 ("sched: Allow newidle balancing to bail out
of load_balance") (Jun 22) made sure that we leave sched_balance_rq()
(former load_balance()) for CPU_NEWLY_IDLE asap to reduce wakeup latency.

So IMHO, we can use 'continue_balancing' instead of 'this_rq->nr_running
> 0 || this_rq->ttwu_pending' in sched_balance_newidle() (former
newidle_balance()).

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

