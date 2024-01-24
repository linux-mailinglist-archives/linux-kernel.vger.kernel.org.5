Return-Path: <linux-kernel+bounces-37411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F683AF78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201E2B2338F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7243D7F7CE;
	Wed, 24 Jan 2024 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk7GwTob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896D7E789;
	Wed, 24 Jan 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116636; cv=none; b=mHE+YB8jWT1SSnX/QpxXGb8Pef4iQfMani8VCRSKvAjbaOGopdD26rU497CZaDunFVILjJMo0ZUlYqwjdwWmfQQpPxIVLrSqmSAtCnG7D4k8UWnVgXjK/thMvOuLIPnPz+YrdD1r6b7NSRj2BrFkysOZBMHUJk/LK+gx7ZC7UV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116636; c=relaxed/simple;
	bh=p0ABOTonvB4mJUph9gKMNiWtDvBfGNCitra/es/MHtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8RKBiVaMMqZX4ESjnrOFdLDVeIam87eGlrniD9gIsDyUhbJtVtrWQFinRlUP2UQLqT/1mDQqBoyQ1+o5QzF8uppJ+0GdrffMY3bqrCgPQ2nBigr8iIUryRLoOoZzAXk5p0zfhIIHXu/lYw8s0diohXRori4FxSHVUS6JVd/X+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk7GwTob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209FFC433C7;
	Wed, 24 Jan 2024 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706116636;
	bh=p0ABOTonvB4mJUph9gKMNiWtDvBfGNCitra/es/MHtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hk7GwTobXn7xyt7w06YZeO9sMIEa3ZpumgsuZKpZOVyStpMOEPFgGAZBNBxTlsGuA
	 0+HHeyAyYHDpmcWVykxEooVOrNCmqqlFFkh1j3IqTtJyMV/AZ/y6jv58hGVa/6owrv
	 yEM+RbnRFtxYESZRKBDsxx853WweEjbLlziY7ErXmnICX+BpMOpE2r71qfF9pT7oP7
	 eYrl9W9nCVVPs/pT80qrjXNBdg4Ua0ZY6hRqkaRxq+VD2aCQLB1jbnoAQm4cbdEM4J
	 mXq5vzM7HJ0Wa0Oy9rrXILAm/IZyZ9CsmgUhHI6vokWYTcUNfL+FYi1QyEbungd4h/
	 aDayhYE2e3qcg==
Date: Wed, 24 Jan 2024 10:17:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: yi sun <sunyibuaa@gmail.com>
Cc: Yi Sun <yi.sun@unisoc.com>, axboe@kernel.dk, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	pbonzini@redhat.com, stefanha@redhat.com,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com,
	hongyu.jin@unisoc.com
Subject: Re: [PATCH 1/2] blk-mq: introduce
 blk_mq_tagset_wait_request_completed()
Message-ID: <ZbFGGPkNsvShlFkc@kbusch-mbp.dhcp.thefacebook.com>
References: <20240122110722.690223-1-yi.sun@unisoc.com>
 <20240122110722.690223-2-yi.sun@unisoc.com>
 <ZbAQLRLNSx-IRRwM@kbusch-mbp.dhcp.thefacebook.com>
 <CALpufv1XRYX7bv-NAUMmRjWr0jhDC1xrd+d48XejJZPjZZLEYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALpufv1XRYX7bv-NAUMmRjWr0jhDC1xrd+d48XejJZPjZZLEYQ@mail.gmail.com>

On Wed, Jan 24, 2024 at 07:22:21PM +0800, yi sun wrote:
> In my case, I want all hw queues owned by this device to be clean.
> Because in the virtio device, each hw queue corresponds to a virtqueue,
> and all virtqueues will be deleted when vdev suspends.
> 
> The blk_mq_tagset_wait_request_completed() function can ensure that
> the device has processed all in_flight requests , and these requests have
> become the complete state. I don´t understand the blk_mq_freeze_queue()
> function very well. Can the function ensure that all requests have become
> complete status? How should I use the function to achieve the same effect?

Yeah, just do something like this:

---
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5bf98fd6a651a..2f69675abdf29 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1593,14 +1593,14 @@ static int virtblk_freeze(struct virtio_device *vdev)
 {
        struct virtio_blk *vblk = vdev->priv;

+       blk_mq_freeze_queue(vblk->disk->queue);
+
        /* Ensure we don't receive any more interrupts */
        virtio_reset_device(vdev);

        /* Make sure no work handler is accessing the device. */
        flush_work(&vblk->config_work);

-       blk_mq_quiesce_queue(vblk->disk->queue);
-
        vdev->config->del_vqs(vdev);
        kfree(vblk->vqs);

--

