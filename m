Return-Path: <linux-kernel+bounces-100633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEF5879B01
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7959E1F23353
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F048E1386D7;
	Tue, 12 Mar 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MO5r/bpc"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93F7C084
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266985; cv=none; b=n4k+Z5pE0PS7uIHlTDz8xDCQsMGZZk3oDl/ERo0WWzN1R2SE/XzDyfURDGN7PvxppyQEQWMvR4EDzoez1nSft80KfM1trAARfwbhVyQmPK9jPwVqx01KqA8PzU+RDDJ9xVtTUO8hy5P+f5Ul2QLNrMxCbLGgRm09D6+EmCGhgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266985; c=relaxed/simple;
	bh=N6hbKJDOHWvCISGJQnkD0ws17JAmMnk10DjL7GMCPbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0mdnRzSq1Hk1lkhINFpOs8S3x28aGgzRycxtB68mRrNINx0rEdJegFX7mYbBUhbPwYW5TzdslC3kYVorkeVfXiEWa2TrAz81aUfcpZjle2AG99LHyF/SVEqSCAMyR4tak0mFdQpGzcnbd2fBQWkeCUWMOQNPtSOZnhCSWpSTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MO5r/bpc; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60a0579a955so47184297b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710266981; x=1710871781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQo4IO+Obsv8ytjIy9Irob+LVNNIUZt7hIxL51DJ3S4=;
        b=MO5r/bpcbRlLiTsp9jHWfjaVz2xFdsbjA3WrrFORsFaQ30hrndnLV0mAUzAs1NXtB4
         74JpTG96HcpxDOSDljAgEsZLY0BNd9Ltn8E/pFES4HGXU4VNFCFBngQxqoDPNd6q62qE
         govHWYfzwT2mAJ8eMTsXrVAcw/wvCLscgQ0o9GTsRdVGEsF9djHkdNjxvKtbfvmLPuI+
         384kgTxt8H6bYC43XfkgtIjgeS1NW+NwKej5842rQLRKDz29ECaKG6xDekPP/xjFDw9t
         q6G/4/8ZOaksFas7uPvCNPgz/U55+v3XFqLUGLQorjBn/X60qhnSyciYh/L/FQZjOj8j
         iFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710266981; x=1710871781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQo4IO+Obsv8ytjIy9Irob+LVNNIUZt7hIxL51DJ3S4=;
        b=JqK6kBMqpZ3fvksm7Xtynj4V+3/qSrl/pY1MZepSvgxcUEofWVC3FSEu2okSHird8m
         gzPBLxaIh9iv96s3Cwg1todrFp71tn9+xSKRkDgoAwxRnIh5yljJY/eWCEg19YRUxDM1
         xUr4E8ooX7O7Tweb8SHK47w58t0IbaRJuNuYzkByonctaWa/JvfkLhdUxwtOkp2zhHEf
         hODOY5ElGi9G7/k9N0pyDk1I2nU37i+sIdW9eWtGKE0FgayeaeIRP+oruLkx/bEhDfJW
         u6pKQQk+9NTMQuA9DuKtvKsEkxP63bhcLfDY/cdLtqpVYZX5g9Dg4V4rRtrKl1ZvRsWL
         oTHg==
X-Forwarded-Encrypted: i=1; AJvYcCXAeISTUdZAgqQjsazQ2dk2XVtFsYG2y0zxZqetnXUCWCMHLbAUezzCZAd/DuOlR+nNYauJ61SHwGWA2kPoEU+Mb+fMbfOdr6aACjJF
X-Gm-Message-State: AOJu0YyxDvX2BSuWSPTC+BbQKHYd4ZIpzkKC6mWF+F1Em0T/+W6gOjR4
	/wx/kFPb2RyDZyZaYI3cwiSML16tqgnp/4M4rtNZGiQfIFyeVRHqkQrNWuZsF01CQ+ges1oEibC
	gpVN4prKYWBOWOQwHvNTclc9CcuWSqJAnGjDl
X-Google-Smtp-Source: AGHT+IH6XUpoIR4I7KGxCGGcQZ+fLoTY6rtMqBf0P2fTFq0mAdMh6HRJQ6lDe0ysu+Y5GV5ITdX5ZTJY7Yana+iWyGc=
X-Received: by 2002:a25:bf8d:0:b0:dc6:19ea:9204 with SMTP id
 l13-20020a25bf8d000000b00dc619ea9204mr212004ybk.61.1710266981294; Tue, 12 Mar
 2024 11:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912205658.3432-1-casey@schaufler-ca.com> <20230912205658.3432-6-casey@schaufler-ca.com>
 <20240312101630.GA903@altlinux.org> <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
 <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com> <CAHC9VhRfwjsGiHXBRcWA6S9+H_kj0vMdQC0gyHr3ZnX-u7KzRQ@mail.gmail.com>
 <f4f5d993-552b-483a-9a3e-1be99ea48757@schaufler-ca.com>
In-Reply-To: <f4f5d993-552b-483a-9a3e-1be99ea48757@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Mar 2024 14:09:30 -0400
Message-ID: <CAHC9VhSewmfbuqyTMgC7MRcw8EcQN0Srdsxmy5r01cCN8U5pAw@mail.gmail.com>
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, linux-security-module@vger.kernel.org, jmorris@namei.org, 
	serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 1:44=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
com> wrote:
> On 3/12/2024 10:06 AM, Paul Moore wrote:
> > On Tue, Mar 12, 2024 at 11:27=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 3/12/2024 6:25 AM, Paul Moore wrote:
> >>> On Tue, Mar 12, 2024 at 6:16=E2=80=AFAM Dmitry V. Levin <ldv@strace.i=
o> wrote:
> >>>> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
> >>>> [...]
> >>>>> --- a/security/lsm_syscalls.c
> >>>>> +++ b/security/lsm_syscalls.c
> >>>>> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int,=
 attr, struct lsm_ctx __user *,
> >>>>>  {
> >>>>>       return security_getselfattr(attr, ctx, size, flags);
> >>>>>  }
> >>>>> +
> >>>>> +/**
> >>>>> + * sys_lsm_list_modules - Return a list of the active security mod=
ules
> >>>>> + * @ids: the LSM module ids
> >>>>> + * @size: pointer to size of @ids, updated on return
> >>>>> + * @flags: reserved for future use, must be zero
> >>>>> + *
> >>>>> + * Returns a list of the active LSM ids. On success this function
> >>>>> + * returns the number of @ids array elements. This value may be ze=
ro
> >>>>> + * if there are no LSMs active. If @size is insufficient to contai=
n
> >>>>> + * the return data -E2BIG is returned and @size is set to the mini=
mum
> >>>>> + * required size. In all other cases a negative value indicating t=
he
> >>>>> + * error is returned.
> >>>>> + */
> >>>>> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user=
 *, size,
> >>>>> +             u32, flags)
> >>>> I'm sorry but the size of userspace size_t is different from the ker=
nel one
> >>>> on 32-bit compat architectures.
> >>> D'oh, yes, thanks for pointing that out.  It would have been nice to
> >>> have caught that before v6.8 was released, but I guess it's better
> >>> than later.
> >>>
> >>>> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modules=
, ..)
> >>>> now.  Other two added lsm syscalls also have this issue.
> >>> Considering that Linux v6.8, and by extension these syscalls, are onl=
y
> >>> a few days old, I think I'd rather see us just modify the syscalls an=
d
> >>> avoid the compat baggage.  I'm going to be shocked if anyone has
> >>> shifted to using the new syscalls yet, and even if they have (!!),
> >>> moving from a "size_t" type to a "u64" should be mostly transparent
> >>> for the majority of native 64-bit systems.  Those running the absolut=
e
> >>> latest kernels on 32-bit systems with custom or bleeding edge
> >>> userspace *may* see a slight hiccup, but I think that user count is i=
n
> >>> the single digits, if not zero.
> >>>
> >>> Let's fix this quickly with /size_t/u64/ in v6.8.1 and avoid the
> >>> compat shim if we can.
> >>>
> >>> Casey, do you have time to put together a patch for this (you should
> >>> fix the call chains below the syscalls too)?  If not, please let me
> >>> know and I'll get a patch out ASAP.
> >> Grumble. Yes, I'll get right on it.
> > Great, thanks Casey.
>
> Look like lsm_get_self_attr() needs the same change. lsm_set_self_attr()
> doesn't, need it, but I'm tempted to change it as well for consistency.
> Thoughts?

I'd suggest changing both.

--=20
paul-moore.com

