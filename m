Return-Path: <linux-kernel+bounces-7356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E0381A678
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497871F234F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920EC47A7F;
	Wed, 20 Dec 2023 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GfmTgFsO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C8447A42;
	Wed, 20 Dec 2023 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P5Zs3qECdjn7uq4jzjXFG/AJJqVMTzM5KFD78T4GWU4=; b=GfmTgFsO7WZPUWeQIz8wIkLZ78
	QXBR2nKA1E1i7bc9cqlCtY9FA1rTaF5acFIypfpjPlpfwK1VOFWmA5eadcG2H/amCG00+cEZUBh+n
	9NmflrX0pngURp6SJeC9zhL0f+YuyA4P/mls6iJO5P8o58AAgNFPp5+OqL3/1KVhuZvhSq+sdMTkk
	RbBfUUFCYJNnsU/8a8Fs2f4gAA+ZaDX5OgGJavV/IGKMR8ilaozWC33JHq56s5vxyZH/CGAM/6nEr
	vvZqgQNVHHZSmJ8yt5hGqDGZrJWhl7oPmJzjvP79kjhUeWdQ3lekSsgB45nOoJ/vUkuZhsys4+rMH
	yteTPRUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rG0VK-000X0K-2h;
	Wed, 20 Dec 2023 17:37:10 +0000
Date: Wed, 20 Dec 2023 17:37:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Baoquan He <bhe@redhat.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/sh/kernel/relocate_kernel.S:38: Error: invalid operands for
 opcode
Message-ID: <20231220173710.GX1674809@ZenIV>
References: <202312182200.Ka7MzifQ-lkp@intel.com>
 <ZYJ/M1HZ9ITfs4qe@MiWiFi-R3L-srv>
 <20231220060030.GV1674809@ZenIV>
 <ZYLrxFyei79R5D8N@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYLrxFyei79R5D8N@MiWiFi-R3L-srv>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 20, 2023 at 09:27:32PM +0800, Baoquan He wrote:
> Since the kexec_core code building depends on CONFIG_MMU=y, we may
> need to add dependency on MMU for ARCH_SUPPORTS_CRASH_DUMP. I made below
> change, do you think it's OK?
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 7500521b2b98..fe1500871648 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -548,6 +548,7 @@ config ARCH_SUPPORTS_KEXEC
>  
>  config ARCH_SUPPORTS_CRASH_DUMP
>         def_bool BROKEN_ON_SMP
> +       depends on MMU
>  
>  config ARCH_SUPPORTS_KEXEC_JUMP
>         def_bool y
> 

I'm *not* familiar with crashdump or kexec machinery, let alone the
current changes in there, so take the following with a cartload of
salt, but...  does sh crash dump support depend upon the code in
question?  From quick grep it looks like we only want it in machine_kexec(),
so the conditionals used in the commit in question might be wrong...

