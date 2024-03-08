Return-Path: <linux-kernel+bounces-96544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97414875DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6C2283B1D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D0036122;
	Fri,  8 Mar 2024 06:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SctkfN6N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E5A1E4A4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709878082; cv=none; b=GC66gDYVytVWliXLFP5+7i66t9VG/fpQ/jtjU2AdiZjz1QprOsinyxP46gpAyP/0fcdVjA1e4fxGdwbCUVLSHmQeJX+Lfs4R86bxALMN9ZIm4LsFheAHR6keISVxKmCHo2oO0b/ckTjQRCYVWitLyj45Q0gdB8GyNPadqkQ67E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709878082; c=relaxed/simple;
	bh=yAYwAe6qEsAeNiOqFJZgN170LNpSGpFkEbfZshwvHMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlQDx+RZRDkeoU81LVKu4VbJiwqy591ifoPi1ee3fYZ2+R571airCrMR+VvnS5gt5SEJ9dsL8cI0NbAVMJuOSrjMRJW1q5Ibc9E3o4rzMqqLY7hHnB9qmVc3U7XN9SNkviz0ABtCNAG3aP2cgt7Zeb+gymfqiSE/fa5JlE6pi8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SctkfN6N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709878080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/4Biu2R85f0cuL1kJQyJ2DRVnushj+5L95Ki/9bvU8=;
	b=SctkfN6Nr0TGa8DaLH7lue9FmDQeVpwKa8OEKs3V6IVfyBE7zkGVcX+VmoIfkOGfRUL7CE
	n0CWDZ8DZaV6erju06uzQ1dWaoPZRoVE7JC3b5f941K3W/6NBdwEDSr6v6kKyg207jH0Pb
	3DDl5yZtn1vo8OSw3Yy/iHzuNKj1agk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-f5jPDFYbNsa_J2vwLB-jmw-1; Fri, 08 Mar 2024 01:07:58 -0500
X-MC-Unique: f5jPDFYbNsa_J2vwLB-jmw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d8dbe37d56so1524203a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 22:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709878077; x=1710482877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/4Biu2R85f0cuL1kJQyJ2DRVnushj+5L95Ki/9bvU8=;
        b=CPf19RTBzaDvJb3GhDOHPGDm7mj9xC4hZrIx+ICR+pEHSvnzKJyZuwKMSjLkdkDK4S
         D0dtn20qfkjpVWb+uvq6Lbi0cfMdreO0MGqgBuyz5LpbPO6hcdZRSb5mcy3Rh25H8v8n
         YLJx58/ehem49Xz11LmfxFm0mmdPq0bLaMc0+ds6wVWIa39TFYOlzBuGvYCuOaN85x2M
         85DY2YSmq68UO/u6Du5SZwFSty8MEFf6/cKwk2AapbsWsBMahfstVbaIi/U3o3v4T91T
         KgLRl5nYIIf3CL4phuNuIU9j0hncjUgsYVBuBHoyufZfxAWoLyJN2QBf7VFXwkvn1STR
         Y/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxA2DOOQsLlLLxCbq9F9msvzMFtOLtmg0avKt1ElGdXJSmXgZdUMtiwbHVEj4QjrPJ/VplutuIwacCJFz5yaq8cwbMte+Bp6p3tBPe
X-Gm-Message-State: AOJu0YwbyE7wDN/2VTirsaDZYFvyRJy6HAUQ++uZ4t+1ofQhj6bwQeA7
	diMJpDTlMURX0WnNZQxu6R3VbQLBG241K9Jmo/7N05guj33bWe35Tt8JHHbQNQAypSp424Xtz5z
	MmeZjXLTTCuNTMliB/e6amJGt3QnrlDcik07pbyRr5gH/TdCPHmE5ZwM+GGPGRhrURa7GAUFio6
	PbHd7J9oQAfaLJ4Lp7/E/FCW8mi+xyI5y7WEcY
X-Received: by 2002:a05:6a20:a10c:b0:1a1:8312:6dfb with SMTP id q12-20020a056a20a10c00b001a183126dfbmr775285pzk.58.1709878077578;
        Thu, 07 Mar 2024 22:07:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaNNejLKzT4KKQINTYDqnElsjZzYqgFJT5Xyckons4B4ocKKV9tMkW7/CVWoPbzwV7uGWSuIfeeT4JqFDKqNs=
X-Received: by 2002:a05:6a20:a10c:b0:1a1:8312:6dfb with SMTP id
 q12-20020a056a20a10c00b001a183126dfbmr775276pzk.58.1709878077290; Thu, 07 Mar
 2024 22:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207054701.616094-1-lulu@redhat.com>
In-Reply-To: <20240207054701.616094-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Mar 2024 14:07:46 +0800
Message-ID: <CACGkMEtb941fJ481xtaGvjF10r_iq53FoTtmAr9jHwvqXssFrw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] vduse: Add support for reconnection
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, xieyongji@bytedance.com, linux-kernel@vger.kernel.org, 
	maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 1:47=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Here is the reconnect support in vduse,
>
> Kernel will allocate pages for reconnection.
> Userspace needs to use mmap to map the memory to userspace and use these =
pages to
> save the reconnect information.
>
> test passd in vduse+dpdk-testpmd
>
> change in V2
> 1. Address the comments from v1
> 2. Add the document for reconnect process
>
> change in V3
> 1. Move the vdpa_vq_state to the uAPI.  vduse will use this to synchroniz=
e the vq info between the kernel and userspace app.
> 2. Add a new ioctl VDUSE_DEV_GET_CONFIG. userspace app use this to get co=
nfig space
> 3. Rewrite the commit message.
> 4. Only save the address for the page address and remove the index.
> 5. remove the ioctl VDUSE_GET_RECONNECT_INFO, userspace app will use uAPI=
 VDUSE_RECONNCT_MMAP_SIZE to mmap
> 6. Rewrite the document for the reconnect process to make it clearer.
>
> change in v4
> 1. Change the number of map pages to VQ numbers. UserSpace APP can define=
 and maintain the structure for saving reconnection information in userspac=
e. The kernel will not maintain this information.

So this means the structure (e.g inflight descriptors) are application
specific, we can't do cross application reconnection?

Thanks

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
>


