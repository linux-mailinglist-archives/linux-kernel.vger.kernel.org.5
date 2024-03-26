Return-Path: <linux-kernel+bounces-118909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E1388C103
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034D6B2342E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488BD59150;
	Tue, 26 Mar 2024 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwcYUMrK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E7481A5;
	Tue, 26 Mar 2024 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453399; cv=none; b=PCgESzqzJ37VAz9H7zxaoA0lQ2VApuvaPlmV+qEW3TvhNQ0gPtUQyBRoogmKc1hsKimlLjHMBAvzJFt2rtKqTmUoTZzhPS7MrdURQjksl1k5XWwt6IbWpuMxa2d+wFjytqdhEJuuTGnEVskFZLjkKMH7zazNTDoDoc8LY+WfWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453399; c=relaxed/simple;
	bh=+q70O26ZXjPNpVTC31rJuwR6dreQFcSrUybo8JVW1Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOMRy6rQueepnuGi+drHAeMmr5V1l5q0HWaYU/QWJpOgEGkd+IR8azgIewSRmTANmKR+bp8h4xi4tuRTWUZSDx6YGkjvN8rOs6K+O0MmDCl4jqd41+eNjnVwxa9AjHVq+hnKm11ppxKnSyyBzdidjlVWJ/weoXEOpLTFXq/Ne9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwcYUMrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D821FC433C7;
	Tue, 26 Mar 2024 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711453399;
	bh=+q70O26ZXjPNpVTC31rJuwR6dreQFcSrUybo8JVW1Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwcYUMrKQ1S6l+SzMLozCeiunrOAHmJynbh5lU5umulZ7oUNnf1ZJdgjXU7CpPW3s
	 Sw/RqIbfgvR5yG2Z0dQxoZACtpr5XRwbsRk+R+rAB/cxpTCtp8+YcEO8NI+haJEA7k
	 UAQwk7rE+uWtcFW3blADUDZQjyx6QcC+jgDycwT1KIjdo38I8lJH2jZJ8CkQ7E6A8e
	 nF/QAKASrPJ7PsRQqgPl7S6WQeQX3Xc6KeCbqg2eMs9i2TBqbwEk+Su6IOiAP3Vcc9
	 XLZxH/efw/kVIDuhQJjRrpPE9E506h994NFKll+XBSdKZlmFfFMw6HHpXJeR+mbCt3
	 vtkR62AwGBwfg==
Date: Tue, 26 Mar 2024 11:43:13 +0000
From: Will Deacon <will@kernel.org>
To: Keir Fraser <keirf@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gavin Shan <gshan@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240326114313.GA9482@willie-the-truck>
References: <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <20240320030215-mutt-send-email-mst@kernel.org>
 <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
 <20240326033809-mutt-send-email-mst@kernel.org>
 <ZgKXr8IQ51xBECuP@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgKXr8IQ51xBECuP@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 26, 2024 at 09:38:55AM +0000, Keir Fraser wrote:
> On Tue, Mar 26, 2024 at 03:49:02AM -0400, Michael S. Tsirkin wrote:
> > > Secondly, the debugging code is enhanced so that the available head for
> > > (last_avail_idx - 1) is read for twice and recorded. It means the available
> > > head for one specific available index is read for twice. I do see the
> > > available heads are different from the consecutive reads. More details
> > > are shared as below.
> > > 
> > > From the guest side
> > > ===================
> > > 
> > > virtio_net virtio0: output.0:id 86 is not a head!
> > > head to be released: 047 062 112
> > > 
> > > avail_idx:
> > > 000  49665
> > > 001  49666  <--
> > >  :
> > > 015  49664
> > 
> > what are these #s 49665 and so on?
> > and how large is the ring?
> > I am guessing 49664 is the index ring size is 16 and
> > 49664 % 16 == 0
> 
> More than that, 49664 % 256 == 0
> 
> So again there seems to be an error in the vicinity of roll-over of
> the idx low byte, as I observed in the earlier log. Surely this is
> more than coincidence?

Yeah, I'd still really like to see the disassembly for both sides of the
protocol here. Gavin, is that something you're able to provide? Worst
case, the host and guest vmlinux objects would be a starting point.

Personally, I'd be fairly surprised if this was a hardware issue.

Will

