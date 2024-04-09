Return-Path: <linux-kernel+bounces-137701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3548489E62B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39BEFB22805
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5433B158DDB;
	Tue,  9 Apr 2024 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZJ+RrgOK"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE05158DCD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705833; cv=none; b=aRG+GMVWSZ/5ZpuLTFG6Zm9oXi8KLtYOTXGd/wC6tqd7uVUsuifIw2QNsjbMVlrPPPQSe8HnY1DqFLueS8SkgVmFOAIJJG59Rivk2C5n4Bf+oRMpeFF4I5avpbSY+wd9xmDmQSKGK5IpRz0iQL+J60PTTvtDdtuO6goy+5IRskc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705833; c=relaxed/simple;
	bh=5IWHRqqI3seHjc0H8avvGZOeJtWf+yYAE01YKdMRMjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/hVCPJzxP6uheOKu8cU6Og6ODf/VvGGzdLqytiO5DbOG6aZbgJpV+Welr3FGAsxyBrE5lt9LnHVL2OT5DZMkIjlKmrI7teQpG1pEJ5sOOvbi1JDGm5QYYJ5On9S8cSjhQ8uHbaCXPuvVbANLCD/d/sxYUTAKgCfnRNpG9IufOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZJ+RrgOK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e2232e30f4so54535015ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 16:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712705831; x=1713310631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3GBllj8XS/Lgw7EDpDRRfiZJH4dQ/8JO1yJUn0SBBo=;
        b=ZJ+RrgOKjpOz9xlBHcWvU73KNORXrOrMjwh4nPUz3JCkOgWGnPN88mBWsC7QFTCz2h
         JDa2g/M33Sx1YvD0C9qx/TOVi5dSKjxD0QfJKrKazgY/j0LEkJKwggviFDiWxOJK1vjt
         dQe0ZoRzVidNxlDGSZGCMBHEO3gs9g2yfNgH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712705831; x=1713310631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3GBllj8XS/Lgw7EDpDRRfiZJH4dQ/8JO1yJUn0SBBo=;
        b=RZquEatVEfc3Sp4cUV2Vh5GjxVh9WDOr27qYm9qw1LZ8iUVqTtwAv+CZw8jGJ2lhqs
         zLNdPnUhNMDUdt05B7HK5Z9xHoqUHK31T4RTPXgNHWaZuAMHlNQOoPiXCkid4EewtDJV
         fivmQWcjqC7Lf56eD8iESMMNf3vRGmO5FSxuCr4cCBwsQGCmA4unHGjmz0cqCtB9+9Az
         t1lWUH62w3ZjPTDO6DPBbIcTJgvntAKIc/FRAqKOeM1641vlXwo8FLlNkP6s+5QWGsn4
         BaW49LbQoE8GqJaELMlCy24IWw55sHMWE1slsG5fhUBE3bG/q4w6Qycwv1drQI/GiiNE
         qmEA==
X-Forwarded-Encrypted: i=1; AJvYcCV0dmHLPnnT+NeNvbF455i0xG8JhPZWSyRpvb+v5c2Tujzz8EHUGm2BTPMZl4OH5gNdcNC0YJMMOO0E3EqiIG7z8iHh5WoB5TV8XU5j
X-Gm-Message-State: AOJu0YwCjyuygKz3bRVtpL0YWJfUstWC4WZWxmDnyNZ+uvCArsstceTD
	A5Mku6Ajiyw0MfLCDidlhgJCP6yDDwckgQypq3QjU2bwsDko1cEcVZw3DzvQtA==
X-Google-Smtp-Source: AGHT+IFGdPZEzpneRh+zF6NNUt7U7MwmMmltzsSaPxDXzFgDYjGM/3hI5oS+TZohMG0Jhx7lVLFtgw==
X-Received: by 2002:a17:902:9303:b0:1e0:a3dd:82df with SMTP id bc3-20020a170902930300b001e0a3dd82dfmr1075461plb.38.1712705831382;
        Tue, 09 Apr 2024 16:37:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kn12-20020a170903078c00b001e0c91d448fsm9479230plb.112.2024.04.09.16.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 16:37:10 -0700 (PDT)
Date: Tue, 9 Apr 2024 16:37:10 -0700
From: Kees Cook <keescook@chromium.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>,
	"wklin@google.com" <wklin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Message-ID: <202404091628.BEC1FAC8@keescook>
References: <20240409210254.660888920@goodmis.org>
 <20240409172358.34ea19f0@gandalf.local.home>
 <202404091519.B7B2221@keescook>
 <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Tue, Apr 09, 2024 at 10:25:33PM +0000, Luck, Tony wrote:
> >> I forgot to mention that this makes it trivial for any machine that doesn't
> >> clear memory on soft-reboot, to enable console ramoops (to have access to
> >> the last boot dmesg without needing serial).
> >> 
> >> I tested this on a couple of my test boxes and on QEMU, and it works rather
> >> well.
> >
> > I've long wanted a "stable for this machine and kernel" memory region
> > like this for pstore. It would make testing much easier.
> 
> Which systems does this work on? I'd assume that servers (and anything
> else with ECC memory) would nuke contents while resetting ECC to clean
> state.

Do ECC servers wipe their RAM by default? I know that if you build with
CONFIG_RESET_ATTACK_MITIGATION=y on an EFI system that supports the
MemoryOverwriteRequestControl EFI variable you'll get a RAM wipe...

-- 
Kees Cook

