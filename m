Return-Path: <linux-kernel+bounces-105592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBC787E122
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D73281112
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0139A21A04;
	Sun, 17 Mar 2024 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFXewxET"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0741C6A4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710718918; cv=none; b=OurJJFaCKixbYZvEi+27j+YAQ6yuNT4dDOgYXYdypeVPOorq4AM/sGGjjC9I0uOC5mEZJYzjrJskBQ/6IA/rp0RznPqJndhbA6RZk/NfEs4RTr576AZhUPb6/xaSZUWX2xI3eQjAPQyj20u7u7NvkG63DsiphVBOgAHB4dPyia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710718918; c=relaxed/simple;
	bh=E0W+KPeRYgxbpPySJO8obxXEgAJoWeJnktC3ciM4R2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bE1eIjd0fkgzgWqQy/bAViRu16A/Ot64pQko+ezY//8mCI45zaUs2R3UQpVgCorPYpRFBFFkxcHq5B0zWGPhHBmG9C7Fr3ujqG3u3wi7RhULnCLGmQdaBulear30EzvvPlyRH/lq+wtlv2I0eyWiIcbhrLZjm9IfIWXGiL5SZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFXewxET; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710718915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VoTTZNQ7z7ZfL93MKLZfFSy4HN01sRZbWbDkkopjTv8=;
	b=DFXewxETtylaNti/cnrGW1uOW3RJoLLq51ovYAHo8ZsRqrVTvE0LsexrTOmL83p+ee55NG
	a9nMALTmdBVmjesBPvCPc7PEbkKYgN3iMR4J5xW/7U/0xl7rEgADf8VeuptSlKEYnnB8om
	X8Kf9xZhp2OTqIFY5cLwaSNM2GVgBCQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-no-coj6yNNqoD_ZlodPgwQ-1; Sun, 17 Mar 2024 19:41:54 -0400
X-MC-Unique: no-coj6yNNqoD_ZlodPgwQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dd72cc8590so44334945ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 16:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710718913; x=1711323713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoTTZNQ7z7ZfL93MKLZfFSy4HN01sRZbWbDkkopjTv8=;
        b=T3yp9RsouDrpaOY7aCGqDa5QF7F7fuPIF7YLVf+u0HOhECf3aFKNzIvbj+KbWk2ebX
         vN/zV4xxl/NNbu1yfgoNHT3g8PM9gVvinpbVovlrHR9PATpswwewRCCV/yVD3Wu/521J
         z8iFMupVBQqU/+rw3bSAweLe3CX70varkBTmGnQsH3V/50dRdaiaToxRzNmnOUWY/qnb
         I27HfCRQMOfELn8OkZrtq1o/ITBmd3kzTjNIYAFP2UtIxriXU7AXzvBf8/lrVL1OxzUz
         DHKhzVAsKItNgIk3CE5HivnGFcOvc5P+k05OpVRLNQMAu4C9VEWPNUtDWqRibp5SdZen
         EQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCV5pN2+4JtIVL7Obgp8JysY7QzJKR9Z/CiQqHuIrrWtp+p2ykh9Adr0estmzP+WUz/l42Y9xc5wBLxMHntjlg4kmdLH8vd0akt/OHmm
X-Gm-Message-State: AOJu0Yz+hy/80D0jHbrLSDkau3mfiw3zYPLQo2EqYFOGIPGSYlYN1qHG
	pty3GYThLNjO+Oe8a+MrkxjVe1GTcCw0n6MDp2AYRT66VO5IDKL/yBSdA77/W9R093dC/HnDXi/
	1s1/NE7i/W6dGe+OLFcerxsIzJG8KKcAfF8SNbfeaR3KFSvooiSOlr2qRAFIcYA==
X-Received: by 2002:a17:902:ee4d:b0:1dd:ba2c:c1c7 with SMTP id 13-20020a170902ee4d00b001ddba2cc1c7mr10818296plo.60.1710718912912;
        Sun, 17 Mar 2024 16:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEO/wqqfVzrPrcABSXe5zrIiQqNXi3v2vD8YlMPl0S/co5tg57mXT8eRN5oJ0hKyrMK8luEA==
X-Received: by 2002:a17:902:ee4d:b0:1dd:ba2c:c1c7 with SMTP id 13-20020a170902ee4d00b001ddba2cc1c7mr10818282plo.60.1710718912496;
        Sun, 17 Mar 2024 16:41:52 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902a38900b001e004924412sm2654363pla.108.2024.03.17.16.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 16:41:51 -0700 (PDT)
Message-ID: <589d980f-2e4d-47b4-9dc7-8c64dbe271ce@redhat.com>
Date: Mon, 18 Mar 2024 09:41:45 +1000
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
 <66e12633-b2d6-4b9a-9103-bb79770fcafa@redhat.com>
 <20240317124214-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240317124214-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/24 02:50, Michael S. Tsirkin wrote:
> On Fri, Mar 15, 2024 at 09:24:36PM +1000, Gavin Shan wrote:
>>
>> On 3/15/24 21:05, Michael S. Tsirkin wrote:
>>> On Fri, Mar 15, 2024 at 08:45:10PM +1000, Gavin Shan wrote:
>>>>>> Yes, I guess smp_wmb() ('dmb') is buggy on NVidia's grace-hopper platform. I tried
>>>> to reproduce it with my own driver where one thread writes to the shared buffer
>>>> and another thread reads from the buffer. I don't hit the out-of-order issue so
>>>> far.
>>>
>>> Make sure the 2 areas you are accessing are in different cache lines.
>>>
>>
>> Yes, I already put those 2 areas to separate cache lines.
>>
>>>
>>>> My driver may be not correct somewhere and I will update if I can reproduce
>>>> the issue with my driver in the future.
>>>
>>> Then maybe your change is just making virtio slower and masks the bug
>>> that is actually elsewhere?
>>>
>>> You don't really need a driver. Here's a simple test: without barriers
>>> assertion will fail. With barriers it will not.
>>> (Warning: didn't bother testing too much, could be buggy.
>>>
>>> ---
>>>
>>> #include <pthread.h>
>>> #include <stdio.h>
>>> #include <stdlib.h>
>>> #include <assert.h>
>>>
>>> #define FIRST values[0]
>>> #define SECOND values[64]
>>>
>>> volatile int values[100] = {};
>>>
>>> void* writer_thread(void* arg) {
>>> 	while (1) {
>>> 	FIRST++;
>>> 	// NEED smp_wmb here
>>          __asm__ volatile("dmb ishst" : : : "memory");
>>> 	SECOND++;
>>> 	}
>>> }
>>>
>>> void* reader_thread(void* arg) {
>>>       while (1) {
>>> 	int first = FIRST;
>>> 	// NEED smp_rmb here
>>          __asm__ volatile("dmb ishld" : : : "memory");
>>> 	int second = SECOND;
>>> 	assert(first - second == 1 || first - second == 0);
>>>       }
>>> }
>>>
>>> int main() {
>>>       pthread_t writer, reader;
>>>
>>>       pthread_create(&writer, NULL, writer_thread, NULL);
>>>       pthread_create(&reader, NULL, reader_thread, NULL);
>>>
>>>       pthread_join(writer, NULL);
>>>       pthread_join(reader, NULL);
>>>
>>>       return 0;
>>> }
>>>
>>
>> Had a quick test on NVidia's grace-hopper and Ampere's CPUs. I hit
>> the assert on both of them. After replacing 'dmb' with 'dsb', I can
>> hit assert on both of them too. I need to look at the code closely.
>>
>> [root@virt-mtcollins-02 test]# ./a
>> a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
>> Aborted (core dumped)
>>
>> [root@nvidia-grace-hopper-05 test]# ./a
>> a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
>> Aborted (core dumped)
>>
>> Thanks,
>> Gavin
> 
> 
> Actually this test is broken. No need for ordering it's a simple race.
> The following works on x86 though (x86 does not need barriers
> though).
> 
> 
> #include <pthread.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <assert.h>
> 
> #if 0
> #define x86_rmb()  asm volatile("lfence":::"memory")
> #define x86_mb()  asm volatile("mfence":::"memory")
> #define x86_smb()  asm volatile("sfence":::"memory")
> #else
> #define x86_rmb()  asm volatile("":::"memory")
> #define x86_mb()  asm volatile("":::"memory")
> #define x86_smb()  asm volatile("":::"memory")
> #endif
> 
> #define FIRST values[0]
> #define SECOND values[640]
> #define FLAG values[1280]
> 
> volatile unsigned values[2000] = {};
> 
> void* writer_thread(void* arg) {
> 	while (1) {
> 	/* Now synchronize with reader */
> 	while(FLAG);
> 	FIRST++;
> 	x86_smb();
> 	SECOND++;
> 	x86_smb();
> 	FLAG = 1;
> 	}
> }
> 
> void* reader_thread(void* arg) {
>      while (1) {
> 	/* Now synchronize with writer */
> 	while(!FLAG);
> 	x86_rmb();
> 	unsigned first = FIRST;
> 	x86_rmb();
> 	unsigned second = SECOND;
> 	assert(first - second == 1 || first - second == 0);
> 	FLAG = 0;
> 
> 	if (!(first %1000000))
> 		printf("%d\n", first);
>     }
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

I tried it on host and VM of NVidia's grace-hopper. Without the barriers, I
can hit assert. With the barriers, it's working fine without hitting the
assert.

I also had some code to mimic virtio vring last weekend, and it's just
working well. Back to our original issue, __smb_wmb() is issued by guest
while __smb_rmb() is executed on host. The VM and host are running at
different exception level: EL2 vs EL1. I'm not sure it's the cause. I
need to modify my code so that __smb_wmb() and __smb_rmb() can be executed
from guest and host.

[gshan@gshan code]$ cat test.h
#ifndef __TEST_H
#define __TEST_H

struct vring_desc {
	uint64_t	addr;
	uint32_t	len;
	uint16_t	flags;
	uint16_t	next;
} __attribute__((aligned(4)));

struct vring_avail {
	uint16_t	flags;
	uint16_t	idx;
	uint16_t	ring[];
} __attribute__((aligned(4)));

struct vring_used_elem {
	uint32_t	id;
	uint32_t	len;
} __attribute__((aligned(4)));

struct vring_used {
	uint16_t 		flags;
         uint16_t 		idx;
         struct vring_used_elem	ring[];
} __attribute__((aligned(4)));

struct vring {
	struct vring_desc	*desc;
	struct vring_avail	*avail;
	struct vring_used	*used;
	uint8_t			pad0[64];

	/* Writer */
	uint32_t		num;
	uint32_t		w_num_free;
	uint32_t		w_free_head;
	uint16_t		w_avail_idx;
	uint16_t		w_last_used_idx;
	uint16_t		*w_extra_data;
	uint16_t		*w_extra_next;
	uint8_t			pad1[64];

	/* Reader */
	uint16_t		r_avail_idx;
	uint16_t		r_last_avail_idx;
	uint16_t		r_last_used_idx;
	uint8_t			pad2[64];
};

static inline unsigned int vring_size(unsigned int num, unsigned long align)
{
	return ((sizeof(struct vring_desc) * num +
		 sizeof(uint16_t) * (3 + num) + (align - 1)) & ~(align - 1)) +
	       sizeof(uint16_t) * 3 + sizeof(struct vring_used_elem) * num;
		
}

static inline void __smp_rmb(void)
{
#ifdef WEAK_BARRIER
	__asm__ volatile("dmb ishld" : : : "memory");
#else
	__asm__ volatile("dsb sy"    : : : "memory");
#endif
}

static inline void __smp_wmb(void)
{
#ifdef WEAK_BARRIER
	__asm__ volatile("dmb ishst" : : : "memory");
#else
	__asm__ volatile("dsb sy"    : : : "memory");
#endif
}

#endif /* __TEST_H */


[gshan@gshan code]$ cat test.c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <stdbool.h>
#include <stdint.h>
#include <sys/types.h>
#include <assert.h>
#include <sched.h>
#include <pthread.h>

#include "test.h"

static struct vring *vring;

static int bind_cpu(int cpuid)
{
	cpu_set_t cpuset;

	CPU_ZERO(&cpuset);
	CPU_SET(cpuid, &cpuset);

	return pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
}

static void write_free_used_desc(void)
{
	uint16_t last_used;
	uint32_t idx;

	if ((uint16_t)(vring->used->idx - vring->w_last_used_idx) < 64)
		return;

	while (true) {
		if (vring->w_last_used_idx == vring->used->idx)
			return;

		__smp_rmb();

		/* Retrieve the head */
		last_used = vring->w_last_used_idx & (vring->num - 1);
		idx = vring->used->ring[last_used].id;
		assert(idx < vring->num);
		assert(vring->w_extra_data[idx]);

		/* Reclaim the descriptor */
		vring->w_extra_data[idx] = 0;
		vring->w_extra_next[idx] = vring->w_free_head;
		vring->w_free_head = idx;

		/* Update statistics */
		vring->w_num_free++;
		vring->w_last_used_idx++;
	}
}

static void write_push_desc(void)
{
	uint32_t head = vring->w_free_head;
	uint32_t avail_idx;

	if (vring->w_num_free < 1)
		return;

	/*
	 * The data in the descriptor doesn't matter. The idea here
	 * is to dirty the cache line.
	 */
	vring->desc[head].flags = 1;
	vring->desc[head].addr  = 0xffffffffffffffff;
	vring->desc[head].len   = 0xffffffff;
	vring->desc[head].next  = vring->w_extra_next[head];
	vring->desc[head].flags = 0;

	vring->w_num_free--;
	vring->w_free_head = vring->w_extra_next[head];
	vring->w_extra_data[head] = 1;

	avail_idx = vring->w_avail_idx & (vring->num - 1);
	vring->avail->ring[avail_idx] = head;

	__smp_wmb();

	vring->w_avail_idx++;
	vring->avail->idx = vring->w_avail_idx;
}

static void *write_worker(void *arg)
{
	assert(!bind_cpu(10));

	while (true) {
		write_free_used_desc();
		write_push_desc();
	}

	return NULL;
}

static void read_pull_desc(void)
{
	uint16_t avail_idx, last_avail_idx;
	uint32_t head;

	last_avail_idx = vring->r_last_avail_idx;
	if (vring->r_avail_idx == vring->r_last_avail_idx) {
		vring->r_avail_idx = vring->avail->idx;
		if (vring->r_avail_idx == last_avail_idx)
			return;

		__smp_rmb();
	}

	head = vring->avail->ring[last_avail_idx & (vring->num - 1)];
	assert(head < vring->num);
	vring->r_last_avail_idx++;

	vring->used->ring[vring->r_last_used_idx & (vring->num - 1)].id  = head;
	vring->used->ring[vring->r_last_used_idx & (vring->num - 1)].len = 0;
	vring->r_last_used_idx++;

	__smp_wmb();

	vring->used->idx = vring->r_last_used_idx;
}

static void *read_worker(void *arg)
{
	assert(!bind_cpu(60));

	while (true) {
		read_pull_desc();
	}

	return NULL;
}

static void init_vring(unsigned int num, unsigned long align)
{
	unsigned int size, i;

	/* vring */
	vring = malloc(sizeof(*vring));
	assert(vring);
	memset(vring, 0, sizeof(*vring));

	/* Descriptors */
	size = vring_size(num, align);
	vring->desc = (struct vring_desc *)malloc(size);
	assert(vring->desc);
	memset(vring->desc, 0, size);
	vring->avail = (struct vring_avail *)((void *)vring->desc +
					      num * sizeof(struct vring_desc));
	vring->used = (struct vring_used *)(((unsigned long)&vring->avail->ring[num] +
					    sizeof(uint16_t) + (align - 1)) & ~(align - 1));

	/* Writer's extra data */
	vring->w_extra_data = malloc(sizeof(uint16_t) * num);
	assert(vring->w_extra_data);
	memset(vring->w_extra_data, 0, sizeof(uint16_t) * num);
	vring->w_extra_next = malloc(sizeof(uint16_t) * num);
	assert(vring->w_extra_next);
	memset(vring->w_extra_next, 0, sizeof(uint16_t) * num);
	for (i = 0; i < num - 1; i++)
		vring->w_extra_next[i] = i + 1;

	/* Statistics */
	vring->num = num;
	vring->w_num_free = num;
	vring->w_free_head = 0;
	vring->w_avail_idx = 0;
	vring->w_last_used_idx = 0;
	vring->r_avail_idx = 0;
	vring->r_last_avail_idx = 0;
	vring->r_last_used_idx = 0;
}

int main(int argc, char **argv)
{
	pthread_t w_tid, r_tid;
	int ret;

	assert(!bind_cpu(0));

	init_vring(256, 64);

	ret = pthread_create(&w_tid, NULL, write_worker, NULL);
	assert(!ret);
	ret = pthread_create(&r_tid, NULL, read_worker, NULL);
	assert(!ret);
	ret = pthread_join(w_tid, NULL);
	assert(!ret);
	ret = pthread_join(r_tid, NULL);
	assert(!ret);

	while (true) {
		sleep(1);
	}

	return 0;
}

Thanks,
Gavin





