Return-Path: <linux-kernel+bounces-4299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06AA817B20
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B28E2844A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BAB71469;
	Mon, 18 Dec 2023 19:40:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7F1E530;
	Mon, 18 Dec 2023 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59158202d22so816588eaf.0;
        Mon, 18 Dec 2023 11:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702928448; x=1703533248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqCIyrV80aQe/xoEqMj06Wb1LCcYSvkWNPSdUnD3As8=;
        b=ISu3/3/LiXkAW/i7y7Rf0rBn1Lz/nDn0wjKxM5UJQJ/A0McbdeEBEi39thjqI+1BYs
         4p611R5qSXFtGQCEp1s2Cr7GM0/tUJBlsdSMoIaKmWqlAAYdX1iVK3BtfRzh3a0lAPZN
         v9I6Vbbl2SWMiyBRMw17hVYlLcn0ZUmtV9wM3A1mbPkPm9KGT+QeGdHjzSXxVPhjJNpX
         oBkCDevJVdr0jE/hdUyZ4tgztmuWsitk4U+ZAiVVSAbefJbfL1FKyGVTVoiHnsd9dqsK
         qS0aWdOrHdo3NaAR6dJe0ardcHxL9b+nx95YH67yvtSCCCr5MmklbyCOVauox3OV5Unq
         O1hg==
X-Gm-Message-State: AOJu0YwVIcz/ZVMbCctMJGfjiWOOemCUBaUOK8JXav4+cO4QCizhyCu5
	feeNDgbn+XNbor4OnI4WDZFpKxQp6LSdGQuv0iM=
X-Google-Smtp-Source: AGHT+IFw6ui7RKvOySfqcNYWm/9KsHzVK8NCh6DrCyO+hgtaUUqYO5d9lQ5UTiAmONH8I1X7ZbYO4U+ycwbN2h9KA0g=
X-Received: by 2002:a05:6820:2a18:b0:590:9027:7ab0 with SMTP id
 dr24-20020a0568202a1800b0059090277ab0mr24739293oob.0.1702928448299; Mon, 18
 Dec 2023 11:40:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218-topic-thermaldbg-v1-1-451bcb723e1d@linaro.org>
In-Reply-To: <20231218-topic-thermaldbg-v1-1-451bcb723e1d@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Dec 2023 20:40:37 +0100
Message-ID: <CAJZ5v0gkko7nWH2ePwEhbfXR-jAb9+f+rsfYXKBMSz04uW4rYg@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Print out thermal zone name on
 update_temperature error
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 3:40=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> Currently, we can encounter an error like this:
>
>   thermal thermal_zone48: failed to read out thermal zone (-19)
>
> It's good to know that there's been an issue, but on some occasions
> (like the error happening in the middle of a platform crash), one may
> not be able to look up what kind of thermal zone that is.
>
> Add the TZ name to the error message in order to speed up debugging.

s/name/type/ ?  It looks like that's what you mean.

First, the tz type is not its name (because there may be multiple
zones of the same type) and it would be consistent with the first
paragraph above.

>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 2415dc50c31d..a6ccf93eb34e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -403,8 +403,8 @@ static void update_temperature(struct thermal_zone_de=
vice *tz)
>         if (ret) {
>                 if (ret !=3D -EAGAIN)
>                         dev_warn(&tz->device,
> -                                "failed to read out thermal zone (%d)\n"=
,
> -                                ret);
> +                                "failed to read out thermal zone %s (%d)=
\n",
> +                                tz->type, ret);
>                 return;
>         }
>
>
> ---

