Return-Path: <linux-kernel+bounces-136825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E101E89D8AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FEE2862B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21780043;
	Tue,  9 Apr 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0FxeHBd"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0655129E81
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664084; cv=none; b=nOee+4QPR7GtTsNB0M7dBpg3IBnFHkICEGlz4nqSC9nBfllurKAurp0locN7a9h6MDhJEuDEs8RJ6MmPxwVSlPnVmO6gH4DitbJnPtGktB00cTMbjeaQ1Fvm4jOCBz4eC780VO+uqtOWjup/mAqAylr8huaUtNyEb0cSIV2qJdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664084; c=relaxed/simple;
	bh=/bJkIcYPyNFLkwEnXNF99Y8h0DtpWIDGG30A3oUtr9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdeJrkhCY7dksWu06CX98vXugQaEAchFD2el18COx0ueABxW99RLIpWmPnhu4q2tPWZFczvJ7AeKCcJ1H6AWoVsyRYMsAWKDA0zdcKc9jTaRU9vY8XKwWosLU5OQ4sYGPDUUENGmt8/PuDT1wqGP8vuhHpm+I+y7FIixpxPAbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V0FxeHBd; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c5ed27114bso450108b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712664081; x=1713268881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bJkIcYPyNFLkwEnXNF99Y8h0DtpWIDGG30A3oUtr9o=;
        b=V0FxeHBdkZQ+o6HC94cZygYR+Xjvwxql88Cyzl6Vpn73+DCWvqcVgSf5O6h0P1kOjm
         79Q5TdQE9wekXswdzU3lNr7cdEuc/G0l8vUmV8W8YVSicbcXijltOdiSQ7M2h+q0Tf2h
         GqHkAqft47gwnupuAbHy7a9S1kpAzGwanRiZIX+USa1U2pVVDtYVi39BoRN0sRtqTjGM
         409fxdb6wit+nAVMq3j55CbfEe07u3w//6DcWDsQKySBInWBLTZiZnf0fiE+TS4oFuq3
         ETHYz+IFw5UaK9G3Ne8sfQR+1UDcQhewD8UQieF1aH7o7NE7Nx/cEGLxlUlZ3ZZEZPXj
         gwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712664081; x=1713268881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bJkIcYPyNFLkwEnXNF99Y8h0DtpWIDGG30A3oUtr9o=;
        b=NilqQgLkPugGfRn1JNzenB7N4tpGoIDGsB/6Wbt6XcPKtydHe3CAmaeAgWAHnfAkcv
         nqXOh2Ap0hRPPiRg4LKTF+1jaAfGUL2q6UrE98KdTQCtXGxqaSJhKk6ctH7pg6jon6PL
         0gyu0SYphgpl5gfwIjDGp74ys/lMMqozqk4rjtzqTrk/gSdPEfLX+F3XIUuDHzsMYESh
         6F0cN2C5TuXCnUhJizIrxqCQIVDb0O+yhou/kYGsG79ZlNOKTbCoG/rX5+viG7T2lBvX
         BbAaYr+I56eBaCbM7bkLEmvyEZaokiB9CkLUQ5fSTVvCUo6x56A0WWZbRZg+3xu13mHn
         krcQ==
X-Gm-Message-State: AOJu0YxTmUHo9qOqHncGHquuBldzwilhLEuFtvwK8rXJLUVejOC/PRpK
	6U0I4ocov5Sk2J5hk1UOzMStsXUtXQvtdYBvAQXnJE0VEwJ48gzB6HfyubC5M+HritTGqzw9raj
	m+ii58lrjjePdwwzNtWcp/eH1UlNh1T9iHR+AAg==
X-Google-Smtp-Source: AGHT+IHvCXB+IR0sKbXE066F42lsqz3+YeUibucf/KdS8fPmJNMZ+gR8gytCo2qCKC+gCADN5Y/2vZAoWEhybIwI6FI=
X-Received: by 2002:a05:6808:21a3:b0:3c5:e755:834f with SMTP id
 be35-20020a05680821a300b003c5e755834fmr1114418oib.0.1712664081629; Tue, 09
 Apr 2024 05:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405115318.904143-1-jens.wiklander@linaro.org>
 <20240405115318.904143-3-jens.wiklander@linaro.org> <CACRpkdYLCuRKZRqRUkav7UoT+0FSaMmciH9bps3VGgxLCw6+_g@mail.gmail.com>
In-Reply-To: <CACRpkdYLCuRKZRqRUkav7UoT+0FSaMmciH9bps3VGgxLCw6+_g@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 9 Apr 2024 14:01:10 +0200
Message-ID: <CAHUa44GozpaRSC4oNiGCG1Myv+GE8bvk6aHS0q1ecQwW-YMMUA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mmc: block: register RPMB partition with the RPMB subsystem
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, Apr 8, 2024 at 11:07=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
org> wrote:
>
> Hi Jens,
>
> On Fri, Apr 5, 2024 at 1:53=E2=80=AFPM Jens Wiklander <jens.wiklander@lin=
aro.org> wrote:
>
> > +/**
> > + * struct rpmb_frame - rpmb frame as defined by specs
>
> As Tomas said maybe we can write the name of the spec or the number or
> something so users can find it?
>
> I would also write explicitly "the stuff bytes and big-endian properties =
are
> modeled to fit to the spec".

That makes sense, I'll add it.

Thanks,
Jens

>
> Yours,
> Linus Walleij

