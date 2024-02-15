Return-Path: <linux-kernel+bounces-66193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C1855868
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE895B26CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8433564D;
	Thu, 15 Feb 2024 00:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cf2UWxre"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63478639
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707957945; cv=none; b=PF9d2reZpbzEYX3kyd3fnIqQySe2dK0V42E5Ey4gBy0bPZheytwr115KHHr+bhlqfNMtuduvjUSrKB1m53+62e117dItEOAjZCp+oapTu7lAMltmYNce8EuYj9k7Jdxz4+EJnjeIXv4kdiAVwj8u2WSr5ZS+cODDIhZ0YAHZfog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707957945; c=relaxed/simple;
	bh=57EG/0ZwmKtwXNJ0IzAUfLW8cf7jcqGxUoA0gdV96WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDBQBQQcI6MNlRKvKD2aDn4/AeqZTE8pLddTIwpGJeGroa3OfRB4L+mHd9QlzBj37QLtR84uJXGy3365OtsEXWfePLEuZ+icKKDX5HfSqJJ2AheuCaSWS0ye+CJjP8a2Iz4uHiRHMRYZ45iQv1d8H1iaFtbE8w9LU6gkxAddOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cf2UWxre; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c48fc56752so12334539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707957943; x=1708562743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0AvVNTj/tsYhJ9uNlkS0NKEX6Ozv7KgymDA8FjoHGs=;
        b=Cf2UWxrenRDfBmtCzOFoIyBD/dbfvsZTZV37AqgonJ++TKn10wV0wWX2y7OS3UWw31
         tjdYnic7uth4zgE6+fLjrxec71HnDN3vhXOcb2ndsnCx8Ps+ThPwC1Uk99baMnGUGhv8
         xSS/nMR35+AgBlH3sZG9s6Z9PSSG8IIgpIHwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707957943; x=1708562743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0AvVNTj/tsYhJ9uNlkS0NKEX6Ozv7KgymDA8FjoHGs=;
        b=awPNQ8+XH31Y+4NpVTF9pbQAMh4jGoZfoBTjHqZBomma/GAssjTzJ9xlaquitYSTii
         bO4AOAx/5NE+Rma0Cm/LPdo8Y2FMXvr9Hb0IoXDI7tFaH/WzjUrGK2zlL1Br/LWktoGW
         j+KhYhRk8YFjy/POFD/VP+8M2xGSYiS9yQaVQjSp6pJ5t4KUeJtx6MKS0cxh6McCVo+V
         2uXafAtglXkEx1aL3GvUinRyYxz1MgvEdKiDpZclmx7YP5O6KdC+JoEDswbFyydEfpNd
         pYgUuOZSLlsIyQtQeM9zTM9qVWVs95MG5vvJ/0FSQVvAywdFg1r0uM+dsCWdbBAgnawe
         860A==
X-Forwarded-Encrypted: i=1; AJvYcCVxiPHiA38X9r+eaznl/97Gk270MV8mS85ZK7ylPFjPIQ+LAJCKozY1PRupv4UXd5j2Ftt6RISPyEJrwqdFUf39i4742ix8H/NMF8bD
X-Gm-Message-State: AOJu0YwOTUVkvYXX9liMlWL53yfE53RPfxI+8zrlVnJmg4HRUw8Zd+s3
	tls8brFVa/LTCjVW4oyDACIDCj+HL4TnaO7UCw4Thiq3D5Q1Kj5ghchkq4YJng==
X-Google-Smtp-Source: AGHT+IE/HUYutDFg5/TS4iAeRQ7tRx4NQpQoDygrWbnBHJDS+e/mKySdgMTuUzCTuSI0C5fsiIpamQ==
X-Received: by 2002:a92:a30e:0:b0:364:21b0:6050 with SMTP id a14-20020a92a30e000000b0036421b06050mr121980ili.6.1707957943570;
        Wed, 14 Feb 2024 16:45:43 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s64-20020a635e43000000b005b7dd356f75sm50540pgb.32.2024.02.14.16.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 16:45:43 -0800 (PST)
Date: Wed, 14 Feb 2024 16:45:42 -0800
From: Kees Cook <keescook@chromium.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: fix integer overflow in lsm_set_self_attr()
 syscall
Message-ID: <202402141644.808307E71@keescook>
References: <20240214160538.1086089-1-jannh@google.com>
 <a4a77e0e-8d5e-4c9d-aff4-9fe0d8b89cf0@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a77e0e-8d5e-4c9d-aff4-9fe0d8b89cf0@schaufler-ca.com>

On Wed, Feb 14, 2024 at 08:53:52AM -0800, Casey Schaufler wrote:
> On 2/14/2024 8:05 AM, Jann Horn wrote:
> > security_setselfattr() has an integer overflow bug that leads to
> > out-of-bounds access when userspace provides bogus input:
> > `lctx->ctx_len + sizeof(*lctx)` is checked against `lctx->len` (and,
> > redundantly, also against `size`), but there are no checks on
> > `lctx->ctx_len`.
> > Therefore, userspace can provide an `lsm_ctx` with `->ctx_len` set to a
> > value between `-sizeof(struct lsm_ctx)` and -1, and this bogus `->ctx_len`
> > will then be passed to an LSM module as a buffer length, causing LSM
> > modules to perform out-of-bounds accesses.
> >
> > The following reproducer will demonstrate this under ASAN (if AppArmor is
> > loaded as an LSM):
> > ```
> > #define _GNU_SOURCE
> > #include <unistd.h>
> > #include <stdint.h>
> > #include <stdlib.h>
> > #include <sys/syscall.h>
> >
> > struct lsm_ctx {
> >   uint64_t id;
> >   uint64_t flags;
> >   uint64_t len;
> >   uint64_t ctx_len;

Do we want to take the opportunity to reduce this to u32 for len and u32
for ctx_len? All FS operations are limited to INT_MAX anyway...

-Kees

-- 
Kees Cook

