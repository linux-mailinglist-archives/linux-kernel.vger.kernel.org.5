Return-Path: <linux-kernel+bounces-153544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B829D8ACF70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1851C2178E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6E152182;
	Mon, 22 Apr 2024 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyMdN45R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82F14006
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796310; cv=none; b=Ov8R01Oka+yOiCubpIAH0pPrCEZJxcAABAsdwd47bFbXjLTRbG7uUN4Has7Fh7gYqUZeEk6ASgRYHOHxGaYEAOoyRS4NsKM6Izi41MYFHirfztIGoWHDn/1315XiOUnsio4oK0p3H9tMUXStEisML6YzxoHaPZuxbnrRyp5jrWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796310; c=relaxed/simple;
	bh=pzmC56HFWs/QTkhB91JQ7NJkOCAI0HM6A928WLI6WQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kxiqsvmL2FuNn7qCzXmbo69NykDfsaEE7GQJkv6Ukv7LdL5xl1Jiz0erODGp5DGgWRJFeQztvMfCubX8jT+2Hta6RDqz9wI9/6RByjbSFKr9pSKm/zjNBCBywj+qLx4K/ZUFv5VdHzhmlRBySfdwSBmxJG9OW72/DzgYHDoEfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyMdN45R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713796307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhkGPPHbdmj1oVdDbXBZ1Ge+SsAT/eWQ0YBbLSXrT28=;
	b=ZyMdN45RT/soQ3fyy306vD6u0T4CNZrSXSFu8kbzC3ejl+i8B8gmMcBdzCqHe+g5VSFidj
	1RJezsB2f1xC7PGxjLjms9LwyaLm7v+UR+PJNtqY1A7gFN7Emj5KNdGoDDZ/WJA1xx55XB
	VxAtJmDFMDIOeqCkaxm+PfymGnBEv0U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-qlrb3V0YOOGfAgeEXoj_fg-1; Mon, 22 Apr 2024 10:31:46 -0400
X-MC-Unique: qlrb3V0YOOGfAgeEXoj_fg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69b09fe4792so63661596d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713796306; x=1714401106;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhkGPPHbdmj1oVdDbXBZ1Ge+SsAT/eWQ0YBbLSXrT28=;
        b=fyNNt0xdifE64inzmEORmoihdtzJTp0WHqe4jy1fmxxzhVH6YAw2MtPhtIm4351hTx
         +n2ESpDQKIMDSwpuXKXerGIvwgbPAwlkmsAIT56BJqiG9HntEm2P46kwBvo7FiQjb5Rt
         EhKoJHAX5zMGgVRB6vnmRRl1zApO2VuCO80AB/5TL8NuWuKTUEzyjNc4EvpGDgvmNGbN
         2qZp5N7pzQjInFfSjSHIRHc4V+XKOQAdinZE1LSspLnW/gDJicN48Op98x2kYduYqbjJ
         lOP0Eb4vKObthJ1wO1Ws9jaY0cK7sQJi5pMT8REOogEQtlCK2ZWkN8Kt22kkXTyuBION
         Sp/w==
X-Forwarded-Encrypted: i=1; AJvYcCXK46KNV9sCFvM9gT9+VJyxM97lYTiIKQlhb+BJTU/gd1aU2nHme4MiaX0fskovIC5fTXOK/7FIEfNeWo9vg6u6ZyrZbOau3+Bt7ZrR
X-Gm-Message-State: AOJu0YxJVJ54nkiL3Ih3mnlO3tVumHJ+2Aoley7eTBdqsBhX/oX3zs8Z
	PjH6cbZh56CRcsJFljpX1tToHz6F41o2MrSpkUA5iAmm23s2axGRzSPwcgZo35RmjinZGVXfcxa
	yuN8Tsft8aGgUEiZTpdCWhE3zqIZ23hfCi4pKA4jH60m4H85qJq22S2ojg/toug==
X-Received: by 2002:ad4:424f:0:b0:69b:1a43:27f5 with SMTP id l15-20020ad4424f000000b0069b1a4327f5mr10265937qvq.35.1713796305989;
        Mon, 22 Apr 2024 07:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgAG0VNYTVd95FVX0FTRiJkrXveidEN6CjszexmNNUFWwDrDgOvzjbXwvC9ZePvx8e1ZiGoQ==
X-Received: by 2002:ad4:424f:0:b0:69b:1a43:27f5 with SMTP id l15-20020ad4424f000000b0069b1a4327f5mr10265921qvq.35.1713796305582;
        Mon, 22 Apr 2024 07:31:45 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id g12-20020a0cf08c000000b006913aa64629sm4260487qvk.22.2024.04.22.07.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 07:31:45 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, mleitner@redhat.com, David Ahern
 <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 0/2] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <CANn89iJRev5Kn_jEgimDfyHosmiyYeaz2gHRGS2tcFC-yMbGaQ@mail.gmail.com>
References: <20240415113436.3261042-1-vschneid@redhat.com>
 <CANn89iJYX8e_3Or9a5Q55NuQ8ZAHfYL+p_SpM0yz91sdj4HqtQ@mail.gmail.com>
 <xhsmhmspu8zlj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CANn89iJRev5Kn_jEgimDfyHosmiyYeaz2gHRGS2tcFC-yMbGaQ@mail.gmail.com>
Date: Mon, 22 Apr 2024 16:31:41 +0200
Message-ID: <xhsmhbk618o4y.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Apologies for the delayed reply, I was away for most of last week;

On 16/04/24 17:01, Eric Dumazet wrote:
> On Mon, Apr 15, 2024 at 4:33=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
>>
>> On 15/04/24 14:35, Eric Dumazet wrote:
>> > On Mon, Apr 15, 2024 at 1:34=E2=80=AFPM Valentin Schneider <vschneid@r=
edhat.com> wrote:
>> >> v4 -> v5
>> >> ++++++++
>> >>
>> >> o Rebased against latest Linus' tree
>> >> o Converted tw_timer into a delayed work following Jakub's bug report=
 on v4
>> >>   http://lore.kernel.org/r/20240411100536.224fa1e7@kernel.org
>> >
>> > What was the issue again ?
>> >
>> > Please explain precisely why it was fundamentally tied to the use of
>> > timers (and this was not possible to fix the issue without
>> > adding work queues and more dependencies to TCP stack)
>>
>> In v4 I added the use of the ehash lock to serialize arming the timewait
>> timer vs destroying it (inet_twsk_schedule() vs inet_twsk_deschedule_put=
()).
>>
>> Unfortunately, holding a lock both in a timer callback and in the context
>> in which it is destroyed is invalid. AIUI the issue is as follows:
>>
>>   CPUx                        CPUy
>>   spin_lock(foo);
>>                               <timer fires>
>>                               call_timer_fn()
>>                                 spin_lock(foo) // blocks
>>   timer_shutdown_sync()
>>     __timer_delete_sync()
>>       __try_to_del_timer_sync() // looped as long as timer is running
>>                        <deadlock>
>>
>> In our case, we had in v4:
>>
>>   inet_twsk_deschedule_put()
>>     spin_lock(ehash_lock);
>>                                           tw_timer_handler()
>>                                             inet_twsk_kill()
>>                                               spin_lock(ehash_lock);
>>                                               __inet_twsk_kill();
>>     timer_shutdown_sync(&tw->tw_timer);
>>
>> The fix here is to move the timer deletion to a non-timer
>> context. Workqueues fit the bill, and as the tw_timer_handler() would ju=
st queue
>> a work item, I converted it to a delayed_work.
>
> I do not like this delayed work approach.
>
> Adding more dependencies to the TCP stack is not very nice from a
> maintainer point of view.
>
> Why couldn't you call timer_shutdown_sync() before grabbing the lock ?

We need the timer_shutdown_sync() and mod_timer() of tw->tw_timer to be
serialized in some way. If they aren't, we have the following race:

                             tcp_time_wait()
                               inet_twsk_hashdance()
  inet_twsk_deschedule_put()
    // Returns 0 because not pending, but prevents future arming
    timer_shutdown_sync()
                               inet_twsk_schedule()
                                 // Returns 0 as if timer had been succesfu=
lly armed
                                 mod_timer()

This means inet_twsk_deschedule_put() doesn't end up calling
inet_twsk_kill() (because the timer wasn't pending when it got shutdown),
but inet_twsk_schedule() doesn't arm it either despite the hashdance()
having updated the refcounts.

If we leave the deschedule as a del_timer_sync(), the timer ends up armed
in inet_twsk_schedule(), but that means waiting for the timer to fire to
clean up the resources despite having called inet_twsk_deschedule_put().


