Return-Path: <linux-kernel+bounces-87221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6F886D147
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1F7283FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B816178268;
	Thu, 29 Feb 2024 17:57:47 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E6757E0;
	Thu, 29 Feb 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229467; cv=none; b=lwONcK1eCgHodv1J6wt1gVXiKW/SRozQR7KT7wqMXIa75R6MynfrRePTS7KWMRXU9jrC64LaJPnSV+BR7+sCT8Vt3kY0EOhxUhngonBBgJqrLNHU1LanUyfLCHePKvwwH3K9RltqjpHnGmXTtW0xD7AKhIowEHgoxwoJzzYHRYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229467; c=relaxed/simple;
	bh=ble/WW7S/LMVFJMHqZsBCnHfwZb+W0WPZfC/b4f77tE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=spuh/yuTLZQx3QbW7kJR8a+Hh6zOgJ8IHEk/xwBv9EoUpTDzJq7BZXDVrdj/o9Juv0jEN7yMIfLEIXaP4Cu8ZjXkG/of16NF53S+qRp30KEe7uHxBkp3c69klisL1U7wRKZ8uJRZHOmkDYku2o5COjCus0ThGQoTCPkbAvPt8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 03BAD40AB2; Thu, 29 Feb 2024 09:57:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 030E040AAD;
	Thu, 29 Feb 2024 09:57:44 -0800 (PST)
Date: Thu, 29 Feb 2024 09:57:43 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Eric Dumazet <edumazet@google.com>
cc: Shijie Huang <shijie@amperemail.onmicrosoft.com>, 
    Huang Shijie <shijie@os.amperecomputing.com>, kuba@kernel.org, 
    patches@amperecomputing.com, davem@davemloft.net, horms@kernel.org, 
    ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
    aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
    netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: skbuff: set FLAG_SKB_NO_MERGE for
 skbuff_fclone_cache
In-Reply-To: <CANn89iJpZ6udACMC9EF=zgYJU5rqLFiTuYJRf1UNA3UKu7CxJg@mail.gmail.com>
Message-ID: <1e72ab23-8161-091e-dc9e-9ecfe84a02df@linux.com>
References: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com> <20240227062833.7404-1-shijie@os.amperecomputing.com> <CANn89iL2a2534d8QU9Xt6Gjm8M1+wWH03+YPdjSPQCq_Q4ZGxw@mail.gmail.com> <018b5652-8006-471d-94d0-d230e4aeef6d@amperemail.onmicrosoft.com>
 <b7825865-c368-1b72-3751-f1928443db32@linux.com> <CANn89iJpZ6udACMC9EF=zgYJU5rqLFiTuYJRf1UNA3UKu7CxJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 29 Feb 2024, Eric Dumazet wrote:

>> If you do not specify a node or GFP_THISNODE then the slub allocator will
>> opportunistically allocate sporadically from other nodes to avoid
>> fragmentation of slabs. The page allocator also will sporadically go off
>> node in order to avoid reclaim. The page allocator may go off node
>> extensively if there is a imbalance of allocation between node. The page
>> allocator has knobs to tune off node vs reclaim options. Doing more
>> reclaim will slow things down but give you local data.
>
> Maybe, maybe not.
>
> Going back to CONFIG_SLAB=y removes all mismatches, without having to
> use GFP_THISNODE at all,
> on hosts with plenty of available memory on all nodes.


Slab uses GFPTHISNODE by default and does not respect the memory policies 
etc set for pages. As such it will causes additional overhead through 
reclaim passses etc and memory policies will not be applied on a per page 
level (as specd) but in its own layer on a per object basis. It causes 
additional fragmentation.

> I think that is some kind of evidence that something is broken in SLUB land.

That is one of the reasons that SLAB was removed.

Slub defragmentation can be disabled by either GFP_THISNODE or tuning the 
remote_claim knob in /sys/kernel/slab/<slabname>

