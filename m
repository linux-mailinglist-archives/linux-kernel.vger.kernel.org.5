Return-Path: <linux-kernel+bounces-102602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECECB87B471
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460F6B20E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3E15BAC1;
	Wed, 13 Mar 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DFAmYa4l"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E558B5A106
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369463; cv=none; b=l1ArT8yTovCxq1wFaa0c79vbxtHoPSpSdtffO+bgxdKwQCJwWnFWWaDEudxrhyu+dtk5QbY+O54it6q2Tof5kn+RWw6m+bEZPwoCNCiDbs+LHN2zwZ8TFBDS1X6JHiJaaCUj+tDSi13d3/+qSl9n3ejv4y+z8nECPqTML7pW0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369463; c=relaxed/simple;
	bh=K6c6XrMV+JwnO0Oej+NDHMjJTLQS8uOVV8aiE4xZcjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+zrBMWrlvfgPoq/QNMWZXEZH8BOgFbfiuOX2wKwMv26UMp3fDxLwE+vbdJGUL7CNK+77/gWKCZBQOqsaEKJr50KS+pHsR9hi0mV+6Tyfn+Kcssex2mBcBixhX5uXDSYZg/7eCsz3SXy9/DOtqnseJsx0SNGsnVGnYBX8O6ObFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DFAmYa4l; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so226795276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710369461; x=1710974261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVkia0Brfygme8KxSL47VEN2pznkZ0Rbot/KUKgOPhU=;
        b=DFAmYa4lMOvzbE3TN3LHAgiLGFS633U1FwLbNunweDcMVacJNplfq6QrBC2e6iLTzt
         dX6moy4WIKD4FtXZqwbfigbeCCSapgiE/Nba/v6N2Oe+kuvOhByXDC/Hj1Ik9z7xcbH0
         m/ZhYCzvHGgLSRjsJcpQ5mTAmcWpR+LINkbxs99Zz9N4MMeM6Vptwqa1LiBKn2EVZkUO
         lSR7x0x3nEf8RciyBObgOOmBRmzZbdixcsKQQuLCSibNMTVy1nCoiRODSp5NJcZy8hNX
         h761zqbmFhqhfs4FlNo9/+jx5TzccDQ50fSNXQKeBN+OysVpZdd+sjc1a0xIeWDCSBXc
         Sy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369461; x=1710974261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVkia0Brfygme8KxSL47VEN2pznkZ0Rbot/KUKgOPhU=;
        b=WIelMMdAwc2Bdf8+0CrgbwjTnNb9PUtY+VA3i+cH4TJhMBU8yi11QTAHca525cpxrI
         gLWEpztEFd3ANamzdvlyrzY48WNUk0d/MsAohxdS6BHX39zc+CbPD0ArRYdbyPKQDGfh
         VOJCTuErsib6IfGucfKH+yGtnktfVt15P6sT6YHm3mcGnhKmnBvM5HJ8zCCwDv9TKugs
         ic0sz6jO9eJRPduChglgU4w9smrcH8HVUvZqCL6GDNAsOww2YbF8mywAx8zk2f0QpK+7
         Jvi5vznpoKX6M1iftXCw8AjrRIk9s8xsm4jyUoAJ8civGzc0V9z3RE4X9ELS6LnrkmMh
         ycNw==
X-Gm-Message-State: AOJu0YyQPxa0usSZI9j0m5RlDhOXzLVJQ8fxdZJ/+qL54gkxcKkwVDZj
	i/9jdLp4uwNHaVZOChUv+CGMyGj69OLNX2V96mK4SEij2WJKYBTd8MzXerRCc89Jnf9BxHplx06
	zTw3O2/9bulSvNXxk6GnGPhSwLoZYNWEO5mta
X-Google-Smtp-Source: AGHT+IHcLoU75514J4UZkFYjn41J0uOlzBxcaIOy7vfg7ZUdz2TLJembuEjtULCz4vfJxzHrXx55CVAE7FHwHp9Pvhw=
X-Received: by 2002:a25:870a:0:b0:dca:e4fd:b6d5 with SMTP id
 a10-20020a25870a000000b00dcae4fdb6d5mr75324ybl.27.1710369460856; Wed, 13 Mar
 2024 15:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com> <ef972e0088964722adffc596d38b0463@paul-moore.com>
In-Reply-To: <ef972e0088964722adffc596d38b0463@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Mar 2024 18:37:30 -0400
Message-ID: <CAHC9VhTkvyWpvkejbFf-VJoTvUKVDGxBDYkKFdNrdgq4jy5i_w@mail.gmail.com>
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
>
> Thanks everyone!

Unfortunately it looks like we have a kselftest failure (below).  I'm
pretty sure that this was working at some point, but it's possible I
missed it when I ran the selftests previously.  I've got to break for
a personal appt right now, but I'll dig into this later tonight.

# timeout set to 45
# selftests: lsm: lsm_get_self_attr_test
# TAP version 13
# 1..6
# # Starting 6 tests from 1 test cases.
# #  RUN           global.size_null_lsm_get_self_attr ...
# #            OK  global.size_null_lsm_get_self_attr
# ok 1 global.size_null_lsm_get_self_attr
# #  RUN           global.ctx_null_lsm_get_self_attr ...
# # lsm_get_self_attr_test.c:49:ctx_null_lsm_get_self_attr:Expected -1 (-1)=
 !=3D r
c (-1)
# # ctx_null_lsm_get_self_attr: Test terminated by assertion
# #          FAIL  global.ctx_null_lsm_get_self_attr
# not ok 2 global.ctx_null_lsm_get_self_attr
# #  RUN           global.size_too_small_lsm_get_self_attr ...
# #            OK  global.size_too_small_lsm_get_self_attr
# ok 3 global.size_too_small_lsm_get_self_attr
# #  RUN           global.flags_zero_lsm_get_self_attr ...
# #            OK  global.flags_zero_lsm_get_self_attr
# ok 4 global.flags_zero_lsm_get_self_attr
# #  RUN           global.flags_overset_lsm_get_self_attr ...
# #            OK  global.flags_overset_lsm_get_self_attr
# ok 5 global.flags_overset_lsm_get_self_attr
# #  RUN           global.basic_lsm_get_self_attr ...
# #            OK  global.basic_lsm_get_self_attr
# ok 6 global.basic_lsm_get_self_attr
# # FAILED: 5 / 6 tests passed.
# # Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: lsm: lsm_get_self_attr_test # exit=3D1

--=20
paul-moore.com

