Return-Path: <linux-kernel+bounces-94430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0AB873FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6967F285789
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3771143723;
	Wed,  6 Mar 2024 18:26:38 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E068B14290D;
	Wed,  6 Mar 2024 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749598; cv=none; b=OBEACqQWnc8FrUvqNR/MQCot3BTAdJt0heWfe57V3RblxQdvCLYBCHOaXD4xZj/nmDPAOfa1ukJAPUCXpwcQ9h3BAnJAL46brvmc68PcHw1jJXJodijl36pNi3KS5aIBbmXY4TCL6QRNK9xWxws5CmoE2jjA1KycDhPcRsn3I70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749598; c=relaxed/simple;
	bh=T71wY2scHtTXTP4/sl05QrepXCFVXT46YKK4DY2mUDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdCDr4pAK2C1xqZ9InSqR1dA3AbclCw4kUchNOp2WzPdCRf4TN74XqYmASYMaEmCLyIqIaMWiwkR1fDyiO5tO2Us4Bl3NV8LRLhpagvhLvpv1zG7LyoxGPssr18W8qOy+nf0RUyIU0mq7PjQmAJ07vfPgUhzCv757yfDy+Iq5lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso994118a12.2;
        Wed, 06 Mar 2024 10:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749596; x=1710354396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9R6qqm0g/+E63vqpNrdKfjU08hftBk5a0rLrgW5krU=;
        b=s5tZGIscCF40KeW5U+6wRzxDhXiBnmnRNdu6FNJf9nEKDrMEkK1nvah3z9/btcUhoQ
         w40CAkok0ZOIsExAHf0Pbbivh+nJqpqJinnhetYdrgc5pzPXm2unBVzuy+zM6NaODM0L
         PCAG8l7Rb3vSEg/9a/4VzDESa654T4qga8ZIxprd664S+MoVEsQcO2yvDK4keINI2swQ
         jvUecKFfL/dhJ84Kv1ZIktGe41JzRnlJ/jyCIimetm2IVlNi9z4P5rpmNSiQuLX6tt6d
         BDLaYpwL7YYyXUHSGVgkcxusEkPsDRBu3Fjh2urXpNaIFcPoHXA8ZZAPkL4v9mhv4LlU
         e8mA==
X-Forwarded-Encrypted: i=1; AJvYcCU8CMKUkxVVDGLOasIRNNoU5+11bU5GKSumY1ak6p04I7WouzXcPOXYHlA0sJG3Nu1Mw0rgDogTo7hKrZ9mifLHjzutO6k95eb1maakUHYUB+0jgHAVQFzHfhtz2JUkJanKGxxN1UvwU5ePQwLvLg==
X-Gm-Message-State: AOJu0Yxs/FBga9babKTJ1Bggx2bUv75gorwgv72IbVtJtUUMlpS5Gi1f
	OhA2RXC5EpcQl1FH38S4CnPeHSKlGuFsvR/W27QUjGXtw8fVodVr0KBdPGZ5RrG/zdsNVgyHuGF
	IlT1VfHPHmYhu2ZA1aKrHUffPR7Q=
X-Google-Smtp-Source: AGHT+IH7yeQ6EPQb5Dz9tV6ssROlhefmL/NLrrsFoEA04BJ4KF6ZRvT5NZoQ/7OSNL/fsMcn0GLg9I+a0XenK+g0PEA=
X-Received: by 2002:a17:90b:892:b0:299:5401:89d2 with SMTP id
 bj18-20020a17090b089200b00299540189d2mr12323738pjb.45.1709749596082; Wed, 06
 Mar 2024 10:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304230815.1440583-1-namhyung@kernel.org>
In-Reply-To: <20240304230815.1440583-1-namhyung@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 6 Mar 2024 10:26:24 -0800
Message-ID: <CAM9d7chkbcV14PtjhretGLkhUh2mF7sGx9Y0fvG3kZE8aUqpeg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf annotate: Improve memory usage for symbol histogram
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Mon, Mar 4, 2024 at 3:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> This is another series of memory optimization in perf annotate.
>
> v2 changes:
>  * fix a bug when offset is bigger than 16 bits

Are you ok with this now?

Thanks,
Namhyung

>
>
> When perf annotate (or perf report/top with TUI) processes samples, it
> needs to save the sample period (overhead) at instruction level.  For
> now, it allocates an array to do that for the whole symbol when it
> hits any new symbol.  This comes with a lot of waste since samples can
> be very few and instructions span to multiple bytes.
>
> For example, when a sample hits symbol 'foo' that has size of 100 and
> that's the only sample falls into the symbol.  Then it needs to
> allocate a symbol histogram (sym_hist) and the its size would be
>
>   16 (header) + 16 (sym_hist_entry) * 100 (symbol_size) =3D 1616
>
> But actually it just needs 32 (header + sym_hist_entry) bytes.  Things
> get worse if the symbol size is bigger (and it doesn't have many
> samples in different places).  Also note that it needs a separate
> histogram for each event.
>
> Let's split the sym_hist_entry and have it in a hash table so that it
> can allocate only necessary entries.
>
> No functional change intended.
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (4):
>   perf annotate: Add a hashmap for symbol histogram
>   perf annotate: Calculate instruction overhead using hashmap
>   perf annotate: Remove sym_hist.addr[] array
>   perf annotate: Add comments in the data structures
>
>  tools/perf/ui/gtk/annotate.c |  14 ++++-
>  tools/perf/util/annotate.c   | 116 ++++++++++++++++++++++-------------
>  tools/perf/util/annotate.h   |  86 +++++++++++++++++++++++---
>  3 files changed, 159 insertions(+), 57 deletions(-)
>
> --
> 2.44.0.rc1.240.g4c46232300-goog
>
>

