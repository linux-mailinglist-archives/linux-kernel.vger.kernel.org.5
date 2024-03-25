Return-Path: <linux-kernel+bounces-117925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B533E88B667
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F89C4398A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483B31CA9C;
	Mon, 25 Mar 2024 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lLqvdpov"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C445037
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398551; cv=none; b=cvxWYKQ5bGa9qSzo5XXw/d98uqK2TtxPsP0SJIbB+ih6NqzJ0ojpWAKhHCmgh3GOj+pSAygkKleseEpyta9YByA41eXFQAIpeZecdTV3PwbcNCyD4Bw/0zmyDnbJz95X+mcAZkYA3z2Iabyb+1ux84f91HyZYm+JiL8ZhhenI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398551; c=relaxed/simple;
	bh=nfVLFY97TTH4TNsZH8G5ndSxRhKAMtXtADlNh6V0jyk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VMBAz2ABgrgyzy3Obk11+cUu6YCLHKPoV08Qjn0NZOA5pXLCqWok+s0Nqs7HfMXwqCnLJ9mfBbC3U3hLuSSExNUdukzMF5+84FvOOkY18pc1DhqmHrxwrLkG0O/Rd7nTeuabekWD3CdKDC5/97cEddPUlWqqlPw3FwRjsWawNvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lLqvdpov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD3AC433C7;
	Mon, 25 Mar 2024 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711398550;
	bh=nfVLFY97TTH4TNsZH8G5ndSxRhKAMtXtADlNh6V0jyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lLqvdpovYZYCLrBxcniicIdrfgG84STczHwD082AmwsVdLSbADv7f8H+LXhIBvDgn
	 jFPLERwXKBBCnDazptInYJ5w1EdJJyIqLziwHyHzqpdNzPQkPg/xibLzKrLh5VcNub
	 DEDjxkQPrWn24SyhoPel+o+zO2Rr/LLZoK2Ccv4E=
Date: Mon, 25 Mar 2024 13:29:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, chenhuacai@loongson.cn,
 dyoung@redhat.com, jbohac@suse.cz, lihuafei1@huawei.com,
 chenhaixiang3@huawei.com
Subject: Re: [PATCH v2] crash: use macro to add crashk_res into iomem early
 for specific arch
Message-Id: <20240325132909.741ae47a8a05837c175a981e@linux-foundation.org>
In-Reply-To: <ZgDYemRQ2jxjLkq+@MiWiFi-R3L-srv>
References: <20240324033513.1027427-1-bhe@redhat.com>
	<ZgDYemRQ2jxjLkq+@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 09:50:50 +0800 Baoquan He <bhe@redhat.com> wrote:

> There are regression reports[1][2] that crashkernel region on x86_64 can't
> be added into iomem tree sometime. This causes the later failure of kdump
> loading.

So I think a cc:stable is needed.

> This happened after commit 4a693ce65b18 ("kdump: defer the insertion of
> crashkernel resources") was merged.
> 
> Even though, these reported issues are proved to be related to other
> component, they are just exposed after above commmit applied, I still
> would like to keep crashk_res and crashk_low_res being added into iomem
> early as before because the early adding has been always there on x86_64
> and working very well. For safety of kdump, Let's change it back.

I'll use 4a693ce65b18 as the Fixes: target, since there is no
"Exposed-by-non-buggy-patch:" tag.  To tell the -stable tree
maintainers how far back in history this should be backported.



