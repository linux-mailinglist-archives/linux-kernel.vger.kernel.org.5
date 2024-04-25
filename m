Return-Path: <linux-kernel+bounces-158574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA24D8B2250
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661CC28986F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7273149C62;
	Thu, 25 Apr 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlOR+q3t"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB9139D16
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050797; cv=none; b=HYVZw2QmD/rrkZtTXNCUpqnLseRlOesXyEnmmK9A4oDM+gVM38WzYkL2RHtnhJMeu/iHpFI6Msaai0ECN8OS1fRrxqTzfwaaOBHwnO5Ashq5fC1RVnGYEmdl8ZQMBcl9csCHO+U3woqF5iFCENlMvmu9jnoyyGScsO+31tFUR98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050797; c=relaxed/simple;
	bh=GNs6qYM5mTElncFO5+Sr185Y9820eQfN0unazhgf+vc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dhe+k58s+kHq8N5yg7+xkRfuIqjbnPmj8XkXC/hfktTaP50/taPFjyN77j2yADn3R5OLLnojWfGVeodvqLAPeCQIwPZ4+GENB2tbVkkDizYBM2CnnsrjmYVvi3ENq5XLNF12Y1LQPZKaFkhaDES+IFr92mJ50DaIt8AWQ+zxWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlOR+q3t; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54ab795e9so1727969276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714050794; x=1714655594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSWln8WS7SiLewV79qk8C/saIRvkQaEo3lKVe0pRsAc=;
        b=vlOR+q3tV+X/mQp4ez5fSjRFao5EH+qvSbEP3foOH8MpYZa9et67ByZ7jyzrnCXeQK
         EPiWCGb4z+nrNKW1y9y/+fgrnX0WJu5zHr+kucY4rv/8QBIrb4wx61VuiJQHws74aALh
         E1MJDbSG/Wn25ayKZFboaAtnmhFeTx6T3I5T1DUhPzNX+nNqJqZ+sIbhmlErqtZWs4jy
         bpZGGxsq6r795n5RFg/WGwdmGY2wUZTHm/HTJSg/1LRQ4dKKwwx3LNxjFyEhP3Y0b1wf
         3m3AwDBa4HhONaIhfOOgYSk9mLnBQigElWLa/9km7XZGJoBpXxXnykeN1UkbMaTWgKGw
         ehmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714050794; x=1714655594;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qSWln8WS7SiLewV79qk8C/saIRvkQaEo3lKVe0pRsAc=;
        b=Hf/7hmTVWifq1/a3+UypUkq1mYuixF/TYMv6eF2BwXdm2xgMQ5F83aV8YHY6VyL4DD
         PCiKxc69rn2Oi0PHAbkULg4iBv7iLyCS802vUXXGptAGV+/vCTnGHnEoGcoBj0mkfvoV
         2HITQDpoyjs63uFAHpJUnFeLFzyNZ43RqeaUNnI3dgR4E7LcHBMhwW45RbMVGqlvAvPM
         LOLslmNWwvSkaMQXO3cWVAKBpTeN097lHMDovkKJsPb1CubClujnXfPxLWIb6ZYOrqb2
         bjojWTtkjg26AGNfjx3pT9rzznL9As3LGxaCCJ+Pj7OIr9oRchkSiPTVEzKakcJyivDL
         kvcg==
X-Forwarded-Encrypted: i=1; AJvYcCUUdGMwZD8bIxbAYb93mD61dLUxRG/4o8PcbizM5J+buiXTo9Ku0cAj9Akxho/bba17OHkz8QBAOdFHxNmLdpu5sTILnaWff8Y67tJG
X-Gm-Message-State: AOJu0YzJNtiR4T4o5RWuW2dYBmaxVvBMFXcYr1eMMrf9jNGLZax1TXr2
	s0YI0+GBDZtjjGnLoE6wM91HnAMI9XnI+RJMqA3Ca9xAR55+vSBX2efHtXAlabB9c7Z5XKIJuUs
	ciA==
X-Google-Smtp-Source: AGHT+IHYYoDVv4F3JZuWB2e6O/vWjmLf9riM5RNBNz4rluKvVTEeMGN4KRq6BE787d7A0wosuPy/HYTmhnY=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:c01:b0:de5:2b18:3b56 with SMTP id
 fs1-20020a0569020c0100b00de52b183b56mr394990ybb.1.1714050794583; Thu, 25 Apr
 2024 06:13:14 -0700 (PDT)
Date: Thu, 25 Apr 2024 15:13:12 +0200
In-Reply-To: <20240425092126.975830-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425092126.975830-1-mic@digikod.net>
Message-ID: <ZipW1BR6OyO7ZOS3@google.com>
Subject: Re: [PATCH] MAINTAINER: Add =?utf-8?B?R8O8?= =?utf-8?Q?nther?= Noack
 as Landlock reviewer
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 11:21:21AM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> G=C3=BCnther is a major contributor to Landlock, both on the kernel and u=
ser
> space sides, and he is already reviewing Landlock changes.  Thanks!
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c95dabf4ecc9..6a84cccbb6d1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12216,6 +12216,7 @@ F:	net/l3mdev
> =20
>  LANDLOCK SECURITY MODULE
>  M:	Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> +R:	G=C3=BCnther Noack <gnoack@google.com>
>  L:	linux-security-module@vger.kernel.org
>  S:	Supported
>  W:	https://landlock.io
> --=20
> 2.44.0
>=20

Thank you!

Acked-by: G=C3=BCnther Noack <gnoack@google.com>

