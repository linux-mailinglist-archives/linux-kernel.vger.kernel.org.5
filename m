Return-Path: <linux-kernel+bounces-148100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C68A7DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6820283DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B597CF1D;
	Wed, 17 Apr 2024 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM2l7cCz"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3427175E;
	Wed, 17 Apr 2024 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341137; cv=none; b=Ta4c3k0qH0qVtPrhOFe6co8CUaLL3xkwl4Orns764ihHB6emiMJcJ47c0jUmWs1ETDWQRfk735V2e9t/HDoBmmWBnrvVikI/3OASTihKCMTyNKpzyYBXNPCiyMVlzGo9HNsjzJenwV7vcUEVbDzmFyGrGBrh4A2dW/IeD6Vdsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341137; c=relaxed/simple;
	bh=lQQlXJQazE1BpJa7cuH8qp/auLHjUtYGP4Ml3ycwZ78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3Kaayy5nS4tKBnhhmXTQ8FV45He2Hq1cqZrrQTqcbjy0iHsCMaCksOAi6Xk9gIxJ/Ru536DDYLzTRNYVNgqcqtUZ06jCd/nQNiiGfiljOVuF2NRgB1FZYHUJo9y7eTyvWHJWpOKNgPa31zAAH6s6RbjrJKGR5XXHUO+FvEKyPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM2l7cCz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a52582ecde4so396261066b.0;
        Wed, 17 Apr 2024 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713341129; x=1713945929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQQlXJQazE1BpJa7cuH8qp/auLHjUtYGP4Ml3ycwZ78=;
        b=mM2l7cCzhfdFLWfwQiqd4nsj8qAlAWC76lgY7uyqcwZfCRRuhY28LXjoDXq1EtX0+M
         ei15FlMncvOFof63H7YARwTt0n0M0hKCeeoVX1vmE1z3hQv2oQPssvUQ+/Rdrwt4J6ym
         uvBVLr+qL91imy/l7S3yrEiT2CAm+KlIl7UfEDnZiVJP/4Qg9OsZ/Hg1FBnk/242wSo+
         u+pscqP5gqFAh1rBqn36C34fmNLkIQOwTWK+in5sn5x8oE/wgTf4MWiKaYQ4nt2gzqHO
         UvV/MjWT9syUthyxwCNFzgFZ8XuEh4qDRZb52ZImLE8ag31gd0zpNCK1i0Y4JTwllXdt
         jc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713341129; x=1713945929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQQlXJQazE1BpJa7cuH8qp/auLHjUtYGP4Ml3ycwZ78=;
        b=JPBhcob05zrqRbmLioJkVNq/3bvCeh5FxyI1rTk3SWL6n5svR4EAG+cghlkSiyC5dy
         gDi3FTtKtg21AYGQDwC4BRJNwiV+C7HMi3EE379QTofIyATDXIQF0CWXme50A79MZz7N
         jXDB4jDAHtMBWKTz3Tdg0vOKdqcDw6hB8JCGiFe6qeRc2MNXDOWIjVmQQi0xSmIeLarX
         RQRpHwQRVHGGS+tf705JtFeuctWs/yqLfjklrngVHU/qfCDDtAnXyldZvSx3+n2W2ACF
         xb4jAmA3h8l8J5Z7wgWl1/kNXrnlfUPyhNeEfqqqqnIcikXHocrbsEaWg3Rl4c+IPqaj
         do4g==
X-Forwarded-Encrypted: i=1; AJvYcCX88HUyseiJ65gAMkLdaSKGFljZgioVB2Uo3lcPAJJmt+RuucpL9/ThhWpNW5HqU9+KOlPG94ThNpiwfZk1+HLKrmhyii6ca4K81FG6jDAklIx05zGOjgTSxHAj6UsEbt1ViuMa8jJFDw==
X-Gm-Message-State: AOJu0Yz4pATjAEIJc17ukxMe6+Q6pjy45ntD1rrllKHK11S0Orcj3N1Z
	aMQ1gkha73gHiwgoqmUlFV/dHcuZ9/SUnfI1v+VK4WmJxh4EWGFQk3yjrvll0bFRqkr8XcDQBxf
	RGjt9R1rzdpL8ocii3FSE/NcAT2Q=
X-Google-Smtp-Source: AGHT+IHIl6XXnV6jonEwRoBIMHjCADhwAaYmaVFRLbMWFV8Gsf2seyaQPK1HAduYiy2A4nr/ZINetgBwQDbFuEejJug=
X-Received: by 2002:a17:906:81d7:b0:a52:6899:37db with SMTP id
 e23-20020a17090681d700b00a52689937dbmr5536538ejx.50.1713341129142; Wed, 17
 Apr 2024 01:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410072102.1200869-1-andy.shevchenko@gmail.com>
 <ZhpC3lLD-BHqJEZz@ishi> <CAMRc=MerqbYue_uubSkr0ta3wr+yQxfFMfk+vAUZa+C2oR+udQ@mail.gmail.com>
In-Reply-To: <CAMRc=MerqbYue_uubSkr0ta3wr+yQxfFMfk+vAUZa+C2oR+udQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 17 Apr 2024 11:04:52 +0300
Message-ID: <CAHp75VcofgAQLFVLdsA-A1AkjVzQBJWtam=w00+z9-rueZyv8A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: sch: Switch to memory mapped IO accessors
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: William Breathitt Gray <wbg@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 12:17=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> On Sat, Apr 13, 2024 at 10:31=E2=80=AFAM William Breathitt Gray <wbg@kern=
el.org> wrote:

..

> I applied it as is, if anyone wants it, this can be sent on top of it.

Thanks, but I assumed this should go via my tree and as PR to you. At
least I have it already in my for-next.

--=20
With Best Regards,
Andy Shevchenko

