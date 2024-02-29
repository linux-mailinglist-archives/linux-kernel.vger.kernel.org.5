Return-Path: <linux-kernel+bounces-86463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC786C5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7991C1F27041
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC49A60EEB;
	Thu, 29 Feb 2024 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr0nGGfQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DBD612CE;
	Thu, 29 Feb 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199791; cv=none; b=VeGg7lwFHJiF4Iof8GM/jgLwSD7kC36+a650IN5xiC7saoYgSy/yN87jlpyvonxcazVvxCWNox3T6m+qAGFjgqYF8VVhK7XKAo5MHVTBbNlaCekHWDvWFE0s3V6Ue8YgzMVX6jj/qCtiHEWlu1MDZ8/a3EyyOk/KrEtfTw4HAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199791; c=relaxed/simple;
	bh=aDbHWCEN87gifEkin69igfn4UnaUalbm7Xpzz7Tjuw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GidAiNcg8fvKSQwsYP9mGe7GJmLDEqQpXvGC/E53ASWYTy2hYf0IRSCNlF+sbB5QeUl8wlgpyfMGkrfT4ENmaepHJN1nRWA/OyVZrjNeFpe/0nl/S6Pnb3wI/KXzBRbmWkcvpQX03s3z/VZbrz3LyvTGoE/R3XtRIlLdga3c6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr0nGGfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1605BC43390;
	Thu, 29 Feb 2024 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709199790;
	bh=aDbHWCEN87gifEkin69igfn4UnaUalbm7Xpzz7Tjuw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cr0nGGfQcPJzRlpgBOWurWE1FlP0/lVOeyoJ0y+JMWFPkBi7Z8r358ncafvax+LcU
	 Utr4eykovmyPVLbRrMd9NNaM5I2CsGLModtc7FUdwAqEqrde8pi5ztd3SWRrtB7q2n
	 yFcYOJo7yRqY5TEgHSWuwo52+FQvMzf/Px27hOyrwc90xeLmHZ8loRRFRRfZFIgy8H
	 6nplNOpn0Z+LhIHagrRGsVo3ANvtj8700A0dL9clQp1aeAWYxzr+8tRSUX5W6L9bWb
	 vZzJ+9zg/s/2116gI22aOiKJiQCK8U4Z3pzPLfAI3O2e7nwXPGiAhbLXW8C5yO/cnj
	 iqjhmV+h7jGzw==
Date: Thu, 29 Feb 2024 11:42:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Yaxiong Tian <13327272236@163.com>
Cc: David Hildenbrand <david@redhat.com>, rafael@kernel.org, pavel@ucw.cz,
	len.brown@intel.com, keescook@chromium.org, tony.luck@intel.com,
	gpiccoli@igalia.com, akpm@linux-foundation.org, ardb@kernel.org,
	wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
	will@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>,
	xiongxin <xiongxin@kylinos.cn>
Subject: Re: [PATCH] PM: hibernate: Fix level3 translation fault in
 swsusp_save()
Message-ID: <ZeBRfxQ8WTEVzpfL@kernel.org>
References: <20240226034225.48689-1-13327272236@163.com>
 <8d70939f-ca14-4167-9647-b8f44ddcbb98@redhat.com>
 <ZdxWcG2XCqBum3_R@kernel.org>
 <3399d2af-3d42-4ac1-9b74-8475bec25f7f@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3399d2af-3d42-4ac1-9b74-8475bec25f7f@163.com>

On Tue, Feb 27, 2024 at 03:51:25PM +0800, Yaxiong Tian wrote:
> 
> 在 2024/2/26 17:14, Mike Rapoport 写道:
> > On Mon, Feb 26, 2024 at 09:37:06AM +0100, David Hildenbrand wrote:
> > > On 26.02.24 04:42, Yaxiong Tian wrote:
> > > > From: Yaxiong Tian <tianyaxiong@kylinos.cn>
> > > > 
> > > > On ARM64 machines using UEFI, if the linear map is not set (can_set_direct_map()
> > > > return false), swsusp_save() will fail due to can't finding the map table
> > > > under the nomap memory.such as:
> > can_set_direct_map() has nothing to do with presence or absence of the
> > linear map.
> > 
> > Do you mean that kernel_page_present() presumes that a page is present when
> > can_set_direct_map() returns false even for NOMAP ranges?
> Yes， in swsusp_save()->copy_data_pages()->page_is_saveable(),
> kernel_page_present() presumes that a page is present when
> can_set_direct_map()
> returns false even for NOMAP ranges.So NOMAP pages will saved in after,and
> then
> cause level3 translation fault in this pages.

So this should be the description of the problem in the changelog rather
than saying "if the linear map is not set (can_set_direct_map() return
false)"

> > > > QEMU ARM64 using UEFI also has the problem by setting can_set_direct_map()
> > > > return false.
> >
> > Huh?
> > Why would you do that?
> >
> I discovered this problem when upgrading from 5.4 to 6.6 using the 5.4
> configuration.
> So I using latest linux-next code,find the problem still exist.To rule out
> the effects
> of a particular machine，I also use qemu to check it.

I believe this can be reproduced if you boot with rodata=off and then
a better description would be something like

	This issue can be reproduced in QEMU when booting with rodata=off

-- 
Sincerely yours,
Mike.

