Return-Path: <linux-kernel+bounces-72625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D346685B661
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BCD1F2302C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76635FEEA;
	Tue, 20 Feb 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSp5ACwL"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F695FDCF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419372; cv=none; b=tHNBQ7hvK6/vf8Hcl+1OIGYn/s+GjfDfzTHGjxdU9SnFZixez2tFtnFsB7F51pRwlyxmcHWK/sMR4FErT0G8JtLI822y0mdngvaarLQsBUd271fiyNKUVkRMqWSG5SvQhRZrRjAPsh8QgLwDD6L4LUlKTf0lwhwe5DCDwGeGIIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419372; c=relaxed/simple;
	bh=T/zllyOevXJDum5KZy0NntbSTaItxVfmTD9BU1g+lvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wpl+Nf4WtI/N+Wy3rtT0hMX7z0jmeMdF/jmzfmdnIRJSuZIbvdgtqQZrlxB2RXz97XiBzzYju18sUaA23M8z1L9bVuMlW7S1gSnWzyu4d5gaXKlowjqNZDw1RYOKmQcZzxVurUV8huo+z124qdO7OXOOyNqBVktRVRnRiVGuPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSp5ACwL; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512be6fda52so1529435e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708419368; x=1709024168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwY7zr2mxzz4q2qnfl1oOBmuQlvU/nD1U8borvNb0RY=;
        b=PSp5ACwLAG6KLh3NqJRiq4hU/hpKbGj53t+dtdmiv8Fr446sv0NRPeKbJk+BO1A17v
         lTYWM23MW58xdxXe9COxLatn7j0xtbOpHCQvYl1zOVq201tu7JJyhL6ySkrO11eh2WEQ
         xxgur6YhkNJq493sMNtYo4lB/ciutSd9wn1qGE4Y/jqEop9DzZou3usAp4NjPXOJg0BK
         0TR02kcNl5CkA6IO+GO1jb/K8DfwsRVqW1IsxxkfeAPZm7eRanlLtfd803U6AzlIN7dx
         m5ynbPYd2vaGZNrJSDRxh3/DO6g+mAzSieH3v7hatmgp742x+fB5t6jAEnVlwlq2Y05X
         +kzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419368; x=1709024168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwY7zr2mxzz4q2qnfl1oOBmuQlvU/nD1U8borvNb0RY=;
        b=UWUKctxUZXdYCaYrE8FI0RZuc+u++CT07iECL5HzD0FRMDUWfCB3mES/GLn8DFA/FD
         oIhcvDEOOMU7eg6GtElzcAFGhnJdZ4NnEjqO25Hto0YMchzKu4oe4o1DJnBtIRFzpkZf
         ydQGyb0wbTrrQWxMGzsuEveQmOhgc9R245CVLVES7Mry0y7Lb7VtiNnpncnV1qj1b6hd
         LtQyZrhoCpzEDt7X+/vqtKk6Kgzbxa9TTdBzsrGE/Y4eSUxkvISyCVs+rCGZhn1YgpyU
         piXNIoTQNyJJBfdIN1ZnlYgOvwbAsUjiy4YyFUg2rxT92SUN+WcCOko2yb+Ucd6SrhSW
         Qk7A==
X-Gm-Message-State: AOJu0YwMS8gjjZKbhCfYFpfd6T+74xEA77R54OrIFnlXmuzq9LiHPVNj
	ztIurWpgrBw3Hx+m2Z9mzdJUHV0w4dBdmkgaZ2O4V0PW1Da3q/EkldlTYBbDytU=
X-Google-Smtp-Source: AGHT+IEtXECJnCuUkZLydj+77qyizHwGAj8jBq275plbOyFDsgk8/RM8aKzBV5GCaepxuMmIUYnc5A==
X-Received: by 2002:ac2:4f8a:0:b0:511:7259:370d with SMTP id z10-20020ac24f8a000000b005117259370dmr8396951lfs.33.1708419367928;
        Tue, 20 Feb 2024 00:56:07 -0800 (PST)
Received: from gmail.com (1F2EF578.nat.pool.telekom.hu. [31.46.245.120])
        by smtp.gmail.com with ESMTPSA id tb21-20020a1709078b9500b00a3e51df2280sm2774123ejc.223.2024.02.20.00.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 00:56:07 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 20 Feb 2024 09:56:05 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, boqun.feng@gmail.com,
	frederic@kernel.org, joel@joelfernandes.org,
	neeraj.iitr10@gmail.com, nphamcs@gmail.com, paulmck@kernel.org,
	peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v2] locking/atomic: scripts: clarify ordering of
 conditional atomics
Message-ID: <ZdRpJaOuyAafDGZY@gmail.com>
References: <20240209124010.2096198-1-mark.rutland@arm.com>
 <ZdNFfoN6V3qj3-FM@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdNFfoN6V3qj3-FM@FVFF77S0Q05N>


* Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Thomas/Ingo/Boris,
> 
> Atomic API patches normally go via tip locking/core, would one of you be 
> happy to queue this up? Normally I'd ask Peter.
> 
> If you'd prefer that I resend and/or fixup anything, please let me know!

Applied, thanks!

	Ingo

