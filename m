Return-Path: <linux-kernel+bounces-102383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B187B172
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B7928745B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97019657B7;
	Wed, 13 Mar 2024 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AmbtVOfd"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07F651B1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355585; cv=none; b=TeYd2NESGJY/wx4Yaj/0zd3cnmR963Njv39/zOeMLvjYJ6I/oJFXxr1za0D47NEHvYO4/SASwVUxm4xL/LlkqTsVZC7JEzZTpVZv9Xy1xjU+BiLAX0h2hTmVDVLt2LW8neb0hF0q7rt2uDauFqnLARIcS1HzP/8xktubiskPcmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355585; c=relaxed/simple;
	bh=+OnZV91ZS5vZO7aIyqccoeeBh3VEiT5tR+L8tOrjf7c=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=hOVFvLEjlXPfwYxDPF3DYitqZNdPy3FDeC1ciiv5Jlbkzi+jHp+rNbB4SRleaGg4QASRZRNRZ9PO1JaORzo78tnkmRxjYJyO3Tszvcb721PrmmEIcfG93br+AQ7hofaG3FyXhfPXUHxMu4hjyNosXc+K9+xGCXkJuC9VxDELxUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AmbtVOfd; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78852e1e923so7564185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710355583; x=1710960383; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ywrPY739yU0nS2VK6Nhds/Zu1RkhASL52nCmk5BLsDI=;
        b=AmbtVOfdgPRgluiUXloYTGlCK0x9hgnsKQk2ZiExL4jqQnqf7GlDEhsH0bkEkKWguu
         Hy7r5qdZmqdboby4Jh2SW3oiq38NlO1aVykjE8lDfdemub5sZriT8zj9dUOV2mmXnpLs
         feMeKhTTwjggFn+jUZRAiifdnbIdzU8kRwt+yt/CBFwLYrv75V32OET1lauD/WGQq1r3
         50sD8wAy0+G5mpXh7cFggyuHX3Wma1gX/bqUOZclKCXRoeZ0MUiQdhqpt3YZpgn9PmVj
         yxFp4D1HKJpkU+PSXM/g4nZ6plwmjxQ0BIuG779r6Z9VOqLeXPyfNw8ScOI7ioDq0pe3
         wmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710355583; x=1710960383;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywrPY739yU0nS2VK6Nhds/Zu1RkhASL52nCmk5BLsDI=;
        b=C9C5mly6kUJC3Rf+k9cXeZGdrUXV8c079X6Gy3Ua2hJFxssNnuP/R5Hux9j72D7btD
         uQMhy/oUyQ9I5dI+QleMPXdOQY2bpDMUAKKaNlbULlzDmjgwHzThoIcSW/m4tuPhpB2+
         U+ceLuDL11+4W37MTNNqMxDtfFOvRe0z4uUOz58r99DFs1UrH6iBRji8UtlZVsFvhEHn
         HhE9P8nEzz+TC5IQ2uYwhOt2TBDDq+4iMShwi0ZKBXbpnsHiDSWaClcveOHk9tBadDy8
         A02nMaYPphqONSlPDH08f33bTx0qksdJwecmRJ5T5qvqxVP9UCtOSK6dpLDKdDNqLBVI
         FY5w==
X-Gm-Message-State: AOJu0Yzw+ofj4focyvUVcm93YgnVbEIftuKcnU3pcLqi3l4PycnZnMKT
	/93iTuosqFkwRj0YQwEJ+RN/NICabHVdbiOWc0Qt8qIXlEQh1Ei9jb2BODZdfQ==
X-Google-Smtp-Source: AGHT+IE+id1wDtRNqVr7efh85Q5hF8uaM3VorLPsEdRgTNhMwwsfhPXVTHo8BcqJaEHVrmlxoQ/z8g==
X-Received: by 2002:a05:620a:2901:b0:789:ca81:a960 with SMTP id m1-20020a05620a290100b00789ca81a960mr1155516qkp.0.1710355582825;
        Wed, 13 Mar 2024 11:46:22 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm5033422qkl.17.2024.03.13.11.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:46:22 -0700 (PDT)
Date: Wed, 13 Mar 2024 14:46:21 -0400
Message-ID: <6353ba2abd868cd83186f54e7b71c840@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, "Dmitry V. Levin" <ldv@strace.io>, LSM List <linux-security-module@vger.kernel.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v2] LSM: use 32 bit compatible data types in LSM syscalls.
References: <045f54ea-4057-43b8-81e2-5cc1b3966d04@schaufler-ca.com>
In-Reply-To: <045f54ea-4057-43b8-81e2-5cc1b3966d04@schaufler-ca.com>

On Mar 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> LSM: use 32 bit compatible data types in LSM syscalls.
> 
> Change the size paramters in lsm_list_modules(), lsm_set_self_attr()

s/paramters/parameters/

> and lsm_get_self_attr() from size_t to u32. This avoids the need to
> have different interfaces for 32 and 64 bit systems.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

We should add the following 'Fixes:' tags as well as a stable marking:

  Cc: stable@vger.kernel.org
  Fixes: a04a1198088a ("LSM: syscalls for current process attributes")
  Fixes: ad4aff9ec25f ("LSM: Create lsm_list_modules system call")

> ---
>  include/linux/lsm_hook_defs.h                        |  4 ++--
>  include/linux/security.h                             |  8 ++++----
>  security/apparmor/lsm.c                              |  4 ++--
>  security/lsm_syscalls.c                              | 10 +++++-----
>  security/security.c                                  | 14 +++++++-------
>  security/selinux/hooks.c                             |  4 ++--
>  security/smack/smack_lsm.c                           |  4 ++--
>  tools/testing/selftests/lsm/common.h                 |  6 +++---
>  tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 12 ++++++------
>  tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
>  tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
>  11 files changed, 40 insertions(+), 40 deletions(-)

..

> diff --git a/security/security.c b/security/security.c
> index 7035ee35a393..a0f9caf89ae1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -810,7 +810,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
>  	nctx->ctx_len = val_len;
>  	memcpy(nctx->ctx, val, val_len);
>  
> -	if (copy_to_user(uctx, nctx, nctx_len))
> +	if (uctx && copy_to_user(uctx, nctx, nctx_len))
>  		rc = -EFAULT;

Hey, where did that @uctx check come from?

I'm trying to work through if that is a good/bad change, but regardless
of if we want to make that change, it really should be in a separate
patch as it has nothing to do with the syscall parameter changes.

> diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> index e0e313d9047a..288302a444e0 100644
> --- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> +++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> @@ -76,8 +76,8 @@ TEST(flags_zero_lsm_get_self_attr)
>  {
>  	const long page_size = sysconf(_SC_PAGESIZE);
>  	struct lsm_ctx *ctx = calloc(page_size, 1);
> -	__u64 *syscall_lsms = calloc(page_size, 1);
> -	size_t size;
> +	__u32 *syscall_lsms = calloc(page_size, 1);

I believe that should remain a __u64 pointer as we didn't change the
first parameter to lsm_list_modules().  I'm guessing this was an victim
of an overzealous /u64/u32/ search-n-replace going from v1 to v2.

> +	__u32 size;
>  	int lsmcount;
>  	int i;
>  

In the interest of speeding things along, I'm happy to make the above
changes while merging Casey, but if you would prefer to do a respin
that's fine with me - let me know either way so I can plan accordingly.

--
paul-moore.com

