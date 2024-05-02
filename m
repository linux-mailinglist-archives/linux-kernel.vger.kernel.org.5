Return-Path: <linux-kernel+bounces-167027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F238BA393
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4210D2810CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1791D1C683;
	Thu,  2 May 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lzVnlRqx"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104294779D
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690658; cv=none; b=slcmTTyPxVDixvHR67IqR54+2hvUiO9Tg9dFx36A1nz9XilDC2b1tV7V5UsV4Fs1OneoJpBiVMM9qd1jk5zIb+CT/KNbDrcp/cd8hqlMgNr44XKOC/oIVeo+pWvJOoGVYe5SQhUU3/nvhKFUo1nWaEa76qDTZ+MJ5F5k93RzYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690658; c=relaxed/simple;
	bh=d6YsudNt7ErlgEKi50Pmqygmqv6ZRUJ8QlgoCBZeXxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzLnUjd9R37ysc8aeIULQ1A5saegCtCnk3FFI1yxpYQOREv/Bbm5LhwCSn8F6K982H4+SfafhxwqTC7k6yXpqgWOIEFgm8OcoOr+2m+fdtDKSZeYkYr0RjSQX9yBxpzVKAB9TXkRZYjVFOnHCigLMZ5R16opsFPu0RRtgGO4Ye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lzVnlRqx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f4472561f1so642703b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714690656; x=1715295456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7utRIDihwTrDtNFq4O/sCtJGTa8ljX+sdlBJo2Fu0o=;
        b=lzVnlRqxECX6Bk7BarDYFFid6Pr1usg2qymXbV66PwPXKPuNvHpZe6I1gWAEqjU4r6
         lmnWEm/D0+8ofTHJiSRE6eUejNtLEeSEbBy7i5dyPzFYXd3W4GdGuath8djEwJE+D+oa
         U0Tc3ibu+ju7EKLh9fSmIHelHUySKJosBJgGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690656; x=1715295456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7utRIDihwTrDtNFq4O/sCtJGTa8ljX+sdlBJo2Fu0o=;
        b=nmj+G3i9wxxO46+5iOUz+IeYx8SeXDEBDSjNIF3K5lxpJ7NEhqWhoTYKwRYwGvPuo6
         iZsmI4LiYNVCApwtDkEXIiEbBObiV2UmW/6mdSsSelrn0fmK+LTFb7QPuCJrXVxqzNEB
         LUU4Yj/ffbt4PjQH2oXBuf3NGj/poSWq2/A5Hv7c45c5NR9yImLeDhpDRmb/87cLCJIg
         ewFluQQereqkiZEmp82I1+7Piy5vSgere0AHty16YRVO/RhPoSHNzyckFex5Y3rLVPCu
         KR8oeGL3QdtXTe553bTQbmcZ7yPVFF9V8Ud+vXV2IwRiDSyAQd/O2U4UHiL7/FEVbapy
         E54Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvar/JG5a3O9GTVXpbGpIemExc5vw3+L0M0wJvS4/1wOUWNCvWf5UrX80IYfIFXvkbAcFLFGKVnZNInlYUpKhx1zvew0OtKjGeTb7E
X-Gm-Message-State: AOJu0YykPfv0QQVHhhWpMyPOtjkMOWFS6fBhzsERjQDq7QqgyCHjMdqF
	vuFRBagBWd+Ja77RsdhEx0CDMOro9EzvhkkzVnQed9j27jLZ2WLEk9+NluwHGw==
X-Google-Smtp-Source: AGHT+IHeipZnVfdal9PG/RbB6O/kgz3jUCJHRq4M3tw+Q+8pHR5xS0qgblTNyIpoX9VYxPinBrPagg==
X-Received: by 2002:a05:6a20:4327:b0:1ad:999b:de34 with SMTP id h39-20020a056a20432700b001ad999bde34mr1584724pzk.38.1714690656398;
        Thu, 02 May 2024 15:57:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p8-20020a056a000a0800b006ecc6c1c67asm1801341pfh.215.2024.05.02.15.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:57:35 -0700 (PDT)
Date: Thu, 2 May 2024 15:57:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Joe Perches <joe@perches.com>
Cc: Justin Stitt <justinstitt@google.com>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	linux-hardening@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v6] checkpatch: add check for snprintf to scnprintf
Message-ID: <202405021556.374C2E8@keescook>
References: <20240429-snprintf-checkpatch-v6-1-354c62c88290@google.com>
 <202404291249.078D924@keescook>
 <aacd7c3a5ad5bb4df71ec5dd107ef12b6ebf4079.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacd7c3a5ad5bb4df71ec5dd107ef12b6ebf4079.camel@perches.com>

On Mon, Apr 29, 2024 at 08:21:49PM -0700, Joe Perches wrote:
> On Mon, 2024-04-29 at 12:49 -0700, Kees Cook wrote:
> > On Mon, Apr 29, 2024 at 06:39:28PM +0000, Justin Stitt wrote:
> > > I am going to quote Lee Jones who has been doing some snprintf ->
> > > scnprintf refactorings:
> > > 
> > > "There is a general misunderstanding amongst engineers that
> > > {v}snprintf() returns the length of the data *actually* encoded into the
> > > destination array.  However, as per the C99 standard {v}snprintf()
> > > really returns the length of the data that *would have been* written if
> > > there were enough space for it.  This misunderstanding has led to
> > > buffer-overruns in the past.  It's generally considered safer to use the
> > > {v}scnprintf() variants in their place (or even sprintf() in simple
> > > cases).  So let's do that."
> > > 
> > > To help prevent new instances of snprintf() from popping up, let's add a
> > > check to checkpatch.pl.
> > > 
> > > Suggested-by: Finn Thain <fthain@linux-m68k.org>
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > 
> > Thanks!
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> 
> $ git grep -P '\b((v|)snprintf)\s*\(' | wc -l
> 7745
> $ git grep -P '(?:return\s+|=\s*)\b((v|)snprintf)\s*\(' | wc -l
> 1626
> 
> Given there are ~5000 uses of these that don't care
> whether or not it's snprintf or scnprintf, I think this
> is not great.

But let's not add more of either case. :)

> I'd much rather make sure the return value of the call
> is used before suggesting an alternative.
> 
> $ git grep  -P '\b((v|)snprintf)\s*\(.*PAGE_SIZE' | wc -l
> 515
> 
> And about 1/3 of these snprintf calls are for sysfs style
> output that ideally would be converted to sysfs_emit or
> sysfs_emit_at instead.

Detecting that we're in the right place for sysfs_emit seems out of
scope for here, but maybe it should be more clearly called out by the
contents at the reported URL?

-- 
Kees Cook

