Return-Path: <linux-kernel+bounces-97954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B562877243
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB761C20AFB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C97945BE2;
	Sat,  9 Mar 2024 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvL882dz"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC96645962;
	Sat,  9 Mar 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710001789; cv=none; b=KwL7z72oXL9b9f7yy2zT9pA4dvkTmpFaWc0WQneuDOR3YqzoEuVsSs4Z7UXSXMG0KjNHqBYhJ7I7pCeINAhswY2Vwg95UCnqawtYfX1eVuJ6NCKIdjijKB/9dHf//POxRtFJYpf9yeuUegaFSLLLcBmSrLgiSAKF74fvaDXOBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710001789; c=relaxed/simple;
	bh=nh6N7RY0Z3aGt3Bcril2of297v7nFeV6+3FAqw7qffc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guuPDinqkdWpSIjET6dA6priCG7BqJwrJN31ykB0+Y0cfl8njTw0sPKdcHwHvxA9iSY/hD7EvFXInloWfITx6MGneAfasg18FpIaR1QjVWpphqJ/ntsXNwFQkNt6H+vqRDjeQCuORAQbV0MmshwO5JLvPw+qwVdK9ObjhnjW81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvL882dz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a293f2280c7so490204566b.1;
        Sat, 09 Mar 2024 08:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710001786; x=1710606586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh6N7RY0Z3aGt3Bcril2of297v7nFeV6+3FAqw7qffc=;
        b=PvL882dzPoI+p7tKvyURoWfVN+msV98SBLsJ2kXSjmFNE12punTy5U9F8JATa/Udni
         56+TdiGNu+O/8/EL+f/tn0AKBs2cPWvD1ngU0NGM0OHCzf1GcZzEs0I3m8/HLOmdRAsT
         r/9m6TdN3hRHOmcXENCOKhNO7UJUTB1A7UWDKcE+9J0QxXpe5OWEqdp4feACbZ/33qdT
         zxJfT03w6G7x1bVF1cK2b7nBQ4YM0AcYxnLYS4AINS3i7x3Q0yLcLBx7khtOSmxt5oz2
         kju7sYoIYHYw0+ncTdwYaRrEARMRt2FX2mSqmliXVywcOCPjHcoDaaU8sMDEQjUtACiS
         AFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710001786; x=1710606586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nh6N7RY0Z3aGt3Bcril2of297v7nFeV6+3FAqw7qffc=;
        b=HOExZ1XnTIOyw/5q11bx0c+Uuy2hzT8ONyfylqahhnttRmIdua0zsb0ncWEBgLMcJ3
         9SKhvz18d8dRsxrkOE3gP/JI368EAA8LgRYByzxQafiEk5DiQ0MHRzrtwpfFA/lciYMg
         QutMvuizN6qkUcv7fJ7jgrGgD0ZuZnQLuF5QkrikCVjfbz2Lkep7ouwFyl6nfE/0OcW7
         hH2egN4wIMgVv510r2DTkwfMzXQypWa1TDhMq0FjW6ipe0d+9JbTax4KrXpn3vdrBpa7
         dZHEnB9LhssRZsAkQSfZygSt3Ycs8E48+9s12fXGU1t299Dgb6hURnK7OqUnHRJrYUkN
         apOA==
X-Forwarded-Encrypted: i=1; AJvYcCWSr4Z291yFSqbvQWYDvcudJ2SwC1eAUcG6U3d41r1Z/gS0699UJ22P43o4HbX952BFM8UhWIIkJIVwRAIeKtU5Sn25YCxmO/IWwP0Y
X-Gm-Message-State: AOJu0YwCvtRF/1cSn4EiT3per6DnmRorB0SD5UgaKr23MIN4Fpgfnv4a
	RNWCbQWAVzy5fG8c2D31alraFCdi9R/pbz8PiwmWjM8SRdQyuMbJP7JTfC5esKHsYEX7vIdMUkF
	sD07Mu2BcJwZ7MAB0yQH3YXGecc8=
X-Google-Smtp-Source: AGHT+IGYYR0knMTnzncdNHGImrNfr3uEeg9LQlEtNWzD1Rst5Y7tYXwoAc0U5ABbmb0WG3ywbkEMFesAHbZ8j1/yYsg=
X-Received: by 2002:a17:906:c7d8:b0:a3f:c779:aa62 with SMTP id
 dc24-20020a170906c7d800b00a3fc779aa62mr1309693ejb.21.1710001785945; Sat, 09
 Mar 2024 08:29:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303121410.240761-1-andy.shevchenko@gmail.com> <384bf6c936fac50042389cc5f53c3199.sboyd@kernel.org>
In-Reply-To: <384bf6c936fac50042389cc5f53c3199.sboyd@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 9 Mar 2024 18:29:09 +0200
Message-ID: <CAHp75VeTS8EEU-j0LUOGONss0i6fNEe0YKcEngAejxY_5jguYg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] clk: fractional-divider: Move mask calculations
 out of lock
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 3:06=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wrot=
e:
> Quoting Andy Shevchenko (2024-03-03 04:14:10)

..

> Applied to clk-next

Thank you!

..

> Should we pre-calculate the mask and shift values too!?

Not that it's required, but we _can_ do that, of course.

--=20
With Best Regards,
Andy Shevchenko

