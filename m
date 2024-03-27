Return-Path: <linux-kernel+bounces-121540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8AA88E96B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451181F31EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCD813BAF1;
	Wed, 27 Mar 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dj9cK6Ah"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CBF13B28B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553580; cv=none; b=DKSyt6gFmgfu93yOaWD1/ZLtOCoL9HfMH9lwKDvBulCi9CtRX8jsN/ywc3AG/0fGMcntjUF9nruoy1vhbk7Lhj5VNKOs66DJ1MzxIUWbHuUbejD3sfrOdqY5mNO0nHOVUesCsT9FhFG0YkNJ8RKrBHZ+4Mdk83comwUudWl13R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553580; c=relaxed/simple;
	bh=P8G03x5KCTx8TF0jsmww7PVADh6Q30jFkCYr5AuRElA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxmTDOetpfYVmckxdNlMo+T1nZkr7xkO9SixT7tKEI2kfnuwCjjavk3acRWfb5kdZtncRyHmVwWcs2vEkaic7ijL2LF3m2zfLQwXBRVzoAr1jB82LTgvgWcRUThF+AREv7AePmUZRifEiS0TpQm8jVIXPMf4dbum2rpMaAElv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dj9cK6Ah; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3688d20b28dso14115105ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711553577; x=1712158377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PF7BpT7xgpetmn2SxPDafvgaaG8xfRfOiIeigueJv44=;
        b=dj9cK6AhEWzqlbDhCvRDfli7Y1bPpYgYfvcKbdrLqmxFosf8oE9jmwoETfSouaKb3l
         QJTKmLGzg8NhQVEcAz88u95V6k+gKfSaPV5dZGHf474ULtUAvrhQ0MWY80qz4LQvDiH6
         bPgWqaPbp1b2gZDm4OZLIrgi7SpLRzCm3/IyIxKgDT09IXhItQiu/0yFVRyXnwhHBaR5
         3STqfhsTjkwL4Dh0xBsasslrlYsc2GTmd2lkgtuk5cmPfJ5NE0731fdnjdazTlUOkm+p
         8jR5YrUrNYwHqegjzz+w9SHRZZmc0UMvFOBtPuamlIBG6mt8qkfrgmVzmJZo4pFvXTuf
         L7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553577; x=1712158377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PF7BpT7xgpetmn2SxPDafvgaaG8xfRfOiIeigueJv44=;
        b=B1ckrrryy3our7tDNWRyCo2UOWbOhluvdF7FceGsnuq+LhkmiEEWme2uEjc999owF6
         GtU3QKgzMBl7q4FX50IsMLBtA342Z+FYi0MpmxidRSbqe0h8E/oqW1/gW4MxR/tb/QnH
         SBWTHwF4qaF1dk41gNebgvaGnNrl/ONzt0bjvhW4evbIwZVPOiKYl5myCM6UGY/qiU3/
         8oDQqOvSzFt8/MCffEKb1Zsl+zqbIe0Au01xV2Ff3210iBNShfCzsKkNFz/EL5CxJ7Xi
         Fx/ikFVdDg5xNHK/fRixfU4h+eBxRLAl6WqEWrMJB2f9nrSOGdS0eqb1FvUVxVvTH/R7
         nwxA==
X-Forwarded-Encrypted: i=1; AJvYcCVNZDH0XTcg2OTdTz2iR/KjhMm/C2sqniqBcFCR+VwnoZegSTohr9s4hky0cn/1r3S458nzo3Y0Ud9xyZj6D4no/pSlvFbfWQFcLtX4
X-Gm-Message-State: AOJu0YxlDxRPZ/5ucWc6xW7Lp+PELO7ELY7R1GvhCvmyofZsuva65cyl
	s2eWZWK4PnPktlDV24V+xU0tYMwEpTr1F4ZZWitE6zGM7vqRa/EPXXLEt9HeVj4=
X-Google-Smtp-Source: AGHT+IGdMChH50XwuKfroi9Ldx4vewY2tL5TXEOV1NEDYN3TGmpIkbk/uE2En+YsZ29z9C1dTS/OdQ==
X-Received: by 2002:a92:c68e:0:b0:368:980a:d879 with SMTP id o14-20020a92c68e000000b00368980ad879mr354346ilg.17.1711553577622;
        Wed, 27 Mar 2024 08:32:57 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190])
        by smtp.gmail.com with ESMTPSA id r10-20020a922a0a000000b003687950b384sm3021534ile.18.2024.03.27.08.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 08:32:57 -0700 (PDT)
Message-ID: <c63150d8-a479-4d75-a826-3f87b1a792b9@sifive.com>
Date: Wed, 27 Mar 2024 10:32:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] riscv: Various text patching improvements
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jason Baron <jbaron@akamai.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <ZctnfZWWO3HCiXe5@andrea>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZctnfZWWO3HCiXe5@andrea>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 2024-02-13 6:58 AM, Andrea Parri wrote:
> On Sun, Feb 11, 2024 at 06:55:11PM -0800, Samuel Holland wrote:
>> Here are a few changes to minimize calls to stop_machine() and
>> flush_icache_*() in the various text patching functions, as well as
>> to simplify the code.
>>
>>
>> Samuel Holland (7):
>>   riscv: jump_label: Batch icache maintenance
>>   riscv: jump_label: Simplify assembly syntax
>>   riscv: kprobes: Use patch_text_nosync() for insn slots
>>   riscv: Simplify text patching loops
>>   riscv: Pass patch_text() the length in bytes
>>   riscv: Use offset_in_page() in text patching functions
>>   riscv: Remove extra variable in patch_text_nosync()
> 
> This does look like a nice clean-up.  Just curious (a "teach me"-like question),
> how did you test these changes? kselftests, micro-benchmarks, other?

For all my patches, I do boot testing on various physical boards (Unmatched, D1,
some internal hardware), plus some standard internal workloads. For
performance-related patches, I run microbenchmarks or whole-system benchmarks
(e.g. UnixBench). For this series specifically, I didn't do any extra
benchmarking, as all of the functional changes should be as fast or faster by
virtue of simply doing less work.

> BTW, I recall a parallel work from Alex and Bjorn [1] that might have some minor
> conflict with these changes; + both of them to Cc: for further sync.

As suggested by Alex, v2 of this series will be based on the latest version of
that patch.

Regards,
Samuel

> 
>   Andrea
> 
> [1] https://lore.kernel.org/lkml/20240206204607.527195-1-alexghiti@rivosinc.com/


