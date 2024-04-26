Return-Path: <linux-kernel+bounces-159546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19338B300A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C381C2194F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F4B13A86E;
	Fri, 26 Apr 2024 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HezeXzpK"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D875810;
	Fri, 26 Apr 2024 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714111614; cv=none; b=ZP4lZU3b1v7iu4BDB+f8u7Q0TEcYhJcC2tUOrM4izCNMe9bGnZHz+bKSHAZ8X+08b2WlRAhTwWo8SCcfZtlePUt/3pDdiZgn5Yugx8AI+W6FV/DvZoH0O6bMEZ1DbmUiYFTAkit53AvYhY5MDzMcHJWSkSBoqlUd4940/91Yadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714111614; c=relaxed/simple;
	bh=ScRbr+wIDvRcJVfn/2jmiWQIpjY96kUJbIjeVXhPEgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOx1YGNITM0XU50XGj0nZ5kUK/uUzzVH/KaAzOrVxObbACcn7VqSA5hYiFssy109/2oU5HMUOVSUk1nBTuc6PenNmRsPPYmCVfg+PyYwG1QjDL1Mg9Mm8a76WNHd+WodEOObRWt73A6GBsMB6y9l+jilc8AvMaIAN/Z5rEVZ6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HezeXzpK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cYGc8bgkg5Zpu6slyAM2fZResCr4NoxWh4jC4YTe6Z4=; b=HezeXzpKy+c+nbPtjU9hQ2YON4
	7NqeGctB0kFJARxdzicRJ9qkqb/LJJPufqo8C9651LqrjVmsH4lClJBWw0/kA46d4v0COqrFTKCZI
	vfY3Li1ZWeapTu9wB2XZrlPdoQP94e41omYnxHovxmUvi/J+VElrUEGoz9eS4yvIAocfBXQpZWEae
	oiGOk6bnS6HU1TGP8+ETw7PK1NHE/+5CdO+cbl60JQbcAptfHk+JrXI2uLAQiOqT7tCcM7zKm932S
	Xbfr0cs334iPsHIUI5lMzyCxUKBtu7IVWV7WgfqlBSwp8c3v9p06+CXnUTQ6G6on2AxvAcGxNfcO1
	hq6KoMFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0EjP-0000000BEyH-28j0;
	Fri, 26 Apr 2024 06:06:47 +0000
Date: Thu, 25 Apr 2024 23:06:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <msnitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] completion: move blk_wait_io to
 kernel/sched/completion.c
Message-ID: <ZitEd_CzSgqy2Kd0@infradead.org>
References: <31b118f3-bc8d-b18b-c4b9-e57d74a73f@redhat.com>
 <20240417175538.GP40213@noisy.programming.kicks-ass.net>
 <546473fd-ca4b-3c64-349d-cc739088b748@redhat.com>
 <ZiCoIHFLAzCva2lU@infradead.org>
 <20240422105956.GN30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422105956.GN30852@noisy.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 22, 2024 at 12:59:56PM +0200, Peter Zijlstra wrote:
> A bit like TASK_NOLOAD (which is used to make TASK_IDLE work), but
> different I suppose.
> 
> TASK_NOHUNG would be trivial to add ofc. But is it worth it?

Yes.  And it would allow us to kill the horrible existing block hack.


