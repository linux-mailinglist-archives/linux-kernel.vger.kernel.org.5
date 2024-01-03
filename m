Return-Path: <linux-kernel+bounces-15556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17383822E1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410D21F20F94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1128199D4;
	Wed,  3 Jan 2024 13:15:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A019452;
	Wed,  3 Jan 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-595ffa2e6a2so145122eaf.0;
        Wed, 03 Jan 2024 05:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704287724; x=1704892524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfyvIelZW7mDBavaNQIQHDffrRYb1YXYXAAsZleBbOE=;
        b=eRQaOby+ZXtwzzjiWmmLp2OkjAUl3TkZFZPfXaCxm0nZq2lCN3kROV5dgy9ifKzOPl
         cCza1TA+zQ5wb+dOmQyDGMIbkmBerU+JhkwJFx6C+1Wy4A8qwhY+Fh6uOvgnZuKsUXMP
         JvaNXmsE/uSCFJlNL+AA8D5l89eBKlwpiOtZdnGfvYP9L207hEI78LyWj1jqXVMZJHbj
         1BGME0Kn3waUjF5uL+2q7jbARIcV49aUVlKhbb32NyWwtmyfR3HeYI3c07XYKSadxWRn
         tMBDMQZqclNVr/MKoK6rMlsCOKXp1AycRrsQ6QL+1CViDGZJCp7C6yywMzzg2qjBp7Us
         p2mg==
X-Gm-Message-State: AOJu0Yx8gZ210cAHbDOBkpcwsuRQD9zqwuGy/rXmawyxEyu9MJtOYeVP
	D2XeZ+FQdB3EiyV/NtewdbUa6OmXJuFV6EYBVC8=
X-Google-Smtp-Source: AGHT+IF6G9iejcCFuWF94TE+8OnDKLwTebZ4yYyxeEIo2WtUzbGVu9pAN1nfLuEeMt90lMGpJWYVY7neydiQir9EbFw=
X-Received: by 2002:a4a:b38c:0:b0:595:6024:c4f8 with SMTP id
 p12-20020a4ab38c000000b005956024c4f8mr7908752ooo.1.1704287724047; Wed, 03 Jan
 2024 05:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 14:15:12 +0100
Message-ID: <CAJZ5v0hDSgn5Cc_md0ZzCtriA21NcBf6WN49PgtVs1dgUSVsiw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] thermal: intel: hfi: Fix memory corruption on
 resume from hibernation
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, 
	Len Brown <len.brown@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 5:13=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Hi,
>
> This is v2 of this series. You can read the overview and motivation in th=
e
> cover letter of v1 [1].
>
> I smoke-retested this version on a Meteor Lake system. It completed 50
> cycles of suspend-to-disk and resume. I completed longer testing for v1.
>
> Changes since v1:
>  * Added locking to hfi_pm_notify() to serialize RMW operations on the
>    MSR_IA32_HW_FEEDBACK_CONFIG register. (Rafael)
>  * Relocated a comment regarding the reallocation of HFI memory to
>    patch 3/4. (Rafael)
>  * Clarified that patch 1/4 does not introduce functional changes.
>    (Rafael)
>  * Indicated the first stable version on which this patchset should be
>    backported.
>  * Renamed hfi_do_pm_[enable|disable]() as hfi_do_[enable|disable]() for
>    future reuse. (Stan)
>  * Registered the HFI suspend notifier towards the end of
>    intel_hfi_init(). (Stan)
>
> Thanks and BR,
> Ricardo
>
> [1]. https://lore.kernel.org/all/20231227062940.10780-1-ricardo.neri-cald=
eron@linux.intel.com/
>
> Ricardo Neri (4):
>   thermal: intel: hfi: Refactor enabling code into helper functions
>   thermal: intel: hfi: Enable an HFI instance from its first online CPU
>   thermal: intel: hfi: Disable an HFI instance when all its CPUs go
>     offline
>   thermal: intel: hfi: Add a suspend notifier
>
>  drivers/thermal/intel/intel_hfi.c | 153 +++++++++++++++++++++++++-----
>  1 file changed, 127 insertions(+), 26 deletions(-)
>
> --

I've queued up the first 3 patches from the series for 6.8 as they
make sense even without the [4/4] IMO.

I still have some comments on the last one, though, but let me reply
to it directly.

