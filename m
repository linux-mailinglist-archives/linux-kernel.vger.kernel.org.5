Return-Path: <linux-kernel+bounces-13175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9A8200B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11798284911
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E68112B7E;
	Fri, 29 Dec 2023 17:15:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189E12B6A;
	Fri, 29 Dec 2023 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-590a21e977aso127016eaf.1;
        Fri, 29 Dec 2023 09:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703870114; x=1704474914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIpqBtiyNIjj1Q2v6I1K0k8F1dXNQa2RGr5h1JJcf7k=;
        b=RzPryYni45wVbODTuocutDmNeGxdwh77f2eu9Zp86aT51G+hKfqzkYBpzXST/NCYJ9
         Eh6EwcdfhbBNsfr7ENBwVNkqwiprA1Qju7PoqLppaiTaGVP/CNyJnGPk0Vv4g3JZzuOI
         9fcY39zy5pl1bfWSkNKfeqP2IDiGxiHTnXKbOvxkr/9tJVdpMcqQFPWmslMWDkwtI6Mn
         JDTt5U/eshMokrXFtbye2jB0MADHjnjqXEyhYYyye3/Cxi+M163r5jh78TY3to4H3gNG
         wGjo6D3nSXiwOQShUbrHGYGFk9/jEOuH1bDgGdsoahz9/nDzLg3gHHdE/A9EleO+2fjH
         SNLg==
X-Gm-Message-State: AOJu0YxBJnooGt7SfnJO79h2oEyLar6U0EcEQ/ncdU9PS2mfvbnCwDim
	FlrVVJ3kL2dSSQQRCSNCJDYL25kyIJ15fu1XIbc=
X-Google-Smtp-Source: AGHT+IHhAJbwOwKbh3BFqZeperr3t8NxfevGdnBCgkcjCUO2O/4Fl1RpsPvNDnQNrzD/r/2JzyATTKdaxLWx7n+HkNg=
X-Received: by 2002:a4a:dc96:0:b0:594:ad62:bab9 with SMTP id
 g22-20020a4adc96000000b00594ad62bab9mr10376974oou.1.1703870114307; Fri, 29
 Dec 2023 09:15:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220231753.1824364-1-lukasz.luba@arm.com>
In-Reply-To: <20231220231753.1824364-1-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Dec 2023 18:15:03 +0100
Message-ID: <CAJZ5v0gxdV4rUtcYM+c9eo9vA_=cW7Sn-Yk2Mo4ssjTMF0t-uQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Add callback for cooling list update to speed-up IPA
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, linux-pm@vger.kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:16=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi all,
>
> The patch set adds a new callback for thermal governors and implementatio=
n for
> Intelligent Power Allocator.
>
> The goal is to move some heavy operations like the memory allocations and=
 heavy
> computations (multiplications) out of throttle() callback hot path.
>
> The new callback is generic enough to handle other important update event=
s.
> It re-uses existing thermal_notify_event definitions.
>
> In addition there are some small clean-ups for IPA code.
>
> The patch set is based on current pm/bleeding-edge branch (20 Dec).
>
> changes:
> v3:
> - changed helper name to thermal_governor_update_tz() with also
>   "reason" argument (Rafael)
> - added thermal_governor_update_tz() to thermal_core.h for use from sysfs
>   functions
> - changed names of the events (THERMAL_TZ_BIND_CDEV) (Rafael)
> - patch 2/9 changed header and comment for function (Rafael)
> - patch 3/9: used unsigned types for num_actors, buffer_size (Rafael)
> - changed trace functions and added new patch 4/9 to be prepare tracing f=
or
>   different internal IPA array; it also drops dynamic array inside trace =
event
> - used new structure power_actor and changed the code in patch 5/9 (Rafae=
l)
> - keept the local num_actors variable (Rafael)
> - patch 6/9 skipped redundant parens and changed the header desc. (Rafael=
)
> - patch 7/9 changed header and used instance->tz->lock (Rafael)
> - patch 8/9 removed handle_weight_update() and renamed new event to
>   THERMAL_INSTANCE_WEIGHT_CHANGE (Rafael)
> - patch 9/9 aliged to use THERMAL_INSTANCE_WEIGHT_CHANGE is switch (Rafae=
l)
>
> v2 can be found here [1]
>
> Regards,
> Lukasz
>
> [1] https://lore.kernel.org/lkml/20231212134844.1213381-1-lukasz.luba@arm=
.com/
>
> Lukasz Luba (9):
>   thermal: core: Add governor callback for thermal zone change
>   thermal: gov_power_allocator: Refactor check_power_actors()
>   thermal: gov_power_allocator: Refactor checks in divvy_up_power()
>   thermal: gov_power_allocator: Change trace functions
>   thermal: gov_power_allocator: Move memory allocation out of throttle()
>   thermal: gov_power_allocator: Simplify checks for valid power actor
>   thermal/sysfs: Update instance->weight under tz lock
>   thermal/sysfs: Update governors when the 'weight' has changed
>   thermal: gov_power_allocator: Support new update callback of weights
>
>  drivers/thermal/gov_power_allocator.c | 269 ++++++++++++++++----------
>  drivers/thermal/thermal_core.c        |  14 ++
>  drivers/thermal/thermal_core.h        |   2 +
>  drivers/thermal/thermal_sysfs.c       |   7 +
>  drivers/thermal/thermal_trace_ipa.h   |  50 +++--
>  include/linux/thermal.h               |   7 +
>  6 files changed, 226 insertions(+), 123 deletions(-)
>
> --

All patches in the series applied as 6.8 material, with minor white
space adjustment in patch [8/9].

Thanks!

