Return-Path: <linux-kernel+bounces-149710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E68A94DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7188A28274B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A5585659;
	Thu, 18 Apr 2024 08:27:24 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3963C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428843; cv=none; b=ma0ybskYSojbfF+1HvjeG435lh54NLXFKgLrdIdY5oSN2+hXo8aOwNLQnxuYYE8x7b/PxlIIgKidTwRLI5dWGH96g3TJR4SkgqMgmBj9n6tRQPPlgaX+e7MCBwTpd3iAQF+A0YpmtiZLpFWtxrHbK0vA2QrEOq0W6ZbfkxjY6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428843; c=relaxed/simple;
	bh=gD1LUmHfql3mtS2gBELN/uTCh/pOuCFSMFgVqLBip3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGIeZJbzAoJ3H5QlO2pW/ilApP3+E3PCtyeZ1oCA8NXJngQ35t/fLkLdLX5dzMxDLynPVwZ+hf0K20LWKLGdRB6BgVQUL/gLGXY5KJlTZ5U9ZRXkL9p0ZICSQfcjQdm2V8XaTb6Iyr/+u5sSwIUUbNlhi/z40LS8Cs/t2LrOsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6E2B940E024C;
	Thu, 18 Apr 2024 08:27:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IbeOpzmjMZ4c; Thu, 18 Apr 2024 08:27:14 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 735A340E0177;
	Thu, 18 Apr 2024 08:27:09 +0000 (UTC)
Date: Thu, 18 Apr 2024 10:27:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Lyude Paul <lyude@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
Message-ID: <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>

On Wed, Apr 17, 2024 at 05:21:43PM -0400, Lyude Paul wrote:
> Hi! I just wanted to let you know that one of the desktops I use for
> testing no longer seems to boot after this commit (just finished
> bisecting and confirming). The machine hangs before it gets to fbcon,
> and the error I'm seeing in the early boot console is as such:
> 
>    Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC
>    CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc5Lyude-Test+ #20
>    Hardware name: MSI MS-7A39/A320M GAMING PRO (MS-7A39), BIOS 1.10 01/22/2019

Looks like an AMD chipset. Thomas did fix some fallout from the topo
rework on AMD, can you test the tip/master branch pls?

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

