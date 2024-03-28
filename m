Return-Path: <linux-kernel+bounces-123769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F272890D82
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708FE1C2FEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B85813F45C;
	Thu, 28 Mar 2024 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXZUrSRm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E066813D526
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664381; cv=none; b=LsJ8c4AgSqhHHD8N5+bBQCi+B/TjIYoHSo6O8nOiAGoy+UNV7PjlXquzQfZnl+FOEc6B/akaTEHKE2MYH5BcKS9Dp9GqEL1wbvxAxGZ4vMo6IQS5sHpCQqy02+3zk8NDjzIpexDUxacMkg5zUvSPtrZ/l7Dnl/3KMD8rY5Y+Jy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664381; c=relaxed/simple;
	bh=KNmyW5fEKd4KjDtcb2BedrvwQ/K9KSHvnnjPqGPoltY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5qrijZCynxKoluOpaLj/8R0WvX58YHGVA0Bo5Dkqg5+0fhdTWgRMouAmkLeFiu+lb6LXkpZ4VtPok3PfVDEwYX5LssjVtUoS/wOUduEZcKATiOmbXjq6xz28/tEuldluu2AvhkC38m4bCiMYe0jxeVWNSzyXeZIrPB1mOYvjgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXZUrSRm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711664377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c0gVdAJady0w2m/mZdiSsjO56B184pXm5Ghe4hgiYIs=;
	b=iXZUrSRmzxh+Zpma4UND/6LJaLURiiQjJSvOtXo25ZLYK3GAN5DmbkgXXusODUxRuV7+0r
	uOzPaMLTVwZ2GJPZBYoQeWJQM3270ll0QUh04VUMEidPitZnyuLCEkxy/4OYMqPZGs0Gd8
	7QDN/TFOT/sVVmBUzb92FRSQ9OhjwBU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-Is6uAylFP6CykLsXkY2xAA-1; Thu,
 28 Mar 2024 18:19:34 -0400
X-MC-Unique: Is6uAylFP6CykLsXkY2xAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14395380213D;
	Thu, 28 Mar 2024 22:19:34 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 65AEC1C06690;
	Thu, 28 Mar 2024 22:19:31 +0000 (UTC)
Date: Thu, 28 Mar 2024 17:19:26 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 5/9] selftests: block_seek_hole: add dm-zero test
Message-ID: <sr42hsk5rqu5siso6xwjlu5akfegl6glco3ug6pleawszgtfcb@h5pca4b3yqot>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-6-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328203910.2370087-6-stefanha@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Thu, Mar 28, 2024 at 04:39:06PM -0400, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  .../selftests/block_seek_hole/Makefile        |  2 +-
>  .../testing/selftests/block_seek_hole/config  |  2 ++
>  .../selftests/block_seek_hole/dm_zero.sh      | 31 +++++++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/block_seek_hole/dm_zero.sh
> 

> +++ b/tools/testing/selftests/block_seek_hole/dm_zero.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# dm_zero.sh
> +#
> +# Test that dm-zero reports data because it does not have a custom
> +# SEEK_HOLE/SEEK_DATA implementation.

Why not?  Wouldn't it make more sense to have dm-zero report the
entire device as a hole (that is, an in-range SEEK_HOLE always returns
the same offset, while an in-range SEEK_DATA returns the device size)?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


