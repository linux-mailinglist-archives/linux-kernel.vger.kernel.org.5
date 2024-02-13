Return-Path: <linux-kernel+bounces-62885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ED485277E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA39D1C2351B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF3E2F2F;
	Tue, 13 Feb 2024 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OrjWC5Gp"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B27E1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790878; cv=none; b=EFR4OuLcKWf2+rsSeb68h52nYHUFwf1+Z+0xaD0S4MsKdKdYH/AaEO5nE1aPCETrxJ+MVw67qqxpxbffUqWmZWwl+xwIKdgnK4S4ocaTKlqcnzJHne3bowtCqIJsxLzmg/CYXtN1lsJwkf4RPEAxE/5+QvTmBN8macuiZZXSc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790878; c=relaxed/simple;
	bh=kRLrMhBp/ovjkKaTQ1mc7J+f9Wuv1iQ0sxQ+yiq61cQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oVL9U1/prFqFHgKGLROHEVfrsbngmsbg8L/qL7Bq/p9+5DL9MG6SvvbExWG7XoI1VcLgjrCCAg9mrguvAc1ig04HU+qhOnAMJlhEdM/QlMk07C3pcyn6tRp4R6JbdNCNjgPECi8mN0tevugAjALYQWhUclFfo2O7Y+qvCFvFzWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=OrjWC5Gp; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6818aa08a33so35211266d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1707790876; x=1708395676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HM8hAEfqj2bBm/D9KcwvAs/q4Mt022Y2JXJQP1FGLHs=;
        b=OrjWC5GpaGv8GoOeuwMIdbQEiVm4iP5j+/pp29x1U1Vv3CEzgVkQnAZHZ0KWM+JnzU
         uCV2pwF66TxqN33fyKPAgpVMEIiXsSRV5LQX+oaXa1U2UWH4XDxSezEog2lTSLjf/5p0
         +gRQpFhfl8GHZTfpvhK+MAUn6jc2YpmL5k464=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707790876; x=1708395676;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HM8hAEfqj2bBm/D9KcwvAs/q4Mt022Y2JXJQP1FGLHs=;
        b=l/hjvqd4ZUn8tcJQy72Ja6LrS8wACbraVZNek+KtzKrpAw5qB7o9a4GqAXlHZhZ4Kf
         1w9Iw6f/StWydUXZ+ol3tJoMlY0W6FuKOS7abm2Zz/MfbZV0RQiIIqBFTN02VIEnVoSw
         K3ftvEcOIcuEwhiNGBDarGZnDsPyTVO4n2FUXIrWIWHHtYuI1mkgw0eroBFVkvtCuPuN
         2/Yg8ZmaRYL2XYk+lkxOTFQCocHoBoloRXDHueODhWWOXSSfLFcEppZPDqnNowCXzAIb
         m4i2OM+dgXSC7O5qqaJ9jqRaa/2okAjqRWLA9fj04GhhUwWfEZ2/F4G6hWl+bIfJTEzW
         RuHg==
X-Forwarded-Encrypted: i=1; AJvYcCX1wc4tK2/Orht9iK49UMWYZ+VRvLmmedvFMWUat7IiiULtzSNRwO8mfsvHBkNsqQxh59OrXRw3F+QNRTlklAcM1PyJmerLvGJA7VNn
X-Gm-Message-State: AOJu0YytCZYIIzVCCJQg8TLrwYUF3GjP2QRdBRTeO69ezzQQpsMWkF1g
	c2ijTpzapMH7/lzUn3/ipheq8meWZiwug4hfk90g9mcsVybedpxXMwmKWuqPhvA=
X-Google-Smtp-Source: AGHT+IEa1LT8oLgYZiQftAsmKwPg5PSyeon1UaAAG8kgY2yfTDPzIHdnZkCcz6l5BlQaj1qkHmkHcA==
X-Received: by 2002:a05:6214:d65:b0:68c:c3a5:8120 with SMTP id 5-20020a0562140d6500b0068cc3a58120mr2881150qvs.3.1707790875705;
        Mon, 12 Feb 2024 18:21:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVuDcyn2pWIOCgq3ecODXDOrgYECjEQIQaOv3S2Ct5Mcwo7obA5/nyO8BLvhKogk2M6WM9ZznxDpdfmXluXRDUECfCag8/I0dA6Sz69dEwJM4vwewsU2P0982C3OKQ4vYipJnoqkD0G4IaNdqFY6s8pCJR66T85wllcqrraUbwCq/sz506e9l/jV782WjuZEXX8qFw12WXS90DvUWPBdqEc7Da6t9J1tY3LL6LeDzBxxaWqHXmGveOyA4PWn7j5ovzCbz/5hxg3PF8xQ10KbC/QkS9AoG0hCBI8ti5wJ08riNKKLcYH1cbaaufGP7kZO5tPUkFsonbnd9yy+AJtF9YlaPcC2T31/S7HB0xnO4PfWFGui+In6E/whnIRdRmbm0V7Roan5g7OOIMk+RymmLUgG9qFovDdfO1FHj9Ax2Y2O0kdww/oXT/6Pz7vQLvLS5u+r2mzY9/WR73RaKVujfSMvy5QAU3bvkadVC8ano7zL8I2c9RcsUE7ARoh37XLNerTb2HRZVK/hsRI+aaolOpYcPkM5sLfjSSzqnlQAhzowYpi7d+80e//Mn0PkEyQNNTN2akprttjihFEBbCO9ZH66iqvSOmV0GogBgGoxWTVNM=
Received: from [192.168.0.226] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id ol11-20020a0562143d0b00b0068cd2feff0asm789517qvb.117.2024.02.12.18.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 18:21:15 -0800 (PST)
Message-ID: <cced2edb-b4ac-4035-9930-9e41eeb1f263@joelfernandes.org>
Date: Mon, 12 Feb 2024 21:21:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 Suleiman Souhlal <suleiman@google.com>, youssefesmat@google.com
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
 <8cbf4bcd-431b-466f-b62d-ee03932e97f5@joelfernandes.org>
In-Reply-To: <8cbf4bcd-431b-466f-b62d-ee03932e97f5@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/2024 9:13 PM, Joel Fernandes wrote:
> 
> 
> On 11/4/2023 6:59 AM, Daniel Bristot de Oliveira wrote:
>> Add an interface for fair server setup on debugfs.
>>
>> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
>>
>>  - fair_server_runtime: set runtime in ns
>>  - fair_server_period: set period in ns
>>  - fair_server_defer: on/off for the defer mechanism
> 
> Btw Daniel, there is an interesting side-effect of this interface having runtime
> and period in 2 separate files :)
> 
> Say I want to set a CPU to 5ms / 10ms.
> 

Sorry let me try again, say I want to set 500us / 1ms.

Then I have to do the following to get it to work:

# echo 100000000 > /sys/kernel/debug/sched/fair_server/cpu0/period
# echo 5000000 > /sys/kernel/debug/sched/fair_server/cpu0/runtime
# echo 10000000 > /sys/kernel/debug/sched/fair_server/cpu0/period
# echo 500000 > /sys/kernel/debug/sched/fair_server/cpu0/runtime
# echo 1000000 > /sys/kernel/debug/sched/fair_server/cpu0/period

IOW, if I boot and do the following, it fails:

# echo 500000 > /sys/kernel/debug/sched/fair_server/cpu0/runtime
bash: echo: write error: Device or resource busy

 - Joel

