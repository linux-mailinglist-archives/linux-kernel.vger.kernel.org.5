Return-Path: <linux-kernel+bounces-45381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA353842F81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED07286BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E13F7D419;
	Tue, 30 Jan 2024 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyPOPKRU"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB1E38DDA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653169; cv=none; b=mg7g+A25VEoEy6Qd6p37zc84o8eptKRiPUfBTszQ2xO3jGXEs0ymkIJieYt6Wk2WG3rYa1rcKn8ygy2dRE70cGIkbfBAqyBYR0gwoNbh3DEDVxd8RqetPh/NhGR5CIzGfhGsBL3ZFglVU5xm7R0dpmvTREn7UecRs0EEuo2jAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653169; c=relaxed/simple;
	bh=IC3p5zH5zXXM8bR+woCqmXd7yYe1yCTFkea4aKMs4wQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA50Hj6QX9lKdDxP78/5B0CJtM3iSFupRmSGX7kw/W2mzsukTKHIbtkaEIUbPC0zhFC/ErzyA7HgjQ1f1sMHi0YdJKqBzexO1p5uYQQtLpBb4ec46WhM6E+V+v4+ojjbYKWjS72AZ7xbJGfHgE38xsvql07dF1IDZ5TCISSq9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dyPOPKRU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8d08f9454so19545ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706653167; x=1707257967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQl8EgXpJK3C8wCH3PL/CVofTbAYU7lTGBdvfNGQY7M=;
        b=dyPOPKRUwf4mAl858V4jYESVWUPy185wBMTJaFf6TVj1QeAkIQ1hN5UORup3mGLzDW
         rc6+mUzX/TIZNHgkrTHHNW9ChIx3X+jQ4bDcG0kMonjcmAEhjsBCg3mvD1N/NoIwuXVq
         3I++X7db05TBqWCfjvpTcJOKw4S437LeTbpQQnpjkngz4Vu2AWVCxVoT+uueU9slFUWZ
         f3K8BWCux3hPhsx3yATvDBKgGk3dl4XK0bbmHjVZSAL5cMTjtNgSj46/iXE+Vo+XDHZ0
         CMhALcXfXM8XDwEE6X47dUxHkCr0tSuJllI/kMmjw9DmJtZ3DuRd+6d3Zkaxdcu5GM3B
         rs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706653167; x=1707257967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQl8EgXpJK3C8wCH3PL/CVofTbAYU7lTGBdvfNGQY7M=;
        b=hW9oOpog7LCz3pstO3SKL27J99F7WQ766l2RJAPLWex26t53zfEgmZj2Qxkw6klA9v
         3uFQpRlsdWCZUpOiLi/BSQxFerO99F+5EDaWHo8HIQRWA2PC+y78Tyo5ACJ/72UIRKTo
         wJYUwj9hHoDAcYjdfRqrnO/iVj8tNjQ2DQvFZBQHzlHmu6dw9HXqzt6CCscOA1FxQzXy
         kQ7hUNum7UaCWyxxz1q9mWkw6y5M0c4xvhNE1NmyfA3pXAyxwIZGuRTBVUGa6oCaHgmk
         fYdbHW5fHA+/5glVpdmEUYxfy3zmRbmtCyMcWB9rYVDvkfTwyGgjIAAJ8GtvYB1PT8Ec
         jSaA==
X-Gm-Message-State: AOJu0YzEV3QfvNpDQLWTMdk4bTaCe0JJnyfhPzx4Yj8HDouddfIoOa8d
	uciqdUcFYqwJwuoKAjO0s/okKheNUTFjF9gihUs6p1vwvJ68AzN4KgJPoS5gFQ==
X-Google-Smtp-Source: AGHT+IFwLv+eKGqrkCeOjgMbEoehzCvXoH+cbPDe2PL0I9RdXrlE78Tt/rrzBUHv78ajXUWMaQtqow==
X-Received: by 2002:a17:902:e547:b0:1d8:d225:699d with SMTP id n7-20020a170902e54700b001d8d225699dmr383866plf.16.1706653167019;
        Tue, 30 Jan 2024 14:19:27 -0800 (PST)
Received: from google.com (69.8.247.35.bc.googleusercontent.com. [35.247.8.69])
        by smtp.gmail.com with ESMTPSA id y11-20020a056a00190b00b006da8f6650a2sm8241626pfi.155.2024.01.30.14.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 14:19:26 -0800 (PST)
Date: Tue, 30 Jan 2024 14:19:23 -0800
From: William McVicker <willmcvicker@google.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kbuild@vger.kernel.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: allow build files to reference other
 build files
Message-ID: <Zbl165bfizOauIlf@google.com>
References: <20240112221947.1950503-1-willmcvicker@google.com>
 <ZbduU15kw5R42awj@buildd.core.avm.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbduU15kw5R42awj@buildd.core.avm.de>

On 01/29/2024, Nicolas Schier wrote:
> On Fri, Jan 12, 2024 at 02:19:46PM -0800, Will McVicker wrote:
> > Add an exception to the EMBEDDED_FILENAME warning for build files. This
> 
> As far as I can see, your patch fixes only the checkpatch warnings for
> top-level Makefile and Kconfig (and leaving out top-level Kbuild).
> Other build files are not affected, right?

Since $realfile includes the full path, I wasn't able to find a case where this
issue happens outside of the top-level build files. The same goes for Kbuild
files -- the top-level Kbuild file doesn't include other Kbuild files and the
other Kbuild files don't include other Kbuild files within the same directory.
If you prefer to protect against this warning in the future, I can include
Kbuild as well if you want.

Thanks,
Will

> 
> Kind regards,
> Nicolas
> 
> 
> > fixes the below warnings where the Kconfig and Makefile files reference
> > other similarly named build files.
> > 
> >   WARNING:EMBEDDED_FILENAME: It's generally not useful to have the filename in the file
> >   #24: FILE: Kconfig:34:
> >   +source "drivers/willmcvicker/Kconfig"
> > 
> >   WARNING:EMBEDDED_FILENAME: It's generally not useful to have the filename in the file
> >   #36: FILE: Makefile:667:
> >   +	} > Makefile
> > 
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > ---
> >  scripts/checkpatch.pl | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > v2:
> > - Unwrap commit message lines
> > - Align and update regex
> > 
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index f8343b34a28b..c2869803e545 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3785,7 +3785,8 @@ sub process {
> >  		}
> >  
> >  # check for embedded filenames
> > -		if ($rawline =~ /^\+.*\b\Q$realfile\E\b/) {
> > +		if ($rawline =~ /^\+.*\b\Q$realfile\E\b/ &&
> > +		    $realfile !~ /(?:Kconfig|Makefile)/) {
> >  			WARN("EMBEDDED_FILENAME",
> >  			     "It's generally not useful to have the filename in the file\n" . $herecurr);
> >  		}
> > 
> > base-commit: 70d201a40823acba23899342d62bc2644051ad2e
> > -- 
> > 2.43.0.275.g3460e3d667-goog
> > 

