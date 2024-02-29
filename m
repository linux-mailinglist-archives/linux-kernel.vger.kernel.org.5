Return-Path: <linux-kernel+bounces-86030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 157EE86BEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B853E2887E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9776036AE5;
	Thu, 29 Feb 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VQk8oU0R"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27D3612A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172616; cv=none; b=nf+X1nAP2e8BoAmG8x6QQ04HR9ERqhYTflNcJJgTTT5tvFxSoS+E+rWq2+jIVnhrGNkfIqK6qZgePmf4o3414WK0GeiaCAAMfPqyl7C2wTrhGOzYoVnD1BkCaSuWDEIpqx/4WUTkoGDL+XBJaCtKfWy/zPyyM81cCK9I0lsT6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172616; c=relaxed/simple;
	bh=lYm5sE8YtwjbzQspufWqcSCIqUUkVnEVFVICmUMwiEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQudpi2sjax0NM7OA4OLNxO/zmrkzVlWZlhifdEqtUywKxfiJunlKmgp0bvKrY8Kf4uhLMHgOe1sHrigU5vWnd0JFoO0s4LfPxx8fSO9KT8cLgHAuGwxnVh+VGvm7BXgBIeGI1JNTCskZnLOH7hJMDp2hYu2qwT3ejzwXmFwI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VQk8oU0R; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e5796d01c8so274217b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709172615; x=1709777415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUf9WkXQBXM7b/VI6HGYsA1IhCASFRsvc9ci4ULhUfk=;
        b=VQk8oU0RI1vSyYS86APmvKgiLvvaCZmDZSN7axCYjOMIeCi2SoML4X6C+Wo7Kab0Pw
         1qNY5Q+lsgbfMX9Tp41M0RrlHXDTm4udVDVC2xpoBbWzHNTOgmXpvsKwdC1Ai1xlU2i+
         /tmhS//+fUNG/uoeeulag1LH0tLWnBm8DV6Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709172615; x=1709777415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUf9WkXQBXM7b/VI6HGYsA1IhCASFRsvc9ci4ULhUfk=;
        b=H4wjbygjh9dYNQEzOWRqUU0n6vFQajv6+GFqvopEFqus5UcYnvUgeweK2bxazk5GKz
         wpBuUSBwtbu5XLdt69QI+X3ac88cqg90XGEN7CTTvLaekCE3ZvVL9WfCyCcz/aRqKiuJ
         FWt23b1pTAC78XRnLkci1Btm4lVLhjziVbzoLbAJD2LLfXKF/iX8E4A6eG9OtFOPDwVI
         ii+dy5wfWMQFUG5xl5rlYpikn9BxCXPSuDJy6ErQYM7tWiV12nrjMFdDdu/GKnYKNuam
         EQ19FUUWzvt3tjh/fu5OO98Ccj61Zef+q8wYeL4kq8pCuzaOTov+J0O6fWnqtYRek3NV
         hPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpLgHoDR6AU6Hxf5gAKOMJX3uUv0Ftj0Xva+XObzoBHs5joNrIYWk6Yym+8u7TwpPZjD79XE+GicLbipQ+WZLiNz6BCMgliZ+FxKNf
X-Gm-Message-State: AOJu0Yw8gT+sVvxXzJwPnJZ0OWAliiMr9dJZi/gX50PdCzjEwy3YlcIw
	59/Mray9kFw7u7Mrv/ZlP6q3QF8uOQBtmqlxZxv2TutzqmvosusfCNgtLRb+SA==
X-Google-Smtp-Source: AGHT+IEZYonSLMh6MVFKIARZL7tUW+oKjPQhV7L1Go8q2yV0UMkSm0FuLH2nTnBKTBOVUI1Xi6pxPg==
X-Received: by 2002:a05:6a00:938a:b0:6e5:5bb4:7098 with SMTP id ka10-20020a056a00938a00b006e55bb47098mr1205300pfb.7.1709172614804;
        Wed, 28 Feb 2024 18:10:14 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:50c1:1ad2:3268:cacd])
        by smtp.gmail.com with ESMTPSA id v5-20020aa78505000000b006e4f311f61bsm118197pfn.103.2024.02.28.18.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 18:10:14 -0800 (PST)
Date: Thu, 29 Feb 2024 11:10:10 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] kconfig: add some Kconfig env variables to make help
Message-ID: <20240229021010.GM11972@google.com>
References: <20240222031801.GG11472@google.com>
 <20240222032559.496127-1-senozhatsky@chromium.org>
 <CAK7LNARo4L6qxoqRU-0dgABarukJKAaZpCRtfA3MyUHhSuDQxQ@mail.gmail.com>
 <20240222051621.GH11472@google.com>
 <20240228045652.GH11972@google.com>
 <CAK7LNAQ8OyNMeGzVoTRg-sHDZ4YK0EKY_eEWNepekaibO_ZKwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ8OyNMeGzVoTRg-sHDZ4YK0EKY_eEWNepekaibO_ZKwg@mail.gmail.com>

On (24/02/29 11:03), Masahiro Yamada wrote:
> > > > > +++ b/scripts/kconfig/Makefile
> > > > > @@ -158,6 +158,10 @@ help:
> > > > >                 if help=$$(grep -m1 '^# Help: ' $(f)); then \
> > > > >                         printf '  %-25s - %s\n' '$(notdir $(f))' "$${help#*: }"; \
> > > > >                 fi;)
> > > > > +       @echo  ''
> > > > > +       @echo  'Configuration environment variables:'
> > > > > +       @echo  '  KCONFIG_WERROR                 - Turn some Kconfig warnings into error conditions'
> > > > > +       @echo  '  KCONFIG_WARN_UNKNOWN_SYMBOLS   - Make Kconfig warn about all unrecognized config symbols'
> > > > >
> > > > >  # ===========================================================================
> > > > >  # object files used by all kconfig flavours
> > > > > --
> > > > > 2.44.0.rc0.258.g7320e95886-goog
> > > > >
> > > > >
> > > >
> > > > Why only two, while Kconfig supports more env variables?
> > >
> > > Right.  I wanted to add only those that we use (and familiar with) for
> > > starters.  I'm not familiar with things like KCONFIG_PROBABILITY, for
> > > instance, and not sure how to document it (its Documentation/kbuild/kconfig.rst
> > > description is pretty lengthy).
> >
> > Masahiro, any opinion?
> 
> 
> I do not need this patch.

Do you agree that putting kconfig env knobs into help makes sense
in general?  Especially those add valuable sanity checks.

