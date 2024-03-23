Return-Path: <linux-kernel+bounces-112500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39026887A92
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3551C20DC6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8A5B200;
	Sat, 23 Mar 2024 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3k5gHlo"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A118659;
	Sat, 23 Mar 2024 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711231956; cv=none; b=G5RcEg8x80dITguMftYwm0PUurWdEwCZfNB+bNbt6UEzwahMarhZ9NDaID3Die+4CKsFRpj7CDEG+5xv4WLYKVUtxMRHADcilRD0o6bU6MFUlOCOrT5euaffNqbVDXHQyp3TeyetMEquhI6YKmUcTsBuVXANavucQAWnP0JlZk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711231956; c=relaxed/simple;
	bh=+w2LWyzhDiU+fkl3eoRQq4N33UvdbLTApNlnfEU+umQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLz/yx1V/4LGpbTC9F029nf/nPzyZnHw0WrXcnOalmpCexEyo5cvGXayV3ycEq589bC+NVEaJSQTw8iAUXzqcTJKYWjeG5TYrE6jpOyoH2FDNUqVYBSU/zGJbFi3iil4PUSt0jQBlPbXaAVrz4tGtUPeDPygjkeRUfODHndFBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3k5gHlo; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-229d01e81f1so1409360fac.2;
        Sat, 23 Mar 2024 15:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711231953; x=1711836753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUQfSvPxag9be1AUK+j/uLuzcbF/ngEqoqA8jQzMsz4=;
        b=h3k5gHloSSUTkeJJR20J7ewvTFJCGvLOa/flTm61ggEhbOuaAlr051jx9cI03xJVQN
         MswC9a6EWqKamKkYNmTMfcR0u6+8X9gD5edXKD/FB/igKQt4uLk+qz0MlB7M4eoS4pra
         CUSbyI6dZ0cmotGZsA+IBJQfudoa9px3+PxDpWXm1O3A53BfNJf5vpd0jIkEqLpJXaje
         NLPL3hLvRfI4pJ8fsZeVqHIkwpffo5pPEApqDrRLnkUINYnphy/EycbQKYKtGtHMmaQY
         aw/qhLCpivTIy5FaT1+erRWAFIMb2noV5f55igHSXT7tY2xCrhkDI1/00HV09eidtNTs
         0rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711231953; x=1711836753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUQfSvPxag9be1AUK+j/uLuzcbF/ngEqoqA8jQzMsz4=;
        b=oiUSOO9PwslSZXPmO91q3rmnuwBcuN6qhb2KDZKjJNlWxZlp20GmlICqa5bAKkGcpt
         881IzxhX88PXDLBC8BWq7V0koQ+864DT9XZqbw8sYmMHC011ob3roQP64hKV9rWVJnHI
         ffYhMup7GxPEWs3eO1ePhrS8oRkyDCLnwfwSRzd974QM8TlghaNml03qezs8onjJWTOa
         jbyB2AfbA8STLX/kqmtR8rdAt3kkfuEPI8BjjMGQ6Vivneu87+n36Mj6mxMVF/C+MCbk
         uwMdKw00bAkO6uWUlvHw+5SVa6Rp/s+X3cGno4T4wbdYYY2VGYM+D0EaT0rlIPBVTLUa
         g8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWBowWmUa6GW8erM77n3AnbReq7BwIBV4aHC09EmA60Vj9cBDk1kroYYg7/TOlAxgjFJy7VKSLdAk/v4++8s6AwBApRar7XEECJPmiMwHn6agqA5LzGqX5dKNQZDpTOLvt4
X-Gm-Message-State: AOJu0Yx6bqdXupaGwhynDUu8o7sKfFykmIPab76TacpywHVnoMBfyO74
	I2lK57tHhtzIP+PoHPyoqpfoWjCiVZ1pKe8DI9B5vjVC2lGuo4xd
X-Google-Smtp-Source: AGHT+IGRKjl7+/dAQb+CzvOyVBvpQFIlYccclDcIBJZt5gpKTYID1TLgx79IJLdMadVpPyuExjhivA==
X-Received: by 2002:a05:6870:14ce:b0:21f:1fcf:8c24 with SMTP id l14-20020a05687014ce00b0021f1fcf8c24mr3778120oab.57.1711231953364;
        Sat, 23 Mar 2024 15:12:33 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id y8-20020a056a00180800b006ea97dc8740sm1580988pfa.78.2024.03.23.15.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 15:12:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 23 Mar 2024 12:12:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Andrea Righi <andrea.righi@canonical.com>
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
Message-ID: <Zf9Tz2wHT6KYtqEG@slm.duckdns.org>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org>
 <20240323023732.GA162856@joelbox2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323023732.GA162856@joelbox2>

Hello, Joel.

On Fri, Mar 22, 2024 at 10:37:32PM -0400, Joel Fernandes wrote:
..
> I was wondering about the comment above related to 'wakeup_preempt', could
> you clarify why it is not useful (NOOP) in the sched-ext class?
> 
> wakeup_preempt() may be called via:
> sched_ttwu_pending() ->
> 	ttwu_do_activate() ->
> 		wakeup_preempt()
> 			
> 
> at which point the enqueue of the task could have already happened via:
> 
> sched_ttwu_pending() ->
> 	ttwu_do_activate() ->
> 		activate_task() ->
> 			enqueue_task()
> 
> But the comment above says "task isn't tied to the CPU" ?

In sched_ext, a scheduling queue isn't tied to a particular CPU. For
example, it's trivial to share a single global scheduling queue across the
whole system or any subset of CPUs. To support this behavior, tasks can be
hot-migrated in the dispatch path just before it starts executing:

 https://github.com/sched-ext/sched_ext/blob/sched_ext/kernel/sched/ext.c#L1335  

So, the CPU picked by ops.select_cpu() in the enqueue path often doesn't
determine the CPU the task is going to execute on. If the picked CPU matches
the CPU the task is eventually going to run on, there's a small performance
advantage as the later hot migration can be avoided.

As the task isn't actually tied to the CPU being picked, it's a bit awkward
to ask "does this task preempt this CPU?" Instead, preemption is implemented
by calling scx_bpf_kick_cpu() w/ SCX_KICK_PREEMPT or using the
SCX_ENQ_PREEMPT flag from the enqueue path which allows preempting any CPU.

> Apologies in advance if I missed something as I just recently starting
> looking into the sched-ext patches.

No worries. Happy to answer any questions.

Thanks.

-- 
tejun

