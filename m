Return-Path: <linux-kernel+bounces-22727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB93382A22F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C7C28E4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4FE4EB3D;
	Wed, 10 Jan 2024 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RL6wQiBB"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660364E1C3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e835800adso4632330e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704918148; x=1705522948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bes0cWsXMkLGrxq87eLM1Od+X4PFPpWEGIfhViy0gH8=;
        b=RL6wQiBBjOoSKlQJRQYMVprP1HIzz9NuXeyd0kxjuIxtvADKW5gsdtNLfH04ddTQQK
         wFiK/xGpwpjQT8bP5xb6mPIWFu6IMDW+hKysZCYHAdD7vyAz5dvVK2C3zdowBdnXZ+9/
         U3AX5fDm5Ck3FbeQCl4TE/iTkTGSZNKZxImKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704918148; x=1705522948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bes0cWsXMkLGrxq87eLM1Od+X4PFPpWEGIfhViy0gH8=;
        b=pKPyHPEgHcqIGuvdVnw068aj/ngLb5PVmwBH0KZ1tbL8zL6NuK99En8sileqVCdMAn
         e2zGhLgshvzSzdpnuyfn07jYbtpth4HvxWoGYQq6rRrbCO+QxV2FdBRxO1Q8D5AkZ9gw
         jfbZsk3B40Cclv+BDk2OPYQ2+gcGHoRxuXOyj5GFPD/SyzWuYOtuCGUW4cJ+NWAN0ST6
         xdYEbMyDXXKtfDXWlGn8vRiQYCjvAa31CMcaqTrajziMRba784wqBb27ikujQb72wjuQ
         QadXdXjJjRLWfOLdIbC+u+iQ98kcayKPfw2Rs4eYs9V2BU2Wvoyw1abi84mD3pkZXCr8
         CxJQ==
X-Gm-Message-State: AOJu0Yy76XcVxvfIre3iGBbc+IVkhRyVLIIZXKEU+JPUXOV1qvvc/LHA
	abxIDRE/LgsL0loVg5d4oZZ1u4pdr6jVKhlHzxF42f0fbcN9e0g6
X-Google-Smtp-Source: AGHT+IEXkvbbJzkfm/QCI4ySRjcJdCRtMrxFyz81Y7aZrzbn+WDJNbqA1PL2UzfwnV4N3dD/Z9XDCw==
X-Received: by 2002:ac2:46e9:0:b0:50e:a93a:fb7a with SMTP id q9-20020ac246e9000000b0050ea93afb7amr415025lfo.184.1704918148134;
        Wed, 10 Jan 2024 12:22:28 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j14-20020a056512398e00b0050ed63b5afasm324633lfu.100.2024.01.10.12.22.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 12:22:27 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e72e3d435so4502900e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:22:27 -0800 (PST)
X-Received: by 2002:a05:6512:3713:b0:50e:67f6:18d7 with SMTP id
 z19-20020a056512371300b0050e67f618d7mr402078lfr.156.1704918147014; Wed, 10
 Jan 2024 12:22:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f5a7bc467d221543444a268dd1a1fe0@paul-moore.com>
 <CAHk-=whb9anXdo4odpP-ybYbmQs0UaPp1fmDjsWFiGxV5aOmig@mail.gmail.com> <CAHC9VhRxG2jYayjpC=bLuBpfZsXnfYj_GoDBeK527sZWRe0ZrQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRxG2jYayjpC=bLuBpfZsXnfYj_GoDBeK527sZWRe0ZrQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 12:22:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=winAVoX=u+uX1Cdf0ekmFHETumRr60rvC_z6jbno0ApPg@mail.gmail.com>
Message-ID: <CAHk-=winAVoX=u+uX1Cdf0ekmFHETumRr60rvC_z6jbno0ApPg@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20240105
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 11:54, Paul Moore <paul@paul-moore.com> wrote:
>
> Thanks for pulling the changes, I'm sorry the syscall table entries
> for the LSM syscalls were not how you want to see them, but I'm more
> than a little confused as to what exactly we did wrong here.

Look at commit 5f42375904b0 ("LSM: wireup Linux Security Module
syscalls") and notice for example this:

  --- a/arch/x86/entry/syscalls/syscall_64.tbl
  +++ b/arch/x86/entry/syscalls/syscall_64.tbl
  @@ -378,6 +378,9 @@
   454    common  futex_wake              sys_futex_wake
   455    common  futex_wait              sys_futex_wait
   456    common  futex_requeue           sys_futex_requeue
  +457    common  lsm_get_self_attr       sys_lsm_get_self_attr
  +458    common  lsm_set_self_attr       sys_lsm_set_self_attr
  +459    common  lsm_list_modules        sys_lsm_list_modules

Ok, fine - you added your new system calls to the end of the table.
Sure, I ended up having to fix them up because the "end of the table"
was different by the time I merged your tree, but that wasn't the
problem.

The problem is here - in the same commit:

  --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
  +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
  @@ -375,6 +375,9 @@
   451    common  cachestat               sys_cachestat
   452    common  fchmodat2               sys_fchmodat2
   453    64      map_shadow_stack        sys_map_shadow_stack
  +454    common  lsm_get_self_attr       sys_lsm_get_self_attr
  +455    common  lsm_set_self_attr       sys_lsm_set_self_attr
  +456    common  lsm_list_modules        sys_lsm_list_modules

note how you updated the tools copy WITH THE WRONG NUMBERS!

You just added them at the end of the table again, and just
incremented the numbers, but that was complete nonsense, because the
numbers didn't actually match the real system call numbers, because
that tools table hadn't been updated for new system calls - because it
hadn't needed them.

Yeah, our tooling header duplication is annoying, but the old
situation where the tooling just used various kernel headers directly
and would randomly break when kernel changes were made was even worse.

End result: avoid touching the tooling headers - and if you have to,
you need to *think* about it.

           Linus

