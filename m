Return-Path: <linux-kernel+bounces-58700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6B284EA1C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E9A1F2F9A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BE34C3BB;
	Thu,  8 Feb 2024 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="StiCQOKO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA544F1E7;
	Thu,  8 Feb 2024 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707426594; cv=none; b=RNPZDFOHv4gzw3nmRLv4GpIJHcGvP2oDvEOXiEII/RsqMEwC+pvCU+vYW8k1X/mXXTqsDBLzSNN7SthqpRGfwSCgNzioavl01IxRt/8QKgC4X+VPUfqEoprUaTrHY+gSMuB+ZQiJEOCINrUWi85VWhwI4hZZIP2ktoONFEGmwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707426594; c=relaxed/simple;
	bh=DzXm9EVWYa8b4QDNaxkkfMISiO9pdEx+UCn6OYF1Vkc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XHaJEN7ziiq5GkdJqsu1NBaqLzavXx2nmG2BSLTvqiPSkkTJfuZaMe8q4KB9g1Am+u6Ey+BsPwJv/ZjkX7SI6WsNB8KQTye03fZmU3DRIC8LQPMKL29F2GdOdnBNIK4EAMUqkP3n9XN1nL/yXi/B+edyZaWcY6KPczudd5H5QKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=StiCQOKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4719DC433C7;
	Thu,  8 Feb 2024 21:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707426593;
	bh=DzXm9EVWYa8b4QDNaxkkfMISiO9pdEx+UCn6OYF1Vkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=StiCQOKOn60o/hlia5zK56EIrwA/08GbVDilfw8paaGnCUWd7s6fLX7o2bi5C4lwH
	 IT8lICT/7m64Q7XCw+lopOe2dxBk3nRTjDItlFUWTCod6j9av40zjc8sIGWvi5X9fi
	 FBH5qknjdGVA8W2N7qsxz/z+L8gQcR7AYpJ5qOpM=
Date: Thu, 8 Feb 2024 13:09:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: chengming.zhou@linux.dev
Cc: hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Chengming Zhou
 <zhouchengming@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes-unstable] mm/zswap: invalidate duplicate
 entry when !zswap_enabled
Message-Id: <20240208130952.b2696eaf6a27eef9866723d4@linux-foundation.org>
In-Reply-To: <20240208023254.3873823-1-chengming.zhou@linux.dev>
References: <20240207154308.bc275f3e72ec1c1fd06cf5a2@linux-foundation.org>
	<20240208023254.3873823-1-chengming.zhou@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 02:32:54 +0000 chengming.zhou@linux.dev wrote:

> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We have to invalidate any duplicate entry even when !zswap_enabled
> since zswap can be disabled anytime. If the folio store success before,
> then got dirtied again but zswap disabled, we won't invalidate the old
> duplicate entry in the zswap_store(). So later lru writeback may
> overwrite the new data in swapfile.
> 
> ...
>
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1516,7 +1516,7 @@ bool zswap_store(struct folio *folio)
>  	if (folio_test_large(folio))
>  		return false;
>  
> -	if (!zswap_enabled || !tree)
> +	if (!tree)
>  		return false;
>  
>  	/*
> @@ -1531,6 +1531,10 @@ bool zswap_store(struct folio *folio)
>  		zswap_invalidate_entry(tree, dupentry);
>  	}
>  	spin_unlock(&tree->lock);
> +
> +	if (!zswap_enabled)
> +		return false;
> +
>  	objcg = get_obj_cgroup_from_folio(folio);
>  	if (objcg && !obj_cgroup_may_zswap(objcg)) {
>  		memcg = get_mem_cgroup_from_objcg(objcg);

OK, thanks.

I saw only one reject from mm-unstable patches.  Your patch "mm/zswap:
make sure each swapfile always have zswap rb-tree" now does

--- a/mm/zswap.c~mm-zswap-make-sure-each-swapfile-always-have-zswap-rb-tree
+++ a/mm/zswap.c
@@ -1518,9 +1518,6 @@ bool zswap_store(struct folio *folio)
 	if (folio_test_large(folio))
 		return false;
 
-	if (!tree)
-		return false;
-
 	/*
 	 * If this is a duplicate, it must be removed before attempting to store
 	 * it, otherwise, if the store fails the old page won't be removed from



