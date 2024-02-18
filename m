Return-Path: <linux-kernel+bounces-70589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55150859983
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D0EB20C5B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C073175;
	Sun, 18 Feb 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gh+L60t0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE67318E;
	Sun, 18 Feb 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708291315; cv=none; b=b1Hr0owJ8sgieo9pTGk3lSWUgy0aoRRGZIfTUpMGB6aQZPGp+Euf6m50bjDRtXE/n2L+R516hrrW7tEZr5W8zqzRrTke+kaoi9pvsLPR2tH/CMWlQOvpSSDiCFHF6UcYcvJ4N0sOj1wOXDp9pE08bfN3o3yIeRRPMP4uXO31u1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708291315; c=relaxed/simple;
	bh=nviFZpkKKCzEebEAPc9U0aKPoo1ClU+opQSf18ATb8I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gqRjFkKUXOGSRTJSKcDR6+JLq/FgwmrCTMlvU4mLOp8afKZtqMpxQrg1WPym6FI2GveEJ1u8skw9ME5w/YKHEVoaYCwtnLekKNuEQvFXUwNOAk9y/+3riqlSYtrXDKCWqtQOaAqgCMC+x3hryZpSJIlkpYA1dbnO+I3ao0OIth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gh+L60t0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6E5C433F1;
	Sun, 18 Feb 2024 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708291314;
	bh=nviFZpkKKCzEebEAPc9U0aKPoo1ClU+opQSf18ATb8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gh+L60t0itXnW1+QDWGY1bz2tANjs2sIwKyWszurYv+kCgTWgx+l9sOyd6OGf8Qe8
	 dEVr7ppgio4xtfjfwO7E6JXEMVHEnPLKzWjpodug9un77PTxXf2FbItNSKq9XqbYJA
	 CVPlsZgjd2mbWAyIkBX254z4YeF1hQwPMsn9XYUY=
Date: Sun, 18 Feb 2024 13:21:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Xiaoyi Su <suxiaoyi@huawei.com>, Eric
 Chanudet <echanude@redhat.com>
Subject: Re: [PATCH v3] modules: wait do_free_init correctly
Message-Id: <20240218132153.d93675d0d241f021565a08b6@linux-foundation.org>
In-Reply-To: <20240217081810.4155871-1-changbin.du@huawei.com>
References: <20240217081810.4155871-1-changbin.du@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Feb 2024 16:18:10 +0800 Changbin Du <changbin.du@huawei.com> wrote:

> The synchronization here is just to ensure the module init's been freed
> before doing W+X checking. But the commit 1a7b7d922081 ("modules: Use
> vmalloc special flag") moves do_free_init() into a global workqueue
> instead of call_rcu(). So now rcu_barrier() can not ensure that do_free_init
> has completed. We should wait it via flush_work().
> 
> Without this fix, we still could encounter false positive reports in
> W+X checking, and the rcu synchronization is unnecessary which can
> introduce significant delay.
> 
> Eric Chanudet reports that the rcu_barrier introduces ~0.1s delay on a
> PREEMPT_RT kernel.
>   [    0.291444] Freeing unused kernel memory: 5568K
>   [    0.402442] Run /sbin/init as init process
> 
> With this fix, the above delay can be eliminated.

Thanks, I'll queue this as a delta, to be folded into the base patch
prior to upstreaming.

I added a Tested-by: Eric, if that's OK by him?

