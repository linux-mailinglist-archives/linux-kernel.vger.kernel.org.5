Return-Path: <linux-kernel+bounces-133703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8589A78C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F461F23400
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65936B1C;
	Fri,  5 Apr 2024 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZKTLgEQ"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B42E852;
	Fri,  5 Apr 2024 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712359009; cv=none; b=siHn4uCk+aL5gAqWBsXWTIpZ4egZub6ZgBGAh/qQqVcBHK9y6evvaucSWKRXHK431hLr6yKOCfn8pqtYvVhFtVa9FfMABwkjS/wvhzih1U6lzKvPubQCl1+Ne18oIWh1IVjZtmlu/aC8Tc/0537xr9DAAWrOy5CdrAU6SM2mXkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712359009; c=relaxed/simple;
	bh=6AF7nJyIzV4qfOtMYOfEHVCkE3ZqMbi869i25rD9LwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GY+twvlCOFipAyK8P/Q1iPOaq59jaiV0GS55HWgm2a2MqPtEQ4qWDEAmyMOiEQI+Vvx1S4m9tVCetOWdIA50Wwv8SE20E4oj7sb8Z8qYlijQkizDa1oncvwCBiziX8RnU3cBvYWHSKn9Av8MKhBgmn6UIqPZ22KHe4eW2ryiWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZKTLgEQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29e0a1fd9a7so1842560a91.2;
        Fri, 05 Apr 2024 16:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712359007; x=1712963807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMjaG1Ua4xv+U+nuPv0Swd2atb/OKUERpZDEdaO/BV4=;
        b=QZKTLgEQARx2ISnecy8WxYp5dzHb4oMHfKo993n2QhAMCRptQ6b2sTQYiFaFsQzmmN
         isqJ3L62i0QK7PVOWHDlt08kh4Xl7AigineyHuHLBnfYG3IoS0yvMYrY25bLSH+WgWYB
         r2q4wp7Vg4l05gMc01CfavbqyW3JxJg2GejIZQmqwR7bozEOUBbQrCf6wHwFqAvXCTrm
         8K98APOKlOQoD5zjSHT5NWxqRKJL53te8TG4jTcEjsGNcW1shhc781Rz+6UXj9XqPVK1
         4DCNC79o2p+svm80jJfFZ8jduA5t90LPKhJZWeibJ9va8yhXpDhd/yXjrPSDw+0a5fU/
         8hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712359007; x=1712963807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMjaG1Ua4xv+U+nuPv0Swd2atb/OKUERpZDEdaO/BV4=;
        b=Lbblq2b0SanOxjO/ypaeGOuMeRtcwEHtElvs1dZa2cxsZXSo+0V48k8DkuX0j0YX2W
         RTdP9Gt5E+R2lFvd/RKKifc19x0dY5cyEhPlrdRCMx1k33/kzanHCWqst+AFn5b2LnTU
         hZXrII2riCBS9kVkgU1YKFNa1KDIOVpUAL/7fnmTAXC6LBum+1nJ44z50fmluqx2GZ3j
         AUCUW2MJp29SQy9LCYXZLYPT+yn1I7jd1EKz6qknnAwDR31s4O7kojYW2NEKpkaXhrv7
         pEugGR0/cv1H34mcle5hjZ5ScjcoogeG7/3H2Y8R8XvmK8NJcVgChW4wA4Gi5hqpjvXy
         skTg==
X-Forwarded-Encrypted: i=1; AJvYcCW6OoVE1q5BIVsHvMYgB6upniZ2/Rjf6z69a0MUAoiknDsw8VJgH9DaRiuEfmAWpz9oh2kFRhJq6gpAnxQqx2URGKpH5cDG3G3yE8lGwhDSXxasDwMWN3cyyQ24LL3lxpOW
X-Gm-Message-State: AOJu0Yxz+DXe/FWgOKWt+enwowx2PTGevN2Nrk48e2fW71kJvN5mOb23
	02UTlFdK9IQkHFz/voxxUojU1MCExd9tns8O8jufs59ENRP8+OiFnfKU4ovz9qzQh1kqNDlO4eO
	YXej//N38MVjq4F8YwIrjLrikAd8=
X-Google-Smtp-Source: AGHT+IFvPyZkSjIgQcVbFrRSyAxzux8dlpn9lmqLb7tUlguobAiuD1/58uDXC1aaOudLgP+qppgnXlqwFX13Wm0aqfQ=
X-Received: by 2002:a17:90a:c918:b0:2a2:c20e:7baf with SMTP id
 v24-20020a17090ac91800b002a2c20e7bafmr2717578pjt.6.1712359007297; Fri, 05 Apr
 2024 16:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405223556.11142-1-andrea.righi@canonical.com>
In-Reply-To: <20240405223556.11142-1-andrea.righi@canonical.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 16:16:34 -0700
Message-ID: <CAEf4BzZyd2T_S+46NcKsM-Vv0mMnsgGd_Hzaq7tn4DFkD+GOGw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] libbpf: API to partially consume items from ringbuffer
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 3:36=E2=80=AFPM Andrea Righi <andrea.righi@canonical=
com> wrote:
>
> Introduce ring__consume_n() and ring_buffer__consume_n() API to
> partially consume items from one (or more) ringbuffer(s).
>
> This can be useful, for example, to consume just a single item or when
> we need to copy multiple items to a limited user-space buffer from the
> ringbuffer callback.
>
> Practical example (where this API can be used):
> https://github.com/sched-ext/scx/blob/b7c06b9ed9f72cad83c31e39e9c4e2cfd86=
83a55/rust/scx_rustland_core/src/bpf.rs#L217
>
> See also:
> https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonic=
al.com/T/#u
>
> [ Note: I haven't implemented the special case of n =3D=3D 0 as "no limit=
",
> because we still need to add a bunch of extra checks for INT_MAX, making
> the code less readable and, from a performance perspective, it seems
> that we may get more downsides than benefits, but I can try to look more
> at this if you think it's worth it ]
>
> v3:
>  - rename ring__consume_max() -> ring__consume_n() and
>    ring_buffer__consume_max() -> ring_buffer__consume_n()
>  - add new API to a new 1.5.0 cycle

You also need to update Makefile, CI is failing right now ([0]).

Please also add a simple test to BPF selftests using the new API.
Other than that the changes look good.

  [0] https://github.com/kernel-patches/bpf/actions/runs/8576515495/job/235=
07610313#step:11:73

pw-bot: cr

>  - fixed minor nits / comments
>
> v2:
>  - introduce a new API instead of changing the callback's retcode
>    behavior
>
> Andrea Righi (2):
>       libbpf: ringbuf: allow to consume up to a certain amount of items
>       libbpf: Add ring__consume_n / ring_buffer__consume_n
>
>  tools/lib/bpf/libbpf.h   | 12 ++++++++++
>  tools/lib/bpf/libbpf.map |  6 +++++
>  tools/lib/bpf/ringbuf.c  | 59 ++++++++++++++++++++++++++++++++++++++++--=
------
>  3 files changed, 67 insertions(+), 10 deletions(-)

