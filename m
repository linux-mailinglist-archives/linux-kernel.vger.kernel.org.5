Return-Path: <linux-kernel+bounces-84804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1058086ABCF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B081C22FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA6F35F18;
	Wed, 28 Feb 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJmO5GLn"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF9524B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114436; cv=none; b=LG3x8ixFLs4FXD4CxM4l0tg79zcfF+dt2xFAmUe+d03zaqd5WRB4ZpTKyuXzG3OTHtddcCUHznJlpybBtKHkfBqDpv43KR6BKORmSdxj25PsWEHcq4xFf+fpWxfBGzFL357id34ZiuNjOfzFrI4FloJZ383IH15i2mm5zuO/hMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114436; c=relaxed/simple;
	bh=/OFOYJO9fNq+le6RofdDTSz5sXThcZ0otJw9BeiRtxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGFH/itW2G2mgHqXcAD5hA6SAZIpopPnvSmbkbNSf0p5lHI6jCdhO4NrN9knZcngIS2+8WX9eGfirbTVqxjNAXL6WfUT4BytmApW3abMxZsnBnx/ckdONHK4viRs4U+pOhZOfpL2rowfLnwUuMj/xpfS1FsWAGhVuuvEKmMJZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJmO5GLn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-299a2456948so3752809a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709114434; x=1709719234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPHruuFdx24/IA4W1sr8Tequbs2WOe5ryCA9XwyzBDA=;
        b=RJmO5GLnJrPjwl7l/trb0EgOcHlmcgYteDBCj5S8DWZRrcCMBqsL0PDnT+gZEGYpTy
         vGyM+DjBCd7YpVzyI8d8dKHYb0g2sQkrSXBZUD60a6oOV8TD0AUVe9uSZu3bzv6ecI+E
         iwoFGxccYdBK5kthlAV1EVBkO07FFyR5x02zaQmpApcFezD0uk16uW8FP1eZJ07Y0WLO
         BTxtkgdjfvt5CuAaK1aMiyeRbmqZqT5KrDlzzLBf563xgYTu52HWfKNijHzmIwcbuweb
         z55KaG8w+rgSsBoeD0UlKEl0moYwXY9COj3W9IAJGMxrpJz8jfZJNppx5QR+KtQEIKJa
         Phvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709114434; x=1709719234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPHruuFdx24/IA4W1sr8Tequbs2WOe5ryCA9XwyzBDA=;
        b=mDwHMaVrQLvwuogmyL+8y1a3YakR7nK1RjMmhAg4Ikf3j5vxZpnp4CBEjGGBUeLlFw
         Fxnz1cYubGVftFojZmj+XeyD802fP4vOrbVhefxZSfSJZMgb1iQempvCNxroKI/zm6Xf
         02nHN640RflG8OnueVcLTcwCgsXl4tCbhjaRB4lP4hkpSQgvGJYbzt11SUmqxWNJzzH8
         moYNKGWjBE6mX+e9WQQH82j3esSCeL0zEHpe1MB3/inCGtHgGfCDzJgAFfQMwKrllv6/
         kiOGmC1QJ4QFJherFi2mt4+Tb8zagpJX3S8HasVgJ1hhAr8en013QAmNiLvf7IgyJyIs
         db+g==
X-Forwarded-Encrypted: i=1; AJvYcCUdoswVXYsON0FfWyecvk32PF0II2D/q4RPDhFgnuFoM9YfOgoaw3INRwmQJkwW24eONSTpB3tgoi2wT2UZQE1JOr/rYTZO7KfBFeFa
X-Gm-Message-State: AOJu0YxXfonBiPbF7jKZAAg+8e4aNMWmbHosyJyNY5fqhs5C0FoCIXK0
	3TSgWHSB2tq4rZFa4Q2tws0P3BAfn47j9yeTBbr3MFGEI8VaQPYna4aZvbc09PzyXuwRQ1ULxCF
	sbvOn+Atx1D4DS9xM3SYTyVEDVcs=
X-Google-Smtp-Source: AGHT+IHm1nywjN9W9zXhaclmdqDXORkERqR7/9idl3dYmgB7F23JPaeB02bDRI9xWer6fqET4+uHrU9hzV++gAN1hb4=
X-Received: by 2002:a17:90b:207:b0:29a:8497:22e with SMTP id
 fy7-20020a17090b020700b0029a8497022emr11223846pjb.29.1709114434221; Wed, 28
 Feb 2024 02:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227172852.2386358-1-tj@kernel.org>
In-Reply-To: <20240227172852.2386358-1-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 28 Feb 2024 18:00:22 +0800
Message-ID: <CAJhGHyDrhsgBcFyqdJ1w3mHmSGaJXErRppcWy7muHWjnL8q=sg@mail.gmail.com>
Subject: Re: [PATCHSET v3 wq/6.10] workqueue: Implement disable/enable_work()
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com, boqun.feng@gmail.com, 
	tglx@linutronix.de, peterz@infradead.org, romain.perier@gmail.com, 
	mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

For patch 1-5:

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

thanks
Lai

On Wed, Feb 28, 2024 at 1:28=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

>
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v3
>
> diffstat follows. Thanks.
>
>  drivers/net/usb/r8152.c   |   44 ++++----
>  include/linux/workqueue.h |   23 +++-
>  kernel/workqueue.c        |  384 +++++++++++++++++++++++++++++++++++++++=
+++++++---------------------------
>

