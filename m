Return-Path: <linux-kernel+bounces-124106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B94891248
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DA61C237C5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136B73A1CD;
	Fri, 29 Mar 2024 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cbCphAJ/"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B039FFD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685152; cv=none; b=pd20vAUKsYJcHDeJ1xE6sGmrQnyI+sl/WUzdFgH9T339kgDR1L8Jo4zrftLYzhiiyQVNFw3JruxMgPaKl4PU1nzi75BZzHalJ0sb2eQH/Gu1HKlS+PFNx3lOeSygL2gmCm/eyObx9fo2gadF8TTzyX0bma0u/jBp3074KVFETnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685152; c=relaxed/simple;
	bh=ugCIfDN+OS9coGjwoiaf4ai/m8GH8gwnqHmA5Gon2/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAIR0kAV/eHGr3XDdxKvDHuRQ4TUIt9+PK6tcQ8TwCIcuH1af2bC9M09BCihm1/dIjoQK7SalpTGoEj6qtRE62UOn09yTRgDX4rNdrb063i0M7CHVpvt1O7qBNqn2fNdQ3byFdHn1vfXSo7jIbnL3MpLuz0g5ulIUJMIWwaLS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cbCphAJ/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e223025ccbso6262905ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711685150; x=1712289950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ChZsgQ1Elm6q3+e9M0QuKvut1I0AizgGhlSGf+ASGQ=;
        b=cbCphAJ/SIsKeYMvVlUUKVR3hb6BCeqlG8dh8614+n6QCNMHn/Ot/lm8RxZJJ8ZbCS
         l/5ABluekQarr3bXfg2Ypc0+JxbEkYda5VV5rWLVYEAyR7Fl9UnCHUz2e7uGL+7i7voh
         AE3OW9uf08XQJRxj/2rh9/sCUvntaH3rIHevo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685150; x=1712289950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ChZsgQ1Elm6q3+e9M0QuKvut1I0AizgGhlSGf+ASGQ=;
        b=R8qCBjd8pArvKoOeO0nY8cskADgaddwqgfu2yoH1qjup1k7SEJwkIv5ybg7zHTUZ8o
         Jxe2jhAixGVw6sRh+ec8tNJMqcK3XVfuMT9rFnv9mLCJ0A2sq6cjHm8VDnU9syLtTdck
         a04LK5I8zuHEMw8ab+51MGPmbQ6a2r1VbclUnPDzZO0kBdxxtb063YohqfScv2/TiHWj
         UoSRcFsSUMXR/ex95g+N6+YNGE8APvwlTpHVyJfF4iwfmlH+gmro2m8U3yoQLGNb1Go3
         oVujBt8ZkAX2aoPEjsJbWMMnkG8pIzbRFCiA0qqwPkCXKAuUrQ0btiqGiXstawCfrm4+
         uGLg==
X-Forwarded-Encrypted: i=1; AJvYcCUoY/NHClKpYLsajJg1YZP/l5OhDD7v4ZBXHUuL4pz64uVIWljz2eT2//1d+R/OF7/MXPCWpoDheJlLhQ0hOkHbBnBSzmNSZNJnB+je
X-Gm-Message-State: AOJu0YxztEu/F7ImaouGHmjhkaKEQpzCp8GhXgKYefcH7Z2DQjOB/y10
	pZcNlTnffafFiFIFSJ8K2wagYxo0hDdgArXGvthlbpO6urijuAkM37ADLUppQA==
X-Google-Smtp-Source: AGHT+IHz/UtiavMzvnaxiQB62DEnni3iPoJJtX7YuCgTzgK2VTzAXvvO9TtTSynjiOUlcZ2jj/z94A==
X-Received: by 2002:a17:902:ec8f:b0:1e0:bddf:7ed0 with SMTP id x15-20020a170902ec8f00b001e0bddf7ed0mr1612364plg.27.1711685150349;
        Thu, 28 Mar 2024 21:05:50 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b001e211a291d6sm2465575plg.260.2024.03.28.21.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:05:49 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:05:49 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Fei Li <fei1.li@intel.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: replace deprecated strncpy with strscpy
Message-ID: <202403282105.321DAF619B@keescook>
References: <20240320-strncpy-drivers-virt-acrn-ioreq-c-v1-1-db6996770341@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-strncpy-drivers-virt-acrn-ioreq-c-v1-1-db6996770341@google.com>

On Wed, Mar 20, 2024 at 11:27:09PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We can see that client->name should be NUL-terminated based on its usage
> with a %s C-string format specifier.
> |	client->thread = kthread_run(ioreq_task, client, "VM%u-%s",
> |					client->vm->vmid, client->name);
> 
> NUL-padding is not required as client is already zero-allocated:
> |	client = kzalloc(sizeof(*client), GFP_KERNEL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Note that this patch relies on the _new_ 2-argument version of strscpy()
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

