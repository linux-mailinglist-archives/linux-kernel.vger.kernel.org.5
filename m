Return-Path: <linux-kernel+bounces-110277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F208A885C77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9CF28189E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B6B86639;
	Thu, 21 Mar 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bU3csa5r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895186271
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035973; cv=none; b=cgu8yVcxdpu486ZdsCbqeEHgcrvKinojzD9hBul/FnkUR2kPy893gJUvsjoXyFdheChKv1JO2XYYX9rIg4DpyHKO9d6U0loNtLdCUQP/asf0g9EUnS/irE/J2x7euu7v4HP6VdklaIqzfTfXZqwgZAjDaE49PErS5DiQIFR2kjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035973; c=relaxed/simple;
	bh=gFqBYv79Oe4VWuydL3wkXy7M4uX3TlLt/bVmuJvy/j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kF76bkFaia9Qyidb80SIMxvc/FrBMe0NA0evsIWYnYzKtIDVTS6q2E/U/PdtgB7S/tFe5s/G4kUpyW6a7iqgwDek9YEhltKVlOcf1TLSWyjIdl5t/SG+TkGUS/3KETLBiu5gJ9KvOGbB7p90PzGoAS0KtnXRf+7hmOK5A8E82wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bU3csa5r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711035970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u/bDAxkRhGNaI63WaSFbPk3WuTeCpBeNP/DPNnUuVA=;
	b=bU3csa5raTKYsRkDjcTokctANzOJueo3SP9GB7lEu4VDrLOwIbB1A2WCODG1zSD4ndjTgo
	Otp1TLt5o8UDEjhOKfrvowFM9IkWdZ5GJ14+0luEO7mu/huUY+y8p+1ZtB1WaasIOBB/ma
	bFBuhyvWeC7/QL7Cdm/E+42M0OiaNMM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-rFkgBk9gMweys7YTAlh1pA-1; Thu, 21 Mar 2024 11:46:09 -0400
X-MC-Unique: rFkgBk9gMweys7YTAlh1pA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56bced2bc99so584767a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035968; x=1711640768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u/bDAxkRhGNaI63WaSFbPk3WuTeCpBeNP/DPNnUuVA=;
        b=vUDQ67FLjNOJNE8yS964+aoI3V4oOElZeB+YSFIpMkrQQmW0PZmRVzpLxrNWLx2+/W
         0FSLnUHe3LatAfXYE21QVv4F+691w95hn4SBT9UT3EtyfPT2Nm8qiLll4QZ2IXBpCRSJ
         /f2Ug3ePM3RRY3tCA+4mzL50w07VuQ48Z2R4FHdnTk0yxxRpvTmORsijZRkGthhDW2Kq
         FTNTJUJ1hdcIeeRe5KubtiBPOur3EYzHwBLUr+pNrUvvyWk1H2FAgq6DdQ7L7SvWN6T+
         OlDTrHOTL116Qwz3Ot/9f4ALbujt2Y40OTkWaxpUULdgNvK2JZvlkQ2uygxgwJ+ydnPY
         k8HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzsLEf0DA9ezUPbMWRSlkZQI97r9K49rCgMJ4Dqv6Qh4mGxam6sPyiskCNXsyWW9+Zu6jVgL1BbdD3uyoQZx6GSLuP4mdSNKfG9kDg
X-Gm-Message-State: AOJu0YxOmP0v+eYrCNDJNhZNWP2ryFZeeGW2guXiSSWocMoLLF94ZaBf
	R6BR+DoHV10m1XxRi7s7v/pZW3IpLCCiOZYJLuSDDd5byBwrQ/jAgKNAXzn7TcVmSqkoyZUPsBd
	FdXxutY+qNToK/9zTdUveOtQgTld1h8Rf3C9a5DbwnlLwpze94iq2wsxregxt69vJXapTPIn01i
	LiA841BeBWy0n8ZeQKyiiYCkKi3of21pQ06I8s
X-Received: by 2002:a50:d74f:0:b0:568:c4ca:987a with SMTP id i15-20020a50d74f000000b00568c4ca987amr1882699edj.13.1711035968300;
        Thu, 21 Mar 2024 08:46:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyoGZJ6qMf3KzVRErhXAnVH5+F4wxjV53GrawrpT4L1asy0FRr1gT8G4TR9rt+kUD4VoEMGruWjRF4VmAhHqY=
X-Received: by 2002:a50:d74f:0:b0:568:c4ca:987a with SMTP id
 i15-20020a50d74f000000b00568c4ca987amr1882679edj.13.1711035967938; Thu, 21
 Mar 2024 08:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
 <20240315-hid-bpf-sleepable-v4-6-5658f2540564@kernel.org> <89e76fa5834bd34ef94761bcbc987a1be245b261.camel@gmail.com>
In-Reply-To: <89e76fa5834bd34ef94761bcbc987a1be245b261.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 21 Mar 2024 16:45:56 +0100
Message-ID: <CAO-hwJKvK+QYig8jM2MsqB_WSCP7VQGt5NSWXJUZR2=_5+Y1RA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: add sleepable timer tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 1:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-03-15 at 15:29 +0100, Benjamin Tissoires wrote:
> > bpf_experimental.h and ../bpf_testmod/bpf_testmod_kfunc.h are both
> > including vmlinux.h, which is not compatible with including time.h
> > or bpf_tcp_helpers.h.
> >
> > So prevent vmlinux.h to be included, and override the few missing
> > types.
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> [...]
>
> > @@ -6,6 +6,14 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include "bpf_tcp_helpers.h"
> >
> > +#define __VMLINUX_H__
> > +#define u32 __u32
> > +#define u64 __u64
> > +#include "bpf_experimental.h"
> > +struct prog_test_member1;
> > +#include "../bpf_testmod/bpf_testmod_kfunc.h"
> > +#undef __VMLINUX_H__
>
> Tbh, this looks very ugly.

heh :)

> Would it be possible to create a new tests file sleepable_timer.c
> and include bpf_experimental.h there, skipping time.h?

Sounds like an option, yeah :)

> It appears that for the new tests the only necessary definition from
> time.h is CLOCK_MONOTONIC.
>

Yeah, that #define should be the only one missing.

I'll try to come up with better tests in v5 :)

Cheers,
Benjamin


