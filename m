Return-Path: <linux-kernel+bounces-54564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC4984B0C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6371D2826E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD1D12CDBA;
	Tue,  6 Feb 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CSviwOn2"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC712B177
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210528; cv=none; b=TFecHXKdq18QIB1lkuJQ4/wHdhgCmGiZ04gX00Rj2LjYczJOxtgyeB3eVWQjokTjXHPbUCiwUalv+GE8AzJLNoiDzfcPH1zowMfDwi/jWquCehdWAtkZ36FPFmL10LeFVhiXLP3goBxmeg9QIAZfolGsKw6iV923kDmHYXEn7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210528; c=relaxed/simple;
	bh=o/nDiZNkpvZtf7fbYby1EZYkJ9fJ2pBt+aJPXFnNHS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQMAwI0y3zjPokMBWWSg+3cl7uOPdOCuipp9H416f7m8lsXsQeK35Irse9aUMSM59Lv4etaSglqlv7tc39/hB8sPUXifbVgimNWLzWZiJCJWh4vRkMHODDDisaWnKv2Hd5fbrWYeWeaJblYOJ7qqYYaFZejbosxoJ1/rT2y8ms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CSviwOn2; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so7051240a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 01:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707210524; x=1707815324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrFND4dxCfWLl1ew1xLsa7iBfu3GqYkoN5PfSIonEFY=;
        b=CSviwOn26Blq1cGSu+mnAsFotrWKWCsa7R6zEAHGG684XY/45PRgFCV4tWKIBXqiaV
         eWvQoDuR+24KOpCoq58NDhF6jsgqXdE8wdjKp3aLGs+YbYNRHBGT9ta2ZmIs8j4R6VyR
         rbi9dtEiRCo3bT9qWAN01xgtQYmvW33obu4zEqyAkRkKh15oATSSpZzsDYzbi2dy01Lq
         2oRHZtggSqhZDzbr47sKPtXF+zXIRxw0l/nh7B5k/VNT8GJ0o/vAsxAwZPNIdAe4rHRl
         NnzIqoJYfwO1gBgLNxBijFHPvNfvyBybxYzqchS01t1A1TZBlhyh7Hm3snRopCh7OFXW
         RCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707210524; x=1707815324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrFND4dxCfWLl1ew1xLsa7iBfu3GqYkoN5PfSIonEFY=;
        b=ZamNj7hihvf+q6JA3l8iSiSJxKDymk3kSCjDdfs30ooeA6IQpTu//fIDotYeTaa48G
         9XmWG1crFZxUIYmR/T/N1DKI896j21p6BboEgpnhTtIYt0M3MAcVHq/eSKC09VcoJ4Nz
         tiZVIiSp7ioMv+O7cqN6LN5oem93cexCwMMJjasGPfwEPoa2I4WYrLfyodIbzp30abnW
         rdX98v1QgDdoTu46AnWPXjVlP2++0VNfMsYd7VWR3EBf8cuOSJ7nTom/ihcs5Pkul1rZ
         zTOIWcvR8Uf5Ub4XnpGWsheT4K+wgCByQL+2sdp3t4frm97eCdIIMhMB/eYi2kM/jYL7
         xJmg==
X-Gm-Message-State: AOJu0YwpbAdwHr31YDxs0imJ0/NtD0Sfax8JmHeFQmwPRD1FBj0ufONS
	spQSWomkpOeBygpbWC19Jxxg0hkjticElbi05sqyo7zLOjmEZydELigMwqxyR74=
X-Google-Smtp-Source: AGHT+IF6DSsrratcT3lQFvy95hQONda/WKZRLQiN/75bYW+PLHjzj5PsEmGc69r70vRkDMHQ+DqS3g==
X-Received: by 2002:aa7:d94a:0:b0:55f:d808:328c with SMTP id l10-20020aa7d94a000000b0055fd808328cmr1337319eds.31.1707210524260;
        Tue, 06 Feb 2024 01:08:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWX0wWQBboywnTmWh/b0932iMAvBXxf9mdgkgO1xIVRZlY+QqokBJFaNk5WRGuZoG5dJ1jBC0NOf3bkaI9rn2UvFqapsiaeiO828GveGZHQd9bXXiJK4JXbJrWdtvQmVOStivg02SVB1TXZcp5EDz0fbSp7FYhgTEsh7OB+HUP82aJ8iXSg38VjV55JbscLEuGXNDFEUcfVshBn64xTahpEK+aoGSs3aZNjdzFZt4tWM/Ra06FS8u/vR8fuk9WvC+6Ax9Bxnb4M4NPNlEVsBIIrX8QuE91BkeUThz9fJZLbmxcruxPyNZ72O9WFRY5BEhu3uGYhbDf7IIlRyGiwFTTAg5fnwk8yIP7T12e2OIr6TvgZiaAzyFsIjSHKEAEUtJQhoEQPnqCjgDZcdywG5dlbpjOgHyAc9+7qYDO/GtGVo3liWHmfiN5c3bSGXrEvtCX+2efzQMisNjYx2fwX6q4lvViminpt1xTSBh3nwcGklXcQx4R4wCGoKwaYI/PC9Ti5Ok68n+p5dcN7BULKrvEkeXaly97j/XTIa07tJX3kPWVWdl6zFlQCsdziLHnYwfQtVrfRF99AghW+W3Hhz8PJu4LD5+eZOCsOZCCfJ80+iqtAhghWC4nXlEUhHZWToqyNwGDNAMjqCcXci6IUAGxjBoKM9pLmQQWX7yUP2+m5c8hFq5CvAmhC96Ruceiw8qMSkeIsLXn7SDPxcbhyCe/0ydHFVzQk3j8j/ac99z8S7rcOg9Rlc0AqaX+7suH96t79dKe5
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id c3-20020a0564021f8300b0055fef53460bsm846722edc.0.2024.02.06.01.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:08:44 -0800 (PST)
Date: Tue, 6 Feb 2024 10:08:42 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	x86@kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v4 3/3] printk: Remove redundant CONFIG_BASE_FULL
Message-ID: <ZcH3GoEOzvJGBlSK@alley>
References: <20240206001333.1710070-1-yoann.congal@smile.fr>
 <20240206001333.1710070-4-yoann.congal@smile.fr>
 <ZcH2ElZd4BaySeGV@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcH2ElZd4BaySeGV@alley>

On Tue 2024-02-06 10:04:20, Petr Mladek wrote:
> On Tue 2024-02-06 01:13:33, Yoann Congal wrote:
> > CONFIG_BASE_FULL is equivalent to !CONFIG_BASE_SMALL and is enabled by
> > default: CONFIG_BASE_SMALL is the special case to take care of.
> > So, remove CONFIG_BASE_FULL and move the config choice to
> > CONFIG_BASE_SMALL (which defaults to 'n')
> > 
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> 
> This might also require updatating the default config files which
> unset CONFIG_BASE_FULL. I mean:
> 
> $> git grep BASE_FULL arch/
> arch/arm/configs/collie_defconfig:# CONFIG_BASE_FULL is not set
> arch/arm/configs/keystone_defconfig:# CONFIG_BASE_FULL is not set
> arch/arm/configs/lpc18xx_defconfig:# CONFIG_BASE_FULL is not set
> arch/arm/configs/moxart_defconfig:# CONFIG_BASE_FULL is not set
> arch/arm/configs/mps2_defconfig:# CONFIG_BASE_FULL is not set
> arch/arm/configs/omap1_defconfig:# CONFIG_BASE_FULL is not set
> arch/arm/configs/stm32_defconfig:# CONFIG_BASE_FULL is not set
> arch/microblaze/configs/mmu_defconfig:# CONFIG_BASE_FULL is not set
> arch/mips/configs/rs90_defconfig:# CONFIG_BASE_FULL is not set
> arch/powerpc/configs/adder875_defconfig:# CONFIG_BASE_FULL is not set
> arch/powerpc/configs/ep88xc_defconfig:# CONFIG_BASE_FULL is not set
> arch/powerpc/configs/mpc866_ads_defconfig:# CONFIG_BASE_FULL is not set
> arch/powerpc/configs/mpc885_ads_defconfig:# CONFIG_BASE_FULL is not set
> arch/powerpc/configs/tqm8xx_defconfig:# CONFIG_BASE_FULL is not set
> arch/riscv/configs/nommu_k210_defconfig:# CONFIG_BASE_FULL is not set
> arch/riscv/configs/nommu_k210_sdcard_defconfig:# CONFIG_BASE_FULL is not set
> arch/riscv/configs/nommu_virt_defconfig:# CONFIG_BASE_FULL is not set
> arch/sh/configs/edosk7705_defconfig:# CONFIG_BASE_FULL is not set
> arch/sh/configs/se7619_defconfig:# CONFIG_BASE_FULL is not set
> arch/sh/configs/se7712_defconfig:# CONFIG_BASE_FULL is not set
> arch/sh/configs/se7721_defconfig:# CONFIG_BASE_FULL is not set
> arch/sh/configs/shmin_defconfig:# CONFIG_BASE_FULL is not set

Ah, also we should drop:

tools/testing/selftests/wireguard/qemu/kernel.config:CONFIG_BASE_FULL=y

Best Regards,
Petr

