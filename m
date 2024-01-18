Return-Path: <linux-kernel+bounces-30059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F8C83188C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772B71F23420
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD81241FB;
	Thu, 18 Jan 2024 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CwIJChyJ"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C338241E2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577886; cv=none; b=lqAI5n+J8UrvZKwowN4RsSEhhzsCI02bol4G+hDtai3XSOlEGiMJxJ+TBeqXJIKuDIFnREMdPdpVVne/DWBUYYZWaKikIAB96eQvWHPqX20TEWwDnmBT7w2XE+M9kM0Z4C8p1eHuPAxB0FApd9SY3hwC/mwHG9B0i70IguGhYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577886; c=relaxed/simple;
	bh=EMq+jKAFC+XJDSvaSPlyCUq/HCdq4MkbD3Td1zIjivQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=T8ZLvOTsOQ0KopPNl8SQgN3ArT9gaJckSMlmJzqdn2Ayx/fSk1hMAgEjiIQxGv+4d0YryH9+2vGzEVGjNZNpoco1gtMbNkZAG5jYwD9+G+YLy8Lmn1lE9nbqN/i44K7yX6xNzuvNtPCuENHR+jcAgpYv3kKeAwBAK9D4e+IeGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CwIJChyJ; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-598a2cb5a7cso3278805eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705577883; x=1706182683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d86VyCLJtJbJlj3tvvWM2v0mz4swiMwtcXUXUXsp84k=;
        b=CwIJChyJ9p54mxwFfHd62dx/itTDbMU51aVdYna2H5IYddYIAJ9EekKgSP8sD0Wtcv
         gcZjxJgcvk6PtQwn5CRJUVU4lGG7tg4C5o7Z6xpSTQQuiRBLbB54zDkMeiPTl8HnSGOV
         1HOEUM44oPSYulgbyOqJWzrmzFKLAPOqb4SrQLj+5C/77tzPyxgLuBiLBT7PKxAPvZns
         q8oMeHj8X7A5HW15pZ9Brb5/16aUpklB98smZrBIrwaMEBNZolLW4K/625VjG/XgMDLi
         OCMxOm+QCLr6/6sjkHhzcYKSXashyo6oOd2C/AE/WZI/R3v2VRPVmC6q77hodz5SybsN
         RlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705577883; x=1706182683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d86VyCLJtJbJlj3tvvWM2v0mz4swiMwtcXUXUXsp84k=;
        b=UiD2OGxxH9eu7CCjptx6b+ozhqtBIeKpJjYpT2rcCZ+n9RHD8ONQ/jBph7jrowcNwD
         DCi86sKknCKy6UjG9UqpGA5/H2WnlLDoUBwIUdRzRD8J1TiyMO1tIuzTm3LHFjRT/+I/
         ulL21WpLt8HOYYJLjRgZB8hUtzADVQqR8InHLisZiJx5eX6LwQe+6eqKm8mozD1CmPF8
         qdKJhEWRplv2nOJodwdjn8O33msmldAeZnUbYOf95bwTwK2xFWcmwE2djZ5EgNMbtC/O
         YUbcDugIvcVHECXd2l7faFkuhU/YfLulBlJ3BKSSbEE+HGpUES2bevGYENp6NvqLeUL9
         Wilg==
X-Gm-Message-State: AOJu0YwGgtmohvrHMQFxWngd1b1ubQB6SMIwBupQctbdNiaPH8Z2sl1K
	ztvk/+RjAtSAIWbSPcRVuK28OqUWGAnClT7QiJA0U7+cnfyZ11P4w0yNnrU1yi0=
X-Google-Smtp-Source: AGHT+IEP8LqRxwUPstJAFnBsW/sws/XH5aEdWxYkFdRsxzHOScSvnjyZF0c70pp2Upm5IJuNVf9hVA==
X-Received: by 2002:a05:6359:6795:b0:175:d7f9:6b40 with SMTP id sq21-20020a056359679500b00175d7f96b40mr663272rwb.3.1705577883029;
        Thu, 18 Jan 2024 03:38:03 -0800 (PST)
Received: from [10.255.202.70] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id u33-20020a631421000000b005cdad153d84sm1342517pgl.90.2024.01.18.03.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 03:38:02 -0800 (PST)
Message-ID: <412b8618-0941-4d9d-85df-ee480695e7f7@bytedance.com>
Date: Thu, 18 Jan 2024 19:37:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/slub: directly load freelist from cpu partial slab
 in the likely case
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Pekka Enberg <penberg@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
 <20240117-slab-misc-v1-1-fd1c49ccbe70@bytedance.com>
 <76641777-1918-2b29-b6aa-bda9b5467aa3@gentwo.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <76641777-1918-2b29-b6aa-bda9b5467aa3@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/1/18 06:41, Christoph Lameter (Ampere) wrote:
> On Wed, 17 Jan 2024, Chengming Zhou wrote:
> 
>> The likely case is that we get a usable slab from the cpu partial list,
>> we can directly load freelist from it and return back, instead of going
>> the other way that need more work, like reenable interrupt and recheck.
> 
> Ok I see that it could be useful to avoid the unlock_irq/lock_irq sequence in the partial cpu handling.

Right.

> 
>> But we need to remove the "VM_BUG_ON(!new.frozen)" in get_freelist()
>> for reusing it, since cpu partial slab is not frozen. It seems
>> acceptable since it's only for debug purpose.
> 
> This is test for verification that the newly acquired slab is actually in frozen status. If that test is no longer necessary then this is a bug that may need to be fixed independently. Maybe this test is now required to be different depending on where the partial slab originated from? Check only necessary when taken from the per node partials?

Now there are two similar functions: get_freelist() and freeze_slab().

get_freelist() is used for the cpu slab, will transfer the freelist to
the cpu freelist, so there is "VM_BUG_ON(!new.frozen)" in it, since the
cpu slab must be frozen already.

freeze_slab() is used for slab got from node partial list, will be frozen
and get the freelist from it before using as the cpu slab. So it has the
"VM_BUG_ON(new.frozen)" in it since the partial slab must NOT be frozen.
And it doesn't need the cpu_slab lock.

This patch handles the third case: slab on cpu partial list, which
already held the cpu_slab lock, so change to reuse get_freelist() from
freeze_slab().

So get_freelist() has two cases to handle: cpu slab and cpu partial list slab.
The latter is NOT frozen, so need to remove "VM_BUG_ON(!new.frozen)" from it.

And "VM_BUG_ON(new.frozen)" in freeze_slab() is unchanged, so per node partials
are covered.

Thanks!

> 
>> There is some small performance improvement too, which shows by:
>> perf bench sched messaging -g 5 -t -l 100000
>>
>>            mm-stable   slub-optimize
>> Total time      7.473    7.209
> 
> Hmm... Good avoiding the lock/relock sequence helps.

