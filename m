Return-Path: <linux-kernel+bounces-121437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A0F88E7E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F90281689
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8CE12F37A;
	Wed, 27 Mar 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QO4hdwZi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824A12DD85
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549744; cv=none; b=VK6DPrCKqZA8dWKanqhimc7MS0kco+K93GRor0+opSRFQN7oF9Pl9R2Hi9FQVYCDaHIu6UH2OBVUoDBSsqXZIkniU+slHNL6ld+6b05w3Zsf8DT4Th/hjNAQRGna4Ci7e3KXgpDQS78qWiICPKRf/Kn75eNUDq0hykImQkV82jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549744; c=relaxed/simple;
	bh=EX3bB2tIvlR70TqSvY9a5kiFkuRf6H6igFYKBi3vo/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SO3FWxBeiHzmy+YHz18SWQ75Qs9cbG9vA2WMZnOkVNUooHB+0KLCaffeqZDpsjdIj4TfQrDi7awKFmTXzKqYDxi/h7Rcnvcht0eSUzeQpVM9dTfiRKJRB9X3g21QxPr/J+7q3AaEWSEt/LO02xI2UkHsBy+TAd9DhGeSWyxm1kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QO4hdwZi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711549741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AexAAi3jOkUSVNodNAIXipjt4sVm4klRFg3i+A4ZqQM=;
	b=QO4hdwZiryuqcpi6ZeLKJ7PVdjlQME8RRhQogjp4PdpGGWO4YYBOrnFccSRru7EQn/Em+L
	wa8O8tvZ52//KfQhRwxcv/7XlBNlZqdm/IXDlvdOC2BLtjNFKdZXFPHcyKmaCnIdnXetMC
	bOzXIDkJeDC86fT7fUTlabJV77IyA6E=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-fVR1VVGWOCqk5MaER7vfYQ-1; Wed, 27 Mar 2024 10:29:00 -0400
X-MC-Unique: fVR1VVGWOCqk5MaER7vfYQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d478badf3cso58285771fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711549738; x=1712154538;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AexAAi3jOkUSVNodNAIXipjt4sVm4klRFg3i+A4ZqQM=;
        b=Ps2CcoByrC2DU6vr7u81ykpX+6cL0nu2HMLEz77DPX6FBZU6cs87p5GwTmvxyU2vIr
         gjti6GHTD7h3gdTIutrwF6rOcgmPdxWA28bcTWyyFIzkx9cZQ71Y4xomQpVXOXUv6lVM
         luPFt/ALYUQpZ2AIqtut2td66CxhKNhIieh6+mAAdpnuIJ6WrXxd3mzWYo/kZTsfKXPR
         bDqqzg6uysZSPpA3DLJzI41yLiB9lo5OiHsX8yIpctII6qvH39UrQZfKjeAUL30F9Nwt
         ddOoHODIW+lH8XVQQcU3WQGj/bsUjbsaYTRrzCncG41ahSaWaHFDH258jpftJFAoSp1g
         T58Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkWwnEKK55F7JkMoHXDyRFTbCOe0X994VeXNNKlKJRJz8MM04tJDCIDVDWjpN/N1FyxeITz66S6+9uqFvLsBaCo5QLArItEAEXRIcT
X-Gm-Message-State: AOJu0YymJGOgW/apmKUezb4FWu0hw7DlyJgaMgR79aP9aIF78gvv2Cu7
	v79YLYjF+yn4OUMlL5wfTfw73O7tSG+xq3YFqkGWpK4+5vBaMFAcNNKWSgCZnXbo1CKrrMkp0Oa
	L1TCnL0btx+sV7M1OKZt7wnV+BP7eXERg7WekoBpo24Gvs+ZB9Lbn3y/y+37yjw==
X-Received: by 2002:a2e:8689:0:b0:2d7:b:da37 with SMTP id l9-20020a2e8689000000b002d7000bda37mr164407lji.7.1711549738457;
        Wed, 27 Mar 2024 07:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaWdIHvC35mqfDxpX51ymos0FP5+HQiZWzLXDlcOh+cOgLh1BSCjFurlSB4Cr46lhZl3HI+A==
X-Received: by 2002:a2e:8689:0:b0:2d7:b:da37 with SMTP id l9-20020a2e8689000000b002d7000bda37mr164384lji.7.1711549738060;
        Wed, 27 Mar 2024 07:28:58 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0041496b92502sm938084wmq.31.2024.03.27.07.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 07:28:57 -0700 (PDT)
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
In-Reply-To: <ZgQULtxy0UnoXfGi@localhost.localdomain>
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
Date: Wed, 27 Mar 2024 15:28:56 +0100
Message-ID: <xhsmhttkrbvfb.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27/03/24 13:42, Frederic Weisbecker wrote:
> Le Tue, Mar 26, 2024 at 05:46:07PM +0100, Valentin Schneider a =C3=A9crit=
 :
>> > Then with that patch I ran TREE07, just some short iterations:
>> >
>> > tools/testing/selftests/rcutorture/bin/kvm.sh --configs "10*TREE07" --=
allcpus --bootargs "rcutorture.onoff_interval=3D200" --duration 2
>> >
>> > And the warning triggers very quickly. At least since v6.3 but maybe s=
ince
>> > earlier. Is this expected behaviour or am I right to assume that
>> > for_each_domain()/sched_domain_span() shouldn't return an offline CPU?
>> >
>>=20
>> I would very much assume an offline CPU shouldn't show up in a
>> sched_domain_span().
>>=20
>> Now, on top of the above, there's one more thing worth noting:
>>   cpu_up_down_serialize_trainwrecks()
>>=20
>> This just flushes the cpuset work, so after that the sched_domain topolo=
gy
>> should be sane. However I see it's invoked at the tail end of _cpu_down(=
),
>> IOW /after/ takedown_cpu() has run, which sounds too late. The comments
>> around this vs. lock ordering aren't very reassuring however, so I need =
to
>> look into this more.
>
> Ouch...
>
>>=20
>> Maybe as a "quick" test to see if this is the right culprit, you could t=
ry
>> that with CONFIG_CPUSET=3Dn? Because in that case the sched_domain updat=
e is
>> ran within sched_cpu_deactivate().
>
> I just tried and I fear that doesn't help. It still triggers even without
> cpusets :-s
>

What, you mean I can't always blame cgroups? What has the world come to?

That's interesting, it means the deferred work item isn't the (only)
issue. I'll grab your test patch and try to reproduce on TREE07.

> Thanks.


