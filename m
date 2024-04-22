Return-Path: <linux-kernel+bounces-153897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBF18AD4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506FB1F21B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCD7155346;
	Mon, 22 Apr 2024 19:10:33 +0000 (UTC)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE9155307;
	Mon, 22 Apr 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813033; cv=none; b=P4zgLNT6S7QjFL6ymFrS3BIEg3UtYcthEaarmdMr46VgYKpH0mw3EOIa7s/XrRsqFqrT3Yo0xLFo6zQ/UjmbwsUn4avE9akFnoY7YfroUo9BOqVet09tdwhuHH5WH675nQZWcgped0O8MSnTANzCS2JSS74Y1UzRK9JpYGelmuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813033; c=relaxed/simple;
	bh=rJvNMMHsO9zI75ghumCSbMliEXPSfFf/Qdfo1bBdBNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwnbDGIROWp2O+aSQftOpAPFm05qQeDgVsOqW40jaXoqhuo2DezwX6SXz7PQlu5HytIZUA4ort/kIdj2kV8Wb3H0u1XzX3spsOfjOELEDJxpT/Bnp0PD+LrbZmofsX7w77LMS7CtkbJi3qwmlqZ+eCSLqPKQ1W6mOQ06ABaNHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7e128b1ba75so980274241.3;
        Mon, 22 Apr 2024 12:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713813031; x=1714417831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FT090QG4mPbWzxLW5ioWJKU6VIVek0mS/v6uLtJKrhY=;
        b=xLzcQ/NiGORsxb2ZPUaVv1w9ATf9uEktUoG2bo9MkpKNBoeikfk64CLDNQlPQA4wId
         0BG15IpUArg+GWSUhHoqTyH2dOyLUOhmjSDzYAYLatU84+z1MekM2dM7Z9qfioRdyG6T
         5oLU2iYGREdOWMQwmIMY2hcqo6QJYvLBcrlhbGDtQF6f6ZmkyFOLIob2lpYlpHMCGx2j
         xsrBPvofsu3118myiW3c6ZFnnaC0sJFdEgxsHj34HIlUDEIXzItC39zFOgEb6PKGpgf8
         PS3qzVcryO3wqN4CG/kJ+kMB8xLW0+uAbpX/OF9M7SPBKEqmKpa0NBWI7dmGPvztn3Db
         OBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAk2SG9yeCRtVgPyA6yG/E+OVyZMd6xiR9wU/gGAjdL7VEpxf+CPnTSTWqpJK3o1N02wpo2jWTm5Jm+qjOcvLwbTLwOLUYEXRHtI+e27NyJ43lyNTWuguQYO9kAqeTMzj8mRntz2MY/a2JtO5yUA==
X-Gm-Message-State: AOJu0YzHQABw4/gxJZseeIFaOSbDENMNr4id9k1XxcXrl/9E6vcrzLxP
	rlLtIo9jSH8tG2ae/0U0u8fINkq+1DdO6JWd37Aw++yYGNJGXeIenf/PcWjdnsvpUGvJ9g4l1IY
	CtO1X+UoWdrLdnMnGpFUUTkpzvXo=
X-Google-Smtp-Source: AGHT+IHyHQTsUzROmqN6jnX/24w46La9WBiStlAq0xOe5OA9QNeAcfTayUuiYweOgOQTpr6p0ouM4uwoD4CughfZ5ak=
X-Received: by 2002:a05:6122:318b:b0:4d4:15d2:8b3b with SMTP id
 ch11-20020a056122318b00b004d415d28b3bmr12316812vkb.9.1713813030859; Mon, 22
 Apr 2024 12:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402214436.1409476-1-weilin.wang@intel.com>
In-Reply-To: <20240402214436.1409476-1-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 22 Apr 2024 12:10:18 -0700
Message-ID: <CAM9d7cj2EbxWVLHU3XPf_F2OzWRVRfSV2TghNA+h8noDztrasQ@mail.gmail.com>
Subject: Re: [RFC PATCH v7 0/6] TPEBS counting mode support
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Weilin,

On Tue, Apr 2, 2024 at 2:45=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Changes in v7:
> - Update code and comments for better code quality [Namhyung]
> - Add a separate commit for perf data [Namhyung]
> - Update retire latency print function to improve alignment [Namhyung]
>
> v6: https://lore.kernel.org/all/20240329191224.1046866-1-weilin.wang@inte=
l.com/

In general, I think you need to explain what exactly TPEBS is and why
you want to do this for TPEBS.  Maybe somewhere in the documentation.

Thanks,
Namhyung

>
> Weilin Wang (6):
>   perf stat: Parse and find tpebs events when parsing metrics to prepare
>     for perf record sampling
>   perf data: Allow to use given fd in data->file.fd
>   perf stat: Fork and launch perf record when perf stat needs to get
>     retire latency value for a metric.
>   perf stat: Add retire latency values into the expr_parse_ctx to
>     prepare for final metric calculation
>   perf stat: Add retire latency print functions to print out at the very
>     end of print out
>   perf vendor events intel: Add MTL metric json files
>
>  tools/perf/builtin-stat.c                     |  249 +-
>  .../arch/x86/meteorlake/metricgroups.json     |  127 +
>  .../arch/x86/meteorlake/mtl-metrics.json      | 2551 +++++++++++++++++
>  tools/perf/util/data.c                        |    7 +-
>  tools/perf/util/metricgroup.c                 |   87 +-
>  tools/perf/util/metricgroup.h                 |   22 +-
>  tools/perf/util/stat-display.c                |   69 +
>  tools/perf/util/stat-shadow.c                 |   19 +
>  tools/perf/util/stat.h                        |    4 +
>  9 files changed, 3115 insertions(+), 20 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroup=
s.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics=
json
>
> --
> 2.43.0
>
>

