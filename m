Return-Path: <linux-kernel+bounces-89166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A47686EB84
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A03B21EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7775C59141;
	Fri,  1 Mar 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkBYj13/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3954273;
	Fri,  1 Mar 2024 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330192; cv=none; b=ZAExKeK/nrm3fwZW6igP9MLuao0lMZs1dfqi+xd35eQebf4smrN9SxYD8WM2emtE282v0IHbDgqj2WVrzghCu6Ji4KQYfmvc6ZOHieptOR9Hd5/XXgZsVfW3bBwUym7u7imwxTYk7fuNIWQogLBVEWwpbwcD4QyexiRZwL7dijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330192; c=relaxed/simple;
	bh=q9UABsAyzVvzna/Tm8mCWvvTktUvuLlJ2k9eH6PTep4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tBVJVXby5IEfeGys3B6Z/Ba1+2kzCfSS92YJhcJMgKknMpQe9G8i5c1CungJf9pU3psLypKZGbgL4jB309IlqpXMTsHsETyz9yexLlIgoxiMUSo8VX9B4NcpWKdU3Q/QfGHdMcHh0SRlWwIJvGnQHOumuIk/rmPYOyEgkbSULW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkBYj13/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0692BC433C7;
	Fri,  1 Mar 2024 21:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709330192;
	bh=q9UABsAyzVvzna/Tm8mCWvvTktUvuLlJ2k9eH6PTep4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pkBYj13/IpRqvB8QY+NKFXvyFlaEV/DO70V8JI0iu7z95dFtwg1ltpxvh61Woby+a
	 DnkGBGquZr/O/vse0kpnT8yqEJT4LyxBymgNxLVQyGlSTsJDQMhA3+IRJ1bI4Xj0Ui
	 zJyiFKWXerHzyXe/nrxiXqAOmTHu87J+CcPStp+qScsB3ct+dI0K6C/CijzgdyCGN6
	 WRIXDRZOhI+Dr3YLp7f+Nzpw+vd1vW2pU/Ho7KOhg9Y0aC9Imt6nzE40EjGNVfoZYl
	 f1Y4OFqA6M80em7X5sxtGBgz2UOejcPwvPKOzd6+pvnJB15TumKfEw9/81yZTVyuy6
	 NuyrXElm4l9Ow==
Date: Fri, 1 Mar 2024 15:56:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
	jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org,
	will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
	dan.carpenter@linaro.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: avoid sending explicit ATS invalidation
 request to released device
Message-ID: <20240301215630.GA409512@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f258426b-cfbe-42c8-9c6a-42452837c73c@linux.intel.com>

On Fri, Mar 01, 2024 at 09:50:36AM +0800, Ethan Zhao wrote:
> On 3/1/2024 5:06 AM, Bjorn Helgaas wrote:
> > On Wed, Feb 28, 2024 at 10:31:38PM -0500, Ethan Zhao wrote:
> > > The introduction of per iommu device rbtree also defines the lifetime of
> > > interoperation between iommu and devices, if the device has been released
> > > from device rbtree, no need to send ATS invalidation request to it anymore,
> > > thus avoid the possibility of later ITE fault to be triggered.
> > > 
> > > This is part of the followup of prior proposed patchset
> > > 
> > > https://do-db2.lkml.org/lkml/2024/2/22/350
> > Please use https://lore.kernel.org/ URLs instead.  This one looks like
> > https://lore.kernel.org/r/20240222090251.2849702-1-haifeng.zhao@linux.intel.com/
> > 
> > > To make sure all the devTLB entries to be invalidated in the device release
> > > path, do implict invalidation by fapping the E bit of ATS control register.
> > > see PCIe spec v6.2, sec 10.3.7 implicit invalidation events.
> > s/implict/implicit/
> > 
> > s/fapping/?/  (no idea :)  "flipping"?  Oh, probably "flapping" per the
> > comment below.  But I think "flapping" is ambiguous; "setting" would be
> > better)
> 
> Yup, like the memory bit flipping, no idea what is the right word,
> setting one bit to 0, then 1, then back to 0. perhaps details the
> setting action 0-->1-->0 ?

In PCIe spec-speak, "Set" means "assign 1 to this", and "Clear" means
"assign 0 to this".

Maybe you could copy the spec language like this:

  Invalidate all ATC entries by changing the E field in the ATS
  Capability from Clear to Set, which causes an implicit invalidation
  event.

Bjorn

