Return-Path: <linux-kernel+bounces-100993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54787A090
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33D42852CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B282BE65;
	Wed, 13 Mar 2024 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FDZNA8oD"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E0947A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710292456; cv=none; b=nIbBY2yPKF4wshpoJUgodMxYrSPbf6xmCWkkWgVhbMe1DIe3E6pY5nsv3VPH+rbSl7R60iOb7TZqyvEnc0UvJw4w5q+Y43VR/IzvxF+uGSYz+gOJggtdfnKzeO8JW0DcLl6USo9CDHrxePKrsRe/GzDk/rg9qlMZglylOEMMttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710292456; c=relaxed/simple;
	bh=twMccmPlR7/SShgFg0AONE56vJVPPL3EBuKYw8SPbFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgsMYUa2jLrM5XKpv7sl14PphszeiHtc76ePgxHGxiTkmR/T4su6caebNG6bJccjqpl2mp/RnPtnCfdzYDJ5xjiN125p2Vv/zmgoIgKBdYymDFj5IvuGE5lFu0r3R9EagtThnzR6jcaRE4xYSH3MBoWSqVb5T58WFeFCca8v7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FDZNA8oD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29bb3d62949so3317508a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710292454; x=1710897254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twMccmPlR7/SShgFg0AONE56vJVPPL3EBuKYw8SPbFI=;
        b=FDZNA8oDu26c1b4Iq8kZpI5sjsgzWxN3M1q+oBqWsp+edkBILL0x/ka8+/nChjOnBo
         cMYlOjrqOw6kEqUyIAMKHDstbnc8rFkNuM1rrWPxLO3KbA3p4Y++EQDbz8OKhAb5qja8
         P/1+acCyx9guR3yh+MkS99mdDHrWjPTSgvwyMWYpSq15boCnFJ9P6M8RBXrnaibQe2qk
         2BsCYF1COi08jt7I+YEdGO6oK2NjxCIwpkkFSRn8A/uCPUSF/O4d72djMV8nJFSKXwUQ
         W8cPGSiSEhradaspEmLUBW3lkkxtC0OsA80J9lNQ/YWJOsOA1HqnRU1xV0YI5hVDMg7T
         PbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710292454; x=1710897254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twMccmPlR7/SShgFg0AONE56vJVPPL3EBuKYw8SPbFI=;
        b=SI6uNQqql2jsCYwEXxE5v+MX/lvkxS19PlIzasTAPHsl+X9gp1dPUQAGV92Vrh8NSE
         DnDFvp0FOk8eBgDTgWlnutojj90Z4dgKAuBKQDINbs6ccO8OLxaovt9n9mwhpHdoWsV+
         dfPMxvJQaIXGaDRZsMJP+3QVkduop+jDHKGI1SX5vOXPpbxC9j5kgTGfQ22pUYyU946U
         OeMp37x7hkpxWwg7vd5BvDHnwBnPbKxl3SnDt6Ki+11473qZKupfn4Yc/y3VxR8xCfE0
         41F1Cj24BtW0ipVThM72o6IlE2T9UGMhDBzD1Y64yDafmpa6EuZNaemsLP1nHA4hJPHj
         uR2A==
X-Forwarded-Encrypted: i=1; AJvYcCVeO+xczJFmUoXvxfUwIqNYNR+yPqmyYxHeLyZ/2Zv1rQbuFTIo+afEAWq5fGJm0vCqeZf/o7D+jHiE7AowWbXTkbkrGRiOqAnoZztZ
X-Gm-Message-State: AOJu0Yzt/zG4VOmf512dJw5oJuxHiZtFH7SLYxMwMWTU0XJM8KXgN//B
	Ymb9zZFrwiaaqKOdxLb6/thkW4tJZ4M77Gf1toR0b7nDnWM03SNKl80S9CfVKkDPHx8gXMChGmp
	lJgY902G5hUrYQHm2h/p2lYJbOfaj7722cynX8A==
X-Google-Smtp-Source: AGHT+IFJ2nJztVxlcv7iF1fLo4e+81DiH9lck4a4XLEq2MMi6yrbHR+XGNXNfeaQ8LZdIPeyXdsLEIp10M0upU5dDak=
X-Received: by 2002:a17:90a:bb0d:b0:29c:5ba3:890e with SMTP id
 u13-20020a17090abb0d00b0029c5ba3890emr829001pjr.4.1710292454186; Tue, 12 Mar
 2024 18:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-9-dongmenglong.8@bytedance.com> <CAADnVQK+s3XgSYhpSdh7_9Qhq4DimmSO-D9d5+EsSZQMX4TxxA@mail.gmail.com>
 <CALz3k9hZxsbUGoe5JoWpMEV0URykRwiKWLKZNj4nhvnXg3V=Zg@mail.gmail.com> <CAADnVQJ87Ov6ny2hj-0_WymGB3TeuEZu373EmqmRJqZv-8Ze_Q@mail.gmail.com>
In-Reply-To: <CAADnVQJ87Ov6ny2hj-0_WymGB3TeuEZu373EmqmRJqZv-8Ze_Q@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Wed, 13 Mar 2024 09:14:03 +0800
Message-ID: <CALz3k9jf4Q7KJPes=omx5oBpEmoFNSvc=vp=D0hEa-51i7tc_A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 8/9] libbpf: add support for
 the multi-link of tracing
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:12=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 7:44=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dong=
menglong.8@bytedance.com> wrote:
> >
> > On Tue, Mar 12, 2024 at 9:56=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Mar 11, 2024 at 2:35=E2=80=AFAM Menglong Dong
> > > <dongmenglong.8@bytedance.com> wrote:
[...]
> > > Pls use glob_match the way [ku]probe multi are doing
> > > instead of exact match.
> >
> > Hello,
> >
> > I'm a little suspecting the effect of glob_match. I seldom found
> > the use case that the kernel functions which we want to trace
> > have the same naming pattern. And the exact match seems more
> > useful.
> >
> > Can we use both exact and glob match here?
>
> exact is a subset of glob_match.
> Pls follow the pattern that[ku]probe multi established
> in terms of user interface expectations.

Okay!

