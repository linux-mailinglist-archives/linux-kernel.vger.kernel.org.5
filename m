Return-Path: <linux-kernel+bounces-134936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF55089B90D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60B1283EB1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDAF31A66;
	Mon,  8 Apr 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euL7Hdq7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA72BAF6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562361; cv=none; b=DJUF+7rGwxSisTQfPrjnUc3zpsJjBUQJ603Q8m21tiu/vHejFZg0fll+mfHgqMtAh+sCJFV6PZNpQYZwBvF+BCB9Bhq77apN/MMU+2ESEJDz3c5lKymWaSBuynOGkHXc11KJW1SzbVJtswUk5JON6x7iz1+qqU1B5nT0u0EAICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562361; c=relaxed/simple;
	bh=VszgEr7MX9Bl2vPJIeDpBUVK8TMsj9COmPwntop6Txk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I25h24fpbOUX4tdRr0OmN0iqSqN1Lc3+RXVdJAh2QGulrSLJcIzl+FQud+cO1s2v9tB0DiBLFjmrT5+I8TzkB/8ERs6jHxHAP1YV6ADR0+qEvUrpGbzNAU9sLrjFJUbCEZK/MJMuX6HCDOwUDHa4h1+WUVgFJqu71nWcLkbdSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euL7Hdq7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712562359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AHCuV/Z0bFdLFjkd4awKH8RSgNzsfw23wSDckJ9Dcr0=;
	b=euL7Hdq7GvUtkj8veJZEBK6X8Fo87chEIc6BLAYVwqmEAQqVWSIlHvhpyI64oRl4jeCDzC
	jKxWI3xmaUpqCo/QJbUuqkdB4ltIJqYE83LX21kI5cLoIokJ1JxXMx2flaN1w34+zCq+Cv
	HsFHVdyHI8hspsYSwS1PQpMhzABgRx0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-wUw8qcjePMWKuWpazM5eRA-1; Mon, 08 Apr 2024 03:45:57 -0400
X-MC-Unique: wUw8qcjePMWKuWpazM5eRA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343c6bb1f21so2501030f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562356; x=1713167156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHCuV/Z0bFdLFjkd4awKH8RSgNzsfw23wSDckJ9Dcr0=;
        b=C6Y4p63mxLJhp/d6EEX/WVXSYrFMoMSOO2FgUvRJVkWkegTJKxgtFj9IekWTsRQRiv
         VLkvF8iGgBAvEVPPMTFs5caGwsQlTfn59sJ9tj6eE5qRTl2+33oCJqhyRytVnPCS55T0
         yQtdG4jtyuk8vHXSCWascF4rDtQ2BBpKYz4Z5TR2E5AyLE0bdUEoak7VOIzYG8JHwcTq
         3tI5l5MATv18/+1v+oZC5T/I6D99noxpGfWKj+kqRbWTA+4Fzg4OmvbuaIplJirXN/5M
         FTV7YnTRoiLmtMFBSj+eP+py4Gf9+8mHDMdHmLVWcqULcyEDEFPAVfksHM5RkPTEK2j0
         GqNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQq3HYGpSt9mpzmr+kvusYPdA7QwNsdSfeXMvFx7GZLzfnYLiwnXF9N55d2ZZuBYDxvl2DXFXBmolfimeaomtBPOUYysYaKjXawaKb
X-Gm-Message-State: AOJu0YyscEd4Er5IRf0kbysqPgM7AxOQ7sEwHhEIq8gnY2BOwB5i/ZoJ
	+VH/4lL5DqTNwwer/zD/z3FjtabCrmI4S2ZId39ZZ/Ue8i0R0JiYcRURaTzHwOUJisPBX8mxvkW
	QWjYZL8ih2R/uVxhPgwhiOiCR6WclyU/tpMyKlRn8AU3DLZv60ksad2RQ2RAdg5UlgeH5OQ==
X-Received: by 2002:a05:6000:1817:b0:343:9a9e:2ca5 with SMTP id m23-20020a056000181700b003439a9e2ca5mr6186000wrh.31.1712562356151;
        Mon, 08 Apr 2024 00:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELDNHAY++9+xbR5gGN9G3+TeVZ9hnW4qxcSDfW5yXkfKb3mXnJpHEKB2eSV6DN9J3ftBWvlg==
X-Received: by 2002:a05:6000:1817:b0:343:9a9e:2ca5 with SMTP id m23-20020a056000181700b003439a9e2ca5mr6185983wrh.31.1712562355622;
        Mon, 08 Apr 2024 00:45:55 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id q1-20020adffec1000000b00345aa92fa1dsm2219980wrs.117.2024.04.08.00.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:45:55 -0700 (PDT)
Date: Mon, 8 Apr 2024 03:45:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Matthew Wilcox <willy@infradead.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: Re: [PATCH v2 0/6] virtiofs: fix the warning for ITER_KVEC dio
Message-ID: <20240408034514-mutt-send-email-mst@kernel.org>
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228144126.2864064-1-houtao@huaweicloud.com>

On Wed, Feb 28, 2024 at 10:41:20PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set aims to fix the warning related to an abnormal size
> parameter of kmalloc() in virtiofs. The warning occurred when attempting
> to insert a 10MB sized kernel module kept in a virtiofs with cache
> disabled. As analyzed in patch #1, the root cause is that the length of
> the read buffer is no limited, and the read buffer is passed directly to
> virtiofs through out_args[0].value. Therefore patch #1 limits the
> length of the read buffer passed to virtiofs by using max_pages. However
> it is not enough, because now the maximal value of max_pages is 256.
> Consequently, when reading a 10MB-sized kernel module, the length of the
> bounce buffer in virtiofs will be 40 + (256 * 4096), and kmalloc will
> try to allocate 2MB from memory subsystem. The request for 2MB of
> physically contiguous memory significantly stress the memory subsystem
> and may fail indefinitely on hosts with fragmented memory. To address
> this, patch #2~#5 use scattered pages in a bio_vec to replace the
> kmalloc-allocated bounce buffer when the length of the bounce buffer for
> KVEC_ITER dio is larger than PAGE_SIZE. The final issue with the
> allocation of the bounce buffer and sg array in virtiofs is that
> GFP_ATOMIC is used even when the allocation occurs in a kworker context.
> Therefore the last patch uses GFP_NOFS for the allocation of both sg
> array and bounce buffer when initiated by the kworker. For more details,
> please check the individual patches.
> 
> As usual, comments are always welcome.
> 
> Change Log:

Bernd should I just merge the patchset as is?
It seems to fix a real problem and no one has the
time to work on a better fix .... WDYT?


> v2:
>   * limit the length of ITER_KVEC dio by max_pages instead of the
>     newly-introduced max_nopage_rw. Using max_pages make the ITER_KVEC
>     dio being consistent with other rw operations.
>   * replace kmalloc-allocated bounce buffer by using a bounce buffer
>     backed by scattered pages when the length of the bounce buffer for
>     KVEC_ITER dio is larger than PAG_SIZE, so even on hosts with
>     fragmented memory, the KVEC_ITER dio can be handled normally by
>     virtiofs. (Bernd Schubert)
>   * merge the GFP_NOFS patch [1] into this patch-set and use
>     memalloc_nofs_{save|restore}+GFP_KERNEL instead of GFP_NOFS
>     (Benjamin Coddington)
> 
> v1: https://lore.kernel.org/linux-fsdevel/20240103105929.1902658-1-houtao@huaweicloud.com/
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20240105105305.4052672-1-houtao@huaweicloud.com/
> 
> Hou Tao (6):
>   fuse: limit the length of ITER_KVEC dio by max_pages
>   virtiofs: move alloc/free of argbuf into separated helpers
>   virtiofs: factor out more common methods for argbuf
>   virtiofs: support bounce buffer backed by scattered pages
>   virtiofs: use scattered bounce buffer for ITER_KVEC dio
>   virtiofs: use GFP_NOFS when enqueuing request through kworker
> 
>  fs/fuse/file.c      |  12 +-
>  fs/fuse/virtio_fs.c | 336 +++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 296 insertions(+), 52 deletions(-)
> 
> -- 
> 2.29.2


