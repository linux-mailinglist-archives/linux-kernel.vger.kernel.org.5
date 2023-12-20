Return-Path: <linux-kernel+bounces-7063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD9181A128
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FEB285AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572ED3A279;
	Wed, 20 Dec 2023 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fxU8N4Yf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE9A39849;
	Wed, 20 Dec 2023 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VNHZHPVNhEEveJLtUV0KuZwFmyIaK/A3vrG6c+yO65g=; b=fxU8N4YfOAZ3LkTlOSH03ox0NS
	mMHOTduh9EOTBCxgSmvCW8zTi6D3Cr731pTfRjbHNxSrleCuAj+GM+E8VdqOmL4VoiM9RfA9QYTIn
	OdbogdzY0AKRbZiwiU+/IJHFzE2bFb9fOH3EU5J1hUo4xWWSSrUrDthtWbDtZhuN9XLjJNvdyfh9/
	IN/D41s4nEzli2hlxSHoMyJpy4xXen+/kHuiP90dxDbbxeij2gtkDwPJvq9R8IPBQGjm0mCuNSYAG
	ur0bmnFwOsOPWrwQaiGYQM831XA2+6Vcy6rx5f+0THUW1uCu5WYIo4NH7jTkoHCgxG31oGHDi7t7C
	oiMlRVkw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFxcl-0005wK-1J;
	Wed, 20 Dec 2023 14:32:39 +0000
Date: Wed, 20 Dec 2023 06:32:39 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hui Wang <hw.huiwang@huawei.com>, Xiaoyi Su <suxiaoyi@huawei.com>,
	Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH] modules: wait do_free_init correctly
Message-ID: <ZYL7B59dQ6XFtVP8@bombadil.infradead.org>
References: <20231219141231.2218215-1-changbin.du@huawei.com>
 <20231219125151.4a042a259edf3c916580ccfe@linux-foundation.org>
 <ZYIQgz+de/JQl10N@bombadil.infradead.org>
 <20231220052751.3zcnsnvjk5vf5t7j@M910t>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220052751.3zcnsnvjk5vf5t7j@M910t>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Dec 20, 2023 at 01:27:51PM +0800, Changbin Du wrote:
> On Tue, Dec 19, 2023 at 01:52:03PM -0800, Luis Chamberlain wrote:
> > On Tue, Dec 19, 2023 at 12:51:51PM -0800, Andrew Morton wrote:
> > > On Tue, 19 Dec 2023 22:12:31 +0800 Changbin Du <changbin.du@huawei.com> wrote:
> > > 
> > > > The commit 1a7b7d922081 ("modules: Use vmalloc special flag") moves
> > > > do_free_init() into a global workqueue instead of call_rcu(). So now
> > > > we should wait it via flush_work().
> > > 
> > > What are the runtime effects of this change?
> > 
> > Indeed that's needed given how old this culprit commit is:
> > 
> > git describe --contains 1a7b7d922081
> > v5.2-rc1~192^2~5
> > 
> > Who did this work and for what reason? What triggered this itch?
> >
> Seems the waiting was introduced by commit ae646f0b9ca ("init: fix false positives
> in W+X checking").
> 
> As what I have observed, mark_readonly() is only invoked by the first user mode
> thread function kernel_init(), which is before userspace /init. So is it real
> possible we have loaded modules at this point?

Are you saying we don't free any module inits at all then? I asked a lot
of questions and your answers seem slim.

How did you find this?
What actual impact does this have without the patch?

The commit must document this.

  Luis

