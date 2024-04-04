Return-Path: <linux-kernel+bounces-131846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A19898C7C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D75287568
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB161CF8D;
	Thu,  4 Apr 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U5eqNiut"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B861C6A3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249270; cv=none; b=hmNbU3e68fRaNmkKgFdzqhXW4ot7aATWPiuODK7YkhSffDM9rU8SEhqL4lSI7RvXV/tpyPjuyuECKhMSbw7NQCWnaIpvdMRP9spys9DT40CDSNpBLKksA7Ymb54ILr0Mxf+I9TWykSxampRkbsma6ng8mF8kGyYNiCiiFkPLDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249270; c=relaxed/simple;
	bh=35dhnO5C4lolhAFARXCTQ/GH9CARWGStS+VDjCNowjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdMSZjkmbrhYaHpQVqV8acgR6rR7r7KDiQmwVtzmkBbQUuCOwIqgytKTPVMD7+G2gL800by/7TWJqlBwrBjm06GT7B6wn2p8EGnxWhmx1UEve6VpBCQkM7emFfDhk/zq3/GgNt6eXp7u9u0oPw4otXHIFMPfpIu04ALN95LI6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U5eqNiut; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fc7e06cd-ecd5-4a2a-8ca5-cd876aa87ac1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712249266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLsFFBjspbz86ZgjfJxLJ79srNQ7++XFl9ggXA36c5c=;
	b=U5eqNiut5RA+lTU17uIy71dFwRNdMxRKDW/BygRyUNkl2lQwB4iqyiE8fdVQ+eM5O74Lh4
	sQhip9E/bTeVSIsnEyhDNdmWWW8XcSJFd2WiYBaMxoGsF7UAJYXRggj88Dhh0l/1+EZEoM
	YWv2wfVszMHQTLp0Hs7iQKQZlIz2eYE=
Date: Thu, 4 Apr 2024 09:47:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify calling core kfuncs
 from BPF_PROG_TYPE_SYCALL
Content-Language: en-GB
To: David Vernet <void@manifault.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240404010308.334604-1-void@manifault.com>
 <20240404010308.334604-2-void@manifault.com>
 <36bb0747-bff4-4fad-93ca-dae406f14099@linux.dev>
 <20240404163316.GA385240@maniforge>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240404163316.GA385240@maniforge>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/4/24 9:33 AM, David Vernet wrote:
> On Thu, Apr 04, 2024 at 09:04:19AM -0700, Yonghong Song wrote:
>> On 4/3/24 6:03 PM, David Vernet wrote:
>>> Now that we can call some kfuncs from BPF_PROG_TYPE_SYSCALL progs, let's
>>> add some selftests that verify as much. As a bonus, let's also verify
>>> that we can't call the progs from raw tracepoints.
>>>
>>> Signed-off-by: David Vernet <void@manifault.com>
>> Ack with some comments below.
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Thanks for the review. It looks like accidentally replied directly to
> me, so I'll re-add the missing cc's.
>
>>> ---
>>>    .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  1 +
>>>    .../selftests/bpf/prog_tests/task_kfunc.c     |  1 +
>>>    .../selftests/bpf/progs/cgrp_kfunc_common.h   | 21 +++++++++++++++++++
>>>    .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  4 ++++
>>>    .../selftests/bpf/progs/cgrp_kfunc_success.c  |  4 ++++
>>>    .../selftests/bpf/progs/cpumask_common.h      | 19 +++++++++++++++++
>>>    .../selftests/bpf/progs/cpumask_failure.c     |  4 ++++
>>>    .../selftests/bpf/progs/cpumask_success.c     |  3 +++
>>>    .../selftests/bpf/progs/task_kfunc_common.h   | 18 ++++++++++++++++
>>>    .../selftests/bpf/progs/task_kfunc_failure.c  |  4 ++++
>>>    .../selftests/bpf/progs/task_kfunc_success.c  |  4 ++++
>>>    11 files changed, 83 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
>>> index adda85f97058..73f0ec4f4eb7 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
>>> @@ -102,6 +102,7 @@ void test_cgrp_kfunc(void)
>>>              run_success_test(success_tests[i]);
>>>      }
>>> +   RUN_TESTS(cgrp_kfunc_success);
>>>      RUN_TESTS(cgrp_kfunc_failure);
>>>    cleanup:
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
>>> index d4579f735398..3db4c8601b70 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
>>> @@ -94,5 +94,6 @@ void test_task_kfunc(void)
>>>              run_success_test(success_tests[i]);
>>>      }
>>> +   RUN_TESTS(task_kfunc_success);
>>>      RUN_TESTS(task_kfunc_failure);
>>>    }
>> The above RUN_TESTS(cgrp_kfunc_success) and RUN_TESTS(task_kfunc_success)
>> will do duplicate work for *existing* bpf programs in their respective
>> files. I think we still prefer to have cgrp_kfunc_success tests
>> in cgrp_kfunc.c to make it easy to cross check. But in order to
>> remove duplicate work, one option is to make other non-RUN_TESTS
>> programs in those files not auto-loaded and their corresponding
>> prog_tests/*.c file need to explicitly enable loading the problem.
> Good point, and yes I agree with that approach of not auto-loading
> non-RUN_TESTS programs. Considering that we have a  __success BTF tag to
> say, "this prog should successfully load", it seems odd that we'd also
> automatically load and validate progs that _didn't_ specify that tag as
> well. At that point, I'm not sure what value the tag is bringing. Also,
> that was the expected behavior before RUN_TESTS() was introduced, so it
> hopefully shouldn't cause much if any churn.
>
>> Maybe the current patch is okay even with duplicated work as it
>> should not take much time to verify those tiny problems.
> IMO it should be fine for now as the overhead for validating and loading
> these progs is low, but it'd definitely be good to address this problem
> in a follow-up. I don't think it should take too much effort -- AFAICT
> we'd just have to mark a test spec as invalid if it didn't have any BTF
> test tags. Ideally I'd like to separate that from this patch set, but I
> can do it here if folks want.

Or you can remove __success from cgrp_kfunc_success.c, cpumask_success.c
and task_kfunc_success.c and also remove their corresponding
RUN_TESTS(cgrp_kfunc_success) and RUN_TESTS(task_kfunc_success).
For example, you do not have RUN_TESTS(cpumask_success) and it is okay.

Basically, those expect-to-succeed new programs should be verified
already even without RUN_TESTS.

>
> Thanks,
> David

