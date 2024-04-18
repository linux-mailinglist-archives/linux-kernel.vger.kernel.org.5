Return-Path: <linux-kernel+bounces-150332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4C88A9D76
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7472D28182D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AD016C44C;
	Thu, 18 Apr 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FurfMoDy"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E4D168AE4;
	Thu, 18 Apr 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451569; cv=none; b=GKmdSIodZX8w5bYWDlQFmEh0eZvuGErcegp7lAJGdPRqFdiJlBa/HAaao/9FLi9SQFX7jmDZjRcPHuSIj2QpUUkeQnPO7brbDpfLGEW9SjHoaaaG6f3vtjnMRGWxZyYsdG7jG7Pbe5yt85Q+KUEjpqZV1lc/JTZGulWCU3fVdds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451569; c=relaxed/simple;
	bh=NN+K5KOtN9QCxC/bLqZ3ZX9SCeTen1cPHw50CtKFEYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFpsvX5Vc9iWEY0agkXWhFKdaf7Vhk1Tk/FYou8c2bprJfgvpv3ccPd+Ygl3uQp2s8yg1gY56qJSeqVU9qAxFoCmOHfuUzdY4n7Oitj1e6HlyTaIsBjufrQbwE520DQ3kObIkpQ45FH44b+emau6+DgnwEFj6w2h6HpsaI/mhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FurfMoDy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NN+K5KOtN9QCxC/bLqZ3ZX9SCeTen1cPHw50CtKFEYE=; b=FurfMoDy96LmZ+8CO7jEv9RwVL
	ku028zReZ5X7hG+mJ25z7Jxd8ZINweODNDcHXK4GocKKiqLfOdOT8eIneYfEiN2WIRNt4jnVZYrc0
	EdWfWxGADTeJmnSz79fJAUFjWH40HlP5WHUvQrQlZWBaofuh3fRXQifnOF9LXrggFjOBjzZmDcmu8
	EjWV5xsZc7qNQynXOwtkNh5RpbVfUN2hDVXglSSjMrAjQIkpwQ40YNxA47HExmLPxAyDEzcZb7hYg
	4cTysIo/bLGnSe8NLwmjga8PEmOLU6t4arTk++DF73BZ6nGdbjMtuwPrirMHNqCIl/S2VYkrXvQjT
	sZLbz3pg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxT1a-00000002gMD-1PZA;
	Thu, 18 Apr 2024 14:46:06 +0000
Date: Thu, 18 Apr 2024 07:46:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Snitzer <msnitzer@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] completion: move blk_wait_io to
 kernel/sched/completion.c
Message-ID: <ZiEyLvL6Pq_RB-Eh@infradead.org>
References: <31b118f3-bc8d-b18b-c4b9-e57d74a73f@redhat.com>
 <20240417175538.GP40213@noisy.programming.kicks-ass.net>
 <546473fd-ca4b-3c64-349d-cc739088b748@redhat.com>
 <ZiCoIHFLAzCva2lU@infradead.org>
 <5f3d434b-e05c-445f-bee5-2bb1f11a5946@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3d434b-e05c-445f-bee5-2bb1f11a5946@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 18, 2024 at 08:30:14AM -0600, Jens Axboe wrote:
> It certainly is a hack/work-around, but unless there are a lot more that
> should be using something like this, I don't think adding extra core
> complexity in terms of a special task state (or per-task flag, at least
> that would be easier) is really warranted.

Basically any kernel thread doing on-demand work has the same problem.
It just has an easier workaround hack, as the kernel threads can simply
claim to do an interruptible sleep to not trigger the softlockup
warnings.


