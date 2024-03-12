Return-Path: <linux-kernel+bounces-100288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EAC879515
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A8E284266
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0667A155;
	Tue, 12 Mar 2024 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P/rzX1/+"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0DF5820A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249929; cv=none; b=QkWw4DKNzywhdhUaYpxHo8pdiaYD93WJD9n8VIhZ7rRk9Y6QhbpuI3xNqv8tm5P9y+NBW9OOKwvcUzHAhoqmXHb9ZFf66WpTMZ9zDPA5o3DmIaBqy161T2+/4SODRTz3hLQM5XlkdRZEiP4Al9RnF5NW9twYLKDYiRA1dGpWF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249929; c=relaxed/simple;
	bh=psGUUbaGpO0STvfivLy6nh3+05iM/5LFBTb9Tiu2sx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtI8Zkhv50xmpLLCXWqg+vBqs1esc4nruojxbver01fIDHrxFJh5VSKQ4jb71IeNtbVT7E/C94qbVNedpTrDUmjCu8UndgaEW3ga8SLqCEbWHypEqjbseAqcSR4X9ucrLMyU5Cm5GCvwOH4/RVvRVshdHLeeNJ9qbiOzzFNYrFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P/rzX1/+; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbed0710c74so3408362276.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710249925; x=1710854725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB/fCkc+DY4m42yOK4XJQgiO/OTJKfXykryTXv2ZIvc=;
        b=P/rzX1/+8Gsya7WVuz83YmqAKIk/yVcSz+63lCQGDNLXEtCbjZfmJqNyyRAeaCHOXf
         SyFFdqzMnnmVJpWt2JJOgACTKbW2jacz9YWj6isXiPaOP8opHzJwqxFx9f2+Tq8TSH+6
         TDUlQRefPZhsKvm5EgYDoNK/TsibUrHaChnFDQZkVAXNOI4bBkr3z4Mlp/uMBHSgF8Kg
         OBPfpJfXZ5W8jq/cNWT6lnyhZ9BEXFArfSrXw9/3vVRec2VKAHOP/HWtLNfgrltHXtSq
         fbDyUNeW44TOiwofbMGjbsVxYRjHXhhwpT9PSoYAIh3t2J3Vlk16Jx42AIdlGDfM4ouJ
         5xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710249925; x=1710854725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB/fCkc+DY4m42yOK4XJQgiO/OTJKfXykryTXv2ZIvc=;
        b=fGzHcEaOxOvcRlK0rkrqqkNSD3Mv4dlozXmg14EvvpRYLI25oJdm/r+oSrdR2DmvPH
         Auc6QUFbSYAZoSb0NwzcCi46ZeEJXUsdHNjpnJlZD3xIFjptOvcHaLSGgnN+u+w0RcCp
         LtO+9sNxIcFw5gqNrXH2OCTC7FuISIHJLI11AdRSObLIcQtdsc+XKAan1IUDNSSfU9ZT
         lOyzCZWluhRgv3/mLDf1685x/KHHbjjPQlyP6p26wN+Zuse7BdbAWgA8QXHyzSVJ8Vxi
         VG/gdqQJK+vBeBDeFBrJVh0NhIsXNaXmER9A4PlURKdVYmmZPvVTNTJtRpwnx9mW33Kv
         MQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuBlA9uVCvHQ82fp3Ty+su0iNGJV9DXi/OnP8BoztRB2+VBLLiEFaWev9uvtaIG1U6dh6yF+Vtni5hlymt3Kb94mLeX87O9zbiAUJu
X-Gm-Message-State: AOJu0YwxOfLjQixri4IcrQlSCXRLS0qcdiEvpxn9ydz3SDv/sCwlOMIv
	WAfCa5yBon95a72nUBtv22oNCYV6GWncsq/goUSMCL+7ucS5SBtYdOB2hWpIkAQWWL9Gr83TjTK
	S28g6XKV5h5F2IjE7/vp4G5K+1gxrZPhCXsCL
X-Google-Smtp-Source: AGHT+IF1cRnaQFumfUlCRp41/6fgcEMzhcjpf5y7umsfzmg6pOq1H7nSsHfaaBxXD1PgiupfKYVSHQ8j8xk0GqbcK7k=
X-Received: by 2002:a25:8f8c:0:b0:dc2:41de:b744 with SMTP id
 u12-20020a258f8c000000b00dc241deb744mr6886137ybl.32.1710249925381; Tue, 12
 Mar 2024 06:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912205658.3432-1-casey@schaufler-ca.com> <20230912205658.3432-6-casey@schaufler-ca.com>
 <20240312101630.GA903@altlinux.org>
In-Reply-To: <20240312101630.GA903@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Mar 2024 09:25:14 -0400
Message-ID: <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 6:16=E2=80=AFAM Dmitry V. Levin <ldv@strace.io> wro=
te:
> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
> [...]
> > --- a/security/lsm_syscalls.c
> > +++ b/security/lsm_syscalls.c
> > @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, att=
r, struct lsm_ctx __user *,
> >  {
> >       return security_getselfattr(attr, ctx, size, flags);
> >  }
> > +
> > +/**
> > + * sys_lsm_list_modules - Return a list of the active security modules
> > + * @ids: the LSM module ids
> > + * @size: pointer to size of @ids, updated on return
> > + * @flags: reserved for future use, must be zero
> > + *
> > + * Returns a list of the active LSM ids. On success this function
> > + * returns the number of @ids array elements. This value may be zero
> > + * if there are no LSMs active. If @size is insufficient to contain
> > + * the return data -E2BIG is returned and @size is set to the minimum
> > + * required size. In all other cases a negative value indicating the
> > + * error is returned.
> > + */
> > +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, =
size,
> > +             u32, flags)
>
> I'm sorry but the size of userspace size_t is different from the kernel o=
ne
> on 32-bit compat architectures.

D'oh, yes, thanks for pointing that out.  It would have been nice to
have caught that before v6.8 was released, but I guess it's better
than later.

> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modules, ...=
)
> now.  Other two added lsm syscalls also have this issue.

Considering that Linux v6.8, and by extension these syscalls, are only
a few days old, I think I'd rather see us just modify the syscalls and
avoid the compat baggage.  I'm going to be shocked if anyone has
shifted to using the new syscalls yet, and even if they have (!!),
moving from a "size_t" type to a "u64" should be mostly transparent
for the majority of native 64-bit systems.  Those running the absolute
latest kernels on 32-bit systems with custom or bleeding edge
userspace *may* see a slight hiccup, but I think that user count is in
the single digits, if not zero.

Let's fix this quickly with /size_t/u64/ in v6.8.1 and avoid the
compat shim if we can.

Casey, do you have time to put together a patch for this (you should
fix the call chains below the syscalls too)?  If not, please let me
know and I'll get a patch out ASAP.

Thanks all.

--=20
paul-moore.com

