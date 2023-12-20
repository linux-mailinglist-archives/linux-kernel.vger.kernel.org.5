Return-Path: <linux-kernel+bounces-6383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E181981B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E19288438
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E660FFC04;
	Wed, 20 Dec 2023 05:28:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B814AA4;
	Wed, 20 Dec 2023 05:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sw2Bn3bZMzWjwP;
	Wed, 20 Dec 2023 13:27:45 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id C9271180032;
	Wed, 20 Dec 2023 13:28:04 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Wed, 20 Dec
 2023 13:28:03 +0800
Date: Wed, 20 Dec 2023 13:27:51 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Changbin Du
	<changbin.du@huawei.com>, <linux-modules@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Hui Wang <hw.huiwang@huawei.com>, Xiaoyi Su
	<suxiaoyi@huawei.com>, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH] modules: wait do_free_init correctly
Message-ID: <20231220052751.3zcnsnvjk5vf5t7j@M910t>
References: <20231219141231.2218215-1-changbin.du@huawei.com>
 <20231219125151.4a042a259edf3c916580ccfe@linux-foundation.org>
 <ZYIQgz+de/JQl10N@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZYIQgz+de/JQl10N@bombadil.infradead.org>
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Tue, Dec 19, 2023 at 01:52:03PM -0800, Luis Chamberlain wrote:
> On Tue, Dec 19, 2023 at 12:51:51PM -0800, Andrew Morton wrote:
> > On Tue, 19 Dec 2023 22:12:31 +0800 Changbin Du <changbin.du@huawei.com> wrote:
> > 
> > > The commit 1a7b7d922081 ("modules: Use vmalloc special flag") moves
> > > do_free_init() into a global workqueue instead of call_rcu(). So now
> > > we should wait it via flush_work().
> > 
> > What are the runtime effects of this change?
> 
> Indeed that's needed given how old this culprit commit is:
> 
> git describe --contains 1a7b7d922081
> v5.2-rc1~192^2~5
> 
> Who did this work and for what reason? What triggered this itch?
>
Seems the waiting was introduced by commit ae646f0b9ca ("init: fix false positives
in W+X checking").

As what I have observed, mark_readonly() is only invoked by the first user mode
thread function kernel_init(), which is before userspace /init. So is it real
possible we have loaded modules at this point?

Cc Jeffrey Hugo <jhugo@codeaurora.org>
> Is it perhaps for an out of tree driver that did something funky
> on its module exit?
> 
> As per Documentation/RCU/rcubarrier.rst rcu_barrier will ensure the
> callbacks complete, so interms of determinism both mechanisms will
> have waited for the free. It seems we're now just limiting the scope.
> 
> This could also mean initialization grew used to having RCU calls on
> init complete at this point in time, even for modules, and so localizing
> this wait may now also introduce other unexpected behaviour.
> 
>   Luis

-- 
Cheers,
Changbin Du

