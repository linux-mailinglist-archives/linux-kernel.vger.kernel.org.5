Return-Path: <linux-kernel+bounces-154039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0508AD679
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6925A281E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE0F1CAB7;
	Mon, 22 Apr 2024 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NKxMXaW1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA918EA1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820877; cv=none; b=pQbhwbpY6WU4S5WlvrNlB0q89Y2QNSudaRh8693vOeAYPMyNiUFoAeOT6hu4WgnYFFWqBQEkW6GDXe8N5Fwg0MkmE1TYN1VuPS11MfG9Q8MV0IaIDCd3Gb7BA6Brs0T6mXyKS17Ts31EiO1jJ4ca3VDaY+7+pSvmk0lB4K7DTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820877; c=relaxed/simple;
	bh=imYM67ihv3Fe1HHi/ujfhBDgevfHRJsH7J8djTH66mg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RGnMGrH0JA2dtCtTmp1Gt2JfCrgcrXG7LKtG0cOR3i1ksqWXRLXHQ6odRV3DAAf9X4dQv6bBPiYJitVlNDvm/2DXiZCayLD9dDrshw+kOOizSN36Cxk8tULX2ZbY/cSmAGNM9Sx8KXcSMvpy7UiwA3cx8FZ5U7Sq20tPSwY0Hyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NKxMXaW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F855C2BD11;
	Mon, 22 Apr 2024 21:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713820876;
	bh=imYM67ihv3Fe1HHi/ujfhBDgevfHRJsH7J8djTH66mg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NKxMXaW1BISKZ+xx18wb/+SrPLRRgxkZ93rWsukcaMxXXr89+EbPpBE7TXnPdQCjL
	 fd5+yT0eBb/fzeAejTinfokN9Bjv2yAN3UpZqI75q/XmE3/jXwmsS339Fw/N1PSOt2
	 IMFYkK3CTuBdBQc3Ua2nwp43SDPBU3WI/y9wAnXk=
Date: Mon, 22 Apr 2024 14:21:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: <muchun.song@linux.dev>, <mike.kravetz@oracle.com>, <osalvador@suse.de>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()
Message-Id: <20240422142115.25582386f7f02df817eab8ae@linux-foundation.org>
In-Reply-To: <000d75f3-6e16-6b91-7657-afb954773381@huawei.com>
References: <20240419085819.1901645-1-linmiaohe@huawei.com>
	<20240419141134.464ea3a1ef3d0e93c6711c93@linux-foundation.org>
	<000d75f3-6e16-6b91-7657-afb954773381@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Apr 2024 10:13:06 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2024/4/20 5:11, Andrew Morton wrote:
> > On Fri, 19 Apr 2024 16:58:19 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> > 
> >> When I did memory failure tests recently, below warning occurs:
> >>
> >> DEBUG_LOCKS_WARN_ON(1)
> >> WARNING: CPU: 8 PID: 1011 at kernel/locking/lockdep.c:232 __lock_acquire+0xccb/0x1ca0
> >> Modules linked in: mce_inject hwpoison_inject
> >> CPU: 8 PID: 1011 Comm: bash Kdump: loaded Not tainted 6.9.0-rc3-next-20240410-00012-gdb69f219f4be #3
> >>
> >> ...
> >>
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -1773,7 +1773,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
> >>  	 * If vmemmap pages were allocated above, then we need to clear the
> >>  	 * hugetlb flag under the hugetlb lock.
> >>  	 */
> >> -	if (clear_flag) {
> >> +	if (folio_test_hugetlb(folio)) {
> >>  		spin_lock_irq(&hugetlb_lock);
> >>  		__folio_clear_hugetlb(folio);
> >>  		spin_unlock_irq(&hugetlb_lock);
> > 
> > Please let's prepare backportable fixes against current mainline, not
> > mm-unstable.  Because fixes against current -rcX and earlier will be
> > upstreamed ahead of the mm-unstable and mm-stable material.
> 
> Do you mean I need to send one fixup patch against mm-unstable and another
> one against current mainline?

Against mainline should suffice.  I normally fix up the subsequent
merge/build fallout.  If that gets too risky I'll ask for help or I'll
outright drop mm-unstable patches and shall ask for a redo of those. 
This is rare.


