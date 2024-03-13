Return-Path: <linux-kernel+bounces-102472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D6287B28F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9BD1F2761B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F814D133;
	Wed, 13 Mar 2024 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aJGTGZ23"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC74CB35
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360425; cv=none; b=u+tm+VHq9LyXM03l5YAK3nY9vGx8IULEYsBHDoel+VBeybHX99X+gI0KaXgSw6dvjfnIRZBlE5mCHOqdtdIuHZsP5wzbmw0uhmywT2dLbzdx/grL/Xesq39Fd8fMlVeelVe+Ol8v10m3STvxIh/3G5e9ptoat6xgXR8b4rB77do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360425; c=relaxed/simple;
	bh=WdJn/2bJPlVRWf/dOWnZCyI2Kvpf9aHz47q/erB5dCg=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=EUB+rOg4M8d0OLeK4pu5h1w5ibCdhUJO8RGsyRi2796InoIBXVfcaD8LEn8mvGDNE1JfIiMbCR9GFAMcRlSpYxNgRE7gCaemVs42TkAT+kti8Y3zXioRQdwiO8nM7o7IpxWcQdqPmRFezgYbrbIm9sfWENszzKcKOXsQjOFTOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aJGTGZ23; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42f37657e91so895421cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710360421; x=1710965221; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TaOWCQYhiM9DJgHYIEv5GJLKXhKlFmkTvf/eVZF5clo=;
        b=aJGTGZ23b/wsfN4YvfvuCU86YOU83NuTbqW8r9WQtbDC13lB80JvrxrGtuYpJE6/oW
         DalDuUnJDX8IcMQtis9h/25kCj9YlhfZlY8KU+Wml63rYp1JbsO8qwD2JYzvuPpW2HF9
         qw0xdXSmjh7RZynQfmfQiyrdWwARnFgalOenb3qYz8siDo07+vStincu0DjxrYaJ57IX
         s+UKaPEV6VtzWgl+RwnPI9tqlD6mw9g90NzGMhwsbNXqTzLSuAiz1/keSKrF3GllvY6b
         fdNmV2Ahpw80GeCN9MfLXwxBJJsc6eWb+jP7JY1EM/1El9KMtq+iYBwReC86PwYc/N86
         4FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710360421; x=1710965221;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaOWCQYhiM9DJgHYIEv5GJLKXhKlFmkTvf/eVZF5clo=;
        b=ZWI8R8GiNhiexM/w36dHVpyn78xUfSTAPizrkhZRuiH18RE3iaj0CZCtqr2ly6UyGc
         mOqPW3AVFFCooyhI408Bq5z3ipRjwhYneaIRJS7+NcQWD0lX9dv4rDyZbeHSmZAEWs+9
         2+MABaORBQn7dBYSXCiWPgKCgA0SJW9tQeWeYqtMN8rpydP2plOSHdD6gzULU1IqY1eT
         zwDEgtf1NvM5uhkQvxdvpbzh9lazrRj+X34vyIhRqhJkOoIP1d/0W8eWhk5mpn/ypwg6
         CKZR2JPhF7QuzD6Bqw0gnxr3+3ikjnxYwZcScRgaTDt3lcJOoZfxBfmB4tCkJcl+f16+
         Rqug==
X-Gm-Message-State: AOJu0YyOjhUdrp8a/svvJ8L/yKa4EimlbjCTRcVAIkDBXbfp+6To6I38
	64jIy37i6eHQWMEWYTaISTNp5/5dfgUNku4zVBg690apdyU7cyeCGQsvTthQ5Q==
X-Google-Smtp-Source: AGHT+IFxmVIZmlHkW7ctMZiLN7tCNdso6UsKbHz3xwPt7MplNKbQy1ronk5TK63/kW8nTuSGVRemjg==
X-Received: by 2002:ac8:7d82:0:b0:42e:f47e:43d8 with SMTP id c2-20020ac87d82000000b0042ef47e43d8mr17793281qtd.43.1710360421643;
        Wed, 13 Mar 2024 13:07:01 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id e17-20020ac85991000000b0042f53f9f8b0sm2357995qte.26.2024.03.13.13.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:07:01 -0700 (PDT)
Date: Wed, 13 Mar 2024 16:07:00 -0400
Message-ID: <ef972e0088964722adffc596d38b0463@paul-moore.com>
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
Subject: Re: [PATCH v3] LSM: use 32 bit compatible data types in LSM syscalls.
References: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com>
In-Reply-To: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com>

On Mar 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> LSM: use 32 bit compatible data types in LSM syscalls.
> 
> Change the size parameters in lsm_list_modules(), lsm_set_self_attr()
> and lsm_get_self_attr() from size_t to u32. This avoids the need to
> have different interfaces for 32 and 64 bit systems.
> 
> Cc: stable@vger.kernel.org
> Fixes: a04a1198088a: ("LSM: syscalls for current process attributes")
> Fixes: ad4aff9ec25f: ("LSM: Create lsm_list_modules system call")
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reported-and-reviewed-by: Dmitry V. Levin <ldv@strace.io>
> ---
>  include/linux/lsm_hook_defs.h                        |  4 ++--
>  include/linux/security.h                             |  8 ++++----
>  security/apparmor/lsm.c                              |  4 ++--
>  security/lsm_syscalls.c                              | 10 +++++-----
>  security/security.c                                  | 12 ++++++------
>  security/selinux/hooks.c                             |  4 ++--
>  security/smack/smack_lsm.c                           |  4 ++--
>  tools/testing/selftests/lsm/common.h                 |  6 +++---
>  tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 10 +++++-----
>  tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
>  tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
>  11 files changed, 38 insertions(+), 38 deletions(-)

Okay, this looks better, I'm going to merge this into lsm/stable-6.9
and put it through the usual automated testing as well as a kselftest
run to make sure everything there is still okay.  Assuming all goes
well and no one raises any objections, I'll likely send this up to
Linus tomorrow.

Thanks everyone!

--
paul-moore.com

