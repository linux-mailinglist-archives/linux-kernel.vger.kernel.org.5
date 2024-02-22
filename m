Return-Path: <linux-kernel+bounces-77243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5567886027E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F96B28E401
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1BB6AF82;
	Thu, 22 Feb 2024 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKtSC+px"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7B1EA95
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629501; cv=none; b=talyniUr+N/jkPX4XPO1xBOPNUlPF6V3CSpj2G2jr41oQ5PSzRzhUkP77h+qENCgo40n6w481w4CjWmpUxashPTnSa5PPnY2y2/Ky/FjtpGq3cJRi2DtWvinI4pxy7+XW4gf9h6x2ddSFk9rtN8HVkZJykkeoOIHNXm7cAQR51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629501; c=relaxed/simple;
	bh=xVVob+Z7aWmWX37Km9Dh5DfsqExi/AgPNz1ll0QzV18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBm7Z8u+LyLrMhc8QYWKnYNBvjHSkgkvfzXZ6oqDOazcR+U2g36jNsX2E4wDAjQfBpnyyMc8TzS6yg3CxLHznzCFVix+n8lwQvKE5Cn6QJ/Jh9QNZXYabMxNHIHAhRqBvOhpre1NFI2qsKlI1LNyRxMseKVcI3+rXl+HeW2Xqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKtSC+px; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708629495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkFttZQemmEwyaRYG2D+K70dFQfSH+R53teWu1VY0ro=;
	b=JKtSC+pxZn9Nl6ElYvtz6nGHbDkzybIYb841E7zN3cnpnWCLk/hm/yo+/h+2n4Yb29RHWI
	BTUjT55dknrekLWdG7wshssXFBNLP/IjyUr+cl+lwZjG58dOqE1kthWmlN40qKi5ZbrWtj
	31aBlX50zR0ERY+g7r/H97Bsfy8j0t8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-GxExdSMePiK7DYo61fWS7A-1; Thu, 22 Feb 2024 14:18:14 -0500
X-MC-Unique: GxExdSMePiK7DYo61fWS7A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d36736772so31642f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629493; x=1709234293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkFttZQemmEwyaRYG2D+K70dFQfSH+R53teWu1VY0ro=;
        b=Drz6L58MTqnCo8t6ykpGuznDF/dPbtcN107QoBilJEL7meymck6F9XlsRKns2M59fb
         GJuFAdBtz8/jbzRGDLKj+7mtwWVxgxFVTbwtBJj18DMVDffu34JWXeghmuhGzEbzg4ql
         M8Ep4ly9GFi8JnLMcwozE+d1zshilOAUg3PSEwlBH2EpJEzfIwq06glQkVmj1WL2ff63
         biDNdt01PIuKcMu4vLhPcgscKFT44ZPf2L13wiLrPzhO0dLYe1s4Pkq7HuEcWWlrMUr9
         8WpNddB1McFGPcMODjB45mcnj46R7qMUtv/upgc+Faufw7Fcs3OKob/xt+y88Gb2J9+i
         HDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3xBf0zECQu7x9+6Fr6i2yvn6avT2qP2oMeCxNfwdv2QkU/j/msjFDc3y04bWwGZFd592fJe27ygHgEdx8kHEjoOXjimOLLTSEkdj9
X-Gm-Message-State: AOJu0YxrR1D6OaXXxJEQGT+xJL7F2QGwRJ/dL1rSnfXcZP16JaaB4Dzm
	VJIwpaqJk8I2L6AwzQvmGM9ZZPE+vUzFBTGnS/+HzDX878m9Mmz1nYR+cWXn7KBREHQvRJeOxf5
	qxnghduqfvSLgleKGx1XWxXQDGgqWIzoN6Qpq1nZgcXwCIWd4EAlZYV2JCHz1hw==
X-Received: by 2002:a5d:5604:0:b0:33d:3098:3ccf with SMTP id l4-20020a5d5604000000b0033d30983ccfmr57325wrv.33.1708629493455;
        Thu, 22 Feb 2024 11:18:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG38ddyZFSkIeEFCaLW3FvivRrTjKt4RKwbqN6Gy7UGOlk8YwQCEsIP+k/ia5ry299E4TVfSg==
X-Received: by 2002:a5d:5604:0:b0:33d:3098:3ccf with SMTP id l4-20020a5d5604000000b0033d30983ccfmr57320wrv.33.1708629493149;
        Thu, 22 Feb 2024 11:18:13 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id o11-20020adfcf0b000000b0033b4dae972asm21160901wrj.37.2024.02.22.11.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:18:12 -0800 (PST)
Date: Thu, 22 Feb 2024 14:18:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, xieyongji@bytedance.com,
	linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Subject: Re: [PATCH v4 0/5] vduse: Add support for reconnection
Message-ID: <20240222141559-mutt-send-email-mst@kernel.org>
References: <20240207054701.616094-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207054701.616094-1-lulu@redhat.com>

On Wed, Feb 07, 2024 at 01:43:27PM +0800, Cindy Lu wrote:
> Here is the reconnect support in vduse,
> 
> Kernel will allocate pages for reconnection.
> Userspace needs to use mmap to map the memory to userspace and use these pages to
> save the reconnect information.

What is "reconnect"? Not really clear from documentation - it seems to
be assumed that reader has an idea but most don't.

Also what's with all the typos? reconnect with 3 nnn s, sutiable and so
on. Can you pls run a speller?

> test passd in vduse+dpdk-testpmd
> 
> change in V2
> 1. Address the comments from v1
> 2. Add the document for reconnect process
> 
> change in V3
> 1. Move the vdpa_vq_state to the uAPI.  vduse will use this to synchronize the vq info between the kernel and userspace app.
> 2. Add a new ioctl VDUSE_DEV_GET_CONFIG. userspace app use this to get config space
> 3. Rewrite the commit message.
> 4. Only save the address for the page address and remove the index.
> 5. remove the ioctl VDUSE_GET_RECONNECT_INFO, userspace app will use uAPI VDUSE_RECONNCT_MMAP_SIZE to mmap
> 6. Rewrite the document for the reconnect process to make it clearer.
> 
> change in v4
> 1. Change the number of map pages to VQ numbers. UserSpace APP can define and maintain the structure for saving reconnection information in userspace. The kernel will not maintain this information.
> 2. Rewrite the document for the reconnect process to make it clearer.
> 3. add the new ioctl for VDUSE_DEV_GET_CONFIG/VDUSE_DEV_GET_STATUS
> 
> Cindy Lu (5):
>   vduse: Add new ioctl VDUSE_DEV_GET_CONFIG
>   vduse: Add new ioctl VDUSE_DEV_GET_STATUS
>   vduse: Add function to get/free the pages for reconnection
>   vduse: Add file operation for mmap
>   Documentation: Add reconnect process for VDUSE
> 
>  Documentation/userspace-api/vduse.rst |  32 +++++++
>  drivers/vdpa/vdpa_user/vduse_dev.c    | 125 ++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h            |   5 ++
>  3 files changed, 162 insertions(+)
> 
> -- 
> 2.43.0


