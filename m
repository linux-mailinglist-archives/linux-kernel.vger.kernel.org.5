Return-Path: <linux-kernel+bounces-51224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3822C84880E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC521C21BEC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FBF5FDC8;
	Sat,  3 Feb 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Vk1L5/Vf"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057225FBB2
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706983049; cv=none; b=buzDiXoUP9pzo2jUr51AZT9vGs107fyAb2QuyRORpsvEeez+im/vR8xg/C7xLmawZmhbgPLymoMwX8/zLvBCDVve6BRH9GG6Rj7FVlwZNzb80SLPch6bXV4lrX2AnURgd45SXYs8pX7l3KMz6GMKOemcyrcGJ+JqeKkmWhW/m9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706983049; c=relaxed/simple;
	bh=/NQk2cDsc/ggDqxAIYb4Sdq12gy7QJZdwvsLLQDIuG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWRVnnVt5zAGbxHnudY5mKy50Q09OpPms9l+1qGb16IQEjc1OZq/otoUzgAdUaSo28udj1t5qG38SakQwaNjGSa/EQkBg2n/He54ScuQdwJQsrZ/8nCVGTw2dzrvr5uwTcEVX+4WdJ+qbxzVYZa+bWFtvY+Pqhc7oEplLvKXtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Vk1L5/Vf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 413HuClN016639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 12:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706982976; bh=ykOOFay+2IfEzshY6L1t7gF/goIrR1N822e2+ESCJlU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Vk1L5/VfsKskGJpf6kj1FqSI9spLbmpo0OMN1uZCsa+rUQuM5qtPiLL5y1W/fhAYb
	 cL45+7C3/Wgh0+dxd8RotJLxAIJFHDKvba4KAtEX92dq9iauIz06YXfMvET9IyUu9K
	 A3udZQcY3yEOdAHaa0EkgYWPMS9kDP3J6lLRiu7Bs8ooGv3TeuKzmp8yAL6uqpFxwJ
	 4uMfnpKu1mHh1UIuw85YTTQFGyevCVd94MkBio4d/45deq0m+e8Aet2M0RiSvjzVyu
	 Xy4OkJPUfrKx8QTGJ8Oj7rist3+Uye/a3AuJRQLeoMWFtnoAcQlxCIrJwUO3N66NaC
	 HjWRVEWLx0aTQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D733315C02FC; Sat,  3 Feb 2024 12:56:11 -0500 (EST)
Date: Sat, 3 Feb 2024 12:56:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        hch@infradead.org, djwong@kernel.org, willy@infradead.org,
        zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 01/26] ext4: refactor ext4_da_map_blocks()
Message-ID: <20240203175611.GD36616@mit.edu>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127015825.1608160-2-yi.zhang@huaweicloud.com>

On Sat, Jan 27, 2024 at 09:58:00AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Refactor and cleanup ext4_da_map_blocks(), reduce some unnecessary
> parameters and branches, no logic changes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.  I've taken the first six patches in this series
since they are clearly bug fixes / prepartory changes for the rest of
the series.  (There were one minor patch conflicts that I fixed up.)

    	     	    	     	   - Ted

