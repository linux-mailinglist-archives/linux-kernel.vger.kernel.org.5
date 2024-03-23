Return-Path: <linux-kernel+bounces-112378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA988791C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D158B284687
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F2A3CF42;
	Sat, 23 Mar 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TafdsgGA"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DBC1E526
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711204629; cv=none; b=HhK3zT9e8ZDMVnjmmBNrF7novBkGBWH+6kzrg1s5pMIyIHAH0XReXxdPYV8DbMTzVS1I8weXKYXGRAVzg8PGqpNZilCAuYssMEJ+mrXOfFLPRNzAoq/tT0z5e+Wv/iJlorV0eQb5wFsoJSsb/EZ/GERhO1Z+FzBL7n3M7ll1DE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711204629; c=relaxed/simple;
	bh=vpcyMVlI/DMXR+ERqbsS/zt6zwr1wOmpA5CiyYZ4s9c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LTFnC2CV2JhzFotNYSFbCRuurkVPGl6JtkRTzmTS3S5efBmv4zXRliFXPXjqIrzXfUq4GUTN/zcr1miV6oXX8P6GRfUdf97+nCkFNOqIje/dF+CiCdFqj3xEHRiN0eErxARV7QUrFAfe//3wIMIsQ8UBtc8nsCbtGDDiC9Q//ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=TafdsgGA; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69675e3be15so6643786d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1711204626; x=1711809426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jgQmyRyGlaC2KW5X3WgrWzY8+HMuHxtZClDLidEb6N4=;
        b=TafdsgGA+FpXt9smnvER+cAUDuvATwIE0vf2TV//QlhI1JVTEXz6ILJugGvvgn2NLD
         8ed4vTsr8PGoQN7HdRCVld1qmeL6CimSSMiBplTgnDsWojhBZD8MVo+Bs4/IdXl4IElD
         TCKD21F4Ue+5vD3buWJXm00NLubJe09ORQE4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711204626; x=1711809426;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgQmyRyGlaC2KW5X3WgrWzY8+HMuHxtZClDLidEb6N4=;
        b=qf0VzcL80almvRQL4TlfXzMJJaBmMI/PCPYPVyswwor6dfMsG7FEkIV6MMvd+Kde3o
         3UbFIUZlk6diue8NOtGH94F0SAXtwE3jbnCZioRFOxuCKoqGxOzIZ0B21iOAira6t3H4
         pbdKaPZrMQAwXdomV1PiPYUs9dJG8hCj2kIgMdpeWd2kyI5XxEX0vDVlS7Ku8mlO9rsF
         xgp5bmds3r4RHE4AyHaD84qfD1xpoK1mrGNUhP6DgyRIIZdZtkYt9K4BWJsVZuDKET04
         dYMa9IKsEn7CnZ09TFslSEpY9pko4OrKHyaHSUQFgwmcx2QrVJC209ezmlMkczBARCtb
         SCeA==
X-Forwarded-Encrypted: i=1; AJvYcCWEnGe/d1VttbssFVL4lx57hoENOHcuXkFRJxl8rSEEZxRURynLN+GdqDhYvLCSWWBeL4j/OB+NapJvBB63oxBKGIUeOWy48dNF25nM
X-Gm-Message-State: AOJu0Yw7PnZ7VJgGujoRIyHod5D/bVqpV+gX5IJNp1VBUvi9TJDqiH3n
	1rZTjNPjt9a2jCf2XE45sFBtAH2MDr39W75+gMqB75uqO5Bf8PEUGuuBU1t506Q=
X-Google-Smtp-Source: AGHT+IEpNj3HJ5rsk2hJiPONlgM54XS2X1t7dUDn+fuwrtVH/jR4T8ZI0tu9da7sbr6zd/uuro5wWA==
X-Received: by 2002:a05:6214:496:b0:690:8a01:eb2b with SMTP id pt22-20020a056214049600b006908a01eb2bmr3006904qvb.56.1711204626416;
        Sat, 23 Mar 2024 07:37:06 -0700 (PDT)
Received: from [10.5.0.2] ([185.195.59.198])
        by smtp.gmail.com with ESMTPSA id u11-20020ad45aab000000b00690fc99a836sm2105198qvg.105.2024.03.23.07.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 07:37:05 -0700 (PDT)
Message-ID: <76ba5a16-5c77-47c3-ba93-0eeff22f936f@joelfernandes.org>
Date: Sat, 23 Mar 2024 10:37:03 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
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
 David Vernet <void@manifault.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <1e26ce6d-5567-477f-847b-445160b2f18c@joelfernandes.org>
 <d7d8540e-c417-41fa-aea9-acb80541a30d@kernel.org>
 <bf4a1255-4f70-4c41-8967-81e86c6c2d7f@joelfernandes.org>
Content-Language: en-US
In-Reply-To: <bf4a1255-4f70-4c41-8967-81e86c6c2d7f@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> On 3/20/2024 3:24 PM, Daniel Bristot de Oliveira wrote:
>>> On 11/4/2023 6:59 AM, Daniel Bristot de Oliveira wrote:
>>>> Among the motivations for the DL servers is the real-time throttling
>>>> mechanism. This mechanism works by throttling the rt_rq after
>>>> running for a long period without leaving space for fair tasks.
>>>>
>>>> The base dl server avoids this problem by boosting fair tasks instead
>>>> of throttling the rt_rq. The point is that it boosts without waiting
>>>> for potential starvation, causing some non-intuitive cases.
>>>>
>>>> For example, an IRQ dispatches two tasks on an idle system, a fair
>>>> and an RT. The DL server will be activated, running the fair task
>>>> before the RT one. This problem can be avoided by deferring the
>>>> dl server activation.
>>>>
>>>> By setting the zerolax option, the dl_server will dispatch an
>>>> SCHED_DEADLINE reservation with replenished runtime, but throttled.
>>>>
>>>> The dl_timer will be set for (period - runtime) ns from start time.
>>>> Thus boosting the fair rq on its 0-laxity time with respect to 
> 

Hi,
Upon reflection, might we simplify the solution by treating RT as a deadline
reservation as well?

The RT deadline reservation can have shorter deadline so it will be interrupted
less immediately by CFS due to EDF. Would that work, or was that already tried
and has other dragons?

If we could pull that off, then we do not need all the deferral/timer stuff and
could considering dropping this patch. Yes it is more code, but this 6th patch
is also big and non trivial.

Juri, Daniel, all, what do you think?

(On the other hand if we want to keep this patch as a first step, and
incrementally improve that is Ok, but  I believe we do need to make a decision..)

By the way, is there a still a slot in OSPM available to discuss these? If so
that would be great. I can put up some slides.

cheers,

 - Joel

