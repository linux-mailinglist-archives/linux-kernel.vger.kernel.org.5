Return-Path: <linux-kernel+bounces-68731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D812B857F21
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5992AB2585E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91EF12C804;
	Fri, 16 Feb 2024 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmXh0IEq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC512C7F7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093111; cv=none; b=qUFTwMd97qqaPoBzYRJ71713FAlgaMgcQZRQmCtPyNS7jd8ejnqoGb2iPUxnvaAULyjfe7Tl3rQAGw5d9BLBAxKppDB1IpSblVXNuvia5DEDIQtxmkZKmv4yjs9b40iIi94IOo/NmeZA9YnGEy9s+1gjGQE+4GLnQ5x0jr/g4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093111; c=relaxed/simple;
	bh=n10Wi6rrBxgiYULKOy0cBzcAPiyEzBjJZzVeqL76wBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RRb+QVOdjgcgdcK9xzig0yOFlZKC5ZwIXYcAgNtZBdkEr32Xc/o1nTRT7p+H+nclRGg9pnCMjCfHtztO/b4zz+liXv7L6UVdHmfvwMdBIr7yEYLTJwVp+3NV4OBGeYNu55Sq1sDTATbfWWk38QJn0qL4+TeroS0RqwALSrCYFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmXh0IEq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708093109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rC9ifvju7BLNt4riptMvs2TUwj1XaSqlPfSm7QrPEPs=;
	b=ZmXh0IEqbh6/LM8ZgL8TgZWlyS2c+7D4sH3lGka6IlGrErUkVGhUF9sSiuMa60zXwyDw9e
	NtlwiVaV2qX9EaHdJ3NYYlsz48aRUxlrWNpjRJOTh58UFOdQHCYWIUWUocO88/UccgvZ44
	uWNiVJ3Wqgfhcg4wbjynOPVEvgxOyho=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-q7Cyuw1QONyVO44T4yRQtg-1; Fri, 16 Feb 2024 09:18:27 -0500
X-MC-Unique: q7Cyuw1QONyVO44T4yRQtg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5640681bc11so168247a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708093106; x=1708697906;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rC9ifvju7BLNt4riptMvs2TUwj1XaSqlPfSm7QrPEPs=;
        b=vrH9Qc9T0FfxRT/3D+uv0FUE1R2WifvlPf5N7nvKZ6XXayUzPRa+frRaF8qAsJcVMn
         grlptVjPmR3w1rqizzy47CKVd04j0p4nrqrgUVK1N8BxTI1JgJS2txsSANEPwnPE8iU7
         ZcZXK+6rytmJKauT5T9jOaz4OdAmcvR7K5Pr/a0hy/zDQkvq8E4rtkiqqr1eWUnRjXDX
         6o0WED8rXru+88xzUBoiSrNAOyShq6PsXbeaoBOAAOBcObmZN9kCMxukq0fU5tC3yAdw
         ULitnkLa0FwfuxYYOK6QI6ALX/3ZTw+iDdcUW9DIzcoUu256pjvB2oxloxVMFRAm4te7
         /7yA==
X-Forwarded-Encrypted: i=1; AJvYcCUtJEbqghYbDZK4DOAhW4L1zQkaZLS4C/ofGBRxyaHsyUC7FCZhsEfv1iF0IO3eKvtUTzqjkty8WeTpSTFoGEydsy10UAY+sA3CmiOe
X-Gm-Message-State: AOJu0Yww6j/VbxdUcXe58WRYkEIl4moH9KdYxI1Gl6BkPDKoSGSnXE2z
	jHhxLSMDtSSQSR2v9zzodzPUtCKONoI3rksxGZsh75hvELZ5IcYJxflBRwngnU52oqxPEccLVBr
	nqXP/QIJPgN9s4jCoHllfnlWB6hbzgH7PWNRdoOet8ZuT3XD+2uGnOOYogAW3CA==
X-Received: by 2002:a17:906:3942:b0:a3c:b136:e607 with SMTP id g2-20020a170906394200b00a3cb136e607mr3845811eje.43.1708093106658;
        Fri, 16 Feb 2024 06:18:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe5pSfuaaWUK7Uo6YfmCsYOhrst6luuLx8Fe5Y5/z56loxHe2lT6PFZXjblUmMjO55iyZg4A==
X-Received: by 2002:a17:906:3942:b0:a3c:b136:e607 with SMTP id g2-20020a170906394200b00a3cb136e607mr3845775eje.43.1708093106304;
        Fri, 16 Feb 2024 06:18:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709061dc900b00a3ce9081547sm1606509ejh.39.2024.02.16.06.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:18:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7DA6610F5BEE; Fri, 16 Feb 2024 15:18:25 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <shuah@kernel.org>
Subject: Re: [PATCH RFC bpf-next v2 02/10] bpf/helpers: introduce sleepable
 timers
In-Reply-To: <r3yhu4h23tdg2dqj7eq3lhevsigvvb3qkge3icxmaqpgkayvoi@gxfxstkr2pxl>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
 <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
 <a72147f5-2b7d-4267-9881-6a645c575838@linux.dev>
 <r3yhu4h23tdg2dqj7eq3lhevsigvvb3qkge3icxmaqpgkayvoi@gxfxstkr2pxl>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 16 Feb 2024 15:18:25 +0100
Message-ID: <87eddccx1q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benjamin Tissoires <bentiss@kernel.org> writes:

> On Feb 15 2024, Martin KaFai Lau wrote:
>> On 2/14/24 9:18 AM, Benjamin Tissoires wrote:
>> > +static void bpf_timer_work_cb(struct work_struct *work)
>> > +{
>> > +	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, work);
>> > +	struct bpf_map *map = t->map;
>> > +	void *value = t->value;
>> > +	bpf_callback_t callback_fn;
>> > +	void *key;
>> > +	u32 idx;
>> > +
>> > +	BTF_TYPE_EMIT(struct bpf_timer);
>> > +
>> > +	rcu_read_lock();
>> > +	callback_fn = rcu_dereference(t->sleepable_cb_fn);
>> > +	rcu_read_unlock();
>> 
>> I took a very brief look at patch 2. One thing that may worth to ask here,
>> the rcu_read_unlock() seems to be done too early. It is protecting the
>> t->sleepable_cb_fn (?), so should it be done after finished using the
>> callback_fn?
>
> Probably :)
>
> TBH, everytime I work with RCUs I spent countless hours trying to
> re-understand everything, and in this case I'm currently in the "let's
> make it work" process than fixing concurrency issues.
> I still gave it a shot in case it solves my issue, but no, I still have
> the crash.
>
> But given that callback_fn might sleep, isn't it an issue to keep the
> RCU_reader lock so long? (we don't seem to call synchronize_rcu() so it
> might be fine, but I'd like the confirmation from someone else).

You're right, it isn't. From the RCU/checklist.rst doc:

13.	Unlike most flavors of RCU, it *is* permissible to block in an
	SRCU read-side critical section (demarked by srcu_read_lock()
	and srcu_read_unlock()), hence the "SRCU": "sleepable RCU".
	Please note that if you don't need to sleep in read-side critical
	sections, you should be using RCU rather than SRCU, because RCU
	is almost always faster and easier to use than is SRCU.

So we can't use the regular RCU protection for the callback in this
usage. We'll need to either convert it to SRCU, or add another
protection mechanism to make sure the callback function is not freed
from under us (like a refcnt). I suspect the latter may be simpler (from
reading the rest of that documentation around SRCU.

>> A high level design question. The intention of the new
>> bpf_timer_set_sleepable_cb() kfunc is actually to delay work to a workqueue.
>> It is useful to delay work from the bpf_timer_cb and it may also useful to
>> delay work from other bpf running context (e.g. the networking hooks like
>> "tc"). The bpf_timer_set_sleepable_cb() seems to be unnecessary forcing
>> delay-work must be done in a bpf_timer_cb.
>
> Basically I'm just a monkey here. I've been told that I should use
> bpf_timer[0]. But my implementation is not finished, as Alexei mentioned
> that we should bypass hrtimer if I'm not wrong [1].

I don't think getting rid of the hrtimer in favour of
schedule_delayed_work() makes any sense. schedule_delayed_work() does
exactly the same as you're doing in this version of the patch: it
schedules a timer callback, and calls queue_work() from inside that
timer callback. It just uses "regular" timers instead of hrtimers. So I
don't think there's any performance benefit from using that facility; on
the contrary, it would require extra logic to handle cancellation etc;
might as well just re-use the existing hrtimer-based callback logic we
already have, and do a schedule_work() from the hrtimer callback like
you're doing now.

-Toke


