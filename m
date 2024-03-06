Return-Path: <linux-kernel+bounces-93883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D46D87364D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B5C1C23736
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88E480618;
	Wed,  6 Mar 2024 12:27:29 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBE605DC;
	Wed,  6 Mar 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728049; cv=none; b=VHOhkRqfVU+0aUVBt6U/GjUJDatqlDZNrWtlGQBhboy/Zx1NxLt85DQmqmNMXXSFPvG2JSN0O/NIEzX4e3jhW3ixveKAAVHzs86INzfIuv4/vEwl0bFm82WFLitTC157ThOQxRgyX+qrzk+8dWZ5tD3Tz5UGnY5xdUehT4qSbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728049; c=relaxed/simple;
	bh=odzYK9sDbtw2mcibUKgzKaZ9I64oqqSJfnvzyoEQ9j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGt79zfgwEa1sRAn6hRkzjDpNv7LFNgmkaL/lJLq+54ApUwuEMJ9jcXmx6JaYgK4H5lr9Ecde9yw1tovz1gHTl+l9A9t4IMs9b3pcrmrbCdmkBskWzSaGuZ3Unm3hPymKRuyU2Go/+qCt1L9VtVFq/OsYL//oE/d/eNn/MYG4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-220ce420472so1286642fac.1;
        Wed, 06 Mar 2024 04:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709728047; x=1710332847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2uwWIvrqigw9U2DmUo/9WpsuuGHJz16WfDDJYpM0GE=;
        b=Z0/sWuyDdS4UNeM5tnrFwChMo7UOXnnM+6j8V79cFn15b/1spWJIVZJuYSbj3M3d0d
         JctUpSKJJPqcqgeEC0ZjyXbiNnzU3Ehn8HCYmbK52oujSqLtE5vfx2OeUrIh4LlRunmJ
         NENWjw84FfttJOcWai5xMtcVXHVrtaN5ksfmJO0rRk96WrkCjBc7vmY0Rw9uDg6q7rLX
         3NLZgC008RckJGzU2QiZIlYVUbrERtWb1LpPv5sP6+K6+Pn58j6Sr0TXnP7ACp/RBwjG
         nRRRKT/Dsjmtz/iszjpn9xuk0a9vjIyppY4GfUAIzZ2b/cO5fGHVaepqeFtRXSYegzqE
         f3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXniDR6AcrGNAeRZN57hCI6WOXq7n7AZl3wKdNfvF86SHdFdSVTVtnJ4cUaMC/8HYCMTg4aO2Y23FpOuKZgwuDJ7l036iBAeA35c2aGPOjSOSyxTglfQcSTqBMYWQVVt3R7FiPeXGkGtcm/Kkj6RLoYpBWIEDullf13+DNKlNm2fo37cLURXMA=
X-Gm-Message-State: AOJu0YySt4s8ltKTUhS10FMnKjbVEyJpKu/r0mUb17OfP6Q+A/Md5h7Y
	b9FqdPCMweNoigyzIhrm674Jv/IX4RuXO9OBajsfmTmOtl5DRZRNlYyfxs+onmYb9p6++Wf7MZb
	GsmxajPTsxBMu/dY0zgzyT5F5A+0=
X-Google-Smtp-Source: AGHT+IEw8QK+9xM0ePQfDuX8Nb/nB70c9hqG08jVgDbSBKLXQ+U/dWyKMZi23KsM5ugJqOEYnOqPtzHiTAFelTx4mk8=
X-Received: by 2002:a05:6871:60a:b0:221:16e3:8f22 with SMTP id
 w10-20020a056871060a00b0022116e38f22mr3274775oan.5.1709728047162; Wed, 06 Mar
 2024 04:27:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3332079a-9548-4b19-bba9-69270be115ec@moroto.mountain>
In-Reply-To: <3332079a-9548-4b19-bba9-69270be115ec@moroto.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Mar 2024 13:27:15 +0100
Message-ID: <CAJZ5v0hF_u+_j7ZJHh8ssdGUWMQWEUDa87Y3YLUcJU9zJSUKFw@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: remove unnecessary check in trip_point_hyst_store()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:31=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> This code was shuffled around a bit recently.  We no longer need to
> check the value of "ret" because we know it's zero.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/thermal/thermal_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index 7c02d35384ce..5b533fa40437 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -181,7 +181,7 @@ trip_point_hyst_store(struct device *dev, struct devi=
ce_attribute *attr,
>
>         mutex_unlock(&tz->lock);
>
> -       return ret ? ret : count;
> +       return count;
>  }
>
>  static ssize_t
> --

Good catch, applied.

Thanks!

