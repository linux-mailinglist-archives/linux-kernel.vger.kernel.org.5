Return-Path: <linux-kernel+bounces-56529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F089884CB42
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD041F22EB4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160777621;
	Wed,  7 Feb 2024 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1nxFYqG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E87604B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311554; cv=none; b=clXYPFRrPMJNHjbuZ4J4T6Fm9x6tPBYQ47BQi7+Y6V1aKZO1ts44rXxm4HxZtmlMApLtC5+XmIUQFD39yc482dFetujxr8vysEHYmSbuVKOix/bed5h0Ug0p1cf91r6BRaRVHidEtXonfyqRWMWbOp65K6r87eED+IXTF8OlFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311554; c=relaxed/simple;
	bh=eHfaLB0w9StkMcmAmJyt0WL3X4LB5H4bpV1qlxJJDNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+EnA0Jx0qo36MyG2udW67XlG1WFtJT4Qm7zgi+MUsf4uHnkfgnPoXqeBomvojlLRj3l703xSoXUJKeeoOo+yP7OtxqISFXlBq3gVeKuM7fhShYoe1ulazRUgp9HQpO88KaUYpq9wsNZedqauFxr4y8k9aH5rJCQv6ck6VHkUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1nxFYqG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707311548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxHbYgF40mvXhoLp/NUG6zCoxS7zVB+OFLNTVEsXK0E=;
	b=b1nxFYqGi+zLp6nFpFt9mx0Rh2Z2AK0ZpsAhcfgpVRilZnRFRGjU9B2+qCU4wTyr9GoTGr
	jBfnx00XuUWXYpfJ0pwrII7hVhAtFVkOf0OKQnVh9wYqpUCLT2NF3VNX+Sl9utBtQRgJ2+
	sk8nmO4sUhbaIJBiWbc6YO/cFCGGKm8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-zztZeUjeOFqBlf5fejcSCw-1; Wed,
 07 Feb 2024 08:12:24 -0500
X-MC-Unique: zztZeUjeOFqBlf5fejcSCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68AD13816B45;
	Wed,  7 Feb 2024 13:12:24 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DB131C066AA;
	Wed,  7 Feb 2024 13:12:24 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id C40704023C99F; Wed,  7 Feb 2024 09:51:24 -0300 (-03)
Date: Wed, 7 Feb 2024 09:51:24 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 04/12] clockevent unbind: use smp_call_func_single_fail
Message-ID: <ZcN8zA4WaLx7c3qy@tpad>
References: <20240206184911.248214633@redhat.com>
 <20240206185709.928420669@redhat.com>
 <87jzngmqsw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzngmqsw.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Wed, Feb 07, 2024 at 12:55:59PM +0100, Thomas Gleixner wrote:
> On Tue, Feb 06 2024 at 15:49, Marcelo Tosatti wrote:
> > Convert clockevents_unbind from smp_call_function_single
> > to smp_call_func_single_fail, which will fail in case
> > the target CPU is tagged as block interference CPU.
> 
> Seriously? This is a root only operation. So if root wants to interfere
> then so be it.

Hi Thomas!

OK, so the problem is the following: due to software complexity, one is
often not aware of all operations that might take place.

For example:

https://lore.kernel.org/lkml/Y6mXDUZkII5OnuE8@tpad/T/

[PATCH] hwmon: coretemp: avoid RDMSR interruptions to isolated CPUs

The coretemp driver uses rdmsr_on_cpu calls to read
MSR_IA32_PACKAGE_THERM_STATUS/MSR_IA32_THERM_STATUS registers,
which contain information about current core temperature.

For certain low latency applications, the RDMSR interruption exceeds    
the applications requirements.

So disable reading of crit_alarm and temp files via /sys, in case
CPU isolation is enabled.

Temperature information from the housekeeping cores should be
sufficient to infer die temperature.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 9bee4d33fbdf..30a35f4130d5 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -27,6 +27,7 @@
 #include <asm/msr.h>
 #include <asm/processor.h>
 #include <asm/cpu_device_id.h>
+#include <linux/sched/isolation.h>
 
 #define DRVNAME	"coretemp"
 
@@ -121,6 +122,10 @@ static ssize_t show_crit_alarm(struct device *dev,
 	struct platform_data *pdata = dev_get_drvdata(dev);
 	struct temp_data *tdata = pdata->core_data[attr->index];
 
+
+	if (!housekeeping_cpu(tdata->cpu, HK_TYPE_MISC))
+		return -EINVAL;
+
 	mutex_lock(&tdata->update_lock);
 	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
 	mutex_unlock(&tdata->update_lock);
@@ -158,6 +163,8 @@ static ssize_t show_temp(struct device *dev,
 
 	/* Check whether the time interval has elapsed */
 	if (!tdata->valid || time_after(jiffies, tdata->last_updated + HZ)) {
+		if (!housekeeping_cpu(tdata->cpu, HK_TYPE_MISC))
+			return -EINVAL;
 		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
 		/*
 		 * Ignore the valid bit. In all observed cases the register


In this case, a userspace application (collecting telemetry data), was
responsible for reading the sysfs files.

Now think of all possible paths, from userspace, that lead to kernel
code that ends up in smp_call_function_* variants (or other functions
that cause IPIs to isolated CPUs).

The alternative, from blocking this in the kernel, would be to validate all 
userspace software involved in your application, to ensure it won't end
up in the kernel sending IPIs. Which is impractical, isnt it ?
(or rather, with such option in the kernel, it would be possible to run 
applications which have not been validated, since the kernel would fail
the operation that results in IPI to isolated CPU).

So the idea would be an additional "isolation mode", which when enabled, 
would disallow the IPIs. Its still possible for root user to disable
this mode, and retry the operation.

So lets say i want to read MSRs on a given CPU, as root.

You'd have to: 

1) readmsr on given CPU (returns -EPERM or whatever), since the
"block interference" mode is enabled for that CPU.

2) Disable that CPU in the block interference cpumask.

3) readmsr on the given CPU (success).

4) Re-enable CPU in block interference cpumask, if desired.


(BTW, better ideas than the cpumask are welcome, but it seems the
realibility aspect of something similar to this is necessary).

Thanks!


