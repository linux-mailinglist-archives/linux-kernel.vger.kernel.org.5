Return-Path: <linux-kernel+bounces-100654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEF7879B55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5EDB23E84
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A984913958D;
	Tue, 12 Mar 2024 18:28:26 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15EC139574;
	Tue, 12 Mar 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268106; cv=none; b=KoIZZFwAGbrcGmFp8hTfsmyRirnFVRNXyq4oltRdLsPSan9iqWOYecnFiMBOS6jt6Qh5hDyOdNkAmQOPIkljQYo5M0wxMBNq1hjtrLaYPQf/LRlUg5ZZlXw17qSN7DIinEcYDf0XS1WK3bO3ijseGj74Y5zANZHr4pv90Ufdkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268106; c=relaxed/simple;
	bh=7EC4IAJJp+c6o0M8iH6pYWKRUgdiQ+sEHXxrJQMhjq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoXMEa1cWd6VaocL8PUua2Gyn3d5BfMho3XGg8PEMhNzl4cG6WltYTLUMx8iB41sftGA82M5MvwVxvWCxvfg6E6lbsMlmFfmiEZv6UrV+4nQvuqfaze2kfAo2VWZge4ilDodc/LEpVMfTgeV1BLTCONuI0VlHTecSSHfptQrfWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 270A072C8FB;
	Tue, 12 Mar 2024 21:28:21 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 1775B7CCB3A; Tue, 12 Mar 2024 20:28:20 +0200 (IST)
Date: Tue, 12 Mar 2024 20:28:20 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
Message-ID: <20240312182820.GA5122@altlinux.org>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-6-casey@schaufler-ca.com>
 <20240312101630.GA903@altlinux.org>
 <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
 <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com>
 <CAHC9VhRfwjsGiHXBRcWA6S9+H_kj0vMdQC0gyHr3ZnX-u7KzRQ@mail.gmail.com>
 <f4f5d993-552b-483a-9a3e-1be99ea48757@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4f5d993-552b-483a-9a3e-1be99ea48757@schaufler-ca.com>

On Tue, Mar 12, 2024 at 10:44:38AM -0700, Casey Schaufler wrote:
> On 3/12/2024 10:06 AM, Paul Moore wrote:
> > On Tue, Mar 12, 2024 at 11:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 3/12/2024 6:25 AM, Paul Moore wrote:
> >>> On Tue, Mar 12, 2024 at 6:16 AM Dmitry V. Levin <ldv@strace.io> wrote:
> >>>> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
> >>>> [...]
> >>>>> --- a/security/lsm_syscalls.c
> >>>>> +++ b/security/lsm_syscalls.c
> >>>>> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
> >>>>>  {
> >>>>>       return security_getselfattr(attr, ctx, size, flags);
> >>>>>  }
> >>>>> +
> >>>>> +/**
> >>>>> + * sys_lsm_list_modules - Return a list of the active security modules
> >>>>> + * @ids: the LSM module ids
> >>>>> + * @size: pointer to size of @ids, updated on return
> >>>>> + * @flags: reserved for future use, must be zero
> >>>>> + *
> >>>>> + * Returns a list of the active LSM ids. On success this function
> >>>>> + * returns the number of @ids array elements. This value may be zero
> >>>>> + * if there are no LSMs active. If @size is insufficient to contain
> >>>>> + * the return data -E2BIG is returned and @size is set to the minimum
> >>>>> + * required size. In all other cases a negative value indicating the
> >>>>> + * error is returned.
> >>>>> + */
> >>>>> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
> >>>>> +             u32, flags)
> >>>> I'm sorry but the size of userspace size_t is different from the kernel one
> >>>> on 32-bit compat architectures.
> >>> D'oh, yes, thanks for pointing that out.  It would have been nice to
> >>> have caught that before v6.8 was released, but I guess it's better
> >>> than later.
> >>>
> >>>> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modules, ..)
> >>>> now.  Other two added lsm syscalls also have this issue.
> >>> Considering that Linux v6.8, and by extension these syscalls, are only
> >>> a few days old, I think I'd rather see us just modify the syscalls and
> >>> avoid the compat baggage.  I'm going to be shocked if anyone has
> >>> shifted to using the new syscalls yet, and even if they have (!!),
> >>> moving from a "size_t" type to a "u64" should be mostly transparent
> >>> for the majority of native 64-bit systems.  Those running the absolute
> >>> latest kernels on 32-bit systems with custom or bleeding edge
> >>> userspace *may* see a slight hiccup, but I think that user count is in
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

As lsm_get_self_attr() has the same issue, it needs the same treatment.

lsm_set_self_attr() could be left unchanged.  In fact, changing the type
of syscall arguments from size_t to an explicit 64-bit type would be
problematic because 32-bit syscalls cannot have 64-bit arguments.


-- 
ldv

