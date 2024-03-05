Return-Path: <linux-kernel+bounces-92404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7535871FC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626F8283087
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6BB8592A;
	Tue,  5 Mar 2024 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZ4No1tv"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5C8564F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643795; cv=none; b=SMUA1jDM49uF/t7h85iptqYNQ8CVOBl5x5vsGUdIfHHVuu/IwdgPjTeQesUpYGFCNPpvW82TJWiO+BGfX76ZIR7fwf5PLPbyG7VpNiv3Y5S0Txbk7VvnHHjLlDGB7VsVSsgS8rElFz7JGIqc1XjgnkmzU2DzVPtMJx1+KUlPF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643795; c=relaxed/simple;
	bh=FMlR3b4A7+t893mx3XssS4mADLt37ULz5EyCiwBOe4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0YX1SBjgwXIYdTRVa+wHlggObLEIBBuXl7w7/sCFlqc3mi4rzX7PT49ojWc0pZNeH2Jx6DlEGh0q5w3wezduILX0aLVlgCzGE4/AerBNmehRpKqIBdhCUPodKiiET1ya/JroIRGGU8s5MJu1e4n24oOapzSCFM8ZsoyqMCh5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZ4No1tv; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c1e6c32a55so1590314b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709643793; x=1710248593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y03NzawgLsuvVK3dnh3vUuU8cb8xlgzFX71BC6/j7b8=;
        b=LZ4No1tvK71uu2tjL+dv17brKuOvcuW9vbzCz9Cp9Wu+cQrX1kJevpNmyLOqRS1cMz
         VJIyFjp/7iZCoL2PajFjcNTtJVYHVq5BXm3DXNAbS8ek5BLhCtwWoxL+f/bDOscjbEaD
         CkqP1KjDX9PjJGng0Ojp/y17lGoR2Vh+nFrm5i/GbR6mg/cMm9DoUHpyx7UjQaKP4p/5
         GiBd2qjdpeWPYKnCpLlA41/BQ6CGNUYflWf5NWoLpP/NEbpc/VBePMtIKDZh8KmIi5Fl
         /1Zp2k4+tKQxXcAN7YeS4n127lvYUoPNMINBLPwOsgeOKFYhcX4bneIiqSLyalxA0K4Z
         t/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709643793; x=1710248593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y03NzawgLsuvVK3dnh3vUuU8cb8xlgzFX71BC6/j7b8=;
        b=dvyxYNY8J/v9oklhkZNf8kJAN+FMwZfzrs6ldHow7EChlbqynFUd+mVk21mq8EHYdE
         WmeYG7Ov5R4gR3T0ZzUcrPK7Q9y2+ddlpMw4OOH7sIcmSHW2MGtFHap6O/gQTsxm0zPJ
         LkmfMS8d081tqjD0SGsQrL+hPVlrf0oOMTmqtbe5F0VAL3SzHXxfAWCoEggoIMbo76km
         YpNdcqLorFzP4Fj6E7q53b0k8YuigROkVcyOAcfv6FHwK5wwPahuA8SID0kOjD4Y3kid
         moJDI7BfxqGA5tN/StiTpFIDTVYIomUwBk7G0eHMvSa6T4mUBPoqhk8sKiY0qzGlaD94
         rwbg==
X-Forwarded-Encrypted: i=1; AJvYcCVBwb/k/i56cor8A65QsBYz1rB9MKY6TgRbJ7Ae8gnUPW0OLNaIDfX8SAO1tq0NmB5gfDu05V4MdWMYLBOl9Tqh/vLfM1Loz6CYUM6U
X-Gm-Message-State: AOJu0YwdmUk7HtcnpE6hIdLHtdiLV1OUSyqd1Zk+rQYG5HawUrfKR5qz
	jTZ4MJQZf2FSR2pPF1oY3GtwJLdDsBTTrkbXh8SD4U5ttONe1KK86TGzwGKI/hlmNumg8HqO8YH
	mWLfI6XJImXF+ucSBtifX014xGVITVIdvVVm8
X-Google-Smtp-Source: AGHT+IEjB+D36pPsTT+GfJa0+YlKEbqMGVHKFQ8yEGj0UDz27soUzs9SaKjQOp1hKs2S/ESVzH4SX6uDdxrplqFQxuw=
X-Received: by 2002:a05:6808:1597:b0:3c1:ae52:6f91 with SMTP id
 t23-20020a056808159700b003c1ae526f91mr1799803oiw.58.1709643792910; Tue, 05
 Mar 2024 05:03:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403051032.e2f865a-lkp@intel.com> <ZeblmHyVlxl_6HGC@localhost.localdomain>
In-Reply-To: <ZeblmHyVlxl_6HGC@localhost.localdomain>
From: Marco Elver <elver@google.com>
Date: Tue, 5 Mar 2024 14:02:35 +0100
Message-ID: <CANpmjNMOazCrzJr+Ckx0vM73P86dPM_0qbcv=Nu44jUtPERD+A@mail.gmail.com>
Subject: Re: [linux-next:master] [mm,page_owner] 4bedfb314b: BUG:KASAN:null-ptr-deref_in_init_page_owner
To: Oscar Salvador <osalvador@suse.de>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 10:26, Oscar Salvador <osalvador@suse.de> wrote:
>
> On Tue, Mar 05, 2024 at 02:08:23PM +0800, kernel test robot wrote:
> >
> > [    6.582562][    T0] Node 0, zone    DMA32: page owner found early allocated 0 pages
> > [    6.612136][    T0] Node 0, zone   Normal: page owner found early allocated 73871 pages
> > [    6.612762][    T0] ==================================================================
> > [ 6.613351][ T0] BUG: KASAN: null-ptr-deref in init_page_owner (arch/x86/include/asm/atomic.h:28)
> > [    6.613893][    T0] Write of size 4 at addr 000000000000001c by task swapper/0
> > [    6.614434][    T0]
> > [    6.614600][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G                T  6.8.0-rc5-00256-g4bedfb314bdd #1 29e70169ace75ef72d53825e983f3dcb1d5756d9
> > [    6.615605][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    6.616367][    T0] Call Trace:
> > [    6.616604][    T0]  <TASK>
> > [ 6.616816][ T0] ? dump_stack_lvl (lib/dump_stack.c:?)
> > [ 6.617161][ T0] ? print_report (mm/kasan/report.c:?)
> > [ 6.617499][ T0] ? init_page_owner (arch/x86/include/asm/atomic.h:28)
>
> So, we are crashing here:
>
>         /* Initialize dummy and failure stacks and link them to stack_list */
>         dummy_stack.stack_record = __stack_depot_get_stack_record(dummy_handle);
>         failure_stack.stack_record = __stack_depot_get_stack_record(failure_handle);
>         refcount_set(&dummy_stack.stack_record->count, 1);
>         refcount_set(&failure_stack.stack_record->count, 1);
>
> when trying to set the refcount. Allegedly, because dummy_handle is 0.
> I thought we fixed that with
>
> commit 3ee34eabac2abb6b1b6fcdebffe18870719ad000
> Author: Oscar Salvador <osalvador@suse.de>
> Date:   Thu Feb 15 22:59:01 2024 +0100
>
>     lib/stackdepot: fix first entry having a 0-handle
>
>
> But I guess this is different.
> The obvious way out is to only set the refcount and link the stacks
> if their handles are not 0.
>
> Marco, could it be that stackdepot was too overloaded, that by the time
> page_owner gets initialized, there are no more space for its stacks, and
> hence return 0-handles?.

That's possible. But it's unclear to me what exactly happens. Are you
able to reproduce the issue? (I haven't been able to because the
config enables CFI which seems to cause other issues for me,
presumably toolchain related. :-/ )

