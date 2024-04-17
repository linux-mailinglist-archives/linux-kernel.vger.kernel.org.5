Return-Path: <linux-kernel+bounces-149223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC6C8A8D53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9B7286F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E16A481B5;
	Wed, 17 Apr 2024 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f4Xj0CYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9165125DB;
	Wed, 17 Apr 2024 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387183; cv=none; b=QtEmQLk61Kz3vLT1xWHxCTb/DDYUOczE/zOa5dXXCIDNJNAwN33KlnHDUMJn0yb0i26288fBA/zC0AfneMD+Wf20xcZyPKcM6Nn26dbaDkjG+ePHYusn0o0U5LUYwlhQ+K2Qm/qT6nPAh4GkLJrLVI+ATRSuuy5bR8yB4+GnY78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387183; c=relaxed/simple;
	bh=Cj/QfjL61EBDCyKPar9P9bXh+y6kXA1dZvl1Mau+d8g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YEXJiywXrq8VnfWrrgnz6yGZzPKovN9vM4UJD660qdc1sYSYJp6/+/APbzBUdcbgQM3Ao52CPipE1XAVqYE7F7wowFBPyU3Kv056hDtSaWfvW5Ls3v5/0h7RuhH8vPYd1FUg+WVSa9SnOYfsNoj+Pz4Yq2uweLL1WKTe1nHUFK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f4Xj0CYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA5BC072AA;
	Wed, 17 Apr 2024 20:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713387183;
	bh=Cj/QfjL61EBDCyKPar9P9bXh+y6kXA1dZvl1Mau+d8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f4Xj0CYIX51NTtIn+FYtxdR5IJSNeNDoU/IxuNSmA5c9Kbsa9KlfN7Qtz7dk+8S55
	 nvc7Ub4+SMJJjDUrMXtHUd2y8s8471H6PvtMU3zacauC4FUGALpJHL8TUSyycRsLCK
	 HC1PWQvEVS45kEQGO+7mI6Bx2mu9F6BICDYlC+hQ=
Date: Wed, 17 Apr 2024 13:53:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Qiang Zhang <qiang4.zhang@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm-hotfixes tree
Message-Id: <20240417135302.2f5c6a9ab9eb2ef58e1bdc7b@linux-foundation.org>
In-Reply-To: <20240417152904.17fa874d@canb.auug.org.au>
References: <20240416173525.13bfd8dc@canb.auug.org.au>
	<20240416115114.8f1673a2490d31f77d276a41@linux-foundation.org>
	<20240417152904.17fa874d@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 15:29:04 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> >   * This clears all data structures of parsed bootconfig on memory.
> >   * If you need to reuse xbc_init() with new boot config, you can
> > _
> > 
> 
> OK, so the above two warnings went away, but now I get
> 
> lib/bootconfig.c:909: warning: expecting prototype for _xbc_exit(). Prototype was for xbc_exit() instead
> 
> Commit
> 
>   aaeda6237dec ("bootconfig: use memblock_free_late to free xbc memory to buddy")
> 
> that was in the mm tree yesterday is not there now.

oop, sorry, fat-fingered that one.  Thanks, I brought back
bootconfig-use-memblock_free_late-to-free-xbc-memory-to-buddy.patch.

