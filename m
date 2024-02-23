Return-Path: <linux-kernel+bounces-79176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886CC861E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161CC28533D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21EC25750;
	Fri, 23 Feb 2024 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="McsG/xV1"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CD14938D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722329; cv=none; b=aUofwn+jv0En2nYNVVUlqcWIh1fZibeC5Ep+pulc2ObVk6Fa6GpQIm5HBqk+tMV71YbR6bOkz+LZO2qBtovgEo9OixCoobLfhnWJKuu9sZNNfbxwGrEPef0H355vV54mrDG9V1sTqjz3CYCeorIcgxsVU+d/R/DDD344xhD9VKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722329; c=relaxed/simple;
	bh=R/+O8H4O8BwAv9+xJIMOzoReW2oS/QadBD8zkAnLLDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYMlFiHY53K/H0sKp9w1Mv9dNG4miM8qhzDEenUH8X1htehY1lK7eE6LybPorDttOil9ePxm428EAwP2dxr9T/qfIo6LDaEmbHzs7NJESsd8+yQN7Xo+M+Q3Rg49GnC9TmW+bo2TfWkXFjOA0Vc1EY1ns9hrb6wGcF8V4jPlL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=McsG/xV1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso861691276.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708722327; x=1709327127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytWrr/Z6XKokLdRa6LccyRlNuSfIGCRB1ohMJ1fqRns=;
        b=McsG/xV1Q6wYwr0hBiL8gQeBgfp9QLQCnz1I6NLyCHktW9rh10xkCwRtX0St8yoNQq
         /Ht/LQzBV0OaCYUlMiAIDqIP+1fia1PNf1+v8WxJaqCj0RR2bSWhW8tJ0z7evZpeqOL2
         tNnxB0sIaVaqcsLZlXrF8ucmB/4B9FpP0s8xO2XpmqZISqV/ss+MoRARStuh/cO+3/9h
         pEI+WO3EFFlMvbK0cdj0T63DTQXZJRMbHzox6kRF8a3usSaOoMf7EetFZbkgtM0PNvBL
         ygVSJ2UbkD8CQVbEMf+qHwG4N+bol0bNRqYHIhecnSGum/RSz5wPq9OCd4KTA3IEUr0O
         m5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722327; x=1709327127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytWrr/Z6XKokLdRa6LccyRlNuSfIGCRB1ohMJ1fqRns=;
        b=h+QvGs0/FWm0Ulg2zQqhPtwcWD+GRj2+bz5z95RD2xrNfHge5TDzTMQcTSeSOgcMMY
         QDKq0UBZfl3YcVlQLWLvt3KzxMBZrirsUwt7AZ1ENVFF9gs6/FD3wdMUryOcXS3H64pw
         r7hNKo0cwpwbZ5vSHJgPiPaIQafvENJU1x0gwrvc9ec+mjWVxqniPjjN/iuK0eI7bGMA
         FG3806S/dfW0+sqyjoLXpEoi+66NHtjunHTIPuhGasovOSlvq86EKHYFP6e5Gs/yMBOi
         /Csdm7xr3SlPd2tBWzIBvUOuhZoyDcS69x2jFzciXjy7N6YfhxF/dQVTn3VXzddJltBW
         ej1A==
X-Forwarded-Encrypted: i=1; AJvYcCU4EQnK+hqfowh6CfgqkfgyBbeHNeGIGAfLnizZ8FThB93Wq/zKUlsWF3EhSTZKqFb56rI2/FZsOAi60KT7hJwn92V7qZz+zwiqu+/w
X-Gm-Message-State: AOJu0Yylk/QRs3IcSpiPUtpMFxAVAmE8XTWkJvdCjxUWoulT4V6pWrC/
	taoBu+UN/HgTmWxJUa0okZ5I8MSXQt9YBiJfQILvdGNqM4yPu8VCbYAzTQmqtmowqd/ToD1Q5Pw
	U3XhgkZyO/5zDuc/A/zq/xQ6+cioN04bv+AJJ
X-Google-Smtp-Source: AGHT+IEpVFDrzEuIGmXD+usw6kJRjPirAlh3UAEtBi1UxjtPyCLhEp1Orc6J/F3wzIU5WK49aEGT3jx6+SyrtibdDLc=
X-Received: by 2002:a25:2bc6:0:b0:dc7:6d9a:37f2 with SMTP id
 r189-20020a252bc6000000b00dc76d9a37f2mr1120688ybr.38.1708722327204; Fri, 23
 Feb 2024 13:05:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223.ieSh2aegurig@digikod.net>
 <20240223.eij0Oudai0Ia@digikod.net>
In-Reply-To: <20240223.eij0Oudai0Ia@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2024 16:05:16 -0500
Message-ID: <CAHC9VhRdRK3FztE-Th=3M+0ZjCZQJ+5sTiXPwfK6xXX_=SFHhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:04=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Fri, Feb 23, 2024 at 08:59:34PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Fri, Feb 23, 2024 at 08:05:45PM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > selinux_lsm_getattr() may not initialize the value's pointer in some
> > > case.  As for proc_pid_attr_read(), initialize this pointer to NULL i=
n
> > > selinux_getselfattr() to avoid an UAF in the kfree() call.
> >
> > Not UAF but NULL pointer dereference (both patches)...
>
> Well, that may be the result (as observed with the kfree() call), but
> the cause is obviously an uninitialized pointer.

Adding the SELinux list to the CC line; SELinux folks the original post is =
here:

* https://lore.kernel.org/all/20240223190546.3329966-1-mic@digikod.net

Thanks for finding this and testing the patch, based on our off-list
discussion, do you mind if I add a Suggested-by?  Looking at this a
bit more I think we'll want to make a few changes to
selinux_lsm_getattr() later, but this patch is a good one for stable
as it not only fixes the bug, but it is a trivial one-liner with very
low risk.

I do think we need to tweak the commit description a bit, what do you
think of the following?

  "selinux_getselfattr() doesn't properly initialize the string
   pointer it passes to selinux_lsm_getattr() which can cause a
   problem when an attribute hasn't been explicitly set;
   selinux_lsm_getattr() returns 0/success, but does not set or
   initialize the string label/attribute.  Failure to properly
   initialize the string causes problems later in
   selinux_getselfattr() when the function attempts to kfree()
   the string."

--=20
paul-moore.com

