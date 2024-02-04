Return-Path: <linux-kernel+bounces-51657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056F848DFD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA4D1F23666
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6BB224DB;
	Sun,  4 Feb 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M4Um41+t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281EC224CE
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707052160; cv=none; b=fUqciupeUg53tg6KV/NPNz20+0093gTdBO69ZxlI3IAcFa2IkdddCZA4yqHLhwnWOpDNuEmG5GXuBRsetICW5ToN6i2eYkSd5sI3DqzfTBLkEZS//kVRVnQw7d7GVzrmwrm6+xPmOph2/4aQYPEQCFSNo+hCq6yed7eAgt+ZSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707052160; c=relaxed/simple;
	bh=wS5G8p7qKOmOMkyKYFO2M4ZLkfVca+B/dMqr4h+AJCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqDQ4HQBvWejouvHpb5dCMOaEmctNHCrd9XFd3iGOrB9McjMoznI8VpcnaZU8pmenaulBNlKVUvP2ffnvVvHKfdi/IMuuxnWgX9W+zDLFULVKWlWC/VPw6F9iPfEdhoX96SGV00JQGv6lJKxV0VA+NvcD9HSze75vqOJnpc2oPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M4Um41+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F4EC433F1;
	Sun,  4 Feb 2024 13:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707052159;
	bh=wS5G8p7qKOmOMkyKYFO2M4ZLkfVca+B/dMqr4h+AJCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4Um41+tWedkPEUIYTt1vo58ax57nGthjHG4mdjIl0VWInh0tJS8T2kBHdy5nHx/b
	 H2tJkjwtUEVNmr6lpgWOO4n4y61V1EcXjLPWDJqE6bLBHP6dC79ENJj3zLzDRnAo96
	 SE2mueivUyNojMY4BP++VzsONomZLK84UtyCnZDg=
Date: Sun, 4 Feb 2024 05:09:18 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Fangzheng Zhang <fangzheng.zhang1003@gmail.com>,
	Yuming Han <yuming.han@unisoc.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH] mm/slab: Add slabreclaim flag to slabinfo
Message-ID: <2024020441-version-chihuahua-1067@gregkh>
References: <20240131094442.28834-1-fangzheng.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131094442.28834-1-fangzheng.zhang@unisoc.com>

On Wed, Jan 31, 2024 at 05:44:42PM +0800, Fangzheng Zhang wrote:
> In order to enhance slab debugging, we add slabreclaim flag to
> slabinfo. Slab type is also an important analysis point in slabinfo
> for per slab, when various problems such as memory leaks or memory
> statistics occur.
> 
> Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
> ---
>  mm/slab_common.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 238293b1dbe1..aeeb2bfe6dda 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1038,7 +1038,7 @@ static void print_slabinfo_header(struct seq_file *m)
>  	seq_puts(m, "slabinfo - version: 2.1\n");
>  	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
>  	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
> -	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
> +	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail> <slabreclaim>");

Doesn't this change the slabinfo version number above?  Where is this
change documented so that userspace knows about it?

thanks,

greg k-h

