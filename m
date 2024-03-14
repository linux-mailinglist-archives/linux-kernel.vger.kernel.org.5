Return-Path: <linux-kernel+bounces-103649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F2387C274
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F341C216E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5943374C0A;
	Thu, 14 Mar 2024 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HD0ESMK9"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA974C06
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440321; cv=none; b=B5Smszb3aJj7pE0GURk3Z7Pmp/XQwJrhSAuEbKT/uEl2g0k77eclPQ0D6EKDDMvJKyHRYgbxxb0SXdn8TGUTHKzh6A3uCsN0hkny421X2nbCTOD4fgVjufzKu2U2uNuwQgXa33kEjS3S/kWGvOlNgEDDQJVmTpJEvqyddFOEm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440321; c=relaxed/simple;
	bh=XfvJ/gyEHsGOw8ctti1alr/Lsnygp4BfvBrNlOhNbYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QivPtkABx4C7t2srPgkxv6tXnXnGww1o7pfNc4ZvWsge0lHfaKiRjmCaiPO0CtuU9fIA26ki1FkNYIb4Zj6ytek+tQCTkv1XHZbOFIGmSN44x1gj8E4UAyTUwE2boxXwg2DttNUainS/X2aweyTQen/wQ0/SxALz9vm6tB9be+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HD0ESMK9; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so1125945276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710440319; x=1711045119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5EfQxrqLDqzJd0vO6EebJPZwf9AXezpn4SptHBp47A=;
        b=HD0ESMK9wtAsHJzETO9qu+RqNUaCXz90qBF1y+yCSBl8TZv0rVE0XtHxl/bWJzRmPH
         onh2H5pzrjYm5XRjjKINoM8u2K8QBJfRMRPQogVcIbm7zj6s6mIBql22ob0VEQHeB8Be
         +RqllE8/ay2vIFful8WmH7G7gyxT//0igp7aKee+Ueohj6mU6H28Xv1+zabxSt54GMet
         AJl9y0kDW3Y8W94TmBJt+H0owhaisB1F1LSQUit7HYlMF9xTh3SVAhXvLVN3CGr2Y7gM
         YngCVx2Q+JMHHgGVWme+5UYfGX5qekOFAlRtUNkZVhP4M3I+wWPaAy3lYdYgdaNnHZg5
         Noeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710440319; x=1711045119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5EfQxrqLDqzJd0vO6EebJPZwf9AXezpn4SptHBp47A=;
        b=CQ6oNwTEwct5AJ0lWsvc1mEmzVj+yKDNdAAfXabURY7Kw5oCrwmzdaszB6++//D918
         OyPrRAtsMkSaNJ1+H/kPzSmNjocONcU3eWELowSapvWhnnzI1mi1OlKVoHmU/iHKSaJp
         4Dpj434k32tz32PPTAUBKz2ffSW9hGQYwup9/2hfQySYxBWiptMvVF4T3Sq3UFocM3im
         8U1fjWIn/fXnNmq6KwsbuiblVsbxQTnpTIqzROeTUVCa5bzOB6tFVJc15if5Y8iXc8x/
         zHgYP5ymtMECKPny69pH0iLfhb2YO3LDfXDQi3GwvGmO+b7CWeJVkw3NzJJE63jVzpSL
         l+HA==
X-Forwarded-Encrypted: i=1; AJvYcCUeRESYDNFNIRuGSBi8A6NvmwHkMnYwEojzP75bI9jvoLtFiywYYtmyqa8qbOSbFhAbzW0gQ0AT9vVVWlgKr1dxKKZSx5TwwXs+hz/I
X-Gm-Message-State: AOJu0YzPpZ1m6Fro2tmjQJGNjAkVneVzETawGo/2adwax2c74JQIxj31
	o7nFNctzec+mDOXrPOe1c7xPYNAX+6Z9uAmL5fBN1OTRfTuDSC+GhsEUpTDptngUbb58dUOeYBC
	yGbh9K0vVrhUfgoSjZeHJ1qI/N5WtOYdKVtGZJyfcHm8LFL8=
X-Google-Smtp-Source: AGHT+IE1SRc+GmgyyOwR51Q0geIvJ72fxbTE+GpoDTLCrIGvpll8QStKJQNxkSqYOjJgfMOm1dRM0NoAh6tQeqW9DkQ=
X-Received: by 2002:a25:9c46:0:b0:dd1:55b6:e671 with SMTP id
 x6-20020a259c46000000b00dd155b6e671mr2620728ybo.21.1710440318187; Thu, 14 Mar
 2024 11:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com>
 <ef972e0088964722adffc596d38b0463@paul-moore.com> <CAHC9VhQc-DEf=kSxbG-Mvz8jq-gxkaCe2jHb2a9LsJLQydj1zQ@mail.gmail.com>
 <20240314180143.GA26431@altlinux.org>
In-Reply-To: <20240314180143.GA26431@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 Mar 2024 14:18:27 -0400
Message-ID: <CAHC9VhTyg1aX-GEuZb2n3BjctH3_fCpz7W4i0WoLoMzbSnPCZA@mail.gmail.com>
Subject: Re: [PATCH v3] LSM: use 32 bit compatible data types in LSM syscalls.
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, 
	John Johansen <john.johansen@canonical.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 2:01=E2=80=AFPM Dmitry V. Levin <ldv@strace.io> wro=
te:
> On Thu, Mar 14, 2024 at 11:30:53AM -0400, Paul Moore wrote:
> > On Wed, Mar 13, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Mar 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > >
> > > > LSM: use 32 bit compatible data types in LSM syscalls.
> > > >
> > > > Change the size parameters in lsm_list_modules(), lsm_set_self_attr=
()
> > > > and lsm_get_self_attr() from size_t to u32. This avoids the need to
> > > > have different interfaces for 32 and 64 bit systems.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: a04a1198088a: ("LSM: syscalls for current process attributes=
")
> > > > Fixes: ad4aff9ec25f: ("LSM: Create lsm_list_modules system call")
> > > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > Reported-and-reviewed-by: Dmitry V. Levin <ldv@strace.io>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h                        |  4 ++--
> > > >  include/linux/security.h                             |  8 ++++----
> > > >  security/apparmor/lsm.c                              |  4 ++--
> > > >  security/lsm_syscalls.c                              | 10 +++++---=
--
> > > >  security/security.c                                  | 12 ++++++--=
----
> > > >  security/selinux/hooks.c                             |  4 ++--
> > > >  security/smack/smack_lsm.c                           |  4 ++--
> > > >  tools/testing/selftests/lsm/common.h                 |  6 +++---
> > > >  tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 10 +++++---=
--
> > > >  tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
> > > >  tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
> > > >  11 files changed, 38 insertions(+), 38 deletions(-)
> > >
> > > Okay, this looks better, I'm going to merge this into lsm/stable-6.9
> > > and put it through the usual automated testing as well as a kselftest
> > > run to make sure everything there is still okay.  Assuming all goes
> > > well and no one raises any objections, I'll likely send this up to
> > > Linus tomorrow.
> >
> > I had to squash the code snippet below into the patch to address a
> > build problem identified by the kernel build robot.  I'm going to keep
> > Casey's sign-off and Dmitry's reported-reviewed tag as I feel this
> > change is minor, but if anyone has any objections please let me know
> > soon.
> >
> > [NOTE: cut-n-paste'd into email, likely whitespace damage, but you get =
the idea]
> >
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 77eb9b0e7685..e619ac10cd23 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -960,10 +960,10 @@ asmlinkage long sys_cachestat(unsigned int fd,
> >                struct cachestat __user *cstat, unsigned int flags);
> > asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long =
size, un
> > signed int flags);
> > asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx=
 *ctx,
> > -                                     size_t *size, __u32 flags);
> > +                                     u32 *size, u32 flags);
> > asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx=
 *ctx,
> > -                                     size_t size, __u32 flags);
> > -asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags=
);
> > +                                     u32 size, u32 flags);
> > +asmlinkage long sys_lsm_list_modules(u64 *ids, u32 *size, u32 flags);
>
> Fine with me, thanks.
>
> btw, with the change above, u32 will become about twice more popular
> in include/linux/syscalls.h than __u32.

I was looking at that when I was putting the patch together this
morning, trying to decide which was the "correct" choice between 'u32'
and '__u32' and wasn't able to find a good explanation of which is the
"right" option in this file.  Ultimately I went with 'u32' as I tend
to follow some old guidance of: '__u32' for userspace headers, 'u32'
for kernel headers.

If it should be the other way, please let me know.  I just want to
keep it consistent across the LSM syscalls.

--=20
paul-moore.com

