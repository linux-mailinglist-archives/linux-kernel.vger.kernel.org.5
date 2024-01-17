Return-Path: <linux-kernel+bounces-29437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C979830E37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E93B235F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BC325108;
	Wed, 17 Jan 2024 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UXnHuZU1"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0281D2556D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524674; cv=none; b=qnHSFlvgjJRMDUv7YXG97Z/4e6O9+n70Znis/eEd/rtROxeNPle8BWyqZzZH9gjqtPoUVfSaHAHDexkGzGtUa0fdZ8QS2iHn8LPPlL2wPgtBvYaCM56HrNHEN6H8RADalIif+SQTKzJDvy0Ue3nJJLIB6x2dSr/h+Tt28AIy6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524674; c=relaxed/simple;
	bh=KEO+rHwBc2shj6H6ATYkN4mc8w4293/sNHJG3mL1qhA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=N+miv6KxQIj0VR8DKwJY65UOz8d0sEly2rUBXjNsr/o2JDBuSWdj00K+yqeZRusA1/Mku8++IIrz3XTQVOSGQ0il6BaQhkyBGpsAYGTd9Q5MMnUp8r7gNlAU6+myKdrfnHaNUR+qf/fD/7btJDicQHaujMV+TGk2EhYlhbEB7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UXnHuZU1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d5f4c9c2a6so15697625ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705524671; x=1706129471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kx/TANifPOtY4pPL6VukQfe4dLtrXERVJTf79pfe/6Q=;
        b=UXnHuZU1FeBYinM64Q/OMb5UBevLFcUxkhPsMjKqsByNfezM6FioGUaCGtUV/7YNIw
         6kAspVzNbrz6aM/w+ExFTe3FK8FpF1HDYbPzYfmGThkU4QmyDITK2kh/2yRzcVPqbKwU
         Iibv2xBxxgBfM8bGgrs2ivA1DKc9vPHSXUong=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705524671; x=1706129471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kx/TANifPOtY4pPL6VukQfe4dLtrXERVJTf79pfe/6Q=;
        b=gd19wgsYF+gkGbQVWjGxE7T2dV1cWfymR1PiSEllQYFdSpaTinr1fu9GumJx/og/SL
         KkfNL6V54d4ajs6TI/PiQqgf5YoB3+fFtD8i6Kf/fhFRTl4ttEbm5E8ZKrfJ4OYXi1FE
         UORon/9uudQZxj6sv9xkH7Jgp9Sy3pCVCbfh1Qxs7Eo+ptfbnEwfhu0Xgh9zSTtg+EZ5
         pjG5/ifLa4GADZGeVM3fq+1DFiM18P0/FsseQXGKwhILBQKWKto+hOl2DYYGMVFjO6Lf
         scd2nMpwk+FudO9FYRnmZexYE+ufQENqPgH08+RAzkZSW8nq8wTsfzxOKOBmt/7oSAVf
         u+sQ==
X-Gm-Message-State: AOJu0Yw4w7UxK/8YhB/APn6A/9AwXhGzBrN6fyNucxbf9r1eS7pUqWOa
	5OFyhAIjmgI+fVjvQscBdffssVbIsIru
X-Google-Smtp-Source: AGHT+IFBazjvV2lR/bEVLRw5mnikVJ9ZApUSi3AOIFGvEer5uS7MyrKkE1kyrimbiHD2zhHX4671mA==
X-Received: by 2002:a17:902:dacc:b0:1d4:69a5:edbb with SMTP id q12-20020a170902dacc00b001d469a5edbbmr11788701plx.48.1705524671293;
        Wed, 17 Jan 2024 12:51:11 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id le4-20020a170902fb0400b001d6f2775570sm76695plb.209.2024.01.17.12.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 12:51:10 -0800 (PST)
Date: Wed, 17 Jan 2024 12:51:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Lu Yao <yaolu@kylinos.cn>, linux-hardening@vger.kernel.org,
	jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lsm: Resolve compiling 'security.c' error
Message-ID: <202401171236.5175FA9FA9@keescook>
References: <20240117014541.8887-1-yaolu@kylinos.cn>
 <CAHC9VhSs6bxXFCAhw7i5cN=iZtuG3-E8xDBRjyGsop=BrhbmSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSs6bxXFCAhw7i5cN=iZtuG3-E8xDBRjyGsop=BrhbmSw@mail.gmail.com>

On Wed, Jan 17, 2024 at 09:32:33AM -0500, Paul Moore wrote:
> On Tue, Jan 16, 2024 at 8:46 PM Lu Yao <yaolu@kylinos.cn> wrote:
> >
> > The following error log is displayed during the current compilation
> >   > 'security/security.c:810:2: error: ‘memcpy’ offset 32 is
> >   > out of the bounds [0, 0] [-Werror=array-bounds]'
> >
> > GCC version is '10.3.0 (Ubuntu 10.3.0-1ubuntu1~18.04~1)'

As an aside, Ubuntu 18.04 went out of support back in June 2023, and
never officially supported gcc 10:
https://launchpad.net/ubuntu/+source/gcc-10

That said, I still see this error with gcc 10.5 on supported Ubuntu
releases. I'm surprised this is the first time I've seen this error!

> >
> > Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> > ---
> >  security/security.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I'm adding the linux-hardening folks to the to To: line as this has
> now come up multiple times and my best guess is that this is an issue
> with the struct_size() macro, compiler annotations, or something
> similar and I suspect they are the experts in that area.  My
> understanding is that using the struct_size() macro is preferable to
> open coding the math, as this patch does, but if we have to do
> something like this to silence the warnings, that's okay with me.
> 
> So linux-hardening folks, what do you say?

This is a GCC bug -- it thinks nctx_len could be 0, so it gets mad about
the array bounds.

> 
> > diff --git a/security/security.c b/security/security.c
> > index 0144a98d3712..37168f6bee25 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -792,7 +792,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
> >         size_t nctx_len;
> >         int rc = 0;
> >
> > -       nctx_len = ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *));
> > +       nctx_len = ALIGN(sizeof(struct lsm_ctx) + val_len, sizeof(void *));
> >         if (nctx_len > *uctx_len) {
> >                 rc = -E2BIG;
> >                 goto out;

Please don't do this -- it regresses the efforts to make sure we can
never wrap the math on here. We need to pick one of these two diffs
instead. The first disables -Warray-bounds for GCC 10.* also (since we
keep having false positives). The latter silences this 1 particular
case by explicitly checking nctx_len for 0:

diff --git a/init/Kconfig b/init/Kconfig
index 8d4e836e1b6b..af4833430aca 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -874,7 +874,7 @@ config GCC11_NO_ARRAY_BOUNDS
 
 config CC_NO_ARRAY_BOUNDS
 	bool
-	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC11_NO_ARRAY_BOUNDS
+	default y if CC_IS_GCC && GCC_VERSION >= 100000 && GCC11_NO_ARRAY_BOUNDS
 
 # Currently, disable -Wstringop-overflow for GCC 11, globally.
 config GCC11_NO_STRINGOP_OVERFLOW



diff --git a/security/security.c b/security/security.c
index 0144a98d3712..ab403136958f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -793,7 +793,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
 	int rc = 0;
 
 	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *));
-	if (nctx_len > *uctx_len) {
+	if (nctx_len == 0 || nctx_len > *uctx_len) {
 		rc = -E2BIG;
 		goto out;
 	}

-- 
Kees Cook

