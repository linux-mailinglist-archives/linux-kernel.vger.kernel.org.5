Return-Path: <linux-kernel+bounces-130850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ADC897DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539271F25ECD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6202F1CD32;
	Thu,  4 Apr 2024 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDt2SS3f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877EDDA3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 03:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712199673; cv=none; b=UQux3Q2OPAvvr5in2gewMWvqjTSgH4/eYodEMvc23w0GvSLICLefQegh8O8GU4xCKv85RF8TGFWIpCeaJlH2j/90HzVOdLzGIY2ATDXmWyWdkoKOPzSsay9SJ81AdMAcdLVkgRuRH2gUh5GbW1wqcgHxqe6PbbIYd/Es4XxvY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712199673; c=relaxed/simple;
	bh=FYxaP8VTxGVIk1hBwFyBnKcpbHquJRXRA9VURtzZ5UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t39ue5NukTAAvFdofG4Yx7W2JHlYKLK7ZGQgR4qrQVR3Ui/8N6BhAQcg4yg2E0dKwVvQdFiwir6Y/O7AlJi/1EOza7P/GDYNfm0Vb3aIsd2DFcg9mUop5US3ePZP/cvDwppUBi5L5MG2MaFLfv/BKOVr05ALsON8Y2+MtHeKEwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDt2SS3f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712199670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqWzVwSDXErXqZAW2hZMSDORWn1QERH5Wj5mwIT/LIM=;
	b=VDt2SS3fL8QxzkYBKMZlNMNE/muMMwjdlJl2Tat5FZaeOiEyyXiPHdVCo+LBPB9T7CuM05
	9e3wLPg1QWbSLdYJRzEknp0hiPTcWMNElZcgMkrTBJyet7x3gKJsup7llcgnBzaGx/eq4Q
	BlKFgF4w9aNYym7E/0cTxwAok6xOk+s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-ZYeFr-TuOu28xJoY64iNWw-1; Wed, 03 Apr 2024 23:01:06 -0400
X-MC-Unique: ZYeFr-TuOu28xJoY64iNWw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CC8F811E81;
	Thu,  4 Apr 2024 03:01:05 +0000 (UTC)
Received: from [10.22.33.218] (unknown [10.22.33.218])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C04F4C041F7;
	Thu,  4 Apr 2024 03:01:03 +0000 (UTC)
Message-ID: <98443f19-c653-493e-a2a9-e1d07b9d8468@redhat.com>
Date: Wed, 3 Apr 2024 23:01:03 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] sched/fair|isolation: Correctly clear
 nohz.[nr_cpus|idle_cpus_mask] for isolated CPUs
Content-Language: en-US
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: Aaron Lu <aaron.lu@intel.com>, Rui Zhang <rui.zhang@intel.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>
References: <20240403150543.2793354-1-pierre.gondois@arm.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240403150543.2793354-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 4/3/24 11:05, Pierre Gondois wrote:
> Zhang Rui reported that find_new_ilb() was iterating over CPUs in
> isolated cgroup partitions. This triggered spurious wakeups for
> theses CPUs. [1]
> The initial approach was to ignore CPUs on NULL sched domains, as
> isolated CPUs have a NULL sched domain. However a CPU:
> - with its tick disabled, so taken into account in
>    nohz.[idle_cpus_mask|nr_cpus]
> - which is placed in an isolated cgroup partition
> will never update nohz.[idle_cpus_mask|nr_cpus] again.
>
> To avoid that, the following variables should be cleared
> when a CPU is placed in an isolated cgroup partition:
> - nohz.idle_cpus_mask
> - nohz.nr_cpus
> - rq->nohz_tick_stopped
> This would allow to avoid considering wrong nohz.* values during
> idle load balance.
>
> As suggested in [2] and to avoid calling nohz_balance_[enter|exit]_idle()
> from a remote CPU and create concurrency issues, leverage the existing
> housekeeping HK_TYPE_SCHED mask to reflect isolated CPUs (i.e. on NULL
> sched domains).
> Indeed the HK_TYPE_SCHED mask is currently never set by the
> isolcpus/nohz_full kernel parameters, so it defaults to cpu_online_mask.
> Plus it's current usage fits CPUs that are isolated and should
> not take part in load balancing.
>
> Making use of HK_TYPE_SCHED for this purpose implies creating a
> housekeeping mask which can be modified at runtime.
>
> [1] https://lore.kernel.org/all/20230804090858.7605-1-rui.zhang@intel.com/
> [2] https://lore.kernel.org/all/CAKfTPtAMd_KNKhXXGk5MEibzzQUX3BFkWgxtEW2o8FFTX99DKw@mail.gmail.com/
>
> Pierre Gondois (7):
>    sched/isolation: Introduce housekeeping_runtime isolation
>    sched/isolation: Move HK_TYPE_SCHED to housekeeping runtime
>    sched/isolation: Use HKR_TYPE_SCHED in find_new_ilb()
>    sched/fair: Move/add on_null_domain()/housekeeping_cpu() checks
>    sched/topology: Remove CPUs with NULL sd from HKR_TYPE_SCHED mask
>    sched/fair: Remove on_null_domain() and redundant checks
>    sched/fair: Clear idle_cpus_mask for CPUs with NULL sd
>
>   include/linux/sched/isolation.h | 30 ++++++++++++++++++++-
>   include/linux/sched/nohz.h      |  2 ++
>   kernel/sched/fair.c             | 44 +++++++++++++++++-------------
>   kernel/sched/isolation.c        | 48 ++++++++++++++++++++++++++++++++-
>   kernel/sched/topology.c         |  7 +++++
>   5 files changed, 110 insertions(+), 21 deletions(-)
>
I had also posted a patch series on excluding isolated CPUs in isolated 
partitions from housekeeping cpumasks earlier this year. See

https://lore.kernel.org/lkml/20240229021414.508972-1-longman@redhat.com/

It took a different approach from this series. It looks like I should 
include HK_TYPE_MISC as well.

Cheers,
Longman


