Return-Path: <linux-kernel+bounces-119352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C4A88C786
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBFD1F802CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A250613C91E;
	Tue, 26 Mar 2024 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc4USQE7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF013C9A8;
	Tue, 26 Mar 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467447; cv=none; b=c1qVWbhXzR4reMBS/NfOFY16dWI174Md4j15L9VYgKhWfxgLoxUpeZmFY1HCLHrz1nTm7nhz6DEzILHuc03JVBDP5T4K3vmjl8j8N2zWv0Yf0GiLfrgLN7vcXcyoWaTUYxLkIFIWmGtIKspWrO4uY3Xl6uwEgOi7r4xpPQN4dks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467447; c=relaxed/simple;
	bh=Bl+BYidMPD6QYSFEUn9nKPp7BsOGv1w8t/Y35xkpOsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dET89eQWqB6oDycs1ro+S+NQ/cLGvCk/AG50hAhmOwF/sciQMi3yHl1EBFxEU9zU/YtpLMuUCBv+WFeTh45U5iHgV1LhP1fCl+SiHAcMA4cDy3xa9F/HNFrqIzwD8uc6exknz3EPv2IcckR9VcOLifhZ580oZYqK2N0fauiK6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc4USQE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9198AC43394;
	Tue, 26 Mar 2024 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467446;
	bh=Bl+BYidMPD6QYSFEUn9nKPp7BsOGv1w8t/Y35xkpOsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kc4USQE7pWStzRH38MPjUVOniBdEq5uyWMoUbz0gTjBmUbZKyomc3+N1bbVG9vdyk
	 fESewTVbd3oBlMBpODGuKsQ7U0RrznUbpvGESpnHLrYY95vSEWQgt7tVJvhjBJ5E9g
	 3U26IABZk/FvcbeOquNy1outnQxgYWJuJWEBjmsSiX5gN1vhK5A0AJdM+uF62HcZkt
	 JM7Tmgbuh6+MlC7ySVap9O8c3uC1wgzwI2PHxvXCVL2g4cWD4KJDkHSxqCr0Hcrt2+
	 5gjlARL8ooO+2pygBvdaL3daFfodtBbnJhsxwceWyyF1QkNhpCg/CRUxGVwPWvAfgK
	 I+vFRiBXWES0g==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	sfr@canb.auug.org.au,
	kent.overstreet@linux.dev,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-mm@kvack.org,
	linux-um@lists.infradead.org,
	linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
Date: Tue, 26 Mar 2024 08:37:24 -0700
Message-Id: <20240326153724.89126-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326073750.726636-1-surenb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Mar 2024 00:37:50 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Patch [1] replaced vmalloc() function with a new definition but it did
> not adjust the forward declaration used in UML architecture. Change it
> to act as before.
> Note that this prevents the vmalloc() allocations in __wrap_malloc()
> from being accounted. If accounting here is critical, we will have
> to remove this forward declaration and include vmalloc.h, however
> that would pull in more dependencies and would require introducing more
> architecture-specific headers, like asm/bug.h, asm/rwonce.h, etc.
> This is likely the reason why this forward declaration was introduced
> in the first place.
> 
> [1] https://lore.kernel.org/all/20240321163705.3067592-31-surenb@google.com/
> 
> Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profiling")
> Reported-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Thank you for this fix, Suren.  I confirmed that this patch fixes the issue I
reported.

Closes: https://lore.kernel.org/all/20240323180506.195396-1-sj@kernel.org/
Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  arch/um/include/shared/um_malloc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/include/shared/um_malloc.h b/arch/um/include/shared/um_malloc.h
> index 13da93284c2c..bf503658f08e 100644
> --- a/arch/um/include/shared/um_malloc.h
> +++ b/arch/um/include/shared/um_malloc.h
> @@ -11,7 +11,8 @@
>  extern void *uml_kmalloc(int size, int flags);
>  extern void kfree(const void *ptr);
>  
> -extern void *vmalloc(unsigned long size);
> +extern void *vmalloc_noprof(unsigned long size);
> +#define vmalloc(...)		vmalloc_noprof(__VA_ARGS__)
>  extern void vfree(void *ptr);
>  
>  #endif /* __UM_MALLOC_H__ */
> -- 
> 2.44.0.396.g6e790dbe36-goog

