Return-Path: <linux-kernel+bounces-154025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAD48AD63D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41A71C208F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4301C6A0;
	Mon, 22 Apr 2024 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbzWU88C"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3B1BC53
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819585; cv=none; b=S3T7K9YKPmQRXzKXtguHcTjjzr/ge2Vv700pEfE3Y6DYVolcjMOf+GuD/lZaNfUkhpJiLXUhUWNs3L8dfbjB9a9LRMHI4bnABnEH9+8QQTOj8mBQqLU3wX1DoNoUrZK/GJBiTNfb79HKrwiO/6rI47HAm1KhReC1dc9QZ27nz+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819585; c=relaxed/simple;
	bh=9DtxLkBqU8o+Vd60v8MnikP8aabry94GM1z7ZjGXJAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5jvn0pF4Em7F743T+H1TrY6+Ft3ywSqNm4kwtgBIIZvZ+m/O40Sfyqs13EJTQtmGLj9Hh7x/JVNq8AyJObYBCosie5nyZNdeCkwmLnqwhGSOpMqgzrT+9DVzHiJG8Sk6I03BzyVbYtEnqyyAPP54rCuT0MZjhM0z7BCAOFvVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbzWU88C; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-439b1c72676so39391cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713819582; x=1714424382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DtxLkBqU8o+Vd60v8MnikP8aabry94GM1z7ZjGXJAA=;
        b=mbzWU88CFNzYso5y3z5u0Y7gx+04dJRwteJm/Hx7ACnQ/V62GydtY5pYvdxn0tJE9j
         J4dazF7HgDQ9euLkxTPEPc+vOF27vdPqiKmzaUnD4onpIlsXIXYOecG5km7ogSX3tjmw
         WXXfnqC6OIKl77hqQHI/Abf42JvRBemo0s9xSgpzrKxqx/kSUTPPJTZDrJ53gAiDKtCJ
         W/2mXwzO6zGIHiOnPAEoKLKAr1STrw46B0RXBM1HDkxwbIi2TRhpXSAXeEpWJi+b90+t
         pF9U6pGLKCCZcrGOOCtiiAU3mE0nyaV/JSh5dHzBchvBsvuUtrHQrpCSVx9Vn86A+mPe
         PVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819582; x=1714424382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DtxLkBqU8o+Vd60v8MnikP8aabry94GM1z7ZjGXJAA=;
        b=gNSZL46bjWYIx1+T/x9OtbcKW4j56OdTJHL7ZitGxBFwyo1yEI8e5xgiQwJcnTcUcB
         wamyk1PJP+nC0dexIakyMk9LDIIcl0wljYsJJItJgoOCRmvZzzyFEKH6LdBtZLCWRDFp
         YJM8Byj3z84fZyOoRKSaalLNUHXLpubiGgCTDkPwLa9dMHKOVnhRqcAhJoPHdgTuzMzm
         0X7toeML7sdfkD3FJz44u7hw/3DvHYsqRYlaPWUrQxM92GSpzJwmUrc/d2yipk+YqhZt
         n5Ju858kZ7LItlwEyLq9ovozI8WxsrgGyQxaW0ZSIhNeHAuJe1RaA58OuAN8tzV7F6Tf
         /a2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRGRgHYX50zGkFiZN+yk7XgdM91tOk9m24F/A8NvJEmk092sBYyh+9v9LxycYmohTKR4G+N65hmNvuyO9ct2hCVp66Q8wfhwVSewW0
X-Gm-Message-State: AOJu0YyMFw07nb1RfhNDIQCGWU0BE2yvuKIxMHI66viamZT75uaJsQzF
	F/eO/T6mZBEh0uvo2U5uY9a3pHUtB7ImMpM64B+AFgQrXuROk070O8dygpqZ6RSJd30Q6xz6HpO
	20VAc/fANxsH2eE/+Q1jIbSzLuWW3KPWM1U3a
X-Google-Smtp-Source: AGHT+IFWv3vY24WCXnrPQ0IXbKt//pYLn/SVsr2ulzPtbd7T/FKDLeYs0qIX73iBiD1osziDXA7eh7+i5RjT8f9m8Qw=
X-Received: by 2002:ac8:748f:0:b0:437:6b79:c9ff with SMTP id
 v15-20020ac8748f000000b004376b79c9ffmr83042qtq.10.1713819581839; Mon, 22 Apr
 2024 13:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com> <ZhgvE7i9HGGar1eX@x1>
 <CAM9d7chWBv14hD4huuoas4ncZaziuTnHi_JvieKqrLZF9fDpPw@mail.gmail.com> <ZibOs-_ASLcZrnFa@x1>
In-Reply-To: <ZibOs-_ASLcZrnFa@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Apr 2024 13:59:27 -0700
Message-ID: <CAP-5=fXwkrPuWBTedUxjc=2GyDwPsTA75RAyN+nj4iHSFozRwg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] dso/dsos memory savings and clean up
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, elfring@users.sourceforge.net, 
	Markus Elfring <Markus.Elfring@web.de>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 1:55=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Apr 22, 2024 at 01:06:46PM -0700, Namhyung Kim wrote:
> > On Thu, Apr 11, 2024 at 11:42=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Apr 09, 2024 at 11:42:02PM -0700, Ian Rogers wrote:
> > > > 12 more patches from:
> > > > https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@googl=
e.com/
> > > > a near half year old adventure in trying to lower perf's dynamic
> > > > memory use. Bits like the memory overhead of opendir are on the
> > > > sidelines for now, too much fighting over how
> > > > distributions/C-libraries present getdents. These changes are more
> > > > good old fashioned replace an rb-tree with a sorted array and add
> > > > reference count tracking.
> > > >
> > > > The changes migrate dsos code, the collection of dso structs, more
> > > > into the dsos.c/dsos.h files. As with maps and threads, this is don=
e
> > > > so the internals can be changed - replacing a linked list (for fast
> > > > iteration) and an rb-tree (for fast finds) with a lazily sorted
> > > > array. The complexity of operations remain roughly the same, althou=
gh
> > > > iterating an array is likely faster than iterating a linked list, t=
he
> > > > memory usage is at least reduce by half.
> > >
> > > Got the first 5 patches, would be nice if more people could review it=
,
> > > I'll try and get back to is soon.
> >
> > For the series:
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> It is not applying right now, I've just merged with torvalds/master and
> I'm running build tests now, will push to tmp.perf-tools-next right now.

Ok, do you want me to rebase on tmp.perf-tools-next?

Thanks,
Ian

> - Arnaldo

