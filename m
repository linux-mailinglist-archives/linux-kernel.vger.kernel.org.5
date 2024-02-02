Return-Path: <linux-kernel+bounces-50244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC44B84763D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73274284857
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8A614AD0D;
	Fri,  2 Feb 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuBxPt9P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110D14A4D9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895343; cv=none; b=saYgGo8d5Gt6ItL3xhAVZc0p8e3HUjaKqF8DrqwYtpuRoiebOdXWMAUJLe+ioa8zlRxzHnoJaWhY9qM2MJiy1XrGzhstFg2dqkr7ExBLFgG7rADonq7vs+XlyGJB2PwRwnFK2mCTF1OouWa6ySgUS76VRyDQrmiauYGlblVlSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895343; c=relaxed/simple;
	bh=mRnjNT6DDned3Q1XytBUwGzL8bLs2iMj3uJu5nqU12c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jiYkldBlOji+qztnIA01l3tz6KIzUneHA2mLbImy0I9tlXVPGO7zBzAMKAuFVxW1D9plvWNZhBDjXl874aXcZ+LlD4FRCjTMmyLcfGuNu1GdGs1f9Nu9GnAO7whWPXpswSIv5vIkpjdpWUYelk49y+9d2LBGWbgEVWb05Un24jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuBxPt9P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706895340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQK3aw5+FTK4GRm25oBJinV55rquq4dzWQOHLOwLXPo=;
	b=OuBxPt9P4Xev03AQQtw9EfjUVMeV1BeqnDEWtNeJ1RSchBv8f3XCTXmg7xoWfQRJ7JTBbT
	y81A1o+HCvAlsfGesa6wpGHHvIBLqpv+QplLAq9SuJ+dWwp7I078fbZMxwx1B769O7bEoz
	3it2Sv2BwxWoMcQ5r0zYjz/7luftyxI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-HZ1V_MKDNzGTBVI32OFdaQ-1; Fri, 02 Feb 2024 12:35:38 -0500
X-MC-Unique: HZ1V_MKDNzGTBVI32OFdaQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40efb04fa1fso11626805e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895337; x=1707500137;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQK3aw5+FTK4GRm25oBJinV55rquq4dzWQOHLOwLXPo=;
        b=EdtQBwAqCj/my1Zd/2fi9Wh1wKGyj63w6z3wasbZP3uwI/caIhGZFiNJ1Lh/gnDArP
         qNHni50SwuGga6x6Anl2lLVWr/lysgJz1D8ABMRNCS8Zk8EeMeVKH6f3rjW9zIb+ODMp
         me/aBUbhe7MhmrIdRahJHB/peebZ5yk0RG85vtYq/gZK1impoYsEqy1LGZAhXw1wUqL+
         PByiFpAWmEyQ25vMrYtZyHJSim8fGWTtNOgBazwALFP6chBuawKBCcKNL0GDOEzoLpJV
         k1s4o2AhGx1tbhu+7BzRiwfaw3naGnIwO8yeeXqfI9t4jJJqtwNpmlMMmK0IG3eB+WH7
         +ArA==
X-Gm-Message-State: AOJu0YxYhxfaSEdGn3aS4STu8px2xLPLyIP0LbHIa53nzNM5h3gU6v29
	/NGZINMAHM1EzSGPxvce2f+rYE2bzuZIRS6jFQUm0rEpMUlCJRK/4Lo8b1RcjcxJZF4FUUbR+K4
	B+InJERY1hZ3C5F8CtHmUIvArURapE0wezDT7paolAFvyhMetm2Hw0unmxEhe7A==
X-Received: by 2002:a05:600c:46ce:b0:40e:7dcf:69ef with SMTP id q14-20020a05600c46ce00b0040e7dcf69efmr1968375wmo.10.1706895337626;
        Fri, 02 Feb 2024 09:35:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5J/UlYK2uDEyNVGBEtytr8hePoxzuB3KX112AAnJpx0M+6CljDX3Sp8GIr+2rK4lN+gqy7A==
X-Received: by 2002:a05:600c:46ce:b0:40e:7dcf:69ef with SMTP id q14-20020a05600c46ce00b0040e7dcf69efmr1968355wmo.10.1706895337311;
        Fri, 02 Feb 2024 09:35:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUN1/TrTGT0fJ1Ku/boW3tTyI7UKwWrqQEXqZp2a9solqxduzI0J1qGU/EbMdFotWXT+m8cS1eHUQDbyhYoFAY1/yQVUz0S/te+LJbAf2yZcmOGy7MgCFmcUPQhIf9TKzOYvYpQCUV34Wg2zd9qAGtdz6aH1SW37RvBDHH6Ey5vg5C3R+uDo9mxT3r7crrwOqUi+MJFicyBC2h7spWMm56Yhkg5ktZyawjhi1iuKIm+WCb2ddEXEeCesuSS9Vqzl2ES5hZDJHmhvcg+ypg3gG7BRr8T2f3uhA+hDABPndR4VOugBKKOe0alO2jrdMGvPRHPMd9S4sxo2UEhGMgE73qx7Jq2uubeofdpcStoTWq9zseHw+QKMkx3TwBgPlZCGIxkP0rElQ==
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b0040fb03f803esm508285wmb.24.2024.02.02.09.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:35:36 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: "Huang, Ying" <ying.huang@intel.com>, Pierre Gondois
 <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Shrikanth Hegde
 <sshegde@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
 Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2 1/3] sched/topology: Annotate RCU pointers properly
In-Reply-To: <8734uy137o.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240115143427.1820628-1-pierre.gondois@arm.com>
 <20240115143427.1820628-2-pierre.gondois@arm.com>
 <8734uy137o.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date: Fri, 02 Feb 2024 18:35:35 +0100
Message-ID: <xhsmhsf2ahiqg.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 16/01/24 09:23, Huang, Ying wrote:
> Pierre Gondois <pierre.gondois@arm.com> writes:
>
>> Cleanup RCU-related spare errors by annotating RCU pointers.
>>
>> sched_domains_numa_distance:
>>   error: incompatible types in comparison expression
>>   (different address spaces):
>>       int [noderef] __rcu *
>>       int *
>>
>> sched_domains_numa_masks:
>>   error: incompatible types in comparison expression
>>   (different address spaces):
>>       struct cpumask **[noderef] __rcu *
>>       struct cpumask ***
>>
>> The cast to (void *) adds the following sparse warning:
>>   warning: cast removes address space '__rcu' of expression
>> but this should be normal.
>>
>> Fixes: 0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>  kernel/sched/topology.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 10d1391e7416..2a2da9b33e31 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1542,8 +1542,8 @@ static int			sched_domains_numa_levels;
>>  static int			sched_domains_curr_level;
>>
>>  int				sched_max_numa_distance;
>> -static int			*sched_domains_numa_distance;
>> -static struct cpumask		***sched_domains_numa_masks;
>> +static int			__rcu *sched_domains_numa_distance;
>> +static struct cpumask		** __rcu *sched_domains_numa_masks;
>>  #endif
>>
>>  /*
>> @@ -1988,8 +1988,8 @@ void sched_init_numa(int offline_node)
>>
>>  static void sched_reset_numa(void)
>>  {
>> -	int nr_levels, *distances;
>> -	struct cpumask ***masks;
>> +	int nr_levels, __rcu *distances;
>> +	struct cpumask ** __rcu *masks;
>
> No.  distances and masks are not accessed via RCU in the function.
> Instead, they should be assigned like below,
>
>          distances = rcu_dereference_raw(sched_domains_numa_distance);
>
> Because sched_domains_numa_distance is protected by cpu_hotplug_lock,
> but the lock is static.  Some comments are deserved.
>
> Anyway, please read RCU document before making the change.
>

IIUC, something like so could also do?

  distances = rcu_dereference_check(sched_domains_numa_distance, lockdep_is_cpus_held());


