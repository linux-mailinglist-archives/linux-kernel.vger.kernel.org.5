Return-Path: <linux-kernel+bounces-35791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC378396A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D312F1F24443
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E180047;
	Tue, 23 Jan 2024 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/Kzn2VW"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4697FBA1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031692; cv=none; b=PuEjwWZ2XxjECc9xmgedMhBkSjMqmR4AHUMcOYewly+cQSxWDz9H6TjiVpDJ+E4U6IKfeWLo5/rb+Bg716agtE9x5UaMuzmUTNlZFNIQHNwWJjE58aAwgj8CFdTEQ9ssjLmvvQ1osfRzWQhp1umJx/nKI5wtFaTdIXddImzDTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031692; c=relaxed/simple;
	bh=xz348oKU6AvMF1pO21pNvmncLBLDSSGLwTjoIJaj5OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKOiYWYRVamUSb2cnfFK9XRVrBIAS0meMp0ownBK54udAF+FSuJifFfpuKnsKfi3LC4j+uS3gitA13DXGuiT06zyijVCeWaeZPfxcLa4VXJ57ZXHdoR7m1F4bkSs1FGp6TwowudL2Y/LyUnjgCPfZTqSmfFUFjAJtXRY9T9AuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/Kzn2VW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d72d240c69so153175ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706031691; x=1706636491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I71cbz0+z/l7EjukDSABLEPiSb/P+c5sQG7mnaPl+5s=;
        b=x/Kzn2VWDhz9WTQl6dEYtrNNECqIO9zDn4Df0er99ZX/WmgSwd7BlQ+GSWYxujgjNK
         KQOQ9rNcVrHVXRY9xiR6lNuCfW1I1O3tClboalao+RUemvTtCpPdMCdSKp0cGN8A4nn3
         RE162K5PAlPw51EZVhZkl1b3AX+JMV9oibLnClEkTA69Z2o05BUZuidmUcl6Huc0EB06
         5cIoa8xnruakkO0PiTUVZZWaibH4wolLSIp+tBpQcFRW31ieUzRxpGqmuVrPCxEt8osb
         0NE+DcTQ7YpmzGmN9C/oLE/tMC2cOkKMNQ89atPcrkrs6zb3Y8Ew8JYSh+qgqylQKPKI
         rRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031691; x=1706636491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I71cbz0+z/l7EjukDSABLEPiSb/P+c5sQG7mnaPl+5s=;
        b=Esw/HtJm1wyBuhI3URXgNgIhNpOBfqrkGBI52TT1tV7J/Y0eI7rz33ROP4SadaG1I/
         ZCgRyWasCNSSJ6nBVxy1FOKT09ZsX86iK8JD5TA7rs1GXZbwceXdOTPAmEjK3s2lC3Be
         /uTzwMVy4gAwl1GCs37GIDjOpVJzKQnTUUPVZt/gfdkVZsOArxbJhNCSOHA/zJZ9EdY8
         QVTLhczCMrhjkfFPEQUQsYoiKwBLGfzCYhY6QKUO9Ort41db/sRa9T6Qx0vFouZPtLJE
         N2Sxwd95NFTAkxyoBnYpYv4q3WhZpO9A0W/NFItrh4CWHjL2hVCu/NjrfhzyKubWbbRY
         sfRw==
X-Gm-Message-State: AOJu0YxZmAZ85OgvVPQcSIWfbfUTi0mIrQfdboaW/cnmwoCnMFRiaRly
	OPXvqq7Y9D2P/FMc1b9+1a/w2CIOIwBXclywRMXAXWw8hjQRpLLNJLkucD9zVy8pZMj+mof86sQ
	SO28rovTaWTgtBRAXik3lF6kGEL62UOC8MscW
X-Google-Smtp-Source: AGHT+IFtIvLah28e+SbECgqi2o0hZS7gomDPxhoryyoEQNbKVSOKVjqoHW7sYfr7E0fwzLjqlMkIjW/+2y3hjtBSFJk=
X-Received: by 2002:a17:902:dac1:b0:1d5:76a6:6402 with SMTP id
 q1-20020a170902dac100b001d576a66402mr29236plx.17.1706031690641; Tue, 23 Jan
 2024 09:41:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123163903.350306-1-james.clark@arm.com> <20240123163903.350306-3-james.clark@arm.com>
In-Reply-To: <20240123163903.350306-3-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jan 2024 09:41:19 -0800
Message-ID: <CAP-5=fX4QQYNzEY7-6GyqWJTuH-RQxxc3jB5B1k8HZtDZCHmFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Skip test_arm_callgraph_fp.sh if unwinding
 isn't built in
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Spoorthy S <spoorts2@in.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:39=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> Even though this is a frame pointer unwind test, it's testing that a
> frame pointer stack can be augmented correctly with a partial
> Dwarf unwind. So add a feature check so that this test skips instead of
> fails if Dwarf unwinding isn't present.

Hi James,

Is there value in testing without the partial Dwarf unwind? Presumably
that is covered by the existing dwarf unwind test?
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/dwarf-unwind.c?h=3Dperf-tools-next
If the issue is inlined functions I'm surprised addr2line isn't doing
the job properly. Is there an addr2line perf script issue here?

Thanks,
Ian

> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/shell/test_arm_callgraph_fp.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf=
/tests/shell/test_arm_callgraph_fp.sh
> index e342e6c8aa50..83b53591b1ea 100755
> --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> @@ -8,6 +8,12 @@ shelldir=3D$(dirname "$0")
>
>  lscpu | grep -q "aarch64" || exit 2
>
> +if perf version --build-options | grep HAVE_DWARF_UNWIND_SUPPORT | grep =
-q OFF
> +then
> +  echo "Skipping, no dwarf unwind support"
> +  exit 2
> +fi
> +
>  skip_test_missing_symbol leafloop
>
>  PERF_DATA=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> --
> 2.34.1
>

