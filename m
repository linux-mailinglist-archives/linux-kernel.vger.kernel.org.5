Return-Path: <linux-kernel+bounces-99320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427EC878686
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25B8284270
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BB652F87;
	Mon, 11 Mar 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7Qkamd4"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28654744
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179032; cv=none; b=R7l5j6d7+/NEmJ48PvusW74GNBGmdKwH0VH9D831/rgOXZoVzqAEzXTJHVYGoKejRP0C6Kx/oyBsh88TFafBkqjO6OooRIH3uyoXWybYLKD3/XuhTy1OL2cmJ9p8/2X9E+raALzI+TDb4OjH60XBBCTO5/kfXfDSz9CgmftXd28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179032; c=relaxed/simple;
	bh=6giF1Y1yY2eNcLEL7A3kln8xD7UdhAKJ+1Jewg7oVW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLMm6Y7cmhthvD9PLCp8pLVO0qOvx+w6se7H2/NGTMQu1P5z0dNNBPF2yPq8lW4QARxW2gFxF3cZtjkxIGAM2f8P+3SSECAuEdxiwzjqcOGW13qZxToqBr/A63UsEZEgYHJv+YQiarze/3HDm7ffeN6EegztVWsXZZ9TEP4b9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7Qkamd4; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3663528c0a5so7425ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710179030; x=1710783830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oF34FEnMH9EnB0cuP15G09+KTXv6xLWNfYuekhXlBCo=;
        b=q7Qkamd4UXnrHRrB8DgXkiREgd0f/sdvVdwQZmGvZlYSI4gxX1cZ47GVph2o09FiTK
         syLzN+nVx7jhiJU7jD/Jri5i8e4kTNTJvlYjut93dMk6xld+ccjroGmc0vb6w6eEQmmA
         0FhOZlEKEZfdam9+uIcBTNaKi/5q9FJ81Pn360XN+5pYvSAquH01GK/eiyHrZ/o3ZkEd
         ReJIPe+EtcTJRXaRXQKlLc8Q9GLl3pLXaHfwz+hokCRhYvrFbMMGv1nV/D+G5tdzC9MB
         wg+8cRlM1zq5hT/v9W/gIm6nARb1NF6RxdMeNJ1sEXWKhjuPT5/MWWftWxL3P8q9dOXI
         IDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710179030; x=1710783830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oF34FEnMH9EnB0cuP15G09+KTXv6xLWNfYuekhXlBCo=;
        b=rpUl0Lm+pThQh4UQ3eVbpzlHcWALG7JWLEj5OjvxNa/yhpmbUh8xbnxSxKBy/6zt5z
         V40EGYjHwT7+jHZEnrXTnmupzht23h4zrE8MGdKNGBAvdKG354rPeugwO3E2AIZMahuU
         fn8sjNL2Ml4mVbRIVQJEV5Fbn6OhfBjpMyhv7uMW3/DINFdqzW9H2iDk2zbxG8B5HY6B
         rwbaDuix5FUhb/9NNakAMjIp+edAROU138oFmR2t9B6QjOTYuaJ4niwjrghQc5ugjNKx
         JM/j2ZQLJhBjIbfI8ErG6q/4Y3i02hzjKPeZd0Gqt/v3zh4WM32MA47EPL/Fg+YOegnO
         LlrA==
X-Forwarded-Encrypted: i=1; AJvYcCVGZoMKaQU6qvchOrsp3HfsybhnRWkUVIq7BODmWV03qIfngYGShEriTxIe6Fj+AIiCMtzlqgUXmtSt4U8xQnvwQSNbD3dvCyslHlEe
X-Gm-Message-State: AOJu0Yx7Df5gh4ByNrxkNm+EotqGAKeE0j62aY5hEaeR857sawE0DTed
	GKNUCtRVvXQ9OpeoIfjidFdHGuq0ThOhfBuTbAokkQt1cUjgYuslcmQvBBkKRnZkkIxCS1o2OWs
	SHgg8IJ/FxPISnjnxHartKwUy2lix+Hhay+G3
X-Google-Smtp-Source: AGHT+IEwJK8LM9z6GepM09xe/l66yPSQAakxHFHLM5guTXsfm4sHI3a8LbuWLfASfh/ViCQG02XZVW2mngXeYb08Zkk=
X-Received: by 2002:a05:6e02:1c24:b0:366:50b7:10ec with SMTP id
 m4-20020a056e021c2400b0036650b710ecmr224089ilh.11.1710179030122; Mon, 11 Mar
 2024 10:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710133771.git.sandipan.das@amd.com> <e100c902fd9e1e4f58e3a9c175d572962a9cdd50.1710133771.git.sandipan.das@amd.com>
In-Reply-To: <e100c902fd9e1e4f58e3a9c175d572962a9cdd50.1710133771.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Mar 2024 10:43:35 -0700
Message-ID: <CAP-5=fU=gO49ASVVLUbT5bFPoOE3qi3+xJqvRD3tA=upVUT_aQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf vendor events amd: Add Zen 5 uncore events
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, eranian@google.com, ravi.bangoria@amd.com, 
	ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 10:24=E2=80=AFPM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> Add uncore events taken from Section 1.5 "L3 Cache Performance Monitor
> Counters" and Section 2 "UMC Performance Monitors" of the Performance
> Monitor Counters for AMD Family 1Ah Model 00h-0Fh Processors document
> available at the link below. This constitutes events which capture L3
> cache and UMC command activity.

Why do the L3 uncore PMU events go in the same topic as the core/cpu
events, but the memory controller events not? Could they both go in
separate files to make better use of the topic?

Thanks,
Ian

> Link: https://bugzilla.kernel.org/attachment.cgi?id=3D305974
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  .../pmu-events/arch/x86/amdzen5/cache.json    | 175 ++++++++++++++++++
>  .../arch/x86/amdzen5/memory-controller.json   | 101 ++++++++++

[ ... snip ... ]

