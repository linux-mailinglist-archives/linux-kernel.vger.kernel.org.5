Return-Path: <linux-kernel+bounces-80018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A1F8629C7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618E0B21551
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D13EEED4;
	Sun, 25 Feb 2024 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnhWfra0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD38BF1
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708850785; cv=none; b=ZLyJ8ShAdW0tO9x/JIaDAuz3sFaLOQd6oHypGk8DtwmWFEuRSg6r48uzCN6GXcs48+yAexAEBpbA2BaW7HXAle0j0Ayf9yN5uuUItF8CRjyOAdOn/3+O1CldGSE1eF/xF1uTh6VLwss4U718HjGxf1zCD2UOfFWEWWUCoeQnLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708850785; c=relaxed/simple;
	bh=qRBGx5Eui1Rg0T17s7xynohjX+P8XO5mBOcrisme1bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/6BWQ8rhq7A2YFyvAu4Xg1YzCB2UYYl7cF+PIyxOZJGX0T2X5gsOKnuysj1s64Zjsts1USnLgxoAFvYS6HKUzUp2q67trm3QcKpTmWuHiLSi1kPTDeQVYiF0rm3aFk7Kfjdy6BJOsri2FQzXZQokD545GPQoyYrmkTZ3jq1p38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnhWfra0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708850783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rfe0ULI+yf/mlID853QRO5tR+jdkdt5ribt0vShWIFo=;
	b=XnhWfra0/iKw8ZpqdmRsgQ46sO9lz60VHqR4hkp6aDflAy6HoEztIVFTDWsXR6VPI6Ab8h
	u1weulGyNZN9kw9YHgmfjpLoTB0J+SwIHUPGUStrZGahqeaVPUe9oFajb65ylctFSk/yeQ
	sZHMpyYfjxG+Cl6Ag8T4rTBbV5HfX+M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-LbX2LkXKNFak0nsamLJKow-1; Sun, 25 Feb 2024 03:46:21 -0500
X-MC-Unique: LbX2LkXKNFak0nsamLJKow-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d39bc6bf4so1194956f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 00:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708850780; x=1709455580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rfe0ULI+yf/mlID853QRO5tR+jdkdt5ribt0vShWIFo=;
        b=MeM9crqGCnzJE3B1iL3H7p7Vkk3w8qh0UjhnPmyW6cY85VYWs/2mjlqzz6p2GASlkf
         JRNaNqwvZqtUPJQt7qkt5tyScMCb7XXZkN+tCkUxqW7pUOuP8aDiQbPlCDyHjB/bBgiY
         QXfrp1IW1b66wllOyDv6zYKWn0zCoUOlqHyBCIsB3Ihx1rQGWfLwI+ooNUyBTylUU7a0
         7aKxRq1Fj9s5quzxIcgrv66tHDM7Iuo7udwj0zSbmAVdQbkZI5fl4awebkn1QVr10AI5
         QGYUPssJmVsMOmtM4HXSoIBXPfSJfpVuAUvC5HkBm/msVyY2xbpEyFn+xhoqtpMQUZum
         pJ2g==
X-Forwarded-Encrypted: i=1; AJvYcCWZe07E0ha6ORprDb0v9Pv9bQIzfchIE4OAQ13WMQLMi1DFbjTrcfzxvUrylNQsXSwRJ0TIs7Gs+nXMwyPxMSzzLSn0032XVxr+s1vf
X-Gm-Message-State: AOJu0YyER/dTixGkOz/j1TNsK1OEL7g9kj/ntD6MjrBnxgqrURrxwNRH
	ywViQkHmcXQhPg1AUWqpKvrdbNctUgyserVzUUG7pl3jzE0Dfaoq46WY3O8+sYjP9NkZta8Uf8W
	7fL7iYcDig7b3LD5tpaNlyxfkLg1LTDLn+p+s4iR1/+7KV7XyyjX1tOjwxAvtqg==
X-Received: by 2002:a5d:59ac:0:b0:33d:d2d0:acb6 with SMTP id p12-20020a5d59ac000000b0033dd2d0acb6mr476367wrr.28.1708850780476;
        Sun, 25 Feb 2024 00:46:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmJCF/RtfKMVJuqXHI/65+QRM1LmffyF/iU7ToqPLCzqEL1wzs0AI/dPXKJoA+CgVrkS38eg==
X-Received: by 2002:a5d:59ac:0:b0:33d:d2d0:acb6 with SMTP id p12-20020a5d59ac000000b0033dd2d0acb6mr476351wrr.28.1708850780163;
        Sun, 25 Feb 2024 00:46:20 -0800 (PST)
Received: from redhat.com ([2.52.10.44])
        by smtp.gmail.com with ESMTPSA id bw11-20020a0560001f8b00b0033da4b06632sm4602412wrb.6.2024.02.25.00.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 00:46:19 -0800 (PST)
Date: Sun, 25 Feb 2024 03:46:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, houtao1@huawei.com
Subject: Re: [PATCH] virtiofs: limit the length of ITER_KVEC dio by
 max_nopage_rw
Message-ID: <20240225034356-mutt-send-email-mst@kernel.org>
References: <20240103105929.1902658-1-houtao@huaweicloud.com>
 <CAJfpegsM2ViQb1A2HNMJLsgVDs1UScd7p04MOLSkSMRNeshm0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsM2ViQb1A2HNMJLsgVDs1UScd7p04MOLSkSMRNeshm0A@mail.gmail.com>

On Fri, Feb 23, 2024 at 10:42:37AM +0100, Miklos Szeredi wrote:
> On Wed, 3 Jan 2024 at 11:58, Hou Tao <houtao@huaweicloud.com> wrote:
> >
> > From: Hou Tao <houtao1@huawei.com>
> >
> > When trying to insert a 10MB kernel module kept in a virtiofs with cache
> > disabled, the following warning was reported:
> >
> >   ------------[ cut here ]------------
> >   WARNING: CPU: 2 PID: 439 at mm/page_alloc.c:4544 ......
> >   Modules linked in:
> >   CPU: 2 PID: 439 Comm: insmod Not tainted 6.7.0-rc7+ #33
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ......
> >   RIP: 0010:__alloc_pages+0x2c4/0x360
> >   ......
> >   Call Trace:
> >    <TASK>
> >    ? __warn+0x8f/0x150
> >    ? __alloc_pages+0x2c4/0x360
> >    __kmalloc_large_node+0x86/0x160
> >    __kmalloc+0xcd/0x140
> >    virtio_fs_enqueue_req+0x240/0x6d0
> >    virtio_fs_wake_pending_and_unlock+0x7f/0x190
> >    queue_request_and_unlock+0x58/0x70
> >    fuse_simple_request+0x18b/0x2e0
> >    fuse_direct_io+0x58a/0x850
> >    fuse_file_read_iter+0xdb/0x130
> >    __kernel_read+0xf3/0x260
> >    kernel_read+0x45/0x60
> >    kernel_read_file+0x1ad/0x2b0
> >    init_module_from_file+0x6a/0xe0
> >    idempotent_init_module+0x179/0x230
> >    __x64_sys_finit_module+0x5d/0xb0
> >    do_syscall_64+0x36/0xb0
> >    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >    ......
> >    </TASK>
> >   ---[ end trace 0000000000000000 ]---
> >
> > The warning happened as follow. In copy_args_to_argbuf(), virtiofs uses
> > kmalloc-ed memory as bound buffer for fuse args, but
> 
> So this seems to be the special case in fuse_get_user_pages() when the
> read/write requests get a piece of kernel memory.
> 
> I don't really understand the comment in virtio_fs_enqueue_req():  /*
> Use a bounce buffer since stack args cannot be mapped */
> 
> Stefan, can you explain?  What's special about the arg being on the stack?

virtio core wants DMA'able addresses.

See Documentation/core-api/dma-api-howto.rst :

..


This rule also means that you may use neither kernel image addresses
(items in data/text/bss segments), nor module image addresses, nor
stack addresses for DMA.



> What if the arg is not on the stack (as is probably the case for big
> args like this)?   Do we need the bounce buffer in that case?
> 
> Thanks,
> Miklos


