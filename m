Return-Path: <linux-kernel+bounces-31736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7677383331D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910D81C2206A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9BC2D6;
	Sat, 20 Jan 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugdFxA+M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAB539D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705735727; cv=none; b=iy/wvS+b980SLtIIDAsE5ubzBl8oedGQDyCuOFxZsuPbBEhHapnkrq9ql0TokldB+Z1Pebd40bs/kz7WFvyg4vuH4GmLi94Bj+gcYfUde5FM1WYo0MEsWRA6sw7DomVX/4BCtKXRfRSeUIRDXv/rIyLuhdKlkacfoR3wcZLy6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705735727; c=relaxed/simple;
	bh=Uml6h9uAYwNMqewrmoFPwoSquZYplcK3FVLAj/jOz/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOzUnhl4fYt9ZACtalo1YPKWDXpWIYBoF1N0Q2qW8fsIZVVQpbMO3ShAXG5J06g4b2FtVRKQ+NenpB9ffVZ4cxDD+QPJA+x4kd/9Ik73iE2u+I+ByMgBTzd8rKep+lSHOEydGPcUpnL2pitVAXXpypCgpwDs+2eFTUuWV74FMJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugdFxA+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29F7C433F1;
	Sat, 20 Jan 2024 07:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705735727;
	bh=Uml6h9uAYwNMqewrmoFPwoSquZYplcK3FVLAj/jOz/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugdFxA+MsTD0rQs0aPWRSb9aulIDlJew3KJ8kHlQ4heHHxpYSwk/1S69OZcIA0Ydk
	 E0hsl4y9Vf9lMHResy5wwgNw72uE3hfmA9129u9AZAMYpBQ+VxFkPIT0wpUrnV7om+
	 Z9w9uiSXvZyGLUpUGEIovouap8pIKPnQtRfksGypqRCGnjQY1EYxm5yfE5jidbi/9v
	 RO8WZcMuW6MX3OAlSw9zbMLp/HDLpoS9hUXbiqk5n1d4wGkhO/ipi4ZvPYDISzAYi5
	 B/6vQzk9VCifilMY3MN1TbRomKk7Z09BQPmF32QbenJtsIcVhd3sYjNj/0092QRHNc
	 NgSsd6YuQnO0w==
Date: Sat, 20 Jan 2024 08:28:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Fullway Wang <fullwaywang@outlook.com>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, 
	fullwaywang@tencent.com, jannh@google.com, akpm@linux-foundation.org
Subject: Re: [PATCH] fs: romfs: Fix potential uninitialized memory leak
Message-ID: <20240120-holzrahmen-uninteressant-0fcb180e88c9@brauner>
References: <PH7PR20MB5925B0893BC44476B0D2E993BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
 <20240119-heilkraft-umgefahren-8f84c6395f6b@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240119-heilkraft-umgefahren-8f84c6395f6b@brauner>

On Fri, Jan 19, 2024 at 03:21:04PM +0100, Christian Brauner wrote:
> On Thu, 18 Jan 2024 15:14:12 +0800, Fullway Wang wrote:
> > romfs_dev_read() fetches a caller-supplied number of bytes from the
> > backing device in an all-or-nothing manner.
> > 
> > Commit bcf85fc fixed CVE-2020-29371, which exposed the bug when
> > the requested length crossed the filesystem size limit, the number
> > of bytes to requested was truncated. However, in romfs_readdir()
> > in super.c, the requested number is firstly truncated with
> > romfs_dev_strnlen() then passed to romfs_dev_read(), leaving
> > the bug exploitable still.
> > 
> > [...]
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
> 
> [1/1] fs: romfs: Fix potential uninitialized memory leak
>       https://git.kernel.org/vfs/vfs/c/530041d36e37

This fails to even compile. Dropped.

