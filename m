Return-Path: <linux-kernel+bounces-34935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572F583896D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E63428921A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394C95788F;
	Tue, 23 Jan 2024 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WYbEiRNQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614B557860;
	Tue, 23 Jan 2024 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999664; cv=none; b=d5GsMPFFTlftmX8lrH4ot49Ha7O9VdMxa5YAWisaeDnE31MmC4UKMhstoWsVIxnRDbTLtAdp2oCPgm4iJM6YtU7gEF9lg4AZbhjtq8HQ/4LXemo7oCSw1vHvhZrVveedHOn9QW1EXtFvDzuo+0DLfXq+ri5kmaUp2VPRprNk7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999664; c=relaxed/simple;
	bh=8RQY7arEYehD1BOniNMroVFilVaiSnwq/CgGVP3ThIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEh68BOuBaLKmZhCH0jN4kWlwxhmvsWx1Iwiz1ATzOPUIaVUYqvcpMmwJlEqsN0b07iRvkXjqy+T8dO28vTKKnwiXOAbP4X7dH1FsxJE+wHXCeF4Bs8MMrYa7oBj6Gk1xcrebnKgwF5yRrRKeNdLR2Nk3WiyDAX0SFLn5U/XsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WYbEiRNQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fSTvLztS7719yyFEnMvAe2uObBUKHJdWLKe1j3LT2Iw=; b=WYbEiRNQwbZ4vG/wMXl1gMSx1+
	0k17q4Gx+7d7CfXLBjK8+kYuiB26pdCXTopSWlMoMezp2bZatP6vbW+rkpyLLoqgJJ7eN3Vsco30M
	LRGxHDPLBdrSwC4x0Iu+gy6GZ+bv2T13wWlXM2ZdqG71/XQ56Eewzxwv9f6AAxKd+ZdDFQEnVIdtC
	TFrSoMOFqjqfzPccY/64LeywGv42iXLyOIvOyqwOsKNkY7BbZ6KxBbMFPE5BPrZZgZUxG4yHdHyyu
	snrJ1b4oMX9owN++IGdrZ+fFm3eXpyK4nyFOrU7pFKlV4TA+Wmj18jXLDyx7+BLxcuDX/bpSIyTEK
	vSWze7tg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCRY-00Fcoj-0I;
	Tue, 23 Jan 2024 08:47:40 +0000
Date: Tue, 23 Jan 2024 00:47:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, Wei Wang <wvw@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] block/blk-mq: Don't complete locally if capacities are
 different
Message-ID: <Za99LKnQE/M6pVfM@infradead.org>
References: <20240122224220.1206234-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122224220.1206234-1-qyousef@layalina.io>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 22, 2024 at 10:42:20PM +0000, Qais Yousef wrote:
> The logic in blk_mq_complete_need_ipi() assumes SMP systems where all
> CPUs have equal capacities

What is a capacity here?

> +	return arch_scale_cpu_capacity(this_cpu) >= arch_scale_cpu_capacity(that_cpu);

oerly long line here.

Also pleas split patches for different subsystems.


