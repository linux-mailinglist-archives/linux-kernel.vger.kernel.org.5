Return-Path: <linux-kernel+bounces-89300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2486EDF3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C64EB24CFA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B417469;
	Sat,  2 Mar 2024 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YgjFnc9G"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ACD6FCA
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709344020; cv=none; b=G//dFTIuQD9x6/EwKzPw0I5AYiTxmhXzxKzCVgia/2r8aekj1D4y6WXOiTarbvGm4FzcGtpIufMHKMJTIwZI3ud1rHGDN+on952KjtlWnqzvgJt/jbLZnRwj239JK4rF78PHBJHTieW9WZz7xp6/wRh5tabWYc2TMxdmSp57UDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709344020; c=relaxed/simple;
	bh=f5A0jR9T6V8+dxH3iXe71oqdvNYD79yPpc1mbD2oH6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctJOHu2CdkwcN8r4CUX++Q8ZnjUAFutfn2hTIeIWY8pdXqKKbJ3OWxnaoD1eHhcv/erbwwqAQdyYRfWv5EZ+CoQqrOn67/kuoRF7/dXiF8zx1m4xnRGs1a2WhKcS420wKkgqzOcLIDgnRqSqipNlIV9tCxkrRDSPIwSpf1nXUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YgjFnc9G; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e56da425b5so2158857b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709344018; x=1709948818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bn1sv4Ad9NlF+2i+d+RVjC+t58fUwFDzcSAxCmkVqVc=;
        b=YgjFnc9G2i21CmrASd7cTvULfQqJ5lnyj2K5tZNA6x2L8192PjJDp0ZMoeMmuEmt92
         FTem8v5JFpoa+r0em6sFzVcK1t55mdCLDQa8y7vlYtc0mg59UepoyuNZVNBnS0NcnkKp
         HXqYr1yhplYHgACoJPo3YON/n9oMGuad7ZHhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709344018; x=1709948818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bn1sv4Ad9NlF+2i+d+RVjC+t58fUwFDzcSAxCmkVqVc=;
        b=v6OsVRxtUW6y+bA7NH+87c/EyY0ciirB2+/BDI53hZo9+j6FRnhTZV2E9hzy9ghoRx
         MlFUzMisUAgvB8oSgt7I1NZ4K52uCvSQ+1QPIrn48+wCe3ZrbyTqqDIizyesWHmjYWNQ
         FORI9GnEXjLmiYiad1w8FCknO5VrYA4ix4u2J7Ni3LkH+ipZJ4O0gzs5mcaw3UHsJ0Lo
         unjNRgVbUHF1N+BujqM4iSQgLOtEfCTSPYv5TU7eQgAm3osQSM/kvSpa764oD6a6ivyi
         YYrg2flWqR0Oz1W4D/nY1C0ZN6619NefoVuekS9THbrtpRv03pKqMso+8txeS40T6BaM
         9+SA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Ox/oZUedZhjo30L2dZDFeHPLyOSfeEc+jJGp1gs6ej2vjDjaTzq6cL89U2lqL0XsHsUJpHb4FjKBttSWFzKYEIt6gmA3kVXvIWQ2
X-Gm-Message-State: AOJu0Yywwx8/lokfYdLF9E1dnB0utk26Fej+HNMvDdaQNALcNxwlof9i
	xfTfP5nz6/5xbMiXZFFwIEjdS4MswjpRasF+0fslq7KgMCtQr0a+zbQnfJdeDw==
X-Google-Smtp-Source: AGHT+IEaaYGyDdKa4lpimUB+90/393TQuYJQkcqWu1nG5sVyhNG8SR4vBzQBf2k5Ik2uH9QuLqlqJA==
X-Received: by 2002:a05:6a00:188b:b0:6e5:9698:7cb9 with SMTP id x11-20020a056a00188b00b006e596987cb9mr4448007pfh.4.1709344018139;
        Fri, 01 Mar 2024 17:46:58 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a28-20020a62d41c000000b006e555b439c7sm3709005pfh.4.2024.03.01.17.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:46:56 -0800 (PST)
Date: Fri, 1 Mar 2024 17:46:55 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] compiler.h: Explain how __is_constexpr() works
Message-ID: <202403011745.C9851C46@keescook>
References: <20240301044428.work.411-kees@kernel.org>
 <ZeJ-LAkSxwBlr9_v@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeJ-LAkSxwBlr9_v@surfacebook.localdomain>

On Sat, Mar 02, 2024 at 03:17:32AM +0200, Andy Shevchenko wrote:
> Thu, Feb 29, 2024 at 08:44:37PM -0800, Kees Cook kirjoitti:
> > The __is_constexpr() macro is dark magic. Shed some light on it with
> > a comment to explain how and why it works.
> 
> I was under impression that somebody did it already once and it fell through
> cracks when has been moved (?) to compiler.h.

I tried to do it before (see the v1).

> 
> Ah, now I see it, https://lore.kernel.org/all/YKeghxRY4FeOKuwb@smile.fi.intel.com/.
> It was asked, but till now never fulfilled (maybe Reported-by:/Closes: tag?).

Sure! akpm was hardly the first to ask about it, but yeah, makes for
some good tags.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Closes: https://lore.kernel.org/all/20210520134112.ee15f156f1b7dbd3d8f16471@linux-foundation.org/

:)

> And explanation before was given here:
> https://stackoverflow.com/questions/49481217/linux-kernels-is-constexpr-macro.

Sure, but I wanted something that lived with the macro and everyone was
happy with the details.

-Kees

-- 
Kees Cook

