Return-Path: <linux-kernel+bounces-43511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C357841501
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EF11F25152
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1C91586CF;
	Mon, 29 Jan 2024 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8kwE4Qc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263B157E7C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563050; cv=none; b=aNCKH+jenzrhs3vYKJgjjnRm0170sfX2el8gBM/9YVKga7Sr5yw1w6fLWlxTiAK8pOUOOgHu2VE+QKodmd6jrkC0WvWIq2pHNOtSPjKbYBw3IAnwPt+i1fCyd9AVTayaAWIqzc/vx7mRWhOigciph7b43ifWm7RBNK8VuXOTbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563050; c=relaxed/simple;
	bh=54vT62+aNYp+SxJyI4e38QX0Bwc1o97kUMGA4AoFCTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=tWKEZxTxbf5pfZFzFQpRIBsEVezJLUapZLmtKR6w68xk15jQ7yIw7fh4xuot1GMoOJKmoLsW//MAxGQJhHwNEQxWWoz21XZS5PLgTaFojv/eQCmJI/pVgsiRVcRKsRTmmfgRGyvKI/VDIIwOO+GA6g3AmpZ3nzbqUGuuNT4QtWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8kwE4Qc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706563047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Tt9gHp4oSUklkVpx9ennGE0VbVJASE5Yjk0Tdw9WKo=;
	b=C8kwE4QcMgEHn/kmytMWLNVEn6ZC3736cvtIKypSkw+SVTuFYy/kxO7Ek/i5F2e5KmHZqM
	Tb2H7Q/I7WR5y2iYP/9vz5v98SiD/Xg3g2q2/NaQC4/RZvf9ndiSyXe7ukwT2owdAJdNAY
	cChDDA8u6vwoRGcP4mU28u1exNzuoLE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-V0LazezbMfqIU3yNc50ggQ-1; Mon, 29 Jan 2024 16:17:26 -0500
X-MC-Unique: V0LazezbMfqIU3yNc50ggQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5ffee6fcdc1so61790107b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706563045; x=1707167845;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Tt9gHp4oSUklkVpx9ennGE0VbVJASE5Yjk0Tdw9WKo=;
        b=LYSyiAIGXiwwMLSf3zok+V421s+iDDYsO3+72VILZv/Pktdw+vQok8APireVdjnS23
         v6h92gSq7/pa1L+CHElmP9C9FKzVNK/H9ubIhxlDuG8xVR7iniFbBXe7IOu+aCYMEdVT
         anYR05XI+0lbyjNxoF4Zw5YFfHuChlm1aRg8cZJ6c9+0UfD6rOkvC1cvHra9OXsru55t
         Xnw6bygxJomu1jvWqwPSpn0Sln2hNp5+3yEXl7X+LdZATHmb/yGHfi5+4QjzKdg+UcdX
         BCE3AczbqMvXwLIMx5D4HJ/n700NXBezGIL3lL8m9s88wJH35nJDV8NtLmn/MIaZOIV9
         XcQA==
X-Gm-Message-State: AOJu0YzONhQFEcznbrM8rEcVRNJh8/3rXmZmU+jGCQ69gJaxJ6fxu311
	4ej0iQYSpXzPEDeIWeHKn4wGtMY/SbHKXz+9wRYWxJoDQvAUViWgXr6kGUgT1WRizqnPds6RbW9
	7IhNHfyMQNkZGaHPETu7/bdRT9fKv3oR+U1k1JkSo8YpZtqRXBGHFs6A56fpoig==
X-Received: by 2002:a0d:ca58:0:b0:603:cba4:c500 with SMTP id m85-20020a0dca58000000b00603cba4c500mr4034144ywd.45.1706563045527;
        Mon, 29 Jan 2024 13:17:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8YkdGgIySQ2nIZEGfbGURoOxyLsugfFap8pCuebD6N+D6nah7N3DItB7Ze8VQv7s6T4abCA==
X-Received: by 2002:a0d:ca58:0:b0:603:cba4:c500 with SMTP id m85-20020a0dca58000000b00603cba4c500mr4034134ywd.45.1706563045258;
        Mon, 29 Jan 2024 13:17:25 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:e70d:8905:313f:9514:fada])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a0cf800b00783391f2066sm3415767qkj.58.2024.01.29.13.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 13:17:24 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] wq: Avoid using isolated cpus' timers on unbounded queue_delayed_work
Date: Mon, 29 Jan 2024 18:17:18 -0300
Message-ID: <ZbgV3kRXqigZ6pW2@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZbgQbOqkrWFPW0Mt@LeoBras>
References: <20240126010321.2550286-1-leobras@redhat.com> <ZbQozqY9qOa4Q8KR@slm.duckdns.org> <ZbQsr1pNSoiMbDrO@LeoBras> <Zbfr52x97-tLP66t@slm.duckdns.org> <Zbf8AVZaXwmExroX@LeoBras> <ZbgPveDBk8ysmF8a@slm.duckdns.org> <ZbgQbOqkrWFPW0Mt@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 29, 2024 at 05:54:04PM -0300, Leonardo Bras wrote:
> On Mon, Jan 29, 2024 at 10:51:09AM -1000, Tejun Heo wrote:
> > On Mon, Jan 29, 2024 at 04:26:57PM -0300, Leonardo Bras wrote:
> > > > Isn't that still the same number of add_timer[_on]() calls?
> > > 
> > > Yeah, sorry about this, what I meant was: If we are ok on calling 
> > > add_timer_on() multiple times, I would rather go with the above version, as 
> > > I think it's better for readability.
> > 
> > I don't know. It looks more verbose and less clear to me in that it isn't
> > immediately clear that every branch ends with timer being added. But this is
> > really minor, so unless you have a really strong opinion against the
> > suggested structured, can we just do that?
> 
> Sure, we can go with the one you suggested.

Hello Tejun,

While I was reworking the code with your suggestion, I found out 
that there is a difference in our suggestions:

###
        if (housekeeping_enabled(HK_TYPE_TIMER)) {
                cpu = smp_processor_id();
                if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
                        cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
                add_timer_on(timer, cpu);
        } else {
                if (likely(cpu == WORK_CPU_UNBOUND))
                        add_timer(timer, cpu);
                else
                        add_timer_on(timer, cpu);
        }
###

In your suggestion you always check housekeeping to be sure that the timer 
is never handled on an isolated cpu.

In my suggestions, it only checks and use housekeeping cpus only
if (cpu == WORK_CPU_UNBOUND).

I was previously afraid to use the approach of your suggestion due to some 
user having the need to handle the timer on the cpu passed as parameter.

But now thinking on it again, it does make sense that the CPU which handles 
the timer has nothing to do with the one that actually runs the work
(other than possible cacheline optimizations), and your suggestion is much 
better for CPU Isolation than mine.

I will send the v2 soon.

Thanks again,
Leo

> 
> Thanks!
> Leo
> 
> > 
> > Thanks.
> > 
> > -- 
> > tejun
> > 


