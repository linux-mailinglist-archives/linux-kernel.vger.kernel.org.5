Return-Path: <linux-kernel+bounces-56553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441484CB9F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796A41C2206C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC0777630;
	Wed,  7 Feb 2024 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4PMeZQ2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A122C76C8F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312885; cv=none; b=lhPb4PvYp+53By7NuzX60+AQLvKkwH1zGJyeyHPLzvAphMwKfmt2rsDf+F/uyzQ4wraZoKlzuWBWO+u3MPx2/Yd3gsteWYtdRVT4vcJzuXd/nNRQSFZJ30wO7Bo3Gh38TVvfdK4jtFE/+lwt9Uqedfjek40fTW94feHaODYXGjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312885; c=relaxed/simple;
	bh=jfdDfyobmnPI3wq5bQDKzQVCXliwCJ+uL6jgW7Mc80A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DCPkOvw+MXeDMTvd/bt8JoLn5qYLoFhLfN3urCMNXmfGTjzfCZMMtLVtGvn+w3NUC4SA3kiUAMU8vyVXSsmbcky/4ZZ70nqx/wbz0GGyGQcT+6caxNXsKO1lptDVrVuDa7kQVc97RwqaYX+C1pYJb+gVjTZhhKSn+SEFlQTBFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4PMeZQ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707312882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jfdDfyobmnPI3wq5bQDKzQVCXliwCJ+uL6jgW7Mc80A=;
	b=S4PMeZQ2INTQlAXQ1WY525SnBsMBy2B0vbKmw4PU80v2FDof5l14K8v7L45ew/+/AiL88o
	U4h9h79sZSEnDUYbkNynL7iqvR3UimHu1nrJ8ppB4O0+yD8ROfyd2aTs8h342ivdaGywAj
	ofeKjeRhT5cg3gLWvao/iCzanJE6Ueg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-XAFcLhDaPwKRbhA6hrEcGQ-1; Wed, 07 Feb 2024 08:34:40 -0500
X-MC-Unique: XAFcLhDaPwKRbhA6hrEcGQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7833761135dso72391685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 05:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707312880; x=1707917680;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfdDfyobmnPI3wq5bQDKzQVCXliwCJ+uL6jgW7Mc80A=;
        b=cleGBF6YB3pc5nt4bDnqvy5/RXbi61fZcsdScMJxwQBITGRJL5gjtbmUpeV+2dy7hA
         9y6R+zXsjT0xdK0hB6G5mlQLIh8AdCgoEHAOr/NsH5WUNFuRHNJ33X4zrwzBoG33jo4V
         B2vKEIuSlxsVrSd+6MWsec+Gc9F19VrvslKG5xjg7j5C6jaxuKDjqEnTI3p42IuxWZzN
         pEtcFyXVQrCJqpDIHXJwyC2gwcXkv88oMLz54xg2KmVKT85P8qWixfJrNDyu2uoJvJpB
         7S0YfiEJSjDw8LuQkaOUsv9+pFvJ5bk0J/M1cce5koXlWGzBSVpuMV/utbJ1POQXlOTn
         z/Zg==
X-Gm-Message-State: AOJu0Yy+8V1ErCne6y6h6gbmUA6rvqMT/PKAR+0KgJkRNs+vTM8cupt4
	QgpQOKAk9z5auCNyr+FPdfVEs5HApW8nV/wJZ5gNtvDwLItZRGFDTyUP9QMb8XIpzglTPLdB5KN
	x/OuPFtqsV7oBht8JOrD2eWdmbE94b9UPeFRA8zrNzwm1GMf26eD0mIpghFTOuQ==
X-Received: by 2002:ac8:7f56:0:b0:42c:123b:1b88 with SMTP id g22-20020ac87f56000000b0042c123b1b88mr6236537qtk.12.1707312880410;
        Wed, 07 Feb 2024 05:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFTQCZxlSugTHKlCSW5VG41meB+m8F94fMZ8CLvQkeN9VnuSSrW/haIkTWK0Qmgv4OUc2r+A==
X-Received: by 2002:ac8:7f56:0:b0:42c:123b:1b88 with SMTP id g22-20020ac87f56000000b0042c123b1b88mr6236521qtk.12.1707312880140;
        Wed, 07 Feb 2024 05:34:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpVlVgywJuMUta5SO8adjEKoihJLq7BUYDSzlAQZV3xMAVhiNazdOf4hqPiDa+U1Pt+BdKrC21Z83KDAsgago/QMZ8v+MIDXjGW263wZDSvbZw+dqdezlFPUH4Qdd/w2w0avLcfufAQ5KI7rxrnIhA2y2bBe72j92iC1JCwm1KZsr7fDnUFB7ZCZKIy+/n0SasUAdr2XD/WZvkmEO9ks4/5n4glO98shQUBF//ap52JGZ0hk3BMZGzvIvbvzONbcuX9JCa/tfUy2WESqO131fhzL9l9pWhBlqkF8RXD0r3L10DPPHe38iGI/j9YyTXnPitKC0Abfx/kOcTKOzwE+WHUl36+uckuyWbXhVLMHVd7G8zMA7lzTBT
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id h7-20020ac85847000000b0042a233d21c2sm515644qth.80.2024.02.07.05.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:34:39 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Benjamin Segall <bsegall@google.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Phil Auld <pauld@redhat.com>, Clark Williams <williams@redhat.com>, Tomas
 Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH v2 0/5] sched/fair: Defer CFS throttle to user entry
In-Reply-To: <xm26cyt92r7t.fsf@google.com>
References: <20240202080920.3337862-1-vschneid@redhat.com>
 <xm26cyt92r7t.fsf@google.com>
Date: Wed, 07 Feb 2024 14:34:35 +0100
Message-ID: <xhsmh7cjggzys.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/02/24 13:55, Benjamin Segall wrote:
> Valentin Schneider <vschneid@redhat.com> writes:
>
>
>> Proposed approach
>> =================
>>
>> Peter mentioned [1] that there have been discussions on changing /when/ the
>> throttling happens: rather than have it be done immediately upon updating
>> the runtime statistics and realizing the cfs_rq has depleted its quota, we wait
>> for the task to be about to return to userspace: if it's in userspace, it can't
>> hold any in-kernel lock.
>>
>> I submitted an initial jab at this [2] and Ben Segall added his own version to
>> the conversation [3]. This series contains Ben's patch plus my additions. The
>> main change here is updating the .h_nr_running counts throughout the cfs_rq
>> hierachies to improve the picture given to load_balance().
>>
>> The main thing that remains doing for this series is making the second cfs_rq
>> tree an actual RB tree (it's just a plain list ATM).
>>
>> This also doesn't touch rq.nr_running yet, I'm not entirely sure whether we want
>> to expose this outside of CFS, but it is another field that's used by load balance.
>
> Then there's also all the load values as well; I don't know the load
> balance code well, but it looks like the main thing would be
> runnable_avg and that it isn't doing anything that would particularly
> care about h_nr_running and runnable_avg being out of sync.
>

Yes, all of the runnable, load and util averages are still going to be an
issue unfortunately. AFAICT tackling this would imply pretty much dequeuing
the throttle_pending user tasks, which was my earlier attempt.

> Maybe pulling a pending-throttle user task and then not seeing the
> update in h_nr_running could be a bit of trouble?

That too is something I hadn't considered. Given the h_nr_running count is
updated accordingly, we could change can_migrate_task() to only allow
kernel tasks to be pulled if the hierarchy is ->throttle_pending. That
would probably require implementing a throttle_pending_count (as you
suggested in the other email) so we don't waste too much time checking up
the hierarchy for every task.


