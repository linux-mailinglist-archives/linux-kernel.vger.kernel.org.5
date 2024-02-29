Return-Path: <linux-kernel+bounces-87129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638DF86CFED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C075283779
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B7D70AE3;
	Thu, 29 Feb 2024 16:56:29 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8483383B0;
	Thu, 29 Feb 2024 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225789; cv=none; b=OtpLNzsTta/xkMpFQfo1nk7wB3iKNGNoKk87oHFJI4a1FfgGvPDi++n0v3I7AF0GSZcL+hZQrM4rSmZ6KQ1zMkSdsWaD0IGasE/XUZvzn1Fr/SRJ2p9TFY405uThu3VwDvrpB+sefclUGnOGBo0OytjrBz1wDWOHOX2VbqiQi7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225789; c=relaxed/simple;
	bh=GrJqqBgEDW//Vb6mDW03vv0mmHF3ihM5IqxCUUk5g/s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WTXFVCfl57zcoGkVIDbJ6WvD8yKj8EvMoa0Z/anZapTeRw5pqZv5vZ5LMK3boigYIWs2uRWeB/H89TLvHk8WCQDL1CHDMBjb6hqXftp7YJYM5Ne7iP7+6ttNks2Bm1cN7tov6XJPsggDDYKrPi//ZeZ84SGjk3gHvutphhOWn9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id ACB1040AB2; Thu, 29 Feb 2024 08:56:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id ABEA040AAD;
	Thu, 29 Feb 2024 08:56:20 -0800 (PST)
Date: Thu, 29 Feb 2024 08:56:20 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
cc: kuba@kernel.org, patches@amperecomputing.com, davem@davemloft.net, 
    horms@kernel.org, edumazet@google.com, ast@kernel.org, dhowells@redhat.com, 
    linyunsheng@huawei.com, aleksander.lobakin@intel.com, 
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
    cl@os.amperecomputing.com
Subject: Re: [PATCH v2] net: skbuff: set FLAG_SKB_NO_MERGE for
 skbuff_fclone_cache
In-Reply-To: <20240227062833.7404-1-shijie@os.amperecomputing.com>
Message-ID: <afcf367f-5b33-5249-ad85-2addede18dc5@linux.com>
References: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com> <20240227062833.7404-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 27 Feb 2024, Huang Shijie wrote:

> Since we do not set FLAG_SKB_NO_MERGE for skbuff_fclone_cache,
> the current skbuff_fclone_cache maybe not really allocated, it maybe
> used an exist old kmem_cache. In NUMA, the fclone allocated by
> alloc_skb_fclone() maybe in remote node.

This is not the right approach. If you want to force a local allocation 
you need to use GFP_THISNODE. Merging has nothing to do with locality.


