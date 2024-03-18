Return-Path: <linux-kernel+bounces-105785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E787E456
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BCB1C20880
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3002374C;
	Mon, 18 Mar 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QL+r+2jB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164023767
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748254; cv=none; b=Rl1HSVGP1qmoXr2lDs1phccQXfo7BQlG5joysNPVWxy7FDg6DKl0oqJOxy9ZNaXoBAPslMAgnV8FhSe/EOOfxkYr9qaxoyKghuGUHbOQhglPy6s3/HtrYwmWqaxAUX6+vRrECfz3919ZP5wyjUqBteYqAEa+fhaDAXn+hdah6+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748254; c=relaxed/simple;
	bh=bElOvLFlA2lRQnpxtaLmrESGqRhuJI/dzvLGPlMWjgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGiRakUKSeRqZxxuNPek4Pa8u9Yft8mEyR7mqMwQxBRuH1GUBS1tCaearm2lfv935J1Jll5we5syfovPLrpNKWf9tDwq9nUp6I+DAheAkbI5OADL70RvX84BPZhEjmm9+Zh0n0YxU+VOLoEBctu5zrxeV4siK3imYI1VJ8cjgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QL+r+2jB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710748252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M61ri+LtQ+sPozYEZ1McUz+TEhyS+suTMSA9oAYcUks=;
	b=QL+r+2jBe54wa4DN4tveEduKoeU8j3NTq/KfEmHjlWSHMUF4KeUzL+4bpUiq3qmjrvRTdz
	KrO9suZgXjM/mS45HFrSm5sDfqyYVv2jKP5U4/u3dgRowpLPTjzkzo1nbQ89QVrzc4WkNw
	O58o/ylrcAJ6/FLQpnBBwNAmqgp6ts8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-08Qzfc7gOca6gQx85vEFOg-1; Mon, 18 Mar 2024 03:50:50 -0400
X-MC-Unique: 08Qzfc7gOca6gQx85vEFOg-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6e0ee5097feso4652188a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710748250; x=1711353050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M61ri+LtQ+sPozYEZ1McUz+TEhyS+suTMSA9oAYcUks=;
        b=un/wRqcUsiZgaLOXO2Mfz4ZeypkP9nBAuKNJa3feIAqCJKN4ehyz5oBbtU6LYUMETn
         1L+Pzp0ud+WiW/hPL+p2tc7RhANI6ygnURDTXVyf2LtEaZvreufDuoyRjykZFNQxlwdN
         NUTOTApCjfqUGX+Z+icCWEcffuLUygPqn9KT1HzVZGh6EtoJ4eliBUnimhc18A5lpWvu
         IvZ8ut8Ru43XaL1MofDjntqvTydJDjT1apnl+AJqXqFay/OzlYyNOL600KqNm2C98zjI
         u7uBVQ2BMLsloRRCR4MqYD2O+/gY7uJXDLmHUm4g+uQ1b4va2bJw6kuE51JiK/BFfBrO
         5Upw==
X-Forwarded-Encrypted: i=1; AJvYcCUN/GqJkfwSmQ877o1L+Epri/NCBT0sxUNzjSBlhLITWmlXJj3DSfMEfFEPO0Ds9JcWCxqxW80kcQEE0x9brCOVBo5Wai2R4jZI29d8
X-Gm-Message-State: AOJu0YyRu1MLoQmnABeTLsLl+06Vu/rnJSTYEQ9Er+vq4cxE8LuOIynU
	PG0+G1GicmmUmgGIbJ586ieYQIdtVBZNlKTagApKXRZEXsIggclrI9OV8J0Qhu4swWNMf8C55MU
	xxOQkJFVC1DaqE0hpR0Q/hLA7htV6A+RI51SuaUyRX1Jma2Lxg0BZGEHQ/JbrSg==
X-Received: by 2002:a9d:6e8e:0:b0:6e4:9456:6b04 with SMTP id a14-20020a9d6e8e000000b006e494566b04mr12857360otr.5.1710748249611;
        Mon, 18 Mar 2024 00:50:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE083dlEzBLt+Sky3z69bRCGJ12X1u/z5aEMtKwBNnHV8LauRWAFwR09RP3WUCW/rBcAqaHMg==
X-Received: by 2002:a9d:6e8e:0:b0:6e4:9456:6b04 with SMTP id a14-20020a9d6e8e000000b006e494566b04mr12857341otr.5.1710748249106;
        Mon, 18 Mar 2024 00:50:49 -0700 (PDT)
Received: from redhat.com ([2.52.5.113])
        by smtp.gmail.com with ESMTPSA id g9-20020a056830084900b006e682c00e59sm843274ott.57.2024.03.18.00.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 00:50:48 -0700 (PDT)
Date: Mon, 18 Mar 2024 03:50:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240318034710-mutt-send-email-mst@kernel.org>
References: <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
 <20240314074216-mutt-send-email-mst@kernel.org>
 <23dc6d00-6a57-4ddf-8611-f3c6f6a8e43c@redhat.com>
 <20240314085630-mutt-send-email-mst@kernel.org>
 <63002c24-8117-458f-84c7-fa4f7acd8cc6@redhat.com>
 <20240315065318-mutt-send-email-mst@kernel.org>
 <66e12633-b2d6-4b9a-9103-bb79770fcafa@redhat.com>
 <20240317124214-mutt-send-email-mst@kernel.org>
 <589d980f-2e4d-47b4-9dc7-8c64dbe271ce@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <589d980f-2e4d-47b4-9dc7-8c64dbe271ce@redhat.com>

On Mon, Mar 18, 2024 at 09:41:45AM +1000, Gavin Shan wrote:
> On 3/18/24 02:50, Michael S. Tsirkin wrote:
> > On Fri, Mar 15, 2024 at 09:24:36PM +1000, Gavin Shan wrote:
> > > 
> > > On 3/15/24 21:05, Michael S. Tsirkin wrote:
> > > > On Fri, Mar 15, 2024 at 08:45:10PM +1000, Gavin Shan wrote:
> > > > > > > Yes, I guess smp_wmb() ('dmb') is buggy on NVidia's grace-hopper platform. I tried
> > > > > to reproduce it with my own driver where one thread writes to the shared buffer
> > > > > and another thread reads from the buffer. I don't hit the out-of-order issue so
> > > > > far.
> > > > 
> > > > Make sure the 2 areas you are accessing are in different cache lines.
> > > > 
> > > 
> > > Yes, I already put those 2 areas to separate cache lines.
> > > 
> > > > 
> > > > > My driver may be not correct somewhere and I will update if I can reproduce
> > > > > the issue with my driver in the future.
> > > > 
> > > > Then maybe your change is just making virtio slower and masks the bug
> > > > that is actually elsewhere?
> > > > 
> > > > You don't really need a driver. Here's a simple test: without barriers
> > > > assertion will fail. With barriers it will not.
> > > > (Warning: didn't bother testing too much, could be buggy.
> > > > 
> > > > ---
> > > > 
> > > > #include <pthread.h>
> > > > #include <stdio.h>
> > > > #include <stdlib.h>
> > > > #include <assert.h>
> > > > 
> > > > #define FIRST values[0]
> > > > #define SECOND values[64]
> > > > 
> > > > volatile int values[100] = {};
> > > > 
> > > > void* writer_thread(void* arg) {
> > > > 	while (1) {
> > > > 	FIRST++;
> > > > 	// NEED smp_wmb here
> > >          __asm__ volatile("dmb ishst" : : : "memory");
> > > > 	SECOND++;
> > > > 	}
> > > > }
> > > > 
> > > > void* reader_thread(void* arg) {
> > > >       while (1) {
> > > > 	int first = FIRST;
> > > > 	// NEED smp_rmb here
> > >          __asm__ volatile("dmb ishld" : : : "memory");
> > > > 	int second = SECOND;
> > > > 	assert(first - second == 1 || first - second == 0);
> > > >       }
> > > > }
> > > > 
> > > > int main() {
> > > >       pthread_t writer, reader;
> > > > 
> > > >       pthread_create(&writer, NULL, writer_thread, NULL);
> > > >       pthread_create(&reader, NULL, reader_thread, NULL);
> > > > 
> > > >       pthread_join(writer, NULL);
> > > >       pthread_join(reader, NULL);
> > > > 
> > > >       return 0;
> > > > }
> > > > 
> > > 
> > > Had a quick test on NVidia's grace-hopper and Ampere's CPUs. I hit
> > > the assert on both of them. After replacing 'dmb' with 'dsb', I can
> > > hit assert on both of them too. I need to look at the code closely.
> > > 
> > > [root@virt-mtcollins-02 test]# ./a
> > > a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
> > > Aborted (core dumped)
> > > 
> > > [root@nvidia-grace-hopper-05 test]# ./a
> > > a: a.c:26: reader_thread: Assertion `first - second == 1 || first - second == 0' failed.
> > > Aborted (core dumped)
> > > 
> > > Thanks,
> > > Gavin
> > 
> > 
> > Actually this test is broken. No need for ordering it's a simple race.
> > The following works on x86 though (x86 does not need barriers
> > though).
> > 
> > 
> > #include <pthread.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <assert.h>
> > 
> > #if 0
> > #define x86_rmb()  asm volatile("lfence":::"memory")
> > #define x86_mb()  asm volatile("mfence":::"memory")
> > #define x86_smb()  asm volatile("sfence":::"memory")
> > #else
> > #define x86_rmb()  asm volatile("":::"memory")
> > #define x86_mb()  asm volatile("":::"memory")
> > #define x86_smb()  asm volatile("":::"memory")
> > #endif
> > 
> > #define FIRST values[0]
> > #define SECOND values[640]
> > #define FLAG values[1280]
> > 
> > volatile unsigned values[2000] = {};
> > 
> > void* writer_thread(void* arg) {
> > 	while (1) {
> > 	/* Now synchronize with reader */
> > 	while(FLAG);
> > 	FIRST++;
> > 	x86_smb();
> > 	SECOND++;
> > 	x86_smb();
> > 	FLAG = 1;
> > 	}
> > }
> > 
> > void* reader_thread(void* arg) {
> >      while (1) {
> > 	/* Now synchronize with writer */
> > 	while(!FLAG);
> > 	x86_rmb();
> > 	unsigned first = FIRST;
> > 	x86_rmb();
> > 	unsigned second = SECOND;
> > 	assert(first - second == 1 || first - second == 0);
> > 	FLAG = 0;
> > 
> > 	if (!(first %1000000))
> > 		printf("%d\n", first);
> >     }
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
> I tried it on host and VM of NVidia's grace-hopper. Without the barriers, I
> can hit assert. With the barriers, it's working fine without hitting the
> assert.
> 
> I also had some code to mimic virtio vring last weekend, and it's just
> working well. Back to our original issue, __smb_wmb() is issued by guest
> while __smb_rmb() is executed on host. The VM and host are running at
> different exception level: EL2 vs EL1. I'm not sure it's the cause. I
> need to modify my code so that __smb_wmb() and __smb_rmb() can be executed
> from guest and host.

It is thinkably possible that on grace-hopper barriers work
differently somehow. We need to find out more though.
Anyone from Nvidia can chime in?

-- 
MST


