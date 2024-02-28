Return-Path: <linux-kernel+bounces-85047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB386AF92
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0138E2878AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1D2148FF4;
	Wed, 28 Feb 2024 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKZgXW5V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DAA208C5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125054; cv=none; b=DeZssp133QMv6STdSCN2a8X5rVfEsudHRh4ih7R5BFurs1SfbPJjvkqb6hLYFen9IGBTYL/PRKld7JffDNLPfBvog7mV1DrUIwcEX0JWSfnGDaNLGOAlfYGRUZ7foCpnqglxFwJTESKDZOh6fmJLCRaH1dgNRNWMATY306ie560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125054; c=relaxed/simple;
	bh=aRQu0O94B8WlLNlFmFrl3z9Zt2G7Kv2dqaDlpP4+6Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/AQ3ejY2EWHpDBWwKbkpzgdHFgDKf+Vb943aime2OVmVOyrnvUMuIpgxCSd+0uJ46pcBKu1K2CEekYQTLUhW5R5knL/HASWHAJMmUubpJM+fgiKLTiNNKuxszytoF0apFRXRw5bQsVt9iCtDj5Nbr1GcpwU84hRPExrYcMw0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKZgXW5V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709125051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KvWJOwrGwY/l3wFHjX1h2nSrO3dCw0bb3kRO4rQX5E=;
	b=bKZgXW5V2GOyGpqjtoIRpw/yD1MqvFHTDOyH76awmmkmY9pMm03o4+xj+StV6iiQFkTUsd
	YQolCGLh5YURJu/EWkoJB65yH9CeeynWwN1C2d1ogiTkqqNOTUtUrXcg2EQ0b1X5V3XZHW
	KWAV9DmbVaYwClPSjQYTyqttzec4DH4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-g8Wiw7_EOfqWx_r8Ms76UQ-1; Wed, 28 Feb 2024 07:57:29 -0500
X-MC-Unique: g8Wiw7_EOfqWx_r8Ms76UQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c1b8b34512so635034b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125049; x=1709729849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KvWJOwrGwY/l3wFHjX1h2nSrO3dCw0bb3kRO4rQX5E=;
        b=k3g6iGcQBYixeNvSYU2AFN+TQFFmv+2wmHRkze5IQCnCBaJqiNAq0NwBXd0w4wAw4w
         14oLHk2Cu9mbM4XdxvBtxuD7ggcLW9r6GLWjZnyngOGLAZk1SdkA66DJe2MMTsGjJupr
         A/yqppadwWaBRc2R8mAo0Sk+xUM+Y78A3R6QsYb9nzKXgK03oykRUlfa/RmgdHqVAEG7
         dND271OeW0H7GQ6pJiHoRwPNmL6a5RfIW0b3TJEaatMbz1GGWRrsGQM86gw0QUdL3x1B
         R33hsqNxobIdoob5mKlZ+ElrFjRkMxLUx0Qug3/2d2SgCu05a1ooY18Lj+uc2FJ3PjHr
         ay6A==
X-Forwarded-Encrypted: i=1; AJvYcCVtgDbSPu6/nHkWs4a+myGXrIqJ4JcRLATQ5kQkD/f5Q6XLGbjFM1NMgFO56edoNIx8vI7EsmfSV7Rmx69SJq8eaqV6A/8wV1Jw6xOf
X-Gm-Message-State: AOJu0Ywm+8g6XWR08FhLrVU3PL2e614oNRVwP+DttzsFsc5n25rzicDJ
	omjV2bjjrmNSzCpPMK8AQLls0myffuD8iBRwh/WTXatXjIiNTAgJtVCiWWWltdQm+A9IfAp246L
	C7b0bh28Dv12g4Sc872c57hBlW6f4pkTcm0JZLLb4ZpXpPr59/4+qFKxFNqTFr57cs2WbplGn7j
	fjhbFWCy4IGKI6+2Yuxb69iFiHkGYOVZF1+a51
X-Received: by 2002:a05:6358:9226:b0:179:ff:2486 with SMTP id d38-20020a056358922600b0017900ff2486mr16401027rwb.29.1709125048894;
        Wed, 28 Feb 2024 04:57:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeeS0ikgf4yqHsAJ/HQO06vAA7zJpcNmKqX0+hjaYOSr4+cDMEL+uZzsSUC4oElIAfogBFzrTOJJbscktJ8dA=
X-Received: by 2002:a05:6358:9226:b0:179:ff:2486 with SMTP id
 d38-20020a056358922600b0017900ff2486mr16401001rwb.29.1709125048659; Wed, 28
 Feb 2024 04:57:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-5-yukuai1@huaweicloud.com> <d233fc29-e3ab-4761-9368-c203efc0466e@redhat.com>
 <40ac6914-7c1f-00b7-f480-25c9786482fc@huaweicloud.com>
In-Reply-To: <40ac6914-7c1f-00b7-f480-25c9786482fc@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Wed, 28 Feb 2024 20:57:16 +0800
Message-ID: <CALTww29JwP+_1vfiodjy3YCze9pQ92JRGhCNVygLpm3k0gVJAA@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] md: don't register sync_thread for reshape directly
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com, 
	agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org, 
	neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 8:44=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/02/28 20:07, Xiao Ni =E5=86=99=E9=81=93:
> > I have a question here. Is it the reason sync_thread can't run
> > md_do_sync because kthread_should_stop, so it doesn't have the chance t=
o
> > set MD_RECOVERY_DONE? Why creating sync thread in md_check_recovery
> > doesn't have this problem? Could you explain more about this?
>
> raid10_run() only register sync_thread, without calling
> md_wakeup_thread() to set the bit 'THREAD_WAKEUP', md_do_sync() will not
> be executed.

I c. The user is responsible to wake up the thread. If raid10 wakes up
the thread in the right way, we don't need to move register reshape
thread to md_check_recovery, right?

>
> raid5 defines 'pers->start' hence md_start() will call
> md_wakeup_thread().
>
> md_start_sync() will always call md_wakeup_thread() hence there is no
> such problem.
>
> BTW, this patch fix the same problem as you mentioned in your other
> thread:
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 2266358d8074..54790261254d 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4904,6 +4904,7 @@ static void stop_sync_thread(struct mddev *mddev,
> bool locked, bool check_seq)
>          * never happen
>          */
>         md_wakeup_thread_directly(mddev->sync_thread);
> +       md_wakeup_thread(mddev->sync_thread);
>         if (work_pending(&mddev->sync_work))
>                 flush_work(&mddev->sync_work);

The first patch of my patch set has this already. Maybe it's the
reason that my patch01 can fix this similar problem.

>
> However, I think the one to register sync_thread is responsible to wake
> it up.

Agree, the user that registers thread should wake it up. So start/stop
sync thread apis are common. And they can be called by many users.

Best Regards
Xiao
>
> Thanks,
> Kuai
>


