Return-Path: <linux-kernel+bounces-151961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C118AB646
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27591B224A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0FC2E40C;
	Fri, 19 Apr 2024 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Be69wG4e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142C107B2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561095; cv=none; b=e5vNy6clE6EhW/lkr6NBh1cU2b+yGoUQTrWe6y9ca7rJT35JcDnT/f4Ig7AS2/HHNnz7HYc8WoIwgw2dIafN3svBmj3Z9lWpOHRADICAZKfLbIl48HhbxK9rXjdG4T9fZBAhj6Ho1UOXP1By8Trz/6YHzfjCrOfdagFnNF8g6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561095; c=relaxed/simple;
	bh=w8dLaSxgMuSudghS89tIqDLnH8VPQ5WVdoqYlYsDR7g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZeCw0cLYAvZqDd++gyG81OYRFHKTX0PSJbh71xuqcQGUXuaO0sT+/5UGMEyxv50Xfudtb9tSvc8N4flGu7f+9mD5Z8EdM9MZ4CCpdm70bLkbf7lQBGMFfI1sal8UttRHVQ0VB6i5Xet5bZ4fqH1lBtQlWijotpVJK0LBzAEws80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Be69wG4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D809AC072AA;
	Fri, 19 Apr 2024 21:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713561095;
	bh=w8dLaSxgMuSudghS89tIqDLnH8VPQ5WVdoqYlYsDR7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Be69wG4ezgeGYP4OVW5eLAmclKIBFx6mIN91Bd7X9P65FmiY+vwfQwtX8jwtWVFBq
	 wk60NWbmL7XNkXjTuR6i2Ezn+O40I1iXFbJuIfHZqA3HtIgt6VpUKj3Z1oqSj2aQeo
	 KkzR3SfHpZ6ZNx9RNtxfzzxHQswatZoTiQTAwFXg=
Date: Fri, 19 Apr 2024 14:11:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: <muchun.song@linux.dev>, <mike.kravetz@oracle.com>, <osalvador@suse.de>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()
Message-Id: <20240419141134.464ea3a1ef3d0e93c6711c93@linux-foundation.org>
In-Reply-To: <20240419085819.1901645-1-linmiaohe@huawei.com>
References: <20240419085819.1901645-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 16:58:19 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> When I did memory failure tests recently, below warning occurs:
> 
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 8 PID: 1011 at kernel/locking/lockdep.c:232 __lock_acquire+0xccb/0x1ca0
> Modules linked in: mce_inject hwpoison_inject
> CPU: 8 PID: 1011 Comm: bash Kdump: loaded Not tainted 6.9.0-rc3-next-20240410-00012-gdb69f219f4be #3
>
> ...
>
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1773,7 +1773,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>  	 * If vmemmap pages were allocated above, then we need to clear the
>  	 * hugetlb flag under the hugetlb lock.
>  	 */
> -	if (clear_flag) {
> +	if (folio_test_hugetlb(folio)) {
>  		spin_lock_irq(&hugetlb_lock);
>  		__folio_clear_hugetlb(folio);
>  		spin_unlock_irq(&hugetlb_lock);

Please let's prepare backportable fixes against current mainline, not
mm-unstable.  Because fixes against current -rcX and earlier will be
upstreamed ahead of the mm-unstable and mm-stable material.


I did this:

--- a/mm/hugetlb.c~mm-hugetlb-fix-debug_locks_warn_on1-when-dissolve_free_hugetlb_folio
+++ a/mm/hugetlb.c
@@ -1781,7 +1781,7 @@ static void __update_and_free_hugetlb_fo
 	 * If vmemmap pages were allocated above, then we need to clear the
 	 * hugetlb destructor under the hugetlb lock.
 	 */
-	if (clear_dtor) {
+	if (folio_test_hugetlb(folio)) {
 		spin_lock_irq(&hugetlb_lock);
 		__clear_hugetlb_destructor(h, folio);
 		spin_unlock_irq(&hugetlb_lock);
_


