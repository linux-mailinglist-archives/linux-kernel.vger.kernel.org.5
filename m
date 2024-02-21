Return-Path: <linux-kernel+bounces-75172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A1C85E41A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61362855F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2BD83CA0;
	Wed, 21 Feb 2024 17:12:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3DF33F7;
	Wed, 21 Feb 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535554; cv=none; b=RXILOlfODYqLsEfhpgafl//zy01pNt5UuTgBzVSMwE0mVm9kIakH1E1PyuWCrc7brMUt1JrbjMm47U2A2+GCgGayeFHBW9nchVBY5kSZclyYmbPf56SrME0C04eaEPa0IoqqZAdfZeKVJA4RJjWRGFNyciwcFKOoVuZivQtn1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535554; c=relaxed/simple;
	bh=6+K4JYURtxFMFUED4tSzJ/ogyXzPLhiyh8zwFpwmxJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4hvpIJEUHyfQ+9K7QftnqcZ8qDdtoBONvZVRhF1F60WeSTKDouX1DFJklzeFy7vb18UK/YliYg2Q+2XJjL8450gynQM1aPD1a8Qy/9PhHyEKBG0yivhy+M0h1QbySviqpxVMosVcGca+8SmkgwUW/4QAqxPFvgffLYXIFhM75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9847AC433F1;
	Wed, 21 Feb 2024 17:12:32 +0000 (UTC)
Date: Wed, 21 Feb 2024 12:14:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vilas Bhat <vilasbhat@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Saravana Kannan
 <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM: runtime: add tracepoint for runtime_status
 changes
Message-ID: <20240221121420.2e32fd00@gandalf.local.home>
In-Reply-To: <20240221164112.846409-1-vilasbhat@google.com>
References: <20240221164112.846409-1-vilasbhat@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 16:41:10 +0000
Vilas Bhat <vilasbhat@google.com> wrote:


> diff --git a/include/trace/events/rpm.h b/include/trace/events/rpm.h
> index 3c716214dab1..f1dc4e95dbce 100644
> --- a/include/trace/events/rpm.h
> +++ b/include/trace/events/rpm.h
> @@ -101,6 +101,42 @@ TRACE_EVENT(rpm_return_int,
>  		__entry->ret)
>  );
>  
> +#define RPM_STATUS_STRINGS \
> +	{ RPM_INVALID, "RPM_INVALID" }, \
> +	{ RPM_ACTIVE, "RPM_ACTIVE" }, \
> +	{ RPM_RESUMING, "RPM_RESUMING" }, \
> +	{ RPM_SUSPENDED, "RPM_SUSPENDED" }, \
> +	{ RPM_SUSPENDING, "RPM_SUSPENDING" }
> +
> +/*
> + * ftrace's __print_symbolic requires that all enum values be wrapped in the
> + * TRACE_DEFINE_ENUM macro so that the enum value can be encoded in the ftrace
> + * ring buffer.
> + */
> +TRACE_DEFINE_ENUM(RPM_INVALID);
> +TRACE_DEFINE_ENUM(RPM_ACTIVE);
> +TRACE_DEFINE_ENUM(RPM_RESUMING);
> +TRACE_DEFINE_ENUM(RPM_SUSPENDED);
> +TRACE_DEFINE_ENUM(RPM_SUSPENDING);

You could do what everyone else does:

#define RPM_STATUS_STRINGS			\
	EM( RPM_INVALID, "RPM_INVALID" )	\
	EM( RPM_ACTIVE, "RPM_ACTIVE" )		\
	EM( RPM_RESUMING, "RPM_RESUMING" )	\
	EM( RPM_SUSPENDED, "RPM_SUSPENDED" )	\
	EMe( RPM_SUSPENDING, "RPM_SUSPENDING" )

#undef EM
#undef EMe
#define EM(a, b)	TRACE_DEFINE_ENUM(a);
#define EMe(a, b)	TRACE_DEFINE_ENUM(a);

RPM_STATUS_STRINGS

#undef EM
#undef EMe
#define EM(a, b)	{ a, b },
#define EMe(a, b)	{ a, b }

> +
> +TRACE_EVENT(rpm_status,
> +	TP_PROTO(struct device *dev, enum rpm_status status),
> +	TP_ARGS(dev, status),
> +
> +	TP_STRUCT__entry(
> +		__string(name,	dev_name(dev))
> +		__field(int,	status)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, dev_name(dev));
> +		__entry->status = status;
> +	),
> +
> +	TP_printk("%s status=%s", __get_str(name),
> +		__print_symbolic(__entry->status, RPM_STATUS_STRINGS))

This will be what you want with that last redefine of EM*()

-- Steve


> +);
> +
>  #endif /* _TRACE_RUNTIME_POWER_H */
>  
>  /* This part must be outside protection */


