Return-Path: <linux-kernel+bounces-123859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E35D890EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A815FB2320D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69FC1C2D;
	Fri, 29 Mar 2024 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFdSDuyM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6451A5F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671121; cv=none; b=FfRQsbUMsQSprKkaP21eDynjFgpYDwgJBbv0hIqpIMEKr7zUVwUroVBYTy2EG/L42ZB8JShMru27QL1aDD1QRwnpBzTiRiLSpNU8PwIHqtmiZR3KkJ75aSwC3FH5O+onux4lrAmG17bxT39fSvq1TjwFlojMbFfpZpht4gQHuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671121; c=relaxed/simple;
	bh=6wtHnx5aHAflr5DF9YkYkeu6eoyg/MQpUEZgak5DzX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcnxoS6GaITurdZlui8oT8a6M6RqvZxrlfVBIYTIbrnpVldjxgUXgMCyVJTwhrIWViuRMplFE/oXp6Pv3KiXO5gkYUzqEva+2WaxqJQZeT37TSAg8e5vfSwrPGM7Btfme7buQA9d3YHTciwmj7/6IHfHR+M560azRJ8b27hd7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFdSDuyM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711671118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehgSCj3GfjkXw0aHOEvtMuIGQ4Ldvig/G2OmaVA7+S0=;
	b=SFdSDuyM81PRDNm0wvzL5cc2/dHtfQa3Q+rXO7rGu1A/DHrSasSYhwArzNt5CSWoympwWI
	7ETGVaFBe93Lk3VNk4ODSV0DzRcOFCMG5zR8W8yUyJq3379VYPGjl5SFjnF7jjClcn0Xzw
	/A72wa0dw1U0UK9USstaNw0qAvtRENI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-3jGYByT2MzOhp1gl9WdmJQ-1; Thu,
 28 Mar 2024 20:11:55 -0400
X-MC-Unique: 3jGYByT2MzOhp1gl9WdmJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D490A3801F4C;
	Fri, 29 Mar 2024 00:11:54 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A32D40C6DAD;
	Fri, 29 Mar 2024 00:11:52 +0000 (UTC)
Date: Thu, 28 Mar 2024 19:11:30 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 3/9] selftests: block_seek_hole: add loop block driver tests
Message-ID: <xh2nqmndk4rfnvghhmv6xlueleb4mdfa6v5vvamnxfyxb3eomb@yz5u2nldqewf>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-4-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328203910.2370087-4-stefanha@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Thu, Mar 28, 2024 at 04:39:04PM -0400, Stefan Hajnoczi wrote:
> Run the tests with:
> 
>   $ make TARGETS=block_seek_hole -C tools/selftests run_tests
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/block_seek_hole/Makefile        |  17 +++
>  .../testing/selftests/block_seek_hole/config  |   1 +
>  .../selftests/block_seek_hole/map_holes.py    |  37 +++++++
>  .../testing/selftests/block_seek_hole/test.py | 103 ++++++++++++++++++
>  5 files changed, 159 insertions(+)
>  create mode 100644 tools/testing/selftests/block_seek_hole/Makefile
>  create mode 100644 tools/testing/selftests/block_seek_hole/config
>  create mode 100755 tools/testing/selftests/block_seek_hole/map_holes.py
>  create mode 100755 tools/testing/selftests/block_seek_hole/test.py
> 
> +++ b/tools/testing/selftests/block_seek_hole/test.py

> +
> +# Different data layouts to test
> +
> +def data_at_beginning_and_end(f):
> +    f.write(b'A' * 4 * KB)
> +    f.seek(256 * MB)
> +
> +    f.write(b'B' * 64 * KB)
> +
> +    f.seek(1024 * MB - KB)
> +    f.write(b'C' * KB)
> +
> +def holes_at_beginning_and_end(f):
> +    f.seek(128 * MB)
> +    f.write(b'A' * 4 * KB)
> +
> +    f.seek(512 * MB)
> +    f.write(b'B' * 64 * KB)
> +
> +    f.truncate(1024 * MB)
> +
> +def no_holes(f):
> +    # Just 1 MB so test file generation is quick
> +    mb = b'A' * MB
> +    f.write(mb)
> +
> +def empty_file(f):
> +    f.truncate(1024 * MB)

Is it also worth attempting to test a (necessarily sparse!) file
larger than 2GiB to prove that we are 64-bit clean, even on a 32-bit
system where lseek is different than lseek64?  (I honestly have no
idea if python always uses 64-bit seek even on 32-bit systems,
although I would be surprised if it were not)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


