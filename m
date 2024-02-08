Return-Path: <linux-kernel+bounces-57826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F2884DDDC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B6A1C28075
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5253A6D1C7;
	Thu,  8 Feb 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jKCO4pZE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667536DCF6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387059; cv=none; b=LBMqg6gjcxdBL4JpU+P+PZ9XGwnxdena1RIeRYQjb0MUssNyczkEriXAN8LC55g+rYkNmW0ChoRXGpV0r6ya0JBOXcSxRgOqAa29otr7VoIeyA/JyG4Mym3xnnmUFTeQkipXoZL6T8eGnmO7YiJQHXi3SZFjezvZ57H1oVWV5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387059; c=relaxed/simple;
	bh=NNoN8U+3Fb9w6zQsjlUkGEO/sipgg2956IONnfjBqss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltviFVzzdJhe3rfo/YolcYQXRJsFf11KvFhio4GPjsfvbCi0sey+q0Jy2cG5yhfvn7+wUALzuqTdEMl7sl/SfxxpnouYclg2kSBkSHqJyWsqHlDeGcYmJ2C2GWPMaRJbquN5FR8IOOkD0et8v0OhZRyzT+mjoXP0+wDi1wyaFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jKCO4pZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814D7C43330;
	Thu,  8 Feb 2024 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707387058;
	bh=NNoN8U+3Fb9w6zQsjlUkGEO/sipgg2956IONnfjBqss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKCO4pZErQ13UNhEkgy1p34TR/HpMwOiQpIIqYXZKaXi1xBlnk1SfFvc6UDQrbydl
	 BjZe0sDjQ1ndgRLqO4lyR53cONMsFuLEeeZgm5cOlCMPiwT2754huQcfkor+VWEc+h
	 s7xGDW8QjjmWo6TYGQ0VMwTGDhVChBquEo6AD4yw=
Date: Thu, 8 Feb 2024 10:10:56 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: make wq_subsys const
Message-ID: <2024020813-wool-haste-fe6d@gregkh>
References: <20240206-bus_cleanup-workqueue-v1-1-72b10d282d58@marliere.net>
 <2024020752-tannery-frozen-04ea@gregkh>
 <ZcOxE2nznfq7dcNh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOxE2nznfq7dcNh@slm.duckdns.org>

On Wed, Feb 07, 2024 at 06:34:27AM -1000, Tejun Heo wrote:
> On Wed, Feb 07, 2024 at 10:12:34AM +0000, Greg Kroah-Hartman wrote:
> > On Tue, Feb 06, 2024 at 03:05:06PM -0300, Ricardo B. Marliere wrote:
> > > Now that the driver core can properly handle constant struct bus_type,
> > > move the wq_subsys variable to be a constant structure as well,
> > > placing it into read-only memory which can not be modified at runtime.
> > > 
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > > ---
> > > The maintainer asked [1] for this patch to be received through the
> > > driver-core tree.
> > > [1]: https://lore.kernel.org/all/ZcEeOueCbrltxr_b@slm.duckdns.org/
> > 
> > There is no cross-tree dependency at all, but hey, I'll take it, no
> > worries...
> 
> Ah, my bad. I branched out wq/for-6.9 before rc1 and was assuming the
> dependent commit was still in the driver core branch. I should have just
> pulled linus#master.

The dependent changes are in 6.4, so before -rc1 would have been ok as
well :)

> That said, that patch going through driver-core should still be fine.

Great, will do that, thanks!

greg k-jh

