Return-Path: <linux-kernel+bounces-55664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7895884BFAA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A681F22EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6594C1C2A6;
	Tue,  6 Feb 2024 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0ifgro5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2991C288
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257004; cv=none; b=sIM7IrORCnkjOrJOGYGzNilKa/501mEpAQCDveE54T4+MEV/IkH5S8t+gG4ut9wPry8FsVzLeKjoteI2QMCXA7xbf3lvYmrkW+AXqpVFrg6ijs+EfHC6yj2AywhKHR9Qrw16U6AYT8xkHdcWT1ZwWrIIONq55uAfiC279DeKhfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257004; c=relaxed/simple;
	bh=xyQBNoTkq1O4oqqTeTEJswcbAwWfjpSnJmtEgBPlD4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoxNhgrhW88og8+TXHTyATbjhXxxtWfh+j23H13eKGa3P3+E4Ad4/mlgKLDOvyRo1Jk/IlavSJZv404fj2SiMw4ZWtteInlQLL07sRTn10LHdjLhTRzKh5R4CQp//FaD/RT5TcwoVe2SIuk7RODVwp77J70vEGt9kYODLX7ZEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0ifgro5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707257001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGQ9CKP60nkIUyrbfOkkuRKFtxIHT0l75qDIwbDbYwk=;
	b=P0ifgro5ceZsk4cGc82/gHAPzFCU06WPdBHo4r1y75SiqvS88179rJUm9SoWkbIUTAzpjT
	3KYfE8IbFGJr8+dOEk5D+b6FUfR/nwbB68dKwQaGwtq0Cub9EvUUtct2RVIvitNK1iytlH
	dYi8JmUVyCU6XyJ6eSxgwD3CZHBF1+A=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-Gtyv1bFIOv-TS_MGDBUPjQ-1; Tue, 06 Feb 2024 17:03:20 -0500
X-MC-Unique: Gtyv1bFIOv-TS_MGDBUPjQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363da08fc19so1853995ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 14:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256999; x=1707861799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGQ9CKP60nkIUyrbfOkkuRKFtxIHT0l75qDIwbDbYwk=;
        b=StsKqP4nJl1NcCLx3Bedz6dcQTA7/v5Z47DnCnPx2zl8L78Tse9g9ZQF3e2Sur/QF8
         1MyY3z6/Nr6MR+Phb8NBue/3jcU/T2LjsFjs7aq20xEaYB3vAF2Rodls4odVzCW0lPcI
         DDVOlh9eOK+HNUlnczE0hXV4f85Ik2ZVel7BdO3C6KtaPxvViLcQqZhm0g/LgoHJpbvu
         XrX+AxC7UBJtDozP4gT1vBb22XtDJjhGA3+NaOSnq1fx1TwxFmnBS5SXr5WVIUYZilzM
         u0GArdiycAQH9X5onqtfXfNY1Sd3nGZkiN8W6vr//lof8FudZoFvTBJeZe73iW79Nhcr
         jk9w==
X-Gm-Message-State: AOJu0Yz2zFn5oEMnE74bryvtw5Ex8MOZ7/OLdwlbFGoXbrDu28LW6NxP
	c81ZRnlag+ZIkJS6eB/nVxp3Vt8ajrGsyx43a8+NdembJ1+k8ifsUxie472mccEMS3zxfzq4DWa
	mXxj2j+4243NXx++ou4rZeb5t4RcmHbQVsz4y6eX0UFYy3x162mephOGrOuwj6Q==
X-Received: by 2002:a92:c20f:0:b0:363:c54e:ce77 with SMTP id j15-20020a92c20f000000b00363c54ece77mr3283646ilo.27.1707256999606;
        Tue, 06 Feb 2024 14:03:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtray0viZ/e7qTOJ2Zjf5gENoPhO98fPwLsa+DFd98WJYhfBSn1S2km2MEuNGDziLYKkGlfg==
X-Received: by 2002:a92:c20f:0:b0:363:c54e:ce77 with SMTP id j15-20020a92c20f000000b00363c54ece77mr3283627ilo.27.1707256999321;
        Tue, 06 Feb 2024 14:03:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWBD8UhrHELZFP+nxm6jfln9Nfbwuz8dk5jVfem/4za5w3FroJbp+xghUTpS+PgwllCN876Gh6gGzwg2j+iiXiKhgbUftWKShr8bNLMQ5ixfMwpwIxdIIXQWOWMJQm0E5sX0dODwGc1seLwZZSMonBEliZQBM5z2K/3vArxwd+6XbM1WcmN/Uuo2ZcKqp8tqm3MqzR4iSX3YuecQvfFOmcC1BKb3H20D8+EbtSdRO4V82XDLk81FaFjTDe8C38zG3/JtrE1BFO/uc8hHXN1IZ+Vdc5dqeSTILfzbHsC39GdjL1RwbH23Lv46CjozV04GPqmbv/DRw==
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id cr2-20020a056e023a8200b00363b935979asm64093ilb.9.2024.02.06.14.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:03:18 -0800 (PST)
Date: Tue, 6 Feb 2024 15:03:16 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
 <kvm@vger.kernel.org>, <dave.jiang@intel.com>, <ashok.raj@intel.com>,
 <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 07/17] vfio/pci: Preserve per-interrupt contexts
Message-ID: <20240206150316.66e24a8d.alex.williamson@redhat.com>
In-Reply-To: <6cef4f69-e19d-4741-9cff-a9485dd58d89@intel.com>
References: <cover.1706849424.git.reinette.chatre@intel.com>
	<d6e32e0e7adaf61da39fb6cd2863298b15a2663e.1706849424.git.reinette.chatre@intel.com>
	<20240205153509.333c2c95.alex.williamson@redhat.com>
	<6cef4f69-e19d-4741-9cff-a9485dd58d89@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 13:45:22 -0800
Reinette Chatre <reinette.chatre@intel.com> wrote:

> Hi Alex,
> 
> On 2/5/2024 2:35 PM, Alex Williamson wrote:
> > On Thu,  1 Feb 2024 20:57:01 -0800
> > Reinette Chatre <reinette.chatre@intel.com> wrote:  
> 
> ..
> 
> >> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> >> index 31f73c70fcd2..7ca2b983b66e 100644
> >> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> >> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> >> @@ -427,7 +427,7 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
> >>  
> >>  	ctx = vfio_irq_ctx_get(vdev, vector);
> >>  
> >> -	if (ctx) {
> >> +	if (ctx && ctx->trigger) {
> >>  		irq_bypass_unregister_producer(&ctx->producer);
> >>  		irq = pci_irq_vector(pdev, vector);
> >>  		cmd = vfio_pci_memory_lock_and_enable(vdev);
> >> @@ -435,8 +435,9 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
> >>  		vfio_pci_memory_unlock_and_restore(vdev, cmd);
> >>  		/* Interrupt stays allocated, will be freed at MSI-X disable. */
> >>  		kfree(ctx->name);
> >> +		ctx->name = NULL;  
> > 
> > Setting ctx->name = NULL is not strictly necessary and does not match
> > the INTx code that we're claiming to try to emulate.  ctx->name is only
> > tested immediately after allocation below, otherwise it can be inferred
> > from ctx->trigger.  Thanks,  
> 
> This all matches my understanding. I added ctx->name = NULL after every kfree(ctx->name)
> (see below for confirmation of other instance). You are correct that the flow
> infers validity of ctx->name from ctx->trigger. My motivation for
> adding ctx->name = NULL is that, since the interrupt context persists, this
> change ensures that there will be no pointer that points to freed memory. I
> am not comfortable leaving pointers to freed memory around.

Fair enough.  Maybe note the change in the commit log.  Thanks,

Alex

> >>  		eventfd_ctx_put(ctx->trigger);
> >> -		vfio_irq_ctx_free(vdev, ctx, vector);
> >> +		ctx->trigger = NULL;
> >>  	}
> >>  
> >>  	if (fd < 0)
> >> @@ -449,16 +450,17 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
> >>  			return irq;
> >>  	}
> >>  
> >> -	ctx = vfio_irq_ctx_alloc(vdev, vector);
> >> -	if (!ctx)
> >> -		return -ENOMEM;
> >> +	/* Per-interrupt context remain allocated. */
> >> +	if (!ctx) {
> >> +		ctx = vfio_irq_ctx_alloc(vdev, vector);
> >> +		if (!ctx)
> >> +			return -ENOMEM;
> >> +	}
> >>  
> >>  	ctx->name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-msi%s[%d](%s)",
> >>  			      msix ? "x" : "", vector, pci_name(pdev));
> >> -	if (!ctx->name) {
> >> -		ret = -ENOMEM;
> >> -		goto out_free_ctx;
> >> -	}
> >> +	if (!ctx->name)
> >> +		return -ENOMEM;
> >>  
> >>  	trigger = eventfd_ctx_fdget(fd);
> >>  	if (IS_ERR(trigger)) {
> >> @@ -502,8 +504,7 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
> >>  	eventfd_ctx_put(trigger);
> >>  out_free_name:
> >>  	kfree(ctx->name);
> >> -out_free_ctx:
> >> -	vfio_irq_ctx_free(vdev, ctx, vector);
> >> +	ctx->name = NULL;  
> 
> Here is the other one.
> 
> Reinette
> 


