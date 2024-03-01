Return-Path: <linux-kernel+bounces-88741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B129186E5FF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675CC1F25C85
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EA6107A6;
	Fri,  1 Mar 2024 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbx0afDH"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6375FBEE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311206; cv=none; b=DJ6acixVV4KXo1OUaj+5VFoSNHjAxDZnNfJhkxMoM53Q3PKTslhExPNjT/xBST3A0pxlRQlnYoawo5odZZto7Y1ZNVxzhOiX9DMjdt4tkW5MrsLJb4RqNxF0sxGE28Qrq2m7jXh7BQK04hgzYkus2Y0q0XvSOUFuSNdUekgMa4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311206; c=relaxed/simple;
	bh=gZv9ZVm2Y/YJWkqC68fwBWPcxyg0G+3yV6nrkCH4dtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDcofdKR5lcJsbglQoWvvgzG8PrNHWNFzFL7ozQYPZlQWkWNfHNdC5lRhKrvPTB5TzqacmMOEJQG8gCgJMyi/OgaD03uGI5PrB8T7otf939Idb/MclhtquZ0YA7Rpl9utyN6Oys4Vfiuh/oUP83qalqjxQD8hrqQRpE1DEuv5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbx0afDH; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36575bb8443so152545ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709311204; x=1709916004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Iz8VtV+mrAqmT+Yd+rcCtPv1t4xoF3O9HUxQFtiwYg=;
        b=tbx0afDHqNU7Atji/Hk4INNkkJ6qAxU3Bg6UINSILPRvNDwZyVL7vWwjWfI3YbuMnS
         QFkZvtL5qRK6kBEbOSbALAbc1o+y16POptDhmgRfO8hCkKlIKouwgTMaHuUjOdf3r8mS
         ZaOO6kM676gORaBomJs6JOPsAknOnvVJUKn86WBQ41ua+mD1ACXq4VW2VSWtf5O9c9yO
         lwt801wmPbAiEVByugI1f+ZLdYTEOe4v9EdI8a6H5qQ3E8cDQ/Pm0uF0ODfy0Mimo/FG
         l8xQBvUOLRtSbgYdzls7VALTOBgLVA50OIT4Yr/jt8b6it5XmQFDf0Ecj3u5oFvisd+K
         gyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311204; x=1709916004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Iz8VtV+mrAqmT+Yd+rcCtPv1t4xoF3O9HUxQFtiwYg=;
        b=lh1lZuG9tSL/YlSIVYwLMDLyRc7fI3NcYAGCVm11G9vCieIhJGvsrGKrNB+k/z90lC
         cnapAA2uIhKUU2xPeJqFa6bVVWg1EYPYeAKVhm3SozN+7GmrJxB4ZZo8KMMUGesKYn08
         TzY3Rt9v5n4PBrz5NjFNnTxENFRiQI7SoZ1uVnfNg9AS4Ugo2muw/YvtJFKffBDZGXHz
         UyIecpkPigFzrdeVxIQSUtyjzj6uwijlZ3GdS6RbdgiflnsRtqYlHww9Qudit0SN04RN
         vEG1XfvFwjubW2mr/ClFe3iH88aiwT8D7Hw/dlmrg+G3jJ2xmMAdKq7uxDbvKvoS9DUX
         0FPA==
X-Forwarded-Encrypted: i=1; AJvYcCVRNB4ORKSTRC10xUOlSnwH/hPhEAGiql2OIhROWT810/WR/G17Hw3fHF9tR518Oz2iPkqHVAUDxmxfzQQLiRQ43avSVL7BK3F70Dzq
X-Gm-Message-State: AOJu0YxtZVwdrYTfSbGXi8j6QOO2yAZnbzEIDzt7DpwmnfZvvZVUQwPC
	T1QzQ2AZpKOy7AQi8XyI4PQ8nDtY6OM2che82hWAhnacWgpP1t4ITOEeKuT/9BtrbxjH1YV1oi5
	RUxjDp4QJmNhtiwBLAhWfxiA/7/9csLUhB0oF
X-Google-Smtp-Source: AGHT+IFhKuMkCMVygmw7wOWmjh+fqlQG1IchTKTj3q1zr5rHxYjNFVMGcW4VP+Ggz34Rx1p4O+y00HjkGptVTU/gOiM=
X-Received: by 2002:a05:6e02:1a8d:b0:365:16d5:4b11 with SMTP id
 k13-20020a056e021a8d00b0036516d54b11mr191985ilv.3.1709311203702; Fri, 01 Mar
 2024 08:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301084431.646221-1-sandipan.das@amd.com>
In-Reply-To: <20240301084431.646221-1-sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 1 Mar 2024 08:39:52 -0800
Message-ID: <CAP-5=fV49j-fMSF5PcAXP7hoD4guqy8DnQs_uJWcgVM7fKxLhQ@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events amd: Fix Zen 4 cache latency events
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	eranian@google.com, adrian.hunter@intel.com, ravi.bangoria@amd.com, 
	ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:44=E2=80=AFAM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> L3PMCx0AC and L3PMCx0AD, used in l3_xi_sampled_latency* events, have a
> quirk that requires them to be programmed with SliceId set to 0x3.
> Without this, the events do not count at all and affects dependent
> metrics such as l3_read_miss_latency.
>
> If ThreadMask is not specified, the amd-uncore driver internally sets
> ThreadMask to 0x3, EnAllCores to 0x1 and EnAllSlices to 0x1 but does
> not set SliceId. Since SliceId must also be set to 0x3 in this case,
> specify all the other fields explicitly.
>
> E.g.
>
>   $ sudo perf stat -e l3_xi_sampled_latency.all,l3_xi_sampled_latency_req=
uests.all -a sleep 1
>
> Before:
>
>    Performance counter stats for 'system wide':
>
>                    0      l3_xi_sampled_latency.all
>                    0      l3_xi_sampled_latency_requests.all
>
>          1.005155399 seconds time elapsed
>
> After:
>
>    Performance counter stats for 'system wide':
>
>              921,446      l3_xi_sampled_latency.all
>               54,210      l3_xi_sampled_latency_requests.all
>
>          1.005664472 seconds time elapsed
>
> Fixes: 5b2ca349c313 ("perf vendor events amd: Add Zen 4 uncore events")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

