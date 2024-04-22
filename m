Return-Path: <linux-kernel+bounces-153080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2B48AC8BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905D51C20D27
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B35254FA1;
	Mon, 22 Apr 2024 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnXjpYmU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E913D297;
	Mon, 22 Apr 2024 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777604; cv=none; b=Oy5WSjBKOhXBj5d7kNr1YKLwoCo9amfoRcgk31b/V8r68AQ5N937amDvcCK2aRgEH62M4MdIrrqWyUuDjCJ4gMogZ0aPBfxlYlkQNxcIAqjH74f3sMbWyAf1gNKeXENBfjyx60AaU8NKU4zYzceNabL63QEaTG6tBZcguZHQrQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777604; c=relaxed/simple;
	bh=nZb1WqOKzpgix7JF8C81SkQWvG7tYsydr8OknjFa2/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAbpt1SHVX5g/wnb3i6EhVeeZbDwL/a+A3thMc+LhBu2VsDOxCuuGkDDfePBJ5CA+LN2i5HM+z6/AsNbcpj/FXB1WJUJZg7lyARmkqcy+eKto159kHG1zpWmtKTtxNsWgZRh/ExpXHVgBCsQ5ItXtMwoXGACWXOlRzCZ1EP/ox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnXjpYmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1DEC113CC;
	Mon, 22 Apr 2024 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713777604;
	bh=nZb1WqOKzpgix7JF8C81SkQWvG7tYsydr8OknjFa2/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnXjpYmUkjd+sbGilXiYyKMgQijrPvrQxNUMTxQ3sCteoQlQ9gwJrU+mjHtH7VFLF
	 vI0fWmNdDFGFUTO2uSdbQAgCsgN0TYLHBv4GgxGsDt6Tdjnkf+8BcV5YTK9dKjJi42
	 xMqJTi+n5IaSYLNCgyWiOBX+FOWNPapwGiYEXWHNQmKNx56SORlAmAAxDM9WAG/8yj
	 77Z4zt/izUVens3e3PVA4u2ldSvZTEREiEa0FvNE5L4i+Ic8IuJgTuE6mQw4ANKMfT
	 0h4kVTKQiijNjfUmYt3wyWUFmZ2XZhi6UqafkbOuSAiKbM+MTIgMAhPnIMMXcfw3dd
	 iRITs0SPZNKOQ==
Date: Mon, 22 Apr 2024 12:18:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Andreas Dilger <adilger@dilger.ca>, Arnd Bergmann <arnd@arndb.de>,
	Changbin Du <changbin.du@huawei.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ingo Molnar <mingo@kernel.org>,
	Krister Johansen <kjlx@templeofstupid.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [init]  b8de39bd1b:
 BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_code
Message-ID: <ZiYrdnbw5z1ajeRw@kernel.org>
References: <202404221524.4954a009-oliver.sang@intel.com>
 <20240422082942.B750cniQ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422082942.B750cniQ@linutronix.de>

On Mon, Apr 22, 2024 at 10:29:42AM +0200, Nam Cao wrote:
> On Mon, Apr 22, 2024 at 03:45:00PM +0800, kernel test robot wrote:
> > kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_code" on:
> > 
> > commit: b8de39bd1b76faffe7cd91e148a6d7d9bf4e38f7 ("init: fix allocated page overlapping with PTR_ERR")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> I can reproduce the problem. I rebased this commit onto v6.8.7, I can still
> observe the problem.
> 
> No immediate idea what is the problem. Backtrace from gdb goes crazy:
> 
> (gdb) bt
> #0  0xffffffffb2074ded in ?? ()
> #1  0x00000000000000a1 in ?? ()
> #2  0x00000000000000a1 in ?? ()
> #3  0x000000007ffff000 in ?? ()
> #4  0x00000000543ff000 in ?? ()
> #5  0x0000000000000000 in ?? ()

The kernel config here has CONFIG_DEBUG_VIRTUAL=y, so __pa translates to
__phys_addr() in arch/x86/mm/physaddr.c and __pa(-PAGE_SIZE) triggers

		VIRTUAL_BUG_ON(y >= KERNEL_IMAGE_SIZE);

x86 has __pa_nodebug() that does not do bounds check, but it cannot be used
in generic code because no other arch except s390 define it.

For now I don't have ideas how to make this work in the general case, so
probably we should only fix riscv for now.
 
> @akpm: drop this commit until this is figured out?
> 
> Best regards,
> Nam
> 

-- 
Sincerely yours,
Mike.

