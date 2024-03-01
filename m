Return-Path: <linux-kernel+bounces-88734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80086E5ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EA7280BEC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60273D96A;
	Fri,  1 Mar 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToFWaj+y"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F1849C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311132; cv=none; b=WXs2TU07b0cwbZVdllhWv/rtkICHdv/SshAWcIx1fegAY8/HO6jnKbCpQhA0oaI0rurtGG5Z6IjAcTrpmKZSvzf9ZR8x1LQMmxFbY9RDsbi9VP/2PzBmE5BDFpfPMSKsE/8CeU8y7BY6GJ714SaMiYwij4LPMBFBmibf3b7wk0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311132; c=relaxed/simple;
	bh=v3fasrZ049SzsiSU8Wv5RWlUno1kfBoq0xOnRmY2Kzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3egZh2eNMB8O83dD77sRASHAA6GSEYZos0Xm0QNksOfDY7DmPOZNrGHD5+QD8xJJ4Vbv7ql3tXs09RP3jE5LqPesCd/DG0nGz8nZUh8Vl5z36O9/yNyrafxTy0tIt6My0ckDu1/r+dw0i74YJ3rBTZ3JQUdb2G02lqcBJS33aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToFWaj+y; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3650be5157fso172185ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709311129; x=1709915929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPAqnWxjgworqniOSJ8PsC+uXqBSSqBSNTzJb0e70h4=;
        b=ToFWaj+yy1xHk0HWU7bAiRlZgJjJ7P5W9nrD2mHEo1Z2vSEf4hFZa2od4BFlXjoJsN
         9UqnA0lX4krcJq5282hSHI6pBKgPaS7G/PV+FvycvgRTzI2k6k2TEI9GmRemRMD+sKBo
         Qg5PDM3cnPc/uFuOcHzNxQbA4mtNm6k7Fb1STIJ94hIMQIQr0ESvT/fPwEX6GEIKIZ4w
         5GWUpmQljBtlHIz4Fm6yiKMy2jfGSFVeOfFQdi0SVC7vqo+CWXx10XRygMcDNRR0Ioz3
         UJqnv7ewtZegAvtnJ9GO7P4nr5pPZD8U3lP9rm3U93G7rAx9vwpL5UkqpBZOzx0VqFN5
         wa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311129; x=1709915929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPAqnWxjgworqniOSJ8PsC+uXqBSSqBSNTzJb0e70h4=;
        b=DbZ62m3mhyq9/9NsUFhyEiY4lvDmibBl25H8QJsWszuIMMspU/PZhWyaqJi6f1i/Jz
         gLBLded6475WbMBDOic9ObH+gz6Th4HdxhDyOYo6jbtlT/3bwKdd0Z43suh/sOX11H85
         S6cewKgaVgVF2Eo/+yJBYprtIBnaEGqZU0AmU4xYz4qKqOMXIvtxyATmlvqDMLtELaXR
         /UfWliKMDEU7+sqsb4Z0IiczTS9A8n3uUvpVaLcNp0Qo/k6HqGBzb8duAp44Ki8X2eRY
         txkazbMBda7kSXDzxFK2gas7YmsrvK3SGPP1XapP9cgyFw76c7pe52uJxPq9fOYztsbP
         IA0A==
X-Forwarded-Encrypted: i=1; AJvYcCUGtO4MRq9sFBSniNtcI8XbKmshLkPCOUeRPHdRI1gaqb9vrtZYyqtNw5ux235+7W8j/f32lkoUDGAgsFbAEyP6WP5aIlKF8+M1hx9Y
X-Gm-Message-State: AOJu0YxAfE8Y9tLoEYXR439+vpDjsGMqsyHo0ySAtOu6QjrhAcdBYIi3
	+62d19t6qXfl3zRiZWFLk2RdUF8hLjKGoz7+HOJkEoztuYF9GHLxirObNW7z1YmiOaZwdANKQ2E
	1dIV1iYxbjdqdULNMVzM7KV5Vumutk9qXGHoT
X-Google-Smtp-Source: AGHT+IGzUaWRlQBaB12S4PDv8Qi4wWxiH8WVAoDZQqsKYneLkWDQW4ooAJch4Bg6DQQcBZP9232lw/TkfOFRlBunGp8=
X-Received: by 2002:a05:6e02:1aaf:b0:363:c5ec:9fe6 with SMTP id
 l15-20020a056e021aaf00b00363c5ec9fe6mr191804ilv.29.1709311128800; Fri, 01 Mar
 2024 08:38:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301133829.346286-1-james.clark@arm.com>
In-Reply-To: <20240301133829.346286-1-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 1 Mar 2024 08:38:37 -0800
Message-ID: <CAP-5=fUWL56Hi716DPa6Q_VXQoGh6Ed1WoNfSHow3+9qzSaMbw@mail.gmail.com>
Subject: Re: [PATCH] perf version: Display availability of OpenCSD support
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, al.grant@arm.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 5:39=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> This is useful for scripts that work with Perf and ETM trace. Rather
> than them trying to parse Perf's error output at runtime to see if it
> was linked or not.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-version.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 1bafe5855ae7..398aa53e9e2e 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -84,6 +84,7 @@ static void library_status(void)
>         STATUS(HAVE_LIBTRACEEVENT, libtraceevent);
>         STATUS(HAVE_BPF_SKEL, bpf_skeletons);
>         STATUS(HAVE_DWARF_UNWIND_SUPPORT, dwarf-unwind-support);
> +       STATUS(HAVE_CSTRACE_SUPPORT, libopencsd);
>  }
>
>  int cmd_version(int argc, const char **argv)
> --
> 2.34.1
>

