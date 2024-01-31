Return-Path: <linux-kernel+bounces-47104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E81844946
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC161F21A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EA238FB2;
	Wed, 31 Jan 2024 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="29M2zCY+"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC138FA5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734708; cv=none; b=AVLamaydUZLblpkW+AWwlPF1gTeiHrIvperPxILjm+LnF2Hq96TaK06Go++Oko2LYhWhrP6vhIuzSOAYA5bAI0m6bGkeTShfDa1jsWkLCkOKqjsxVkDAmPcgV1y5XX4afogRhY2cUHlxbn30I2Gvikl1mMgYj5u35oDOqZJ1ap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734708; c=relaxed/simple;
	bh=DQIAR3a2+GYSJd/qP7x5sqbp+FJ423c005JG3hn6MVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELzvnP+ELPxKDV84TxMTfIwHTFGZigJqvpe6nvUcyPs8wjPooyHGdLs2aXVYUwkIv4rPX9wE98/W2Wo0bvBqZnwJzcjQejlvnXRCCQS+nWG/bnEs1MKBCsG/D9ay6y2KQudsjkQ1fbDOl580rtIiUHAhdC7I3mO6H7I2fDhtHJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=29M2zCY+; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3638fa55e4aso3615ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706734706; x=1707339506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cRMWGaZe17hqgsRkYRErhUDWc8ajpBRBvwzmEJlT7E=;
        b=29M2zCY++xBVl0DPKKuH7vkQ8R/BlGQH64R3PdACzMLzZUjER0OSQp+haOsxd3iY3d
         VgPNAGBvYcgL+vyy1mBFZrSbUrMAx4Ex47jvtLXg9s/GFelT+GNUHAkSo3q5rVTuvJVF
         9uhNObyiDME1LAlhFf8R20D90446MYNGUsleE+Q2XTwwnjmxDLw0+TJLjDz0d3c1sUEp
         gpeOyskYbcL3kuWRdbT8jm7+iN7/XloiV6MXr9xRRM/TBhtZF0R52k8KXIhKj95V2T3w
         U9HYseeFp6n+jHFDyXNf8IUuLh7S1fFVTF8xtrlq9a+SSyjZ0P0ejjlAhXw3YYrU6mYj
         iA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734706; x=1707339506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cRMWGaZe17hqgsRkYRErhUDWc8ajpBRBvwzmEJlT7E=;
        b=ZxVCgmSzDYahnQ3GsBZS8P4t23XHHzzYCIhY104fsq4sHYOMK/T75SEVdFsWzdBvEu
         lDL0S063QrYN5yxOKV2HiiHrIFqNb0+MwX99C1CCIVw010YiM4AD62DS0SDGkAG0qIoL
         Ccs9bfmASsahMV+W6QrSXCFnQg8QD3UqPZHE6HkVnGmJhc0lJyjHyXlz0AdD1R6yRvfC
         Aqd57DUsC89TPuox+79c58urlaEXM7yt/1iShHGsMJEf29ki0oiNJZA1VfmXTM0gvX9C
         ueHH9Qsp7zFoReOrcsHD8I/HCKmLbCubqawevrkbGCSKU3mI9wOAjG3nSh3HQM3/8e6A
         yvkg==
X-Gm-Message-State: AOJu0YxSxCFdI5dbGgv4hJifbRngKFtAtfJlCvZYro5b2Vg22cVQWcor
	U0eu5MqRc3UM7PUxw+up+Z55zGehHiq8HU2SXI1RZXPvHUfbWbID2/5tR/pvWmVbLtUtxd5/TG5
	g996LZUZsLbvT0Is/SQbfQQ92IHWoT0aPGYFFgSmLqhS/GiVihN88
X-Google-Smtp-Source: AGHT+IHjNx6A6wJxelPQj5uYeilAH5UzbelaEdF4jDA7IV9uDC2jkjXNsExtVdzPX0JIPD2pkkoMwY3vfI7cBCg9MYE=
X-Received: by 2002:a05:6e02:388e:b0:363:7bf7:4211 with SMTP id
 cn14-20020a056e02388e00b003637bf74211mr12715ilb.7.1706734706299; Wed, 31 Jan
 2024 12:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131192416.16387-1-adrian.hunter@intel.com>
In-Reply-To: <20240131192416.16387-1-adrian.hunter@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jan 2024 12:58:12 -0800
Message-ID: <CAP-5=fUrTzkAfXoto1P8SnTFApSSdt+mmWHCXSKVrr0kuphE0w@mail.gmail.com>
Subject: Re: [PATCH] perf test: Enable Symbols test to work with a current
 module dso
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 11:24=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
com> wrote:
>
> The test needs a struct machine and creates one for the current host,
> but a side-effect is that struct machine has set up kernel maps
> including module maps.
>
> If the 'Symbols' test --dso option specifies a current kernel module,
> it will already be present as a kernel dso, and a map with kmaps needs
> to be used otherwise there will be a segfault - see below.
>
> For that case, find the existing map and use that. In that case also,
> the dso is split by section into multiple dsos, so test those dsos
> also. That in turn, shows up that those dsos have not had overlapping
> symbols removed, so the test fails.
>
> Example:
>
>   Before:
>
>     $ perf test -F -v Symbols --dso /lib/modules/$(uname -r)/kernel/arch/=
x86/kvm/kvm-intel.ko
>      70: Symbols                                                         =
:
>     --- start ---
>     Testing /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko
>     Segmentation fault (core dumped)
>
>   After:
>
>     $ perf test -F -v Symbols --dso /lib/modules/$(uname -r)/kernel/arch/=
x86/kvm/kvm-intel.ko
>      70: Symbols                                                         =
:
>     --- start ---
>     Testing /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko
>     Overlapping symbols:
>      41d30-41fbb l vmx_init
>      41d30-41fbb g init_module
>     ---- end ----
>     Symbols: FAILED!
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/symbols.c | 68 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
> index 16e1c5502b09..2fed6d67f50f 100644
> --- a/tools/perf/tests/symbols.c
> +++ b/tools/perf/tests/symbols.c
> @@ -41,6 +41,30 @@ static void exit_test_info(struct test_info *ti)
>         machine__delete(ti->machine);
>  }
>
> +struct dso_map {
> +       struct dso *dso;
> +       struct map *map;
> +};
> +
> +static int find_map_cb(struct map *map, void *d)
> +{
> +       struct dso_map *data =3D d;
> +
> +       if (map__dso(map) !=3D data->dso)
> +               return 0;
> +       data->map =3D map;
> +       return 1;
> +}
> +
> +static struct map *find_module_map(struct machine *machine, struct dso *=
dso)
> +{
> +       struct dso_map data =3D { .dso =3D dso };
> +
> +       machine__for_each_kernel_map(machine, find_map_cb, &data);
> +
> +       return data.map;
> +}
> +
>  static void get_test_dso_filename(char *filename, size_t max_sz)
>  {
>         if (dso_to_test)
> @@ -51,6 +75,26 @@ static void get_test_dso_filename(char *filename, size=
_t max_sz)
>
>  static int create_map(struct test_info *ti, char *filename, struct map *=
*map_p)
>  {
> +       struct dso *dso =3D machine__findnew_dso(ti->machine, filename);
> +
> +       /*
> +        * If 'filename' matches a current kernel module, must use a kern=
el
> +        * map. Find the one that already exists.
> +        */
> +       if (dso && dso->kernel) {
> +               *map_p =3D find_module_map(ti->machine, dso);
> +               dso__put(dso);
> +               if (!*map_p) {
> +                       pr_debug("Failed to find map for curent kernel mo=
dule %s",
> +                                filename);
> +                       return TEST_FAIL;
> +               }
> +               map__get(*map_p);
> +               return TEST_OK;
> +       }
> +
> +       dso__put(dso);
> +
>         /* Create a dummy map at 0x100000 */
>         *map_p =3D map__new(ti->machine, 0x100000, 0xffffffff, 0, NULL,
>                           PROT_EXEC, 0, NULL, filename, ti->thread);
> @@ -97,6 +141,26 @@ static int test_dso(struct dso *dso)
>         return ret;
>  }
>
> +static int subdivided_dso_cb(struct dso *dso, struct machine *machine __=
maybe_unused, void *d)
> +{
> +       struct dso *text_dso =3D d;
> +
> +       if (dso !=3D text_dso && strstarts(dso->short_name, text_dso->sho=
rt_name))
> +               if (test_dso(dso) !=3D TEST_OK)
> +                       return -1;
> +
> +       return 0;
> +}
> +
> +static int process_subdivided_dso(struct machine *machine, struct dso *d=
so)
> +{
> +       int ret;
> +
> +       ret =3D machine__for_each_dso(machine, subdivided_dso_cb, dso);
> +
> +       return ret < 0 ? TEST_FAIL : TEST_OK;
> +}
> +
>  static int test_file(struct test_info *ti, char *filename)
>  {
>         struct map *map =3D NULL;
> @@ -124,6 +188,10 @@ static int test_file(struct test_info *ti, char *fil=
ename)
>         }
>
>         ret =3D test_dso(dso);
> +
> +       /* Module dso is split into many dsos by section */
> +       if (ret =3D=3D TEST_OK && dso->kernel)
> +               ret =3D process_subdivided_dso(ti->machine, dso);
>  out_put:
>         map__put(map);
>
> --
> 2.34.1
>

