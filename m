Return-Path: <linux-kernel+bounces-86435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384F586C550
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9732128F06F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3475D91A;
	Thu, 29 Feb 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TL9LNCsQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D7B5B697
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199214; cv=none; b=eawqtD6mgChOoxipI/3YnDpwrbaSlgudXGwNr8y4obex1ZA3/3dZZxCHWQfa6faD1lPweXGglMP+lOKy0l6TQ8F7/soeZkWnlv3fCCW/NrPM0P5CXeWm2lbMsHjhEWkvHmr7PIx7l84vB68RMlZVEhvoY9eoUkwSN3DmmLTWq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199214; c=relaxed/simple;
	bh=OCAkzthHT1GednMqkQR0khKweCPNUd0S8CFHc0nINQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAjfuLoV9a2LzLfG4xrs2ea/BgGWlR9OEEbDz0n9q9nu3cHVnBu2z4uV3uilJDoqh+vaUvZnkxSNjteLjS2fQUlHM61iaaNtBisiD21crHUha8zMLI7PqtRVUB/IR73fHTLeCcDvife6fLGsz6T9/2WobOEiHoeNqSt7hBSqXMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TL9LNCsQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709199211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0lTD41pfzWAqfwwm7qOf8/65xi10nz/8NBAoqHJCpo=;
	b=TL9LNCsQ6av6BO/k9HfBZ8V6Jvb8ggjw8qYukNy5V4npsoSt9jiYWtvqjO2jiKR4fUZC4G
	lN1VeA4zLN1Ggwq9cpUlNv9I+Dkvk3vCYDDAwf06EW9zzwUpxj5jJXt5mnTBV3VPcs0kVu
	3BnMmgrB0DZWHkSM8/9JX8v7TW97qTE=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-QPWg-4uQP8yJOiyNhTouIQ-1; Thu, 29 Feb 2024 04:33:29 -0500
X-MC-Unique: QPWg-4uQP8yJOiyNhTouIQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c1c1e68dc5so716460b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199208; x=1709804008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0lTD41pfzWAqfwwm7qOf8/65xi10nz/8NBAoqHJCpo=;
        b=eLd77aGioICZvyEpVnepyXTYZhVe4WJ2QKhsAMTjOd+kHVRdrcjveJjDTJ0k3oUP2g
         2TAMX/9dySGB9uMIlceOpRAmgomgj0h9TvF4LVmaonsCJKLAz+Hl/g2V7l/1jySbd80P
         6ILXZmuKm2lEA1N7I4BqsUWp+pvXYWF1G+OxJvAAm/4TqoCrxAwqUfeupHdklb8cdXtG
         Fg5cUpn1q0mXsC0Wvx2hCDIL7rbG5V9+zJUp6cdld4ZdJeoNaVbF7NoH6x0/+go4YCqp
         3rMRxCrOvHzR0Bq0wVmA15SEzew/v+pKK4c4CHwrX3eyLbHCCgqcw8EvxybcZcjEugES
         5pKw==
X-Gm-Message-State: AOJu0YyFIsWFmK35KBI76N+Npw7e0IlhPJrEeWdNMaS3NLAy/E8aGJyO
	mya4izcYX8l4aCbCvwKx3fr1ziAEugIrJ6lqCCf1gZU77UwR5069XoNotaCoZ+EXxA6IvllrWig
	o3MwpMG+XHvq3YR/aK2cHCTukwzSKRHZEhNnQhv1sYMhAV54AhEis939DBGsbmzymPPXpy/An
X-Received: by 2002:a05:6358:5923:b0:17b:8a02:a9b6 with SMTP id g35-20020a056358592300b0017b8a02a9b6mr1475332rwf.21.1709199208223;
        Thu, 29 Feb 2024 01:33:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ3FhXf54FrmUmhWMB78EuZTnPJKOo+16rR9CKAmGMemUrKffmyritMCgFqds8i13JNwSKlg==
X-Received: by 2002:a05:6358:5923:b0:17b:8a02:a9b6 with SMTP id g35-20020a056358592300b0017b8a02a9b6mr1475314rwf.21.1709199207832;
        Thu, 29 Feb 2024 01:33:27 -0800 (PST)
Received: from localhost.localdomain ([176.206.22.187])
        by smtp.gmail.com with ESMTPSA id qq1-20020a0562142c0100b0069030b7dee3sm542406qvb.30.2024.02.29.01.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:33:27 -0800 (PST)
Date: Thu, 29 Feb 2024 10:33:16 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
	jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
	andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH 23/30] sched/fair: handle tick expiry under lazy
 preemption
Message-ID: <ZeBPXNFkipU9yytp@localhost.localdomain>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-24-ankur.a.arora@oracle.com>
 <Zd85iRyY6-zlo2wl@localhost.localdomain>
 <871q8v7otl.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q8v7otl.fsf@oracle.com>

On 28/02/24 22:43, Ankur Arora wrote:
> Juri Lelli <juri.lelli@redhat.com> writes:

..

> > For deadline we call resched_curr_tick() from the throttle part of
> > update_curr_dl_se() if the dl_se happens to not be the leftmost anymore,
> > so in this case I believe we really want to reschedule straight away and
> > not wait for the second time around (otherwise we might be breaking the
> > new leftmost tasks guarantees)?
> 
> Yes, agreed, this looks like it breaks the deadline invariant for both
> preempt=none and preempt=voluntary.
> 
> For RT, update_curr_rt() seems to have a similar problem if the task
> doesn't have RUNTIME_INF.
> 
> Relatedly, do you think there's a similar problem when switching to
> a task with a higher scheduling class?
> (Related to code is in patch 25, 26.)
> 
> For preempt=voluntary, wakeup_preempt() will do the right thing, but

Right.

> for preempt=none, we only reschedule lazily so the target might
> continue to run until the end of the tick.

Hummm, not sure honestly, but I seem to understand that with
preempt=none we want to be super conservative wrt preemptions, so maybe
current behavior (1 tick of laziness) is OK? Otherwise what would be the
difference wrt preempt=voluntary from a scheduler pow? Yes, it might
break deadline guarantees, but if you wanted to use preempt=none maybe
there is a strong reason for it, I'm thinking.

> Thanks for the review, btw.

Sure. Thanks for working on this actually! :)

Best,
Juri


