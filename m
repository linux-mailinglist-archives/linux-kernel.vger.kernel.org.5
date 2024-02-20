Return-Path: <linux-kernel+bounces-72752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9137885B853
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD17283038
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC71560DEC;
	Tue, 20 Feb 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lDdHorO+"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08DF65BA4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422857; cv=none; b=C+jPoL/0FJbr6qhS1+biYC7ehl1GD3iqgXPl/p1uUKXU8qKOmH+1uvrwZZzyoxqWKCdHvmBRBAmdi3AvgVgPuu1QPLmtoyGgUCskzBECvP+s6HSZySKalaVc8vwKshtm5D7ctbKjSvTZI5amOjxWM6wGn3zduu8VosvyuE3rg5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422857; c=relaxed/simple;
	bh=4xzN47cfbSqo2a8NkyQa4EL2L6QY3ra7B9pOZIDIlz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDos0pMxF1qOlWRk09HxK+7DKzTjKyBaJB8ucI3qHrLtrlvgyzIk6xRTTt4Hkm8BJ4FiCOC7UD/Dx4WE6OcxMFlALpQoJXOVY5dFTvTdETI+Mm76SKkk/Ecr2Vn7mqM6ByhOgQQKJRAHHn9jmDgvsYFRaBo2OlYc9JFQdVIgb+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lDdHorO+; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d5c257452dso2031652241.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708422853; x=1709027653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xzN47cfbSqo2a8NkyQa4EL2L6QY3ra7B9pOZIDIlz8=;
        b=lDdHorO+lkfPQMdArhhqvsmZumn00lMM9ChBwlJTyrdXR9C1SW+jGrC1BOqtVsRcz4
         a9sEehk7uszhNFjO5ej8c0DGoE0opL7XrHI3Xa+mZQ6Gg87x0MHM232QA0Ce6rycKRUL
         3k0h+R/wF6BnPS4Moc4tk+q4mdo2QuMWaPnNcvAUh9WmcxBcR5aAZwOmVzvrmypu6lLK
         dLP6ao+K/EGrSAX8nrf48cTADgeWYG1Hj59ZP8VL+QS31aW27QAe+EY4Xs7HfZAcCLZa
         uZfw1lN3B9owYyOBbOBXuZFzrSePGTmXIGsnU5ETPY9SEUyjLdV1TDKM7mEETMix3YYL
         PnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422853; x=1709027653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xzN47cfbSqo2a8NkyQa4EL2L6QY3ra7B9pOZIDIlz8=;
        b=ZAfhUcrt/ajTY+iLBbEV8AEiHSNkHP2AweiuUpoMz/Xvnv4xa3ZSItmKupuq7iLNFt
         wbL7TDdciCLg6s8mbel8Hhfgq52taY0ij+J0AlqNtS7GKiiLgM3UDb354bFMzC3NXs6v
         8K5YCUYo3KWfCdhPSOuZf5Hz/3l3f3ddUGKOSWYqphPD34gJr7q+GOBVVimL/BGYr5xI
         6g6if7XzEK+Duo+DChUHDsdZNzgcvXO46ZfzNkPWK2CIC5/UBGMJdAHYZG+4owc81xju
         pBWN5oT15bmGI8DpGOPaZ6NrQkXQOWW91SstgVNcN3n+CEwC6AUlUfQapNjH5TE5/v5a
         IQFw==
X-Forwarded-Encrypted: i=1; AJvYcCW3qLx2yCXBW6Gz1612bM+2MR+wPAUpCwJdmEmNJQ7LSGQj5LgWpyxNerBRPmOWOpKiHZP4TPiryh4tlCPHHpRZpnrL8a9klDOvI60Q
X-Gm-Message-State: AOJu0Yy/2aFtVLpjDH2w4eBugFcOspgG6QmuZufeLTvf2JLSiCM7PO2S
	7SC0ej1GXCx6NVq6TWroSLKFet1SGadw571YUwNxJJi/SYyiYoITnV3kpFa0Qypdefed3lHW+da
	iJp8fWyGOzDIxITDX/ThJ5lMrSqB7nawynxhNBA==
X-Google-Smtp-Source: AGHT+IGg0Yy/XoNbR6IfOmnx5l8zqnMeE76L60nsYWm8H5+Bhua/gwybe1nMinRutBrrSD8nrquPZ/DI8Do5B76kNsk=
X-Received: by 2002:a67:fb56:0:b0:470:397f:157b with SMTP id
 e22-20020a67fb56000000b00470397f157bmr4981944vsr.12.1708422853472; Tue, 20
 Feb 2024 01:54:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182810.58382-1-brgl@bgdev.pl> <20240205182810.58382-9-brgl@bgdev.pl>
 <yu5uhamdlygti3jo73ipy3gxhcmgxrm5g6imgqg6ksleim4ton@npvzlex2j4xi>
In-Reply-To: <yu5uhamdlygti3jo73ipy3gxhcmgxrm5g6imgqg6ksleim4ton@npvzlex2j4xi>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Feb 2024 10:54:02 +0100
Message-ID: <CAMRc=Mctm-cyYPpu-Vb+fr1cWJPUW49shaa9HEXYp+rkF_CHUw@mail.gmail.com>
Subject: Re: [PATCH v7 08/12] firmware: qcom: qseecom: convert to using the TZ allocator
To: Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 4:08=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Mon, Feb 05, 2024 at 07:28:06PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Drop the DMA mapping operations from qcom_scm_qseecom_app_send() and
> > convert all users of it in the qseecom module to using the TZ allocator
> > for creating SCM call buffers.
>
> This reads as if this is removal of duplication, now that we have the TZ
> allocation. But wasn't there something about you not being able to mix
> and match shmbridge and non-shmbridge allocations in the interface, so
> this transition is actually required? Or did I get that wrong and this
> just reduction in duplication?
>

What is the question exactly? Yes it is required because once we
enable SHM bridge, "normal" memory will no longer be accepted for SCM
calls.

> > Together with using the cleanup macros,
> > it has the added benefit of a significant code shrink.
>
> That is true, but the move to using cleanup macros at the same time as
> changing the implementation makes it unnecessarily hard to reason about
> this patch.
>
> This patch would be much better if split in two.
>

I disagree. If we have a better interface in place, then let's use it
right away, otherwise it's just useless churn.

> > As this is
> > largely a module separate from the SCM driver, let's use a separate
> > memory pool.
> >
>
> This module is effectively used to read and write EFI variables today.
> Is that worth statically removing 256kb of DDR for? Is this done solely
> because it logically makes sense, or did you choose this for a reason?
>

Well, it will stop working (with SHM bridge enabled) if we don't. We
can possibly release the pool once we know we'll no longer need to
access EFI variables but I'm not sure if that makes sense? Or maybe
remove the pool after some time of driver inactivity and create a new
one when it's needed again?

Bart

[snip]

