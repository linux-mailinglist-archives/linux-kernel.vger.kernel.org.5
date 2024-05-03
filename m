Return-Path: <linux-kernel+bounces-167126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0446B8BA4BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670061F22AB3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29959F510;
	Fri,  3 May 2024 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvJdKPvT"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCDAE556
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697892; cv=none; b=sr28gRbZaW9fxQgmhDq05FZQRfxs0+spyeVhfckUTP2oIMIlTljs55QuGmL+bZuI2uTesZdGdj55DQ8sC9yzheB6Q31neBM9uYdjSsAO68aQ5EXrX/zRtWqlYUgvmD9RYXIAduO1ZFcBnrMr106TuFPiX9FxVcxlSaCfr38dRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697892; c=relaxed/simple;
	bh=91Dfm01knwvPbmaIVdIV3JLbaaYPHycwfWHt/+jD++8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZC9ommOdbYrYSTopv20jiqjUxxVWGRETqMAo1AdKxODbUt43v1YM8a23ll0j8XYv+ji/nymRDmJZfMZOb/q2cNFrnffaQd136Axy8yAXIZV7xfLnYwiYlVLIuAF3XStqoBnWIMhwf1HSIAQ0GRZRleAYmZ2NzMzqXoyanj4y44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KvJdKPvT; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-439b1c72676so158621cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714697890; x=1715302690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu/Iz/dAMUjaxd9jmVYTC2Y3lCKhZRQ76joBN91gdNA=;
        b=KvJdKPvTExB7djESZim61U0r0wsdBgRGWnxPBFT62P2+50QVa6WiygXDdmhyjl2bm5
         ODX6hQBYrJMNNsvhWvvZ/4Eq04sXfqTVftw+cwp7yTxdAul8W0RsVftMM7lSfsQ5HKKq
         hC6UUFyxYjc8aCzNM+slawglnFHe9phI72cDJQ4Dcr9Gk3Z7PQO4t65vVpddpBAtasFf
         4HZesr8Lkvd7Zxf8DF2Nz9g9BMdbYk6AMd57ZCUJe2mn3TjtABnk/xqkj+AQ0Cso7QNG
         AFx/fRPuQ133/1DoHB5WWlwci5m7Ob5zER7GPZOHxYRV0GmPk4DXqhjgTo/W5M+e5zdR
         jX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714697890; x=1715302690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zu/Iz/dAMUjaxd9jmVYTC2Y3lCKhZRQ76joBN91gdNA=;
        b=Fj+V9oRz7pboSbvNfAIGC1Y6MaUxwm60ZjiGn0Wjri/Io4GOSrFTUjruy7dqptbYTd
         cZnyYNsqE1YLRuG69QpF8/BFHPL80cANpL48EF3/4joSZLm9on/rDBJHC9LnM3ww2TPd
         HV76Z82vVc3YBH/hdgvlOFSxryCxEiUwqqbNT3B5xV6TIj8X9EhIhzQwCqf1IRojCg+x
         K4+qCF8MzuHtHezXut6v7boipqqFLU/DxF109xlWmQZ7xfIMJlOym2AAL9ipN/LFiW2v
         hoJa7W8rI7OnlyaeAp9hTV74m/kT+bn89ndj4Ng1jR+uSKtYXqbHed2MPENZQsdN09OM
         vNYA==
X-Forwarded-Encrypted: i=1; AJvYcCXQUrmhXyheHT48NclA2c9AMQZ0px08axbKsPuRQuk1dFm2JCXMwFzUAYuD3KFrxMZX7ByqIHYwbGCTqGiT8dlRZmYmJlpuzVlJFfL4
X-Gm-Message-State: AOJu0YxWMTMvnepEJk5TLX5Rxlhokds9jtOGP3oFfCo2m4yf5rgbkeEI
	719SpHC5egE6olapLN2A66s+nlirlC8XDleOZCkvjk8UYqv/dbHCHXgTuQH45SrWUwh5J7v8E+l
	emuX+TJESdhg5sNDe6uKWpl+zsjI6nAiai5qk
X-Google-Smtp-Source: AGHT+IHtormWyn3Q/Jcqq3O7SbSkTVAZEVcwlqPQ9WqkqBkv3JLJpsdmKwOJZ4e3Mg9C7sA+qyRSuKppvzCRvCUjJP4=
X-Received: by 2002:ac8:7e84:0:b0:43a:b547:9f7a with SMTP id
 d75a77b69052e-43cd71b1567mr1387091cf.22.1714697889514; Thu, 02 May 2024
 17:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711674410.git.babu.moger@amd.com> <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
 <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com> <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
 <6edffe1b-e9a9-4995-8172-353efc189666@amd.com> <ab2a6a4b-3740-47c6-9443-e6bb7a0c1adb@intel.com>
In-Reply-To: <ab2a6a4b-3740-47c6-9443-e6bb7a0c1adb@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 2 May 2024 17:57:58 -0700
Message-ID: <CALPaoCiYFKeASPMDwzzaHLw4JiMtBB6DTyVPgt0Voe3c3Tav_A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, corbet@lwn.net, fenghua.yu@intel.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Thu, May 2, 2024 at 4:21=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter and Babu,
>
> On 5/2/2024 1:14 PM, Moger, Babu wrote:
> > Are you suggesting to enable ABMC by default when available?
>
> I do think ABMC should be enabled by default when available and it looks
> to be what this series aims to do [1]. The way I reason about this is
> that legacy user space gets more reliable monitoring behavior without
> needing to change behavior.

I don't like that for a monitor assignment-aware user, following the
creation of new monitoring groups, there will be less monitors
available for assignment. If the user wants precise control over where
monitors are allocated, they would need to manually unassign the
automatically-assigned monitor after creating new groups.

It's an annoyance, but I'm not sure if it would break any realistic
usage model. Maybe if the monitoring agent operates independently of
whoever creates monitoring groups it could result in brief periods
where less monitors than expected are available because whoever just
created a new monitoring group hasn't given the automatically-assigned
monitors back yet.

>
> I thought there was discussion about communicating to user space
> when an attempt is made to read data from an event that does not
> have a counter assigned. Something like below but I did not notice this
> in this series.
>
> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> Unassigned
>
> >
> > Then provide the mount option switch back to legacy mode?
> > I am fine with that if we all agree on that.
>
> Why is a mount option needed? I think we should avoid requiring a remount
> unless required and I would like to understand why it is required here.
>
> Peter: could you please elaborate what you mean with it makes it more
> difficult for the FS code to generically manage monitor assignment?
>
> Why would user space be required to recreate all control and monitor
> groups if wanting to change how memory bandwidth monitoring is done?

I was looking at this more from the perspective of whether it's
necessary to support the live transition of the groups' configuration
back and forth between programming models.  I find it very unlikely
for the userspace controller software to change its mind about the
programming model for monitoring in a running system, so I thought
this would be in the same category as choosing at mount time whether
or not to use CDP or the MBA software controller.

Also, in the software implementation of monitor assignment for older
AMD processors, which is based on allocating a subset of RMIDs, I'm
concerned that the context switch handler would want to read the
monitors associated with the incoming thread's current group to
determine whether it should use one of the tracked RMIDs. I believe it
would be cleaner if the lifetime of the generic monitor-tracking
structures would last until the static branches gating
__resctrl_sched_in() could be disabled.

>
> From this implementation it has been difficult to understand the impact
> of switching between ABMC and legacy.

I'll see if there's a good way to share my software monitor assignment
prototype so it's clearer how the user interface would interact with
diverse implementations. Unfortunately, it's difficult to see the
required abstraction boundaries without the fs/resctrl refactoring
changes[1] applied. It would also require my changes[2] for reading a
thread's RMID from the FS structures to prevent monitor assignments
from forcing an update of all task_structs in the system.

-Peter

[1] https://lore.kernel.org/lkml/20240426150537.8094-1-Dave.Martin@arm.com/
[2] https://lore.kernel.org/lkml/20240325172707.73966-1-peternewman@google.=
com/

