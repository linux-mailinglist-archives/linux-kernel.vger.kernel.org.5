Return-Path: <linux-kernel+bounces-103557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DCB87C111
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790E31C2127F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDC173514;
	Thu, 14 Mar 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIHwkShn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D62399
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432977; cv=none; b=rsDO1solvFlWcRPddwuYSgz6cnUJpGkIQWNAIHGSPJXFuupTJmEZs9VhVX7d/K2e9a4eA/gZFNJTWeHoTvi4Lb3xCcrwm0l+51AL3R7qsxOfl9iS5Z4I1ueuwIX6+5RVZ1P63esbA+y+/qhy1gnuJPQxHhLK9hybiBVNcuk4PHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432977; c=relaxed/simple;
	bh=U8AyetdLrhnWBQCfPFpv6tTgew9AS0AAM56e79RtgeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCm5ChSZfuYsNaqDkxtjOAFrlXcHwZtdh8Cw5U1ZwR0vKU5BvH3ZrsaqH+3+DWAj1iDVWkK1P7hQ9z58TEMJBcEZeTjCGKvL/31HUdsK6g5HOeN8Mh3ypo/9Sl3F9AWaxuCfxQDjceh3uuCXElmXj9P953z9x282wLcE9d4TH0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIHwkShn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72B1C433F1;
	Thu, 14 Mar 2024 16:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710432977;
	bh=U8AyetdLrhnWBQCfPFpv6tTgew9AS0AAM56e79RtgeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIHwkShnXphYqFArdN0hG3XJx0vwoeoLih4Bo5c9IFPa6h3zvCl9niRZeulLJKt71
	 HrlmHYATceiLkvKZss3yUOaCmesxi4c0ry8fGaSRowDsATKyQI+sR+LeaIDlT2u+HC
	 oigBQf5i3j4Qd0O/mhg3ZXAXBVjVixMRig2oXOPhoYwP9iemI0HyhJUbMbi8Nz+rUk
	 gNWoB1ikRk2G7KKeJt+mhjqi1MrqR53m85A8E4GqnH89UgvUy8G+67U2pKScRTCwf4
	 qNdJyKuvI79ST5R1khU7BNANNPIvGM2Vhv+fxYg1BVfzBpdc5A4jgJC9PxmqNI2z8j
	 AJw9e3/zQ2bug==
Date: Thu, 14 Mar 2024 09:16:15 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com,
	Ed Tsai <Ed.Tsai@mediatek.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] f2fs: fix to avoid use-after-free issue in
 f2fs_filemap_fault
Message-ID: <ZfMiz67zynbEFBl9@google.com>
References: <20240314020528.3051533-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314020528.3051533-1-chao@kernel.org>

On 03/14, Chao Yu wrote:
> syzbot reports a f2fs bug as below:
> 
> BUG: KASAN: slab-use-after-free in f2fs_filemap_fault+0xd1/0x2c0 fs/f2fs/file.c:49
> Read of size 8 at addr ffff88807bb22680 by task syz-executor184/5058
> 
> CPU: 0 PID: 5058 Comm: syz-executor184 Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x163/0x540 mm/kasan/report.c:488
>  kasan_report+0x142/0x170 mm/kasan/report.c:601
>  f2fs_filemap_fault+0xd1/0x2c0 fs/f2fs/file.c:49
>  __do_fault+0x131/0x450 mm/memory.c:4376
>  do_shared_fault mm/memory.c:4798 [inline]
>  do_fault mm/memory.c:4872 [inline]
>  do_pte_missing mm/memory.c:3745 [inline]
>  handle_pte_fault mm/memory.c:5144 [inline]
>  __handle_mm_fault+0x23b7/0x72b0 mm/memory.c:5285
>  handle_mm_fault+0x27e/0x770 mm/memory.c:5450
>  do_user_addr_fault arch/x86/mm/fault.c:1364 [inline]
>  handle_page_fault arch/x86/mm/fault.c:1507 [inline]
>  exc_page_fault+0x456/0x870 arch/x86/mm/fault.c:1563
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> 
> The root cause is: in f2fs_filemap_fault(), vmf->vma may be not alive after
> filemap_fault(), so it may cause use-after-free issue when accessing
> vmf->vma->vm_flags in trace_f2fs_filemap_fault(). So it needs to keep vm_flags
> in separated temporary variable for tracepoint use.
> 
> Fixes: 87f3afd366f7 ("f2fs: add tracepoint for f2fs_vm_page_mkwrite()")
> Reported-and-tested-by: syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/000000000000e8222b060f00db3b@google.com
> Cc: Ed Tsai <Ed.Tsai@mediatek.com>
> Cc: Hillf Danton <hdanton@sina.com>

Suggested-by: Hillf Danton <hdanton@sina.com>

I modified to "Suggested-by". Please let me know if this doesn't work.

> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index a47c57e813bb..c19e55a3e50e 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -39,6 +39,7 @@
>  static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
>  {
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
> +	vm_flags_t flags = vmf->vma->vm_flags;
>  	vm_fault_t ret;
>  
>  	ret = filemap_fault(vmf);
> @@ -46,7 +47,7 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
>  		f2fs_update_iostat(F2FS_I_SB(inode), inode,
>  					APP_MAPPED_READ_IO, F2FS_BLKSIZE);
>  
> -	trace_f2fs_filemap_fault(inode, vmf->pgoff, vmf->vma->vm_flags, ret);
> +	trace_f2fs_filemap_fault(inode, vmf->pgoff, flags, ret);
>  
>  	return ret;
>  }
> -- 
> 2.40.1

