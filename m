Return-Path: <linux-kernel+bounces-125553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5A2892848
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F2F1F21AE9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F405FA933;
	Sat, 30 Mar 2024 00:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UgMP4wp+"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76E8F47
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 00:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759069; cv=none; b=A964PZK1vEXYjh27E5xh/ky8MNg3Mn962xICU8S6JfP9wyfC/yHOpAFKTuAdhFYp/O4YmGacvhcsbROKo4WOnYH/gWiELw3LHU9R4dp4wG+4ciWLq8qvyzQU/XNtyp1mRnujmV1/CYCum3y2qWNexL4xM8TPtM6+NdgsJ5Nw1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759069; c=relaxed/simple;
	bh=yE5+DggEX5qa/NHxKfZq/7KSyZSSGnH3wPKjVIy61mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbuxrW/l8G7DyrRXL0CEAzcyVL7QccvRuUGcxLOjaVr3iXrJIa21ad7c6q0/ipf95bHymLtzHVimga+bv+ecGau0eV/mktleJ16/Ekfdqrjz91TbJv0PQqA4HJnjiamOpESqy4OSZ0cSckos1fQojj+vluCrPOrM3SqbpMKH24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UgMP4wp+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so1382226a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711759066; x=1712363866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vAN6pcNUU/LtGsyeSO7wkayB5UqUGKzphZgd3xlQSM=;
        b=UgMP4wp+9qFxKU2DsiwVfBQw5f5jd5sPAvmT0ZhGVgQSO3t29+bkONNQTL+74dUZow
         SlA+XPvva9/9DjrqQKpdL6bYiKZQuigvTv+/KRDzxZ6ORlcXiiCIpVDJlhgDtxaQGEQ8
         rFViUfCBQGCHEhoVy4n+qZUpe47R5Txr19dMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711759066; x=1712363866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vAN6pcNUU/LtGsyeSO7wkayB5UqUGKzphZgd3xlQSM=;
        b=IsOlR7fie7iimBUKkr/ID6HGVIdg6dX74VvyB9JOZnGVU/wAZ1mvQIXawosqPW3utb
         a7lhjJ2mxH0OQjQcaJAijSv/zfIDGN3ZdSvfzSva4anyyz+5oq/ODMgSCjZE7UBZ2Mf3
         dBHo/VwOF+Ur8CbJQa644azOeEmMcqY8B72WR/jSSZlFOO8H8uo91tzDW+rZcfmffVON
         ZwC8JyhpBOFphNl4vdXRcuqVncd9TeSfXZWZr92H3jRjLLPFwx63XxfHwrkABCnaZZYF
         wjFtGGgnx68KDeAZIvVxmLHRwpkJpxcNbsxrsys5HtVcMxa0Hl08RM9isBgbOc8rdGdk
         DEyA==
X-Forwarded-Encrypted: i=1; AJvYcCUHVtJr3n7Rk/yUG60miuABG/GpMeGr01sKNA5AyAPbxBI+2jBqOixtx69LfChrbftGcr5HW3oYPnoAewMF4ZQvzCf2FGo7xdYWCj/9
X-Gm-Message-State: AOJu0Yypgp6meqiXjCR4QDCyP2VDuvBNHlmdOmXpwsR9F8RCy9LGBCCT
	qQBiIkrpCKDV2XqSyGD5nMZJdEUrhO4MhPz3ZyWYhnLX62gAkmx6313Iykxl2sdWRWBxSdAnc7Q
	=
X-Google-Smtp-Source: AGHT+IGuOzdrmPTki81zqW88HgYHwCuK2N58bZOYowyg6RvgIK3ZV7dGzfahBKHfyK6jHvxaubpDAg==
X-Received: by 2002:a17:903:264c:b0:1e0:378d:f2d1 with SMTP id je12-20020a170903264c00b001e0378df2d1mr2828344plb.60.1711759066494;
        Fri, 29 Mar 2024 17:37:46 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001dc9422891esm4016487plg.30.2024.03.29.17.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 17:37:45 -0700 (PDT)
Date: Fri, 29 Mar 2024 17:37:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>, Jia Tan <jiat0218@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] xz: Updates to license, filters, and compression
 options
Message-ID: <202403291736.B7E9C61@keescook>
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
 <202403291221.124220E0F4@keescook>
 <87h6go3go2.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6go3go2.fsf@meer.lwn.net>

On Fri, Mar 29, 2024 at 02:51:41PM -0600, Jonathan Corbet wrote:
> "Kees Cook" <keescook@chromium.org> writes:
> 
> > On Wed, Mar 20, 2024 at 08:38:33PM +0200, Lasse Collin wrote:
> >> XZ Embedded, the upstream project, switched from public domain to the
> >> BSD Zero Clause License (0BSD). Now matching SPDX license identifiers
> >> can be added.
> >> 
> >> The new ARM64 and RISC-V filters can be used by Squashfs.
> >> 
> >> Account for the default threading change made in the xz command line
> >> tool version 5.6.0. Tweak kernel compression options for archs that
> >> support XZ compressed kernel.
> >> 
> >> Documentation was revised. There are minor cleanups too.
> >> 
> >> Lasse Collin (11):
> >>   MAINTAINERS: Add XZ Embedded maintainers
> >>   LICENSES: Add 0BSD license text
> >>   xz: Switch from public domain to BSD Zero Clause License (0BSD)
> >>   xz: Documentation/staging/xz.rst: Revise thoroughly
> >>   xz: Fix comments and coding style
> >>   xz: Cleanup CRC32 edits from 2018
> >>   xz: Optimize for-loop conditions in the BCJ decoders
> >>   xz: Add ARM64 BCJ filter
> >>   xz: Add RISC-V BCJ filter
> >>   xz: Use 128 MiB dictionary and force single-threaded mode
> >>   xz: Adjust arch-specific options for better kernel compression
> >> 
> >>  Documentation/staging/xz.rst    | 130 ++++++++---------------
> >>  LICENSES/deprecated/0BSD        |  23 ++++
> >>  MAINTAINERS                     |  14 +++
> >>  include/linux/decompress/unxz.h |   5 +-
> >>  include/linux/xz.h              |   5 +-
> >>  init/Kconfig                    |   5 +-
> >>  lib/decompress_unxz.c           |  39 ++++---
> >>  lib/xz/Kconfig                  |  13 ++-
> >>  lib/xz/xz_crc32.c               |   7 +-
> >>  lib/xz/xz_dec_bcj.c             | 183 ++++++++++++++++++++++++++++++--
> >>  lib/xz/xz_dec_lzma2.c           |   5 +-
> >>  lib/xz/xz_dec_stream.c          |   5 +-
> >>  lib/xz/xz_dec_syms.c            |  16 +--
> >>  lib/xz/xz_dec_test.c            |  12 +--
> >>  lib/xz/xz_lzma2.h               |   5 +-
> >>  lib/xz/xz_private.h             |  20 ++--
> >>  lib/xz/xz_stream.h              |   7 +-
> >>  scripts/Makefile.lib            |  13 ++-
> >>  scripts/xz_wrap.sh              | 157 +++++++++++++++++++++++++--
> >>  19 files changed, 487 insertions(+), 177 deletions(-)
> >>  create mode 100644 LICENSES/deprecated/0BSD
> >
> > Andrew (and anyone else), please do not take this code right now.
> >
> > Until the backdooring of upstream xz[1] is fully understood, we should not
> > accept any code from Jia Tan, Lasse Collin, or any other folks associated
> > with tukaani.org. It appears the domain, or at least credentials
> > associated with Jia Tan, have been used to create an obfuscated ssh
> > server backdoor via the xz upstream releases since at least 5.6.0.
> > Without extensive analysis, we should not take any associated code.
> > It may be worth doing some retrospective analysis of past contributions
> > as well...
> >
> > Lasse, are you able to comment about what is going on here?
> 
> FWIW, it looks like this series has been in linux-next for a few days.
> Maybe it needs to come out, for now at least?

Yes, for sure. Andrew, just so it's explicitly clear: please remove this
series from -mm for now, until the situation is better understood.

Thanks!

-Kees

-- 
Kees Cook

