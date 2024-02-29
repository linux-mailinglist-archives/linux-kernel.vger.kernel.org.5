Return-Path: <linux-kernel+bounces-87134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F9086CFFC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62EE72893DB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193D4AECF;
	Thu, 29 Feb 2024 17:01:02 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940E2E3E1;
	Thu, 29 Feb 2024 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226062; cv=none; b=dzututtrhlKqC6ZMkiul4/GHu/kRqrFZGdPcN5b6DtHZGhVECvfHhWGHw0ytcjLV2YOrQWCi8VDPgYFq4BUMOYXjzUzDRy/4N7cVi2KlajPF8IaD22iepsrypZM9MP31WBuytbaUrmWn5RtteMkaaaQbpmh98HiB58pcXMvUApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226062; c=relaxed/simple;
	bh=AJlVspfSdCAd3r0V5g9qas0SihWHSfY4bK1XQbc9yqg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IUEXu8EkDEKRG1Wvia1tbhRzl7TMYJjzFrjcvDna58WzaAuZ0HW7NfcKMVx0Zf864JZRLuUJefkjXV/pgV8yW2LTvwCCD3TucGIJihz8wDK2l/gfua2fP/mmFRLqu+Qe12NaYJuHMbuCM3/UEGs6mUEwZS43GbWaqFbeQaT8Elk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 86EC040B02; Thu, 29 Feb 2024 09:00:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 8634E40AAD;
	Thu, 29 Feb 2024 09:00:58 -0800 (PST)
Date: Thu, 29 Feb 2024 09:00:58 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>
cc: Eric Dumazet <edumazet@google.com>, 
    Huang Shijie <shijie@os.amperecomputing.com>, kuba@kernel.org, 
    patches@amperecomputing.com, davem@davemloft.net, horms@kernel.org, 
    ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
    aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
    netdev@vger.kernel.org, cl@os.amperecomputing.com
Subject: Re: [PATCH v2] net: skbuff: set FLAG_SKB_NO_MERGE for
 skbuff_fclone_cache
In-Reply-To: <018b5652-8006-471d-94d0-d230e4aeef6d@amperemail.onmicrosoft.com>
Message-ID: <b7825865-c368-1b72-3751-f1928443db32@linux.com>
References: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com> <20240227062833.7404-1-shijie@os.amperecomputing.com> <CANn89iL2a2534d8QU9Xt6Gjm8M1+wWH03+YPdjSPQCq_Q4ZGxw@mail.gmail.com>
 <018b5652-8006-471d-94d0-d230e4aeef6d@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 28 Feb 2024, Shijie Huang wrote:

>> 
>> Using SLAB_NO_MERGE does not help, I am still seeing wrong allocations
>> on a dual socket
>> host with plenty of available memory.
>> (either sk_buff or skb->head being allocated on the other node).
>
> Do you mean you still can see the wrong fclone after using SLAB_NO_MERGE?
>
> If so, I guess there is bug in the slub.

Mergin has nothing to do with memory locality.

>> fclones might be allocated from a cpu running on node A, and freed
>> from a cpu running on node B.
>> Maybe SLUB is not properly handling this case ?
>
> Maybe.

Basic functionality is broken??? Really?

>> I think we need help from mm/slub experts, instead of trying to 'fix'
>> networking stacks.
>
> @Christopher
>
> Any idea about this?


If you want to force a local allocation then use GFP_THISNODE as a flag.

If you do not specify a node or GFP_THISNODE then the slub allocator will 
opportunistically allocate sporadically from other nodes to avoid 
fragmentation of slabs. The page allocator also will sporadically go off 
node in order to avoid reclaim. The page allocator may go off node 
extensively if there is a imbalance of allocation between node. The page 
allocator has knobs to tune off node vs reclaim options. Doing more 
reclaim will slow things down but give you local data.


