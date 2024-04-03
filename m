Return-Path: <linux-kernel+bounces-130030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AA7897365
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258DA1C276A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB793149E11;
	Wed,  3 Apr 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JIbahdN3"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46A148FE8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156750; cv=none; b=ekguwjYt3ITyKEmZw+eHwCM9+vjalOi1BUpTBwFYJLdRcJB1z+mhFEqGCUpO7b0+8RRYIU/8MtWLQvU8teMqtlxxFQBNhyDTCwl8O2oU3CxibK+eOEWMoi9P1xlUHGAg7HWCjZA4RcpdzTpwc9+5Gm6unjfyH2fx1ZhpgCDOX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156750; c=relaxed/simple;
	bh=tn60vKHjPFapgtuUkPwXfSpy/taU/QcLKMDYSThlYro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqsNRvWYnZqNDfT4DvTFID10uIfamnIVYbM20t522GHON0HdmM6DTnxBGj2MDc+ibc4BOqanpmYnccdXExCqbQsa6/k13VbtvqowXfZ1Jc90kvxCfKFVXlepyJZ933fIzHr5RvQwqwBoJXEd8GDZrzKmeZIVvaiX6nYVsq2aD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JIbahdN3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e277154d4cso138915ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712156748; x=1712761548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGjaA6uK7iELe5s2Mt4kGrj959ypfrao/zFNpn4utmA=;
        b=JIbahdN3zovO8/s0DfBu9YOmfkRB6yCWAP3KyWs7kXC0oLYeis5e8u5KucT+dkHmQ2
         P4DP7KttEnH51EIwIXXGQOt+D3QI3MiQm2HpPhDbBQMXFFnT1XDegBkOKGg7PGuGVng0
         JMcehjSJ70AnTf9SBfM6EAdjVrbqlHI+z9AfUsDD3lo7eDdC5zlHCPLUGb8Fyrgp4afU
         sY9ydBzt36+QKA1NfLiswUts6ijT50JSg8J2gztJ3ZlEoEzx2VRIOI6TlQQ6pKn4tNYQ
         +jDVkO8vi8DuaSobz3ra8O3FvSQkAfVa5wdxkbxURWtZcQJZfXr6UvGcMHhnzLTZ9eaW
         /BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712156748; x=1712761548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGjaA6uK7iELe5s2Mt4kGrj959ypfrao/zFNpn4utmA=;
        b=wL+zRf18oHhvOT8wHrvaoJOiWXZjy4l631+VoC4FXGir6Q007tx7Ag4b2NcyFkLppj
         YbFfY587lQLah2qs/zGXwKs5t7+GMooCFiPCujW8JRV7diQtm7dcu9tDd6KhWnMwWljQ
         5M4580JwxcS/Cwv4fwjJW0pnoWTi3MBLm9oBHYFRRMOPOdoyfk7z8OOtOI1ET9jtI/nr
         zMXKcdGyAI6uHoYwEXvGDQidpud549FFY+FQ61mSO0+IKqsP3UipPk+jRY6vP5/oqzx8
         VA3rbOrqdJ66eD4PqdDgYS/LsdJRD8zamFXvaqkcSjNLOLtQq0tredo8UsiyJlr1kko2
         hBbA==
X-Forwarded-Encrypted: i=1; AJvYcCULDWJOEgvlL2RaZWpKvNjVT+CZueOAKOY8fVA0lXCTHQhllY9iZMmrW1c06qP1NJV2ioMfW6JZVob3AuqZCaxWaehq4MXORYhTrA9E
X-Gm-Message-State: AOJu0Yy0zWFVr0P/npZefk+ADhPLy7bly8BraJkHmy/XEzTXBRQPXMen
	WMQ39k43nbpkk2ThlpxsFq06z/VkjNk2mdOnd4krq50U9eEUdbQODcSYfFdap2Nju8xFnBLFN4O
	TWBJX8DMoozr61ft6ClsrhSCVEPF50QeUwa2v
X-Google-Smtp-Source: AGHT+IFj1uqHkPN2XkLFMOwYAqBWNsYoZRjBCVkFu+DunMVLPRkjoIu87gyUNaPa0EKERgjaFHvr4e4dlMSHWE2S6xU=
X-Received: by 2002:a17:902:dacd:b0:1e0:b622:4e24 with SMTP id
 q13-20020a170902dacd00b001e0b6224e24mr259868plx.20.1712156747572; Wed, 03 Apr
 2024 08:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403122558.1438841-1-yangjihong@bytedance.com> <Zg1l3RUMrzJaBYcP@x1>
In-Reply-To: <Zg1l3RUMrzJaBYcP@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Apr 2024 08:05:32 -0700
Message-ID: <CAP-5=fW36AauhRemyNah_a4bnLWisV2kxmVZadtSb2xHA8RfrA@mail.gmail.com>
Subject: Re: [PATCH] perf beauty: Fix AT_EACCESS undeclared build error for
 system with kernel versions lower than v5.8
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Yang Jihong <yangjihong@bytedance.com>, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 7:21=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Wed, Apr 03, 2024 at 08:25:58PM +0800, Yang Jihong wrote:
> > In the environment of ubuntu20.04 (the version of kernel headers is 5.4=
),
> > there is an error in building perf:
> >
> >     CC      trace/beauty/fs_at_flags.o
> >   trace/beauty/fs_at_flags.c: In function =E2=80=98faccessat2__scnprint=
f_flags=E2=80=99:
> >   trace/beauty/fs_at_flags.c:35:14: error: =E2=80=98AT_EACCESS=E2=80=99=
 undeclared (first use in this function); did you mean =E2=80=98DN_ACCESS=
=E2=80=99?
> >      35 |  if (flags & AT_EACCESS) {
> >         |              ^~~~~~~~~~
> >         |              DN_ACCESS
> >   trace/beauty/fs_at_flags.c:35:14: note: each undeclared identifier is=
 reported only once for each function it appears in
> >
> > commit 8a1ad4413519 ("tools headers: Remove now unused copies of
> > uapi/{fcntl,openat2}.h and asm/fcntl.h") removes fcntl.h from tools
> > headers directory, and fs_at_flags.c uses the 'AT_EACCESS' macro.
> > This macro was introduced in the kernel version v5.8.
> > For system with a kernel version older than this version,
> > it will cause compilation to fail.
>
> Thanks, I test on it, but since I didn't found libtraceevent-devel
> available there, then I have to build with NO_LIBTRACEEVENT=3D1 and thus
> this doesn't get built :-\
>
> Thanks, applying.

Yang also wrote:
https://lore.kernel.org/lkml/20240314063000.2139877-1-yangjihong@bytedance.=
com/
that may have helped you with this.

Thanks,
Ian

> - Arnaldo
>
> > Fixes: 8a1ad4413519 ("tools headers: Remove now unused copies of uapi/{=
fcntl,openat2}.h and asm/fcntl.h")
> > Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> > ---
> >  tools/perf/trace/beauty/fs_at_flags.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/perf/trace/beauty/fs_at_flags.c b/tools/perf/trace/b=
eauty/fs_at_flags.c
> > index c1365e8f0b96..c200669cb944 100644
> > --- a/tools/perf/trace/beauty/fs_at_flags.c
> > +++ b/tools/perf/trace/beauty/fs_at_flags.c
> > @@ -10,6 +10,14 @@
> >  #include <linux/fcntl.h>
> >  #include <linux/log2.h>
> >
> > +/*
> > + * uapi/linux/fcntl.h does not keep a copy in tools headers directory,
> > + * for system with kernel versions before v5.8, need to sync AT_EACCES=
S macro.
> > + */
> > +#ifndef AT_EACCESS
> > +#define AT_EACCESS 0x200
> > +#endif
> > +
> >  #include "trace/beauty/generated/fs_at_flags_array.c"
> >  static DEFINE_STRARRAY(fs_at_flags, "AT_");
> >
> > --
> > 2.25.1
> >

