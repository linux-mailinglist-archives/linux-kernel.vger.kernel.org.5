Return-Path: <linux-kernel+bounces-44739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E078426C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C844B26502
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1086DD0E;
	Tue, 30 Jan 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HZVmtQzs"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6CE6DCF4;
	Tue, 30 Jan 2024 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624471; cv=none; b=ZkuxXeiol9BnkzARzH1VbzX9SHKQti2bHl1uyyxBtU2Vis5WsAP+K1XBUII1F+qXr2nFa9wGZLlNUg3koX4g0njac+fXHd/uTU9ijMg9Jz9cbcq1+O+EOt+eSDa1mp4lR4fBrjiQXOSN0d4yyhP+iBlycCUQFlaH7/FIVZ8WOBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624471; c=relaxed/simple;
	bh=olSaK7JL+ACpsyZyms8oqccQ09X5WG8N6HcRyA51xAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2+gUH0X+6l6aOPJI92gX6N5t3GwXpjNFMvbSWp3LRfgmEuje9xUbfO5z4r4Xee/vfoPfpUDDM2lUQKclu7Dy9ZqtJn5i4sSTwmB/YekNT6OonaoX68mpL/2uMRdmFwOyihFiqey5BVcScxtmoxbGMMEAL/DpKSBmZ1tF9gkNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HZVmtQzs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZlU/Iia4dRlyNiSU0aRFfm43368jA6PyTy6ZwniEs/U=; b=HZVmtQzsGUG81lBJ166sHDWiUx
	+PzgY6NFN8kQh+VRrJ3f6noZj+8o/cyM5HREqU/55bVAh7uDORHTHR+EvN4am6VdqaXx7OVaSZkIE
	Y/yFz20OlJJI43vc9dlOOQM1LXnIdFDNQhE2qA9U/i6Tq42ZZMzjSMcsO4m0eI+42ec2hQMIl08Oy
	wSAJ65NL7mVR0Saz2TM7IKRlzN/Vqp3iyavWSrXp/7dA/EzjZTPmNrRgBRDCqf/3lf42FWqSdxGKU
	a61sJBLTvO02D9uUf3Lika9jG5LJ7Y26jsYYgbNQPWJ+0ctr7xFH5Xb5IlveYdqL8GvwEpa/xX3g+
	dWd0blXw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUoz1-0000000GxEt-12i6;
	Tue, 30 Jan 2024 14:21:03 +0000
Date: Tue, 30 Jan 2024 06:21:03 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiaoyi Su <suxiaoyi@huawei.com>
Subject: Re: [RESEND PATCH v2] modules: wait do_free_init correctly
Message-ID: <ZbkFz25DtYuhkIEj@bombadil.infradead.org>
References: <20240129020304.1981372-1-changbin.du@huawei.com>
 <ZbfmNiY52KdAet7_@bombadil.infradead.org>
 <20240130014038.mawqxwoc34v6hztb@M910t>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130014038.mawqxwoc34v6hztb@M910t>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Jan 30, 2024 at 09:40:38AM +0800, Changbin Du wrote:
> On Mon, Jan 29, 2024 at 09:53:58AM -0800, Luis Chamberlain wrote:
> > On Mon, Jan 29, 2024 at 10:03:04AM +0800, Changbin Du wrote:
> > > The commit 1a7b7d922081 ("modules: Use vmalloc special flag") moves
> > > do_free_init() into a global workqueue instead of call_rcu(). So now
> > > rcu_barrier() can not ensure that do_free_init has completed. We should
> > > wait it via flush_work().
> > > 
> > > Without this fix, we still could encounter false positive reports in
> > > W+X checking, and rcu synchronization is unnecessary.
> > 
> > You didn't answer my question, which should be documented in the commit log.
> > 
> > Does this mean we never freed modules init because of this? If so then
> > your commit log should clearly explain that. It should also explain that
> > if true (you have to verify) then it means we were no longer saving
> > the memory we wished to save, and that is important for distributions
> > which do want to save anything on memory. You may want to do a general
> > estimate on how much that means these days on any desktop / server.
>
> Actually, I have explained it in commit msg. It's not about saving memory. The
> synchronization here is just to ensure the module init's been freed before
> doing W+X checking. The problem is that the current implementation is wrong,
> rcu_barrier() cannot guarantee that. So we can encounter false positive reports.
> But anyway, the module init will be freed, and it's just a timing related issue.

Your desciption here is better than the commit log.

  Luis

