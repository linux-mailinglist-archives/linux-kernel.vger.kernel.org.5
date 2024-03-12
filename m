Return-Path: <linux-kernel+bounces-100577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F7A879A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D82C1F24373
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A45313B29D;
	Tue, 12 Mar 2024 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eisIbU3m"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4AC13B292
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263205; cv=none; b=gOjjOBdXspi/SEvG78fhYCPoV+lROeGqTPS+AmgQpkwWt8H1ROyL4fX02GTpOiOsHnABHHx4uinflbQOUg/1xw+r/pg0qP8jPD+vfMJVj/DHrakOyU98mQ6Nl4HX3b84CWNj+uXWCrya7hQL0zRDJnzjvU2g2UWaBCjtkJSsw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263205; c=relaxed/simple;
	bh=ODBwrrI/trcFkdEjJ9gJJB5JMu44UNEg7dQLx1OB5rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DopaOPZqfU7EAvzXloLVpojmqh5wRuEwxpzhRotEuWXgEnDf7VxAB3aKUhZ6hPGe41IS3APlrcDVanRhIythTtYH1MRcN8CKVXcOSheYGNoGjlsf873h7YmXMh0bCNDdnVMvq/9Iow6Qkdsc4tfB0SmWHDSxErXw4FkGDJ5gTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eisIbU3m; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso5718033276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710263202; x=1710868002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rm7l+RMSZUqlJJ7DTu0GuXUMEcKHLbKcsHpJaXGfU7Q=;
        b=eisIbU3mBKRJicxPXBF3Q+rP7hzmR6PNkBd7REayXUtW/xwkGdc0bvLVxCVXpqLLz0
         RRGm2vsiLEEPhJc4gSiyPUhywCpeBiHSqsqzbUJ72TOOLUqiYQfaAamB8tfdOn8eGzSW
         yl6zSZERuVtTCr5LO21L1bOTZouaGroQZqYZdoU34CB9aRQDeUc+iCJGPmZOP7bOWPbl
         g9k0eN2hwJw4uaEilYrbUBYu/Ox84dIqVDerBsdueM9Aw58jdW40LbB02hAyCM9k9BpQ
         TUU0L9a9wbcDjlhCqjNTDup2jn1Z+kjsYjEA7Hk+++jRxlPv2Uw8SLKw4eKT/MYDTxwo
         iuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263202; x=1710868002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rm7l+RMSZUqlJJ7DTu0GuXUMEcKHLbKcsHpJaXGfU7Q=;
        b=SmWfhNO+9+Ta+6KuR0k7LjMkhlXBFLIPQCiVOr6kq+QmzT1Dw9QoEYL1KZljvVUtuq
         g2kF+fRdQCwtLUxT3kQN7JvduyMigqHdBReRTquuz1oZUkASDP/L/mi4AFhTnmfMslWR
         iF/y2ThyJZHxuCBb0CF0gDFXClMLzrajpdlDVYyow0Tp5srvv4szNzgxpRSPEXJ0qBNN
         e+7OWrQQmZgcOKTkC8N9yyYojnBWqBeBdKTZJvnEmPp3CgJOjrNgZTE/6F6ZI9ZQCax5
         PJhGDDJgLDOF0aFWiU8YkwcDr8L2uIoenaIOy9dFL6MaK8KEXDOcQHms4koSkGaP7XPp
         AnMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWav9JSXjVOH1YEcT6JUyHQ22uSyPhh7ai0yiy5TEzjFoI4rrQ2Ud45up1Csta4NxXDD80MthBr+bSvKTQ9obL4mQgniCDdDl9bQYVh
X-Gm-Message-State: AOJu0YzjQy7i7A7cYizHwyMqyTtmzWF0jGEFplmNiJewJmpz65pEiu9E
	qcno1gI4ztg3w0v8fFdkDrLN7Lhboiw//wc78aSgT7dMMK541xaQ0jHP0azu2ZKzG2kGNb/YS32
	dzaNWASYs5SHF1iKTb1dZRsdRuT6h7UKlmjsO
X-Google-Smtp-Source: AGHT+IGE+VfMAqbVYN41jVn1YyoH5kAy0AKB+zcQZl0WABPOYxYN+EL+RCMyJWkqXwdFHtxZGLeP8pt7ClkhUNY5aic=
X-Received: by 2002:a25:b227:0:b0:dc7:45d3:ffd0 with SMTP id
 i39-20020a25b227000000b00dc745d3ffd0mr80052ybj.1.1710263202618; Tue, 12 Mar
 2024 10:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912205658.3432-1-casey@schaufler-ca.com> <20230912205658.3432-6-casey@schaufler-ca.com>
 <20240312101630.GA903@altlinux.org> <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
 <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com>
In-Reply-To: <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Mar 2024 13:06:36 -0400
Message-ID: <CAHC9VhRfwjsGiHXBRcWA6S9+H_kj0vMdQC0gyHr3ZnX-u7KzRQ@mail.gmail.com>
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, linux-security-module@vger.kernel.org, jmorris@namei.org, 
	serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:27=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 3/12/2024 6:25 AM, Paul Moore wrote:
> > On Tue, Mar 12, 2024 at 6:16=E2=80=AFAM Dmitry V. Levin <ldv@strace.io>=
 wrote:
> >> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
> >> [...]
> >>> --- a/security/lsm_syscalls.c
> >>> +++ b/security/lsm_syscalls.c
> >>> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, a=
ttr, struct lsm_ctx __user *,
> >>>  {
> >>>       return security_getselfattr(attr, ctx, size, flags);
> >>>  }
> >>> +
> >>> +/**
> >>> + * sys_lsm_list_modules - Return a list of the active security modul=
es
> >>> + * @ids: the LSM module ids
> >>> + * @size: pointer to size of @ids, updated on return
> >>> + * @flags: reserved for future use, must be zero
> >>> + *
> >>> + * Returns a list of the active LSM ids. On success this function
> >>> + * returns the number of @ids array elements. This value may be zero
> >>> + * if there are no LSMs active. If @size is insufficient to contain
> >>> + * the return data -E2BIG is returned and @size is set to the minimu=
m
> >>> + * required size. In all other cases a negative value indicating the
> >>> + * error is returned.
> >>> + */
> >>> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *=
, size,
> >>> +             u32, flags)
> >> I'm sorry but the size of userspace size_t is different from the kerne=
l one
> >> on 32-bit compat architectures.
> > D'oh, yes, thanks for pointing that out.  It would have been nice to
> > have caught that before v6.8 was released, but I guess it's better
> > than later.
> >
> >> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modules, =
..)
> >> now.  Other two added lsm syscalls also have this issue.
> > Considering that Linux v6.8, and by extension these syscalls, are only
> > a few days old, I think I'd rather see us just modify the syscalls and
> > avoid the compat baggage.  I'm going to be shocked if anyone has
> > shifted to using the new syscalls yet, and even if they have (!!),
> > moving from a "size_t" type to a "u64" should be mostly transparent
> > for the majority of native 64-bit systems.  Those running the absolute
> > latest kernels on 32-bit systems with custom or bleeding edge
> > userspace *may* see a slight hiccup, but I think that user count is in
> > the single digits, if not zero.
> >
> > Let's fix this quickly with /size_t/u64/ in v6.8.1 and avoid the
> > compat shim if we can.
> >
> > Casey, do you have time to put together a patch for this (you should
> > fix the call chains below the syscalls too)?  If not, please let me
> > know and I'll get a patch out ASAP.
>
> Grumble. Yes, I'll get right on it.

Great, thanks Casey.

--=20
paul-moore.com

