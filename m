Return-Path: <linux-kernel+bounces-165174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C18B890D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874471C236E4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18276A357;
	Wed,  1 May 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzYl3piF"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09248CE0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561894; cv=none; b=PhJwklwFq+VKUqn4ZNB7xTn0E22K2kHq5C1BMKTKWAA+P4P26NytQ9ZSWQa4E11RAjxET3Tl94PuGOEr0H3FZTZcBsPq25Lpi+TDjmp2n70oFiH32vleKvfGG2k9umcY3CNMeBMS38Q2lxRUf/8arV5Y0bkpeoG3CZSCSqZaVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561894; c=relaxed/simple;
	bh=rP7uH6p9WSfZPD4zUjuFPD5EEQc4lxYWqVD/vJwLfNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgnAu57G9y7OXkjH+iruFBAnL/zMxt0uzOPv11nNY0cZ90DDDhSH4z9nw5k7XA4coeF9KX/gPT3MyQ5a8VjNQiJkQzQl4AD5uvsh5RzF3a34L393NCo2HHZB/0RRN4WQIdP6ugXyp1sZSUFUsWC0UmRMlzAjueucxYBkodB7Bo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UzYl3piF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b273cbbdfdso1343788a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714561892; x=1715166692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BZZTUr02OpFJNJ7PY9o47700VYpg5n+dM1vcCgaaNjM=;
        b=UzYl3piFd3XIDUK3Jo7G1t3EWTIMMM/ubuKvSd33n20bQro1x0CTrFo4/M2nE4kHD8
         wDwQoVua0xPozaqQbmqRxXYH9ot9uOSsI2izTZVZZJOtuRrWKQ3xHjEUReNWxF6cx+Ai
         ZCcIglNDgRVIqpPy0w8so4/utRevDPjuoBr6hMTdGgOl7rj5mF+G/mjZ4A8ofZOmsUq+
         gUSvo9Z7F49bndZB1MAba4dOc2g1WPKiDMIh/E1Dd+w4YansHhQXAmhSMG01or34vFWc
         kieBpI0SxYZYMbJjndJLVYEj0YLkpaGXPEb3z9JtlmqMyeFBfWIXZ7L+hBJxA/OuZ6IM
         dj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561892; x=1715166692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZZTUr02OpFJNJ7PY9o47700VYpg5n+dM1vcCgaaNjM=;
        b=R955xQQMxzoWypDiBrLeVRp+jm+X67XUGrHOJGUj+OBMRhTkH6FqeRLqWCUbK5uwMd
         HH26jReFE1tp50uw5On7Ye14fWtEEN0chElrDLugQATYNuwudoxUI8EDeL7DygCrGffN
         65ODcVYE+k8mBtLtFamFqrHIzSD9pmCRqNee+7hofiwjIUmcYxmCRWKre2NW8kN00Ts4
         EW/mJdZz+lfKS0Uv9rNx6NMfHL9dUzhAI/dNiHT8Ylz0Viiv42c8vMdFzd/+OYfI1t+H
         JptIsicaIu9Hkl8pqXcnt8olBeZwNydakrp0nL2L3RBgGBYxjOG1zkkIDiYwe91nX5iK
         sCRg==
X-Forwarded-Encrypted: i=1; AJvYcCXiIPPeKqhmul/YrCmaAdvh7R7pMJSjQssM6MKNjISonq0qXXe69Ntn8ZlBH5eTNm2emsSLKEfyW4pD7T71fqcNjxf0bwfsPwGA2cz8
X-Gm-Message-State: AOJu0YzpiP8k95Be6y9x0Oo9Z6394UtQKgKhEXGBBLWuXaYoZYp0+xUS
	r9Lecnt82rC3dnTsH7VUOVqYN6QjAZraSV3iIae+EH40CAZzaPeh8pyKjLowUWkUN+IKN7bbRzZ
	Ujsi19nyeeeiGFi3TjVe3fubRPGBUe3nUhXlOdg==
X-Google-Smtp-Source: AGHT+IHme+tbaissSNWWxihi7iBWbnHX1ITaUYwIqqsZ/hS87/ki1ILDQ1EHmGWbPiULm7pY0uK6xANN1WfW/TaXyVQ=
X-Received: by 2002:a17:90b:388f:b0:2b2:812e:1d8c with SMTP id
 mu15-20020a17090b388f00b002b2812e1d8cmr1795234pjb.2.1714561892566; Wed, 01
 May 2024 04:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429152207.479221-1-james.clark@arm.com> <20240429152207.479221-11-james.clark@arm.com>
In-Reply-To: <20240429152207.479221-11-james.clark@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 1 May 2024 12:11:21 +0100
Message-ID: <CAJ9a7VghkeaJ8e-mEZKodicQ++QyW_SKfacsPPsfQb2PiT6H0w@mail.gmail.com>
Subject: Re: [PATCH 10/17] coresight: Move struct coresight_trace_id_map to
 common header
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
> The trace ID maps will need to be created and stored by the core and
> Perf code so move the definition up to the common header.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../hwtracing/coresight/coresight-trace-id.c  |  1 +
>  .../hwtracing/coresight/coresight-trace-id.h  | 19 -------------------
>  include/linux/coresight.h                     | 18 ++++++++++++++++++
>  3 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index af5b4ef59cea..19005b5b4dc4 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2022, Linaro Limited, All rights reserved.
>   * Author: Mike Leach <mike.leach@linaro.org>
>   */
> +#include <linux/coresight.h>
>  #include <linux/coresight-pmu.h>
>  #include <linux/cpumask.h>
>  #include <linux/kernel.h>
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> index 3797777d367e..49438a96fcc6 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.h
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> @@ -32,10 +32,6 @@
>  #include <linux/bitops.h>
>  #include <linux/types.h>
>
> -
> -/* architecturally we have 128 IDs some of which are reserved */
> -#define CORESIGHT_TRACE_IDS_MAX 128
> -
>  /* ID 0 is reserved */
>  #define CORESIGHT_TRACE_ID_RES_0 0
>
> @@ -46,21 +42,6 @@
>  #define IS_VALID_CS_TRACE_ID(id)       \
>         ((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
>
> -/**
> - * Trace ID map.
> - *
> - * @used_ids:  Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
> - *             Initialised so that the reserved IDs are permanently marked as
> - *             in use.
> - * @pend_rel_ids: CPU IDs that have been released by the trace source but not
> - *               yet marked as available, to allow re-allocation to the same
> - *               CPU during a perf session.
> - */
> -struct coresight_trace_id_map {
> -       DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
> -       DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
> -};
> -
>  /* Allocate and release IDs for a single default trace ID map */
>
>  /**
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index f09ace92176e..c16c61a8411d 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -218,6 +218,24 @@ struct coresight_sysfs_link {
>         const char *target_name;
>  };
>
> +/* architecturally we have 128 IDs some of which are reserved */
> +#define CORESIGHT_TRACE_IDS_MAX 128
> +
> +/**
> + * Trace ID map.
> + *
> + * @used_ids:  Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
> + *             Initialised so that the reserved IDs are permanently marked as
> + *             in use.
> + * @pend_rel_ids: CPU IDs that have been released by the trace source but not
> + *               yet marked as available, to allow re-allocation to the same
> + *               CPU during a perf session.
> + */
> +struct coresight_trace_id_map {
> +       DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
> +       DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
> +};
> +
>  /**
>   * struct coresight_device - representation of a device as used by the framework
>   * @pdata:     Platform data with device connections associated to this device.
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

