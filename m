Return-Path: <linux-kernel+bounces-123031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2240389013E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B00E29763E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337FA8002E;
	Thu, 28 Mar 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1f9QYDp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B98172F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634898; cv=none; b=Z3zTv2GR7DFWjvN8odNB4DBmCRiciD6fb97VdQ/XbgvZFhueuPEfw6dKMaGjy4+uu6+JfJ1D9/ikRsrM/ld+9iv8K7iXfR8P/upWVRIvo2Cvvtl4mHM2m1K1ubPVqPHbXDSFLBKlw+6/LvcIjUKWDlZOP2XM3htSZ23CNshftfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634898; c=relaxed/simple;
	bh=elSPJdpeP0L54k/M93Wq7ddKM8Kt3ItDSSLp8XZWfNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UBhP6Ol47YfKB6kxlTL9xI+KvJ1+WoasK8XUYdmrlW0ShBsdlgiyK2YHvB+ujy2ExiYb4rJA1Fs0m9yeeY7giBI3fvw76G6vapZd7f7x68D04Jmlze6gvn+zTVmh00KSaThusnRDjfI1GaXI0mhUEvs9xtDRDimr4t4GkPKDUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1f9QYDp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711634895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwwZhwkkxx/X57hMDSUsv9/pbe8bflwfF1YkdMboXWM=;
	b=K1f9QYDpVC9zTI0BgSM/xbAIfJ1jGY7RxWLJPDzonn6MclAQhIHDPNJUpWwuu8gtL1VZ1H
	cj+8VN4fHBR9OTBL8+ikcSuYv9WF92d7qjxCwOcgRIT0qKr2dY2AcSZfVk2qj/f4pEtJDs
	A4Ip2+IObXTEXjzQxzN9t1nN3LWebkk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-10Oi3zS0MluFEqm-p78omw-1; Thu, 28 Mar 2024 10:08:13 -0400
X-MC-Unique: 10Oi3zS0MluFEqm-p78omw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6986eb55527so6590106d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634893; x=1712239693;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwwZhwkkxx/X57hMDSUsv9/pbe8bflwfF1YkdMboXWM=;
        b=qRTkE1pDmUmuiGx33ids+tphT7MkgVttL87+NnwWnSVROLAT3U/3mDrje94p0hdoSn
         trmfFDRFCgF/sy7l4pqZDUtmKGVZD+LRlv7v3FkixkKArzf4qKmJa62c6OO8BeBXD1/G
         T78LFz+fo+sFqPIhGT80RT46o5dVWYnYScK1i2OdGXBUiDYizE4tR+et3o3gXUjUyHHX
         9YWypic9Xn9rBJvcaZGjSNRU0JVD3IWrC0tqF9Y5dShpzaLECkHbRrKKziT+yAh1NzGJ
         0JsL8IeRqL9bxK9PlpYfNcm5CKKer+7ooN1jv8hNvvfhK3Fwo+o6t+BXB4GDDNB/BRlM
         XBcw==
X-Forwarded-Encrypted: i=1; AJvYcCXIkVTLC24wqMjC5gsl7hAY4UHOLgzPaX8S4blXQ/s1GEjVawv3DhWsA2A4a6f/e6EcZ2nOg/2h6js6ye/8z+sTBx34U1J+je61LZYR
X-Gm-Message-State: AOJu0YyNZrtFLfrB72eUptxFjipNkcqxc3hKvT1OST2IJ8BVNMatepqy
	QqK3yBuJoFnUOSpCa74wfRe+k2i7S2TELae7WJ/a85S2zbg/yn1gqskahAfQ2T7w1p6WEARV3Km
	4ae5Csaz2TlOxeESnVQkwwV0fVmnqpodis1ySk9qUxPfJz4k28jAHnp074u8PjA==
X-Received: by 2002:a0c:aa46:0:b0:691:1a13:b452 with SMTP id e6-20020a0caa46000000b006911a13b452mr2445362qvb.16.1711634892759;
        Thu, 28 Mar 2024 07:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2ybPFAeQ6dCN4ECOvP/8nVSGbSYSQB/c65YiHAMKdOyI7F2TxPD64Pe5Y7/8NhoCukdg1qQ==
X-Received: by 2002:a0c:aa46:0:b0:691:1a13:b452 with SMTP id e6-20020a0caa46000000b006911a13b452mr2445334qvb.16.1711634892379;
        Thu, 28 Mar 2024 07:08:12 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id o8-20020a0562140e4800b0069677500d0bsm668627qvc.29.2024.03.28.07.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:08:11 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Alex
 Shi <alexs@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vincent
 Guittot <vincent.guittot@linaro.org>, Barry Song
 <song.bao.hua@hisilicon.com>
Subject: Re: for_each_domain()/sched_domain_span() has offline CPUs (was Re:
 [PATCH 2/2] timers: Fix removed self-IPI on global timer's enqueue in
 nohz_full)
In-Reply-To: <xhsmhttkrbvfb.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <Zf1sSv/6mQHJuJ8G@lothringen> <Zf2GDjekyemQKn7I@lothringen>
 <xhsmhwmppaqls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZgQULtxy0UnoXfGi@localhost.localdomain>
 <xhsmhttkrbvfb.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Thu, 28 Mar 2024 15:08:08 +0100
Message-ID: <xhsmhr0fubgaf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27/03/24 15:28, Valentin Schneider wrote:
> On 27/03/24 13:42, Frederic Weisbecker wrote:
>> Le Tue, Mar 26, 2024 at 05:46:07PM +0100, Valentin Schneider a =C3=A9cri=
t :
>>> > Then with that patch I ran TREE07, just some short iterations:
>>> >
>>> > tools/testing/selftests/rcutorture/bin/kvm.sh --configs "10*TREE07" -=
-allcpus --bootargs "rcutorture.onoff_interval=3D200" --duration 2
>>> >
>>> > And the warning triggers very quickly. At least since v6.3 but maybe =
since
>>> > earlier. Is this expected behaviour or am I right to assume that
>>> > for_each_domain()/sched_domain_span() shouldn't return an offline CPU?
>>> >
>>>=20
>>> I would very much assume an offline CPU shouldn't show up in a
>>> sched_domain_span().
>>>=20
>>> Now, on top of the above, there's one more thing worth noting:
>>>   cpu_up_down_serialize_trainwrecks()
>>>=20
>>> This just flushes the cpuset work, so after that the sched_domain topol=
ogy
>>> should be sane. However I see it's invoked at the tail end of _cpu_down=
(),
>>> IOW /after/ takedown_cpu() has run, which sounds too late. The comments
>>> around this vs. lock ordering aren't very reassuring however, so I need=
 to
>>> look into this more.
>>
>> Ouch...
>>
>>>=20
>>> Maybe as a "quick" test to see if this is the right culprit, you could =
try
>>> that with CONFIG_CPUSET=3Dn? Because in that case the sched_domain upda=
te is
>>> ran within sched_cpu_deactivate().
>>
>> I just tried and I fear that doesn't help. It still triggers even without
>> cpusets :-s
>>
>
> What, you mean I can't always blame cgroups? What has the world come to?
>
> That's interesting, it means the deferred work item isn't the (only)
> issue. I'll grab your test patch and try to reproduce on TREE07.
>

Unfortunately I haven't been able to trigger your warning with ~20 runs of
TREE07 & CONFIG_CPUSETS=3Dn, however it does trigger reliably with
CONFIG_CPUSETS=3Dy, so I'm back to thinking the cpuset work is a likely
culprit...

>> Thanks.


