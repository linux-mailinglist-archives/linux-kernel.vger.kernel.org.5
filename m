Return-Path: <linux-kernel+bounces-55360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1963C84BBB9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEDCEB268B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AA7D52B;
	Tue,  6 Feb 2024 17:17:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12093D51A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239849; cv=none; b=nzjCGdxyR12t9rLDKgrU7E9XhM7WlYnpMgCM3+f2E2hwPFWi5A5B2ogj7smTVf8K8Rr9Apru/H/GEgRAEfzYIsZxizZSBLXHMLrGlrofX0HV51FVIO7D8IzZxTksi4USNzqHFCZWe5y7xb+/b2THzpz6ZlIax071Zly6SThX1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239849; c=relaxed/simple;
	bh=cfHGigLto/qWdnBkKMG62iRBESRbiwnB/3N57/mdW90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B12YSNFC4QF3Co+ni2KN29tuQDQNj8bSb35lwH59UEdeY4kugoVGJlMs+nXYEVgd9ojB6n87Yt38z1BongAXLbPh1qBhcDxs0MpTGRpogZRiP2T6qaGpkcpE0bxAAsA4gaNgtAwMiJyETLS84kStRx34+LKPeMe0w1plE6wqlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58FFA1FB;
	Tue,  6 Feb 2024 09:18:07 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8AE13F64C;
	Tue,  6 Feb 2024 09:17:23 -0800 (PST)
Message-ID: <f58fb725-39b6-4b76-bc23-bc0526bddccb@arm.com>
Date: Tue, 6 Feb 2024 18:17:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Pierre Gondois <Pierre.Gondois@arm.com>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
 <20240124222959.ikwnbxkcjaxuiqp2@airbuntu>
 <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>
 <20240126014602.wdcro3ajffpna4fp@airbuntu>
 <5249d534-d7ac-4cbc-a696-f269cb61c7d1@arm.com>
 <20240206150653.34ouqhbt4yz2cmgo@airbuntu>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240206150653.34ouqhbt4yz2cmgo@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 16:06, Qais Yousef wrote:
> On 02/05/24 20:49, Dietmar Eggemann wrote:
>> On 26/01/2024 02:46, Qais Yousef wrote:
>>> On 01/25/24 18:40, Vincent Guittot wrote:
>>>> On Wed, 24 Jan 2024 at 23:30, Qais Yousef <qyousef@layalina.io> wrote:
>>>>>
>>>>> On 01/23/24 09:26, Vincent Guittot wrote:
>>>>>> On Fri, 5 Jan 2024 at 23:20, Qais Yousef <qyousef@layalina.io> wrote:
>>>>>>>
>>>>>>> From: Qais Yousef <qais.yousef@arm.com>

[...]

>>> It seems we flatten topologies but not sched domains. I see all cpus shown as
>>> core_siblings. The DT for apple silicon sets clusters in the cpu-map - which
>>> seems the flatten topology stuff detect LLC correctly but still keeps the
>>> sched-domains not flattened. Is this a bug? I thought we will end up with one
>>> sched domain still.
>>
>> IMHO, if you have a cpu_map entry with > 1 cluster in your dtb, you end
>> up with MC and PKG (former DIE) Sched Domain (SD) level. And misfit load
> 
> Hmm, okay. I thought the detection of topology where we know the LLC is shared
> will cause the sched domains to collapse too.
> 
>> balance takes potentially longer on PKG than to MC.
> 
> Why potentially longer? We iterate through the domains the CPU belong to. If
> the first iteration (at MC) pulled something, then once we go to PKG then we're
> less likely to pull again?

There are a couple of mechanisms in place to let load-balance on higher
sd levels happen less frequently, eg:

  load_balance() -> should_we_balance() + continue_balancing

  interval = get_sd_balance_interval(sd, busy) in rebalance_domains()

  rq->avg_idle versus sd->max_newidle_lb_cost

> Anyway. I think I am hitting a bug here. The behavior doesn't look right to me
> given the delays I'm seeing and the fact we do the ilb but for some reason fail
> to pull

[...]


