Return-Path: <linux-kernel+bounces-7752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FFC81ACA2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5663287A42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9723C0A;
	Thu, 21 Dec 2023 02:31:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8A1843;
	Thu, 21 Dec 2023 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SwZCs1Lw2zMp2G;
	Thu, 21 Dec 2023 10:30:33 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id EAAD71400CD;
	Thu, 21 Dec 2023 10:30:48 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Thu, 21 Dec
 2023 10:30:47 +0800
Date: Thu, 21 Dec 2023 10:30:37 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: Changbin Du <changbin.du@huawei.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-modules@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Hui Wang <hw.huiwang@huawei.com>, Xiaoyi Su
	<suxiaoyi@huawei.com>, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH] modules: wait do_free_init correctly
Message-ID: <20231221023037.emexvbbnt6tpgcs5@M910t>
References: <20231219141231.2218215-1-changbin.du@huawei.com>
 <20231219125151.4a042a259edf3c916580ccfe@linux-foundation.org>
 <ZYIQgz+de/JQl10N@bombadil.infradead.org>
 <20231220052751.3zcnsnvjk5vf5t7j@M910t>
 <ZYL7B59dQ6XFtVP8@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZYL7B59dQ6XFtVP8@bombadil.infradead.org>
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Wed, Dec 20, 2023 at 06:32:39AM -0800, Luis Chamberlain wrote:
> On Wed, Dec 20, 2023 at 01:27:51PM +0800, Changbin Du wrote:
> > On Tue, Dec 19, 2023 at 01:52:03PM -0800, Luis Chamberlain wrote:
> > > On Tue, Dec 19, 2023 at 12:51:51PM -0800, Andrew Morton wrote:
> > > > On Tue, 19 Dec 2023 22:12:31 +0800 Changbin Du <changbin.du@huawei.com> wrote:
> > > > 
> > > > > The commit 1a7b7d922081 ("modules: Use vmalloc special flag") moves
> > > > > do_free_init() into a global workqueue instead of call_rcu(). So now
> > > > > we should wait it via flush_work().
> > > > 
> > > > What are the runtime effects of this change?
> > > 
> > > Indeed that's needed given how old this culprit commit is:
> > > 
> > > git describe --contains 1a7b7d922081
> > > v5.2-rc1~192^2~5
> > > 
> > > Who did this work and for what reason? What triggered this itch?
> > >
> > Seems the waiting was introduced by commit ae646f0b9ca ("init: fix false positives
> > in W+X checking").
> > 
> > As what I have observed, mark_readonly() is only invoked by the first user mode
> > thread function kernel_init(), which is before userspace /init. So is it real
> > possible we have loaded modules at this point?
> 
> Are you saying we don't free any module inits at all then? I asked a lot
> of questions and your answers seem slim.
>
Yes, indeed no module loaded at all before mark_readonly(), at least on my desktop.
So I think we can just delete this synchronization. I am not sure whether there are
any historical reasons.

> How did you find this?
> What actual impact does this have without the patch?
>
This is a coincidence. We encountered a rcu problem which the barrier takes much
longger time to wait (this is an another story). So we reviewed the code and
found this issue.

There is no funcional problem without the patch. It's a unnecessary wait AFAIK,
and it does take a little cycles to wait the rcb callbacks.

> The commit must document this.
> 
>   Luis

-- 
Cheers,
Changbin Du

