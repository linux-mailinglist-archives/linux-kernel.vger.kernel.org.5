Return-Path: <linux-kernel+bounces-59584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E28F84F957
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4776FB23092
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A138762C9;
	Fri,  9 Feb 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ai8QzRi/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D9692FC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494950; cv=none; b=YBknHtHnwpWkyfWQD70gA33ZiKzX8oOSOlFg86MC5+975n/dn6bbsEebfdRC2ahp0/i+Ze5vKUf5LWMQYXgo9uXGnNKlDtbtAjMkR5weLV7acTGoxWcSdE0KCJPW86LCcKP/MVzOuOc3pQHbfWWZNVeHfwTgqKVjTDlzYxRfpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494950; c=relaxed/simple;
	bh=IM34ld5UQY9RkQt7bVN6df1EDHk1RikgjaWYreQSvho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2i1Kit6nU/b3xvkJyWh0hWKcpTZgMzB/xoZcUbpdXNCCvNwaRwfi+UqvsO6Y/40Nz/rTTLl4mmFGCxSLskQAjDqFWyuI39OyIt8qeOns5Qn2CSDG1okwG4ecxODneoEwCwep6/bRpuNQde08NdWuLR7eOOmit4DqbA++iVPttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ai8QzRi/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707494947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Du2SfjHBpDjPlfaHFC+gaGPeR3k5e4CR2pmUQgD5lXg=;
	b=ai8QzRi/Lh2MnOXnW1np3gloV23FITqZKe3jLigk4tgrzgAdvKapIc/srwUq/GPPnWn48Z
	dZ9Is1zcKeEdyupjRs3zJaB0t/d79dlZUjOFrt0ypHSeJBeomz0yw85cLBqv2gwWVcTrh3
	DtivZLAXYGkTSD6wCxSMkowPsXHkNak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-yf3VcraqP-mnUSo7svD9jQ-1; Fri, 09 Feb 2024 11:09:04 -0500
X-MC-Unique: yf3VcraqP-mnUSo7svD9jQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B69F7185A785;
	Fri,  9 Feb 2024 16:09:03 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C8FA111FF;
	Fri,  9 Feb 2024 16:09:03 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 8C56A4039CA89; Fri,  9 Feb 2024 12:30:14 -0300 (-03)
Date: Fri, 9 Feb 2024 12:30:14 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 05/12] timekeeping_notify: use stop_machine_fail when
 appropriate
Message-ID: <ZcZFBp2TBSm/RfQi@tpad>
References: <20240206184911.248214633@redhat.com>
 <20240206185709.955049547@redhat.com>
 <87h6ikmqqo.ffs@tglx>
 <ZcN+XM4223HS42LM@tpad>
 <87zfwbkmi9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfwbkmi9.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Thu, Feb 08, 2024 at 04:23:58PM +0100, Thomas Gleixner wrote:
> On Wed, Feb 07 2024 at 09:58, Marcelo Tosatti wrote:
> > On Wed, Feb 07, 2024 at 12:57:19PM +0100, Thomas Gleixner wrote:
> >> On Tue, Feb 06 2024 at 15:49, Marcelo Tosatti wrote:
> >> > Change timekeeping_notify to use stop_machine_fail when appropriate,
> >> > which will fail in case the target CPU is tagged as block interference
> >> > CPU.
> >> 
> >> You completely fail to explain 'appropriate'. There is zero reason for
> >> this churn, really.
> >
> > The churn is so that we can return an error to
> > current_clocksource_store (sysfs handler for writes to
> > /sys/devices/system/clocksource/clocksource0/current_clocksource).
> 
> What for? Why?
> 
> Writing to that file requires root. Root can rightfully screw up a
> system and adding a debugfs based "prevention" mechanism is not making
> this any better because root can just clear the CPU mask there and move
> on.
> 
> So what is the actual real world problem solved by these patches?
> 
> All I've seen so far is handwaving about interference prevention and TBH
> I can't squint hard enough to believe that.
> 
> Thanks,
> 
>         tglx


Thomas,

The problem is an administrator is not aware of the relationship between

Kernel interface        ->      generation of IPIs.


Even less so of which applications in the system are accessing
which kernel interfaces.

Let me give some examples:

1) Change of trip temperatures from userspace.

static int
sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
{
        struct zone_device *zonedev = thermal_zone_device_priv(tzd);
        u32 l, h, mask, shift, intr;
        int tj_max, val, ret;

        tj_max = intel_tcc_get_tjmax(zonedev->cpu);
        if (tj_max < 0)
                return tj_max;
        tj_max *= 1000;

        val = (tj_max - temp)/1000;

        if (trip >= MAX_NUMBER_OF_TRIPS || val < 0 || val > 0x7f)
                return -EINVAL;

        ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
                           &l, &h);
        if (ret < 0)
                return ret;

        if (trip) {
                mask = THERM_MASK_THRESHOLD1;
                shift = THERM_SHIFT_THRESHOLD1;
                intr = THERM_INT_THRESHOLD1_ENABLE;
        } else {
                mask = THERM_MASK_THRESHOLD0;
                shift = THERM_SHIFT_THRESHOLD0;
                intr = THERM_INT_THRESHOLD0_ENABLE;
        }
        l &= ~mask;
        /*
        * When users space sets a trip temperature == 0, which is indication
        * that, it is no longer interested in receiving notifications.
        */
        if (!temp) {
                l &= ~intr;
        } else {
                l |= val << shift;
                l |= intr;
        }

        return wrmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
                        l, h);
}

It seems plausible that userspace application decides to change trip temperature.

2) Read of per-CPU registers (from sysfs).

arch/arm64/kernel/topology.c

static inline
int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
{
        /*
         * Abort call on counterless CPU or when interrupts are
         * disabled - can lead to deadlock in smp sync call.
         */
        if (!cpu_has_amu_feat(cpu))
                return -EOPNOTSUPP;

        if (WARN_ON_ONCE(irqs_disabled()))
                return -EPERM;

        smp_call_function_single(cpu, func, val, 1);

        return 0;
}

sysfs read -> cppc_get_perf_caps -> cpc_read -> cpc_read_ffh -> counters_read_on_cpu 

#define define_one_cppc_ro(_name)               \
static struct kobj_attribute _name =            \
__ATTR(_name, 0444, show_##_name, NULL)

This one does not even require root.

Other interfaces on the same class:

show_pw20_wait_time (PowerPC)
uncore_read_freq (x86)
..

So while I understand your point that root can (and should be) 
able to perform any operations on the system, this interface would 
be along the lines of:

"I don't want isolated CPUs to be interrupted, but i am not aware of
which kernel interfaces can result in interruptions to isolated CPUs.

Lets indicate through this cpumask, which the kernel can consult, 
that we'd like userspace operations to fail, if they were going
to interrupt an isolated CPU".

Its the kernel that knows which operations might interrupt 
isolated CPUs, not userspace.

Also https://www.spinics.net/lists/kernel/msg5094328.html. 


