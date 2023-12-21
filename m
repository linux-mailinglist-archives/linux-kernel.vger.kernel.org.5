Return-Path: <linux-kernel+bounces-8500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D14481B8B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A54A0B24BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712507A236;
	Thu, 21 Dec 2023 13:38:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40CE77622;
	Thu, 21 Dec 2023 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2041426d274so47483fac.0;
        Thu, 21 Dec 2023 05:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703165932; x=1703770732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaaMP/Ehp6Ky92f3J2t9EYFK/YDZkcgDDuEjvhVl2BY=;
        b=ZAIvb4DJcRkkiawLLKrWKlG3Sjzb/1qFcqapWf8PrvOyJ2jgID41/qGLTrL68uDdOY
         KfVF0lhIGR63LhZS7HwBFk+4mUIresFC8cbO0Ef9cGYaiHYyq+8eXxkCxRNB392nLaUa
         O8NAqfxjhV3LRjEjCQMSFY0AFGq4N446qthjBbXNR1zy+asXmbRnYEoOXIBajUSW3+qa
         rBlB1nnP3lrXLkY2kXEUV85AgzrplxrLV/4jBJGeZBWQgPUtwFGPOF9Ng+dyEnDlDukx
         EwmG0NwtH+JVKf0udVSyYvb0xovTfOPJ58Zf5uBvDK4i17n8fH+9au4MElOWF8872a1B
         2INA==
X-Gm-Message-State: AOJu0YxLWUi7apNOLDvTdbWbipwyKZzvSWhfbROAOngkTk3R/FJyXRNE
	lxMGDVzhRemEzB/n8XyXD8KIQJufAWwHPecR7W0=
X-Google-Smtp-Source: AGHT+IEWfGXnteVaEGsZ4dSZy5VoCwSTyAhQ/LVEPotxyxKjxhkzmyUax+uh1rqFv0OFFYem5YrGs1FfgiOmeNJCR8I=
X-Received: by 2002:a05:6870:9591:b0:203:e5bc:154a with SMTP id
 k17-20020a056870959100b00203e5bc154amr9494813oao.2.1703165931637; Thu, 21 Dec
 2023 05:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 14:38:40 +0100
Message-ID: <CAJZ5v0g4D66c4mkHmKko+wdLbyRxXnaW77gKiDR42rX2NbzPKw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/26] Add thermal zones names and new registration func
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 1:48=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> ** This RFC was sent only to thermal API maintainers + reviewers on purpo=
se **
>
> As per previous discussion with Daniel [1], I've prepared this series add=
ing
> a new struct thermal_zone_device_params, used in a new registration funct=
ion
> for thermal zones thermal_zone_device_register(), deprecating and, finall=
y,
> replacing functions thermal_tripless_zone_device_register() and
> thermal_zone_device_register_with_trips().
>
> The new flow to register a thermal zone becomes the following:
>  - Declare a struct thermal_zone_device_params (`tzp` in this example)
>  - Fill in all the params (instead of passing all of them to a function)
>  - Call thermal_zone_device_register(tzp)
>
> Moreover, I've also introduced the concept of `name` for a thermal zone,
> and set, as suggested, a constraint for which:
>  - Multiple thermal zones can have the same `type` (so, no change), and
>  - A thermal zone's name must be *unique*.
>
> This should then help (in a later series?) to disambiguate thermal zone
> name vs type, as most of (if not all) the users seem to actually be
> misusing the TZ type referring to / using it as a TZ name.
>
> Please note that this series is currently a RFC because it's apparently
> growing bigger than I wanted - and because I probably have to add some
> more code on top. Before doing so, I'm trying to get feedback on what
> I've done until now.

And it is very unlikely that I will be able to provide any useful
feedback on this series before 6.8-rc1 is out.

Thanks!

