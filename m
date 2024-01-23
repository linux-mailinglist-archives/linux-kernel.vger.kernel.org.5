Return-Path: <linux-kernel+bounces-35589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4168393BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E057E1C25DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACEC60B8F;
	Tue, 23 Jan 2024 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZeSQHkG"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC060B8B;
	Tue, 23 Jan 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024733; cv=none; b=VDDLG2+UaNvUoCuvwZN0qeovtZcIQagB6EI2Pb2UOxjpm4NiA/jhggpFOAWsalPEyYvCvvUWT+mAr/aKiq20WKQOb9+CrGZjGQjLCt1h9s/Kx1HWqqg7G4feETTVcIk6wj3PH96JhhOOZ7bfRpA2APESlGjZ6J2bnvtGA8pMKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024733; c=relaxed/simple;
	bh=hdBYdUxOFq+kbS0ASigOqpNwC+DLJhVJWkE9MFnLlNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfBDtEsYyPOGrly7wPLeMXP9qOBAHeQoGyj2uHl+FJmHvQl1IMmeoKpFnmNwVA8cvcg7WAeTW6jkUp9oKa5IfwcfZNufD+yjmizinWZfaCMFz+KqC3FsxqkjRzyI6o+QSKQ/Vj7m/utrO7AWv3XO+xwq4pWJN/vy9LnWbVhVIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZeSQHkG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso432919166b.2;
        Tue, 23 Jan 2024 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706024730; x=1706629530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtlKdxisJ1H4nXUQnaiF3tGiczuUPAFtsLVHqqe+6VI=;
        b=CZeSQHkGMHeHcWoEL36DbEv7o+4X+RJNWCIdD8+W1P+K4k+jfUQ1YVoX4T0x2i+1jI
         SEcl88ixaxRdtNvzOSkg3fZ91d2hf0jv2x+hGfB2GWS1j8hiH+SmA8WwHOXyJdHBiVHl
         RcX/LnoWaCSCvKE7uGtvKVkU3aD47GIy3p2tP+T0VIcGHoyNGe26kBJ9Syh6vStbbIEk
         WW7K9tgSgUtbJ7Wx+HrNLTvQbsVk+d0aFSq9KuwTo46llJ4sp+YSxbaATOiLbW7qf6yG
         Gk05kK7UaJrRtT//vaX3TvKpw32CN5FE5Vvv/69QtQkJP/Bho6UhQFd7cqO0HbCClN4H
         c3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024730; x=1706629530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtlKdxisJ1H4nXUQnaiF3tGiczuUPAFtsLVHqqe+6VI=;
        b=oU5DaUKU+rlzlr187XEJspN+VszFNMXpQjaESqYxqgw3O3Z5RYHlkWtJppgDP4i4XT
         Zp59qzvVxXL6LQ5hfFQ8qOFwewq0xpyo1i7YZNyuKJdOmDVgsg+8F2swKrIraI7cK3gX
         aay0s2KwEyVDLOBINmBl9IXTyCSZ5WGjA+9mMLPKJUKe7XBdCUc/lwC8wwxdw1Sk1wI6
         4oku/6cEe3QN6H260UJaiH1uKsC8wKpKjImKPs0C6iLBYynhjo8u+yTeZbe64jgihIsY
         1e60syNhxjFuVUQrrqEqNt+japK2hiIxVaBxXtl//rUOKTAUa2vNhfoAGc26XKX0tzas
         4trQ==
X-Gm-Message-State: AOJu0YyBq+Ov4xx9VJ+Mb8p5i0yxD86TRD7HVIjYm01Kw8Us0fJK1xL8
	py0pmZw+dghZ7bxIDoR5BvBzjhaIe+n9El9yeDk88Whx4zxCHvcuw4tCdSovjsmyBC8/99lOo7V
	7ZjedD0Jd/+IxHCs8wZO1uSuBYXk=
X-Google-Smtp-Source: AGHT+IGeoKDAXQT1QtGkmzsvDd9O3U+IXSXTY2VIJASOG7mhjJxF1tXdrpBbCuSnLMpczZO5eE6k5hkSEaDy2eB9Yno=
X-Received: by 2002:a17:906:da81:b0:a30:f04e:4bdd with SMTP id
 xh1-20020a170906da8100b00a30f04e4bddmr45448ejb.68.1706024729528; Tue, 23 Jan
 2024 07:45:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123133828.141222-1-warthog618@gmail.com>
In-Reply-To: <20240123133828.141222-1-warthog618@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 23 Jan 2024 17:44:52 +0200
Message-ID: <CAHp75Vd1dipGkCgQBENN3rLeUO+eQfOz9uKzz86eK755smqGag@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: describe uAPI behaviour when
 hardware doesn't support requested config
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	andy@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 3:39=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> The existing uAPI documentation does not adequately describe how the kern=
el
> handles the case where the underlying hardware or driver does not support
> the requested configuration.
>
> Add a Configuration Support section describing that behaviour to both the
> v1 and v2 documentation, and better document the errors returned where th=
e
> requested configuration cannot be supported.

..

> +Bias             best effort

So, best effort means that in some cases it won't fail. It reminds me
of the baud rate setting in serial (TermIOS). The question here is how
does user space know that it fell in one of such cases? (In termios
the IOCTL updates the respective fields and then user space can get
settings to see what has actually been applied.)

Floating line is not good in some cases and user space really wants to
know that and treat it as an error (if needed). Hence the above Q. I
believe this needs to be explained in the documentation.

..

> +Bias             best effort

Ditto.

..

Personally I would still do two patches per ABI version, but it's up
to Bart what he wants to see at the end.

--
With Best Regards,
Andy Shevchenko

