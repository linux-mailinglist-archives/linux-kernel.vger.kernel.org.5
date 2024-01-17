Return-Path: <linux-kernel+bounces-28569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C3830024
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81F91F251F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7FAD26D;
	Wed, 17 Jan 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYQk9dww"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014FBE49
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705473026; cv=none; b=OAQPI+Dab2Wi+HWfRNhriRzpmNnVJjXZEHj8tX3lSpvrRUU9A11a6XtUpMuhxvlBg8TSqIqZKn7h3p2UCSTXzXGuJr8VJSilKOg3AI3WK+zI6bc28nevOoIlvPgZ3LTl2FMitYHmEuUXL+z/aTRaHPLjVgUeyQeg4QX1rpvbzi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705473026; c=relaxed/simple;
	bh=d/+Iqt7FN2V9H5BldHeUcRwFbKJt6MqHvk+5w5dVM70=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=ekvQ5uDwqCIRrxpxaddmfwnLk24zAB4exy9YE1eiJYDLp3ptx1PVxl7hCzfuacx6SQwBaAOc1mhp/N8h7LUB6mH4RKD5Fh1WjDYxfSMVmT/aBLf/aVJxINSdQRZGCZEsSKsPdjA4/4K8jSxOtZ/vVWk3qlUjtvaJUFEFlw7SPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYQk9dww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705473024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3SWvsqvo8kKRREIVaq74k7zOkw2lqw8OoQBIc8ZyG6g=;
	b=KYQk9dwwY9HmEBamOFIC+Dcxi/KLImccbZhSa66rPNnalljHX82FJ0yLNdyGC7bNykDczN
	om9T/yFa7s3AgXrSzI9hhkGo2bHT+tjnYT4knvRZ0qopsPGrI4mlHwtRAg8PF2HIwuQUt2
	uGXOUnXaYVRyjIGjoat8J9IPDeAw6Aw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-kIj_0avkMaa1JkFLRNor8Q-1; Wed, 17 Jan 2024 01:30:21 -0500
X-MC-Unique: kIj_0avkMaa1JkFLRNor8Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-429d02a63baso80108931cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705473021; x=1706077821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SWvsqvo8kKRREIVaq74k7zOkw2lqw8OoQBIc8ZyG6g=;
        b=IMamS9eR0QuCcR1O/jSeBVFmFjDSbFUlC7Lm0A219ZrxgP8Nl7um1NBGKe7c1ztYGe
         7d3XA/CXvcPyu6YEEVpI67vu6uL44iafuNCzgT0nZNV4UGpobjD3sDPMTh2jk6LwN482
         m/qVPy8M1o9g8fAMR1eo5a1QK7QdgCP/+pSa6CZv2HJdXRyvqsEH/x/Iu54t/C8lO65K
         +0JQMF0HqJV/mjF0ALQpGKv73p1q5/T4aSl3BB2vNr+MRFR2It/NrwWGPu0cvG4RHhvs
         47clPkLcO+ZkqHTzRbg+JYoDajHtyiOubtfLyrBMwnLAwIZr7DrbpiIkEf8nX1uGs6IL
         pgfQ==
X-Gm-Message-State: AOJu0YyLnVMrXY15E0dUM9qWHeHXpbRBcwNMhwJVzc+Me2PErjuFHlfA
	G8z8fxauIL8bclEL+JeYdLDm5OCGQZwZHCTi0k5432Dw5G7KtRVaupbh3+DH6fGnbTZRT5IkjYF
	TLCg2W4cAsFPPHzTOQuxwfpoNRl3Uugy/
X-Received: by 2002:a05:622a:11c9:b0:429:7d0c:6046 with SMTP id n9-20020a05622a11c900b004297d0c6046mr10952481qtk.68.1705473020903;
        Tue, 16 Jan 2024 22:30:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+BQy/SCO/b8AjPtrrp1Vd/3GsTEAFv27SNam14tPowsSumiOsAu3SejErD6EszzKJE+6zyw==
X-Received: by 2002:a05:622a:11c9:b0:429:7d0c:6046 with SMTP id n9-20020a05622a11c900b004297d0c6046mr10952471qtk.68.1705473020527;
        Tue, 16 Jan 2024 22:30:20 -0800 (PST)
Received: from localhost.localdomain ([151.29.130.8])
        by smtp.gmail.com with ESMTPSA id w8-20020ac86b08000000b0042a0effd2d8sm298843qts.36.2024.01.16.22.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 22:30:20 -0800 (PST)
Date: Wed, 17 Jan 2024 07:30:16 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] kernel/workqueue: Let rescuers follow unbound wq
 cpumask changes
Message-ID: <Zadz-DT6lTdrx7US@localhost.localdomain>
References: <20240116161929.232885-1-juri.lelli@redhat.com>
 <20240116161929.232885-5-juri.lelli@redhat.com>
 <CAJhGHyBuf02mh=ezoua33UNu5QTpwP=qf-WP_C2qVyx_HEtMDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyBuf02mh=ezoua33UNu5QTpwP=qf-WP_C2qVyx_HEtMDg@mail.gmail.com>

Hello Lai,

On 17/01/24 11:56, Lai Jiangshan wrote:
> Hello, Juri
> 
> On Wed, Jan 17, 2024 at 12:20 AM Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > +       /* rescuer needs to respect wq cpumask changes */
> > +       if (ctx->wq->rescuer) {
> > +               set_cpus_allowed_ptr(ctx->wq->rescuer->task, ctx->attrs->cpumask);
> > +               wake_up_process(ctx->wq->rescuer->task);
> > +       }
> > +
> 
> What's the reason to wake up the rescuer?

I believe we want to wake it up so that it can possibly be moved
"instantly" to a cpu inside its new cpumask affinity. If we don't wake
it up it might be sleeping on a cpu outside its affinity which might
have become isolated and this cpu could be affected by that wakeup if
that only happens later on when possibly the rescuer needs to perform
some work.

Does is make more sense to you?

> I support this patch except for the wakeup:
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Thanks for looking at this!

Juri


