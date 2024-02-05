Return-Path: <linux-kernel+bounces-52992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB6849F3E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA61F212F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CBC33CD9;
	Mon,  5 Feb 2024 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB+lUYTy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57B3CF58
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149125; cv=none; b=RgLxqxX1s9E4eScEoVZEOo+dH5LPP7eP/ayxXIPgHWNXInMdWpGSeTWGxEnBTwG9IRqInfxeqUVP6NzlutP1QofuRywxs7WAf3CYrMVmtyDgnArgyaIVvFFqT0EZ8C/KHC4dOv0NPc8+Jmys5OT0WxpXTyaZJfC9lAThOtDuhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149125; c=relaxed/simple;
	bh=nbsv/ESIHwJSh7QNZhf5AczCQ2fjogWmJ59hgx6/47g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ayDD8b7NzSkCfgBvzE9Xf5Zn5BO9glyT1GyFAGVlgdczUlPjTtNt5787x+tJJGWtT788Oyq0yWTd0ZZ5B5GrUPs1Ag7Mra5g3bH36LuPgkCJh03hoBgLjgSxJ1jpFcXDpPaibHvWbj9aQNQr16pTjt3XisYCwos6hrDpfM1H/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VB+lUYTy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707149122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/YDhdLXQmNxdWoNzbOTZZc0FZCB0nekr5D8YLQhiDIs=;
	b=VB+lUYTyjBdpryWeyBCMxhbmplJ1kvBY1QS/39pL6rcZZxNhQhKE1K4Ds4ZGp7B/YBVVWP
	xTvpksnN2dO9TjIWaxHm1nvro+1XCI8XFzEFmh4lpgvrVi4n+TlIcvPfuB0J0+aeiRy28S
	RFr4QhH49h7gFd8WDKg+Fn20UoNneUo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-5g0mnRzcO9-9M5Y4xxofEw-1; Mon, 05 Feb 2024 11:05:20 -0500
X-MC-Unique: 5g0mnRzcO9-9M5Y4xxofEw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68c8a5327a2so30639176d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149118; x=1707753918;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YDhdLXQmNxdWoNzbOTZZc0FZCB0nekr5D8YLQhiDIs=;
        b=CckA3QBA7acfFD0BDQedrbpIEmuN4IJkGzgoNPkZtf1o3Z+vMD9226/uOU8ZtLuVnE
         Yq/6uVhE/guIkrJ5Xrwg0AgK5Vj7+e24p8BySOggQkYjh9GQbMf7qkLeQW5Zwd2T9JsF
         opjWyvFxw7K6oARUpqGDbTwyEc+1ribHOv11BXvX2H7+IbxTa9TSCPfr5nG7Sqn01zbJ
         +t4uUFcnPeXzE40b+Y6ouPfPk9cNbUWP35U6S4RicWcNMt+iYDvSuFjqZJB7kiKrd34t
         HS7cZao8p9cAvYHqjkV/MtXPhGoQh4fxZ3Yb28cLIDmx7YxeJYh6JSeiUvo5ZO+DNCh7
         9riw==
X-Gm-Message-State: AOJu0YwLVyygtZUrO4lRtDeudy+AqfQiGh9R2eDzvlKtvxfEQJ+MG/7i
	AZ10Htk5yhg0/iM+halJ19CjqtltAOlGe31DUXy6FrQJOzZg5uOd5i+gye4M49TFrQGTQqrvmji
	irIztP37x88K18g/hoF0atXwffO8xibIeYmxllgCNYkVXoS79jqId9GrBU5FTScgbzXShqKzltM
	HJ0vmWC+OPP0C2Be8WSn3pcjn3nHfOGsBc7lhbPusL6CbPvg==
X-Received: by 2002:a05:6214:234c:b0:68c:a48b:1837 with SMTP id hu12-20020a056214234c00b0068ca48b1837mr4341672qvb.56.1707149118729;
        Mon, 05 Feb 2024 08:05:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEK5wyGMRf7y6ljyaUktOKqjtoG7O1AlU4Dzog+BlM4E7VbbrOpKjXLqEv/DTIi2DjcIw0sw==
X-Received: by 2002:a05:6214:234c:b0:68c:a48b:1837 with SMTP id hu12-20020a056214234c00b0068ca48b1837mr4341637qvb.56.1707149118410;
        Mon, 05 Feb 2024 08:05:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYwD3XfR1ZPE9TqWGg3RvY3sNwUSjHOdjGmXJ3/N5P5Ej0vSwBHvh2RUH0bVziZ5Y7T5cgd9ANVYBG5awCOONDk8xfJ1hlvOtHmS+ZlAwPeOYXDjLdeBPc8nv4Fauig/uy4GE5pQgn1ZuM44GvuDZHsHO++anq6ehVIYdL0BjYaZhc1nTgP4c3bXx3Yaq2DmFOBgSbsotNQtxU4+vBFgZfojkQLlZ9lqNyA82da4KSUp803akvbzP9zs495pgDe9743+yiXz7PKNs0T+iMQaNFdm0=
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id y14-20020a0ceace000000b0068c4aabcdb6sm103206qvp.29.2024.02.05.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:05:17 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: richard clark <richard.xnu.clark@gmail.com>, nico@fluxnic.net,
 mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about the ipi_raise filter usage and output
In-Reply-To: <ZcDwoce6Ok25K6Dm@FVFF77S0Q05N>
References: <ZcDwoce6Ok25K6Dm@FVFF77S0Q05N>
Date: Mon, 05 Feb 2024 17:05:14 +0100
Message-ID: <xhsmhmssehp6t.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 05/02/24 14:39, Mark Rutland wrote:
> [adding Valentin]
>

Thanks!

> On Mon, Feb 05, 2024 at 08:06:09AM -0500, Steven Rostedt wrote:
>> On Mon, 5 Feb 2024 10:28:57 +0000
>> Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> > > I try to write below:
>> > > echo 'target_cpus == 11 && reason == "Function call interrupts"' >
>> > > events/ipi/ipi_raise/filter
>> >
>> > The '=' checks if the target_cpus bitmap *only* contains CPU 11. If the cpumask
>> > contains other CPUs, the filter will skip the call.
>> >
>> > I believe you can use '&' to check whether a cpumask contains a CPU, e.g.
>> >
>> >    'target_cpus & 11'
>>
>> 11 == 0xb = b1011
>>
>> So the above would only be true for CPUs 0,1 and 3 ;-)
>
> Sorry, I misunderstood the scalar logic and thought that we treated:
>
>       '$mask $OP $scalar', e.g. 'target_cpus & 11'
>
> .. as a special case meaning a cpumask with that scalar bit set, i.e.
>
>       '$mask $OP CPUS{$scalar}', e.g. 'target_cpus & CPUS{11}'
>
> .. but evidently I was wrong.
>
>> I think you meant: 'target_cpus & 0x800'
>>
>> I tried "1 << 11' but it appears to not allow shifts. I wonder if we should add that?
>
> Hmm... shouldn't we make 'CPUS{11}' work for that?
>

It /should/ already be the case, the user input with the curly braces is
parsed as a cpulist. So CPUS{11} really does mean CPU11, not a hex value to
be interpreted as a cpumask.

However...

> From a quick test (below), that doesn't seem to work, though I think it
> probably should?
> Have I completely misunderstood how this is supposed to work, or is that a bug?
>

The CPUS{} thingie only works with an event field that is either declared as a
cpumask (__cpumask) or a scalar. That's not the case for ipi_raise, the
target_cpus event field is saved as a "raw" bitmask.

There /should/ have been a warning about the event filter though, but I
think it's not happening because I'm allowing more than just FILTER_CPUMASK
in parse_pred() to make it work for scalars. I'll go poke around some more.

Generally for this sort of IPI investigation I'd recommend using the newer
trace_ipi_send_cpu() and trace_ipi_send_cpumask() (for which CPUS{}
filtering works).
If it's only the function call interrupts you're interesting in, have a
look at trace_csd_queue_cpu().

> Mark.


