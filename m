Return-Path: <linux-kernel+bounces-146505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E88A6642
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D4C1F22628
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A4484D10;
	Tue, 16 Apr 2024 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FE6QZv0L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A97205E10
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256586; cv=none; b=ZLCUDBr29stSPyrkPXbAAfwMXzJoWLJWhQUicaTxXfrD3xr2ZBvujQSQCUWzjtgzkfwtsxWx388AJjwq+rfcsyFFvzy9vowE6876yQ+vI3E56I0o9Lm84z595fJaxQWudlmlBW2J2uFyTqzh2XQ2DSrpFat4Be3LoSLDS3wbuHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256586; c=relaxed/simple;
	bh=aOdBoB93vxsijvwYVSFBSNuBZpGDotBJXt9pWDSyh08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b3SPXGptO69wIrHE4AOYqsmK3hAbJZcnyPVe5sIcYzG4w0OxR0VTHJlO/N9vSntDN3/cjF+mwBKN2hseWPuOU4hNPBZYTiEyyBFgf8cObGsneXaC10Gd9hEFZUFHmjd0ZdPeqGCN6ol18YVnq6THnfuVr0xfEGMtrdy8RKJdIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FE6QZv0L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713256583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9h0BHooKT4d+s5o9CfTkWVc8WVyWweFWg1hgv32sDw=;
	b=FE6QZv0L1XKaDOlCFSV7y4DpVQQJixf0uVUYzVq3Fc3Ykoo9gmqXvmATZOfTQLMpAhGDra
	NVLk07LcZnvD0CA0Je2U6WliyfA+vKSCP/1Gyh+Hl+WWh7SkLwYPnzUpBKipph2aX1GK+x
	0yOYRhjWUoeSkX8PDRnICl2UAzXuOVk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-T-yOrPNoMz-hJSJBQv5emw-1; Tue, 16 Apr 2024 04:36:22 -0400
X-MC-Unique: T-yOrPNoMz-hJSJBQv5emw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a51a2113040so261254866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713256580; x=1713861380;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9h0BHooKT4d+s5o9CfTkWVc8WVyWweFWg1hgv32sDw=;
        b=TBSRNxcdX8Tg7z05Y5+SO21QdUEkTA3vPX2y/hSdjWMSdigl+/EfqY91KFD4umZ02W
         coejj7i7eJUpjmb9Cm4iM+/QH26QmKbjD7Un/nnm4KAa264XgosSSqphTwgye98c/xci
         po8+hEi0vh63g5fzCr9EOszlsVeCi3TeUGtdSiH+/K2CVTiKKF7ZgHzGMgE4cfyI2Knz
         RM1Flgy3AlgG1dXkQgth6BUGK+Ae2LbmMMEJUWPeu9n1x+ecsRjFZxaBM/+5SdVEKfbo
         jSSxz06vSAfZbNjrOO6W9X29uCkM18rQcikOFibiUtcKlEpUpX6eLA6h8/F4d4F5BiSw
         RPMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNAMQCG3hNSdcCu58r5EYgx+HUGUOq3cehVRAXU7Qu/49BPHtk1j49hW0YegjMj2qmfbbjlB7zP1DJEV7T9Mqrk23axHaLfS8giVaU
X-Gm-Message-State: AOJu0YyXf1U6xrz72hKWrr/n4CDyCpZCpKVyrdAmFcJqntyiZDCfIv8f
	ISaO/XhmC4klp8pfDibn2fBShUqlk+4dozXpgHeFFK2e/lYpo7IlBC8GzBf7GnLdCWeiC7pEO2W
	IRwG5KauuOcdyQSJduPODIBwCkV5hrh5UAKUCQqh5V4NjClfkKE+WENQ+eyyEW6Y++Cj47Q==
X-Received: by 2002:a17:906:fd89:b0:a52:24b7:b4fc with SMTP id xa9-20020a170906fd8900b00a5224b7b4fcmr9803962ejb.72.1713256579929;
        Tue, 16 Apr 2024 01:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcUTY/qJBHlbwy/q1b5NbiJban9UANxl5bmP8c8RwUfPyqxenDNL5DXXGruVveAU0+G2ypgw==
X-Received: by 2002:a17:906:fd89:b0:a52:24b7:b4fc with SMTP id xa9-20020a170906fd8900b00a5224b7b4fcmr9803942ejb.72.1713256579538;
        Tue, 16 Apr 2024 01:36:19 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090624ca00b00a46a2779475sm6490570ejb.101.2024.04.16.01.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 01:36:19 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 2/2] context_tracking, rcu: Rename RCU_DYNTICKS_IDX to
 CT_DYNTICKS_IDX
In-Reply-To: <Zh2XRgIGDILD6u7Q@pavilion.home>
References: <20240327112902.1184822-1-vschneid@redhat.com>
 <20240327112902.1184822-3-vschneid@redhat.com>
 <Zg6tYD-9AFPkOOsW@localhost.localdomain>
 <1ef9d1f9-16a2-4ddc-abd5-6c3b7cde290f@paulmck-laptop>
 <ZhZqX0YqlzPoOK2b@localhost.localdomain>
 <af3eed7e-a889-4008-ba47-045483ab79fc@paulmck-laptop>
 <xhsmhjzky8tww.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Zh2XRgIGDILD6u7Q@pavilion.home>
Date: Tue, 16 Apr 2024 10:36:18 +0200
Message-ID: <xhsmhh6g1901p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15/04/24 23:08, Frederic Weisbecker wrote:
> Le Mon, Apr 15, 2024 at 06:36:31PM +0200, Valentin Schneider a =C3=A9crit=
 :
>>
>> Sounds good to me too, thanks for the suggestion :)
>>
>> Now, what about ct_dynticks() & friends? I was about to do:
>>
>> -static __always_inline int ct_dynticks(void)
>> +static __always_inline int ct_rcu_watching(void)
>>  {
>> -	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICK=
S_MASK;
>> +	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WAT=
CHING_MASK;
>>  }
>
> Yup!
>
>>
>> ... but then realised that there's more siblings to the rcu_dynticks*()
>> family;
>
> Ouch right, sorry I forgot there is so much of this namespace. But in cas=
e you're
> willing to clean that up:
>

While I'm at it, I figure I might as well.

>>
>> AFAICT dynticks_nesting could also get the rcu_watching prefix treatment,
>> `rcu_dynticks_task_exit() -> rcu_watching_task_exit` doesn't sound as
>
> rcu_tasks_exit() ?
>
> But Paul, is there a reason why check_holdout_task() doesn't check
> ct_dynticks_cpu(task_cpu(t)) instead of maintaining this separate counter?
>
>> obvious though. The rcu_dyntick event probably can't be renamed either.
>
> I think we can rename trace_rcu_dyntick() to trace_rcu_watching()
>
>>
>> I'm not sure how far to take the renaming; seeing things like:
>>
>>   notrace bool rcu_is_watching(void)
>>   {
>>           bool ret;
>>
>>           preempt_disable_notrace();
>>           ret =3D !rcu_dynticks_curr_cpu_in_eqs();
>>           preempt_enable_notrace();
>>           return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(rcu_is_watching);
>>
>> makes me think most of the rcu_*dynticks / rcu_*eqs stuff could get an
>> rcu_watching facelift?
>
> The eqs part can stay as-is. But the *dynticks* needs an update.
>
>>
>> Here are my current considerations for identifiers used in context_track=
ing
>> in decreasing order of confidence:
>>
>> | Old                                   | New                           =
                                |
>> |---------------------------------------+-------------------------------=
--------------------------------|
>> | RCU_DYNTICKS_IDX                      | CT_RCU_WATCHING               =
                                |
>> | RCU_DYNTICKS_MASK                     | CT_RCU_WATCHING_MASK          =
                                |
>> | context_tracking.dynticks_nesting     | context_tracking.rcu_watching_=
nesting                         |
>
> This can be context_tracking.nesting (and yes one day we might need to lo=
ck up
> context_tracking.nesting and context_tracking.recursion together in a roo=
m and see
> who wins after a day or two).
>

Much better!

>> | context_tracking.dynticks_nmi_nesting | context_tracking.rcu_watching_=
nmi_nesting [bit of a mouthful] |
>
> context_tracking.nmi_nesting
>
>> | rcu_dynticks_curr_cpu_in_eqs()        | rcu_watching_curr_cpu() [with =
an added negation]              |
>
> Nice!
>
>> |---------------------------------------+-------------------------------=
--------------------------------|
>> | TRACE_EVENT_RCU(rcu_dyntick,          | [Can't change?]               =
                                |
>
> It can change. Officially trace events aren't ABI. Unoficially I wouldn't=
 dare
> changing the sched switch trace event but this one is fine.
>

Cool, away it goes then :)

>> |---------------------------------------+-------------------------------=
--------------------------------|
>> | rcu_dynticks_task_enter()             | rcu_watching_task_enter()> | |
>
> rcu_tasks_enter() ?
>
>> | rcu_dynticks_task_exit()              | rcu_watching_task_exit()      =
                                |
>
> rcu_tasks_exit() ?
>
>> | rcu_dynticks_task_trace_enter()       | rcu_watching_task_trace_enter(=
)                               |
>
> rcu_tasks_trace_enter()?
>
>> | rcu_dynticks_task_trace_exit()        | rcu_watching_task_trace_exit()=
                                |
>
> rcu_tasks_trace_exit() ?
>

Now that you point it out, it looks obvious!

> Thanks.
>
>>
>> Thoughts?
>>


