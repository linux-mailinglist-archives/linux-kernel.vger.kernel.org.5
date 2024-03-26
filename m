Return-Path: <linux-kernel+bounces-119389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA088C813
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366D41F80FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A98013C91B;
	Tue, 26 Mar 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtXOD6iW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E7013C3C4;
	Tue, 26 Mar 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467995; cv=none; b=eikQpBj7jQPmVE04jJ4MXRBgD/hW9Ok8w6eXyGrm0a71JGQRMD16ZPNJf63ir4T1PPXO8NUon6WwAeibkEG/LCTzyT06IIu5mfkZxHxnMEt80NCMATxnlZ103hWgX+SKxQoChWLlPtODzLErADPfZTTjFKTQwqwPV1ccdkLBGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467995; c=relaxed/simple;
	bh=blMMUCS6bBwkEUeKDfD5/uqKHUYqqABX3cMRG8GSLtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnEmZfaRFCq0CywlbKY1GikGDLB63uh219sNsDQb+IApCUEuX2ndjej8Kt5VbUnolY1oSaLYpthueKJqmFyXAlMXojp6q0U3rZ7k9NJE0v9UO7sCEhBPuDDIG2cIjKO7RKtyRC1OApB3J8V1Na3w6sMpzrrEzIlfCl0iZRd0A7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtXOD6iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CCFC43394;
	Tue, 26 Mar 2024 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467994;
	bh=blMMUCS6bBwkEUeKDfD5/uqKHUYqqABX3cMRG8GSLtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtXOD6iWSamqz0Z4Z2qRKxQx5zenEIGgmpVobYercZRuxN04pSqre+436BYwczR1z
	 xUOu00ogyzPBJ8VMxe2OtroDVVpSOLB9/VDJc3ZtWe9Z8trBwb5AzHdzZ6dBKnOl7S
	 j23/yCWp4ziRHXMaC4sTcB6jaRBAmL2VMghON5PvuR+B9aWB5BflLQY32JLyjdhCsI
	 BFqWK+dSiPl0qkEXLWxqlVE2TCrHh3fn6sneuVVO7ZmLsgcCjohsGQd4eIra3LxnNF
	 Wsa3oI7oWDa/z1ouDfCokJH30C5BAgGAnoVMjquuwSGVql191lxWXcTwXXZCLOrny9
	 dZV3fMT7ND9gA==
Date: Tue, 26 Mar 2024 15:46:29 +0000
From: Will Deacon <will@kernel.org>
To: Keir Fraser <keirf@google.com>, gshan@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240326154628.GA9613@willie-the-truck>
References: <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <20240320030215-mutt-send-email-mst@kernel.org>
 <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
 <20240326033809-mutt-send-email-mst@kernel.org>
 <ZgKXr8IQ51xBECuP@google.com>
 <20240326114313.GA9482@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326114313.GA9482@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 26, 2024 at 11:43:13AM +0000, Will Deacon wrote:
> On Tue, Mar 26, 2024 at 09:38:55AM +0000, Keir Fraser wrote:
> > On Tue, Mar 26, 2024 at 03:49:02AM -0400, Michael S. Tsirkin wrote:
> > > > Secondly, the debugging code is enhanced so that the available head for
> > > > (last_avail_idx - 1) is read for twice and recorded. It means the available
> > > > head for one specific available index is read for twice. I do see the
> > > > available heads are different from the consecutive reads. More details
> > > > are shared as below.
> > > > 
> > > > From the guest side
> > > > ===================
> > > > 
> > > > virtio_net virtio0: output.0:id 86 is not a head!
> > > > head to be released: 047 062 112
> > > > 
> > > > avail_idx:
> > > > 000  49665
> > > > 001  49666  <--
> > > >  :
> > > > 015  49664
> > > 
> > > what are these #s 49665 and so on?
> > > and how large is the ring?
> > > I am guessing 49664 is the index ring size is 16 and
> > > 49664 % 16 == 0
> > 
> > More than that, 49664 % 256 == 0
> > 
> > So again there seems to be an error in the vicinity of roll-over of
> > the idx low byte, as I observed in the earlier log. Surely this is
> > more than coincidence?
> 
> Yeah, I'd still really like to see the disassembly for both sides of the
> protocol here. Gavin, is that something you're able to provide? Worst
> case, the host and guest vmlinux objects would be a starting point.
> 
> Personally, I'd be fairly surprised if this was a hardware issue.

Ok, long shot after eyeballing the vhost code, but does the diff below
help at all? It looks like vhost_vq_avail_empty() can advance the value
saved in 'vq->avail_idx' but without the read barrier, possibly confusing
vhost_get_vq_desc() in polling mode.

Will

--->8

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 045f666b4f12..87bff710331a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2801,6 +2801,7 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
                return false;
        vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
 
+       smp_rmb();
        return vq->avail_idx == vq->last_avail_idx;
 }
 EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);


