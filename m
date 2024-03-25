Return-Path: <linux-kernel+bounces-117430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6D088AB57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5B61C3B65C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AC912A167;
	Mon, 25 Mar 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlgBwyrV"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CE5A0F1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382511; cv=none; b=E+6jbQbgMDFQHW4Jc6aZMrSUs7Rj84ryxWjEtq6JBx7uUrXn7SBmsIr7cbRk/f1Hj0VT1vYHtm5zO9T7lM6d/VQHZfy8+bAvLjwnO2BFGkBKjsAeiey/pLsys0TxztuXnxMrvoy2A7UdR5Ok75Yo5bWd4Tx+WIBDdP3B7RZr3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382511; c=relaxed/simple;
	bh=59UbE9m4dLNU/UctnLIacfNEWVQyMyg4nrGCFaybjgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9cNPFPEwLE6tnMNcvLW9IOB846ZDVcrbf9f7Kitw9GbaJ7/IqoRZWtnU41at/tMA6f9b3+WDl99f4cAg+bnLMQmyMl01j+1NuC7K+vRZ2CfG6ocrIxg5uEWJLYBqT+9YQBbYNFTtS+d/deZbobmYwegJjo+NjdlVd4Hd0IM+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlgBwyrV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-431347c6c99so480101cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711382508; x=1711987308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPRJuOE8OwASDffe8vbBcREJyVnhJmE0vJXfy1nelnE=;
        b=VlgBwyrVKpYos7z4YtAxg/SZkVfWQjq7P/ccKASb8+rAUY8yfX9QCY1L2CSlhqc6Bd
         I/3IR4iWTe7jXcaeTrNbSWwXbLMTSKZcbaAb4M/2IP5X/AQGoyWrlS6mDrllMgId7IWj
         i6LRIZatXBEunh8ZGAuYfRsN2LX446iEc+uaDn4BUrKj0Brw6tCl/Hk3IgwGHfBrrnFq
         Keg5s8SRYc0yrPrdA/5fcm6vtO7LANnWkvIIBW1stDYVF3MoLKJ7k2fyAep0ZB3zJr5D
         KXoU89tKAJow6YK/TwW/vNUYcCxMzB7GOyz1DIpyoQmzuIiYUc6Cgh4dfoePcjLGVskw
         z0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711382508; x=1711987308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPRJuOE8OwASDffe8vbBcREJyVnhJmE0vJXfy1nelnE=;
        b=wJpXCKzSaNKgW/OlJgLdwx/rF+ZMKF9zHxhdQFkNhiK8ibvolyZ3gfeHHP83KRtMic
         HdVhMF/7pQ2YCjrXlYcJs1iEAqrqayMYlhjp47pjJAtTe75/tAJYGXndD3JPFmIRTppQ
         jLY2n/jDmIXO06NF6nW+ysbbz+W/5iIVl1MZN6aUEiUxbKpe7HX1LSWeltAmvK1XQQMk
         UFI6MAhjL1d7mE//5iw562SICkIpUI4bDfZwDRWrMlijUcTji9n2vV/mxaZUtPoxJicv
         FeX7n1+ZGGxlhsE79aBqvpf7N6SOiFLThGRfDFtkPi0M71ytE2E1kMcKsjY/CbkSImmw
         jn6w==
X-Gm-Message-State: AOJu0YwtbNpYdrPduhoqn1wd8OoWJiPIc8bIcZmJcjpEzJAZ8V3FhTcT
	xbXOWvDoUbPU4ZPSdZi/PBGwpehK9zG29UAXa9/G73lqkG1/qw+Dd6Xty4b/cXRc0o93z5NYoxh
	PJ2XnxTbhI09Ba+penX252SLAn8S/QlgNJDc0
X-Google-Smtp-Source: AGHT+IHIrmG9yy6eJ8Q/zdFwGJDQtXTQy2MgXxKHSYvK+VOGsArCqswKFxdn5ogEGlicgLKBGkG/vVvus9AgpXw9RAA=
X-Received: by 2002:a05:622a:2298:b0:431:5e0c:f0e1 with SMTP id
 ay24-20020a05622a229800b004315e0cf0e1mr160429qtb.20.1711382508184; Mon, 25
 Mar 2024 09:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321071512.2916952-1-tmricht@linux.ibm.com>
In-Reply-To: <20240321071512.2916952-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Mar 2024 09:01:36 -0700
Message-ID: <CAP-5=fWMdgWe8FqeMcjf6ZCq5fdKWmrROCqnAsKYD9iXQxYEKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] perf report: Fix PAI counter names for s390
 virtual machines
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:15=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.=
com> wrote:
>
> s390 introduced Processor Activity Instrumentation (PAI) counter
> facility on LPAR and virtual machines z/VM for models 3931 and 3932.
> These counters are stored as raw data in the perf.data file and are
> displayed with command
>
>  # ./perf report -i /tmp//perfout-635468 -D | grep Counter
>         Counter:007 <unknown> Value:0x00000000000186a0
>         Counter:032 <unknown> Value:0x0000000000000001
>         Counter:032 <unknown> Value:0x0000000000000001
>         Counter:032 <unknown> Value:0x0000000000000001
>  #
>
> However on z/VM virtual machines, the counter names are not retrieved
> from the PMU and are shown as '<unknown>'.
> This is caused by the CPU string saved in the mapfile.csv for this
> machine:
>
>    ^IBM.393[12].*3\.7.[[:xdigit:]]+$,3,cf_z16,core
>
> This string contains the CPU Measurement facility first and second
> version number and authorization level (3\.7.[[:xdigit:]]+).
> These numbers do not apply to the PAI counter facility.
> In fact they can be omitted.
> Shorten the CPU identification string for this machine to manufacturer
> and model. This is sufficient for all PMU devices.
>
> Output after:
>  # ./perf report -i /tmp//perfout-635468 -D | grep Counter
>         Counter:007 km_aes_128 Value:0x00000000000186a0
>         Counter:032 kma_gcm_aes_256 Value:0x0000000000000001
>         Counter:032 kma_gcm_aes_256 Value:0x0000000000000001
>         Counter:032 kma_gcm_aes_256 Value:0x0000000000000001
>  #
>
> Fixes: b539deafbadb ("perf report: Add s390 raw data interpretation for P=
AI counters")
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/s390/mapfile.csv | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu=
-events/arch/s390/mapfile.csv
> index a918e1af77a5..b22648d12751 100644
> --- a/tools/perf/pmu-events/arch/s390/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
> @@ -5,4 +5,4 @@ Family-model,Version,Filename,EventType
>  ^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
>  ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
>  ^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_z15,core
> -^IBM.393[12].*3\.7.[[:xdigit:]]+$,3,cf_z16,core
> +^IBM.393[12].*$,3,cf_z16,core
> --
> 2.44.0
>

