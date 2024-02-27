Return-Path: <linux-kernel+bounces-83604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF74869C25
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB39F1C21CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324121DA37;
	Tue, 27 Feb 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UflHmV06"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F95FC0C;
	Tue, 27 Feb 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051446; cv=none; b=fir6V0chqtmvp3Q9FVsBfjXtlFPXMbd4zgQtj5GCcmznQvme74ZJCAaief4LF0YE0lTgaU6x9vmbRmvdVtmbIq6enBnsl1bx/j08FkyxwpAoioOSupPsTDq+qaPD2qfBC8vKtYdVQEPY/7Deyl9Co2+HaWDOWXE0a/NJD8fyVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051446; c=relaxed/simple;
	bh=KBTtlPCL4hk1PkKTBjxD4B7zdpjr8IXelQA+EBL3VnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsC1slu26ijjKt8D2ldYzqGFJ8gyRSPFIx/phOU89v9QJPqhutY8VR6IDQIDBRT27hPsW5jj4VA+YGwwe84Q5tGnce5ewuk9rKVlvASYCecAGs0wi6EuU2FfYRXYCC+yqgLL41nP0aQSCiu/wLCzLwV5qPwMem/OTPc7M74HAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UflHmV06; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8Em3WrQ3rbqBswUK3H5v5TrX0P+gERz3y+yQCLjfY1o=; b=UflHmV06nWxmj5rJD5mToBCGK1
	wHyE17Nv+e5oi7s5UasYKAceuiSW2TIHK+3FYS+ma6fZy8z4E4jWj7voaa7z47KoKSXdun/Vu+mXp
	B/pKZYPpMAMSUQPjZuMa6cr8mnOz2EFR3eAs9ozna2kS52rFTxQBgSBiv7xSI1pFR4b0OBHwVL1cJ
	EpRIgaQHUPnrdu9RRB6Lva9ZYXy0Yc7fZI6R6fH4XagM2IyyDH6ZPHgjCjGU02XUpTwFKLVjHz8+r
	CCPHm6bUFt5+M6UVgphuqxo+ti6AHhK1zpGukmU3xNS3O3lCfEojlmkAm2xND48jDR8qoeEKHdWUn
	E7yPcOrg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf0Ls-00000005ytE-0MFf;
	Tue, 27 Feb 2024 16:30:44 +0000
Date: Tue, 27 Feb 2024 08:30:44 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiaoyi Su <suxiaoyi@huawei.com>,
	Eric Chanudet <echanude@redhat.com>,
	Luis Chamberlain <mcgrof@infradead.org>
Subject: Re: [PATCH v4] modules: wait do_free_init correctly
Message-ID: <Zd4ONMe5c_tdPyLW@bombadil.infradead.org>
References: <20240227023546.2490667-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227023546.2490667-1-changbin.du@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Feb 27, 2024 at 10:35:46AM +0800, Changbin Du wrote:
> The synchronization here is to ensure the ordering of freeing of a module
> init so that it happens before W+X checking. It is worth noting it is not
> that the freeing was not happening, it is just that our sanity checkers
> raced against the permission checkers which assume init memory is already
> gone.
> 
> Commit 1a7b7d922081 ("modules: Use vmalloc special flag") moved
> calling do_free_init() into a global workqueue instead of relying on it
> being called through call_rcu(..., do_free_init), which used to allowed us
> call do_free_init() asynchronously after the end of a subsequent grace
> period. The move to a global workqueue broke the gaurantees for code which
> needed to be sure the do_free_init() would complete with rcu_barrier().
> To fix this callers which used to rely on rcu_barrier() must now instead
> use flush_work(&init_free_wq).
> 
> Without this fix, we still could encounter false positive reports in W+X
> checking since the rcu_barrier() here can not ensure the ordering now.
> 
> Even worse, the rcu_barrier() can introduce significant delay. Eric Chanudet
> reported that the rcu_barrier introduces ~0.1s delay on a PREEMPT_RT kernel.
> 
>   [    0.291444] Freeing unused kernel memory: 5568K
>   [    0.402442] Run /sbin/init as init process
> 
> With this fix, the above delay can be eliminated.
> 
> Fixes: 1a7b7d922081 ("modules: Use vmalloc special flag")
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> Cc: Xiaoyi Su <suxiaoyi@huawei.com>
> Cc: Eric Chanudet <echanude@redhat.com>
> Cc: Luis Chamberlain <mcgrof@infradead.org>
> Tested-by: Eric Chanudet <echanude@redhat.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

