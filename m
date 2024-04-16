Return-Path: <linux-kernel+bounces-147426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61E68A73DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60DD1C2187F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967EA1386D4;
	Tue, 16 Apr 2024 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kl9ZtWxL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B48137C26;
	Tue, 16 Apr 2024 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293475; cv=none; b=Ezera1T9exkxHuHIQwXEntyFPRIUHvdRDNM7JW6wUikT3d8JCw9TOkbr215YkBFe0cvkzOrG09sd4bZyKMmEfYLrO83f0/jLoAeNt9dp3ta1bOS6MbGSLZpy6g29BZ+tZzBc47JC2b60+OUzGUgo8OKkVU3bUOTPNXMglr9zRzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293475; c=relaxed/simple;
	bh=Tb/H+4YgFd51hFSuhrwmFRYeEJAYFHRd90KcANVm3cw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fjWim0Lc5AyNM5dztmFFF5rlF/t1k55GlXTXV4iYv05oi/JrVa7daqEzpoWxX5lgS8wTnwSvN1RDKYAMZTTLjW+IEC/5tyxJkEy7s5w/CRrqmNigxnhAq803gzLSSYhtvG8pHvQwOseGObU99/NkG2l4xZofChgbQHoHt8wvZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kl9ZtWxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F65C113CE;
	Tue, 16 Apr 2024 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713293475;
	bh=Tb/H+4YgFd51hFSuhrwmFRYeEJAYFHRd90KcANVm3cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kl9ZtWxL+gLv41LGOBtWYoQCosg4WXkp8I02rcJXgYbuGdJzlSYtJPWtMpLnQiJ2S
	 K5mNaSwdh8aJPfFz12MgnIMpwB3uXA8/oGYHfmAeWwPxXAFJSPf+IDI5Q5u2NIMXXV
	 3LJY0TBQ3u0u1ZIDOOg3qVPXcVv/gimqaAcdjNWg=
Date: Tue, 16 Apr 2024 11:51:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Qiang Zhang <qiang4.zhang@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm-hotfixes tree
Message-Id: <20240416115114.8f1673a2490d31f77d276a41@linux-foundation.org>
In-Reply-To: <20240416173525.13bfd8dc@canb.auug.org.au>
References: <20240416173525.13bfd8dc@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 17:35:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the mm-hotfixes tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> lib/bootconfig.c:911: warning: Function parameter or struct member 'early' not described in '_xbc_exit'
> lib/bootconfig.c:911: warning: expecting prototype for xbc_exit(). Prototype was for _xbc_exit() instead
> 
> Introduced by commit
> 
>   aaeda6237dec ("bootconfig: use memblock_free_late to free xbc memory to buddy")
> 
> from the mm-hotfixes-unstable branch of the mm-hotfixes tree.

Thanks.  How's this?

--- a/lib/bootconfig.c~bootconfig-use-memblock_free_late-to-free-xbc-memory-to-buddy-fix
+++ a/lib/bootconfig.c
@@ -901,7 +901,8 @@ static int __init xbc_parse_tree(void)
 }
 
 /**
- * xbc_exit() - Clean up all parsed bootconfig
+ * _xbc_exit() - Clean up all parsed bootconfig
+ * @early: in early xbc init error
  *
  * This clears all data structures of parsed bootconfig on memory.
  * If you need to reuse xbc_init() with new boot config, you can
_


