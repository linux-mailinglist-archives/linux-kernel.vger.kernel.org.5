Return-Path: <linux-kernel+bounces-148902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B90C8A88C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A05283B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E290148849;
	Wed, 17 Apr 2024 16:23:04 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528DE1487ED;
	Wed, 17 Apr 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370983; cv=none; b=a+IB9ezKbBBYIsLAQ9M4zuhFaLlAY0MGjO7QdvFJMXAdRRHIMK+vZG/ZlsG3YPy/1j7s0yYU7ZRm67LQ5+tBjLwBiKMWlHvQQNK4xVX9B6uOpjfGvgUhYoa12Gm1516dlY6no/Ex6ZtNHhRx7gaA0KFD41mBq6fw/mCcCjBKcfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370983; c=relaxed/simple;
	bh=pNpAR6fUyvIyqKi57y6ZYwGyUeQlHqA/Ixs/InAdn10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7ildxWrvJfTlz0MsJIhLbrvmaxI5fE0/TryQ9vsrJoGmASJoww5JPQW1A8dt8thMNn8PfstzYA+QHhgwWeoymP7IKIP50rLJvnOuzsAAigaBFFe/5XdBvYyWsBX4KH/0CKxoqzLtP4O9hBIzgR7aHbo7h9TpWqVfPm3cyQs+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 513CD227A88; Wed, 17 Apr 2024 18:22:57 +0200 (CEST)
Date: Wed, 17 Apr 2024 18:22:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <20240417162257.GA8098@lst.de>
References: <ZhRSVSmNmb_IjCCH@gardel-login> <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com> <ZhT5_fZ9SrM0053p@gardel-login> <20240409141531.GB21514@lst.de> <Zh6J75OrcMY3dAjY@gardel-login> <Zh6O5zTBs5JtV4D2@kbusch-mbp> <20240417151350.GB2167@lst.de> <Zh_vQG9EyVt34p16@gardel-login> <20240417155913.GA6447@lst.de> <Zh_0bfqBsJFyJKgT@gardel-login>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh_0bfqBsJFyJKgT@gardel-login>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 17, 2024 at 06:10:21PM +0200, Lennart Poettering wrote:
> Well, there are plenty of other block devices with part scanning off,
> such as DM, including dm-crypt, dm-integrity and so on. And that's
> certainly stuff we want to cover for this.

But there is no good reason to prohibit scanning for them.  We can't
scan by default as that would probably break a few expectations in
userspace, but we can trivially allow manual scanning.


