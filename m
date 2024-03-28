Return-Path: <linux-kernel+bounces-123702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D39890CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D0D1C21EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A822913B5A4;
	Thu, 28 Mar 2024 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D87S6gOX"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084D13AA54
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663566; cv=none; b=W9s+KdfKxMxBvdcKJ9F+WTJUBUrfOKj5eBw1znaIYBWG+5byhGmpdwFHi6Z991uA+1TjGI6wLrau6p6+ofKFmcUOTm8t7HhpzieKUF8nXqqeV4xnrquznHH0dN/YRx4KwhGGjHyFvxvUn0MQcuYYByCiIaALoEgCivyCID3q4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663566; c=relaxed/simple;
	bh=BMVe5w6WOEXTcXCCqr7XwIN6WHhygsRAlRjfU3X7bhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCAy1rzV1T7jx21SdMvxnMDN6IBZeOn1dhwYfkxcgYQ7AcJLldqicPxvDYASH/kB6K1Lbtp0OWF5bUHxq9yWwesQhRvZgc16XY/X7IT2D51z3oJQOaYh18e/zr3dTadtHGqt2G9LX79XdNDoyRX7KtaYjJ+FiHgj3Q2WOYIk5YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D87S6gOX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e782e955adso1371998b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711663564; x=1712268364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ulFT2YtYHRUyQ2m0L9C0dai4nEzKGQhAD0pMYhyoW8=;
        b=D87S6gOX1X8YYp1S+39cRqkjIoufWeL7TSIWKdYownLn/P0FLhPF43SGJ/9hMeBd32
         MkKwSzcJCEL6sudRqtwG94OTZJWRwg4j5pvbVH7O+w+6MufzwOS8RMaXLeZeukxJRoKB
         PEu1p+qG97hMrUpvyuVGRSZFY/gPahbDogvXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663564; x=1712268364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ulFT2YtYHRUyQ2m0L9C0dai4nEzKGQhAD0pMYhyoW8=;
        b=F1utYEa5qa+Zn2GUTZ+IEdstx0O6a23RMyx98UIsjcaPpnfttsT725S3Jr+vH5R0lT
         ZdMBg2Mtg8ti8FBl42eugoTtJc+ywohnDyKYOQgFIvwIJXKroHoKsDDkmbU1DfcuC8Dw
         44uVPmQj4/9wp7KLnPUdDzxLMgeE41WqbNgtuifM+4wMM2XlzK6OR2IcLGIiLCoW0UzB
         vpovFPmV6bWz/OrgaFs0Zzi2fQ4q8dx5eLej6m/dNSk8BWVutCclTWPtNQeUROZv7BQ3
         3Qo8HgoX1mbRcHY91a0rBQFJH6ZqPZrV2vtfrjqORXiYdUwc4K0r+j8XlTcqNNKhjnqL
         WA4w==
X-Forwarded-Encrypted: i=1; AJvYcCXFMAZhaHdhIcZ2+JLFufiwYrACXTCmKq2XVFH3X0hbVhnp9eSGAmuXIWCZRhCGlb4W8j8GY/1PsO6kVQ7hpxxDsPjtLUOxHJJUiAYB
X-Gm-Message-State: AOJu0YxIKxF0K+Qx48uDyECWE+ESbbXIXPkA7s64bh0fehO3YykFu0mw
	r4elMNmW4cFQHVAfhM+1h21WN2+GmFKcJWkISZ/pGUzRCGmkbjQ6HdefOCyh3Q==
X-Google-Smtp-Source: AGHT+IHMcpSW028XxTQvmxpihDQRd+NUVdxm2dqXDSvZsx+g48XAeL0IeezbbE3UA8t48l295BDITQ==
X-Received: by 2002:a05:6a00:a90:b0:6ea:7647:282d with SMTP id b16-20020a056a000a9000b006ea7647282dmr715662pfl.29.1711663564040;
        Thu, 28 Mar 2024 15:06:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n19-20020aa78a53000000b006e6c16179dbsm1876305pfa.24.2024.03.28.15.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:06:03 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:06:03 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] reiserfs: replace deprecated strncpy with scnprintf
Message-ID: <202403281505.C5C8691@keescook>
References: <20240328-strncpy-fs-reiserfs-item_ops-c-v1-1-2dab6d22a996@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-strncpy-fs-reiserfs-item_ops-c-v1-1-2dab6d22a996@google.com>

On Thu, Mar 28, 2024 at 09:16:52PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Our goal here is to get @namebuf populated with @name's contents but
> surrounded with quotes. There is some careful handling done to ensure we
> properly truncate @name so that we have room for a literal quote as well
> as a NUL-term. All this careful handling can be done with scnprintf
> using the dynamic string width specifier %.*s which allows us to pass in
> the max size for a source string. Doing this, we can put literal quotes
> in our format specifier and ensure @name is truncated to fit inbetween
> these quotes (-3 is from 2 quotes + 1 NUL-byte).
> 
> All in all, we get to remove a deprecated use of strncpy and clean up
> this code nicely!
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, I like the use of %.*s here. This is much more clear now I think.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

