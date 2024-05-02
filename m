Return-Path: <linux-kernel+bounces-166671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6D48B9DF3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFA01F222C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9454615B972;
	Thu,  2 May 2024 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dL+nMW+7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD615B969
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665480; cv=none; b=n2qjWUPuDR1QEKBrJiETp5v2q7sgKiGk2M5PrixBm3a19G9QsP4hwknEgBFwXo4pZ26qMK56HkQ+Z8shrbcsTSIMGlEgH5atwzszlvM5uJtB5VaI9AaKbogE9CNu2LaeL4rdwvFLpnZzKZV74apGkzhiPZmiihR6+vWdk672ZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665480; c=relaxed/simple;
	bh=RMF1iDACZjV0hcRbGCfWVq/3XQXFlMSv68uJ+vPjxt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OsafnkEisx2dB3qRfQHuxNv1UnRkModvQPpsAQqLlaRjlllBldWpxRJR5loLpa/MV9426GA01LgeRaEuVF0uwD8sDjbQI5IYzAdJkfOZmAUDmCySh5Nfs665V5h1nYzJ1Mjd4Cs0Z9R0T+TfSpdW7ZQhwIHdjLQFixR4qI6MAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dL+nMW+7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714665478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2QWCAWoe9RfmRGkQtfD5xor166vDzpcOxvA7W0znVI=;
	b=dL+nMW+7qhB7WHpHkdksep4+LiBVjKsVJ5sZfz4vxNOaqHInsR/JNBPeped88OjCU5jAwn
	FsW2ooOWwTmNIyoHX68AIYK0TMSscXakyn/Qa5E3xzRm5H+ol/oefqPdeSa78sDD7IrzQ5
	0i90hprwBu2vgfya6+a405PtywT675o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-mS0GLFexMCWEzCR3g0ADdQ-1; Thu, 02 May 2024 11:57:57 -0400
X-MC-Unique: mS0GLFexMCWEzCR3g0ADdQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-790eaf8fc79so440368685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 08:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714665475; x=1715270275;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2QWCAWoe9RfmRGkQtfD5xor166vDzpcOxvA7W0znVI=;
        b=Mbip5B4WffXTEnLGfe9nW123BYXCNW9kx0nJov3K7k0HyIp+czENpBJm81z6a1mqqU
         s33Lstk6jOIWLyzPwjd6zQOc/KMTwKqzQBvbTPCsFqjo3f7YN37j1ArI+aOkrM/1qVOZ
         2ZG+/zhQ1dnsAz8syk2yllQ2Kb9giEyYCsPlrZ7nY0bmCO1bdV94sgtFMBbE52wEiC2i
         5kpAni5oEGMVZ0kEe6MdQ7NkIXeGr9dI2LZkGkBt7QA9DHKXQ89kRGdLUdp1HBqWl9s8
         2YTsDsQ2UvVSR27gAhdf5T4RDitxoQ0teiU8U3kbCF0ZVIFdemNdcvBzDUrz/wBCuzQy
         BtoA==
X-Forwarded-Encrypted: i=1; AJvYcCVXHpRtTCWeoK5x5G6yULgIqktySl6R3ag1DxizjKuHKRcHMi5r8kYyMUoII48zixWhI74hiJ9Ti+/oQr/nkhucAIMYyY10J6+1Vh8U
X-Gm-Message-State: AOJu0YyRzB5JDG87Qssq1MTJyqjHSrUxxqy2IwHfqBavnGYPiLt5bpP5
	2A54C3L57yTPk9Ba5qx8taiV8NV+HYX1aTyjqCgr0dj59y1iQ9AuNu3AwqoBZJEQrZuADdv7Oql
	VPxFKFPqPVbQpR653nT71ANyu9oBjEyWgnUufIhZB16ig5xL/cQvuMmFvQkXvHMCsNZw6wBf9PU
	q6BRgqGEPn4ZhKFhRbPlku36P6iOGr76QOFTuBhCRqc406gg==
X-Received: by 2002:ad4:4ea7:0:b0:69b:7f0e:bdc with SMTP id ed7-20020ad44ea7000000b0069b7f0e0bdcmr2999618qvb.30.1714665475486;
        Thu, 02 May 2024 08:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG97JAqVOACow1rDFS27Mb+spd1vooExZ6DFMMGuLsIWG1E/USjXHhA0smMG6ip97v2EJA8fQ==
X-Received: by 2002:ad4:4ea7:0:b0:69b:7f0e:bdc with SMTP id ed7-20020ad44ea7000000b0069b7f0e0bdcmr2999522qvb.30.1714665474017;
        Thu, 02 May 2024 08:57:54 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id o14-20020a0cfa8e000000b006a0f63bcea6sm449908qvn.29.2024.05.02.08.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:57:53 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Test online status in available_idle_cpu()
In-Reply-To: <20240429055415.3278672-1-svens@linux.ibm.com>
References: <20240429055415.3278672-1-svens@linux.ibm.com>
Date: Thu, 02 May 2024 17:57:50 +0200
Message-ID: <xhsmhzft86wap.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 29/04/24 07:54, Sven Schnelle wrote:
> The current implementation of available_idle_cpu() doesn't test
> whether a possible cpu is offline. On s390 this dereferences a
> NULL pointer in arch_vcpu_is_preempted() because lowcore is not
> allocated for offline cpus. On x86, tracing also shows calls to
> available_idle_cpu() after a cpu is disabled, but it looks like
> this isn't causing any (obvious) issue. Nevertheless, add a check
> and return early if the cpu isn't online.
>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>


So most of the uses of that function is in wakeup task placement.
o find_idlest_cpu() works on the sched_domain spans, so shouldn't deal with
  offline CPUs.
o select_idle_sibling() may issue an available_idle_cpu(prev) with an
  offline previous, which would trigger your issue.

Currently, even if select_idle_sibling() picks an offline CPU, this will
get corrected by select_fallback_rq() at the end of
select_task_rq(). However, it would make sense to realize @prev isn't a
suitable pick before making it to the fallback machinery, in which case
your patch makes sense beyond just fixing s390.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


