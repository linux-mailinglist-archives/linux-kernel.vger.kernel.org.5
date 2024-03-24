Return-Path: <linux-kernel+bounces-112574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF67887B9B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D451C20C29
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAD54439;
	Sun, 24 Mar 2024 04:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tIQnOy39"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAEA4691
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 04:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711252935; cv=none; b=h5RkAvtC3VWDkAaL0JWXmDN3FF7zYoVng9k2G5rdVEWD0cC6R9vuSDZIX9s2CLEtX91lhojGoJ08k7/bHis4n+SCi7Bv1olG1Z3Q4sNdAKaMHTHzt+xcOiaCZMkkotMgOldR+jQIiEdJaBLK+5R/3iYN9jJjcHW2ExnoVz++5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711252935; c=relaxed/simple;
	bh=5OZcy0cvcWpGXzari92vyjneWj/13af01epaD5LDZ3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qku2H00Z8G72GIFDAoqjguv4m4D0CbifDGkqka1k6jaxoPoL93n8aiI5aIuOtPbQbQ8IgbDk7z6H81bT8mvxe8RhoKouLQD6twaw3M4s6DxWMzp4W82+JBmugpCR63g6L19yK9V+QI19KDdatPHrsKuXYHCulAVjpn57PaoUtQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tIQnOy39; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e058b9e479so90285ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711252933; x=1711857733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FDuFqOuTc7gua+Z/Dt+h+8SW6PrKycoDzBI96oJTec=;
        b=tIQnOy396wUGj2lzd+3P8FFEKFRRKtpDGb7Ma9cP8+geupzcwJhJhLrX3Mly2CdYw9
         BXKRlYlbCPMyAKP/YiPwy0BGM6oo3reH7S8hd7XSzjdgM6/BnhIzl0YNOC6UkO2aNPNW
         txn/wjM+LYajXlJDoP2N6xs/A0FUkK4p9v19VVPh6ec5nzVpe4sm1mtGcV7jWgTezEj8
         81F46AwvqPJKVycl9bnIblypoYnYMpaOJKzfRzz6W/IjoHvwaww8vZqVnr9ycfFQgh8Y
         0XRu/YQqQsmXU0+AD2FIhAnSM/jL8rMigwXAB0jIa+HBZkBWivfu2/8IqNv9TDTpdWDb
         1G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711252933; x=1711857733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FDuFqOuTc7gua+Z/Dt+h+8SW6PrKycoDzBI96oJTec=;
        b=Udi2f1JFbCPPCMLnrUM3kzb0Osml/05tphxhrvSsGaLDeyfHHNGJ5Tsrc7z8Ak7i0F
         zsSqgy/DSFvu0lFtFYedeF4OheMLQe4r0xuWiA0yaexaotoyEE58Xd1HHJItsYUA4NoO
         nsaLA8O0tytfNaNpF0gOw/hqAC2CWoYKbo6YOmsdFLcUqCc64KEbdxkvIO2NaHEkxwtD
         SQikALRDpx37whNiOGZbu3wiwdRbhKEXtXdNmeg/F9PDaT+6SRtMTbrexJduSjVVWyIi
         z/yYOEWbzUKkk4j7sakeeY5G7ljYtT5gNpn99gYKY9rVvUBzviTZCla2lIQyqfijY4VG
         i3zQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2wYv5ZdWe2QNXBa6efW0piQQCJGYlVU+Y352H0y0hPOJqW4fwgp6Lwh2rEB4KPH3N5M6SbwdbIVmBmtWiDPx1bQtMKgc9m3mvDCQ+
X-Gm-Message-State: AOJu0Yx7ObneRMlvRnmvzDilQgXPQ5TphmZc/RHStnEemKErkia3bA3A
	rAE6l8pbJTn6SAGt5Jj9Ezi2o7GlEX2R4z6Ri9YWMKPsbWjTM4eO/d4H9zKWSWRS3WP5tqEpAdi
	NGayqXhz709gq2pCLOtB6BCxAydPqk3DZuwc4
X-Google-Smtp-Source: AGHT+IGpw6CBMCIKPJoL+FNoSt0LH9Pv1DCpGjkQRjLXoofQA7dcHtpiEELJCQ18HljSY7e6sgxLqKg2ERYdppEY+Nw=
X-Received: by 2002:a17:902:b218:b0:1e0:94a1:95b8 with SMTP id
 t24-20020a170902b21800b001e094a195b8mr316330plr.29.1711252932865; Sat, 23 Mar
 2024 21:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312234921.812685-1-weilin.wang@intel.com>
In-Reply-To: <20240312234921.812685-1-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 21:01:59 -0700
Message-ID: <CAP-5=fUbbX2LVTvqTvcbw=GPgvibMB8V0mpEx8zUrgYkXRq80A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/6] TPEBS counting mode support
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 4:49=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>

For the series, some nits noted on particular patches but otherwise:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Changes in v4:
> - Remove uncessary debug print and update code and comments for better
> readability and quality [Namhyung]
> - Update mtl metric json file with consistent TmaL1 and TopdownL1 metricg=
roup
>
> v3: https://lore.kernel.org/all/20240302001139.604829-1-weilin.wang@intel=
com/
>
> Weilin Wang (6):
>   perf stat: Parse and find tpebs events when parsing metrics to prepare
>     for perf record sampling
>   perf stat: Fork and launch perf record when perf stat needs to get
>     retire latency value for a metric.
>   perf stat: Add retire latency values into the expr_parse_ctx to
>     prepare for final metric calculation
>   perf stat: Create another thread for sample data processing
>   perf stat: Add retire latency print functions to print out at the very
>     end of print out
>   perf vendor events intel: Add MTL metric json files
>
>  tools/perf/builtin-stat.c                     |  211 +-
>  .../arch/x86/meteorlake/metricgroups.json     |  127 +
>  .../arch/x86/meteorlake/mtl-metrics.json      | 2551 +++++++++++++++++
>  tools/perf/util/data.c                        |    4 +
>  tools/perf/util/data.h                        |    1 +
>  tools/perf/util/metricgroup.c                 |   88 +-
>  tools/perf/util/metricgroup.h                 |   23 +-
>  tools/perf/util/stat-display.c                |   65 +
>  tools/perf/util/stat-shadow.c                 |   19 +
>  tools/perf/util/stat.h                        |    4 +
>  10 files changed, 3074 insertions(+), 19 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroup=
s.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics=
json
>
> --
> 2.43.0
>

