Return-Path: <linux-kernel+bounces-77318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D798603A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE23B25CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE82548E9;
	Thu, 22 Feb 2024 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnNp+y7l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C81054903
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633764; cv=none; b=hkwzrCVZv/lpKPZIWX1B+sjSrBuQguha8Bksqb9g7UFyHzEDyf0QrSwz0VXRVMndygh0+BK6Dcrc13LOAYHvXXc0MADoCIi7DrQj9hF6YS5fYf+YkkR1CCWgU9sH0aV84+Cl+EqnnDN6Qd6mBnNewegIkaxvBSX196vwX0P0NMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633764; c=relaxed/simple;
	bh=EIRl5JmeNnsCCCvrzAJOkSjYNmO/xKRIFAlKwErah0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4xe2vV2XEgSSPzZ30ydqcL9twCJUlKhlT/XZzIrWPxj5lmTSZKmOqcdOK4pIQyBsPKluEeOwb5vm1g6bPL5yG/bY7Y7ZnEgXnuNJvyrCy92wh/b6ONXcGrbXQeBzk0PVNB9G0GKlRldHJW6gurN9vBcIQqPOK/QV3sZcAUjq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnNp+y7l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708633761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9U/SuU7EoZOYs84Oq+NGNW63wWSqGFV+44C2eP5B4o=;
	b=GnNp+y7lj4fd3KSHBNXjRXfvxWZpSAun8XEqx+eF+sThOLU74VNzJq0Sc6z93c3hMKNkMb
	q/Ib3fWMAE79AAIoHFoHm+L2298umJz3f1dVUPaAe17A4EWyf+UHaYB8p2pu9ZADKuWzVw
	WUctRIWIYT2sV9jlJLxsg/MKxwjAblM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-iyyrkQUbOh2tq3JT8S6XPQ-1; Thu, 22 Feb 2024 15:29:20 -0500
X-MC-Unique: iyyrkQUbOh2tq3JT8S6XPQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d308b0c76so599225f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633759; x=1709238559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9U/SuU7EoZOYs84Oq+NGNW63wWSqGFV+44C2eP5B4o=;
        b=g7xYPbNNtUNaaj4qoJAZYO/t3lij6aVg59/ZI6+4uYn6w4DrHTHGJHWXHZqVtYapiU
         FmIF4e0cBCLULxA8Uf+lhWz8dNWfCaEfOkf7fxGqXBYuEHUw7O38vBWvQjj1aJm7N8ct
         LLiRx9hm2kKetSqPz6fVFWPIF6cpEZU80wroNSWzrvolJRtF8YBiLowQD88VTSPrEd8V
         rp9YZnPBBbTalOsIz6Gk47bemlhM1XoYquyBmTooXd4ozAwBjv12iVARGovB0XVbDJuG
         Q4I5VKSN8+MLm938SRlEDrLW+8r0ErpiXZyUUXeG4yir51+ULXSUKvcO9Br0jSTcds6k
         b7Iw==
X-Forwarded-Encrypted: i=1; AJvYcCW6pl1oKfhPjiN6091Vn/cBtBZKgwZ1a+1xbKoKOVmDLmkYarkIE4ylexl3wXq0L+8r/ldI/m4hQsxNJY5X4uk8qbDQfbFRpQQc5g8v
X-Gm-Message-State: AOJu0YwhG1BFo7wcRwfibTSWVqfznwNbir43W8c+OFIHNDT6giJavYbV
	k1NIRb7bxvFDQ6BQu233eYnSoiU+306K9NUCIMXriu4AqLxpfp0EcVNwZ2xpUX07eqh4Y4iKF4x
	49QFeum4gV3Iby8CuJKv28Ctw4OdNOoNUibvIspLgH6XnAO4eBSNKWSKTUF/S7A==
X-Received: by 2002:a5d:490b:0:b0:33d:513a:9248 with SMTP id x11-20020a5d490b000000b0033d513a9248mr3036120wrq.15.1708633758954;
        Thu, 22 Feb 2024 12:29:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmu72LYTYj8EKBymqMoqhVGv0sg4c6wtoeXMyJjoPERBEKhLX3cOJNp9rtBUbNB6tc0W/0bg==
X-Received: by 2002:a5d:490b:0:b0:33d:513a:9248 with SMTP id x11-20020a5d490b000000b0033d513a9248mr3036108wrq.15.1708633758639;
        Thu, 22 Feb 2024 12:29:18 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600004cf00b0033b1c321070sm142852wri.31.2024.02.22.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:29:18 -0800 (PST)
Date: Thu, 22 Feb 2024 15:29:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com,
	axboe@kernel.dk, gregkh@linuxfoundation.org, brauner@kernel.org,
	lstoakes@gmail.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	david.marchand@redhat.com
Subject: Re: [PATCH] vduse: implement DMA sync callbacks
Message-ID: <20240222152541-mutt-send-email-mst@kernel.org>
References: <20240219170606.587290-1-maxime.coquelin@redhat.com>
 <ZdRqcIRmDD-70ap3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdRqcIRmDD-70ap3@infradead.org>

On Tue, Feb 20, 2024 at 01:01:36AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 19, 2024 at 06:06:06PM +0100, Maxime Coquelin wrote:
> > Since commit 295525e29a5b ("virtio_net: merge dma
> > operations when filling mergeable buffers"), VDUSE device
> > require support for DMA's .sync_single_for_cpu() operation
> > as the memory is non-coherent between the device and CPU
> > because of the use of a bounce buffer.
> > 
> > This patch implements both .sync_single_for_cpu() and
> > sync_single_for_device() callbacks, and also skip bounce
> > buffer copies during DMA map and unmap operations if the
> > DMA_ATTR_SKIP_CPU_SYNC attribute is set to avoid extra
> > copies of the same buffer.
> 
> vduse really needs to get out of implementing fake DMA operations for
> something that is not DMA.

In a sense ... but on the other hand, the "fake DMA" metaphor seems to
work surprisingly well, like in this instance - internal bounce buffer
looks a bit like non-coherent DMA.  A way to make this all prettier
would I guess be to actually wrap all of DMA with virtio wrappers which
would all go if () dma_... else vduse_...; or something to this end.  A
lot of work for sure, and is it really worth it? if the only crazy
driver is vduse I'd maybe rather keep the crazy hacks local there ...

-- 
MST


