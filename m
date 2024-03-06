Return-Path: <linux-kernel+bounces-94567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49504874181
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C4E2831B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF1517736;
	Wed,  6 Mar 2024 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QpgO+716"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF714006
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709757738; cv=none; b=Q1XGDE5aMOS9Rs7gdgfBst0I2cA/DcBzNqpOyO7kMwYjpI/eBZXzux/M41GJaILMbGU4KynwiMyJW8lUBYZ+RkIkvTNx5sRw/5yfM5CUo/VQT4glZjb+s7+Mhnzz6qpMNK0wMMQW+lFsMW2xSopIedjfoUqKmhr6KpO2ZwhL5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709757738; c=relaxed/simple;
	bh=cYX1beKtszcOqBiG4dZyOQlR1F7E+GSotuZxX/m5OJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6FuSlHbyz+Eh1gpOdx3h16qfk8W1qCq8Ox6armhsFe6LJTZ1Or9RG8GUXfnjDheY5xvbW61xzXCpR1O04svbDZtHFs8aPFPKUpALXFR0WyGjm+p0atW5mz7d9H5kT3MR5b2wfqT/4LB1xspoZ2WE4/Jl6Id5onRX3Wsgs+ngXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=QpgO+716; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6907ab22f47so660496d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709757736; x=1710362536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5XEfRywm5pe7dMN3IUl6f6i+3v4HajOdA+bk3NTouk=;
        b=QpgO+716xhhLVLGPD4pM9uAfoHb85HfxC3aJwQMBDC91e/ZSmRN4hUU52TyNYTPswu
         8Yu9hRIIJxYUVfau4K2/Dgw6w2EiCuNGOl+rwQtWhiizwhMjS44+o6jZ8m//Q13z8Kpg
         xrsqn3LIy6hxKSHr4ZEgyMl2JeNoEs8VlCinA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709757736; x=1710362536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5XEfRywm5pe7dMN3IUl6f6i+3v4HajOdA+bk3NTouk=;
        b=MSh6YuHfEV9V9Dm5pV9qGxK0Eh8/Qi2oMxbGF0QkeHWN3nhkdAHUnBj0g+ACsB1ZBW
         GlJVZERU8x1HkQN82s5Unc83KcSkXg8EVzbzzaQwDBUWgJG6nzFPMwB7rK3xyKaGpaR/
         8G/WexOaxUINLX18Buk0tpJ6ueLQh/iHLF8WCW9QV1JZOuxvlLuFA+u0Q8yj7XS/Yi4k
         E2YbAv6koo+dXCcUbJMg8sVOLpWfGocbAuVVZELZwOm4O/eweIAcMcifqQHoSpylTXeE
         2sDldrRabItlaTQYQoMXRQ2V+8sl4B/gEZdg4VG2cAMH21HQLRtcwmiz4jbTFqxlpScF
         9teA==
X-Gm-Message-State: AOJu0YxZjXoBXhkZd+NVYCLMld3710LuOA45gWvLu20mXeF7q3GeWsLF
	LLSJQ4z/8OmLi8Nb0Ki5B0hqMn6m3v1Lqw3RdvosXGyceR1Ap3oRC16d6UjVS+I=
X-Google-Smtp-Source: AGHT+IFRpUbmAquh6H46LFTcKsuQMbE9hWKICs+SxImokJG19sxmvO1Yw45fjpe4ejO4LtNoWrJ/rg==
X-Received: by 2002:a05:6214:114d:b0:68f:6410:99d7 with SMTP id b13-20020a056214114d00b0068f641099d7mr5963128qvt.64.1709757735626;
        Wed, 06 Mar 2024 12:42:15 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id pc16-20020a056214489000b006904d5bf148sm7450111qvb.134.2024.03.06.12.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 12:42:14 -0800 (PST)
Message-ID: <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
Date: Wed, 6 Mar 2024 15:42:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
Content-Language: en-US
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
 torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
 andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com> <87frx514jz.fsf@oracle.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <87frx514jz.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ankur,

On 3/5/2024 3:11 AM, Ankur Arora wrote:
> 
> Joel Fernandes <joel@joelfernandes.org> writes:
> 
[..]
>> IMO, just kill 'voluntary' if PREEMPT_AUTO is enabled. There is no
>> 'voluntary' business because
>> 1. The behavior vs =none is to allow higher scheduling class to preempt, it
>> is not about the old voluntary.
> 
> What do you think about folding the higher scheduling class preemption logic
> into preempt=none? As Juri pointed out, prioritization of at least the leftmost
> deadline task needs to be done for correctness.
> 
> (That'll get rid of the current preempt=voluntary model, at least until
> there's a separate use for it.)

Yes I am all in support for that. Its less confusing for the user as well, and
scheduling higher priority class at the next tick for preempt=none sounds good
to me. That is still an improvement for folks using SCHED_DEADLINE for whatever
reason, with a vanilla CONFIG_PREEMPT_NONE=y kernel. :-P. If we want a new mode
that is more aggressive, it could be added in the future.

>> 2. you are also planning to remove cond_resched()s via this series and leave
>> it to the scheduler right?
> 
> Yeah, under PREEMPT_AUTO, cond_resched() will /almost/ be not there. Gets
> defined to:
> 
> static inline int _cond_resched(void)
> {
>         klp_sched_try_switch();
>         return 0;
> }
> 
> Right now, we need cond_resched() to make timely forward progress while
> doing live-patching.

Cool, got it!

>> Or call it preempt=higher, or something? No one is going to understand the
>> meaning of voluntary the way it is implied here IMHO.
> 
> I don't think there's enough to make it worth adding a new model. For
> now I'm tending towards moving the correctness parts to preempt=none and
> making preempt=voluntary identical to preempt=none.

Got it, sounds good.

> Thanks for the review.

Sure! Thanks for this work. Looking forward to the next series,

 - Joel


