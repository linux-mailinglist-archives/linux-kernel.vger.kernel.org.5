Return-Path: <linux-kernel+bounces-148129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CDF8A7E19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCB61C20A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2A7EF1C;
	Wed, 17 Apr 2024 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAGmkfnp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46342A9E;
	Wed, 17 Apr 2024 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342125; cv=none; b=J60+eL7exOwV2wGuCAACBFMqG5/qT5e3/UdL7T2CYVidBp1oSr/uuTX3KdkZKTdTud4lJZ8kk1XeFrxXauk4Vv3Zq6sNYqa2uYCSAl3j5adofBROu8bngyeCiuTEWyuoAK0urmWfR6wSKFwLAnA2V5gFDcFBU4pb9zWlsUG1m8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342125; c=relaxed/simple;
	bh=fJVFKAtjU8PYRAWhhJNVZZwZkfGyLUmuVCnAzGjz4j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=II3GngGWtIo5mB4npL6STWs9j7DRC8JcoSMuot3y2vf1iabnqYJ4UdwjxpWNU8SnFLaOEnIiOM2Yc6zq5kfDN5dGsSnEjt3j/ZjAWh6nfz+lswCQwlIWzJEzJpL2XHjg2X6m7Wsm7XUfkffS/NfAvTYOMZ8ZA6lAJzWFI/2waWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAGmkfnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5B1C072AA;
	Wed, 17 Apr 2024 08:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342125;
	bh=fJVFKAtjU8PYRAWhhJNVZZwZkfGyLUmuVCnAzGjz4j4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SAGmkfnpE4X+tV9vTqzVGLoVe+966WhszV5WKsHiAPm9y7v7FBoZ9TIMrKb7AZ5ZV
	 5RMRU750/I1sNwrl1ebuSDezJFv92tID203AUvyq1yhELtM7ag0jx/ohSKzPH18bqW
	 eny4EyHnOqgHzFau4qN05PWedaKvf9T4D/ZPnk5r1TYJAq/jVVZOcjDgS5lEZgVSLX
	 9D3TmwdOlh5IHOJkT5spO1NVWFkBps95qDc0JmLnJ7WXm4YQdsiTpTOYe3llLLYLxP
	 3uqZAqr4OCry9JPXMmjB9mJ+TeI7Pq+Syd4uLXTZyNyuM/g5org0ZndbQE5WZgy0i0
	 Ir/IwIuYCZPZg==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6eba841d83bso82579a34.3;
        Wed, 17 Apr 2024 01:22:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWswXqcafgpMTAh/1lBzyYGkNQEpl6tKXKkeWBU8b1/sO5FPAkY4GAMWC9mYPUi5qkGS9X1WoLdlnbd+iJ5CLj3CRFbkOi8ToE=
X-Gm-Message-State: AOJu0YwshVtYFnBZyl07l8C2DfPSZoUNKt+rlDXGb7yixrVM1Qe6itix
	jwIVWUfQ6PvjHAPaWRRnOfhsuXWFLlQ1BAQuCrW7Ckytb07/pSEE1eTbunqFtqFdcep3pgbq1Xa
	Ett37umpzReU2cfKJXKj6X8EWqNo=
X-Google-Smtp-Source: AGHT+IGOxdBQGozU3hYW410deWZT982OPluZf8gphKnDc/jI4f4/4FO3e+MUIIEUFwb/5B1vFl+v0fy1UzyxDGXysDY=
X-Received: by 2002:a4a:e9f0:0:b0:5aa:6a31:4f53 with SMTP id
 w16-20020a4ae9f0000000b005aa6a314f53mr13550136ooc.0.1713342124603; Wed, 17
 Apr 2024 01:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416211941.9369-1-tony.luck@intel.com> <20240416212243.9910-1-tony.luck@intel.com>
In-Reply-To: <20240416212243.9910-1-tony.luck@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 10:21:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hgyKxxA-fVjn_1NsSmm7yTOY1HPdpxTk3NL=sFpvWCOQ@mail.gmail.com>
Message-ID: <CAJZ5v0hgyKxxA-fVjn_1NsSmm7yTOY1HPdpxTk3NL=sFpvWCOQ@mail.gmail.com>
Subject: Re: [PATCH v3 66/74] x86/cpu/vfm: Update drivers/powercap/intel_rapl_common.c
To: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:22=E2=80=AFPM Tony Luck <tony.luck@intel.com> wr=
ote:
>
> New CPU #defines encode vendor and family as well as model.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/powercap/intel_rapl_common.c | 118 +++++++++++++--------------
>  1 file changed, 59 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index a28d54fd5222..59c36ea55712 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1220,65 +1220,65 @@ static const struct rapl_defaults rapl_defaults_a=
md =3D {
>  };
>
>  static const struct x86_cpu_id rapl_ids[] __initconst =3D {
> -       X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,         &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,       &rapl_defaults_co=
re),
> -
> -       X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,           &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,         &rapl_defaults_co=
re),
> -
> -       X86_MATCH_INTEL_FAM6_MODEL(HASWELL,             &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,           &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,           &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,           &rapl_defaults_hs=
w_server),
> -
> -       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,           &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,         &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,         &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,         &rapl_defaults_hs=
w_server),
> -
> -       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,             &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,           &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           &rapl_defaults_hs=
w_server),
> -       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,          &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,            &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,        &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,           &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,             &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,        &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           &rapl_defaults_hs=
w_server),
> -       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           &rapl_defaults_hs=
w_server),
> -       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,         &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,           &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,         &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,           &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,          &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,      &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,        &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,          &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,        &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_defaults_sp=
r_server),
> -       X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,     &rapl_defaults_sp=
r_server),
> -       X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,         &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,           &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl_defaults_co=
re),
> -
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,     &rapl_defaults_by=
t),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,        &rapl_defaults_ch=
t),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, &rapl_defaults_tn=
g),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,    &rapl_defaults_an=
n),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,       &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,  &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,     &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,        &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,      &rapl_defaults_co=
re),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,      &rapl_defaults_co=
re),
> -
> -       X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &rapl_defaults_hs=
w_server),
> -       X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &rapl_defaults_hs=
w_server),
> +       X86_MATCH_VFM(INTEL_SANDYBRIDGE,        &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,      &rapl_defaults_core),
> +
> +       X86_MATCH_VFM(INTEL_IVYBRIDGE,          &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_IVYBRIDGE_X,        &rapl_defaults_core),
> +
> +       X86_MATCH_VFM(INTEL_HASWELL,            &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_HASWELL_L,          &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_HASWELL_G,          &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_HASWELL_X,          &rapl_defaults_hsw_server=
),
> +
> +       X86_MATCH_VFM(INTEL_BROADWELL,          &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_BROADWELL_G,        &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_BROADWELL_D,        &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_BROADWELL_X,        &rapl_defaults_hsw_server=
),
> +
> +       X86_MATCH_VFM(INTEL_SKYLAKE,            &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_SKYLAKE_L,          &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_SKYLAKE_X,          &rapl_defaults_hsw_server=
),
> +       X86_MATCH_VFM(INTEL_KABYLAKE_L,         &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_KABYLAKE,           &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_CANNONLAKE_L,       &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ICELAKE_L,          &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ICELAKE,            &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ICELAKE_NNPI,       &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ICELAKE_X,          &rapl_defaults_hsw_server=
),
> +       X86_MATCH_VFM(INTEL_ICELAKE_D,          &rapl_defaults_hsw_server=
),
> +       X86_MATCH_VFM(INTEL_COMETLAKE_L,        &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_COMETLAKE,          &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_TIGERLAKE_L,        &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_TIGERLAKE,          &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ROCKETLAKE,         &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ALDERLAKE,          &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ALDERLAKE_L,        &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,     &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_RAPTORLAKE,         &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_RAPTORLAKE_P,        &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_RAPTORLAKE_S,       &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_METEORLAKE,         &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_METEORLAKE_L,       &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,   &rapl_defaults_spr_server=
),
> +       X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,    &rapl_defaults_spr_server=
),
> +       X86_MATCH_VFM(INTEL_LUNARLAKE_M,        &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ARROWLAKE,          &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_LAKEFIELD,          &rapl_defaults_core),
> +
> +       X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,    &rapl_defaults_byt),
> +       X86_MATCH_VFM(INTEL_ATOM_AIRMONT,       &rapl_defaults_cht),
> +       X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &rapl_defaults_tng),
> +       X86_MATCH_VFM(INTEL_ATOM_AIRMONT_MID,   &rapl_defaults_ann),
> +       X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,      &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS, &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,    &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ATOM_TREMONT,       &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,     &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,     &rapl_defaults_core),
> +
> +       X86_MATCH_VFM(INTEL_XEON_PHI_KNL,       &rapl_defaults_hsw_server=
),
> +       X86_MATCH_VFM(INTEL_XEON_PHI_KNM,       &rapl_defaults_hsw_server=
),
>
>         X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
>         X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
> --
> 2.44.0
>

