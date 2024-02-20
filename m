Return-Path: <linux-kernel+bounces-73624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7FB85C540
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C102854B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D6C14A4C8;
	Tue, 20 Feb 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="okAhoWU3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E02578B75
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458875; cv=none; b=sOX3G65Lv7hDR17nmDXWoRuOB6imRpnz2IavE8vJS7kGRh9isNM7YReupw32kzK53vMVpsOIIbnK6mLmjtOF+xjbbYVWOq2YOq2r2i3R/xjH3nHDArNq9I4+ONNQnKSYvOegO9MOxtR2kc8QsZtXb6927LlgRAF6FOeaXsLnmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458875; c=relaxed/simple;
	bh=zyWiwr3kr66iv0H03kPtFHH2VSqtORK0ZNZADANCIcU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=R9uSfQR+K9qwssBtIuJ3D9HEhkc06pt+O4VH4EZbK2jHnPOXPWJAwb1QJWkcB/AY28ffsXPWsElfhSiUUrLu1oWpl2O18+hMoZmgWQhvC+aI7OrncRGly9XtsPZhQF9/gKZFgPXZdq2ll1gWmkEVQpkAqOuUx5/g0o9A/WVHDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=okAhoWU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B1DC433C7;
	Tue, 20 Feb 2024 19:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708458874;
	bh=zyWiwr3kr66iv0H03kPtFHH2VSqtORK0ZNZADANCIcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=okAhoWU32N05cVz5+oGrrMXDJO7CCJ1uiIk/Bu7Kpix5pkm2k2o/AyZ1ED3wH44Jq
	 G6nrzwhvSXazF055COs6GP12x13Odg9UqMizQi/Xv30izglzJd9njeOeYQRWJOZT7K
	 NZM9xRpW8qKT0CXJaTJKFjRkXpSnKPzKbGMDVSuQ=
Date: Tue, 20 Feb 2024 11:54:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: rulinhuang <rulin.huang@intel.com>
Cc: urezki@gmail.com, colin.king@intel.com, hch@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lstoakes@gmail.com,
 tim.c.chen@intel.com, zhiguo.zhou@intel.com, wangyang.guo@intel.com,
 tianyou.li@intel.com
Subject: Re: [PATCH v2] mm/vmalloc: lock contention optimization under
 multi-threading
Message-Id: <20240220115433.4d76e50c46454f7aabb7b93d@linux-foundation.org>
In-Reply-To: <20240220090521.3316345-1-rulin.huang@intel.com>
References: <20240209115147.261510-1-rulin.huang@intel.com>
	<20240220090521.3316345-1-rulin.huang@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 04:05:21 -0500 rulinhuang <rulin.huang@intel.com> wrote:

> When allocating a new memory area where the mapping address range is
> known, it is observed that the vmap_area lock is acquired twice.
> The first acquisition occurs in the alloc_vmap_area() function when
> inserting the vm area into the vm mapping red-black tree. The second
> acquisition occurs in the setup_vmalloc_vm() function when updating the
> properties of the vm, such as flags and address, etc.
> Combine these two operations together in alloc_vmap_area(), which
> improves scalability when the vmap_area lock is contended. By doing so,
> the need to acquire the lock twice can also be eliminated.
> With the above change, tested on intel icelake platform(160 vcpu, kernel
> v6.7), a 6% performance improvement and a 7% reduction in overall
> spinlock hotspot are gained on
> stress-ng/pthread(https://github.com/ColinIanKing/stress-ng), which is
> the stress test of thread creations.

vmalloc.c has changed a lot lately.  Please can you work against
linux-next or against the mm-unstable branch of
//git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Thanks.

