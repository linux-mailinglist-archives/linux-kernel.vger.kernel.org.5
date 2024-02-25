Return-Path: <linux-kernel+bounces-80251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5E862C87
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57F51C20B62
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E9E18E28;
	Sun, 25 Feb 2024 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8yCu0fr"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7A1B7FB
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708887072; cv=none; b=DtbDndLnnL1uHik8I6Dfa70OLphdD5qvym2WXQOMQiRYfjNmTBmg/wpD3fUIH5pax+14efKY8qeOTy7NZbq2bSpY5l4vJwAMGzZ4v71HAET+9skf4/lJG1hu4GbTNHIO4/wNqNTqBmXOrDph58Zle9WnNSW3ngKbNIb8ytF5ar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708887072; c=relaxed/simple;
	bh=GcjXzUspWJyHWnXifYzzK/sflMFCO8s+VX1t10MLqac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fMkPov+L/t7ifqNGUCIqdhmkNsnLF65OVM37wnFkaZn7fi5agC6/yn/47f45WjPzcyd59JP4Kb6mjfmfSkFw8eKUER1Fw+ihtaZ6TOmFhFe8BR0w1ivpPKoAHp4QGMZbiPg21WprSl8UfjRM56MK3hvCLDZD/lhHGZYUCtTUV+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d8yCu0fr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dbe7e51f91so119525ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 10:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708887071; x=1709491871; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7KE24MU9eBDBjtTNbfc43uuaCFDb+3UMGms8jPvzDQ=;
        b=d8yCu0frenTOD+F9N7YYvm6/YatnRt6BJy0ft7ukkD+ibLUjghcBSK8UCExwF2aPAw
         WsAPuRFtayq4z/IxkinNvNLzPXqybsNC6PDHn5AG0MqqS+1pnjbuyt6PV7rrozGSx87K
         wG5gotrtq/ei3kEX+RGgZKIDYxk/TzxpnAuWFRQTEtpgR62ODYg3GsMFh/gsXkBiLvfG
         0J92vH5gjIcUI7A25ooeI5QnLNWgMhCzBIt6ERmp+LcMpNXsXpD4Gg5UXz0/nMQspm7L
         mIvhAlmqBWu4QP9PFH1ZdhE+YQxFF5ZHyt3LPQDWi2NceL0AauNo+a9f/wL9YfUdOZIx
         neOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708887071; x=1709491871;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7KE24MU9eBDBjtTNbfc43uuaCFDb+3UMGms8jPvzDQ=;
        b=h6cvm5lrrpHdyIdvnW8WPgp85OUN6ZBF2PKIFqNbeA4Wnj16QOvWx0oAde5A/PKplg
         GOrSKMW99CR9TMnLqZ+mw+tWR2eoU7R9XapcFflXIB8cW6E95CNSexIp/nOysVFu9I0e
         IE+3X3nnAnJCmehWZLYk8jhNzAujRjZBsrkZV9wAoPqgOYZE/eNq4VDUTDvTpXG/fEay
         LhIZc23lBgLjV3XRgFprwtbdM6p2AWGEf8PPjQ28ywpvyeqkQW9T0bv/FsAcXDVKtk+s
         hz/wlpqmSsH8ftvgrnCjRFe8G9ybRyrpho9sBhFLcEVE//OvIRU3wnHn1rEvdaKQp2Yh
         EVPw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ9QlQJJwx/ypG+Kv6HaTLwj2xFx1g0xunxRIxS59FYGsn4veAkYA5ymzV39hf6p+bLs2IfhrDIPd6WgsiS4t6xgth2+EziLg3CYig
X-Gm-Message-State: AOJu0YwTVQMbeVS8GInDErH/RCK8epajHJyEHcI+yuwi6W6YkGFTe3if
	5Jojiv6aQuWuxTFFdAYzwaSL92ftdWlZ1TmQPDg/Wzr2/lPXM0JgjewhMJHCsfY7fEvT1/aglnJ
	9dbtXWwuc+DAuWYUqdlrcPoy/wG/he6/cPwiP
X-Google-Smtp-Source: AGHT+IHlyeuRMm9XjLl4GPQEhwwJdCgz/3HCmZEfXLKbYFWdnA6DoDHqOg/2Z0w5L+na/YNYO5L72bfgxGPFrVwl8Sw=
X-Received: by 2002:a17:903:410c:b0:1db:90e9:43dd with SMTP id
 r12-20020a170903410c00b001db90e943ddmr237497pld.22.1708887070453; Sun, 25 Feb
 2024 10:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com>
In-Reply-To: <20240214063708.972376-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 25 Feb 2024 10:50:55 -0800
Message-ID: <CAP-5=fUhK9FaP4c5sSsM_DdNB+MipEvDDwO1e-n9fK5GLn87wA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Thread memory improvements and fixes
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> The next 6 patches from:
> https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
> now the initial maps fixes have landed:
> https://lore.kernel.org/all/20240210031746.4057262-1-irogers@google.com/
>
> Separate out and reimplement threads to use a hashmap for lower memory
> consumption and faster look up. The fixes a regression in memory usage
> where reference count checking switched to using non-invasive tree
> nodes.  Reduce threads default size by 32 times and improve locking
> discipline. Also, fix regressions where tids had become unordered to
> make `perf report --tasks` and `perf trace --summary` output easier to
> read.
>
> Ian Rogers (6):
>   perf report: Sort child tasks by tid
>   perf trace: Ignore thread hashing in summary
>   perf machine: Move fprintf to for_each loop and a callback
>   perf threads: Move threads to its own files
>   perf threads: Switch from rbtree to hashmap
>   perf threads: Reduce table size from 256 to 8
>
>  tools/perf/builtin-report.c           | 203 ++++++++-------
>  tools/perf/builtin-trace.c            |  41 +--
>  tools/perf/util/Build                 |   1 +
>  tools/perf/util/bpf_lock_contention.c |   8 +-
>  tools/perf/util/machine.c             | 344 +++++++-------------------
>  tools/perf/util/machine.h             |  30 +--
>  tools/perf/util/rb_resort.h           |   5 -
>  tools/perf/util/thread.c              |   2 +-
>  tools/perf/util/thread.h              |   6 -
>  tools/perf/util/threads.c             | 186 ++++++++++++++
>  tools/perf/util/threads.h             |  35 +++
>  11 files changed, 464 insertions(+), 397 deletions(-)
>  create mode 100644 tools/perf/util/threads.c
>  create mode 100644 tools/perf/util/threads.h

Arnaldo/Namhyung, anything outstanding that needs addressing in a v2?
I'm looking for reviewed-by/acked-by tags :-)

Thanks,
Ian

> --
> 2.43.0.687.g38aa6559b0-goog
>

