Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E751B78BC00
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjH2AI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjH2AIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C951A1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693267658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfIIOjpw/JPxG16IRtlqlUGwpaBYGM5WNBJjPm24CLw=;
        b=apuTYZpabNdK6stJz9kEtbZ9xhDTgRAJh/JFHrcNZq9LDDrUIgz/8xM98mMGWotjN0R51X
        082WBfHZiNe8Pji9oAPOSQ3udSJcGKGL4k/kUXahISTUMzwKsX/hWvIizdLy1c6zwbPArI
        B+P9fWUjXuZsFwA85fGTMggYLjd0nXE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-YNqGIFpDNdiCWMUn7kVKVg-1; Mon, 28 Aug 2023 20:07:35 -0400
X-MC-Unique: YNqGIFpDNdiCWMUn7kVKVg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a741f478f8so4679995b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693267654; x=1693872454;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EfIIOjpw/JPxG16IRtlqlUGwpaBYGM5WNBJjPm24CLw=;
        b=cSIw8O6jSH59om+DoD+VMbL/yNGNdOwBL8uUweh7FBiWkyle2xjMvKloRUGEb+4yLm
         +csmmG5OdZpkzQNqKLfXTBBmHezSdLnaRFXN254PUpZ7gQ7P4B9m+MF1a/SJ+CxEXX31
         0ZLsg8YXAX+zx86yMNvnxtU2a9Ln4xUeSniJY0dg9XHFnu8UC8sJUBOEsZpNOAr8Kc3y
         y5j6gqRAr32IEozUG1A8DRKh0tVV4w83VfOFMYbFaIy+QthN9ttLbHrJArLCxdkoSWDH
         qrQWi9dFGoI5y9UobX31pX+92EoU24BqFjAM+K6J9LQn1PvZss+Q8yw0AkAjunPR1Mli
         WalQ==
X-Gm-Message-State: AOJu0YyoYyWsW+BkKT9K8DsyNpVV9OtJMhDkE2ixZznNTnTEbvPYCf8n
        lrA2Hcct+LyyLnKRHudES4t1TbZFHG48qTqLsWOhaPH5uIBefcTvw0w0V5ogELfC7caHPx2tnuV
        h9+HgFduda+sTBJfv3TiDif2C4hofHPOS
X-Received: by 2002:a05:6808:1393:b0:3a7:4ac4:d4fc with SMTP id c19-20020a056808139300b003a74ac4d4fcmr14387151oiw.33.1693267654318;
        Mon, 28 Aug 2023 17:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYsefOaHBY9jkmas3f1adjpVCO+ZP2NesdWBg8EU5kcBCRAtIMhPRb543B1wG6ZeLwrgxAqw==
X-Received: by 2002:a05:6808:1393:b0:3a7:4ac4:d4fc with SMTP id c19-20020a056808139300b003a74ac4d4fcmr14387145oiw.33.1693267654133;
        Mon, 28 Aug 2023 17:07:34 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:98e3:3c98:3d83:9703:4411? ([2804:1b3:a802:98e3:3c98:3d83:9703:4411])
        by smtp.gmail.com with ESMTPSA id e17-20020a056808149100b003a88f5ebfeesm3923557oiw.42.2023.08.28.17.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 17:07:33 -0700 (PDT)
Message-ID: <82ea7cb508ee4cee6d2fde1158692d0cee97eb42.camel@redhat.com>
Subject: Re: [RFC PATCH 2/4] swap: apply new local_schedule_work_on()
 interface
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Date:   Mon, 28 Aug 2023 21:07:30 -0300
In-Reply-To: <ZNKZ8Vc/LE9lVAjN@tpad>
References: <20230729083737.38699-2-leobras@redhat.com>
         <20230729083737.38699-4-leobras@redhat.com> <ZNKZ8Vc/LE9lVAjN@tpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-08 at 16:39 -0300, Marcelo Tosatti wrote:
> On Sat, Jul 29, 2023 at 05:37:33AM -0300, Leonardo Bras wrote:
> > Make use of the new local_*lock_n*() and local_schedule_work_on() inter=
face
> > to improve performance & latency on PREEMTP_RT kernels.
> >=20
> > For functions that may be scheduled in a different cpu, replace
> > local_*lock*() by local_lock_n*(), and replace schedule_work_on() by
> > local_schedule_work_on(). The same happens for flush_work() and
> > local_flush_work().
> >=20
> > This should bring no relevant performance impact on non-RT kernels:
> > For functions that may be scheduled in a different cpu, the local_*lock=
's
> > this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).
> >=20
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  mm/swap.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> Leo,
>=20
> I think the interruptions should rather be removed for both
> CONFIG_PREEMPT_RT AND !CONFIG_PREEMPT_RT.
>=20
> The impact of grabbing locks must be properly analyzed and not
> "rejected blindly".

Yes, I agree with the idea, but we have been noticing a lot of rejection fo=
r
these ideas lately, as the maintainers perceive this as a big change.

My idea here is to provide a general way to improve the PREEMPT_RT scenario=
s CPU
Isolation, even though there is resistance in !PREEMPT_RT case.

As I commented, spinlocks are already held by PREEMPT_RT's local_locks hotp=
aths,
and yet are using schedule_work_on() to have remote work done. This patch t=
ries
to solve this by using spin_lock(remote_cpu_lock) instead and save a lot of
cycles while decreasing IPI at the remote cpu.

It looks a simple solution, improving isolation and performance on PREEMPT_=
RT
with no visible drawbacks. I agree the interface is not ideal, and for that=
 I
really need you guys help.

I understand that having this change merged, we will have more precedence t=
o
discuss performance for the !PREEMPT_RT case.

What do you think on that?

Thanks!
Leo

>=20
> Example:
>=20
> commit 01b44456a7aa7c3b24fa9db7d1714b208b8ef3d8
> Author: Mel Gorman <mgorman@techsingularity.net>
> Date:   Fri Jun 24 13:54:23 2022 +0100
>=20
>     mm/page_alloc: replace local_lock with normal spinlock
>    =20
>     struct per_cpu_pages is no longer strictly local as PCP lists can be
>     drained remotely using a lock for protection.  While the use of local=
_lock
>     works, it goes against the intent of local_lock which is for "pure CP=
U
>     local concurrency control mechanisms and not suited for inter-CPU
>     concurrency control" (Documentation/locking/locktypes.rst)
>    =20
>     local_lock protects against migration between when the percpu pointer=
 is
>     accessed and the pcp->lock acquired.  The lock acquisition is a preem=
ption
>     point so in the worst case, a task could migrate to another NUMA node=
 and
>     accidentally allocate remote memory.  The main requirement is to pin =
the
>     task to a CPU that is suitable for PREEMPT_RT and !PREEMPT_RT.
>=20

