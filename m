Return-Path: <linux-kernel+bounces-82569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AF0868672
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F3E29029D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7A1EAD7;
	Tue, 27 Feb 2024 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOkTVtsh"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2815D53E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998804; cv=none; b=PERxGqHH1Ff6BsLwEYsETv+d+q6uuhEftN3EqAiio3imWHzXNIR0sB+oRlC+dfFlFle7RXx5cOytzlH+Y03RvWONP21yLBzQ65rl1KFnQJzOEBuZn2/aykBuGvmDbL9fVERPiaEGezG2eJejbK5TxVZTme5qOstOFwj01AmWFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998804; c=relaxed/simple;
	bh=4S4jDqDL1DUGgGXSUskhjdsGXIhGNsCdJ9oLr7BFdMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8NKyEvCe6Rvv/TvmvA7748QHeZJWAXWznpPhoPQV1NRIuKwyMpe0y3FMqdZntRSgL9KunvGcXq+lK6lBEsU/y+XNSxHghWeACP2YPDJ2swBWBpUAVqFVc8uAvAX1M/6rpQW2X1h1P3SF6dZ96qEQF7UhRi5rfow6NvWVvTSJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOkTVtsh; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6087d1355fcso21617587b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708998802; x=1709603602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6USE5wdkkio0lfiZ/tGqZ6PFDqZXdzVmrvIAXJ0Sak=;
        b=nOkTVtsh+kGttGerySO37MG2BO7RhVpjJ/TPfwXIkpCFZIdLulEmi9e0zuI0vQHjF1
         Mqhh6BtQ35KFuBxwbu9+y5SLRSzb8Czde8sV67OXW+pbkeDVzOOstzKwJZMknE2ZhX4O
         3BIAwcfv05eH8QSUMnl6Lub/stA5LZPgHJ7dIir5EaoNBBnncSg+CK90b9+eFSL1sVij
         co1JBqEnhU8i9ku3gMAT2SzG3aZHTfifaSl/qXOmtLIKY++e3P0TbC/Eu8QGibE0pkV/
         Q4y/mCxUiA5ijApE6nWR5VWY0pcA7+5d+QfQv/lVEnO31C6u/UFSNAp+35zTMhp5IW8J
         qYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998802; x=1709603602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6USE5wdkkio0lfiZ/tGqZ6PFDqZXdzVmrvIAXJ0Sak=;
        b=j/+WwBM8+nTqexgLf1Jjp+RyPIcDMHdbgMIxQZ9LE3ix1JLcCH5xrRpLtxtsUxAxpP
         sK0vZflke/E4gOxaXzroKMSp5mPGtDWrTXjsC4/w419zUX9Yy3J3hFiMONYMUIFDQH68
         fFrpp++P65EJj19GPl6z8WhaRgYYZLPhqXQJATQ1QRCAUGEpaMQIxu9r2b+I7gAdd2Pb
         zzcepJGOqrzjsHbB571TaS0yaHxNu0iZ1xwZbFRqbwsZJlUnrK4iG56WIGpY8TLHbN/3
         ZSx02gVJbK70UHpm76vKrhVTO/9QJXPoJtelV82Rae5KLqzVwVQeHBr9Cr7Dw5PaIS/o
         57jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVv4Tr6KZIDQiTiVpf+cdgoDrnSFB7RUG1ld+r1hsT89hw0xjLIPN5pfES8LjRODW5JxkZVc5waNo8g3vjHh0SLMhH98ctsle8Q5nu
X-Gm-Message-State: AOJu0YzMluszWCr9q2475TP5F+ei1iZJDA0Nm+vGPBm/MOOMBGZDzXlo
	e7q8xatnn/wHFEsOGsw/plwiP+pcvq2XRZ6JrkDPytojSUDvSU6ASph89MMfOudg09JlEk+6Zon
	RD1X3SqR8TVYYpIcWcReBJjAzC78gXIEZF3Tk
X-Google-Smtp-Source: AGHT+IH3NLEq+kRwFV52T3PyanitX2Oeaf7rYJMYskdkACQ4qRASDE1wbegLDTCv2W+cgMJJRENl6Ce4sSz/CsZqQII=
X-Received: by 2002:a81:e209:0:b0:609:2104:3cf8 with SMTP id
 p9-20020a81e209000000b0060921043cf8mr817872ywl.41.1708998801798; Mon, 26 Feb
 2024 17:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226080003.4094089-1-usama.anjum@collabora.com> <20240226080003.4094089-2-usama.anjum@collabora.com>
In-Reply-To: <20240226080003.4094089-2-usama.anjum@collabora.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 26 Feb 2024 17:53:09 -0800
Message-ID: <CABdmKX047LoKGWAJrEyu2egpRw8K-_=-ZPkxQNZ5GXtwzb_V4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: dmabuf-heap: add config file for the test
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 12:00=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> The config fragment enlists all the config options needed for the test.
> This config is merged into the kernel's config on which this test is
> run.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/dmabuf-heaps/config | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/config
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/config b/tools/testing/=
selftests/dmabuf-heaps/config
> new file mode 100644
> index 0000000000000..34bd294836df0
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/config
> @@ -0,0 +1,4 @@
> +CONFIG_DMABUF_HEAPS=3Dy
> +CONFIG_DMABUF_HEAPS_SYSTEM=3Dy
> +CONFIG_DRM_VGEM=3Dy
> +
> --
> 2.42.0

Reviewed-by: T.J. Mercier <tjmercier@google.com>

