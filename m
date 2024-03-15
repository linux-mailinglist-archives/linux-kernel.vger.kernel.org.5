Return-Path: <linux-kernel+bounces-104969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA7987D6C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825FAB2103D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAD05A0E8;
	Fri, 15 Mar 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="NuG1v4kN"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ABD59B67
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710542539; cv=none; b=arDb1EiPA1ZDy8u+SldODf8zMSqw20G4xCCuGm4OEWjjvcOso1Bw2O8yjQk5WrpLuXTBL2kWvTl2/iqn+vMrbW+S1T9BWlYBaCKzdJUzOFgrtFRROkaefFPCVWpHfT2xCvrRj3QknmqNTAWnCk8pNvyGyGjV3opXlsL+NQCECDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710542539; c=relaxed/simple;
	bh=9aTC8xKicnal5qtnDL3cjqNci//gvsNOASreQ2FWddk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAbgYwmvxWyWORAY2rwOl/gDrfV5wXt3H3cXmdnFL7dPAWybnh426KpdE1j70acJJPxgHtq82XZxmBQABmtHOJpQnMR1J+/KHA1nTikQWj1l5uHwbXaNaMY3i5rQkNF6ho6MSEwrlsY4mPUAZ+afAHL4yxozwh1EimIv/90BBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=NuG1v4kN; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cbfa0796e8so36973639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710542534; x=1711147334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsRqTXgMaYQKprnwZS46sKtunWtNyYt/xYWjCFRYquc=;
        b=NuG1v4kN0tBNM8FYruKU8M5f/mqN01+dXs/ZiwkD3SyRgzyIcBPzyUKEiCnzcT5Zhn
         Gnnbzhlio4SeWTNsxFlj8zgWvLreRGORREl4v+nrDWiUbAljBMiyD2WekGJWqleN6bHo
         42CwjqS6jRNLV9etWkx8479k0SF79AMR/q6fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710542534; x=1711147334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsRqTXgMaYQKprnwZS46sKtunWtNyYt/xYWjCFRYquc=;
        b=e4gojX6oKzLz5LnfKhcKCD4rxZBENp/7HI6zjMD1CyxN6Qcu+6Aw/6AFbulKPfCLB2
         O59AQ5qZLi4uyRD6dIpbMGvGhQBs3bG32Nywgc9NUYhxnoj2Uep2/TGpID+24KNJ5/nG
         G9tb17MIEmLVJS3uDFOFi/GjJoIWyE1tbZRG/pb7OvGjbqNEI6b85Y79RdCHbqkA3+6s
         cdNYnJX2NY7h3D56+v3yxyMOLTD8erWnNle0vMXnPuvhok/WKM5EN+nP81Dqrm9KF1B+
         cJ/4TE4QDGhB7RbfMO3apCKYFia8MIb8cVV3cNdFA5meukDrfTySIDjF3BMZQ0Up10KY
         51hA==
X-Forwarded-Encrypted: i=1; AJvYcCV8j+ZsB6CJRglE66NurZ110LeAe19gKABohUQQWXjgP5X+W1nkW+lqsb6KtbA0i+IJSumPc91SKtQ8ZcZ2tmU2EPzoDKNgi4tk/xkJ
X-Gm-Message-State: AOJu0YziE4y2nIS7UxIrrz/SWweC/rS/3oiirIKEkBb6a5fj5ktMkuB9
	GVBHdxOF5g8hXNzsGX2J4kleF4oV9btesaTpWrgG2b0lwb4uk/+XPCqb2jZGxds=
X-Google-Smtp-Source: AGHT+IGfhVeqIsZOso6gswm+yxDMnUr35mGAJUjS8wARQgdmrfpH74HsobqMOyD3K0gWlSYbttz7rw==
X-Received: by 2002:a6b:4f17:0:b0:7cb:f1d0:a1cc with SMTP id d23-20020a6b4f17000000b007cbf1d0a1ccmr3704914iob.4.1710542533892;
        Fri, 15 Mar 2024 15:42:13 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:80e2:186e:c8ca:d2a2])
        by smtp.gmail.com with UTF8SMTPSA id w25-20020a029699000000b00474350caf1asm958836jai.175.2024.03.15.15.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 15:42:13 -0700 (PDT)
Date: Fri, 15 Mar 2024 16:42:12 -0600
From: Jose Fernandez <josef@netflix.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH bpf-next 1/2] bpf: add btf_task_get_cgroup_id kfunc
Message-ID: <20240315224212.sinyco7bxbnlgw2e@SlimPro9i>
References: <20240315182804.216081-1-josef@netflix.com>
 <ZfSYiWcE0_au_ZPt@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfSYiWcE0_au_ZPt@google.com>

On 24/03/15 11:50AM, Stanislav Fomichev wrote:
> On 03/15, Jose Fernandez wrote:
> > This patch enhances the BPF helpers by adding a kfunc to retrieve the
> > cgroup v2 ID of a specific task, addressing a previous limitation where
> > only bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
> > particularly useful for scenarios where obtaining the cgroup ID of a
> > task other than the "current" one is necessary, which the existing
> > bpf_get_current_cgroup_id helper cannot accommodate. A specific use case
> > at Netflix involved the sched_switch tracepoint, where we had to get
> > the cgroup IDs of both the previous and next tasks.
> > 
> > The bpf_task_get_cgroup_id kfunc returns a task's cgroup ID, correctly
> > implementing RCU read locking and unlocking for safe data access, and
> > leverages existing cgroup.h helpers to fetch the cgroup and its ID.
> > 
> > Signed-off-by: Jose Fernandez <josef@netflix.com>
> > Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
> > ---
> >  kernel/bpf/helpers.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index a89587859571..8038b2bd3488 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2266,6 +2266,27 @@ bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
> >  		return NULL;
> >  	return cgrp;
> >  }
> > +
> > +/**
> > + * bpf_task_get_cgroup_id - Get the cgroup ID of a task.
> > + * @task: The target task
> > + *
> > + * This function returns the ID of the task's default cgroup, primarily
> > + * designed for use with cgroup v2. In cgroup v1, the concept of default
> > + * cgroup varies by subsystem, and while this function will work with
> > + * cgroup v1, it's recommended to use bpf_task_get_cgroup1 instead.
> > + */
> > +__bpf_kfunc u64 bpf_task_get_cgroup_id(struct task_struct *task)
> > +{
> > +	struct cgroup *cgrp;
> > +	u64 cgrp_id;
> > +
> > +	rcu_read_lock();
> > +	cgrp = task_dfl_cgroup(task);
> > +	cgrp_id = cgroup_id(cgrp);
> > +	rcu_read_unlock();
> > +	return cgrp_id;
> > +}
> >  #endif /* CONFIG_CGROUPS */
> >  
> >  /**
> > @@ -2573,6 +2594,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
> >  BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_task_get_cgroup_id, KF_RCU)
> 
> Any reason we are not returning 'struct cgroup' pointer? That should
> allow using other kfuncs that are all 'struct cgrop' based as well.

Returning the cgroup pointer would make this kfunc more flexible, agreed. 
My intention was to make the kfunc more user friendly by returning the cgroup ID, 
but I can see how it would be beneficial to have the cgroup pointer as well. 
I'll update the patch to return the cgroup pointer.

