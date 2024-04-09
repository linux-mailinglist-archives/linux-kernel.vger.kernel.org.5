Return-Path: <linux-kernel+bounces-137645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4901089E4EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74282820D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9D9158A29;
	Tue,  9 Apr 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GkNdKHWp"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20FC158878
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698142; cv=none; b=SIwagr/B0APoMFSMe9RWkq8qQUGkQYw17kSj6X+qt2GxcV3tK02RsgEemQkgnEBjv5gqdGXKHnU+9hftZAv3WSUtYXDIqSjsBUu4Kc3o3OZVxJvmihxWx/8IpNvFbDW20Jth5Mh4odHNOkVRL7KPUB3Fwu1+yPue7s/27kQ+6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698142; c=relaxed/simple;
	bh=cpqL+Hl6DXpr8zMLQSAXCRUte3LWhQQIiqBnOCk+8q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKki1t9Vcjsgi8+Sg/508YuXSrl97fGN487g8LLKKyoSVEXgOayrLRD3mNHNGaXveyUgMyf+0H/KYC5T1VCkcA9RBMXVjGKta/OXGqf58DClel24gw24Pe0vIH6q++tptTAmSFe4ZETbKPPMU59w+hARKhCUlVo+OIQhFvvwOx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GkNdKHWp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3f6f03594so18847345ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712698140; x=1713302940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1EckUdhv2S0vsLHXrSpPAoBKrsnqtVxE+FzPaDR/vQ=;
        b=GkNdKHWpHzVRjHUHYaa4Dz17qLR3IeF9Tm3SDpo2v/aWhb7gJnJGowGCG4ac0B+LJ4
         YYpujhGFRCPEt/Mmc3jdRKWklWg1gtLO+oOS9PNMAfUmAetioAxVQN7FesJtnQQ8Vx4v
         ochJCC9jTAVkYqqudrXye+NxGkAK0vkfJyqpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712698140; x=1713302940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1EckUdhv2S0vsLHXrSpPAoBKrsnqtVxE+FzPaDR/vQ=;
        b=C1KnVEPwDdXpGLEBHbEA21AbB1rgehnQYuoYX7MaTYc9VkV+FatYWCKO5NDiTUQAe/
         SomMZHTgD2w5SpDWdomUj8nv9lyIdBfKazx+vjvGgkkk/2kCbPniNCO+PbICahung318
         8BCqVz/wr/NTjoYRPx7Byb6vxosDZamja04dsO84MYZx2ngCa4sv4YRabsqc2eDJ1Lz3
         xMKOOhiq4t4bg2PVWeErNn1ubkIy4t3fW1ogikok61slauKzePMuFZBzZLZmtC90/P/x
         BujtE6p9i+usLzhFQcV9EKPWLs2MDxo1HI66rXk/jri0hhe8TZQe4JBsYraHuZ14ZMtV
         hsew==
X-Forwarded-Encrypted: i=1; AJvYcCW3mHi7/o7Yyvr0v8AgY2MPAvzysimp0FToPeF189AIODSuxdPxF3Z6+nv/H1b+6Oxfl5P+Rt3w4PnVTGZFx7H2H32yi3GTjsi8HPum
X-Gm-Message-State: AOJu0YxmNAUxLs1uBBdz3utXctbVODsVMGbnVtmWauyAT3JrlewGltbo
	pe8BKzAqEpCCkqmy2Yap16VWbMpBhRLSlpihf60KkbvA5v7rFNJCTAPqaQjU2w==
X-Google-Smtp-Source: AGHT+IGp1vHyVN9Of3ONnBmhGBURnZ2ozCtASZrjhYok6bINm0BBVqQzRg5525pvfv09CAPY6RG2ng==
X-Received: by 2002:a17:902:a5cb:b0:1e2:adad:75f4 with SMTP id t11-20020a170902a5cb00b001e2adad75f4mr907671plq.28.1712698139910;
        Tue, 09 Apr 2024 14:28:59 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e35200b001e2461c52c6sm9401985plc.149.2024.04.09.14.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:28:59 -0700 (PDT)
Date: Tue, 9 Apr 2024 14:28:58 -0700
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] tracing: Add new_exec tracepoint
Message-ID: <202404091428.B95127B72@keescook>
References: <20240408090205.3714934-1-elver@google.com>
 <202404090840.E09789B66@keescook>
 <ZhWIKeZuWfPOU91D@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhWIKeZuWfPOU91D@elver.google.com>

On Tue, Apr 09, 2024 at 08:25:45PM +0200, Marco Elver wrote:
> On Tue, Apr 09, 2024 at 08:46AM -0700, Kees Cook wrote:
> [...]
> > > +	trace_new_exec(current, bprm);
> > > +
> > 
> > All other steps in this function have explicit comments about
> > what/why/etc. Please add some kind of comment describing why the
> > tracepoint is where it is, etc.
> 
> I beefed up the tracepoint documentation, and wrote a little paragraph
> above where it's called to reinforce what we want.
> 
> [...]
> > What about binfmt_misc, and binfmt_script? You may want bprm->interp
> > too?
> 
> Good points. I'll make the below changes for v2:
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index ab778ae1fc06..472b9f7b40e8 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1268,6 +1268,12 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		return retval;
>  
> +	/*
> +	 * This tracepoint marks the point before flushing the old exec where
> +	 * the current task is still unchanged, but errors are fatal (point of
> +	 * no return). The later "sched_process_exec" tracepoint is called after
> +	 * the current task has successfully switched to the new exec.
> +	 */
>  	trace_new_exec(current, bprm);
>  
>  	/*
> diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> index 8853dc44783d..623d9af777c1 100644
> --- a/include/trace/events/task.h
> +++ b/include/trace/events/task.h
> @@ -61,8 +61,11 @@ TRACE_EVENT(task_rename,
>   * @task:	pointer to the current task
>   * @bprm:	pointer to linux_binprm used for new exec
>   *
> - * Called before flushing the old exec, but at the point of no return during
> - * switching to the new exec.
> + * Called before flushing the old exec, where @task is still unchanged, but at
> + * the point of no return during switching to the new exec. At the point it is
> + * called the exec will either succeed, or on failure terminate the task. Also
> + * see the "sched_process_exec" tracepoint, which is called right after @task
> + * has successfully switched to the new exec.
>   */
>  TRACE_EVENT(new_exec,
>  
> @@ -71,19 +74,22 @@ TRACE_EVENT(new_exec,
>  	TP_ARGS(task, bprm),
>  
>  	TP_STRUCT__entry(
> +		__string(	interp,		bprm->interp	)
>  		__string(	filename,	bprm->filename	)
>  		__field(	pid_t,		pid		)
>  		__string(	comm,		task->comm	)
>  	),
>  
>  	TP_fast_assign(
> +		__assign_str(interp, bprm->interp);
>  		__assign_str(filename, bprm->filename);
>  		__entry->pid = task->pid;
>  		__assign_str(comm, task->comm);
>  	),
>  
> -	TP_printk("filename=%s pid=%d comm=%s",
> -		  __get_str(filename), __entry->pid, __get_str(comm))
> +	TP_printk("interp=%s filename=%s pid=%d comm=%s",
> +		  __get_str(interp), __get_str(filename),
> +		  __entry->pid, __get_str(comm))
>  );
>  
>  #endif

Looks good; I await v2, and Steven's Ack. :)

-- 
Kees Cook

