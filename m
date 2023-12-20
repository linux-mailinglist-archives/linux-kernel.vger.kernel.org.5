Return-Path: <linux-kernel+bounces-7073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDD681A145
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD8028294B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560E13D3BD;
	Wed, 20 Dec 2023 14:40:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA83D384;
	Wed, 20 Dec 2023 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-594172c5785so2789eaf.0;
        Wed, 20 Dec 2023 06:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083218; x=1703688018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uPEe/PvV2yyHocYnPwV3SYIncthg+F3eKBKwNYbXFU=;
        b=ERjpMnXAbGc7CalrihyKkmTMRFzM2m0GQuibC0yF8GoLpBbYH6L737CmlF3q+wQLrk
         Yl8VwiMgQSIUSQafGG3+04SE31gfc2sdINBe4fvFwH2WjSsO2RNbiLgPMwr/qCTf3Oyb
         OLQVtrXXLnajndFoQqqA+LhMcJ/DmiJIK2eh5yen48JqEPKGt0owjPmkMpnBXCIHL+Oe
         5TkW5atcOeF2Durlqgf7KVMH6GUjcs4qmy6UwgfwhCahCtbufdMaybPj9pCejPBgKxdn
         h8pNYMwKdR01iujaa0IGlXydjYgv4zVgBDIA0A7n2QG61lAwKeSmNVSf5CQsXyxP7GnM
         HASw==
X-Gm-Message-State: AOJu0YwZmRfuY9ERCvU9wJBRFi2hISOmBjbfmVBSJgco1FaJgW2VMP10
	V/CzXC6OeTo90On4VRjdmC77jmA/3kUMiwjypGQ=
X-Google-Smtp-Source: AGHT+IHf6sLVJGTRYf+rJnQ5UNZC7SViAjxARHLltX3Tr0p/4tZyeTNxNauLV7oZvx02NqrZNjvysjnS4uVMTkWvhAw=
X-Received: by 2002:a05:6820:2484:b0:591:4861:6b02 with SMTP id
 cq4-20020a056820248400b0059148616b02mr23018350oob.1.1703083217730; Wed, 20
 Dec 2023 06:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212134844.1213381-1-lukasz.luba@arm.com> <20231212134844.1213381-5-lukasz.luba@arm.com>
In-Reply-To: <20231212134844.1213381-5-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2023 15:40:06 +0100
Message-ID: <CAJZ5v0g_+D5WV0kiC_guS4OQP4wb1qgw1xmzFQBhvF9fz4zxJQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] thermal: gov_power_allocator: Simplify checks for
 valid power actor
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, 
	linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 2:48=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> There is a need to check if the cooling device in the thermal zone
> supports IPA callback and is set for control trip point.
> Refactor the code which validates the power actor capabilities and
> make it more consistent in all places.

This really is about reducing code duplication which is worth
mentioning, so I would say

"Add a helper to check if a given cooling device in a thermal zone
supports the IPA callback and is bound to the control trip point and
use it wherever that check is needed to reduce code duplication."

>
> No intentional functional impact.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 41 +++++++++++----------------
>  1 file changed, 17 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 3328c3ec71f2..1a605fd9c8c6 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -85,6 +85,13 @@ struct power_allocator_params {
>         u32 *weighted_req_power;
>  };
>
> +static bool power_actor_is_valid(struct power_allocator_params *params,
> +                                struct thermal_instance *instance)
> +{
> +       return ((instance->trip =3D=3D params->trip_max) &&

The inner parens are redundant.

> +                cdev_is_power_actor(instance->cdev));
> +}

The part below LGTM.

