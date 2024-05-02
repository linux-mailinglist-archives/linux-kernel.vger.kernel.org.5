Return-Path: <linux-kernel+bounces-166241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591E78B97EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F241F23620
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6A655C29;
	Thu,  2 May 2024 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EhVfyho6"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78154F87
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642794; cv=none; b=ZBI/r6pAB9Gh5jHc8oaQvK54lWcueLM1d2iU0WQ7eT1U5KNQMaqCVFXGdliSQHtmAqS3UTXJx+7DZLEevNJrESzNhxXyODFIYjLntuyUoWxT+vU47UtPdiRNOUiP6bRLPXfnmuLmWxIMmg/C/Uy3Or0vD/F3YYxDAebvq8mnaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642794; c=relaxed/simple;
	bh=sqMoKRK4y1Rh1zRpDDkDNXt+SzfZBNPMW/1AY9LKymM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JbXDbD8Z23Wm+h5KrQ2O7o9IIHc/2kgSN6iSz7O1kxbqbi1SQgkWQjTd78JE6lmz2AXxbFGZ1qGwYYkDV47pQgjvfKLm4UajbguZdx6FoOhKfpK03TsVmeM/g2Nq8ATnyyZdf15nu12/DxDF9+Tb0YASNm+0Ow9a117aHPdQXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EhVfyho6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6174735c444so931234a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714642792; x=1715247592; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqMoKRK4y1Rh1zRpDDkDNXt+SzfZBNPMW/1AY9LKymM=;
        b=EhVfyho69v6dBSy2JIJnt5t/4+kHfMLY/9/83t6/y8maq0xJ/KTWt/Qa4TJ9bCLHDR
         r66senwMjvEIk3k1lTjbtxEgnV22BkJi0h8zilLgbo81NZRe9B/qBQ/eDGyfesPqlw5A
         KAC2ec1Pmzl6iEh2HtP6aku2G8uWpe8yt1YK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714642792; x=1715247592;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqMoKRK4y1Rh1zRpDDkDNXt+SzfZBNPMW/1AY9LKymM=;
        b=pMFJVLJTOhHBfXLkPmvm8thF/QM6KAcSNhMQD2P47wUPFf4oEPRw2vcuSSmhLmxfj+
         dd7Bv+LM/sj7HWhd/iR0rQedWsJt1/wi3siF5q9cfnRQslI4I4OXRcdFVZWsxYYylAzV
         5VTvIakK6FlYy/V6ayJfz+OSJrb5gtgblGLB8j8DnhW0A/tX3c2/T4se8ApESSlZJyvs
         bOx27uYqcM+qw7gHRwb9oAihypKeU9PYgf0migHrhgD3o2NWslPA+NdYgNMXZ1PWRYBX
         /h63W9kM3KPenR9rTMDFjRK5BRr6BHRCf8WFXcIc+8enahTG/i8kpEIcWne7JBVcWdxe
         q8bA==
X-Forwarded-Encrypted: i=1; AJvYcCX178jkPsbxnxBQ+PvZaei2Agl7tL5/iQ0/H5S9ldIr1CEPhFSysjkx2xzRvcFPbtFS8Ws5IDuykbKLaG7r6cGALT3I0/2p/U16OOks
X-Gm-Message-State: AOJu0YxXhmZsboeLQVIhWXpFZ8YZE13hUyyraVDe3AqlhtNwV23mbzpl
	7K/yWnHy/e8VGXNmKhtDdfnBOy/fiJt6IvOc/n72icrg9Yxuu2DjO4d7pRgi3A==
X-Google-Smtp-Source: AGHT+IGydD8U8S2tFFcgkgudhMsXbEcgK2uWLG5iCTvap6KD0v5y6i2iS60xdpJ/+ZSOwDtdxxGqYg==
X-Received: by 2002:a05:6a20:2d13:b0:1a7:6a90:8820 with SMTP id g19-20020a056a202d1300b001a76a908820mr4613288pzl.4.1714642792455;
        Thu, 02 May 2024 02:39:52 -0700 (PDT)
Received: from smtpclient.apple ([103.19.213.32])
        by smtp.gmail.com with ESMTPSA id ca10-20020a17090af30a00b002ac4e48b0fdsm781830pjb.8.2024.05.02.02.39.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2024 02:39:52 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.1\))
Subject: Re: [PATCH] lib/cpumask: Boot option to disable tasks distribution
 within cpumask
From: Ankit Jain <ankit-aj.jain@broadcom.com>
In-Reply-To: <F4B1A5C9-FD5E-42EF-9DA7-4EB394D10408@broadcom.com>
Date: Thu, 2 May 2024 15:09:34 +0530
Cc: linux@rasmusvillemoes.dk,
 akpm@linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com,
 vasavi.sirnapalli@broadcom.com,
 Paul Turner <pjt@google.com>,
 Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>,
 yury.norov@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <65066F6B-7A00-4F1C-B09A-C9843884DEFC@broadcom.com>
References: <20240430090431.1619622-1-ankit-aj.jain@broadcom.com>
 <ZjE3C9UgeZR02Jyy@yury-ThinkPad>
 <20240501133608.GB39737@lorien.usersys.redhat.com>
 <ZjJfftWMbjT9r8iT@yury-ThinkPad>
 <20240501153911.GD39737@lorien.usersys.redhat.com>
 <F4B1A5C9-FD5E-42EF-9DA7-4EB394D10408@broadcom.com>
To: Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3731.700.6.1.1)



> On 02-May-2024, at 1:39 PM, Ankit Jain <ankit-aj.jain@broadcom.com> =
wrote:
>=20
> On Tue, Apr 30, 2024 at 11:23:07AM -0700, Yury Norov wrote:
>> On Tue, Apr 30, 2024 at 02:34:31PM +0530, Ankit Jain wrote:
>>> commit 46a87b3851f0 ("sched/core: Distribute tasks within affinity =
masks")
>>> and commit 14e292f8d453 ("sched,rt: Use cpumask_any*_distribute()")
>>> introduced the logic to distribute the tasks within cpumask upon =
initial
>>> wakeup.
>>=20
>> So let's add the authors in CC list?
>>=20
>>> For Telco RAN deployments, isolcpus are a necessity to cater to
>>> the requirement of low latency applications. These isolcpus are =
generally
>>> tickless so that high priority SCHED_FIFO tasks can execute without =
any
>>> OS jitter. Since load balancing is disabled on isocpus, any task
>>> which gets placed on these CPUs can not be migrated on its own.
>>> For RT applications to execute on isolcpus, a guaranteed kubernetes =
pod
>>> with all isolcpus becomes the requirement and these RT applications =
are
>>> affine to execute on a specific isolcpu within the kubernetes pod.
>>> However, there may be some non-RT tasks which could also schedule in =
the
>>> same kubernetes pod without being affine to any specific =
CPU(inherits the
>>> pod cpuset affinity).
>>=20
>> OK... It looks like adding scheduler maintainers is also a necessity =
to
>> cater here...
>=20
> So 14e292f8d453 is very specifically only using sched_domain_span(), =
and
> if you're using partitioned CPUs they should not show up there.
>=20
> As to 46a87b3851f0, if you're explicitly creating tasks with an =
affinity
> masks that spans your partition then you're getting what you ask for.
>=20
> In fact, I already explained this to you earlier, so why are you
> suggesting horrible hacks again? This behaviour toggle you suggest is
> absolutely unacceptable.
>=20
> I even explained what the problem was and where to look for solutions.
>=20
> =
https://www.google.com/url?q=3Dhttps://lkml.kernel.org/r/20231011135238.GG=
6337@noisy.programming.kicks-ass.net&source=3Dgmail-imap&ust=3D17152442350=
00000&usg=3DAOvVaw03JVPjd7QleOP3JrOjP8pO


Hi Peter,

Apologies for not trying out the solution you suggested earlier. I will =
test this
solution for our use case and share the result.

Thanks,
Ankit=

