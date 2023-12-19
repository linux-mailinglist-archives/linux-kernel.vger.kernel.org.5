Return-Path: <linux-kernel+bounces-5989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B5381928D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB8B1C241A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFF33B793;
	Tue, 19 Dec 2023 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HDSZgooh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32BC3B786;
	Tue, 19 Dec 2023 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gVd47evYyjxYsUBmxgwI2kdHq36z+sE1ylaz9D0MCCM=; b=HDSZgoohkuO0F/vcntn/Pp24jx
	53FgXclHwvGi6RQBCc/AICMcLkQG9P/w6jIr2wlQfO/z7QBOdtx3556hPx7HSdCmFSI43UqWtoZ+S
	+OqpaAgUysNro18l045Qa7HHAvns6WGIjP9JgXTJLgRufqTWG0/3TmPDcC9/nBfo/2owiLx6AkYYc
	g+EcJS9lErwwCsyIB4sPA9clKtx+mBOIrilZFlfL/AKDL+pnk+lIq+V6XaPRTi6TgWaL30nJHRSG1
	zuz3dCbQIEuHjZtSz70iq+Qdf7B3PVoPX5+MDVBPYonZhn8DPTh2mUnsYSmZvYHAKBHyCaMvO0OD9
	ZkBB4thQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFi0R-00FWw8-1k;
	Tue, 19 Dec 2023 21:52:03 +0000
Date: Tue, 19 Dec 2023 13:52:03 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Changbin Du <changbin.du@huawei.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hui Wang <hw.huiwang@huawei.com>,
	Xiaoyi Su <suxiaoyi@huawei.com>
Subject: Re: [PATCH] modules: wait do_free_init correctly
Message-ID: <ZYIQgz+de/JQl10N@bombadil.infradead.org>
References: <20231219141231.2218215-1-changbin.du@huawei.com>
 <20231219125151.4a042a259edf3c916580ccfe@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219125151.4a042a259edf3c916580ccfe@linux-foundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Dec 19, 2023 at 12:51:51PM -0800, Andrew Morton wrote:
> On Tue, 19 Dec 2023 22:12:31 +0800 Changbin Du <changbin.du@huawei.com> wrote:
> 
> > The commit 1a7b7d922081 ("modules: Use vmalloc special flag") moves
> > do_free_init() into a global workqueue instead of call_rcu(). So now
> > we should wait it via flush_work().
> 
> What are the runtime effects of this change?

Indeed that's needed given how old this culprit commit is:

git describe --contains 1a7b7d922081
v5.2-rc1~192^2~5

Who did this work and for what reason? What triggered this itch?

Is it perhaps for an out of tree driver that did something funky
on its module exit?

As per Documentation/RCU/rcubarrier.rst rcu_barrier will ensure the
callbacks complete, so interms of determinism both mechanisms will
have waited for the free. It seems we're now just limiting the scope.

This could also mean initialization grew used to having RCU calls on
init complete at this point in time, even for modules, and so localizing
this wait may now also introduce other unexpected behaviour.

  Luis

