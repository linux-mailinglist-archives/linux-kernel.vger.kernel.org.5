Return-Path: <linux-kernel+bounces-105480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9AB87DEF9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1167B1C20BD8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4381CF9A;
	Sun, 17 Mar 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9coI0di"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1871CF80
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710694252; cv=none; b=krfxT3fLAkrzxaWvn3fyTQlpbeHTLuHBhPsOUVj+xCrl5YrN3YnQ3MgdIPMKrBboo7NQInV56B56ajMnsRPhJVdG8pmYkyWRYA95TARpSqsSTHqYPbsbS3hgyEOPJ1Ky0TlHiG06J8RQ/09TrdqSpyZAJqqB4cdZIP2+xXqiidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710694252; c=relaxed/simple;
	bh=+69dr8c+5NtNEp3QMh1SBqo5IoYW8Yi5KCnmfdRbgf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWdqYg1zw5lTl/855P3eAd8l+MiXR1teUlc89t7dblV7a495rlD40hFerm0YC9jmY6O61ZJXWX+736iRdk8hpttDIGACq9eqfhmVHQnqwPMp6O/MboK3yK5wCZJch4b0ilIHoJRnfyLMfOz+Y0pcMPmpzBoFIBO8hGK7xkPSyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9coI0di; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710694249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGvhd+CS6miBdqthamxj1yw7gllwSdC3ScsQwTgOyD8=;
	b=g9coI0di0VSucWyJUEEYLCVyAxweQuhcj60X6JO2U05A+LxwQ6R3HsFzfTt0eN5w/ctscQ
	DlKKujzkdCYsGTC2EEpJsCEDELk4BX6pn3i9LEinXpHGiwqZwOajEYH5UrqNJqI0zJeiMO
	oeeof3p+z4YQSJjWM8+2a9q1+J5s7Bk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-m93XmnbsNfSV9HydwSKoXw-1; Sun, 17 Mar 2024 12:50:47 -0400
X-MC-Unique: m93XmnbsNfSV9HydwSKoXw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-568a3be9127so1931143a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 09:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710694246; x=1711299046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGvhd+CS6miBdqthamxj1yw7gllwSdC3ScsQwTgOyD8=;
        b=FC7DOYkXI/E8OZrOmC4TOrngmXyhBkbsBFszF9xOPqrHX8I48x2rWeh30i0P28GxKy
         dk3fLNsrdAN4x72EGjqAtE5F/e22MU9e8iWzMFvDHTa/6zlQ3GO4Vupuqsqn6yb5Pa4s
         GPWwZ0FTgmcK/Rg2LatHEGViZFj8b3xD3CDC/30NhyRN9h2ZbEQIn1u6GQ+EVudmSin9
         TF8XtR8banDaAiJUVGi36FsNxKrszy4VgF07hK5ZwsOkVea8EoZZ7DbadpPC6OUt2kb3
         IizLwQ+uOvPwXPFoiq0E3cpgsZteQHVm8dRT9dTJVc7L+zqKi9D8z21eXFsPddaBUOOc
         vrSg==
X-Forwarded-Encrypted: i=1; AJvYcCVSYmiODcQbt3YsCkAruTsgc7zByTFLsvRC4V4hUveJ1iAp8wdU4iCyDTPWfd7NkxfIFlJmE9dgXLZu/VdVdA9OJvRVJzFzLIBFv45/
X-Gm-Message-State: AOJu0YxIlaFsXcMVOSqLKveGcGVU5B86iL+zaWtkZR8g/xEbeOoM9VBv
	U0Tmq6AJxZsLnftVeie00Wzxw8dtbRNUlaTM5hqvgiDi5Ep9WZzHdNA1B9xcNizVuwmkEQEcORK
	haXbAzHPgHC3IadB0W5a17uEWXdAOT30z6YreSuHcB4xIh38adDUv7Dk7Ad+7q4QmAQY+FA==
X-Received: by 2002:a05:6402:538f:b0:568:b815:caa0 with SMTP id ew15-20020a056402538f00b00568b815caa0mr4116079edb.39.1710694245819;
        Sun, 17 Mar 2024 09:50:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Nit2FP2MKnbmfP4dsvWppBfe7t0ROYKCk6hvOVVepgry4K32jKa9tHwjSAngIboUrm7XDw==
X-Received: by 2002:a05:6402:538f:b0:568:b815:caa0 with SMTP id ew15-20020a056402538f00b00568b815caa0mr4116069edb.39.1710694245384;
        Sun, 17 Mar 2024 09:50:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f9:4d09:1b04:6193:3a0b:7c1])
        by smtp.gmail.com with ESMTPSA id b70-20020a509f4c000000b00567c34d8a82sm3950966edf.85.2024.03.17.09.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 09:50:44 -0700 (PDT)
Date: Sun, 17 Mar 2024 12:50:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240317124214-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
 <20240314074216-mutt-send-email-mst@kernel.org>
 <23dc6d00-6a57-4ddf-8611-f3c6f6a8e43c@redhat.com>
 <20240314085630-mutt-send-email-mst@kernel.org>
 <63002c24-8117-458f-84c7-fa4f7acd8cc6@redhat.com>
 <20240315065318-mutt-send-email-mst@kernel.org>
 <66e12633-b2d6-4b9a-9103-bb79770fcafa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e12633-b2d6-4b9a-9103-bb79770fcafa@redhat.com>

On Fri, Mar 15, 2024 at 09:24:36PM +1000, Gavin Shan wrote:
> 
> On 3/15/24 21:05, Michael S. Tsirkin wrote:
> > On Fri, Mar 15, 2024 at 08:45:10PM +1000, Gavin Shan wrote:
> > > > > Yes, I guess smp_wmb() ('dmb') is buggy on NVidia's grace-hopper platform. I tried
> > > to reproduce it with my own driver where one thread writes to the shared buffer
> > > and another thread reads from the buffer. I don't hit the out-of-order issue so
> > > far.
> > 
> > Make sure the 2 areas you are accessing are in different cache lines.
> > 
> 
> Yes, I already put those 2 areas to separate cache lines.
> 
> > 
> > > My driver may be not correct somewhere and I will update if I can reproduce
> > > the issue with my driver in the future.
> > 
> > Then maybe your change is just making virtio slower and masks the bug
> > that is actually elsewhere?
> > 
> > You don't really need a driver. Here's a simple test: without barriers
> > assertion will fail. With barriers it will not.
> > (Warning: didn't bother testing too much, could be buggy.
> > 
> > ---
> > 
> > #include <pthread.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <assert.h>
> > 
> > #define FIRST values[0]
> > #define SECOND values[64]
> > 
> > volatile int values[100] = {};
> > 
> > void* writer_thread(void* arg) {
> > 	while (1) {
> > 	FIRST++;
> > 	// NEED smp_wmb here
>         __asm__ volatile("dmb ishst" : : : "memory");
> > 	SECOND++;
> > 	}
> > }
> > 
> > void* reader_thread(void* arg) {
> >      while (1) {
> > 	int first = FIRST;
> > 	// NEED smp_rmb here
>         __asm__ volatile("dmb ishld" : : : "memory");
> > 	int second = SECOND;
> > 	assert(first - second == 1 || first - second == 0);
> >      }
> > }
> > 
> > int main() {
> >      pthread_t writer, reader;
> > 
> >      pthread_create(&writer, NULL, writer_thread, NULL);
> >      pthread_create(&reader, NULL, reader_thread, NULL);
> > 
> >      pthread_join(writer, NULL);
> >      pthread_join(reader, NULL);
> > 
> >      return 0;
> > }
> > 
> 
> Had a quick test on NVidia's grace-hopper and Ampere's CPUs. I hit
> the assert on both of them. After replacing 'dmb' with 'dsb', I can
> hit assert on both of them too. I need to look at the code closely.
> 
> [root@virt-mtcollins-02 test]# ./a
> a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
> Aborted (core dumped)
> 
> [root@nvidia-grace-hopper-05 test]# ./a
> a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
> Aborted (core dumped)
> 
> Thanks,
> Gavin


Actually this test is broken. No need for ordering it's a simple race.
The following works on x86 though (x86 does not need barriers
though).


#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#if 0
#define x86_rmb()  asm volatile("lfence":::"memory")
#define x86_mb()  asm volatile("mfence":::"memory")
#define x86_smb()  asm volatile("sfence":::"memory")
#else
#define x86_rmb()  asm volatile("":::"memory")
#define x86_mb()  asm volatile("":::"memory")
#define x86_smb()  asm volatile("":::"memory")
#endif

#define FIRST values[0]
#define SECOND values[640]
#define FLAG values[1280]

volatile unsigned values[2000] = {};

void* writer_thread(void* arg) {
	while (1) {
	/* Now synchronize with reader */
	while(FLAG);
	FIRST++;
	x86_smb();
	SECOND++;
	x86_smb();
	FLAG = 1;
	}
}

void* reader_thread(void* arg) {
    while (1) {
	/* Now synchronize with writer */
	while(!FLAG);
	x86_rmb();
	unsigned first = FIRST;
	x86_rmb();
	unsigned second = SECOND;
	assert(first - second == 1 || first - second == 0);
	FLAG = 0;

	if (!(first %1000000))
		printf("%d\n", first);
   }
}

int main() {
    pthread_t writer, reader;

    pthread_create(&writer, NULL, writer_thread, NULL);
    pthread_create(&reader, NULL, reader_thread, NULL);

    pthread_join(writer, NULL);
    pthread_join(reader, NULL);

    return 0;
}


