Return-Path: <linux-kernel+bounces-77262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648F38602B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F82428F5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C325A54902;
	Thu, 22 Feb 2024 19:29:12 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941C14B804;
	Thu, 22 Feb 2024 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630152; cv=none; b=GcjEg1LQbQF01JzSWa2SKlO6zALuUjjLzLpuWNi4+gmXb42XrJcXU6F2jb6l5K9y9UjDc18iEBMHQGgWXsV+uC2PhVu7kaac4TMSTC68WnYGszbzMUfhb3L2nPOZWcRKznx6E2nYaDpFgGYsgZQhECQW70bGM0jG0/h9XOsITpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630152; c=relaxed/simple;
	bh=YgjkuxchnXOjDfgszCGMtWwsEo8UYhEcWPYKyGmmSgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWtcPQkSRHsndiBBXNp3IYuyMwVKiOA0iNk++12UQNjOGZtI6BSdwVdk08aBuWdq9BSb/z0PIjicyxQTQyCZ4T02/Yob6jI7v3F06zzkLmEoaIGJQiIdXc/L0HTu400MpHo2FDj7o3gmjo+F00kQ1mEZ0Z/k1+JRVlrseZMx+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59f9045d18dso17954eaf.0;
        Thu, 22 Feb 2024 11:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708630150; x=1709234950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRYTvrV/sGoxnF4i005HgV0pmSUWvFLsiZ3PZkIgeCo=;
        b=jqH4ws+6uLDWMLuJJr8pi8yyWNmnfIF/G8egMbziE6xkCHLLz+M1lfLmhs69PD9yCa
         YA+VJ4hq0qHMSfw6JiCPFxl72+i7fkvu1ZVVTnhn5oBZTNhAd30ElM6j45lJR9YEsTGr
         xUsO+NsVYP+vTTuv/fyAmWgU2UbmtOB6gKDtVPEXR9NJ/m8hGojD++RlRPRx2tApahih
         DGFxUDBLjen0A0Vx7UOxWAzN5q2wmaXJvjbl9ZQBrF2k2mjc2EJZLixKtre3Sv+myupj
         5MSdVBdzwPZL/KlygU77faZWNs9tFFOc1O47xqUDhp4kNuXFHLHBvLOYgNRbIUciJCD6
         6pjg==
X-Forwarded-Encrypted: i=1; AJvYcCW3kaqJHYJ0KvODftEJIwz2vb8UPdAzKeFyYAJ5LWuc52M2r0bpzB4XXFz3h+w5xgWTC25xyiFtouwydWUSSI+TJMki3E1LHX8ALFaSXG4pyRmvb5wd0EHTcpT8+lXCEQhBv+NNua0i//O6XAoTnrARA1tCsAS+45XXEiEyLvXKJJYAdWeWqWTg6UU=
X-Gm-Message-State: AOJu0YzxLKV5Xl4zNjUdsirGMv/kPZocuM3QQIzTXJSaok5skBxGQ2P1
	yYnyPKLaj3YtxnSgZG7e/fqgcK5wwZ2wxnYmlH8hZVz49tXzEAaCWixFeIVLcM2GBHKlBlFLO0u
	HtcIN6H5tVfArwqIQFDGad4S2Ak4=
X-Google-Smtp-Source: AGHT+IHacAAt04GBLc6BsHQ4gZjeD5H5Ok51Dk3K9JgCmLL0KZV1P6w9te0saUVsiE+RuDQtRM1pUJclhDL46ePbr6g=
X-Received: by 2002:a4a:e713:0:b0:5a0:2cbe:43dd with SMTP id
 y19-20020a4ae713000000b005a02cbe43ddmr2343870oou.1.1708630149996; Thu, 22 Feb
 2024 11:29:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194754.986300-1-vilasbhat@google.com>
In-Reply-To: <20240221194754.986300-1-vilasbhat@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 20:28:59 +0100
Message-ID: <CAJZ5v0j1trhHqzCaZOWMY-FghQw3EeaAciRwBmYUtKjBbKUNhQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: add tracepoint for runtime_status changes
To: Vilas Bhat <vilasbhat@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:49=E2=80=AFPM Vilas Bhat <vilasbhat@google.com> w=
rote:
>
> Existing runtime PM ftrace events (`rpm_suspend`, `rpm_resume`,
> `rpm_return_int`) offer limited visibility into the exact timing of devic=
e
> runtime power state transitions, particularly when asynchronous operation=
s
> are involved. When the `rpm_suspend` or `rpm_resume` functions are invoke=
d
> with the `RPM_ASYNC` flag, a return value of 0 i.e., success merely
> indicates that the device power state request has been queued, not that
> the device has yet transitioned.
>
> A new ftrace event, `rpm_status`, is introduced. This event directly logs
> the `power.runtime_status` value of a device whenever it changes providin=
g
> granular tracking of runtime power state transitions regardless of
> synchronous or asynchronous `rpm_suspend` / `rpm_resume` usage.
>
> Signed-off-by: Vilas Bhat <vilasbhat@google.com>
> ---
> V1 -> V2: Modified enum value definition as per reviewer comments.
> ---
>  drivers/base/power/runtime.c |  1 +
>  include/trace/events/rpm.h   | 42 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 05793c9fbb84..d10354847878 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -94,6 +94,7 @@ static void update_pm_runtime_accounting(struct device =
*dev)
>  static void __update_runtime_status(struct device *dev, enum rpm_status =
status)
>  {
>         update_pm_runtime_accounting(dev);
> +       trace_rpm_status(dev, status);
>         dev->power.runtime_status =3D status;
>  }
>
> diff --git a/include/trace/events/rpm.h b/include/trace/events/rpm.h
> index 3c716214dab1..bd120e23ce12 100644
> --- a/include/trace/events/rpm.h
> +++ b/include/trace/events/rpm.h
> @@ -101,6 +101,48 @@ TRACE_EVENT(rpm_return_int,
>                 __entry->ret)
>  );
>
> +#define RPM_STATUS_STRINGS \
> +       EM(RPM_INVALID, "RPM_INVALID") \
> +       EM(RPM_ACTIVE, "RPM_ACTIVE") \
> +       EM(RPM_RESUMING, "RPM_RESUMING") \
> +       EM(RPM_SUSPENDED, "RPM_SUSPENDED") \
> +       EMe(RPM_SUSPENDING, "RPM_SUSPENDING")
> +
> +/* Enums require being exported to userspace, for user tool parsing. */
> +#undef EM
> +#undef EMe
> +#define EM(a, b)       TRACE_DEFINE_ENUM(a);
> +#define EMe(a, b)      TRACE_DEFINE_ENUM(a);
> +
> +RPM_STATUS_STRINGS
> +
> +/*
> + * Now redefine the EM() and EMe() macros to map the enums to the string=
s that
> + * will be printed in the output.
> + */
> +#undef EM
> +#undef EMe
> +#define EM(a, b)       { a, b },
> +#define EMe(a, b)      { a, b }
> +
> +TRACE_EVENT(rpm_status,
> +       TP_PROTO(struct device *dev, enum rpm_status status),
> +       TP_ARGS(dev, status),
> +
> +       TP_STRUCT__entry(
> +               __string(name,  dev_name(dev))
> +               __field(int,    status)
> +       ),
> +
> +       TP_fast_assign(
> +               __assign_str(name, dev_name(dev));
> +               __entry->status =3D status;
> +       ),
> +
> +       TP_printk("%s status=3D%s", __get_str(name),
> +               __print_symbolic(__entry->status, RPM_STATUS_STRINGS))
> +);
> +
>  #endif /* _TRACE_RUNTIME_POWER_H */
>
>  /* This part must be outside protection */
> --

Applied as 6.9 material, thanks!

