Return-Path: <linux-kernel+bounces-165164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11C28B88DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26E91C21BD0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AA056754;
	Wed,  1 May 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMpNrJC4"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633AA5028F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561601; cv=none; b=mvE1a1XUzyhorZxAy14ytpftPBLp04P6lKkyf5+M2Rxuy/66dJw5VXfIEC1Q5+Trl5RpfEivPbvMc4pSSwoUnJDwRUuxw6HrYoUzDlP1gM/YI5a8ymsvWS7Xu3hkKdmOvzi8BSPJFdCXT9ehdCCTDxqDx0mWTOJdlE3Nynj7/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561601; c=relaxed/simple;
	bh=8Ern/w3N5sL4wLf8mWZQzBfabAjbgCGzxG/d/rNuRT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzEnRItFzV7yhssIzQQhJVcecKabDDOYO0lPerVzaDf8EzV8+wrtE1pNlAulHBnenN74JkIIVkK+JjtxnnMyQGsCLRjipyH6yKdNK2BnCNwjXlCRAYzxoW1f58CEWmIfhEhI9pbUFVV9n+9nJZ3o0TYzky38c+URhrXtTeoGfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eMpNrJC4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f3f6aa1437so3154515b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714561599; x=1715166399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UVIfCEDLcryVh1sxegO1WMzH32gqhTaOJpqJeO8zPZI=;
        b=eMpNrJC4M4qGrIQJtM34Z32GvUCmKNcl3/h9L2WhKEOAH9g0XkiMSvomfWrnBxz0dA
         bXvE45U6qg80AGk9EmKI4YQ5nEuXgGnF4qvsw74ndNoXYODpaha/UZCjyGR/AODE09Uu
         gJHAmJ2c38/HtMvKcb3msy1AdnprvOaEKzkxmz360lVx0PM5p35LHY4Xf8TwxnGPeoN0
         Vlyh2sn8Qlev7bABki4sDXak+DYKYxHVs7VjuKGx3MAbVgW8+r4XihUimkZOeJMxTrUu
         MrlmZnDrZyLwtAjT9U1EqHmvrPeGHChpToYJ3vlBVqZkbmcZzx5Wsb8HoYA+HVNh//Mg
         bjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561599; x=1715166399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVIfCEDLcryVh1sxegO1WMzH32gqhTaOJpqJeO8zPZI=;
        b=ivD6fL2+pbGtRNYuDG1MTlIRmtuq67Y7hnUQLVKMHFhlG8zJWIe5xrdqB2qQr6am3g
         KgBZUiTthsNXSXuyj3BS5B/a6nKcHSgUtWK4ekVPTg0kMS9YcDg/V8v0Q9OC2fpCC6Cq
         7X+AuduJH+ntxbjrGqB7W41KYFj8ryX9oYdfi69e+8qCYbz43IkZxK6U0YZgvNPYjRT8
         TKk5fU/nqRnz1+c1/cT0zPkcLaX8mtZn6Qerh4n5rJtmM2hietC11VwVUXkGxpAOuJ0G
         dCKYm42DBrvCN6FLNUCGsejAo52qsigbYyltkY89+10UjgQM/KP+INNH8nDsI5/SUofe
         72Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWg0DD9JsVCoc09TFv85rApqKg6kIH53Vp9FRP+qdm1AKIa2PpADj2xBRyWiP/syb6xXJcX97qCvJDLEBBokHQyuWxuvg6mtePnpoMY
X-Gm-Message-State: AOJu0YxDIGXFOY60kHm37AsEG4J5IU4HupHln2nfAGLmgXkiZ+zo074D
	BW2iEYRuhLOe44roKGtaLvoTswSdceXq/aJg0jEyj/kK/Uecv5QivIgXd/YtlU6H0Hhhd5W3AZN
	1gc1IsnV+H9zMZzLtstXe+0+Ns2K8FmxCzbPlxw==
X-Google-Smtp-Source: AGHT+IEIeZDG2abjSl7JiRn4xQhRhE22MbWI7q0YUcF0ys8JS5PMok3Dg8kUX1MoLmYeliXkgq+kWLLlOGEYtodZ7Ag=
X-Received: by 2002:a05:6a20:5a89:b0:1a7:9e85:c28f with SMTP id
 kh9-20020a056a205a8900b001a79e85c28fmr1964085pzb.48.1714561599628; Wed, 01
 May 2024 04:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429152207.479221-1-james.clark@arm.com> <20240429152207.479221-9-james.clark@arm.com>
In-Reply-To: <20240429152207.479221-9-james.clark@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 1 May 2024 12:06:28 +0100
Message-ID: <CAJ9a7VgAg==xysGSjR9Cd5oO1+=HQF0xxcpamgntb_PV6aw6JQ@mail.gmail.com>
Subject: Re: [PATCH 08/17] coresight: Remove unused stubs
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
> This file is never included anywhere if CONFIG_CORESIGHT is not set so
> they are unused and aren't currently compile tested with any config so
> remove them.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../hwtracing/coresight/coresight-etm-perf.h   | 18 ------------------
>  1 file changed, 18 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index bebbadee2ceb..744531158d6b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> @@ -62,7 +62,6 @@ struct etm_event_data {
>         struct list_head * __percpu *path;
>  };
>
> -#if IS_ENABLED(CONFIG_CORESIGHT)
>  int etm_perf_symlink(struct coresight_device *csdev, bool link);
>  int etm_perf_add_symlink_sink(struct coresight_device *csdev);
>  void etm_perf_del_symlink_sink(struct coresight_device *csdev);
> @@ -77,23 +76,6 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
>  int etm_perf_add_symlink_cscfg(struct device *dev,
>                                struct cscfg_config_desc *config_desc);
>  void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc);
> -#else
> -static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
> -{ return -EINVAL; }
> -int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> -{ return -EINVAL; }
> -void etm_perf_del_symlink_sink(struct coresight_device *csdev) {}
> -static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
> -{
> -       return NULL;
> -}
> -int etm_perf_add_symlink_cscfg(struct device *dev,
> -                              struct cscfg_config_desc *config_desc)
> -{ return -EINVAL; }
> -void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc) {}
> -
> -#endif /* CONFIG_CORESIGHT */
> -
>  int __init etm_perf_init(void);
>  void etm_perf_exit(void);
>
> --
> 2.34.1
>
Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

