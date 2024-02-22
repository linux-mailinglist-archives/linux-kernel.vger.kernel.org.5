Return-Path: <linux-kernel+bounces-75901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982C085F074
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EC51C216D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D218D1396;
	Thu, 22 Feb 2024 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP249eMl"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59610E5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576507; cv=none; b=mKr93JuwM3uuzGizZP+drgJ1KoKaQ6/5kI6BalTFTcvKzhuGKrRsZ82umRYbBAxq76Q85Ym7QlFUxf6nXTKyMGBDiawK3RRM5GMLqzh4eAsRgcxyFCotYtJ1K1U+t1l/MFunw/RfJlpE4qiRa9IzQZV/twcWkI4yRBhxJOBqMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576507; c=relaxed/simple;
	bh=bDSh2knwVrNKJfmxROY0X5nCMgibjZZ6exazpdHrFEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7ODWP2RxJzqP7tvfhcjvLeT8DAtXCD6cqIV8lxCRjSvSAXLrMT0UjADX2xLLFXL+EX/ecv4W9scoEsQ108Rma1bNLNAwWvJ3e4fl3ZemLLfVa4JP2Nk1VbX4lZVKeNFWqHWu+UcQO9xMe2CJ8bFzj4QAWD+5Mr0Ew+EubLiVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP249eMl; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e2e44aad03so4116628a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708576505; x=1709181305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBQD7tnFOjoQHYTQUmw4ZSBBoid0r3L9wTk/Cj72Dco=;
        b=FP249eMll6DFbs5fUeeZ3pfufiEy2IoetnJn9mVx4/cwQVpKy4bnSwMzmVsH8Psws1
         lzvuEKAH69kPNdmS2qUwMWUQg/Xc0BhUrel4xyDblWiGgLwm7eSWKZPHhTouar2j//iN
         UDxnkHl/eDcQGCudfkfxLxTd+iRG4UuDvJ5e7GStB29+2Xm8qKDdRlPYbeIZvFanfSMc
         v++qyMOeaj5OAFtsfyt66r083QhoaJvdoPKfG3owyApiuLinIWDb/ECxI3gUux7YA9bs
         T+5QB6h7fsINUGerkc80ItMlMXOWHnySJmsOjltwP0/tw0uERvvrAthlBbirxnV0YKfZ
         kPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708576505; x=1709181305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBQD7tnFOjoQHYTQUmw4ZSBBoid0r3L9wTk/Cj72Dco=;
        b=IvAsP9ReqhuB2+qqTPlh9vO4EqHRWUsC7by6pyFx+ItV2F2nXYFi52lHmWZD/5vUI8
         o+o+XtgddCx7ijpCk5zWBOXtttvE1Q3C5aSDNVNQWTtZQ+5NCaoC1w9VU94M0waAJRix
         /IeNOjEEhwJegvMlzYWQ7N04JcnMaqdFCo5oc67qgdoQin4+9LBb42ErrzZ33INI5Yt0
         wQNOlYaAAo593ukdrfv2ePEmqfin2DL/BtbusymW0k69Xw5LT/Vs25tRvEM9gu4jUXM9
         A1+8/prV6JNoV9efCEB+kBcIUB9rEH3YOMSbYB1FakI87eObKlQNUS3GuxccIGVB9WyW
         xe9w==
X-Forwarded-Encrypted: i=1; AJvYcCWCmnmzOzRUU9elGPXaGhi9RlUKQQRvcanDUKl8652lUtl+AzMgMmDjpTe4eMhNNxW6DMpQQmBYqb8FGJ7Cca+247nEy9gcLEzZZPzW
X-Gm-Message-State: AOJu0YxCOg9Z9AXfc0zjYMPHh02VRFX2doplXbnG0vIntCbP7K+b8C2H
	z7GOGMDjYUhxS3dd2ZuP7etBCQKwSll9s90+M8i7629BYmXiX5gCaTUDzp1erc06uNRWBGS4qLp
	QpRwNFnECF4stx2r+a+arVsB2oEI=
X-Google-Smtp-Source: AGHT+IFX9KJSKOvbBJXl46XglISOn2zeMMgpX1VMS6qwoeOZcQVlE1L9Bo8VT6ZTuo8HLlM91s1BWmThQaGCfd5gpTs=
X-Received: by 2002:a05:6358:6f88:b0:17b:4a5f:bd27 with SMTP id
 s8-20020a0563586f8800b0017b4a5fbd27mr8291393rwn.24.1708576504658; Wed, 21 Feb
 2024 20:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221174333.700197-1-tj@kernel.org> <20240221174333.700197-3-tj@kernel.org>
In-Reply-To: <20240221174333.700197-3-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 22 Feb 2024 12:34:52 +0800
Message-ID: <CAJhGHyDJAUt8hSJNf91vosOK5TMRykudUZdiKvYYaU3co3T=6w@mail.gmail.com>
Subject: Re: [PATCH 2/7] workqueue: Implement disable/enable for (delayed)
 work items
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

On Thu, Feb 22, 2024 at 1:43=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

> +/**
> + * enable_work - Enable a work item
> + * @work: work item to enable
> + *
> + * Undo disable_work[_sync]() by decrementing @work's disable count. @wo=
rk can
> + * only be queued if its disable count is 0.
> + *
> + * Must be called from a sleepable context. Returns %true if the disable=
 count
> + * reached 0. Otherwise, %false.
> + */
> +bool enable_work(struct work_struct *work)
> +{
> +       struct work_offq_data offqd;
> +       unsigned long irq_flags;
> +
> +       work_grab_pending(work, 0, &irq_flags);
> +
> +       work_offqd_unpack(&offqd, *work_data_bits(work));
> +       work_offqd_enable(&offqd);
> +       set_work_pool_and_clear_pending(work, offqd.pool_id,
> +                                       work_offqd_pack_flags(&offqd));
> +       local_irq_enable();

It can use local_irq_restore() directly or the next patch needs to be fixed=
.

The next patch making enable_work() able to be called in any context
forgets to change local_irq_enable() to local_irq_restore().

Thanks.
Lai

