Return-Path: <linux-kernel+bounces-125157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658FF892152
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8723B234DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3885620;
	Fri, 29 Mar 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n8fm4s9G"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7017E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728495; cv=none; b=HBceoGFcy5+7tSVp1Qwvpd0nsPQ9oNR5UJaNh5zA/pRvFZfaRDO2PnNDGnOYZ5Fs+aoAOA5wFj4PFAdgDl17NBpGli8+By+8VzYs+P/+novNcsmDVB0c/Y0BNCJWLGBs7HuX/69YdL0PS3JWPxpnNJjPfqoqRrP9q4pbVKT9EMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728495; c=relaxed/simple;
	bh=ORDMO7iq+qG47Ethl6mIy/3F1xWCTVmKAZEo+I/HjQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfbKEX0PSyuhjiB2ZtaT2aE/O7s1cAjIVerlUjxWqWS1rCYErBhywJ5VEYNE/xaL3UJlvGDZO4KsJHc4KakLlswCyjWeZRIifO1RhhoR9u4P8nD8CoGoh4sq/9JYI6ENuNoC807PHlAypDXUtefJXYGvOe/ZvKyWjbD6O2/QtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n8fm4s9G; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e062f3a47bso128745ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711728493; x=1712333293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjmlQ3HD86lPrX4N3/sKMd9ZFH0zbBs9cXcgFLc2t20=;
        b=n8fm4s9G+feAxDHUibBXslYDeiI0SiPzvFToPgGKl7v1vPxcoWQ7zxJCZhASohW26e
         Uhq7PPFtCSWx0IhHzeWFG6YeP02p5fnuwGk53YrC18xjrsZOUOINSYqEOkWBsdiSY5OJ
         uac/q41GZ1ho0t1ICZrL5WwkzrdtKLQm9TArFi81K58OW9BCqfeAX9CAOKoaBwLOOK7G
         C7Ypg+AL+8JN1cuQl2bI1pQgyvlhDdaeMmy4a8ewuAuVCoUJRcDxvilNXeOGupw3wYmo
         fDv/4MvFCadxy+Ko5cO8xPY0lB/9jdMTq++WLeZms2s0XsP8Cf+zaqCv5UcZNPujNMjH
         PqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711728493; x=1712333293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjmlQ3HD86lPrX4N3/sKMd9ZFH0zbBs9cXcgFLc2t20=;
        b=jum6d0PjCxYNns5n0kUtbT924y1Hq759diIFtlv0E0ExIP3dnM9LgLPX8FOKvxTYAs
         7sgpgMyUNTaRsDOGExJTaTgUbc9nV7sQUy93folhUrdkXZEcWjGldENprula1EpC+Jsy
         XMPywn5rNx0zZQSyIf3q1lheTXTP8WGz59kluG1xl5NBKxJ1DFXDIOY8uydW0OJ+c/kC
         h6TO36GHh2y4UW5EWdcwkLBcBIwoLLbrab+CnZFkHydatwDLgNcMUMCPwoY4KJG3+Jj+
         NRkVHYPReapLO6/oh1q+kzrK1B/GhoQOCHb6e4Idt2Y8KBhywL+zOEquOVr91IyLBC0h
         YeBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNfhKr6UxBYG6wP0KSxlQN/065b0L2v+tuTzbVaCYlkBvdqfdLLvYjnGbkZPCGqYhqOIRGGCig/8SAS74XNJMrkvFpxu0sl2j3r5ax
X-Gm-Message-State: AOJu0YyRrny9/MOhYchajW/CnGnV1CfVXft3tFCtFf77g4JDVVtH2vGs
	niHadgVPUcLmJ9TNPqikdVPek6wV94/PhbMwdYpk3AAF53b2EWKe44U9I/dWGg+gp1Mhl8zoGTq
	MxMtDya3NsGdZp4Yta4sCl9slWDs4sgLAAmxf
X-Google-Smtp-Source: AGHT+IHi6OBA8+HHba49tAMrF0+49yLt28nckztPyAAHs4YZnyDvMq8fTZY26cB8lS7oxNChTnry3NOO6svsqsw+DrI=
X-Received: by 2002:a17:902:f54a:b0:1e2:578:b531 with SMTP id
 h10-20020a170902f54a00b001e20578b531mr217572plf.14.1711728492740; Fri, 29 Mar
 2024 09:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328055857.383180-1-yangjihong@bytedance.com>
 <CAP-5=fXms1noWT8PXqBu89QogcwVsvAGpxq3Q_bNUYOYL7PpKA@mail.gmail.com> <2e44ae50-d4af-4788-9274-aaf345bac066@bytedance.com>
In-Reply-To: <2e44ae50-d4af-4788-9274-aaf345bac066@bytedance.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 29 Mar 2024 09:08:01 -0700
Message-ID: <CAP-5=fWDY9Aj+qHNOuwJ9yE==G=vmCzECXYEZAifOhGHX7yr6w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] perf sched timehist: Fix
 -g/--call-graph option failure
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:02=E2=80=AFPM Yang Jihong <yangjihong@bytedance.c=
om> wrote:
>
> Hello,
>
> Sorry, due to the new email settings, the last reply email was in html
> format, resend it now.
>
> On 3/29/24 00:02, Ian Rogers wrote:
> > On Wed, Mar 27, 2024 at 10:59=E2=80=AFPM Yang Jihong <yangjihong@byteda=
nce.com> wrote:
> >>
> >> When perf-sched enables the call-graph recording, sample_type of dummy
> >> event does not have PERF_SAMPLE_CALLCHAIN, timehist_check_attr() check=
s
> >> that the evsel does not have a callchain, and set show_callchain to 0.
> >>
> >> Currently perf sched timehist only saves callchain when processing
> >> sched:sched_switch event, timehist_check_attr() only needs to determin=
e
> >> whether the event has PERF_SAMPLE_CALLCHAIN.
> >>
> >> Before:
> >>    # perf sched record -g true
> >>    [ perf record: Woken up 0 times to write data ]
> >>    [ perf record: Captured and wrote 4.153 MB perf.data (7536 samples)=
 ]
> >>    # perf sched timehist
> >>    Samples do not have callchains.
> >>               time    cpu  task name                       wait time  =
sch delay   run time
> >>                            [tid/pid]                          (msec)  =
   (msec)     (msec)
> >>    --------------- ------  ------------------------------  ---------  =
---------  ---------
> >>      147851.826019 [0000]  perf[285035]                        0.000  =
    0.000      0.000
> >>      147851.826029 [0000]  migration/0[15]                     0.000  =
    0.003      0.009
> >>      147851.826063 [0001]  perf[285035]                        0.000  =
    0.000      0.000
> >>      147851.826069 [0001]  migration/1[21]                     0.000  =
    0.003      0.006
> >>    <SNIP>
> >>
> >> After:
> >>    # perf sched record -g true
> >>    [ perf record: Woken up 1 times to write data ]
> >>    [ perf record: Captured and wrote 2.572 MB perf.data (822 samples) =
]
> >>    # perf sched timehist
> >>               time    cpu  task name                       wait time  =
sch delay   run time
> >>                            [tid/pid]                          (msec)  =
   (msec)     (msec)
> >>    --------------- ------  ------------------------------  ---------  =
---------  ---------
> >>      144193.035164 [0000]  perf[277062]                        0.000  =
    0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switc=
h <- __sched_text_start <- preempt_schedule_common <- __cond_resched <- __w=
ait_for_common <- wait_for_completion
> >>      144193.035174 [0000]  migration/0[15]                     0.000  =
    0.003      0.009    __traceiter_sched_switch <- __traceiter_sched_switc=
h <- __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
> >>      144193.035207 [0001]  perf[277062]                        0.000  =
    0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switc=
h <- __sched_text_start <- preempt_schedule_common <- __cond_resched <- __w=
ait_for_common <- wait_for_completion
> >>      144193.035214 [0001]  migration/1[21]                     0.000  =
    0.003      0.007    __traceiter_sched_switch <- __traceiter_sched_switc=
h <- __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
> >> <SNIP>
> >
> > This looks good, should there be a Fixes tag for the sake of backports?
> >
> The direct cause is commit 9c95e4ef0657 ("perf evlist: Add
> evlist__findnew_tracking_event() helper"). perf-record uses
> evlist__add_aux_dummy() to replace evlist__add_dummy() to add a dummy
> event. The difference is that evlist__add_aux_dummy() sets
> no_aux_samples to true (this is expected behavior, for dummy event, no
> need to sample aux data), resulting in evsel__config() not adding the
> PERF_SAMPLE_CALLCHAIN bit to dummy's sample_type.
>
> In summary, the direct cause is the problem introduced by commit
> 9c95e4ef0657 ("perf evlist: Add evlist__findnew_tracking_event()
> helper"), but the root cause is the timehist_check_attr() logic problem,
> The dummy event itself does not need to have PERF_SAMPLE_CALLCHAIN, so
> there is no need to check it.
>
>
> So, maybe add fixes-tag:
>
> Fixes: 9c95e4ef0657 ("perf evlist: Add evlist__findnew_tracking_event()
> helper")
>
> If it is ok, I will send v2 version with this fixes-tag.

I think the maintainer can add the fixes tag when they add the reviewed-by =
tag:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Yang

