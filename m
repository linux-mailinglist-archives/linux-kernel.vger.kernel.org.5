Return-Path: <linux-kernel+bounces-34029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4884C837217
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F3C28E7F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAF347F5A;
	Mon, 22 Jan 2024 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kGQDacHz"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679247A6F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949750; cv=none; b=par/1DjwAhDylaxP4Sak7G0m88jlrLLFClChzJXHvlVC5O2lGQ+H+kbmxA3hNU+W+q48Mz3DImKKXWffLrnFnbbpAc3XLxos74IrIafAx7VxTgnuBNQVXHkZVt2jM6hA+/3HkpQ80a086qyiwrIhN44xlGygcubEo6ssEmaI5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949750; c=relaxed/simple;
	bh=mk255U7PBxhQdFXsjowvY80I7qza3X9f+j/WQQEG63g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHx0ItVJHgLocbifgX4Mk8cX0/pRXWHD5ud5gLJs0jKFVHGpT6KUnblmDe68zlyMp0P0iJZjJJdtQsZ+sKKA8rzcPMcbULc6Q1gRTitBVH1bBVItSD2JXL8YmMG4q9N9FX2X58W4e7tIbUg4+pf2aR7R9+3i4dW7EW7hIQ2Q9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kGQDacHz; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1705949747;
	bh=mk255U7PBxhQdFXsjowvY80I7qza3X9f+j/WQQEG63g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kGQDacHzXhlzdsG3StG65zMwj47vckUS6IeAFeZlE9rEyIIptCpsqXxeAF2e02E8W
	 S4OkGFg8eou81sc93mhC3k+jtqdv0b8fuFOaydmZUEkVMwIIOFEnH8ok9tgG1/AWQZ
	 f6UgSeJeRjMn7Eg163HmpS0mpCA3hNbTxx57t0HF1W/EZslyJHMlAuyJG/Vsg85Xn/
	 PMdnU+oYPjgrC80ZowfrCzFKJSJQ6mi1wb1ZJtCw2KTX5THMK9d3ckprrDfGEgUmID
	 GOJgsQMQOBL1qLI/NH/1cF1ELkUsxdUNKpaYzIeYIUqZ4DwpoFat7X429ZpaQJklPU
	 5C5AqSwsjWF9w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TJfYv3WTVzTbc;
	Mon, 22 Jan 2024 13:55:47 -0500 (EST)
Message-ID: <e33279b2-be4d-4706-8faf-9cf5e8c8e092@efficios.com>
Date: Mon, 22 Jan 2024 13:55:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: Do not skip !allowed_cpus for mm_cid
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
References: <20240111154922.600919-1-mathieu.desnoyers@efficios.com>
 <40935ea7-9da6-455d-8df3-94e7e0fc6fa4@linuxfoundation.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <40935ea7-9da6-455d-8df3-94e7e0fc6fa4@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-01-22 13:43, Shuah Khan wrote:
> On 1/11/24 08:49, Mathieu Desnoyers wrote:
>> Indexing with mm_cid is incompatible with skipping disallowed cpumask,
>> because concurrency IDs are based on a virtual ID allocation which is
>> unrelated to the physical CPU mask.
>>
>> These issues can be reproduced by running the rseq selftests under a
>> taskset which excludes CPU 0, e.g.
>>
>>    taskset -c 10-20 ./run_param_test.sh
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> ---
> 
> Hi Mathieu,
> 
> I applied this to linux-kselftest fixes for the next rc.
> 
> Please cc linux-kselftest mailing list on your future patches. This makes
> my workflow easier as it relies on patches going to linux-kselftest 
> patchworks
> project.

Will do, thanks!

Mathieu

> 
> thanks,
> -- Shuah
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


