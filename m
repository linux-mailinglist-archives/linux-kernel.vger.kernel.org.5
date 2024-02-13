Return-Path: <linux-kernel+bounces-63538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1668530ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0909E286703
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01BA4BA9A;
	Tue, 13 Feb 2024 12:49:54 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703F482C5;
	Tue, 13 Feb 2024 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828594; cv=none; b=ErI6OSJhVwQNR1F+uo/Xjpi+2Kg4eosu5MQe+kTeK1SzUPaITPqkIqGNzayl/C0znrg5vBm4TfDzfGCG6gwcfH9NB/JO4OPKmdyE4bDW1dck7TZSo6wppOjVcsxZb7Z4AkAdVLlE8a5Mt8k/uVyiMAttwwVyop9at1B29OwOij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828594; c=relaxed/simple;
	bh=ex3TVzNJN0wCNtO75MDBncMsHfHQsNEWiw0uCMYtP0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ge55H93akpGblhNxB38oaFeQsvDvGeIlRRk3xoeC/o8A3FfzV31QkhuYvTcaooqsBklEigIMX+ir/UFvVJdLxCvCI248wX4aOLOsT1EwjPu63oUmkaEduaePItlxu2Msi8m0ZIFaIdo1NKMcKCBBS8o+AHeJg3oiQ93sftx4zis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5958d3f2d8aso1780361eaf.1;
        Tue, 13 Feb 2024 04:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828592; x=1708433392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CBaxOaB3YtfOi5TS5qWweacR8xmwIUPPYfPdVBRx/s=;
        b=RVtMee1L4BU07ZzNeXFF6RiJf0m9FO5Vpe9Inx2ycTk344HdGsKL/pl3Br0cu2CQWi
         l6H8BZgvtW9yRl6RL2vSv6X89GMo6GALUaAvsiCvbpvps2KMHq73haYfkdRIKFMe6ofz
         dk9oDiIQ9DQ6AXObMwzlyTHgEnVLLbqDsIIqljCIPrbLcgwqzqN1vU8LUxmi/hZghgb8
         bU0lTux9Tk+45UrMK3lddilux53zZAm36mw73W7ATDhSwAH50s3EkfWOBGiijDrh5ZKx
         46fGL+6EjKY+Vd7jGy1e5kgQ+8Rsi0wMHxRHrCPWyFJNEBK/jq/Oesx1OO9dNWc7BsNf
         ABwg==
X-Forwarded-Encrypted: i=1; AJvYcCXkaIlZh4QgvXwwvJf85zVanKBo2X5p5GKs8hN5sieFCrNx0etzFLxjMvrLYDpNx9+nm5GLUJLyVhM5zo2SFF6dnOIFn4i65Y/Sys+QomLmYVsrv3dCGtchAIvrY73vE7Rffg417Uw=
X-Gm-Message-State: AOJu0YwhqfIO54eMGRTX0hLVrrjpzXEoPZqMLL+pHiH5Zcflkt7oMDgc
	XVv0o3hbyVfiMUfmfS7OnkWHZP+xx8s3X9SCmYS0YlnR3q9N1/h4T5VUW/4vZSBlZkAXI0yy0z3
	/O8MFx6m/nJm7YaM9omqodJd3HEw=
X-Google-Smtp-Source: AGHT+IGepfo3mjYQMT/6bLddK5Tf4BA9NDeq2GTv2R5GvwY3wkdkJL7vMUtcZmGcKZMXRXPWGfa++T8qADrKAt9VGpg=
X-Received: by 2002:a05:6820:a8f:b0:59d:6ef2:7b01 with SMTP id
 de15-20020a0568200a8f00b0059d6ef27b01mr3048157oob.1.1707828591767; Tue, 13
 Feb 2024 04:49:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213111600.25269-1-jirislaby@kernel.org>
In-Reply-To: <20240213111600.25269-1-jirislaby@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Feb 2024 13:49:39 +0100
Message-ID: <CAJZ5v0i0C3iPCUaUxfGGd+XjKmh7gY3G1e0uNG4mBm3FEmx8LA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq/intel_pstate: remove cpudata::prev_cummulative_iowait
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:16=E2=80=AFPM Jiri Slaby (SUSE) <jirislaby@kerne=
l.org> wrote:
>
> Commit 09c448d3c61f (cpufreq: intel_pstate: Use IOWAIT flag in Atom
> algorithm) removed the last user of cpudata::prev_cummulative_iowait. So
> remove the member too.
>
> Found by https://github.com/jirislaby/clang-struct.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/cpufreq/intel_pstate.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index ca94e60e705a..5ad3542c0e1e 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -201,8 +201,6 @@ struct global_params {
>   * @prev_aperf:                Last APERF value read from APERF MSR
>   * @prev_mperf:                Last MPERF value read from MPERF MSR
>   * @prev_tsc:          Last timestamp counter (TSC) value
> - * @prev_cummulative_iowait: IO Wait time difference from last and
> - *                     current sample
>   * @sample:            Storage for storing last Sample data
>   * @min_perf_ratio:    Minimum capacity in terms of PERF or HWP ratios
>   * @max_perf_ratio:    Maximum capacity in terms of PERF or HWP ratios
> @@ -241,7 +239,6 @@ struct cpudata {
>         u64     prev_aperf;
>         u64     prev_mperf;
>         u64     prev_tsc;
> -       u64     prev_cummulative_iowait;
>         struct sample sample;
>         int32_t min_perf_ratio;
>         int32_t max_perf_ratio;
> --

Applied as 6.9 material, thanks!

