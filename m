Return-Path: <linux-kernel+bounces-104626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C49387D134
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E35D28356E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390F679C1;
	Fri, 15 Mar 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sexsV4ds"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C335D29B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520360; cv=none; b=ZT7t2h/7obbawdNWrnbqpy52xVD4qAjFm7KZvO26AH8P811544HHaqz4qhq6bF9A8OTwnKE1V81168GPlnN1NHGwAAR009Ivq5C3KQoiQF3IZhIBcAuQNgooTfHdd7YCWzEFWqVZa9XBvw7eXkvec4toNLu5sIcZWCj+HHe3QsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520360; c=relaxed/simple;
	bh=cFBQJA75k/GHkrgjihwXOl85fcNHcFHYEwcptB8NdUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrEoatpmJeAv8QXEvyCxVl6DL0juDYVv0+6U7iarhEgFy2W+ZaGOKw4lSAGUW1yevoA7f+9LQrQrqXXZ7t3yH3GLtYNu3KuyMunnNOuzixrEh5PNtGTpUZH0l5v2LHj+rIg02SU7tLuAPdDqYt+FWEr9dJUUoZ3Hjo2JH8IhZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sexsV4ds; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FFt4G6023912;
	Fri, 15 Mar 2024 16:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=YsVfEyh+PeyjprJYlAXtRWWK3GSAClwznohLSbdhhlw=;
 b=sexsV4dsmR349VqrsOvgkYScTw92nfdylftwFn9FDAlB4jnhiziSvDbS0VNv4jRs5MRo
 vfs98r6uXg6XT+nAMoXGVIoUeGjviXnJG1COuqmU52gMc9KBYJ5Ge6UnPZzsse8oXViW
 hJLg75jlC/pzqFZac5JTTcV/Ax6SHPVGB0iOWOd6hp+A5LjbypA8UceVj6yrWqIJBC53
 I1A6tQ+RMQZaKcrUMoyh/9qXBUkUTA0m+cLiVdsBqDA2YAEsIkQ579wyd9uBwKr/hSEg
 CHG+cty+5yN2KXATaxP6pLLW0Lw6UiOGw4YucFHjiWRKFe01gsv8CH9m2Clj0jrIY4se JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvsd08g06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 16:32:13 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42FGGswF014915;
	Fri, 15 Mar 2024 16:32:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvsd08g02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 16:32:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42FDbpcJ015492;
	Fri, 15 Mar 2024 16:32:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2g0d32e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 16:32:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42FGW7Os25625236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 16:32:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9E9520043;
	Fri, 15 Mar 2024 16:32:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00C5E20040;
	Fri, 15 Mar 2024 16:32:07 +0000 (GMT)
Received: from heavy (unknown [9.179.26.51])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 16:32:06 +0000 (GMT)
Date: Fri, 15 Mar 2024 17:32:05 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Mark Rutland <mark.rutland@arm.com>, Changbin Du <changbin.du@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
Subject: Re: [PATCH] mm: kmsan: fix instrumentation recursion on preempt_count
Message-ID: <lisylv2horoqxszuajysz6gp5nv4pkfhtdehi7wkp3oidao6dj@djh3zzri56dt>
References: <20240311112330.372158-1-changbin.du@huawei.com>
 <Ze7uJUynNXDjLmmn@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze7uJUynNXDjLmmn@FVFF77S0Q05N>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: viS-32uWKrtprKrxz8TdP1dZPeC3-Lyr
X-Proofpoint-ORIG-GUID: oIJbDiMm3TdMoKCHl9gu2j7Eoj6QY3c7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_03,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 mlxlogscore=922
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403150134

On Mon, Mar 11, 2024 at 11:42:29AM +0000, Mark Rutland wrote:
> On Mon, Mar 11, 2024 at 07:23:30PM +0800, Changbin Du wrote:
> > This disables msan check for preempt_count_{add,sub} to fix a
> > instrumentation recursion issue on preempt_count:
> > 
> >   __msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() ->
> > 	preempt_disable() -> __msan_metadata_ptr_for_load_4()
> > 
> > With this fix, I was able to run kmsan kernel with:
> >   o CONFIG_DEBUG_KMEMLEAK=n
> >   o CONFIG_KFENCE=n
> >   o CONFIG_LOCKDEP=n
> > 
> > KMEMLEAK and KFENCE generate too many false positives in unwinding code.
> > LOCKDEP still introduces instrumenting recursions issue. But these are
> > other issues expected to be fixed.
> > 
> > Cc: Marco Elver <elver@google.com>
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  kernel/sched/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9116bcc90346..5b63bb98e60a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5848,7 +5848,7 @@ static inline void preempt_latency_start(int val)
> >  	}
> >  }
> >  
> > -void preempt_count_add(int val)
> > +void __no_kmsan_checks preempt_count_add(int val)
> >  {
> >  #ifdef CONFIG_DEBUG_PREEMPT
> >  	/*
> > @@ -5880,7 +5880,7 @@ static inline void preempt_latency_stop(int val)
> >  		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
> >  }
> 
> What prevents a larger loop via one of the calles of preempt_count_{add,sub}()
> 
> For example, via preempt_latency_{start,stop}() ?
> 
> ... or via some *other* instrumentation that might be placed in those?
> 
> I suspect we should be using noinstr or __always_inline in a bunch of places to
> clean this up properly.
> 
> Mark.

Hi,

I tried the patch with the ftrace testsuite, and this uncovered another
loop, as predicted here:

preempt_count_add():int3
  function_trace_call()
    __msan_metadata_ptr_for_load_8()
      kmsan_get_shadow_origin_ptr()
        kmsan_get_metadata()
          virt_to_page_or_null()
            preempt_count_add()

Best regards,
Ilya

