Return-Path: <linux-kernel+bounces-77247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F174786028F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A421328CBEE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03AE5490A;
	Thu, 22 Feb 2024 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNHfUSPk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5581EA95
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629724; cv=none; b=eO792YwibrQB+keVCnj870e9wyYfMEL/s/kA3T7JIuT6LRUDipU2qAKfnsypZ8JFkgJWY8K3HYOBqjs6Bz41WmzPoxEMz2MPGoWra6oD73GfU/TgfhDEsbNKqoz/OUyF9LiTWxX4sNiPsvUmwvyVOrLiCO8Eh6Gw7CvX871KFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629724; c=relaxed/simple;
	bh=YOFy7rDBur98HKb4T8iNwqGjLEGoqJ8uHEdBXt2njs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uefy2qT10yYhlqobGothz/O5+fqLpv7Y/2MDohAP8BV1GepuHG2ACSPYa8bBZSVr8gNt35N33QRDdbv07ZNDikMJjs+pSKaJLMBbXhkCIh0uOEXOlCbiDGicP+0Cz8kyU5pz7Nt6CxQEAPYjn41c6IOLIESzgWGMN3ic3HvouuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNHfUSPk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708629722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoW+UBQJD6ZgSdChLNCjVMHFeJ/kR7AsTe80jde9KZQ=;
	b=JNHfUSPksUVDbud0v3f5yQkbAgvdmieMoYQ5ibC9HrqUdyDCmzJcn81pGAECIPpwehLZRY
	vu3t5f/pGDVZhKFNbZTmMie7/DCe9drC/XfHcY1BSGBVC8r4RsChDVRtccnJl9uG48/+0U
	LMNeyaz4vwlqo4wxCCWpi1BC/jgPvGM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-l7vbf-thMi6J-t5bDnH9dg-1; Thu, 22 Feb 2024 14:22:00 -0500
X-MC-Unique: l7vbf-thMi6J-t5bDnH9dg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d0d313b81so24053f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629719; x=1709234519;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoW+UBQJD6ZgSdChLNCjVMHFeJ/kR7AsTe80jde9KZQ=;
        b=a1nfUOtvOTGFgVGRhS7YU03M18VPUOjKJ8ssetGo2GsHiLbdoPMGYTXDpVkOX3BvWq
         tLCGzKM3/bmlTuNWE1imRsNeMue8U+hlbcpH2AJarvqY1Ge+ccucTZMyd3szkwqWxjM9
         gOVDP/CJeKPsenTCM5VmTNahPjP2GIewZz/T4DE+ylJvY+1z7bJbtxeMv7HQBhhEPqkN
         yArChfw+0BQHFwwbWyZ1AS5CBS5RDDyvChlQ6xiflcX3KkDjKtz+GPrt60D9v8VmAP6T
         DsLhNxmdU2ZKUZ8hkH5bdX4aeWZzkKa1qy2fBspUo29zDpvCtFv/Umn5nVZy8xaUHa6l
         cNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuNmWnFEWkmkiGco4APVfPCE1KqP9Xbd3E586AGriIyCa9hv4TIHRj0Y2dvPHU0m0iAZQra9v0fLy1ZY2IK2tMcd8xHsX2kfuJok6C
X-Gm-Message-State: AOJu0Yxg1v8WYBr49AuLlFJNibNC15QqGys6UUzCwJsPRj1ixF6Fs2h9
	gwWbW/dS3KCloJARCEiJUZDaU8Sl8R2fhCtUfgLSSt0VeGaxi4XrnYQr3Yf+FOFaWbTft7U5qU/
	r8wWUD59HhybTNWWdh7a7g9U4bDr1+kAIGowkIVFJpfKv9XVhBggzyum+5fz2wg==
X-Received: by 2002:a5d:4a42:0:b0:33d:6fd8:90d3 with SMTP id v2-20020a5d4a42000000b0033d6fd890d3mr80478wrs.4.1708629719228;
        Thu, 22 Feb 2024 11:21:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyAsNHbNiywW9uYcePA/nsah0M+iug3QdVHUBuhKgxM3+lUOSbNSmQdjj9XJdRV2NVji0Wbw==
X-Received: by 2002:a5d:4a42:0:b0:33d:6fd8:90d3 with SMTP id v2-20020a5d4a42000000b0033d6fd890d3mr80467wrs.4.1708629718894;
        Thu, 22 Feb 2024 11:21:58 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d4441000000b0033d8871acdfsm3865273wrr.69.2024.02.22.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:21:58 -0800 (PST)
Date: Thu, 22 Feb 2024 14:21:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>, xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20240222142056-mutt-send-email-mst@kernel.org>
References: <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <20230723053441-mutt-send-email-mst@kernel.org>
 <CACGkMEuPcOyjgHkKXrcnofdb5XhYYTrGQeuR3j6Oypr0KZxLMg@mail.gmail.com>
 <20230724031732-mutt-send-email-mst@kernel.org>
 <CACGkMEvNqJvLvVqQyrw-5jLDA2RvWkSPfb_RLVZbe_wsM=AK4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvNqJvLvVqQyrw-5jLDA2RvWkSPfb_RLVZbe_wsM=AK4g@mail.gmail.com>

On Tue, Jul 25, 2023 at 11:03:11AM +0800, Jason Wang wrote:
> On Mon, Jul 24, 2023 at 3:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 24, 2023 at 02:52:49PM +0800, Jason Wang wrote:
> > > On Mon, Jul 24, 2023 at 2:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Jul 21, 2023 at 10:18:03PM +0200, Maxime Coquelin wrote:
> > > > >
> > > > >
> > > > > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > > > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > > > > > On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > > > > > > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > > > > > > > > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Adding cond_resched() to the command waiting loop for a better
> > > > > > > > > > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > > > > > > > > > run other task(workqueue) instead of busy looping when preemption is
> > > > > > > > > > > > not allowed on a device whose CVQ might be slow.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > >
> > > > > > > > > > > This still leaves hung processes, but at least it doesn't pin the CPU any
> > > > > > > > > > > more.  Thanks.
> > > > > > > > > > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I'd like to see a full solution
> > > > > > > > > > 1- block until interrupt
> > > > > > > > >
> > > > > > > > > Would it make sense to also have a timeout?
> > > > > > > > > And when timeout expires, set FAILED bit in device status?
> > > > > > > >
> > > > > > > > virtio spec does not set any limits on the timing of vq
> > > > > > > > processing.
> > > > > > >
> > > > > > > Indeed, but I thought the driver could decide it is too long for it.
> > > > > > >
> > > > > > > The issue is we keep waiting with rtnl locked, it can quickly make the
> > > > > > > system unusable.
> > > > > >
> > > > > > if this is a problem we should find a way not to keep rtnl
> > > > > > locked indefinitely.
> > > > >
> > > > > From the tests I have done, I think it is. With OVS, a reconfiguration is
> > > > > performed when the VDUSE device is added, and when a MLX5 device is
> > > > > in the same bridge, it ends up doing an ioctl() that tries to take the
> > > > > rtnl lock. In this configuration, it is not possible to kill OVS because
> > > > > it is stuck trying to acquire rtnl lock for mlx5 that is held by virtio-
> > > > > net.
> > > >
> > > > So for sure, we can queue up the work and process it later.
> > > > The somewhat tricky part is limiting the memory consumption.
> > >
> > > And it needs to sync with rtnl somehow, e.g device unregistering which
> > > seems not easy.
> > >
> > > Thanks
> >
> > since when does device unregister need to send cvq commands?
> 
> It doesn't do this now. But if we don't process the work under rtnl,
> we need to synchronize with device unregistering.
> 
> Thanks

But what's not easy about it?

> >
> > > >
> > > >
> > > > > >
> > > > > > > > > > 2- still handle surprise removal correctly by waking in that case
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > > ---
> > > > > > > > > > > >      drivers/net/virtio_net.c | 4 +++-
> > > > > > > > > > > >      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > > > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > > > > > > >              * into the hypervisor, so the request should be handled immediately.
> > > > > > > > > > > >              */
> > > > > > > > > > > >             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > > > > > > > -              !virtqueue_is_broken(vi->cvq))
> > > > > > > > > > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > > > > > +               cond_resched();
> > > > > > > > > > > >                     cpu_relax();
> > > > > > > > > > > > +       }
> > > > > > > > > > > >
> > > > > > > > > > > >             return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > > > > > > > >      }
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.39.3
> > > > > > > > > > > >
> > > > > > > > > > > > _______________________________________________
> > > > > > > > > > > > Virtualization mailing list
> > > > > > > > > > > > Virtualization@lists.linux-foundation.org
> > > > > > > > > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >


