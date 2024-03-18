Return-Path: <linux-kernel+bounces-106412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A22DD87EE49
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42567B230DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D385578E;
	Mon, 18 Mar 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo/GJa7t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711945577F;
	Mon, 18 Mar 2024 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781170; cv=none; b=ppjPdiM9NaVUKRXIaBC2n4zGNWgUi+OODsjdUrCdzp6nrRv4W6BRPumSikhP+1brhJPC6o9GqZXViFdMgdBihbXu7r2UoTwl1Sp4Sli+Zf0Ra3WGFQ0kQ4V02u2glLhGjSOFtNQkBJ1rcSMPRFqV+I6EjUDo8n7shhloll3FL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781170; c=relaxed/simple;
	bh=309esXPROR72XF5lugy8hqSX4sumxs3hZ1s5WYP+zMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnBKDRL9KkGsK51Bx3yU2Mt2DUPq999sXyKsj8hqQQ5VlHUC53hoWX7i/9HLCKizagA763BkjnBB/Uz2Ce190IRFnub29pwCNTSUXu59vm0ob+Wy4fTcN2cXtjOl/bd3Qreo1mNRucszhSFEpz4ZBAk1081bH8zKZhK5kvgXl1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo/GJa7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A2BC433F1;
	Mon, 18 Mar 2024 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710781170;
	bh=309esXPROR72XF5lugy8hqSX4sumxs3hZ1s5WYP+zMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mo/GJa7t/sGuslJBzjOp2deS2+fdXByifJ25a9x15hSNp470Rb1nTno4Bl7BM7NOm
	 jmfJzlzWYhweTaNGRy769kXt5by/dyQYvgiYam7eFhCk9/JqZZVLGj6694+97I9mn4
	 ZgWBorPUQl3AkWYg9/m1FSWHVm/JDKjQVDm/SBgPCl/YiV3qseRnLtc9gtiQTpBqmv
	 hpIrhqprHNqDuG0b3XCdM31vHUbfyaeT0FiXcOBzUT/eX3f7AG4aZkDa42zNzoLSxW
	 8q3+i7yTMVuGfVKbifvBe7nlJVFqUCRnJi7uHBLPZEVoDUPO+oh3UBV+4ibd/23A//
	 SxTQ4HWKSY0Hg==
Date: Mon, 18 Mar 2024 16:59:24 +0000
From: Will Deacon <will@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240318165924.GA1824@willie-the-truck>
References: <20240314074923.426688-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314074923.426688-1-gshan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
> The issue is reported by Yihuang Yu who have 'netperf' test on
> NVidia's grace-grace and grace-hopper machines. The 'netperf'
> client is started in the VM hosted by grace-hopper machine,
> while the 'netperf' server is running on grace-grace machine.
> 
> The VM is started with virtio-net and vhost has been enabled.
> We observe a error message spew from VM and then soft-lockup
> report. The error message indicates the data associated with
> the descriptor (index: 135) has been released, and the queue
> is marked as broken. It eventually leads to the endless effort
> to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
> and soft-lockup. The stale index 135 is fetched from the available
> ring and published to the used ring by vhost, meaning we have
> disordred write to the available ring element and available index.
> 
>   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
>   -accel kvm -machine virt,gic-version=host                            \
>      :                                                                 \
>   -netdev tap,id=vnet0,vhost=on                                        \
>   -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
> 
>   [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
> 
> Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
> virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
> ARM64. It should work for other architectures, but performance loss is
> expected.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 49299b1f9ec7..7d852811c912 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>  	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>  
> -	/* Descriptors and available array need to be set before we expose the
> -	 * new available array entries. */
> -	virtio_wmb(vq->weak_barriers);
> +	/*
> +	 * Descriptors and available array need to be set before we expose
> +	 * the new available array entries. virtio_wmb() should be enough
> +	 * to ensuere the order theoretically. However, a stronger barrier
> +	 * is needed by ARM64. Otherwise, the stale data can be observed
> +	 * by the host (vhost). A stronger barrier should work for other
> +	 * architectures, but performance loss is expected.
> +	 */
> +	virtio_mb(false);
>  	vq->split.avail_idx_shadow++;
>  	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>  						vq->split.avail_idx_shadow);

Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
here, especially when ordering accesses to coherent memory.

In practice, either the larger timing different from the DSB or the fact
that you're going from a Store->Store barrier to a full barrier is what
makes things "work" for you. Have you tried, for example, a DMB SY
(e.g. via __smb_mb()).

We definitely shouldn't take changes like this without a proper
explanation of what is going on.

Will

