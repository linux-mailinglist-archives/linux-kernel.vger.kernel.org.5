Return-Path: <linux-kernel+bounces-56355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7274284C925
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F57F1F271D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F5117C76;
	Wed,  7 Feb 2024 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RNBtpq1M"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254FF17BCF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303860; cv=none; b=me9cHlf0mglNXEpY9VVTSKZ2oFzp8FDSu+74LQKeQUF38NqpTZswih5nN6c5WgF+F/QBxLGaqaynKWd4FH9WNjz7B552af7glj0d+ervnjzYG5gNAKPVIbSQgih+ViwdAY0GYCOt/BMg8FLTApNQbUyyDCKlvkPh6s2pR86Ob+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303860; c=relaxed/simple;
	bh=CgYyRmc6Z59PnXZh+5ZKWs0+Cbn8qJv1WXKrOV0Or9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sk91bdRtvEr9Xf447UJlKnqXdGbu8xRiXgX1TagpOjzdwiAO9T1QNuyx+gsO9cXA/+jZrgFrcA5L08CHRIZdisvpMBWKXQvERJPgQWNr8yqmhU0SmI3vsxV7fVycRplBfYN+1y7ImovNlkb6NRBIVnJeFena/TVrqHYIWALbbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RNBtpq1M; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-363c7d490d1so777095ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707303856; x=1707908656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MkHJEMhdHIEDISZVoKhCE9ifS1ot8NgYUDuuTg1ODbU=;
        b=RNBtpq1MRPESx57cDJ2wvt+fsfxaz6FtCznbReN75Ij/Ise8wkzw5yJuMiajsv14vq
         Ih8R64zS87/5xpfjgnzqnRwLse0rigqN+Qam00rj56JRkgt7I6gGiXb1xDdRrCFXelCx
         u4hAza/gL9vD8O41sEJ114ZzZui3d+yph9NSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707303856; x=1707908656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkHJEMhdHIEDISZVoKhCE9ifS1ot8NgYUDuuTg1ODbU=;
        b=YhJLtBcK+a6DnPM7jwqpxf7Q7a4EMU3irCbsZGMTIO58xzIc8ZU/JN1JTEOvoPgjdn
         zL7TjrQoRtmO1W65H7TP8q0of6dQnspdJ0raGffTOvMlj1fWCS+nim8qotBab9F8uwSj
         C76ztseT8H7oYotY/NJ9+Q8GGs3BNdWHcdutSqOaxw9oAJMUkQanihnER9fXYGdjX8BW
         lTOIfwHrjfiLAVlr2moSs8g3QMhcXWINfPSw3UuhtX3XfhzXoJHdQf4d8kNaEfCFu2F4
         I6j7n3Z5uKSxoefC1jVtKwEjY8FfBC5MYmY93tsxFuGJRNLe6E0KGr6GajdXoWxvZhBD
         tBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjjUEBs8bS/lBuaxox+o5NfAXq7jJNba7mnuUSgAIorkOwD4bcCo+yiLaL5p8nYm6uMzGyYTrJKO0pli8/8GgjFBQb4Nhqj7tNo8Ma
X-Gm-Message-State: AOJu0YwjNODh4RL5brTmY9Rx4IMRXQBnoat1VYMHXjyDdakhtrUAvbHF
	h/jW4WpTCXtz2/wT/zB6aOtPIvMfyGbBQe78Ornhj6EnIDXrzCe9/+ucJ1iqGA==
X-Google-Smtp-Source: AGHT+IFsYYm7hJGs5m67HBsC49sVaunlIdTZxtC+l0udvR2oLwzFexMXoEljKEGwE1VAc90ijtD/5w==
X-Received: by 2002:a92:c20f:0:b0:363:ad00:106d with SMTP id j15-20020a92c20f000000b00363ad00106dmr5585505ilo.4.1707303856225;
        Wed, 07 Feb 2024 03:04:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrtNEYtrYrUbd3WCx5d+Vo2gSvxdEHF0BNGt6ximizf7qYe7T5H46Ie55fL2VWgxMxlWduhoOX6KlMOKtsxeFyYCjnhIkE3L6KvmtJVxIpjw7kXgW5qPN+w4huuzEm3qwVbp0AVgQ1ZkASW5U90p88VrUkWp6nk5vR49oEi+InXGOlVot97XzK5pkmLoC/C2lIuxSGPyqlv0uv7XGoAEMGG6mOD7CY9rcJB8pP2E8YKfhqP27o1FFSVoC5YBVbtY5PZ9MkHM2h+wYCchXO4Cb0F8vo8CHqj9008WFYSz/M028lVxfT3MffozMwCJI64UcjTuNhYeBexPzgZrEmQuSK3FMTUJHePjnEMG8JGdN/epYhO8fGrZcF43GqGd7MGSkLs0TQbrG7Y1g3GzzCBrKf8uLtRggideexU9Q0w5aJ/L4dwMQvoBR9qCjBvFyTRh6Icke/q+ziPbcKh2mMkoOp3unEJyA0N6zOTMm/dlbK9WvXl3hPgy+yY0O9wlGZ62HqyqCbYDs=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ck4-20020a056a02090400b0059b2316be86sm1109248pgb.46.2024.02.07.03.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:04:15 -0800 (PST)
Date: Wed, 7 Feb 2024 03:04:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Marco Elver <elver@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Hao Luo <haoluo@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3] ubsan: Reintroduce signed overflow sanitizer
Message-ID: <202402070255.36699AE147@keescook>
References: <20240205093725.make.582-kees@kernel.org>
 <20240207014528.5byuufi5f33bl6e2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207014528.5byuufi5f33bl6e2@google.com>

On Wed, Feb 07, 2024 at 01:45:28AM +0000, Justin Stitt wrote:
> I wouldn't mind also seeing a test_ubsan_div_overflow test case here.
> 
> It has some quirky behavior and it'd be nice to test that the sanitizers
> properly capture it.
> 
> Check out this Godbolt: https://godbolt.org/z/qG5f1j6n1
> 
> tl;dr: with -fsanitize=signed-integer-overflow division (/) and
> remainder (%) operators still instrument arithmetic even with
> -fno-strict-overflow on.
> 
> This makes sense as division by 0 and INT_MIN/-1 are UBs that are not
> influenced by -fno-strict-overflow.

There is actually already a test_ubsan_divrem_overflow, but because the
failure modes result in a trap even without the sanitizer, it's disabled
in the test. For testing a crashing mode, it might be interesting to add
it to LKDTM, which is the crash tester...

> 
> Really though, the patch is fine and the above test case is optional and
> can be shipped later -- as such:
> 
> Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks!

-Kees

-- 
Kees Cook

