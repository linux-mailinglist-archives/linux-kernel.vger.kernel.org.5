Return-Path: <linux-kernel+bounces-104331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A9587CC3C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39121C2249B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96DD1B5A0;
	Fri, 15 Mar 2024 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqE8+0Fn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5D1AAC4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501889; cv=none; b=Oyxvw8+dzaxEZEt/GeXVMBjhKWYE12xDBMAA0fJhMYLyaY7HlnN2N5vulTLtYy9sgdjC316s1QZJ4GZD2JGEHUc/nHZ4B2FsXY/p5PjkQn1n0Mje14sLbsbLVeU/AFubY7+01OfmC6eQZVDzcZf4FVS6Zn5Xe2T1UUQI7XO/YpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501889; c=relaxed/simple;
	bh=Fw3gXm5GXjZxZ4JPw0DW5hTXqGv9wxu9zz3x6N9pKEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxcK6xszGJexCmoYpOKxgSjBgyBCqGbPRy0Y1AtOEM1OasEoqvqYmx7cKkW62j3X8QWBzjv5FLmMQ7Qf/OZ9EbWn0Mt+sRV7cTXGvwAdlMog1eMNE5FbsHvc4Ffm8E3EN0IiEhSFHWp4NQKJ5iN5Q4qcu4J7ji3Um2XfZtGLc5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqE8+0Fn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710501886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5BzWgrmdgiGxq+PlZflG+BHDXAH3VOatC+yV3V4Mnk=;
	b=LqE8+0FnLPIGae3x7zI0v1EJ5WswsvKPs2OGxi806Lqlja5I/TrEOdP5rXS+ZDGSFqeXRD
	XM/Bc3vhXSwEDLjnfv6aDH1epGTCt3zkQcl5w2Ay3d3to982743x8KuRlLTHy//BSbQ8U/
	7glDbPOhGBkEq4Ri8hA6DbIpr0HEuTs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-lH8_J2gjOMOiEoqxStw_Zg-1; Fri, 15 Mar 2024 07:24:45 -0400
X-MC-Unique: lH8_J2gjOMOiEoqxStw_Zg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e6a1625e4bso2266690b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710501884; x=1711106684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5BzWgrmdgiGxq+PlZflG+BHDXAH3VOatC+yV3V4Mnk=;
        b=fC17Uj420Px28nwK1+vkxW14snmODl/jYN8v/CGCcoRvR+97HuEt78epm9jDN04peD
         mt1KQ7F+xQTDZzjBk+x6IgKp2O343llw2UK1AJClq43aK0df2SyTGK8QGt4zOPsQMQma
         g4PWS5oVcxIO7Boibtw+dcLs+CGqGaF3VZDHRXEFp6sSF2DE0ynNLA0B5Qm6nAKyMPt8
         Gq4Cm0hR8P/IfefLnFEviIqnEjihyzRoiuUJH9m8oQVdjZ0UWO6jjxGZBEyr+kXs9i9A
         FLzj7pQ634XzW9KjZvGlT8/DXeK94vlt6n0Rf2u6F+T/0hNEaT5i7fnEhzSeGL5gwCkv
         oTew==
X-Forwarded-Encrypted: i=1; AJvYcCUaSV9vyifzVE5U2RdrBN0LbZKBLLfDJ8nOKdbuCvf7kLbRC6n1VCtX1zFd8pnaTPgq0vBk6RDNQ/71xzwQfCGEye9j5ghKGG+0iC8L
X-Gm-Message-State: AOJu0YyPfXT07eQLTNZHmLW+MhGB9nFCv5NH0dJa/fFiS+WuodDHN1x/
	uA8w35d/4B0I214zfWg5Mab4wpyjetd+ILrgeHRNclkKzov+V/zWDMI0UdOEo0JjC+sTOyOfo7P
	odKxrLvyZzSxxzkYN4yY4V/OXlNqgTZFyN0+UpvCXNwdE9kekLf4SXMea+5le/w==
X-Received: by 2002:a05:6a00:b96:b0:6e3:b1b3:139f with SMTP id g22-20020a056a000b9600b006e3b1b3139fmr3397437pfj.17.1710501883981;
        Fri, 15 Mar 2024 04:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv6UByGgC+juEfECmFf0FkqYVVrr5jER7l/udV8Oy/Bm8qarOlLsSpAREhnDHVoTzcBzZzsg==
X-Received: by 2002:a05:6a00:b96:b0:6e3:b1b3:139f with SMTP id g22-20020a056a000b9600b006e3b1b3139fmr3397425pfj.17.1710501883695;
        Fri, 15 Mar 2024 04:24:43 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id kt2-20020a056a004ba200b006e6233563cesm3131483pfb.218.2024.03.15.04.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 04:24:43 -0700 (PDT)
Message-ID: <66e12633-b2d6-4b9a-9103-bb79770fcafa@redhat.com>
Date: Fri, 15 Mar 2024 21:24:36 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
 shan.gavin@gmail.com, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, mochs@nvidia.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
 <20240314074216-mutt-send-email-mst@kernel.org>
 <23dc6d00-6a57-4ddf-8611-f3c6f6a8e43c@redhat.com>
 <20240314085630-mutt-send-email-mst@kernel.org>
 <63002c24-8117-458f-84c7-fa4f7acd8cc6@redhat.com>
 <20240315065318-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240315065318-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/15/24 21:05, Michael S. Tsirkin wrote:
> On Fri, Mar 15, 2024 at 08:45:10PM +1000, Gavin Shan wrote:
>>>> Yes, I guess smp_wmb() ('dmb') is buggy on NVidia's grace-hopper platform. I tried
>> to reproduce it with my own driver where one thread writes to the shared buffer
>> and another thread reads from the buffer. I don't hit the out-of-order issue so
>> far.
> 
> Make sure the 2 areas you are accessing are in different cache lines.
> 

Yes, I already put those 2 areas to separate cache lines.

> 
>> My driver may be not correct somewhere and I will update if I can reproduce
>> the issue with my driver in the future.
> 
> Then maybe your change is just making virtio slower and masks the bug
> that is actually elsewhere?
> 
> You don't really need a driver. Here's a simple test: without barriers
> assertion will fail. With barriers it will not.
> (Warning: didn't bother testing too much, could be buggy.
> 
> ---
> 
> #include <pthread.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <assert.h>
> 
> #define FIRST values[0]
> #define SECOND values[64]
> 
> volatile int values[100] = {};
> 
> void* writer_thread(void* arg) {
> 	while (1) {
> 	FIRST++;
> 	// NEED smp_wmb here
         __asm__ volatile("dmb ishst" : : : "memory");
> 	SECOND++;
> 	}
> }
> 
> void* reader_thread(void* arg) {
>      while (1) {
> 	int first = FIRST;
> 	// NEED smp_rmb here
         __asm__ volatile("dmb ishld" : : : "memory");
> 	int second = SECOND;
> 	assert(first - second == 1 || first - second == 0);
>      }
> }
> 
> int main() {
>      pthread_t writer, reader;
> 
>      pthread_create(&writer, NULL, writer_thread, NULL);
>      pthread_create(&reader, NULL, reader_thread, NULL);
> 
>      pthread_join(writer, NULL);
>      pthread_join(reader, NULL);
> 
>      return 0;
> }
> 

Had a quick test on NVidia's grace-hopper and Ampere's CPUs. I hit
the assert on both of them. After replacing 'dmb' with 'dsb', I can
hit assert on both of them too. I need to look at the code closely.

[root@virt-mtcollins-02 test]# ./a
a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
Aborted (core dumped)

[root@nvidia-grace-hopper-05 test]# ./a
a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
Aborted (core dumped)

Thanks,
Gavin


