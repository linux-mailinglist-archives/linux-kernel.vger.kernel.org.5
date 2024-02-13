Return-Path: <linux-kernel+bounces-63244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8433F852CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C801C26C24
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102292EB11;
	Tue, 13 Feb 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t3BLbJLW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14856381CF;
	Tue, 13 Feb 2024 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817299; cv=none; b=YqNQEIP1eZou3GulewtKHGAYea9BcrzYI8Xflgl1hLd/QxXWJVKvjFuBuu2s/EC74cVIYWXKUgWDwanJk2CThEqwZJTF7LDF4KJG/lMHiVXVpVP0SMD79WC1SOPF/i4mwqb8MusaO/CVJxywRXMS/O6LNNw4emggMEBuX2heCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817299; c=relaxed/simple;
	bh=Z/UeRF0PUC7eWwdhWXuxUx7yfttwjE8TQV6RnN3Itw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4Exg1inwiA7u5/ZGcsllPUcy4WgUMUjArnLVUZ/wrb4dkjY/e0Wr75HSU/X5+b+N2qh5E/B75PrgznHcDSv+lv4v0Ivqwox3FOcI+fOgwvZXuoSr786OIWzxB9v5Atdl4fMbBElisW7TRSLNBNjQkgbzrxDXny3+WXjDFTK8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t3BLbJLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407C7C433F1;
	Tue, 13 Feb 2024 09:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707817298;
	bh=Z/UeRF0PUC7eWwdhWXuxUx7yfttwjE8TQV6RnN3Itw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3BLbJLW5bXJxoyt4FKCsJFZe99A2CkiIGuDf+4VFnDlEdMoD4AWSLvRgFZQtJbMd
	 mBYuQpULiUn539XaDFyA8S3R8Ggv9ddc3qCpW2FTqnHhb0d4l4QHgOt/6f5cad0ZjJ
	 Mclpt6wzkmboOeBHslg6R0W2Lggj5f99sTkm5o2E=
Date: Tue, 13 Feb 2024 10:41:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
	dhowells@redhat.com, david@redhat.com, surenb@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	# see patch description <stable@vger.kernel.org>
Subject: Re: [PATCH] mm/huge_memory: fix swap entry values of tail pages of
 THP
Message-ID: <2024021309-predict-scrubber-d6f3@gregkh>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>

On Tue, Feb 13, 2024 at 02:18:10PM +0530, Charan Teja Kalla wrote:
> An anon THP page is first added to swap cache before reclaiming it.
> Initially, each tail page contains the proper swap entry value(stored in
> ->private field) which is filled from add_to_swap_cache(). After
> migrating the THP page sitting on the swap cache, only the swap entry of
> the head page is filled(see folio_migrate_mapping()).
> 
> Now when this page is tried to split(one case is when this page is again
> migrated, see migrate_pages()->try_split_thp()), the tail pages
> ->private is not stored with proper swap entry values.  When this tail
> page is now try to be freed, as part of it delete_from_swap_cache() is
> called which operates on the wrong swap cache index and eventually
> replaces the wrong swap cache index with shadow/NULL value, frees the
> page.
> 
> This leads to the state with a swap cache containing the freed page.
> This issue can manifest in many forms and the most common thing observed
> is the rcu stall during the swapin (see mapping_get_entry()).
> 
> On the recent kernels, this issues is indirectly getting fixed with the
> series[1], to be specific[2].

Then why can we not take that series?  Taking one-off patches almost
ALWAYS causes future problems, what are you going to do to prevent that
here (merge and logic problems).

> When tried to back port this series, it is observed many merge
> conflicts and also seems dependent on many other changes. As backporting
> to LTS branches is not a trivial one, the similar change from [2] is
> picked as a fix.
> 
> [1] https://lore.kernel.org/all/20230821160849.531668-1-david@redhat.com/
> [2] https://lore.kernel.org/all/20230821160849.531668-5-david@redhat.com/

Again, please try to take the original series, ESPECIALLY for stuff in
-mm which is tricky and likely to blow up in odd ways in the future.

So I will not take this unless the -mm maintainers agree it really is
the only way forward.

thanks,

greg k-h

