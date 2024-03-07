Return-Path: <linux-kernel+bounces-96299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D5F8759E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21AAAB2438A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A221913E7CA;
	Thu,  7 Mar 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9tlcmeV"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54975131E3C;
	Thu,  7 Mar 2024 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848990; cv=none; b=CqhJI0a/78wuUqJ3uSM+qvGKm11/+aeFT5+ZX1BIAgST7Xlw5wuTKWA5ZdpxG1NshOWBMIcjGYjO2oFWmAfCu6vt9AllRVnKIpYP5sXGvWJ6s37WVZZ8SQ9uw9DyNC5NmKWLD0SmBAk6sk8Pdvkq4D6IS/J57uR9ZtXq7nJ7w6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848990; c=relaxed/simple;
	bh=vBkZtaqVntdNGyZ81IE7wiSv/8xQ924S6Z6De0WhMzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGcQn/rDXYGr9K/YLl5l+xoDyZAKEzXrInyZRXjuyjBO4D9G9nC6bCYwiA7Dz9mbfEaAxJQ4GuP/CFYY5gWIwvIG6EIXv/rlwn5ZXnK/Ew5LJy6rg5aQ5Uekrda9grdCwbC+FWsPR2z9sYjNbJHPXKgfrXqEWZyCoX80lLkcNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9tlcmeV; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56657bcd555so1702540a12.3;
        Thu, 07 Mar 2024 14:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709848986; x=1710453786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb1Oxz6Ph60z8Lq65XXMzOlY/y+ojFU9w6HKYFgNSHw=;
        b=Y9tlcmeVJXwkU6Dw5x//Wlm+emHGUH8YcTX5BxTzPcLceGhtlfJKRb0yjEVE0WjdS/
         SKI6e3y2fXl6uNXH8CthgPc9Dj4PuEGWGaTaKqhogo034pfPAw2W/7jHOsn1trFckDr0
         3j/Akw11pvzl0rCXpPxywrZaPlJchDSkIXlgs2CfRgvK6o/NEjrQiXaUOkzHA1oAvW4a
         5MFDloDi/txg6p0pPcgeGE4FGy5SvzIeOUN3zlR+HCRlktdGsRLc+Bnkmobd6ufvzVzM
         j4zNBEHP7yJ1QKbs9xKCugII65cYPxU/ydgjX7Jnzle2WWUrtszborrHHWgkwgPwlC4Y
         M1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709848986; x=1710453786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mb1Oxz6Ph60z8Lq65XXMzOlY/y+ojFU9w6HKYFgNSHw=;
        b=sIOxXH+FEa//K06kXEy9r1nVvqVQfR/xWikpte1nW9GUcdhCyyxke/+UbwCMoQNHRL
         c246nj0laCrrSyGdvpZFBuUS6bGvmYsyN2XbsO5hYlXxlsa25rTtLRKtfeaxLAQNkAcJ
         1jbArnqWVW9+Et/rk+gsiac/DFozGcMIeFPIjadjh4HohQHflO67AR57P4SbuaIjWwrq
         t1iVvStom+GfYFqAtopgvxhBv19k8+mkLrPrHhrNOJ48qs2kUu2Cb3i4WjJH41TOvL0f
         59xEYXi4ilU+qI5c9BDAujUDXNp9QgL/N1I7T8CgO05SuASmapEIIOBlHy0Stu5qzAOW
         exLA==
X-Forwarded-Encrypted: i=1; AJvYcCXeX5x3n4Nv4opx+vxRIgLsij/1mY8FwV0n8WgVgJzTzw/Ck3iK19AJt4WhOnyUK3FUpeEH9BdONpeMBA3QqoIr/fVdwbCwRYFjuPLNsaWGmjv6vF6k1jzN0/pIEDPvIyAv4cityMA0X7FhepA=
X-Gm-Message-State: AOJu0Yz20drrB6EqILoqD7SxlrtzPvN3snyvSSXJqV5Jq6vasLjQSsHx
	mkyaxqrTBYDEhRkzzJcuA7ds3nnissq282IcHBmMbBD9+6Om7hgUL/mZvhNDABIxyHWlnTYtOOu
	8RKENUgeKwsuRBq24stvFxygy/X0=
X-Google-Smtp-Source: AGHT+IGJNYYE20GnvozheQwK8KZ+q2tdMkPA12HFRQDyrCmKYZtDeExZ3OQzqyqrIA1nl6E5hhbRgNbAW4zYALe9uA4=
X-Received: by 2002:a17:906:1193:b0:a3e:58df:fb08 with SMTP id
 n19-20020a170906119300b00a3e58dffb08mr11772124eja.44.1709848986330; Thu, 07
 Mar 2024 14:03:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307192405.34aa9841@barney> <20240307211928.170877-1-rand.sec96@gmail.com>
 <20240307223849.13d5b58b@barney>
In-Reply-To: <20240307223849.13d5b58b@barney>
From: James Dutton <james.dutton@gmail.com>
Date: Thu, 7 Mar 2024 22:02:29 +0000
Message-ID: <CAAMvbhGmu5VtkA=KnxoHr=Fg_4=1yHFP_SERwKD_rxH=jpM1BA@mail.gmail.com>
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in ssb_device_uevent
To: =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc: Rand Deeb <rand.sec96@gmail.com>, deeb.rand@confident.ru, jonas.gorski@gmail.com, 
	khoroshilov@ispras.ru, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org, 
	voskresenski.stanislav@confident.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Mar 2024 at 21:39, Michael B=C3=BCsch <m@bues.ch> wrote:
>
> On Fri,  8 Mar 2024 00:19:28 +0300
> Rand Deeb <rand.sec96@gmail.com> wrote:
>
> > Defensive programming is typically applied when there's a potential ris=
k,
>
> A NULL pointer dereference is Undefined Behavior.
> It can't get much worse in C.
>
> > If we adopt this
> > approach as a form of defensive programming, we'd find ourselves adding
> > similar conditions to numerous functions and parameters.
>
> Not at all.
> Your suggestion was about REMOVING a null pointer check.
> Not about adding one.
> I NAK-ed the REMOVAL of a null pointer check. Not the addition.
>

Hi,

This is an interesting discussion. Just to add my 2 cents.
If one does a NULL check after it has been previously dereferenced,
the compiler will totally remove the NULL check anyway, so although
the NULL check was in the source code, it will be absent from the
compiled code.
Re-arranging the NULL check to be before the dereference is fixing
that, but not necessarily in the way you expect.

