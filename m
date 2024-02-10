Return-Path: <linux-kernel+bounces-60295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6A68502D3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 948F5B2443B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3261EF19;
	Sat, 10 Feb 2024 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d6LUHLFC"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498596AB7
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548170; cv=none; b=bfuJmiraZkK9aNo9K04itouw1y6FOAvsiCKiBgyaIAyRoFvc5xOEwBkzwvPDwkEdzIp8feOASIqyNqHmPr1QwMiLIWCJ4DMV1j5DKURXQNxTCCe0e/RQJpb67KI+u2ijZ9MaWKCqTJvthE/crFW81JSDX1YUuJOTugiMgE+aMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548170; c=relaxed/simple;
	bh=NVSOZpQjmNZbvBbytVbKbYZTTj5KexVg9+EBMGPo8iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNbH5vYVITgBcExlytfOua3UV0fGXtyz+vNVvVdS5Q0fUL7t0iLEQLrB904TZ7BFVAzWEQQ3Rm0uYXcgufCQY7xKCH9irrzJkrfwKfCfDDEwJ+ZUrZJifW2xXiIXfd2PESW60cDr0UCpCT0yIMfI0mUbRuFAxKkfCreEc7KOuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d6LUHLFC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7881b1843so15469525ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 22:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548167; x=1708152967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lqdmVzIJwt0NdDv6XcYQYzL0U+gQtOwIYPw83OVL8g=;
        b=d6LUHLFC9vd9PmKcO4dhOkt3K3zU5yRuw1C2EGhxy8e34ZJvfR3DP45U8XxFFeBLBZ
         aPYbZ7p6Qs/h0PaMi4d1K0k/1hSrXIXnzMtnp6yT5LIfl6E82K4hb53oMaFjCnj6BmNs
         vF5D7w7352R6gQK4GsaHgyDD14Aqn9iKzPOpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548167; x=1708152967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lqdmVzIJwt0NdDv6XcYQYzL0U+gQtOwIYPw83OVL8g=;
        b=M4JyiJTuDfUhLPkCGz1UhiBINuUzNdLsl8k3rfEbL8a/rIFNlk8rDCZar19zJUI8Cu
         Cc/J/pjZ1MDAR2gQW1nNJuaiO04HiEJALDH6gzHkSte4ybZxUhNj/89oxdhKRhtZVtp1
         tXnW3zmr4x0V+j7Cp3TGBA9Rij2JxkjNpzA5AangS4G1ie5yTc6xbmBWaJ6gqTWp9C35
         CrGAqBTqOOBHT1MCLncZS76bfvPe3zlJotSplCJBW7AZ13XPLoMHGj983/QftrUcxjAB
         xAjaswfZ+0fdx0Y6uUm+g5Jj7QNbT8zhLULoaEmxxrwk9bZEk9eGHTWFzJKLqswim8il
         g97g==
X-Gm-Message-State: AOJu0Yw0YMHnQBsGRZTqPnqB5Q1jQxNrQlxAxErleWhqJSJUnbpynxe9
	H+P4iHi7t6p4fjq0qN6H5gm2lMFiwk9G54XBZnzZ+SNtts/24o3VSBE8srRQ8A==
X-Google-Smtp-Source: AGHT+IG8Uvto3IXh7IM+fA+MZ+Inj6FlHN977ejGAfyv7OajcSC0CUdI70yPsphZgCB7gunDHexmGA==
X-Received: by 2002:a17:902:f809:b0:1d9:7729:2a6f with SMTP id ix9-20020a170902f80900b001d977292a6fmr1497467plb.61.1707548167643;
        Fri, 09 Feb 2024 22:56:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHNFwtwo2sj5Hgq9iT4SeharaFb3De5jNs2sKKLiRzhEOcJt9l0HQWoxTSJBuBbvBTHHP+w5FoKVroZZDidVlFmiko3Q3RPTYxPY8x9vc974PFN7dkbXledwzEmaGTCFNB1mAzMCu+0ZatG2sAA/J08eE57foSNwEJSd716ibUiYWvTqrzGTU9I8XM+zcpoHD/fw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jz15-20020a170903430f00b001d9a40f50c4sm2491642plb.301.2024.02.09.22.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 22:56:06 -0800 (PST)
Date: Fri, 9 Feb 2024 22:56:06 -0800
From: Kees Cook <keescook@chromium.org>
To: tools@kernel.org, Joe Perches <joe@perches.com>
Cc: Lee Jones <lee@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: .mailmap support for removals (was Re: [PATCH 00/10] scsi: Replace
 {v}snprintf() variants with safer alternatives)
Message-ID: <202402092252.0A0A59A@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <c9129b08-50fb-4371-aa05-6f6c7cd7acfa@acm.org>
 <20240208174912.GZ689448@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208174912.GZ689448@google.com>

On Thu, Feb 08, 2024 at 05:49:12PM +0000, Lee Jones wrote:
> On Thu, 08 Feb 2024, Bart Van Assche wrote:
> 
> > On 2/8/24 00:44, Lee Jones wrote:
> > > Cc: Andre Hedrick <andre@suse.com>
> > 
> > Please take a look at https://lwn.net/Articles/508222/.
> 
> get_maintainer.pl pulled it from here:
> 
> https://github.com/torvalds/linux/blob/master/drivers/scsi/3w-xxxx.c#L11

Oh. Hm. It seems "git check-mailmap" (and get_maintainers.pl) don't
support a way to remove an email address -- only redirect it.

It seems we may want to support "don't use this email address" for more
than just the currently observed rationale. I don't have any good
suggestions for what the format should look like? Perhaps:

"" <address-to-remove@example.com>

?

-- 
Kees Cook

