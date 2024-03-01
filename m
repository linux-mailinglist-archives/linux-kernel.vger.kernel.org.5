Return-Path: <linux-kernel+bounces-88546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C99686E33A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165AAB21EB2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485566F08A;
	Fri,  1 Mar 2024 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCCoIZdE"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CCA6EEEB;
	Fri,  1 Mar 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302990; cv=none; b=oAHYGuvAkGQ8qm6iADFnKkUwal9J04wiYdAzruhmjVhNiK+oHaavJEuuDIIxE7qGHavg3oLoK9HdBQgbA7lPrtDXiP05fnnBEjLwDIipCrk1l7uKg4AUq+dx/xls3DuBOSsA2QTYRtK+k5TlCZZ6jfFbKuG7O6UZ92d9iTjb7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302990; c=relaxed/simple;
	bh=HZCxlrgGljidyTarDfuqfAysxjyvcHG4UHNCNIebsrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubry8Lry6yNzvu8C41lW8eRY5Ex2e87wMOu5DqMRiVlTzVwHV49zEfMo6z14wvV99NsipZ9iv9bAKqzOpnz4h8rXLlaz1wvW1pdiU+ttyHFrha+NLCROwByxmn2uxrrKokYh85a8Q6uuXcTGRMxETTInklSR5PtV5JNjjtRNsmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCCoIZdE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-566df43a1f8so802142a12.0;
        Fri, 01 Mar 2024 06:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709302987; x=1709907787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bda4kfIFTgemCk1Wz0NaLukSggxZd32xgBKtfHKR0eg=;
        b=SCCoIZdEm17nU0m8jxLXgvG1JJGCSxNX6HDCB4DIKZV3aAxUi2JDNVffWOaKIiOXS5
         y3rCjFuM6zgMfdfCF733GzQIMCjuQCw7EzcjQJy1Fm8MBWKgNKuYbRtt+0S3N8tgLVhv
         KXzXNtzYGDNiYC8DXWI7+VCowu6aMhPL1/gSwTB0o2vKHkJyHNx5yHO1wZ67gMQxUbj4
         g8/3cre2sVGCmctRWDXgFpuWJRg71SmworPSly2vD1ntRRUZBuIVRAr4EKXbzP+2Jo2Z
         7ahy1+gN1pRLn3YhZIVe1TRix46pQdRppyg+qY8QX3W5BhI4FpVISGaNtYvoic2EyWhS
         XLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709302987; x=1709907787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bda4kfIFTgemCk1Wz0NaLukSggxZd32xgBKtfHKR0eg=;
        b=F+U/Iod1H+aQpa4WqtULElvX09SyoowQbIwSNopAwppA7twdmXhsFau+bQQa6mkLsQ
         B7h16ZE51dRt+rO3vFtQSBLJZudXNeOe6JV+MZNCl3OOxHZM58FWcHLYQbiCcFzI/qbm
         pa3bpoNSDw8FxibFEX6UVVOGrUuSjZzfq136+4hxF1DmgsB+fjyb7GvRViJ14WqdkeQn
         bEpdUfUhy8idd6p0l5V/uZIuWhsvms76AO8Q0ECvxSfAhmqXzLzt6A3tFh5VGo5zTPfx
         Uje0OrXcNQ35f8anVFhkuX+mqpIfMjKJv2tdwcOf/6YLf5sfWqGRS22S8r/ecos4mQo4
         uLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8J16+H88V+buNUIamMcKiO64D5n9GMkfaOatjZP+dvlSC2/BshhDCioHj3YvSxKVwhHc7ZEvJstDRgWaeBzm7yeeiyanOYftquM5xeKxSH2nECEQJ/lT5CtuqroFrmcuV9YrCb5uw
X-Gm-Message-State: AOJu0YyhjOerBUTzNW4qwGy6wlm7DIkzcm0o/5292bW2GQPKfk5UA0O1
	Cxrae2FuVD/25W8IG7VPXlxZ95/QzRQdp6WflDQBpV2W9/KNNCvM3jGTkFjR2fVX5VCVXPz4qhU
	jAaSq6JYg7uyy3ih7uC1S4QQxDbU=
X-Google-Smtp-Source: AGHT+IEwdB8lfu9PxIvgbBfvGBG0oALBdsAnOzy3HWx7e/FKDGO9udHXaNGUJcmenJrpKZRPZ/63J90jNo3z/ay2LuY=
X-Received: by 2002:a17:906:bc48:b0:a44:958:c3a4 with SMTP id
 s8-20020a170906bc4800b00a440958c3a4mr1345109ejv.32.1709302987239; Fri, 01 Mar
 2024 06:23:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131410.35269-1-lukas.bulwahn@gmail.com> <e6441dc1-6821-4514-b285-ebc24114aece@oracle.com>
In-Reply-To: <e6441dc1-6821-4514-b285-ebc24114aece@oracle.com>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Fri, 1 Mar 2024 15:22:56 +0100
Message-ID: <CAKXUXMwGekn7++3TmKhe20s0bebM=hjSU82PhuWV9=0Cc9wfkw@mail.gmail.com>
Subject: Re: [PATCH] docs: drop the version constraints for sphinx and dependencies
To: Vegard Nossum <vegard.nossum@oracle.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:39=E2=80=AFPM Vegard Nossum <vegard.nossum@oracle=
com> wrote:
>
>
> On 27/02/2024 14:14, Lukas Bulwahn wrote:
> > As discussed (see Links), there is some inertia to move to the recent
> > Sphinx versions for the doc build environment.
>
> [...]
>
> > diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphi=
nx/requirements.txt
> > index 5d47ed443949..1f3b98eee2c9 100644
> > --- a/Documentation/sphinx/requirements.txt
> > +++ b/Documentation/sphinx/requirements.txt
> > @@ -1,6 +1,4 @@
> > -# jinja2>=3D3.1 is not compatible with Sphinx<4.0
> > -jinja2<3.1
> > -# alabaster>=3D0.7.14 is not compatible with Sphinx<=3D3.3
> > -alabaster<0.7.14
> > -Sphinx=3D=3D2.4.4
> > +jinja2
> > +alabaster
> > +Sphinx
> >   pyyaml
>
> I know you wrote this as well, but just for the record I tried dropping
> jinja2 from this list and it still pulled it in automatically:

Vegard, I took your suggestion and removed jinja2 from the
requirements.txt in my patch v2:

https://lore.kernel.org/linux-doc/20240301141800.30218-1-lukas.bulwahn@gmai=
l.com/

So, there is no need for any further future one-line deletion patch.

Jonathan, please pick the patch v2.

Lukas

