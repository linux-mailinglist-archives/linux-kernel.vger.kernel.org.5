Return-Path: <linux-kernel+bounces-69275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E414858680
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD161C20975
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8BA138496;
	Fri, 16 Feb 2024 20:09:01 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B93135402;
	Fri, 16 Feb 2024 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114141; cv=none; b=pvSnSPi+D0ZPOQvPxPreZbEW39k+ujnNyAj27AtBPyyljvlmm5b7nLd9XjaDd9vWrA3hobQN2/A4l6aySjbQsjATCIcANPwrEChlKGmEEbhaBKo3YrzZ3BlBylJ9n3tw7o5O8Q6x0mC7DwQVsfeHoE2h3+e1YmyDbtna9UcAs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114141; c=relaxed/simple;
	bh=zGDptjAq4jLL6sQvLop2+9PNm8IdwyOTG2jsi5pb8YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1ICwKWOdx6lnNpLMxaOigHPbLMwhbXknymvJcSmcGxPhtws1IyW0r69BjB4OaJsxXbSEmcgV9AYpB41Wx9986FnbVR+60qNwa7HnAe7rUUvRZOTdHfOSNcbZZSGYdLCE0wbAvRvROvbeYjUwZFOZ8KzTEPk8nbh2GVIeEC2pf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d70b0e521eso20760185ad.1;
        Fri, 16 Feb 2024 12:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708114139; x=1708718939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+K2Fgb8X/bk94h+IXdbaE/IqDHPns4xLfRpQ3CzppJ8=;
        b=ClF1rtKXYi73uF3C/ZAD99JmoQusrMv3cmvLUljQ0lNUVbsQxRZ1XWW7Wub7zZTWd+
         bhp6k/U2DmQi8ssy1LrnE+q323+QVXMzTxVYqaBD3S0gROs6VZS8kscEHIAaziTY70mj
         hWnqkqXM60nuIMsY6qsw8J8xagvB8fjaDNhY67g4aCY/FVkvtqXBjn6K583qgLjXnK6S
         hpaNDXdOZCeUoe+rgS4lMOG18quH9p4RF2iCdmfgpvqhtnpefEkjq/ClXNd0rHaSbxi0
         bBtUk3rHEtOMybIcHHO17/CHPVmQt8MtIYMP4dNT1kIsaC3WQn6qNMqniuT7ZpNBBQWr
         92rw==
X-Forwarded-Encrypted: i=1; AJvYcCVRMyZK1oU7l10Az9vFfJ/8YX5epNP9P8rjWWKfu+laZARKp1XpE/PEZgDblVVC802NHkdULLUOMeNqtcNMq/b/EdfC5dlaPeF+xkNhWazErSJIZO8sPBpG3DLZLV0oxKb5+5eeDR22POCKsHljug==
X-Gm-Message-State: AOJu0YzYR2nRPKHgYUP5ex3Fow23OWHVScx1wYpvhvUu0CBu6Hxzgh6O
	t9szsdn/Gy5XbpgOfATHaJasIHv8suquOt8XwWGzSisM3x6iAQqcDnZ1nZMgxGZoiRE951leR7m
	BK29PiNrvSLDmLq8f7knoFbdMzJs=
X-Google-Smtp-Source: AGHT+IHZWDq9bOXMcAvX157mn+T/0988y0sNXqUdfnXVqfmZebDAaiCia2ydBIf1qLRjVwNydZL893BMKKUYu+/Giwk=
X-Received: by 2002:a17:90a:dc0a:b0:299:3657:494c with SMTP id
 i10-20020a17090adc0a00b002993657494cmr2054663pjv.24.1708114138871; Fri, 16
 Feb 2024 12:08:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213075256.1983638-1-namhyung@kernel.org> <20240213075256.1983638-4-namhyung@kernel.org>
 <CAP-5=fVK3vvNoaGHPep8NCweGw9cztKBGQh5+0bVX91PhWp5Eg@mail.gmail.com>
 <CAM9d7ci=A9rwZxEYYQRi-Cncs7NSpRG+TaH5knTdEPZYxJWp9Q@mail.gmail.com> <CAP-5=fWwRjnv=BSdz2GV+EfKUrtzMCSvheR38hkbFadKpvW2eQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWwRjnv=BSdz2GV+EfKUrtzMCSvheR38hkbFadKpvW2eQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 16 Feb 2024 12:08:47 -0800
Message-ID: <CAM9d7cg6c7t7zAgDEJP=+D1qM16SQuWN05fn4T-m1WPfXjaZvA@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf hist: Do not use event index in hpp__fmt()
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 11:54=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Feb 14, 2024 at 9:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Wed, Feb 14, 2024 at 4:08=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Mon, Feb 12, 2024 at 11:52=E2=80=AFPM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > >
> > > > The __hpp__fmt() is to print period values in a hist entry.  It han=
dles
> > > > event groups using linked pair entries.  Until now, it used event i=
ndex
> > > > to print values of group members.  But we want to make it more robu=
st
> > > > and support groups even if some members in the group were removed.
> > >
> > > I'm unclear how it breaks currently. The evsel idx is set the evlist
> > > nr_entries on creation and not updated by a remove. A remove may
> > > change a groups leader, should the remove also make the next entry's
> > > index idx that of the previous group leader?
> >
> > The evsel__group_idx() returns evsel->idx - leader->idx.
> > If it has a group event {A, B, C} then the index would be 0, 1, 2.
> > If it removes B, the group would be {A, C} with index 0 and 2.
> > The nr_members is 2 now so it cannot use index 2 for C.
> >
> > Note that we cannot change the index of C because some information
> > like annotation histogram relies on the index.
>
> Ugh, the whole index thing is just messy - perhaps these days we could
> have a hashmap with the evsel as a key instead. I remember that I also
> forced the idx here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2049
> If it were invariant that the idx were always the position of an event
> in the evlist then I think life would be easier, but that won't help
> for the arrays of counters that need the index to be constant. I guess
> this is why the previous work to do this skipped evsels rather than
> removed them.

Actually I have a patch series to convert the annotation histogram
to a hash map.  It'd reduce memory usage as well.  Will post.

I think removing evsel is not a common operation and should be
done with care.  In this patchset, it removed (dummy) events after
processing all samples.  I can make the code to skip those event
when printing the result but it'd be much easier if it can remove the
unnecessary events.

Thanks,
Namhyung

