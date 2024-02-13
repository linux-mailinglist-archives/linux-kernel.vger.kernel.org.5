Return-Path: <linux-kernel+bounces-63895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E3853626
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D41B287C57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB85FDA8;
	Tue, 13 Feb 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xvVe6Qag"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDDF5FBB7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842079; cv=none; b=i5JvnX5jZjchdbOAoGZoIbKN4wtQbtgrztZfKfsBk5liW7PEa6IpiJlRDMRXXngBUPjuR0tkDxqlmFXclS5vsH+qMC3xCaJMAS4e2X83ZpNwFhjy5CzKD6Qke2q7yB72z69JVi3Xrsg2UxwCxja1gaUbgaoWeU1sa9V3EL9uTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842079; c=relaxed/simple;
	bh=qh9Zi6tg5C8H6VJFMfs4rvu5i4YkiIKOWDivVxYtq48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agfo4m0eBLXEIvKKxV1IFTznFpcXZ8UiJA+L+7g0d9vh40S7HlnQfG52fZLWWX5r5TlzmnVX6EzQiTv8UPuDvNX+Jrt25s2LwGEV29pjbsHF+Gj90l022jw6KyFWCQNzNhhniNvyt/0PvsVWB8nVjdDK3NUWStMcTlEdKJ3k4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xvVe6Qag; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4c0819bf523so1028457e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707842076; x=1708446876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QTZIUFrrp7MxF81J3CDcDQvti3Wc8zOpi4mNhiqNKo=;
        b=xvVe6QagAceznq0PTUM0WaqEZCCYMHBjjfBp+CSLai3VAFJb2lEc3gfHHEgR3SGW0A
         ++dVh7UXgpTsHh/h4egAp40tnwp4jX1ihMiFkb6oMCP5ChaECRVxKP9bljmmSUL6w8x3
         WOrzctnIrqOaYk3lz8Fchz85qg4mXp3eb/m78KhaJghCGeM/wDa7DtC9ZhytKMk4WNAV
         l6jvqYcyG6ZGUYG82QCoNXyEyMSudRZDXY1kauim5RwMV0AiPhZy/JJ84KWqiExn+lii
         9Bezt1FFr828oyHXaiaBv1n1hKnZeTgLfLV9qjbQyJvP3RmdMWVpIBILh2jSQHmm9MBK
         Yh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842076; x=1708446876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QTZIUFrrp7MxF81J3CDcDQvti3Wc8zOpi4mNhiqNKo=;
        b=hlmRL7UUo2EGQ5/a+8xKAShRzMEUMCNtZVg5gPkIy5+D632q8o5wJf3IDDdW6St4BI
         dPcN1ukSOiwdzdq9ysGsf/hvMMJXnA2k01ivydzXte0HEhRst/V8q1DDSs9xq5jhdpLC
         eewVGqwC6HPaZQh107NdhsYp3Mkl9MdXPu45LhmUU+6+wlnxFufY+8cpGSzaSyqfwpFw
         KTXMQoL+R0CXp3qJazRk7kGezfeTW7eERiamhc8cQ0GpEiVPM4UqrlYAnDqPsadQpNuw
         9hhlij73VmZSF0ZTMKeA53/GvlN8X6ipgw7ZlxY9r7OPnT+vYYOxEPNlYgSu1iR4BkuA
         YajQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx16ohJ/lp1cOJsefr9RuJ2gD347pncmL4oYy9OQFlXlqrzyTiNWu6lKbGtx8kHDAbrYfXfjH8oqXtc183WkXcNCFm72rO/jKgHbKj
X-Gm-Message-State: AOJu0YxerDF1/r7/2rOai33Pgq91l/ufAOUs0E0tzqjT3B904eIeftCC
	JdQLYAMmSsapIt0DpyXp85VHOx9a9+YMDxVndgij04ev91kQ3zDNmNU6FUaaxbWK3uCV3fzqcKq
	uytfqyHF8eA/dprK1M/82GdlvwcodnoouXBcBGg==
X-Google-Smtp-Source: AGHT+IHLrGY/9w7JE8p14AKLwUvvhQ6K08W9tSUadgwCQ43pxqBRLZe/15lo9E5igUFN0xb253wR/IYEhjg3+2D4N+U=
X-Received: by 2002:a05:6122:4c83:b0:4bd:800d:7308 with SMTP id
 fg3-20020a0561224c8300b004bd800d7308mr2775525vkb.3.1707842076222; Tue, 13 Feb
 2024 08:34:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182810.58382-1-brgl@bgdev.pl>
In-Reply-To: <20240205182810.58382-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 13 Feb 2024 17:34:25 +0100
Message-ID: <CAMRc=MfbcweVTo0-Xqe0aMyWfX14AHqYB+Y-1iK2nY_gOTHaiw@mail.gmail.com>
Subject: Re: [PATCH v7 00/12] arm64: qcom: add and enable SHM Bridge support
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 7:28=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>

[snip]

>
> Tested on sm8550 and sa8775p with the Inline Crypto Engine and
> remoteproc.
>

I forgot to mention that I also tested it on db410c where it correctly
reports that:

[    0.107312] qcom_scm firmware:scm: SHM Bridge not supported

and falls back to using non-SHM bridge allocator.

It was also tested on other platforms by other people which is
reflected in Tested-by tags in this series.

Bart

