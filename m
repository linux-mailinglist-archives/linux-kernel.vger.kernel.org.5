Return-Path: <linux-kernel+bounces-100730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F6879C71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1741F24170
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86A3142652;
	Tue, 12 Mar 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tljUnGRC"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84BD1E53F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273387; cv=none; b=lic+EVkBiGAAiwrJyjbkiKMpwCgkcPZVdjJ6I31mtjaXOlayo7vB75TvM4+npIicqE/XcufQYRgizGTRbgNspTOGjPoPm6R4B84ME6ZVr19R7nlJoH0OwbFAolsX/1rn2TKXkcUoLuQxEG08jbbQ4QVPsTRmucsHwTUl5S5nIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273387; c=relaxed/simple;
	bh=JpCfWmE3gZ134IFjyr24O/ViKidoaAIpyYk5Xdh/x70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkqzBJIB/4nUlNb1NV9/41wv16I/JhsRurjC9GyLtpUfa1YCqSDgdlXsFBXo6iCtKd1uyQw6yaiFKXUC1/CIapZpabFWoazDXy+iwt0LoTxOvJ1FfdeKqm97oJttGAKHrjH3jErFwCCTBJk+ynou48LcHWxrOLvjFQOCLpdAsc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tljUnGRC; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36645c1169cso28605ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710273385; x=1710878185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hf5HSohkhQcxAR7Z7ENUcmxxLo3lTcaUMn5gqzq++Kk=;
        b=tljUnGRC4WM8+MbRu/n/q3a0kauBZw0DWdItMfnVylmT1iJCMn0Di4Ps2iMCRkzxwW
         XTckUE8ycXSKLacd90G4+gF0IWGSQFsMSM0qJffNEB6AMj5A/2xtTCT8xl5c/7w/aqVZ
         GYFXrgYLzqUNIQt+N59bpnmQ7pNIQhA0PcZ9oOJnq+toyKAvEyM5yOhPhQm70jFIOW27
         n6py1/rI9tNCOydWi/kn7/cFDAsZMuwb7Wv3tSZQl26yW6mfpV2tW3qQUC4EPzDet2EJ
         9En2r5vyz7GN51kXpwbSUK1Wjf9Z081SNX6aLZRwAUuqr/NapDiDVM6XxsWtq9SHlRdC
         eMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710273385; x=1710878185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hf5HSohkhQcxAR7Z7ENUcmxxLo3lTcaUMn5gqzq++Kk=;
        b=TSWOYut3offg1eCf7T7VuT9YYGuyq/Ma/PjsDvFKsHfe+Pra7Soa+m7ongpUT0SIIQ
         bFPYJHyHv5Pb22fobDq4lFb54M5vEQ6VCZFG7Ag5G53nIUDDdkaCPj7dJ5518B4CYKZC
         PJVH2U0gG5CJJaW2RwIvwYGYYAkNq1rj6Mo2fStfr4B/Pq985xiSbXmq6g6khoV9UMKn
         E66LC7/H2b6TFkytbWnvWGAuNQIZGRQkKaSq4hnlUzGIxvTo0SPYNoLcGLDdxHWiH7he
         wdiQuLmNir4XEH4i5sPxwA/hQHAcoPr9n9dCI2tr/fTkMj3fTFKzTCCl9xsVpuslhjAA
         T8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJPKCsgzrShonQAS5EaBsQJet8UD/3rQZiDtoLGICAomtShw5wF0nl3FFDzsm66vMvCO/zip8OuI8L0a2JYXGPDlNz4WPzXgHdARXh
X-Gm-Message-State: AOJu0Ywx6FqdB5zM9zkOp4kqrNmrnYjv1EnfcinYEDizaPZIJcbIfw/t
	AYo8S133RqowrSARrj6ZsyxdcMc4zVW6mMARe0oCjL83Z6hYW+USjUWCAIEJavEdk/P3iiqIDdp
	Fg5lte9VY4+324/lLwvOQfVdvONJARmDIcsoZ
X-Google-Smtp-Source: AGHT+IHyoeIdKrv8xlOiCMcXvMsqVvCAyCjtoVw8/VI11YoxqgZF3CePzvE2XLiX5frxi7ieRR/RreuyYCdjvTpOMF8=
X-Received: by 2002:a05:6e02:1787:b0:363:db1c:22ef with SMTP id
 y7-20020a056e02178700b00363db1c22efmr18997ilu.24.1710273384776; Tue, 12 Mar
 2024 12:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312132508.423320-1-james.clark@arm.com>
In-Reply-To: <20240312132508.423320-1-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Mar 2024 12:56:09 -0700
Message-ID: <CAP-5=fWGrkjx1vz+2aQU0A+_B3d=nCtK9WBGiSPbDbUaTXR4pQ@mail.gmail.com>
Subject: Re: [PATCH] perf docs: arm_spe: Clarify more SPE requirements
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 6:25=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> The question of exactly when KPTI needs to be disabled comes up a lot
> because it doesn't always need to be done. Add the relevant kernel
> function and some examples that describe the behavior.
>
> Also describe the interrupt requirement and that no error message will
> be printed if this isn't met.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-arm-spe.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Docum=
entation/perf-arm-spe.txt
> index bf03222e9a68..0a3eda482307 100644
> --- a/tools/perf/Documentation/perf-arm-spe.txt
> +++ b/tools/perf/Documentation/perf-arm-spe.txt
> @@ -116,6 +116,15 @@ Depending on CPU model, the kernel may need to be bo=
oted with page table isolati
>  (kpti=3Doff). If KPTI needs to be disabled, this will fail with a consol=
e message "profiling buffer
>  inaccessible. Try passing 'kpti=3Doff' on the kernel command line".
>
> +For the full criteria that determine whether KPTI needs to be forced off=
 or not, see function
> +unmap_kernel_at_el0() in the kernel sources. Common cases where it's not=
 required
> +are on the CPUs in kpti_safe_list, or on Arm v8.5+ where FEAT_E0PD is ma=
ndatory.
> +
> +The SPE interrupt must also be described by the firmware. If the module =
is loaded and KPTI is
> +disabled (or isn't required to be disabled) but the SPE PMU still doesn'=
t show in
> +/sys/bus/event_source/devices/, then it's possible that the SPE interrup=
t isn't described by
> +ACPI or DT. In this case no warning will be printed by the driver.
> +
>  Capturing SPE with perf command-line tools
>  ------------------------------------------
>
> @@ -199,7 +208,8 @@ Common errors
>
>   - "Cannot find PMU `arm_spe'. Missing kernel support?"
>
> -   Module not built or loaded, KPTI not disabled (see above), or running=
 on a VM
> +   Module not built or loaded, KPTI not disabled, interrupt not describe=
d by firmware,
> +   or running on a VM. See 'Kernel Requirements' above.
>
>   - "Arm SPE CONTEXT packets not found in the traces."
>
> --
> 2.34.1
>

