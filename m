Return-Path: <linux-kernel+bounces-69737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7A7858DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FBF1F21E43
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDDB1CD28;
	Sat, 17 Feb 2024 08:11:29 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EEC1BDC4;
	Sat, 17 Feb 2024 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708157488; cv=none; b=NuviRLeiNmjtY45ntkUxKM1Guv2AkNq7J2z0kWVdUP786EtXoN+rHtFy8LT5SpvtVopSMWtJneXOg79ofjxpLwCzRM+EXgJ/wC2Ha03TqWAr3re5RO1yytOfQ+mbMo2SRq1Z+Jj7R6FRTD4PW1sewaqW6xGyfKu3gxFseoxrj8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708157488; c=relaxed/simple;
	bh=Nd05lFhDQQjMnAkK8Ja9xC0rQFniUZh8gkFfKPTq7bs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfkps24Q1HjkrwQIXRp1lAWxKiGb435K1yPc3Rf3cpWMHEt7zxT0Kvwdmf30AivZC8oafKYc/EO+DaAA1MoE3J4657oM1yjuNx8PlNaja4EE5kn0jrMAPWI3Nyc+WUFPcVA7Tj9xQydrO/JdGq8SxeVnQLDrdtpJW8eLBtRqHck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TcM1k3YQRz1vtgL;
	Sat, 17 Feb 2024 16:10:50 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id D75371A0172;
	Sat, 17 Feb 2024 16:11:22 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Sat, 17 Feb
 2024 16:11:21 +0800
Date: Sat, 17 Feb 2024 16:10:46 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Eric Chanudet <echanude@redhat.com>
CC: Luis Chamberlain <mcgrof@kernel.org>, Changbin Du
	<changbin.du@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Xiaoyi Su
	<suxiaoyi@huawei.com>
Subject: Re: [RESEND PATCH v2] modules: wait do_free_init correctly
Message-ID: <20240217081046.5u6dgwdoano2axpd@M910t>
References: <20240129020304.1981372-1-changbin.du@huawei.com>
 <ZbfmNiY52KdAet7_@bombadil.infradead.org>
 <20240130014038.mawqxwoc34v6hztb@M910t>
 <ZbkFz25DtYuhkIEj@bombadil.infradead.org>
 <qrq7emx7zxnmyv6qoakxpaisan2hiophf5lte4ag4di4euqzfi@3kjtbfau6nlm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <qrq7emx7zxnmyv6qoakxpaisan2hiophf5lte4ag4di4euqzfi@3kjtbfau6nlm>
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Thu, Feb 15, 2024 at 09:18:09AM -0500, Eric Chanudet wrote:
> On Tue, Jan 30, 2024 at 06:21:03AM -0800, Luis Chamberlain wrote:
> > On Tue, Jan 30, 2024 at 09:40:38AM +0800, Changbin Du wrote:
> > > On Mon, Jan 29, 2024 at 09:53:58AM -0800, Luis Chamberlain wrote:
> > > > On Mon, Jan 29, 2024 at 10:03:04AM +0800, Changbin Du wrote:
> > > > > The commit 1a7b7d922081 ("modules: Use vmalloc special flag") moves
> > > > > do_free_init() into a global workqueue instead of call_rcu(). So now
> > > > > rcu_barrier() can not ensure that do_free_init has completed. We should
> > > > > wait it via flush_work().
> > > > > 
> > > > > Without this fix, we still could encounter false positive reports in
> > > > > W+X checking, and rcu synchronization is unnecessary.
> 
> The comment in do_init_module(), just before
> schedule_work(&init_free_wq), mentioning rcu_barrier(), should be
> amended as well.
>
yes, I'll update it as well.

> > > > 
> > > > You didn't answer my question, which should be documented in the commit log.
> > > > 
> > > > Does this mean we never freed modules init because of this? If so then
> > > > your commit log should clearly explain that. It should also explain that
> > > > if true (you have to verify) then it means we were no longer saving
> > > > the memory we wished to save, and that is important for distributions
> > > > which do want to save anything on memory. You may want to do a general
> > > > estimate on how much that means these days on any desktop / server.
> > >
> > > Actually, I have explained it in commit msg. It's not about saving memory. The
> > > synchronization here is just to ensure the module init's been freed before
> > > doing W+X checking. The problem is that the current implementation is wrong,
> > > rcu_barrier() cannot guarantee that. So we can encounter false positive reports.
> > > But anyway, the module init will be freed, and it's just a timing related issue.
> > 
> > Your desciption here is better than the commit log.
> 
> I saw this problem using a PREEMPT_RT kernel as well. Setting DEBUG_WX=n
> stills show a significant delay due to the rcu_barrier:
>   [    0.291444] Freeing unused kernel memory: 5568K
>   [    0.402442] Run /sbin/init as init process
> 
> The same delay is shorter using linux-next, but still noticeable
> (DEBUG_WX=n):
>   [    0.384362] Freeing unused kernel memory: 14080K
>   [    0.413423] Run /sbin/init as init process
> 
> Matching trace_event=rcu:rcu_barrier trace:
>          systemd-1       [002] .....     0.384391: rcu_barrier: rcu_preempt Begin cpu -1 remaining 0 # 4
>          systemd-1       [002] d..1.     0.384394: rcu_barrier: rcu_preempt Inc1 cpu -1 remaining 0 # 1
>          systemd-1       [002] .....     0.384395: rcu_barrier: rcu_preempt NQ cpu 0 remaining 2 # 1
>           <idle>-0       [001] d.h2.     0.384407: rcu_barrier: rcu_preempt IRQ cpu -1 remaining 2 # 1
>          systemd-1       [002] .....     0.384408: rcu_barrier: rcu_preempt OnlineQ cpu 1 remaining 3 # 1
>          systemd-1       [002] .....     0.384409: rcu_barrier: rcu_preempt NQ cpu 2 remaining 3 # 1
>           <idle>-0       [003] d.h2.     0.384416: rcu_barrier: rcu_preempt IRQ cpu -1 remaining 3 # 1
>          systemd-1       [002] .....     0.384418: rcu_barrier: rcu_preempt OnlineQ cpu 3 remaining 4 # 1
>           <idle>-0       [004] d.h2.     0.384428: rcu_barrier: rcu_preempt IRQ cpu -1 remaining 4 # 1
>          systemd-1       [002] .....     0.384430: rcu_barrier: rcu_preempt OnlineQ cpu 4 remaining 5 # 1
>           <idle>-0       [005] d.h2.     0.384438: rcu_barrier: rcu_preempt IRQ cpu -1 remaining 5 # 1
>          systemd-1       [002] .....     0.384441: rcu_barrier: rcu_preempt OnlineQ cpu 5 remaining 6 # 1
>           <idle>-0       [006] d.h2.     0.384450: rcu_barrier: rcu_preempt IRQ cpu -1 remaining 6 # 1
>          systemd-1       [002] .....     0.384452: rcu_barrier: rcu_preempt OnlineQ cpu 6 remaining 7 # 1
>           <idle>-0       [007] d.h2.     0.384461: rcu_barrier: rcu_preempt IRQ cpu -1 remaining 7 # 1
>          systemd-1       [002] .....     0.384463: rcu_barrier: rcu_preempt OnlineQ cpu 7 remaining 8 # 1
>           <idle>-0       [004] ..s1.     0.385339: rcu_barrier: rcu_preempt CB cpu -1 remaining 5 # 1
>           <idle>-0       [007] ..s1.     0.397335: rcu_barrier: rcu_preempt CB cpu -1 remaining 4 # 1
>           <idle>-0       [003] ..s1.     0.397337: rcu_barrier: rcu_preempt CB cpu -1 remaining 3 # 1
>           <idle>-0       [005] ..s1.     0.401336: rcu_barrier: rcu_preempt CB cpu -1 remaining 2 # 1
>           <idle>-0       [006] ..s1.     0.401336: rcu_barrier: rcu_preempt CB cpu -1 remaining 1 # 1
>           <idle>-0       [001] .Ns1.     0.413338: rcu_barrier: rcu_preempt LastCB cpu -1 remaining 0 # 1
>          systemd-1       [002] .....     0.413351: rcu_barrier: rcu_preempt Inc2 cpu -1 remaining 0 # 1
> 
> With this patch the delay is no longer there:
>   [    0.377662] Freeing unused kernel memory: 14080K
>   [    0.377767] Run /sbin/init as init process
> 
Thanks for your info. We encounter similar delay in our scenario. I'll add your
testing data in commit msg.

> AFAIU, for the race to happen, module_alloc() needs to create a W+X
> mapping (neither x86 nor arm64 does) and debug_checkwx() has to happen
> before module_enable_nx() in complete_formation(), I didn't get a
> reproducer so far.
> 
> Best,
> 
> -- 
> Eric Chanudet
> 

-- 
Cheers,
Changbin Du

