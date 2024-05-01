Return-Path: <linux-kernel+bounces-165166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 029D18B88E0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB15B22F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974156760;
	Wed,  1 May 2024 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B08lNSqO"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4C5028F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561662; cv=none; b=mUQgXlofYequWEokn7ercl6Lj7oObZvjGdWTZ8noCRaRdOrWpn1shB0ZXsm7sC6U522k6DeeuTdiZ7pBG028V1kYNcwiXICoWkot53tWlnHpDsa+ElmwRKXFe0bAJTsS5Ujn9uSy40OwIsfai1SxNqIskj2UOaGe8Znnz7TPj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561662; c=relaxed/simple;
	bh=PFvDOMRHeF4ceqtT1HoG5CTMOEV3p5eFI81RRqSaeRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubfk/cNqmH2uDWty1ma3+nNaar5Q8FfdGTJIZfSEc2tspSDmWxgGq7o2NDd0zj4oyU/xWz6VJd3A/xnlegwsBjOJueQK1QJAGVJOGk5ki55lX7CL0QAqgVspW7b2FGfWWxagJ48t2K1SXQgYfSsNxjxJNfGzIn+60a394sqSq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B08lNSqO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed32341906so6102471b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714561660; x=1715166460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ek5F3YPIQaz7pVJGDrpZC6fIvMvYFFyBjkRJozj7mhk=;
        b=B08lNSqORCad23SG44rFFpG4gqe3jaITrZ3AG2hQ8xd6+9b3KwQc5XT2dU+g8f4dsj
         5eJWFBMNshAiz04IUZeIhJy87m5GAMx+bxMFXiC1GuAAtp6T4m/o9Awu+rKCo06jWSBL
         1iP0rIqF/FQX0bMlkgvPoY1zTUMeYETMCF0v6VcTV/6QLTXKKX5ek0YMVszrENtYjYIl
         HuWgJzEm4wTR/o7JRmATlhKLA2lDnE0KIq40jcb/9nnRU54w1DqyOJwR4KIgCyaU6tfT
         TGasvGS1NhgK7h/xlTkeN6R7TO3rDgHAuSiv9HD3m5gxBYrdFXfSGN3gJvDtu4xTXTls
         Eeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561660; x=1715166460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ek5F3YPIQaz7pVJGDrpZC6fIvMvYFFyBjkRJozj7mhk=;
        b=p4XPFB0csaOlY79s19JzWfyRGEef/rkoG3+C6o19DAU1M0FKdv+LPMwSyKdIBpEOdC
         ylU8rmL0bcFrs1Y/C1V5ZgcCHKD8fBT/7w9jDJDj9DVbJm/+A+Ymv+eblFiMOXfLo0Mz
         iOuO2JKfeLa52ZA93W0hlSZpVcGWoHZqgnu8o1UE+6v5sgi8AK0n9qY8kGtGjmTdoLum
         TFQ0rP97tqeNcBsymK5mBwZ2nd75DVc4vNqT5/6RW165AWNPp2v7jFK7HEm+ZiZD0Q0J
         eDYoZFnO6syxwg7ALixfI8kGpO7ozVIRfZWvayMR3jE7wI3Z7lBz04pMpSuQi2KaXc7X
         N2Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVWMJRba6DM5Bu7f7bZvrjgNG3s00dZJ0MqLVTnfntuPrnmfn3K/vOiPBskB7b41JWZwfZphycwbrjSaSIfm3OKBkZYhruOC9DJKCpt
X-Gm-Message-State: AOJu0Ywhb2SlvL5FktaTRJenzqTKZee+qjr6pEMjUna/BF8gxm85Bp4p
	iokAHR4aFAjOfoTzfWVLkVHxTq3QYigrNiOsHuOnJ71eo41zOA+dMCnyti2dAW2gBGuXWwsu6sN
	WElfexdmpEdpB+0fVA1j9k/22Eg7PKtG5gm44AA==
X-Google-Smtp-Source: AGHT+IE/tyinAuqC8y5bBreMEgtKVRNCzWBS/7la0SOC/SOUmFsQmilGpTeNNFJve+JepEwqeq9sMzFbKUfoY4RzIdo=
X-Received: by 2002:a05:6a20:3213:b0:1a9:c757:a22d with SMTP id
 hl19-20020a056a20321300b001a9c757a22dmr2167796pzc.14.1714561659976; Wed, 01
 May 2024 04:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429152207.479221-1-james.clark@arm.com> <20240429152207.479221-10-james.clark@arm.com>
In-Reply-To: <20240429152207.479221-10-james.clark@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 1 May 2024 12:07:29 +0100
Message-ID: <CAJ9a7Vgvdjz9peyDzRzAJ3DDGFfjVD0dNXgcJ7b+g-WvCwZ1QQ@mail.gmail.com>
Subject: Re: [PATCH 09/17] coresight: Clarify comments around the PID of the
 sink owner
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com, 
	scclevenger@os.amperecomputing.com, coresight@lists.linaro.org, 
	suzuki.poulose@arm.com, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 16:24, James Clark <james.clark@arm.com> wrote:
>
> "Process being monitored" and "pid of the process to monitor" imply that
> this would be the same PID if there were two sessions targeting the same
> process. But this is actually the PID of the process that did the Perf
> event open call, rather than the target of the session. So update the
> comments to make this clearer.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++--
>  drivers/hwtracing/coresight/coresight-tmc.h     | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index e75428fa1592..8962fc27d04f 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -36,7 +36,8 @@ struct etr_buf_hw {
>   * etr_perf_buffer - Perf buffer used for ETR
>   * @drvdata            - The ETR drvdaga this buffer has been allocated for.
>   * @etr_buf            - Actual buffer used by the ETR
> - * @pid                        - The PID this etr_perf_buffer belongs to.
> + * @pid                        - The PID of the session owner that etr_perf_buffer
> + *                       belongs to.
>   * @snaphost           - Perf session mode
>   * @nr_pages           - Number of pages in the ring buffer.
>   * @pages              - Array of Pages in the ring buffer.
> @@ -1662,7 +1663,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>                 goto unlock_out;
>         }
>
> -       /* Get a handle on the pid of the process to monitor */
> +       /* Get a handle on the pid of the session owner */
>         pid = etr_perf->pid;
>
>         /* Do not proceed if this device is associated with another session */
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index c77763b49de0..2671926be62a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -171,8 +171,9 @@ struct etr_buf {
>   * @csdev:     component vitals needed by the framework.
>   * @miscdev:   specifics to handle "/dev/xyz.tmc" entry.
>   * @spinlock:  only one at a time pls.
> - * @pid:       Process ID of the process being monitored by the session
> - *             that is using this component.
> + * @pid:       Process ID of the process that owns the session that is using
> + *             this component. For example this would be the pid of the Perf
> + *             process.
>   * @buf:       Snapshot of the trace data for ETF/ETB.
>   * @etr_buf:   details of buffer used in TMC-ETR
>   * @len:       size of the available trace for ETF/ETB.
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

