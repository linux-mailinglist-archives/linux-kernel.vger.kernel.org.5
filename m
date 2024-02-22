Return-Path: <linux-kernel+bounces-75698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E7185ED86
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B9BB25E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003C8C0B;
	Thu, 22 Feb 2024 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwr8FRRO"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE72919
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560267; cv=none; b=VgdFQ4GENCQYLKNNphBD4J6yCsHo+SlZ1Bj6Gizlq5QR0jRtS2rsyuqyD6z8Rda/1staNDDHAPmZpzVrskiX66lQ5NUBhdKj+sQFt60zkHtubh5bEx6UFy1lHfhXpji38D7N+zzuK/CX3ITrhUvFDZypwAg7aT3n7XVY7My8xFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560267; c=relaxed/simple;
	bh=lT1thb2VEXL2bWUBArUywP/XYHhdK1ewl190KRXCA08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTMEYKQ5MSi4cjOfxWUqrMRBNs1aMO5Qp53a0cqHOqJLUFbZpYuTt52qefBbDveTPjTq4J2cs6KdtQtuD4kAY3988FaksodrHL0Abmi275dZOhkV21fW8Kr/epht2vlk+dnHMULiNmwllwe6QfCyxVCG399+SPvXd/IMdeqsSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bwr8FRRO; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607eefeea90so3318307b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708560265; x=1709165065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT1thb2VEXL2bWUBArUywP/XYHhdK1ewl190KRXCA08=;
        b=bwr8FRRONtSw9n+YxN3OtX+iz3wM9Xxk6BMciDYGgv2EO2kXiqT6zCKZunD73hJvH5
         XyNr37kwaVOlxvW0fFpq/HhUErWRDUoxAk5nF7vt366i1qF36kOcgfvjj2KOh8iLPnou
         pAqLQfzfVTNknVIO8a2PRrC19nvFJ/y0zASTuAclGminNYYfSp8TNu56t+Jk7QakwT6g
         f0xznJYosLMS2wPLyZCU+U/DzRSUO3MHN/CQbYeOrTE3sHHpuh9krr97tnYEgYKREPTy
         RRY9Gt82jmDR5eHLQdQRBvdfOYhqYED2X3L4zJTPGGKFymNpcyCjpUy2YX6QS7DhgKeB
         TrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560265; x=1709165065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT1thb2VEXL2bWUBArUywP/XYHhdK1ewl190KRXCA08=;
        b=l64BCaEKEynkVnnaNZ29NHhuOfTa6xb8r7W0cWp++0xouJ6Ly0ajX11HQYkLKVULvH
         ewupnS04wfz/dzIzgVlChECx/qGDPpR6tNo/bmDKgCqL4M+fcr1h9UXeh5C4eQZudQtg
         TUkWgqL9c3weHcm0rDL2YRzJ3dylURPM81PHGi3xGjZw2ezSJuPUZl+iRkmDUNTqle0x
         5yfDLeA5Sd72mFxli6zwfQw9XkZ+79BARBMEzm/g9GXWoQwnokkoKNFph6QMWdtb0oXq
         ag8LXD3r0m8lGU8bj+iCZyU/I6QyhNYO5d7wtwcZ5jRjsltunGMbPuWjgiExn8CQrbat
         bVMg==
X-Gm-Message-State: AOJu0YxQtuL2BZe443bRaNeEFR/M/8o8xTpNGxVURQ4j8xr4MEbr/Omj
	qrnhDNeKOkDAt7OSuJAmP6HSl/cbZSIVeJsGyWY+o0wXlAsVlE0rzR/AutwcGmqcYmVVFLcmTVj
	G8QtQTj9TjHO3SIjrRkxJfw7mYBrnuzvmz9llRgO023nCpQTx
X-Google-Smtp-Source: AGHT+IG4AZWIqfRYBzUoTqXosaKSEiAemgDz9Q5erFqe6YRZIMSkJ5xuW2wcvxkYhivEUZOALJs1NdrFvv8l2PCzhoU=
X-Received: by 2002:a0d:e88b:0:b0:608:77cc:3e82 with SMTP id
 r133-20020a0de88b000000b0060877cc3e82mr643102ywe.6.1708560264757; Wed, 21 Feb
 2024 16:04:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221064104.7863-1-rdunlap@infradead.org>
In-Reply-To: <20240221064104.7863-1-rdunlap@infradead.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2024 01:04:13 +0100
Message-ID: <CACRpkdb6x4pPuSr1UEpjaXQ4hBk7bzRfJtSWQtftfpD_N8-2NQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip: vic: fix a kernel-doc warning
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 7:41=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:

> Drop one extraneous struct member to quieten a warning:
>
> drivers/irqchip/irq-vic.c:73: warning: Excess struct member 'parent_irq' =
description in 'vic_device'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

