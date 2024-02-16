Return-Path: <linux-kernel+bounces-68889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C800F85817E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C287282605
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E217E132C35;
	Fri, 16 Feb 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="QrhIENWD"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B9312FF81;
	Fri, 16 Feb 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097794; cv=none; b=qy/3VXZjQlkQ7b7IXuYZ7p18427+d6shlcXZHrCuqGieWj9mculGURAjTUzET/IwvzVziVwnN6xaoYiADEq/UEaqEiiW1HtO9UkIaIGmSJUBAyFUAfOg2QNWaCv8qWPvbsO3209RmLCwSnkksHcqCxKXV06Jf7C0jzGVNqGdE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097794; c=relaxed/simple;
	bh=9X3M2Hi2BGu4LrBLQAuN+zc5VZRS6uyvkKa9xFV6lnk=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FS/pYTb6N5qEtmvZVMYsH5pC9oaJ68qZPcVnxgVuaMZMYa5GRaErVKa10VUCS9L9mXOJNDGdc7jVjv+5brb0wG4Q6ZHTHrw7RuHbCW7VLrTVahgewPFfyYI0D8aXw3S6L+mlEdkj7XrhguYuBRzOiyJUMcxAv1/9MDgk8qWEMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=QrhIENWD; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1708097791; x=1739633791;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zYEPhdOGwxfalucYYKXEQXA0b+MOVSC9pumogm3wVhQ=;
  b=QrhIENWD4ZDj8t0DHE7YumF4mitFiDf9RNtQ4aHPib1iCDx4l0Q+yjQc
   N+RRh1REJI8gk9ckrbDsOueXPLPlm/4EZnjpspCS6ElXQGnvcLIqvk5W+
   pNXSuH3DshgB6EzWKRqlfq/P9QDxheSWgGzB85SEuLbqpfup8drIv+Ju0
   8=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="66561533"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 15:36:27 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.29.78:36608]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.0.197:2525] with esmtp (Farcaster)
 id 14bd3545-92ef-44f2-844a-9c8f63002956; Fri, 16 Feb 2024 15:36:26 +0000 (UTC)
X-Farcaster-Flow-ID: 14bd3545-92ef-44f2-844a-9c8f63002956
Received: from EX19D008UEC003.ant.amazon.com (10.252.135.194) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:36:06 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEC003.ant.amazon.com (10.252.135.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:36:06 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 16 Feb 2024 15:36:06 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 0583720CE8; Fri, 16 Feb 2024 16:36:06 +0100 (CET)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Alexander Graf <graf@amazon.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
Subject: Re: [PATCH v3 11/17] tracing: Introduce kho serialization
In-Reply-To: <20240117144704.602-12-graf@amazon.com> (Alexander Graf's message
	of "Wed, 17 Jan 2024 14:46:58 +0000")
References: <20240117144704.602-1-graf@amazon.com>
	<20240117144704.602-12-graf@amazon.com>
Date: Fri, 16 Feb 2024 16:36:05 +0100
Message-ID: <mafs0sf1s8lqy.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Wed, Jan 17 2024, Alexander Graf wrote:

> We want to be able to transfer ftrace state from one kernel to the next.
> To start off with, let's establish all the boiler plate to get a write
> hook when KHO wants to serialize and fill out basic data.
>
> Follow-up patches will fill in serialization of ring buffers and events.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
>
> ---
>
> v1 -> v2:
>
>   - Remove ifdefs
> ---
>  kernel/trace/trace.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a0defe156b57..9a0d96975c9c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -32,6 +32,7 @@
>  #include <linux/percpu.h>
>  #include <linux/splice.h>
>  #include <linux/kdebug.h>
> +#include <linux/kexec.h>
>  #include <linux/string.h>
>  #include <linux/mount.h>
>  #include <linux/rwsem.h>
> @@ -866,6 +867,8 @@ static struct tracer		*trace_types __read_mostly;
>   */
>  DEFINE_MUTEX(trace_types_lock);
>
> +static bool trace_in_kho;
> +
>  /*
>   * serialize the access of the ring buffer
>   *
> @@ -10574,12 +10577,56 @@ void __init early_trace_init(void)
>  	init_events();
>  }
>
> +static int trace_kho_notifier(struct notifier_block *self,
> +			      unsigned long cmd,
> +			      void *v)
> +{
> +	const char compatible[] = "ftrace-v1";
> +	void *fdt = v;
> +	int err = 0;
> +
> +	switch (cmd) {
> +	case KEXEC_KHO_ABORT:
> +		if (trace_in_kho)
> +			mutex_unlock(&trace_types_lock);
> +		trace_in_kho = false;
> +		return NOTIFY_DONE;
> +	case KEXEC_KHO_DUMP:
> +		/* Handled below */
> +		break;
> +	default:
> +		return NOTIFY_BAD;
> +	}
> +
> +	if (unlikely(tracing_disabled))
> +		return NOTIFY_DONE;
> +
> +	err |= fdt_begin_node(fdt, "ftrace");
> +	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
> +	err |= fdt_end_node(fdt);
> +
> +	if (!err) {
> +		/* Hold all future allocations */
> +		mutex_lock(&trace_types_lock);

Say I do "echo 1 | tee /sys/kernel/kho/active". Then the lock is held by
tee, which exits. Then I later I do "echo 0 | tee
/sys/kernel/kho/active". This time another tee task unlocks the lock. So
it is not being unlocked by the same task that locked it. The comment
above mutex_lock() definition says:

    The mutex must later on be released by the same task that acquired
    it. Recursive locking is not allowed. The task may not exit without
    first unlocking the mutex.

I tested your code and it happens to work because the unlock always
happened to take the fast path which does not sanity-check the owner.
Still, this is not the correct thing to do.

> +		trace_in_kho = true;
> +	}
> +
> +	return err ? NOTIFY_BAD : NOTIFY_DONE;
> +}
> +
> +static struct notifier_block trace_kho_nb = {
> +	.notifier_call = trace_kho_notifier,
> +};
> +
>  void __init trace_init(void)
>  {
>  	trace_event_init();
>
>  	if (boot_instance_index)
>  		enable_instances();
> +
> +	if (IS_ENABLED(CONFIG_FTRACE_KHO))
> +		register_kho_notifier(&trace_kho_nb);
>  }
>
>  __init static void clear_boot_tracer(void)

--
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




