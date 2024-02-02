Return-Path: <linux-kernel+bounces-49678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE6E846E06
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B5E28FBD3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C380112AAC3;
	Fri,  2 Feb 2024 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IE/h4hZL"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867CD129A61
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869958; cv=none; b=Lgw+CyET/ZcSPvxyT7zmcTG87iZOcUIzoqhY2+pZqoHNqIBqSlm943pW2e1TcnlRcqjPEDwxFLax9Nc3l57gfiRwx4KH3Eg3h+WW1lwK+ICpXXFdy0Ig7xx/UyqTJFESJ883/5hhQUyxDWPmU+PxC583gJFfcTKAHlth6/WQs4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869958; c=relaxed/simple;
	bh=uXUipmy/R5ZOIbKsEs9QPraU2tmLbEvI/QwqRmYhptQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5KJ3sh8BK76L9Dug+ZMqLEdI59TUZBPdZeVLpte9x3N8h3xzVQn6+Rf3kQ7DApMO5C/i7aMNtQ7ISdkXfH05lfuKXuyTOEleMgMw0iqjmWCeod/F0S4+B+EUKs/0yOoVpGuTKstJjKp5WoKqEZBalNF9kTkP699+o4xafMPkE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IE/h4hZL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d953fa3286so11585835ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706869956; x=1707474756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rP513YN1a62J3CV7L8vAPGxN8u8562HK0dd64qxYUI0=;
        b=IE/h4hZLP5B9QlKrQZjz7nMUdCqEO5FWX2ZPrHBKI/2ejd3n4oTi0az3qpdcC/BRMA
         LY1wjCyV83KuGcF3gl+mwIH9XPmrp3hfEFEopOhbF4I3GU/7zabCB1g1xIAs/cuja0vg
         AVCbDJkdHpnlGDIo2yWQ24QCE3BRj9e040BM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869956; x=1707474756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP513YN1a62J3CV7L8vAPGxN8u8562HK0dd64qxYUI0=;
        b=qfVlubVRTTB12Q1nWi3MEAsOcJTA2zW1dgoKJeviRSB5ngCI7HGRDeMlPRllFHeJrM
         PgrinGJMhTRtTAmTSlHjOk4epJ0MbVls31oTf93XRY24XjAGJgbKQ1WPiJe0Nq5cp354
         6bqG5BndTadCX7/fHibv+IrOeUJ0bsoLB6jMG14Rj02iB8LT1R3dAfmBU2ub0jUYAOG9
         uf4AWyl4DdaGb5+S62+5R+9/bSUlNVWyuyH3FvVKJwy42/JFypK1x1KIgkxKZb1hB7GS
         L+E7goFKIipa8UD0uA//Xy7BeLgvODeT4rBHk/Nm1FeJ0re+ZNdoVvL18HAlW3+RPbPW
         fEGA==
X-Gm-Message-State: AOJu0YwInk9b/bA3LFxiWZkp56SCkymJH7r/E3pt8nXS6p+WiwDpI/6y
	urlWQ8wgzErNEzXI35OnJC1sJHWPSeBbxTokyAeUSToA6f08/wSGU6zGJSVs5A==
X-Google-Smtp-Source: AGHT+IEyirkJDw7WBU/1FJrLaWfq2iP+2z+RGmivHiVQ2prUmq3XvBaVVXQ92tYQlvHdPx57k1bbeA==
X-Received: by 2002:a17:903:2b04:b0:1d9:7ab0:5e20 with SMTP id mc4-20020a1709032b0400b001d97ab05e20mr523799plb.69.1706869955727;
        Fri, 02 Feb 2024 02:32:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXXfbi4Cj5WSyBND3C3ah7zoVKwtEN2SMAsOXAl4EPG51gwjcNNnpczP6t/IxL9mzZtFXSpw9P88crW7mDekJrRJsZ/unHzLU/9n5hQ0bl4KhBFvqvK+7et2rKpw35rXL5G+d+hazne7DQzlBP4MVxBAzG6KcEILvRCuPXQA1j5QnK74OxNGYgNUhsol1J0BGtRnggpkhC4kKxhchbcAgW58pQiBTxB5QL2ieTBDfEehYMWw/UW/4ZNvx3wqvZrQU0JiZCr6F180azg7aeLZg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b001d94644382dsm1297090plb.108.2024.02.02.02.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:32:35 -0800 (PST)
Date: Fri, 2 Feb 2024 02:32:34 -0800
From: Kees Cook <keescook@chromium.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	kernel test robot <lkp@intel.com>, Rich Felker <dalias@libc.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <n.schier@avm.de>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sh: Fix build with CONFIG_UBSAN=y
Message-ID: <202402020228.BBEF7DAC@keescook>
References: <20240130232717.work.088-kees@kernel.org>
 <494586ed5a0871cf7cfd005f513577952306a0bc.camel@physik.fu-berlin.de>
 <fe057f57aba0f8a9040d4700d27f5bd478032925.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe057f57aba0f8a9040d4700d27f5bd478032925.camel@physik.fu-berlin.de>

On Wed, Jan 31, 2024 at 12:19:22PM +0100, John Paul Adrian Glaubitz wrote:
> Hi Kees,
> 
> On Wed, 2024-01-31 at 12:03 +0100, John Paul Adrian Glaubitz wrote:
> > Hi Kees,
> > 
> > On Tue, 2024-01-30 at 15:27 -0800, Kees Cook wrote:
> > > The early boot stub for sh had UBSan instrumentation present where it is
> > > not supported. Disable it for this part of the build.
> > > 
> > >   sh4-linux-ld: arch/sh/boot/compressed/misc.o: in function `zlib_inflate_table':
> > >   misc.c:(.text+0x670): undefined reference to `__ubsan_handle_shift_out_of_bounds'
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202401310416.s8HLiLnC-lkp@intel.com/
> > > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > Cc: Rich Felker <dalias@libc.org>
> > > Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > Cc: Nicolas Schier <n.schier@avm.de>
> > > Cc: linux-sh@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  arch/sh/boot/compressed/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
> > > index b5e29f99c02c..6c6c791a1d06 100644
> > > --- a/arch/sh/boot/compressed/Makefile
> > > +++ b/arch/sh/boot/compressed/Makefile
> > > @@ -12,6 +12,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
> > >             vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo $(OBJECTS)
> > >  
> > >  GCOV_PROFILE := n
> > > +UBSAN_SANITIZE := n
> > >  
> > >  #
> > >  # IMAGE_OFFSET is the load offset of the compression loader
> > 
> > Thanks for the patch. I'm looking into this now and will provide the review later.
> 
> I tried to reproduce the error using your tree and the branch devel/overflow/ubsan-only
> minus the above patch and using the provided config but I'm unable to reproduce the
> error above.
> 
> Am I missing anything?

When I use GCC 13.2 (I'm specifically on Ubuntu 23.10) and the randconfig
linked from the report:
https://download.01.org/0day-ci/archive/20240131/202401310416.s8HLiLnC-lkp@intel.com/config
(which is notably enabling CONFIG_UBSAN=y and CONFIG_UBSAN_SHIFT=y) then I
see at the final link stage:

/usr/bin/sh4-linux-gnu-ld: arch/sh/boot/compressed/misc.o: in function `zlib_inflate_table':
misc.c:(.text+0x650): undefined reference to `__ubsan_handle_shift_out_of_bounds'
..

After the patch, it's solved.

-Kees

-- 
Kees Cook

