Return-Path: <linux-kernel+bounces-46843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F18844543
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804F4293FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7101512FF72;
	Wed, 31 Jan 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJDU9pwu"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7412CD8E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720000; cv=none; b=NznYkAQsXN1MpSlgNNd8DTUhycDnXtLuYjmyn2nHhjAn2Z/Eazplx8nlTL5TrAYhBUz/pAJAFnTV3cyby/UhvGV+wi+2V2VbVFMt1zRLKG5OPyFD7e1onfzzfSFYP//nwuph2T3f0fnh3HXGVj7s10VSQHZ27Jit81mqKxJv/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720000; c=relaxed/simple;
	bh=5ywzRswissfPoaz3gVx2xuLLVjU6sVIFulHNw/8BM30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbsIqqmeX3+5kSr4H9n6geshhLwZckMUFiaWfdZlR4NTvrknUWvVjOhQ2SffnlBsEGvMQU7H29TTC6Ulfkvjhg18QzmG4Nn5BgmNO4Rmb9CdzyvtLW3x5CQ7MNYqC0tXNCg+HtUboZ2KWdW8G19dVP/dSYtErbPiafeGv3VA+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJDU9pwu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d89f0ab02bso118495ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706719998; x=1707324798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvpSV43rWUbyYM7/B2V4hGiTICXwiFlKZ/puS1sh6dc=;
        b=YJDU9pwuhBv9fzzd6/ZXDVfVEOccQ3NwQKPoCvM+Fie7C8U62APFXMK0qhSTZ0kbE4
         Hqh2ZRK70ZAbqKembA9bWZuVyoeuZ1wghMAoZVV3LbHQPdNCH2q/ik7VT+DiMjHFqv8D
         xYgt7P1buGOVFRGG9GUQ6+kVx4k4canRCoVq5mu72LVbK4w+1Jjxnno5PDU7aRFm6itG
         FPJYhJ63JZ/dGh4DMWadivwU/5YKQy2996yo8QeFb7nmKeEjDBC63AGveQ6+DsZ72XjK
         vYJmrX2sRV2wGuathPpzWwxFyZk58TdIFJASUccPkKqjfUedevMF2bynHdOEVSUMTwMq
         gwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706719998; x=1707324798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvpSV43rWUbyYM7/B2V4hGiTICXwiFlKZ/puS1sh6dc=;
        b=MAObkFVtZvQGR5f6wZdMrtTFE8tbLiMaXAlf6AEx9Gszcnyl7wf1YtkktxNgNjR4eG
         gzsEEtBcR7qSXMMFY+kffkVF1nyzoxC66t1K1fDZbeZHxmsbN8EwXaeYW+hTfno7DTmh
         6EWLbaXgdew58PFlmYcDh4IqVabuS5G5iMK8xMf/nfc798gXw+dLVMyRuwPjbsQRGyzd
         lsTapi7CwZPyfINlwodbo8fwStAy+q9X/e7fvwk13dftFAJdQ9uNOzrkeNdTmRWaCCki
         //FcmtgjYq+Di9cYmcSAWp+DewxxUxMg38phMP6ZbfxNEMxiTgdBGOfcR2skmCP7hzLT
         S3gQ==
X-Gm-Message-State: AOJu0YzoF9jWxgjLkHbFmhgZTIR3QUNWiSsgXwN2K3uFZRMKFgylQgsN
	Kc7zx1Mh1l9Zby/SJp6qWuht/5HzKonqJ7VoOOzHLI27rUoxbiinsaUIZ90D59W8H56sHqxt2JO
	lBZ1eHcSbCUP3yHHMiLSKY9yMWiYpPUhzOEt5
X-Google-Smtp-Source: AGHT+IHMQYaDBFz1W8XBw72XV3h2NEsDxSXFWe7Vn6lJSDsDU86qsPaWycXMzKI2TVxmE9Vf70BygMoQPGpF7Ny78l0=
X-Received: by 2002:a17:902:f54a:b0:1d4:ca8c:aa6d with SMTP id
 h10-20020a170902f54a00b001d4ca8caa6dmr584364plf.0.1706719998205; Wed, 31 Jan
 2024 08:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111081914.3123-1-adrian.hunter@intel.com> <31bae596-ecb1-4b9c-9f1c-aaec4bcefd38@intel.com>
In-Reply-To: <31bae596-ecb1-4b9c-9f1c-aaec4bcefd38@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jan 2024 08:53:06 -0800
Message-ID: <CAP-5=fUo96EABpH6=7i2cXFmZhAB2MM=UsnG-+vL4HJtLGS=bA@mail.gmail.com>
Subject: Re: [PATCH V4 00/11] perf/core: Add ability for an event to "pause"
 or "resume" AUX area tracing
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon <will@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 4:49=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 11/01/24 10:19, Adrian Hunter wrote:
> > Hi
> >
> > Hardware traces, such as instruction traces, can produce a vast amount =
of
> > trace data, so being able to reduce tracing to more specific circumstan=
ces
> > can be useful.
> >
> > The ability to pause or resume tracing when another event happens, can =
do
> > that.
> >
> > These patches add such a facilty and show how it would work for Intel
> > Processor Trace.
> >
> > Maintainers of other AUX area tracing implementations are requested to
> > consider if this is something they might employ and then whether or not
> > the ABI would work for them.
> >
> > Changes to perf tools are now (since V4) fleshed out.
> >
> >
> > Changes in V4:
> >
> >     perf/core: Add aux_pause, aux_resume, aux_start_paused
> >       Rename aux_output_cfg -> aux_action
> >       Reorder aux_action bits from:
> >               aux_pause, aux_resume, aux_start_paused
> >       to:
> >               aux_start_paused, aux_pause, aux_resume
> >       Fix aux_action bits __u64 -> __u32
> >
> >     coresight: Have a stab at support for pause / resume
> >       Dropped
> >
> >     perf tools
> >       All new patches
> >
> > Changes in RFC V3:
> >
> >     coresight: Have a stab at support for pause / resume
> >       'mode' -> 'flags' so it at least compiles
> >
> > Changes in RFC V2:
> >
> >       Use ->stop() / ->start() instead of ->pause_resume()
> >       Move aux_start_paused bit into aux_output_cfg
> >       Tighten up when Intel PT pause / resume is allowed
> >       Add an example of how it might work for CoreSight
>
> Any more comments?

I think the tools side looks good. The parsing changes match the
existing style. I wonder if it wouldn't be better to handle the valid
strings (pause, resume, etc.) in the lexer rather than a separate
parse function, but the pattern used matches the existing one. You can
have my Acked-by on the tools changes, although the subtleties of ARM
PMUs makes me somewhat nervous in this regard.

Thanks,
Ian

