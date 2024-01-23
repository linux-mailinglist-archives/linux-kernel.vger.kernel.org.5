Return-Path: <linux-kernel+bounces-34595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB978381E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405CD1C240A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C776A50A8A;
	Tue, 23 Jan 2024 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2rhQ12B"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BD3984D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705973932; cv=none; b=UlBrcneAm+eG3Axsrl1rTaEKAqwsEf1e2RMRPo6bZjnxl9qmjDt4tqheNzL/OpZ/N5sDynEVgmMql5FkMUU9HM932eKNjxLS4nade9Mbnj0Kb/CF4tJr260Dgp0loqZi3bXU1AOV3a/h2ZII5UOQ5GfpxxZa7ZShTeGGkUfcWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705973932; c=relaxed/simple;
	bh=zl4aJyrUhSHsvEk27CkHExQkZaJ7tb06Sui5CDGbx34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/tFGbdcHdNc+C6oiJwDe4oA1mCYkbjPbOE6kVtxp0MSYlc56Mr/rj83okR0HLcVVenrVFr8uWjV8Uf7BK4M5fI9SZKmrulYgHDMQoyIFZs5LECyMvnkZKMktsIYMl5zstKoy7Y3zBazcMZEuHhYORomsm79nYK63dpWwAcEOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G2rhQ12B; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dd6c3c8a0eso74099b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705973930; x=1706578730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WdGUH2BwY/NEYNguaaXC3mNHDjXcBRBu3LEUVRExTQ=;
        b=G2rhQ12BROdNyP0zm9UWTmgqEsFjOH/uQLcqchkMOTWbfq7Pew652vPJzz5jh2m0wO
         rI24nJUMLcv3Jb3wNB9w3xhpY3PBOmFZYv9y2hKsWYfJfL7AsvFEcnbr4C7rYkFAflOL
         Q6cNmmZVEpP68gbzdl1c3NVIlzXOGGHPrOsrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705973930; x=1706578730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WdGUH2BwY/NEYNguaaXC3mNHDjXcBRBu3LEUVRExTQ=;
        b=E1pI3cGHSHynz2cSzI5NF2jYiwUpCYCsoMJQeuA5qFEL93lsCSDgSf+BDbLujKxQ9Y
         dBIan8n3VmfbdlItYxvqEFWE8AiIv6ZUquscKCUhmNZ34QhIjRRxy8vNXxC8YeO4QLRN
         FpnUHddi0PqP/6kk9gtTxyQI3dzCparWCs9fIdNgcO8A49tanuEFvPJ7Od8HFvuSk0qG
         TLdTR7FgPDrIMSHmy0QFyj9nYr0Q9FvOBqRLCx34vHJEDeYdkjBF2BxQ0Wut5ZBYqPlC
         1vrgDq/rdsAJyMbaDctRsYSAO+tkhAIkFb21wcZR2cCP620kPh3Oi76hZuvVWw8JoXQO
         GMDg==
X-Gm-Message-State: AOJu0YzJRU2138rxLLLzXPhUD3Dwev+ovCFcsGfcebmNOgbKVOS/Z/rk
	Jf+H10ZpjSHvPYtxi94WcAEwNEQ5Nskj/ZHmwE1gUjiaxnS6m+85MGlrNHh8eg==
X-Google-Smtp-Source: AGHT+IHQv4+ziECX82p4oiuyPHzvjMvPIEVm9TEr6afRzbnVws9fq5VlFHPtV/DhF9QjU9jJNWCzyA==
X-Received: by 2002:a05:6a21:33a9:b0:19b:1f00:29d3 with SMTP id yy41-20020a056a2133a900b0019b1f0029d3mr3132827pzb.7.1705973930199;
        Mon, 22 Jan 2024 17:38:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090ad60f00b0028dd42b115bsm10167086pju.5.2024.01.22.17.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:38:49 -0800 (PST)
Date: Mon, 22 Jan 2024 17:38:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Vasily Averin <vasily.averin@linux.dev>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/82] ipc: Refactor intentional wrap-around calculation
Message-ID: <202401221713.3FCABC9290@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-34-keescook@chromium.org>
 <CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com>

On Mon, Jan 22, 2024 at 05:07:40PM -0800, Linus Torvalds wrote:
> First off, none of this has anything to do with -fno-strict-overflow.
> We do that, because without it gcc ends up doing various odd and
> surprising things, the same way it does with strict-aliasing.
> 
> IOW, you should think of -fno-strict-overflow as a hardening thing.
> Any optimization that depends on "this can overflow, so I can do
> anything I want" is just a dangerous optimization for the kernel.
> 
> It matches -fno-strict-aliasing and -fno-delete-null-pointer-checks,
> in other words.
> 
> And I do not understand why you mention it in the first place, since
> this code USES UNSIGNED INTEGER ARITHMETIC, and thus has absolutely
> nothing to do with that no-strict-overflow flag.

I've tried to find the right balance between not enough details and too
much. I guess I got it wrong. I go into more detail in the cover letter:
https://lore.kernel.org/linux-hardening/20240122235208.work.748-kees@kernel.org/

Basically, this isn't about -fno-strict-overflow -- that's just a wrinkle
on the compiler side. I completely agree: we have to keep the "undefined
behavior" junk as far away from the kernel as possible.

This is about disambiguating the intent of C arithmetic so we can be in
the position to instrument the kernel to catch unexpected wrap-arounds.
We can't use C++ tricks with operator overloading and the introduction
of wrapping vs trapping types, so we have to annotate things directly.

And we have sanitizers for signed, unsigned, and pointers. Hence, the
need to adjust these open-coded wrap tests. It's not about removing UB:
-fno-strict-overflow already does that. This is about let us trap
unexpected wrap-around, regardless of type.

> Stop making the world a worse place.

Rude. I'll leave that to ice storms.

-- 
Kees Cook

