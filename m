Return-Path: <linux-kernel+bounces-158628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6C58B2339
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7261F22A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2364149E07;
	Thu, 25 Apr 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXzcqdVf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3EF1494D2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053349; cv=none; b=D/odUhHV1yrKQrarm9uBLa+1l38oWK83S4F/0sLqr4wI2MevmjXs3EEoTZIEvPm2fHbOiZLXGJj+m984Ymv1QTNTEEeXFqZ3BKW8Rw6PQjikxcQF94ukJjp9czxkX6cw58exTA4fXANLMYq+8ZRz2LWJsIQLklT5G7RqirLuokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053349; c=relaxed/simple;
	bh=0gOGWX754Dme5o75hzHeRnF10h1sIbteWYGixJF88Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQTrudu7074kz+GfpLgt/cAeAmJuFmEOtXcj9NiUTxXbCCbeeWRhU3FPwZk8Stdjq4SBLNKsoHwyTkcmd4JgHeL0nn1vPUiPTr6UmnMEXoAf5FhiPDz5Fjlkk+hUyZPGF+xK0BwBgL3gRL13lQIiEdj7/73mpssrva3EW/skq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXzcqdVf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714053346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SIrQNZSOyGumQ4W9WyC3jnI0g+lXhd8s1D7EZMPy8ok=;
	b=NXzcqdVffiHt64vMyfUbOK2s1qDvJuvE7RWuGPRinoCD05KNWh2NcIXehdc8b9hsXH5fKn
	BqC/JbQWn3g18clYILOR8/aHBQgxjNfm7zXcOGTSJKhLkBU4POABhTFrRMlJUzemIJ4zFC
	yMbEVWs+yVSCGPY5ZhHmR8txU1Pp9UY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-Aqd1LsKTOJ6ER0lihQRU_Q-1; Thu, 25 Apr 2024 09:55:40 -0400
X-MC-Unique: Aqd1LsKTOJ6ER0lihQRU_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8D481827141;
	Thu, 25 Apr 2024 13:55:38 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7127DEC686;
	Thu, 25 Apr 2024 13:55:38 +0000 (UTC)
Date: Thu, 25 Apr 2024 09:57:54 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, djwong@kernel.org,
	chandan.babu@oracle.com, syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] KASAN: slab-out-of-bounds Read in xlog_cksum
Message-ID: <ZiphYrREkQvxkE-U@bfoster>
References: <CAEkJfYO++C-pxyqzfoXFKEvmMQEnrgkQ2QcG6radAWJMqdXQCQ@mail.gmail.com>
 <ZipWt03PhXs2Yc84@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZipWt03PhXs2Yc84@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Thu, Apr 25, 2024 at 06:12:23AM -0700, Christoph Hellwig wrote:
> This triggers the workaround for really old xfsprogs putting in a
> bogus h_size:
> 
> [   12.101992] XFS (loop0): invalid iclog size (0 bytes), using lsunit (65536 bytes)
> 
> but then calculates the log recovery buffer size based on the actual
> on-disk h_size value.  The patch below open codes xlog_logrec_hblks and
> fixes this particular reproducer.  But I wonder if we should limit the
> workaround.  Brian, you don't happpen to remember how old xfsprogs had
> to be to require your workaround (commit a70f9fe52daa8)?
> 

No, but a little digging turns up xfsprogs commit 20fbd4593ff2 ("libxfs:
format the log with valid log record headers"), which I think is what
you're looking for..? That went in around v4.5 or so, so I suppose
anything earlier than that is affected.

Brian

> diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> index b445e8ce4a7d21..b3ea546508dc93 100644
> --- a/fs/xfs/xfs_log_recover.c
> +++ b/fs/xfs/xfs_log_recover.c
> @@ -2999,7 +2999,7 @@ xlog_do_recovery_pass(
>  	int			error = 0, h_size, h_len;
>  	int			error2 = 0;
>  	int			bblks, split_bblks;
> -	int			hblks, split_hblks, wrapped_hblks;
> +	int			hblks = 1, split_hblks, wrapped_hblks;
>  	int			i;
>  	struct hlist_head	rhash[XLOG_RHASH_SIZE];
>  	LIST_HEAD		(buffer_list);
> @@ -3055,14 +3055,16 @@ xlog_do_recovery_pass(
>  		if (error)
>  			goto bread_err1;
>  
> -		hblks = xlog_logrec_hblks(log, rhead);
> -		if (hblks != 1) {
> -			kvfree(hbp);
> -			hbp = xlog_alloc_buffer(log, hblks);
> +		if ((rhead->h_version & cpu_to_be32(XLOG_VERSION_2)) &&
> +		    h_size > XLOG_HEADER_CYCLE_SIZE) {
> +			hblks = DIV_ROUND_UP(h_size, XLOG_HEADER_CYCLE_SIZE);
> +			if (hblks > 1) {
> +				kvfree(hbp);
> +				hbp = xlog_alloc_buffer(log, hblks);
> +			}
>  		}
>  	} else {
>  		ASSERT(log->l_sectBBsize == 1);
> -		hblks = 1;
>  		hbp = xlog_alloc_buffer(log, 1);
>  		h_size = XLOG_BIG_RECORD_BSIZE;
>  	}
> 


