Return-Path: <linux-kernel+bounces-150366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3836B8A9DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB6A1F22FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA87165FDF;
	Thu, 18 Apr 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B1LZJjoU"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887F916ABFA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452952; cv=none; b=IiXfr4tA8gK8thNAYVYcRy+PI2oN0zkBlHPlQ7wrOpd12FcM4wzYaYwneqjaEZStoHrzJ2X/f6IJgC0MeoeUSoiXCN4tMiK90Zy+WFzsuDIJEpuwUIZ60ZELZ+BvvYImQJlIFEdokVhEvphSnkyTE8J1ynHRIgsK6c+LFo90wIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452952; c=relaxed/simple;
	bh=k+6r0GGg1vUggBFS1HFE+EGyXIm1V66bbTL8/78gpIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWO2oHltiCCvYjADwAT8PqunQeYV1/NOE+buCWiPELR/ImPXRryICqLb5hNkY3JE4eF8dN5z/nZJwP7IlcqtR5O7e1GEYPnYwlml490LD4bXxJ3k/20tRJgd7nBEr2xkWfYDWbhzS/dbFJW6uhoqg0FvekccWeQVKc22a+js2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B1LZJjoU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ab48c1156dso51950a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713452950; x=1714057750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9O3FV94jh7vQc95L9k9nvefdNDVfaT9ibGX8CYdkE0=;
        b=B1LZJjoUCtuOlGcn9U1cjNB8sFIjuVv1mQmVusLC7U5bSe2BDxPeb7PGK/33ad+bqU
         ko/ZJ8dY9HhSS6fdKjasdd4PV7gPyYyQgDlre+82dSCb/pmvMzXwQagxGYMz+Co+69wi
         ycdVvJKuCA3aw+qds9laOO3L3eEkCWoW7tdngejNkRT7gEqFxB0GuVo3ZLJ3lo8YqMgM
         2jTDaScUD5Ca7toegrIE/OZ7gvt6wBA2oikW4pt+IU8Pv3EK2PEVjm7d3x7QKGmKcxWI
         iucju/+lE0j7ZW+3LaMz7tFKFpMSJ92Q5E+fehRyMVRNx4LADj2qVaDI6fHUvlFNqfSK
         Of5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452950; x=1714057750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9O3FV94jh7vQc95L9k9nvefdNDVfaT9ibGX8CYdkE0=;
        b=UPDTkp5Cy0jwFPO97krSEvv4oKrS3/VDl7oJAvF2gcDb4UX7e5o7ZlYvE77ZnpYxpQ
         yOTPWtCTPb/+Hy5dP3wkvsNEf06l30GFuujKRZefexnS618ktzktp69ulxSLKS1njp48
         fIU04cxxQUQjjGcy6Gl/RSM9uew9jtUgJGnZ8Ubx9MDDybO5qXLNknzdt/VKS0dksHxP
         8gxN83/jvfPQT9If7Fn8sm7y5ru9GQKUKTR5wkStCVmQUpwiu/ipQiyinTpn7RwqENgD
         OSudGerpO52Aci2nLg7WnBUdSISIs0luEv41gPeYVdyzw/DDPX7Sc8sBED4XedZUGQ92
         BYcw==
X-Forwarded-Encrypted: i=1; AJvYcCX1Tcm2UrTrmWIjGqgFbVV8scbrPULLT5rP1t2RoMMUQU/k3mjPQzPcVAr+xq9CDiRQkXynBLQkgIa8UzrPpsGoaa5Vj+Eoq0hHyxR4
X-Gm-Message-State: AOJu0Yz/u7QnwFT2nUCzWRM5iPVDCOQe7Z/jpz1HRmKyUh+Af9r0++5s
	Qlgk1G+aoxb/9b1NNQk8P/l83NqxeDFH81OUT3nURBBZpu/osW4apTn/gllM/Mg=
X-Google-Smtp-Source: AGHT+IEpDI3SLb6DK8eESf91mbfRxTkqd15fvUPDNtPee/hawli5VCPVwcKmvtkaX2PmBdDDW5btOg==
X-Received: by 2002:a17:90a:7e0e:b0:2a3:be48:23f3 with SMTP id i14-20020a17090a7e0e00b002a3be4823f3mr2885933pjl.4.1713452949760;
        Thu, 18 Apr 2024 08:09:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090aa11600b002ab664e5e17sm1547775pjp.1.2024.04.18.08.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:09:09 -0700 (PDT)
Message-ID: <362c3c63-6fd9-401c-9281-e2e0c7efc14a@kernel.dk>
Date: Thu, 18 Apr 2024 09:09:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] completion: move blk_wait_io to
 kernel/sched/completion.c
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Mike Snitzer <msnitzer@redhat.com>,
 Damien Le Moal <dlemoal@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <31b118f3-bc8d-b18b-c4b9-e57d74a73f@redhat.com>
 <20240417175538.GP40213@noisy.programming.kicks-ass.net>
 <546473fd-ca4b-3c64-349d-cc739088b748@redhat.com>
 <ZiCoIHFLAzCva2lU@infradead.org>
 <5f3d434b-e05c-445f-bee5-2bb1f11a5946@kernel.dk>
 <ZiEyLvL6Pq_RB-Eh@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZiEyLvL6Pq_RB-Eh@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/24 8:46 AM, Christoph Hellwig wrote:
> On Thu, Apr 18, 2024 at 08:30:14AM -0600, Jens Axboe wrote:
>> It certainly is a hack/work-around, but unless there are a lot more that
>> should be using something like this, I don't think adding extra core
>> complexity in terms of a special task state (or per-task flag, at least
>> that would be easier) is really warranted.
> 
> Basically any kernel thread doing on-demand work has the same problem.
> It just has an easier workaround hack, as the kernel threads can simply
> claim to do an interruptible sleep to not trigger the softlockup
> warnings.

A kernel thread can just use TASK_INTERRUPTIBLE, as it doesn't take
signals anyway. But yeah, I guess you could view that as a work-around
as well.

Outside of that, mostly only a block problem, where our sleep is always
uninterruptible. Unless there are similar hacks elsewhere in the kernel
that I'm not aware of?

-- 
Jens Axboe


