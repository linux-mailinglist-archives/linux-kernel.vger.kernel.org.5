Return-Path: <linux-kernel+bounces-56554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2C284CBA1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A711F23C97
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199AB77628;
	Wed,  7 Feb 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkhTBZeN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20B76C99
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312894; cv=none; b=JIp98atJcKIpuleYIrK9/bWD4a1S4Od1KohVXe6x3H+lvuAyG8XyG6LIiV/aa4QpZWYTTH2Vah/olRy4n2CSdUkGzQzd/677N0/1/ciZfExcjl1bSmsdeJHcDqyRV90Y2QssiA9qNagfpd7NQVf3jBH+t11XeDgCa3UL3LtW2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312894; c=relaxed/simple;
	bh=5SdBr3MNXKJadaK9usfVXbcaJr4lVwkiPljHb9tT+QY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FLpOicjUh6g5kwe31U3uz7k5qMiO8V7pmk8TDZJPaQIGL6+j/MgkID8fhJ1GAbjYbC/1TEQUWobP4rt8hPFuniBet/xLWdk738YuJcf2D1/lWxb8WWNuqT0748ECR8FH+/w8z+YnO677+SxMd5WB3Pb9hiLSPWP/h26QKDf378E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkhTBZeN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707312891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0YdmZXmeO8yx8Ipl0wAtpFtdSadCIJ86dpTSm8XJIzQ=;
	b=NkhTBZeNpOAwThksJ62JKFVw9kt2JfyXnxdbS5/9nCff9e2qog8jBgm592ocsOUL6+6r4+
	BZbRFsvf7GbYWibmV+KugqPmmOCbpCALNFVhaKEq0k4mWvTDhyL+Ol7Ko161BKertETdG7
	maWLT5C9un9FDlauOwCfiVn4RxXWo38=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Epm15_IEM7aECw2nEPFQBw-1; Wed, 07 Feb 2024 08:34:50 -0500
X-MC-Unique: Epm15_IEM7aECw2nEPFQBw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7853d5e398dso75234185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 05:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707312889; x=1707917689;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YdmZXmeO8yx8Ipl0wAtpFtdSadCIJ86dpTSm8XJIzQ=;
        b=jgTkomKBK02nU+zIA0lBlQqhmjijCea6vJ9jQdYfsGKrIukQn19Wj+9N/fxaX3y+Cy
         ZRM/RXMoDIfcvqM/8U6/E4sJyLb3D/iAg+kg3UPB/A1kuZJOnfU6v9pRvz4kSV/+UqhM
         tFqrVuuzFxjJMMbu+kDmGXxGBFnjvfUgTGtMzLd/I0UdnrWHWBG3S8Re23a364a3UF4D
         aBkr1bK3lI1S5zLTpFRhd/u3QXdJZXgygOmIy9Zmh/CRY7CUao3ITBShdJ8LDCBg1hp4
         IAmlq1HfNjBFSUbOwNq7bz80LRCGVOywvTOFibVnzH/AG48x4Waxsa8QfluIH0X1sk/e
         xLiw==
X-Gm-Message-State: AOJu0YwynNDJoqaDi2WH0bwGQ3dTjQwZtohm8m4KJzUXU/xRDJKz2mdg
	k8mChyTuHM2xiwWY2+Me/ccMqvGAmVwoAGAPFhh556lTFJZk2nY3VD0647Xl/cQmdmSNqTb/kAZ
	qJ1dsXPAVzs4DhDKtrU0QXWuN6bO7YBgEFdit2e1ZUAAcUyl69g6CF79BTcfztQ==
X-Received: by 2002:a05:620a:a4c:b0:785:62c3:9f5b with SMTP id j12-20020a05620a0a4c00b0078562c39f5bmr5328927qka.22.1707312889717;
        Wed, 07 Feb 2024 05:34:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaKo1FowKHgdnmHika+3LHNUCxVfXb2RCnn8wOKC5rbLIG54z/3ptxrfecYSrNBHSW8V0//A==
X-Received: by 2002:a05:620a:a4c:b0:785:62c3:9f5b with SMTP id j12-20020a05620a0a4c00b0078562c39f5bmr5328918qka.22.1707312889503;
        Wed, 07 Feb 2024 05:34:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOqp/kTjmU86+Fm7T9rUs883WBBxqDKx9EfbiEtqe8z/hxwunMZKQjjfZMWF0I9w3ar6/zD1J3BWzFYnABMPhHIlHZZnm6fW0TorFQIz3pBlEDN4lbmf7nzLCw3LgIyjhDw1YgXEG+zWUzJqvKdHITxbdM0GTWrYFSg71JNcr89bDt7bbDv0866rv10EzGCtwd/ehRGzJfLI5/x4KF4bpZDBro2OFZS5o38QYPXyYDj0hGe0KAalNb04BzkVRdUgRnHdvBq4vQJG3qRTMraFA3WXiUKCCXRFCYDrt4ajXYj9rwROED+L0qXobhFELrdI0i8UPYi6uFEwjX+w3jxYcjoNC8DU7ZygHC3sROPt5w85pZliCGDeeG
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a095b00b00783f70bc497sm513030qkw.115.2024.02.07.05.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:34:49 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Benjamin Segall <bsegall@google.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Phil Auld <pauld@redhat.com>, Clark Williams <williams@redhat.com>, Tomas
 Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH v2 3/5] sched/fair: Delete cfs_rq_throttled_loose(),
 use cfs_rq->throttle_pending instead
In-Reply-To: <xm26jznh2s25.fsf@google.com>
References: <20240202080920.3337862-1-vschneid@redhat.com>
 <20240202080920.3337862-4-vschneid@redhat.com>
 <xm26jznh2s25.fsf@google.com>
Date: Wed, 07 Feb 2024 14:34:45 +0100
Message-ID: <xhsmh5xz0gzyi.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/02/24 13:36, Benjamin Segall wrote:
> Valentin Schneider <vschneid@redhat.com> writes:
>
>> cfs_rq_throttled_loose() does not check if there is runtime remaining in
>> the cfs_b, and thus relies on check_cfs_rq_runtime() being ran previously
>> for that to be checked.
>>
>> Cache the throttle attempt in throttle_cfs_rq and reuse that where
>> needed.
>
> The general idea of throttle_pending rather than constantly checking
> runtime_remaining seems reasonable...
>
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  kernel/sched/fair.c | 44 ++++++++++----------------------------------
>>  1 file changed, 10 insertions(+), 34 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 96504be6ee14a..60778afbff207 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5462,7 +5462,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>   * 5) do not run the "skip" process, if something else is available
>>   */
>>  static struct sched_entity *
>> -pick_next_entity(struct cfs_rq *cfs_rq, bool throttled)
>> +pick_next_entity(struct cfs_rq *cfs_rq)
>>  {
>>  #ifdef CONFIG_CFS_BANDWIDTH
>>      /*
>> @@ -5473,7 +5473,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, bool throttled)
>>       * throttle_cfs_rq.
>>       */
>>      WARN_ON_ONCE(list_empty(&cfs_rq->kernel_children));
>> -	if (throttled && !list_empty(&cfs_rq->kernel_children)) {
>> +	if (cfs_rq->throttle_pending && !list_empty(&cfs_rq->kernel_children)) {
>
> ... but we still need to know here if any of our parents are throttled
> as well, ie a "throttled_pending_count", or to keep the "throttled"
> parameter tracking in pnt_fair. (ie just replace the implementation of
> cfs_rq_throttled_loose).
>

Hm, good point. We should be good with reinstoring the throttled parameter
and feeding it a ->throttle_pending accumulator.

>>              /*
>>               * TODO: you'd want to factor out pick_eevdf to just take
>>               * tasks_timeline, and replace this list with a second rbtree
>> @@ -5791,8 +5791,12 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>>       * We don't actually throttle, though account() will have made sure to
>>       * resched us so that we pick into a kernel task.
>>       */
>> -	if (cfs_rq->h_kernel_running)
>> +	if (cfs_rq->h_kernel_running) {
>> +		cfs_rq->throttle_pending = true;
>>              return false;
>> +	}
>> +
>> +	cfs_rq->throttle_pending = false;
>
> We also need to clear throttle_pending if quota refills and our
> runtime_remaining goes positive. (And do the appropriate h_* accounting in
> patch 4/5)

Right, so we could move the throttle_pending logic to after
__assign_cfs_rq_runtime(), and then modify distribute_cfs_runtime() to
catch the !throttled but throttle_pending case.


