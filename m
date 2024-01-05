Return-Path: <linux-kernel+bounces-18367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4D9825C1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E951F244BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F922360B4;
	Fri,  5 Jan 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdIXVjlq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CEB360A8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704490035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvKoTY7AaklNgqFAKz7HE/SEnOyTG3mvRlAEYCQEh+w=;
	b=gdIXVjlqlNDYFMGmbccXVa6qDxRJxLQczrzueTli+nPako1Qw3SEYkm/VoGE3buJFbt2Lv
	gZtGByIjWiX4b+noD8MCY6K+JA9qkAllUQCTny5cvg8ozuIKKaQroDpIx96dNwZgbZLXFD
	PkjULTEFIDvkfjqJVFafXp1OWUdg6x0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-KlLuGbKbM9yD6Qvgmfd9VQ-1; Fri, 05 Jan 2024 16:27:10 -0500
X-MC-Unique: KlLuGbKbM9yD6Qvgmfd9VQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19578837184;
	Fri,  5 Jan 2024 21:27:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A668D1121306;
	Fri,  5 Jan 2024 21:27:09 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id 0137E28EBE7; Fri,  5 Jan 2024 16:27:08 -0500 (EST)
Date: Fri, 5 Jan 2024 16:27:08 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, houtao1@huawei.com
Subject: Re: [PATCH v2] virtiofs: use GFP_NOFS when enqueuing request through
 kworker
Message-ID: <ZZh0LKpkrVdoU0tH@redhat.com>
References: <20240105105305.4052672-1-houtao@huaweicloud.com>
 <ZZhjzwnQUEJhNJiq@redhat.com>
 <ZZhkrOdbau2O/B59@casper.infradead.org>
 <ZZhpjEwDwMS_mq-u@redhat.com>
 <ZZhtU0IxUycpLGJe@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZhtU0IxUycpLGJe@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Fri, Jan 05, 2024 at 08:57:55PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 05, 2024 at 03:41:48PM -0500, Vivek Goyal wrote:
> > On Fri, Jan 05, 2024 at 08:21:00PM +0000, Matthew Wilcox wrote:
> > > On Fri, Jan 05, 2024 at 03:17:19PM -0500, Vivek Goyal wrote:
> > > > On Fri, Jan 05, 2024 at 06:53:05PM +0800, Hou Tao wrote:
> > > > > From: Hou Tao <houtao1@huawei.com>
> > > > > 
> > > > > When invoking virtio_fs_enqueue_req() through kworker, both the
> > > > > allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
> > > > > Considering the size of both the sg array and the bounce buffer may be
> > > > > greater than PAGE_SIZE, use GFP_NOFS instead of GFP_ATOMIC to lower the
> > > > > possibility of memory allocation failure.
> > > > > 
> > > > 
> > > > What's the practical benefit of this patch. Looks like if memory
> > > > allocation fails, we keep retrying at interval of 1ms and don't
> > > > return error to user space.
> > > 
> > > You don't deplete the atomic reserves unnecessarily?
> > 
> > Sounds reasonable. 
> > 
> > With GFP_NOFS specificed, can we still get -ENOMEM? Or this will block
> > indefinitely till memory can be allocated. 
> 
> If you need the "loop indefinitely" behaviour, that's
> GFP_NOFS | __GFP_NOFAIL.  If you're actually doing something yourself
> which can free up memory, this is a bad choice.  If you're just sleeping
> and retrying, you might as well have the MM do that for you.

I probably don't want to wait indefinitely. There might be some cases
where I might want to return error to user space. For example, if
virtiofs device has been hot-unplugged, then there is no point in
waiting indefinitely for memory allocation. Even if memory was allocated,
soon we will return error to user space with -ENOTCONN. 

We are currently not doing that check after memory allocation failure but
we probably could as an optimization.

So this patch looks good to me as it is. Thanks Hou Tao.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek


