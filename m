Return-Path: <linux-kernel+bounces-51225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A0848811
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1E6B238EB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DA45FEFF;
	Sat,  3 Feb 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XUp703cP"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9F5FDA6
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706983050; cv=none; b=ESehIv8S6m54nWGb+gi+t7cE6iSOjth7oEnD3Z2lNAaZoCUAPZSYKY5piJMjcXtT6p2y+v0oMiQwZI+BJhKPx9D23iJzFDwSOSrCiikYkLxCRxPPkq6241oT9tkeSh97GhSyZs+A50oNokP18/AwHScAFqg0fSPFSmjwBIXd02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706983050; c=relaxed/simple;
	bh=jxikJnui4qVASYJwKxqS8vDGGr7p1uCmUe68FiuwKdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX1CUx9CwsKzmgUEQ7s9AdRDRCmFhyg7TNUpuLFIPuPmwBTEevB+xpuENRrnJe51ro/AWj2MJbH42Knmf9co95UAayk7E2ARHFFuZhYE1N9ZIvZ1EfflG20DwDEdyCBntbUrOjDQQ798xK1YznGvMwmsrSpDLENCmKj6kJC0RGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XUp703cP; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 413HuPjn016713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 12:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706982989; bh=PIvmql/b6IcoymoMAhVlPKQhnLvNYMHHW5GYReOxLtU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=XUp703cPR/HSw0a8/8lfRjHaqFn9t0WI+Nv1Lqu4oCneg0qSBOCIaRVhWoBMvFihE
	 hubkxs4n3OSP8nyltNh3CnWnX+6rChgqSOeRDOQL6OkR+6FFuwHaLWsjG/44cG6sm+
	 BVNP9XtIwPisO6tQX6KR/gO7X779mL6VQ8DS8niiCm0egq86yc/jZChwjP/+5MO3S/
	 /k9cpxNbznjwQJEtH/+wy0KKikGmGzDYLeYQMQNY/HKasecyoCxovE06wz2errblKo
	 gDRBkBZlbdz3eTt8edpqxIoUUG6BiWy/pl/HalkbSdkd9nm7trgO65IOjeer9fq/IN
	 F2mZwWFUw1OEw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E425915C02FC; Sat,  3 Feb 2024 12:56:25 -0500 (EST)
Date: Sat, 3 Feb 2024 12:56:25 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        hch@infradead.org, djwong@kernel.org, willy@infradead.org,
        zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 02/26] ext4: convert to exclusive lock while inserting
 delalloc extents
Message-ID: <20240203175625.GE36616@mit.edu>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127015825.1608160-3-yi.zhang@huaweicloud.com>

On Sat, Jan 27, 2024 at 09:58:01AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> ext4_da_map_blocks() only hold i_data_sem in shared mode and i_rwsem
> when inserting delalloc extents, it could be raced by another querying
> path of ext4_map_blocks() without i_rwsem, .e.g buffered read path.
> Suppose we buffered read a file containing just a hole, and without any
> cached extents tree, then it is raced by another delayed buffered write
> to the same area or the near area belongs to the same hole, and the new
> delalloc extent could be overwritten to a hole extent.
> 
>  pread()                           pwrite()
>   filemap_read_folio()
>    ext4_mpage_readpages()
>     ext4_map_blocks()
>      down_read(i_data_sem)
>      ext4_ext_determine_hole()
>      //find hole
>      ext4_ext_put_gap_in_cache()
>       ext4_es_find_extent_range()
>       //no delalloc extent
>                                     ext4_da_map_blocks()
>                                      down_read(i_data_sem)
>                                      ext4_insert_delayed_block()
>                                      //insert delalloc extent
>       ext4_es_insert_extent()
>       //overwrite delalloc extent to hole
> 
> This race could lead to inconsistent delalloc extents tree and
> incorrect reserved space counter. Fix this by converting to hold
> i_data_sem in exclusive mode when adding a new delalloc extent in
> ext4_da_map_blocks().
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted

