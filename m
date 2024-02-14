Return-Path: <linux-kernel+bounces-65902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F176385538C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769B2B2793C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C5B13DB8F;
	Wed, 14 Feb 2024 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxX8f/LD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2686127B5D;
	Wed, 14 Feb 2024 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940666; cv=none; b=V9RTwYidUajzqQkEY/ElDYc4wEdcC25moPlpYpEgTO4mRcgDaegU0bewjWZJpk5GuHbNmR5/mza7FqK0ZPUmZa1B/6ssphnc8mrkX5NxzdPkOySI4hUdaXmaI+t0a/9Eo+Wk1vIYH8N21QaXyidv7tps7OHq8Az316Y2JGtdOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940666; c=relaxed/simple;
	bh=2ZTZOAZ6r5nb9GcIJQVf/4h+mDGM0VJEAdW0eJhu87g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRhItdsif2PPk1jCbxlOGSLSA4hrJ1KFRyZSp+F37cBTpaNjIp61QVlrHkQ75lkI05WEyRtdQX84o6sIA8tNbdqfR00tGjGuNhWhJ/d600yKZlDlfC4lyrBkip0QaMcyHOmhnM8DgUGkCTj/+0wntXwjzZ0jODPCavBGafP2f94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxX8f/LD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAA2C433F1;
	Wed, 14 Feb 2024 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707940665;
	bh=2ZTZOAZ6r5nb9GcIJQVf/4h+mDGM0VJEAdW0eJhu87g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxX8f/LD6QoHhkCzBrEJ9Wn/ZZYo462aDGZnIA1StRjxsYdJuZz7BcoK64zUhWsCe
	 XKltXqUknpd+PgayVtVtX1h6dZgCbo5zlBkwR//O/XOSRl1Kn74hiwr87uY1DyUATf
	 IzbdHaFdNE+m1dl9tWabnUMjgz1Eq7yT9qQIpdsx9Hrd2JFGfY8C+jyRrgxbC9Qnqe
	 hdwuK5cqwnHkm6EJjkPGAikVekklrlRRc5tuOAJBrISugYyGSEYy/1sDDfgZOdMHzG
	 UdttM6sOYpi4OxsRsC5mTgKowL1t6foyM40J+YZV1aLoUGfLvKu/eJMceolh59B9OY
	 3kCTd3DK6asKw==
Date: Wed, 14 Feb 2024 12:57:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, maskray@google.com, ndesaulniers@google.com,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 00/11] s390: Support linking with ld.lld
Message-ID: <20240214195742.GB1179178@dev-arch.thelio-3990X>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
 <20240214134328.6438-F-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214134328.6438-F-hca@linux.ibm.com>

On Wed, Feb 14, 2024 at 02:43:28PM +0100, Heiko Carstens wrote:
> On Wed, Feb 07, 2024 at 05:14:52PM -0700, Nathan Chancellor wrote:
> > Hi all,
> > 
> > This series allows the s390 kernel to be linked with ld.lld (support for
> > s390 is under review at [1]). This implicitly depends on [2], which was
> > created and sent before it was realized that this series was necessary.
> ...
> > Nathan Chancellor (11):
> >       s390: boot: Add support for CONFIG_LD_ORPHAN_WARN
> >       s390: vmlinux.lds.S: Handle '.data.rel' sections explicitly
> >       s390: vmlinux.lds.S: Explicitly handle '.got' and '.plt' sections
> >       s390: vmlinux.lds.S: Discard unnecessary sections
> >       s390/boot: vmlinux.lds.S: Handle '.init.text'
> >       s390/boot: vmlinux.lds.S: Handle '.rela' sections
> >       s390/boot: vmlinux.lds.S: Handle DWARF debug sections
> >       s390/boot: vmlinux.lds.S: Handle ELF required sections
> >       s390/boot: vmlinux.lds.S: Handle commonly discarded sections
> >       s390: Select CONFIG_ARCH_WANT_LD_ORPHAN_WARN
> >       s390: Link vmlinux with '-z notext'
> > 
> >  arch/s390/Kconfig              |  1 +
> >  arch/s390/Makefile             |  2 +-
> >  arch/s390/boot/Makefile        |  5 +++--
> >  arch/s390/boot/vmlinux.lds.S   | 28 ++++++++++++++++++++++++++++
> >  arch/s390/kernel/vmlinux.lds.S | 28 +++++++++++++++++++++++++++-
> >  5 files changed, 60 insertions(+), 4 deletions(-)
> 
> Now available at:
> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=features
> 
> And should be in linux-next soon.
> 
> Thanks a lot! :)

Thank you for bearing with the issues that came up in the series and
getting it reviewed and accepted quickly!

The ld.lld pull request has been merged into main:

https://github.com/llvm/llvm-project/commit/fe3406e349884e4ef61480dd0607f1e237102c74

and Fangrui requested a backport to 18.1.0, so it is possible that
people will get access to this even quicker:

https://github.com/llvm/llvm-project/pull/81675

I did not CC you all on this one but it is needed to avoid a link error
with ld.lld when CONFIG_DEBUG_INFO_BTF is enabled but it is not specific
to s390 so it will go via the kbuild tree (hopefully for 6.8):

https://lore.kernel.org/20240212-fix-elf-type-btf-vmlinux-bin-o-big-endian-v2-1-22c0a6352069@kernel.org/

With that change on top of features, all my builds pass successfully
with ld.lld :) I'll be sending another change your way shortly for
something that came up during my testing with GCC + ld.lld.

Cheers,
Nathan

