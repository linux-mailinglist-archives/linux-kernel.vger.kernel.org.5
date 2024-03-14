Return-Path: <linux-kernel+bounces-103494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25C987C03C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F739B22A09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101977317F;
	Thu, 14 Mar 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LVnpPLo3"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893AE73160
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430268; cv=none; b=Nnip3GINOjjf9nIzjq71eSTpHf+VPCrOWSm9Lu7eaDObgo3Vlw0UExdl2DqbZulOyR2bDu1Lp8bcQ5oR9ZzC0kN6DdIhmTY2z7POkXzF9zQS/6ThPV8TGpQh3PoJ2uF3K/VeDWWffJewlezsQT0sPDJuEeq+TBoP9Q1szvzb16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430268; c=relaxed/simple;
	bh=9ZQ1t1rVe0FrApDMiLTEp7rBgibtRxfjgP1kmP9RgNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikHhiBZXeu+3eNfPZWfKfHBPc/0OpuscPxQGED3FMH6YQ7A53GW/2EpTjS6YxamUvUHijkKulho59eMwON+QigZJ8fLlE0f8TbsGQt/66+jStJ+o0Liky6dux8Z9Qxu1j9+Rrx56Hh1ct2fPI/MVgnVvVBDW3IU8OsC2mKU0nhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LVnpPLo3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-609408d4b31so11454657b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710430265; x=1711035065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxK2KXxBiljZaX04ZK1sbZ6ecmksuIMA+jQgqOjSU0Q=;
        b=LVnpPLo39/+88+FwmlWx1IbM56HEIwV3y9Xiyp++A8qb9tJuhl2exZDMCzAhZqDHaA
         c6CypBqwCoKoRDgA9YDuKR1Vi48DxV32i7v2Tn/9PBSzC+WaF0J+DaaiVtVvPP1RhSr3
         6sZvwZGrR4+CL/+GX2aWhrNGGr1qJ5pxSTrwgODTY8HMHU9P/cltTQgEa9SMU/PenEIw
         7qyuqxhw84/XjbiWxe7UK1W4McSt4kCy17bE7McIWifahmpALgqwcdgLyuy7zNg5/pEt
         7hLz024Ae+JNED6HoQegjYT4zqPFMKgHz/eyMPDraIeSi1GQg6kAZrjrFek8s30YdDvB
         KNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430265; x=1711035065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxK2KXxBiljZaX04ZK1sbZ6ecmksuIMA+jQgqOjSU0Q=;
        b=FbEtn+zdILlxrmFHYCFXjfHiHvV+CgHZzv40LF+Ps4z3eM7RZC2hEBxm+Yw4b1U3BS
         i0NVVYP3DGN54bgtLEEOpSao70/TB5qdwTWw2bbhm0u5MjB7c1B0cRMxqBM4UXWqI0Dp
         C7flp2qJfBQj9D7xX1xBO28nJzgPOQfBKVAkWLuDR+yIcE7H22ipZxIzh6EGFkD3W2oe
         +HIhTGG5sAOocVGMg+75/MAdCIOV3dBCWlWKK7f3X6mMVo4OEd78HjjbP7gWX8iChS8g
         tym0C9OOb4ucixVByh4VmRudbcX0aiD6EmYCuWMWgSBzb8oULeXADSvxra+W8n04TmWH
         +BSQ==
X-Gm-Message-State: AOJu0YxffEqYcmsX6NLhq3M/hrjhHVLEieRxgNyEMi6md4ng8reLjPTN
	znDVEbcPAwXJQxXq78blml/fj/3f7t1eKO7iEHOEjbeUQY8gqpIR1eHKhEtm8t7Vv0pSA0W3dBH
	Lv3sU3tv8FkJlwrYvbrcg5vqfTzkZ4Zh3BYhP
X-Google-Smtp-Source: AGHT+IFFJ4Cb2JwXh0t8r6l1MRqhHBFknJZNbtosljPHGFlqBq55hrQS8sHmamEcG43gfXD559LvX/uw8e94dJHwoaw=
X-Received: by 2002:a25:b59a:0:b0:dbd:4578:5891 with SMTP id
 q26-20020a25b59a000000b00dbd45785891mr2165614ybj.65.1710430264086; Thu, 14
 Mar 2024 08:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com> <ef972e0088964722adffc596d38b0463@paul-moore.com>
In-Reply-To: <ef972e0088964722adffc596d38b0463@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 Mar 2024 11:30:53 -0400
Message-ID: <CAHC9VhQc-DEf=kSxbG-Mvz8jq-gxkaCe2jHb2a9LsJLQydj1zQ@mail.gmail.com>
Subject: Re: [PATCH v3] LSM: use 32 bit compatible data types in LSM syscalls.
To: Casey Schaufler <casey@schaufler-ca.com>, "Dmitry V. Levin" <ldv@strace.io>, 
	LSM List <linux-security-module@vger.kernel.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, 
	John Johansen <john.johansen@canonical.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mar 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > LSM: use 32 bit compatible data types in LSM syscalls.
> >
> > Change the size parameters in lsm_list_modules(), lsm_set_self_attr()
> > and lsm_get_self_attr() from size_t to u32. This avoids the need to
> > have different interfaces for 32 and 64 bit systems.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: a04a1198088a: ("LSM: syscalls for current process attributes")
> > Fixes: ad4aff9ec25f: ("LSM: Create lsm_list_modules system call")
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reported-and-reviewed-by: Dmitry V. Levin <ldv@strace.io>
> > ---
> >  include/linux/lsm_hook_defs.h                        |  4 ++--
> >  include/linux/security.h                             |  8 ++++----
> >  security/apparmor/lsm.c                              |  4 ++--
> >  security/lsm_syscalls.c                              | 10 +++++-----
> >  security/security.c                                  | 12 ++++++------
> >  security/selinux/hooks.c                             |  4 ++--
> >  security/smack/smack_lsm.c                           |  4 ++--
> >  tools/testing/selftests/lsm/common.h                 |  6 +++---
> >  tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 10 +++++-----
> >  tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
> >  tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
> >  11 files changed, 38 insertions(+), 38 deletions(-)
>
> Okay, this looks better, I'm going to merge this into lsm/stable-6.9
> and put it through the usual automated testing as well as a kselftest
> run to make sure everything there is still okay.  Assuming all goes
> well and no one raises any objections, I'll likely send this up to
> Linus tomorrow.

I had to squash the code snippet below into the patch to address a
build problem identified by the kernel build robot.  I'm going to keep
Casey's sign-off and Dmitry's reported-reviewed tag as I feel this
change is minor, but if anyone has any objections please let me know
soon.

[NOTE: cut-n-paste'd into email, likely whitespace damage, but you get the =
idea]

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77eb9b0e7685..e619ac10cd23 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -960,10 +960,10 @@ asmlinkage long sys_cachestat(unsigned int fd,
               struct cachestat __user *cstat, unsigned int flags);
asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size=
, un
signed int flags);
asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ct=
x,
-                                     size_t *size, __u32 flags);
+                                     u32 *size, u32 flags);
asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ct=
x,
-                                     size_t size, __u32 flags);
-asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
+                                     u32 size, u32 flags);
+asmlinkage long sys_lsm_list_modules(u64 *ids, u32 *size, u32 flags);

/*
 * Architecture-specific system calls

--=20
paul-moore.com

