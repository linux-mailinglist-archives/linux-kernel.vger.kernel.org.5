Return-Path: <linux-kernel+bounces-75351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D085E711
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B95C1C25108
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DA785C47;
	Wed, 21 Feb 2024 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8tP7os8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8485951
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542980; cv=none; b=iqDzv8X/0LVCcgdHNPb+yitAwnNwx2YMd7/g67dztoLRLmZ6aZF5FWCcTAw84JGpY/6/WYhkkhhroWjk/HnV/d0Pua8DXEjg7ESJyCfqNDatVU61lXYw0Z24VJ2fPXxqg7I/eA1aUIhG25Aev080cBdMjDrLnySwhjb3HEIL4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542980; c=relaxed/simple;
	bh=xeSqTcdOop8ByxjajLeXj1vNEujmvPFWktRS4l4TJeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOFnebmGDT7Ao7iq/9zh2k83Rng0jEpEivr4EnDfiMQ4VH5rdHjECechd9ioW4qQCz1iIPaotqn3km98+eibNr2E4qy5E3etpLRJ5svO/YiSawTopOYbs6tAC5G5t3ZmYzmsa9ETt7pFxheKu/xO2TUG+XCFnVT2BuBKPvQ6a0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8tP7os8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4120933b710so11095e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708542977; x=1709147777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeSqTcdOop8ByxjajLeXj1vNEujmvPFWktRS4l4TJeA=;
        b=A8tP7os89VJjNODbvmZOSIY1DiYI6w6TlaoL/qu81JK+bb5iia0oRy/V4ASrXnLPhR
         IOYzRhH9x1+oUQ3ZHpMYME/UqKEKSpZizNj0BGd2/BEnLehWjADIjsQC1hGaCMB8rlis
         uTYHZgBScBKQWsasMLyV4r3Eb/c9j7A+xSsRAlpNztY9IDAJjtkCJ38gwrmV6ViidXIW
         S9LtRbsRIUMM2Wwu+XfNYufE77fNjij/JaQgOG1qmmsQd+XdY8wXClWQN9eXtsiwgt8p
         my+Ah4XcbzzwKmW7foMClojn12BA0lt7bYR8E7A3HgGYtzkO0iBndXTawvCJhK8eaf/i
         CWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708542977; x=1709147777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeSqTcdOop8ByxjajLeXj1vNEujmvPFWktRS4l4TJeA=;
        b=MKuOB4x5gvwTz7FJ2qUSaN/f3lOIDQeKepDapy3I+TF+VXfjiUgJVGoBqY7c76jK6V
         hr170veSBbNAkjEv6td4pmxUyLGFaYyrbGVfKIGLLkaRd9bjcJwOjHFUrVjTHyXsKS8f
         7HGri5Nqx4VhRsikNOdd81dKPa94z3yVQOsdOO5uZzEF31DghPjDLMFQw9UdLx6PX0LQ
         fJ6yRMmvqdjEK6sqLabEbo/tkTsDKE1AFQMx+vMtxAU8IPx4fctPag0IBsqJN8nq5ZL/
         rJ9GP8m2XoxTKVxsZJUv8/FQZPO4XdN0SNu+b+jL8FarHTuIJwlevn+Od+MzNNN6DYax
         6Lxw==
X-Forwarded-Encrypted: i=1; AJvYcCUZreU80/rllxbcaPUBEO0OO+9dbn5iCJip6KaxX8R2Ply3YXI8JYQGhCoO0GkPTKyNKhq09wJqkav7q3KCC3uFO1+G0CAC2rlky7Xc
X-Gm-Message-State: AOJu0Yz/XZDE4q8TuPQhQsSb8oJvNWEiyLGpGnExDZl6DPmKQU3AcZgT
	ReNu6MrcXBVBPWE0ErbJQOY8R89vPR/HTg0ayyB1ThdzLhSKUwFi8mxADY7ZDIPxGuqpCxN8ToM
	q+rhaxW5wf6qg+HcAsAq1KuRZ69zGSzkbP3A=
X-Google-Smtp-Source: AGHT+IHfWwtX8dHD2LEvTjtF4HrlIuaoj7Y5ePsGJmz/DJzgL+q4H/xqoIF5hBAWPi4D0Y9C7oG0up+wE66eeedOE/w=
X-Received: by 2002:a05:600c:6002:b0:412:7852:bfd2 with SMTP id
 az2-20020a05600c600200b004127852bfd2mr144259wmb.2.1708542976688; Wed, 21 Feb
 2024 11:16:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708508896.git.u.kleine-koenig@pengutronix.de> <8775e9573fec55c5fc04151800829e9aeafc5dda.1708508896.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <8775e9573fec55c5fc04151800829e9aeafc5dda.1708508896.git.u.kleine-koenig@pengutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 21 Feb 2024 11:16:03 -0800
Message-ID: <CANDhNCpURMQmRwCyt47SnSWJO=uJiaWNr9QVmmAMBZ7r5JhJMA@mail.gmail.com>
Subject: Re: [PATCH 04/11] misc: hisi_hikey_usb: Convert to platform remove
 callback returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, Yongqin Liu <yongqin.liu@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 1:54=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Looks fine to me.
Acked-by: John Stultz <jstultz@google.com>

CC'ing YongQin as he still has hardware to test with.

thanks
-john

