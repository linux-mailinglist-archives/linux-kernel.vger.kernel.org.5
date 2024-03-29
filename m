Return-Path: <linux-kernel+bounces-125339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DDB892453
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C1B24883
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542471386DC;
	Fri, 29 Mar 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BUYVZV7k"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CDB52F79
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740730; cv=none; b=d/fwbUzmKiWTXfqxPoyX+H6mihwrlQeo76u6F1iLEkpGV/Papf4n/6XBQkZafi7TvNFL5uGU8YPMSBjyGigLWCGpeCRasLsGrE7/reZ6a3J7kabhoMrfVPiHN82iQZ1FICjckOQQjkDs30asqGN/N92AXq+117BBZq3ePic68Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740730; c=relaxed/simple;
	bh=Qg6JQU06sgKW9eYerMelYzujMyN/XjWSVwAEBQRqmN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Npr0bAZtPRdGD2ab5OtQstBNZBBNKG67poOKNv8hsULmWiBJmICEbn66Hkqoor9IG454ebz9GCE1R23oxRwfGvaitlsG859GWZydMreDmRihLQOMtQJ29x5fKRwfe0rNRKM2+EryA8TdvfuwxR2hHylMElSeX10ESf1YbOdwZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BUYVZV7k; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0b213efa3so20890805ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711740728; x=1712345528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98Fa2R+IhvZQEbNzhMF87WzGRorq0pNL8uG9IBYNkc8=;
        b=BUYVZV7kL+fXb3JNiowRCVRnEg1sgQJNculGo7cp4bTDXu5pRVJl+yWQmXyxd1S0pa
         pH+HvXY6VecTWcqu92Nyc3BbEVcqAS1ZskoJo1Ajy0I4CX8LF8B8eL+j1E38Yt7Om5C6
         08yDO1NG8lDkZFt7DO8tPeVapm+yL0JHiBo70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740728; x=1712345528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98Fa2R+IhvZQEbNzhMF87WzGRorq0pNL8uG9IBYNkc8=;
        b=ro+q6pXXL9tHdhPp3m8PZnI2k7bv2u9Eb75PEV5zAd4G13RGTIi7wigU3K7gOPEqwF
         8Wgou3xdYmW+vnXy3t3amkBIA+N1trSAFvckh9Kp8RejklOExemTA3qKHwAE4cNEG5il
         drpANAaPQfm3Tp8P0MCzE8jF4xE3izXNvtr7zapkMDbYtu2PQ4CplPej4dnfxeAEqfGO
         kttdLXKLLew+e6Zr6T5DqEntzgSDtpb8rIz38mP8QM9t8ijmbtRUrncaQIJdRE5GCFxx
         SraJX0s9EXtu9BPFLCPUgmInPeJ7E8KJ3xGvlMt2QtQ432nCQh/aXBmDAiDeIqe0VeB3
         001g==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+WTrOEqSkdtH4395PjtFWoAPJzqwSQAtMAS0cTiNrB5YIUpNzzhJexJ8PgQE05QaxkfzDw8MW9frwuZWzU6jK0hLhHLsn/YlhWxz
X-Gm-Message-State: AOJu0YwyWvSQ+i8qKVSCpU2RauoeChyQoVxm9+JRYW57C1+3GbKawcVf
	NwAy+2VhpCNQIPNt4jGehaN+s8c5tv4mqNfgv9wEN+gahkUazul4Zj9B1p48AQ==
X-Google-Smtp-Source: AGHT+IGYzt504Mj7WpvI3TcGOknccKEkffs6TOokF2keOdb6i1qwocy6kuphkHf5jd6ms+OYqg/jWg==
X-Received: by 2002:a17:902:be05:b0:1e2:2bae:90f with SMTP id r5-20020a170902be0500b001e22bae090fmr3173324pls.49.1711740728360;
        Fri, 29 Mar 2024 12:32:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b001e0e977f655sm3790954plg.159.2024.03.29.12.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 12:32:07 -0700 (PDT)
Date: Fri, 29 Mar 2024 12:32:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>, Jia Tan <jiat0218@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] xz: Updates to license, filters, and compression
 options
Message-ID: <202403291221.124220E0F4@keescook>
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320183846.19475-1-lasse.collin@tukaani.org>

On Wed, Mar 20, 2024 at 08:38:33PM +0200, Lasse Collin wrote:
> XZ Embedded, the upstream project, switched from public domain to the
> BSD Zero Clause License (0BSD). Now matching SPDX license identifiers
> can be added.
> 
> The new ARM64 and RISC-V filters can be used by Squashfs.
> 
> Account for the default threading change made in the xz command line
> tool version 5.6.0. Tweak kernel compression options for archs that
> support XZ compressed kernel.
> 
> Documentation was revised. There are minor cleanups too.
> 
> Lasse Collin (11):
>   MAINTAINERS: Add XZ Embedded maintainers
>   LICENSES: Add 0BSD license text
>   xz: Switch from public domain to BSD Zero Clause License (0BSD)
>   xz: Documentation/staging/xz.rst: Revise thoroughly
>   xz: Fix comments and coding style
>   xz: Cleanup CRC32 edits from 2018
>   xz: Optimize for-loop conditions in the BCJ decoders
>   xz: Add ARM64 BCJ filter
>   xz: Add RISC-V BCJ filter
>   xz: Use 128 MiB dictionary and force single-threaded mode
>   xz: Adjust arch-specific options for better kernel compression
> 
>  Documentation/staging/xz.rst    | 130 ++++++++---------------
>  LICENSES/deprecated/0BSD        |  23 ++++
>  MAINTAINERS                     |  14 +++
>  include/linux/decompress/unxz.h |   5 +-
>  include/linux/xz.h              |   5 +-
>  init/Kconfig                    |   5 +-
>  lib/decompress_unxz.c           |  39 ++++---
>  lib/xz/Kconfig                  |  13 ++-
>  lib/xz/xz_crc32.c               |   7 +-
>  lib/xz/xz_dec_bcj.c             | 183 ++++++++++++++++++++++++++++++--
>  lib/xz/xz_dec_lzma2.c           |   5 +-
>  lib/xz/xz_dec_stream.c          |   5 +-
>  lib/xz/xz_dec_syms.c            |  16 +--
>  lib/xz/xz_dec_test.c            |  12 +--
>  lib/xz/xz_lzma2.h               |   5 +-
>  lib/xz/xz_private.h             |  20 ++--
>  lib/xz/xz_stream.h              |   7 +-
>  scripts/Makefile.lib            |  13 ++-
>  scripts/xz_wrap.sh              | 157 +++++++++++++++++++++++++--
>  19 files changed, 487 insertions(+), 177 deletions(-)
>  create mode 100644 LICENSES/deprecated/0BSD

Andrew (and anyone else), please do not take this code right now.

Until the backdooring of upstream xz[1] is fully understood, we should not
accept any code from Jia Tan, Lasse Collin, or any other folks associated
with tukaani.org. It appears the domain, or at least credentials
associated with Jia Tan, have been used to create an obfuscated ssh
server backdoor via the xz upstream releases since at least 5.6.0.
Without extensive analysis, we should not take any associated code.
It may be worth doing some retrospective analysis of past contributions
as well...

Lasse, are you able to comment about what is going on here?

-Kees

[1] https://www.openwall.com/lists/oss-security/2024/03/29/4

-- 
Kees Cook

