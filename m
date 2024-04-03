Return-Path: <linux-kernel+bounces-130180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C2A897505
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D73A1B24B9C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A6714F11C;
	Wed,  3 Apr 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbUxIIGF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CAD14E2EC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161054; cv=none; b=ubpq+K+sM1/6F2to7GFUUP3ce3BRSHcvEfs6QYDv33NIYel8e+v0zv2bgzIuFv6dUlOsyq0x2jQToDC91/mooEKnzz4SWoAg4xOrzw+UFnOuFudweVm11UHQKA3BUPTyr8ahPdbOv/5sLPBgOhFH7HG0/Jg3CDQi3hWmQkODIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161054; c=relaxed/simple;
	bh=/oHz60YmomB8xtLx1SmFXh+ChYzmFb8LPQK3p7ehSUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D7K3faTDhP0wamg/XoBXQgXH6pzdhqVh6BP6fyk6xwRChoi/q206AHWY+qHtoGuIGOww9xOf3mLPxyQfdNF3N6OmEVFyVb1u/dV7KBDDgBaWiCpBK17Y+4jUlNJU+Vmhgx5uzqW3uDuYCFECLhpOEubg/TWI3Eu+9ppjsd2c0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbUxIIGF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712161052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQm7KJ2wxSLm5O0upddCNpxjqnodHhe0dn1TWqhcwVM=;
	b=CbUxIIGFlyZJ/hf6mrsde4gwXpm70JgMw+Pc/du55q7b2fA+zHik8nieCx0bL2A2F3kmo3
	kHtWEqn5cykaMpGGtT8ngWM4ALu2CI2+G6dcLuUKJODuy0EDXC2pX7WfF2F13qM4o6u8tf
	pgEfyxqtcqlVH2+sY+BtvgNZjOBWH98=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-Om4XmBmcMYm1F04UhbtY7A-1; Wed, 03 Apr 2024 12:17:30 -0400
X-MC-Unique: Om4XmBmcMYm1F04UhbtY7A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6963cd45fddso25623116d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712161050; x=1712765850;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQm7KJ2wxSLm5O0upddCNpxjqnodHhe0dn1TWqhcwVM=;
        b=S59aMSxvz64FZ6EFsf8wo4jk0yFylzKaf0sAEV3O4sAI0IBiALTswd2ogk0pnaEV/j
         cl1MSvv8i1bLZzgIezcncwjvdN8wkKP7bMefx4I/GPgzapK5s2cHh65zJrmXNlb7TMZd
         ca004Qk227MFSpuvL025V7DfLDXc98G10uQgqTrlP+T83JiFrU+uvahyMn3brJD58VP1
         dC7POZkTl2QDnn0S52SeXq92ZQTWNsRZOZ9kgYmsbqd2stI9rkb8DeuB+Q3JPCFJkr4v
         9q0d6q/stZInBf2x8SZqMpXLo7q1TMNIKWarNE4OvNWulQ3zChJwhKSJZ+wJIaavIbdz
         tbhA==
X-Forwarded-Encrypted: i=1; AJvYcCUi8lkKTKMT6JLrkrmFsmvebmI7Gj6U2VYE10NqCtO93Po8I0/eEAO6DZfxvjB1ZJ5OkSwia2DFGhY8OQpPgBJVWQzmKEy+WlsCapdb
X-Gm-Message-State: AOJu0YwAzveX2imzDZgIDa33U1Ezb8CF1ejy8y+KAqREQXzOAhDQ4Knf
	hVwbU8GZpjXiHjLZl0uS6CHiuizurO8H7ZRwBzjjNaih39L9uf0FoaySO59FbldLqDFcdKz3e3b
	eynRB5iPbRMepQuHJLyvsGHIfmwBL6jcS7yPqKBbKfHglzAdzi+0Jkl4ORxDYzg==
X-Received: by 2002:a05:6214:4a5b:b0:696:926e:dfe3 with SMTP id ph27-20020a0562144a5b00b00696926edfe3mr4445023qvb.22.1712161049921;
        Wed, 03 Apr 2024 09:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR3C2HuuS83Z+oeOqPEr+EoDC/KiDUbG8jZaKkAfFo7rb5+8xu5HIXGjsbFTYHuv5C36xqTg==
X-Received: by 2002:a05:6214:4a5b:b0:696:926e:dfe3 with SMTP id ph27-20020a0562144a5b00b00696926edfe3mr4444998qvb.22.1712161049636;
        Wed, 03 Apr 2024 09:17:29 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id oo14-20020a056214450e00b00690c9256676sm6614401qvb.49.2024.04.03.09.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:17:29 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Waiman Long <longman@redhat.com>, Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Alex Shi <alexs@kernel.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH 1/2] cgroup/cpuset: Make cpuset hotplug processing
 synchronous
In-Reply-To: <620d1b70-cfbc-4b76-ad04-b3be559afd56@redhat.com>
References: <20240401145858.2656598-1-longman@redhat.com>
 <20240401145858.2656598-2-longman@redhat.com>
 <kce74bx6aafxfuw5yovaschym4ze4kommfk74eq5totojytest@mdxnfvl2kdol>
 <548efd52-e45f-41fa-a477-bc5112d7b00c@redhat.com>
 <u3naomgv34t5rnc7pmyy4zjppgf36skeo45orss2xnqcvtrcez@m74tsl2ws76f>
 <7e62b37d-6c9c-4e55-a01a-175695475cb5@redhat.com>
 <xhsmhedbmbjz5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <620d1b70-cfbc-4b76-ad04-b3be559afd56@redhat.com>
Date: Wed, 03 Apr 2024 18:17:25 +0200
Message-ID: <xhsmh8r1ubeui.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/24 10:47, Waiman Long wrote:
> On 4/3/24 10:26, Valentin Schneider wrote:
>> IIUC that was Thomas' suggestion [1], but I can't tell yet how bad it wo=
uld
>> be to change cgroup_lock() to also do a cpus_read_lock().
>
> Changing the locking order is certainly doable. I have taken a cursory
> look at it and at least the following files need to be changed:
>
>  =C2=A0kernel/bpf/cgroup.c
>  =C2=A0kernel/cgroup/cgroup.c
>  =C2=A0kernel/cgroup/legacy_freezer.c
>  =C2=A0mm/memcontrol.c
>
> That requires a lot more testing to make sure that there won't be a
> regression. Given that the call to cgroup_transfer_tasks() should be
> rare these days as it will only apply in the case of cgroup v1 under
> certain condtion, I am not sure this requirement justifies making such
> extensive changes. So I kind of defer it until we reach a consensus that
> it is the right thing to do.
>

Yeah if we can avoid it initially I'd be up for it.

Just one thing that came to mind - there's no flushing of the
cpuset_migrate_tasks_workfn() work, so the scheduler might move tasks
itself before the cpuset does via:

  balance_push() ->__balance_push_cpu_stop() -> select_fallback_rq()

But, given the current placement of cpuset_wait_for_hotplug(), I believe
that's something we can already have, so we should be good.

> Cheers,
> Longman


