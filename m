Return-Path: <linux-kernel+bounces-121982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC29388F031
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F5C29A5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043411534E4;
	Wed, 27 Mar 2024 20:34:36 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165112E405;
	Wed, 27 Mar 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571675; cv=none; b=MQfM21dLw4QLLKhkKMZx9/4cRlmh3X9hteEpZBuM1SXuut0RdDwFYTSXJnwTcBxd9/c6eh8s0Xu/Qb2dxgUOBrDE2KR8KrDd8t54trkAyu9dYdJhQGhzrC7Rjr6W7UkEusHN2Ny6WNKN7YUJRDJjClVG271zaJ68pZvGjJGek7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571675; c=relaxed/simple;
	bh=KwmTraLokWvUVav8mjs3/ZYVbaEKtrQRNzc9845lWV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFGTeQRLds4AtYuj2Pt1Hh9dcxxpTK2mepzqwTkTtZCjhW6UWv1muMkzn+B8PzIY7it68wCccltAJNe6E1u2DRVRv5tRz38qUt+j+svHVrg0jlc1bG7zoHpWgv1j3hvz/vtY9QZMi2K444ApwCluIV397QRxsHaWATeYONGvUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0d8403257so2439445ad.1;
        Wed, 27 Mar 2024 13:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711571673; x=1712176473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+x7D6kOto8z970KdkxwYoEzZ3J7QDTI0xwm/8QGlp4A=;
        b=nQCZXaEfbcUS5fMXBagdziGUiFx3fI+vNQPynskZr+A8DGzB8fjig1UyREBdjP+IR2
         WHtTHAxB5GTNL9WRKKgnB7pLdgb9l/JG5F+z5hCowj9ScRgtTDDbgfhQLRMQMX10+Apd
         iStqmOYZBoefqQSabHoCHM04zKjEUK4a9lyzN6aK38339NyZkAZ3r6RBeKE5FvX0UBVM
         GA+og9Xzr1XTC4MqTY5hpo0KIe9IKIfb/uOsNOhYBYWCksXfxgDdyPhD4VeJ5aBjgSZp
         yJTeWFsbPjd3WkOGw1aZnGuqlR8s89Eh2XTMKlG/U947XZwafbBuYvWPGwr24WI7HH05
         Nb0g==
X-Forwarded-Encrypted: i=1; AJvYcCXkRKbbD3SygrLpeqKWcXRW78805dDQjq50TBqX44qI0jmj+lYWnttKaGtRpM6Ecb/Fl9jn7raHUw/3xdLxFafE90IArEVDd7cnpQcz4eaxJWqvq0uNOiaLYjUw+LHqMX4J2soNRTUPsQweHZjXdw==
X-Gm-Message-State: AOJu0YzL7cC5SLT0tocjs+ShGZ/YSSwcAOTzIsob1AVn8yBU0HqgLE6k
	zlYAg0f55J1J9YrmtQkq9QrGdEjBzUmMKrAyRggNJb5gZH3E+vxdgZjkjYJR0+nh+ljjZqPtNoY
	IGTWvu5uV/l09ScvJRQRWkGD01HE=
X-Google-Smtp-Source: AGHT+IFCHLcKkNsvRbq1SvSTDKJZpEtgXNJVuHS8g8JgpKuR8S+4cBcizzVtu8ZhK0Bj1390CuRfButTxzapzb5F6AM=
X-Received: by 2002:a17:902:d54f:b0:1e0:b5d4:9f55 with SMTP id
 z15-20020a170902d54f00b001e0b5d49f55mr911146plf.50.1711571673343; Wed, 27 Mar
 2024 13:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322164237.203358-1-ben.gainey@arm.com> <CAM9d7chfXH0ynfT_PSPyjhE8ATa=fV-kbx_csgeQrWiv+1EiiQ@mail.gmail.com>
 <70cb93e37dc6036c7638a2630ae6dcbaa728602a.camel@arm.com>
In-Reply-To: <70cb93e37dc6036c7638a2630ae6dcbaa728602a.camel@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 27 Mar 2024 13:34:22 -0700
Message-ID: <CAM9d7ciy+8j86n0v_tOiL=MswcVjj+qkROXvOmVd57MT14v_0w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] perf: Support PERF_SAMPLE_READ with inherit_stat
To: Ben Gainey <Ben.Gainey@arm.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, James Clark <James.Clark@arm.com>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "irogers@google.com" <irogers@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Mar 25, 2024 at 3:12=E2=80=AFAM Ben Gainey <Ben.Gainey@arm.com> wro=
te:
>
> On Fri, 2024-03-22 at 18:22 -0700, Namhyung Kim wrote:
> > On Fri, Mar 22, 2024 at 9:42=E2=80=AFAM Ben Gainey <ben.gainey@arm.com>
> > wrote:
> > >
> > > This change allows events to use PERF_SAMPLE READ with inherit so
> > > long
> > > as both inherit_stat and PERF_SAMPLE_TID are set.
> > >
> > > Currently it is not possible to use PERF_SAMPLE_READ with inherit.
> > > This
> > > restriction assumes the user is interested in collecting aggregate
> > > statistics as per `perf stat`. It prevents a user from collecting
> > > per-thread samples using counter groups from a multi-threaded or
> > > multi-process application, as with `perf record -e '{....}:S'`.
> > > Instead
> > > users must use system-wide mode, or forgo the ability to sample
> > > counter
> > > groups. System-wide mode is often problematic as it requires
> > > specific
> > > permissions (no CAP_PERFMON / root access), or may lead to capture
> > > of
> > > significant amounts of extra data from other processes running on
> > > the
> > > system.
> > >
> > > Perf already supports the ability to collect per-thread counts with
> > > `inherit` via the `inherit_stat` flag. This patch changes
> >
> > I'm not sure about this part.  IIUC inherit and inherit_stat is not
> > for
> > per-thread counts, it only supports per-process (including children)
> > events.
>
> Hi Namhyung
>
> Thanks for the comments...
>
> I don't think this is correct, if you compare the behaviour of
>
>     perf record --no-inherit ... <some-forking-processes>
>     perf script -F pid,tid | sort -u
> and
>     perf record --no-inherit ... <some-multithreaded-processes>
>     perf script -F pid,tid | sort -u
>
> vs
>
>     perf record ... <some-forking-processes>
>     perf script -F pid,tid | sort -u
> and
>     perf record .. <some-multithreaded-processes>
>     perf script -F pid,tid | sort -u
>
> The behaviour is consistent with the fact that no-inherit only records
> the primary thread of the primary process, whereas in the inherit case
> any child tasks (either threads or forked processes) is recorded.

Right, I was talking about the counting behavior not sampling
as inherit_stat is only for the counting.  I think it'd return an error
if event attr has both sample_freq and inherit_stat.


> >
> >
> > > `perf_event_alloc` relaxing the restriction to combine `inherit`
> > > with
> > > `PERF_SAMPLE_READ` so that the combination will be allowed so long
> > > as
> > > `inherit_stat` and `PERF_SAMPLE_TID` are enabled.
> >
> > Anyway, does it really need 'inherit_stat'?  I think it's only for
> > counting use cases (e.g. 'perf stat') not for sampling.
>
>
> I would be very happy to remove the inherit_stat requirement. When I
> first came to this it seemed like the logic was all there in
> inherit_stat already, but now that I have to take a different path in
> `perf_event_context_sched_out` I suspect it should be trivial to remove
> the inherit_stat requirement.

ok.

> >
> > Also technically, it can have PERF_SAMPLE_STREAM_ID instead
> > of PERF_SAMPLE_TID to distinguish the counter values.
>
>
> It looks like you are correct, but the ID given in the read_format part
> of PERF_SAMPLE_RECORD is the ID rather than STREAM_ID. (I had
> incorrectly thought/stated it was the latter). Hence when processing
> the read_format values in the sample record, we either need to use the
> TID to uniquely identify the source, or we would need to modify the
> read_format to (additionally) include the STREAM_ID.
>
>  * The current approach in tools uses the ID+TID, which puts more
> complexity in the tools but means there isn't an extra field in the
> read_format data (for each value).
>  * Alternatively I could introduce a PERF_FORMAT_STREAM_ID; I would
> expect that the user/tool would need to specify
> PERF_FORMAT_ID|PERF_FORMAT_STREAM_ID as they would need to use the ID
> to lookup the correct perf_event_attr, but could use the STREAM_ID to
> uniquely identify the child event. This approach would add an extra u64
> per value in the read_format data but is possibly simpler/safer for
> tools?
>
> Any preferences?

I think it's better to use TID + ID.  IIUC there's no way to track
STREAM_ID for new children other than getting it from sample.
As sample has TID already it'd be meaningless using STREAM_ID
to distinguish events.

Thanks,
Namhyung

