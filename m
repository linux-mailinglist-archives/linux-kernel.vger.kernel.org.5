Return-Path: <linux-kernel+bounces-38340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8750083BE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6951F246C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AF61CA93;
	Thu, 25 Jan 2024 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUxdD07i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6531BDE1;
	Thu, 25 Jan 2024 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176472; cv=none; b=cEw/DBVkWkgx8Th9xZ00pBit9//7vWrhGjXE6C/x+WyuyMlJhnpp0nk1zxYsubHjkebmrHtyoFWLgQTr0S0Qvpxd4xIePdencVcL/PVQrKrjgV9iPSsfKOxUtBc2OE/2Ohl7k08gz6LTn6Ylrd0N2qLE0zPl28fhW5qw21N4Zjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176472; c=relaxed/simple;
	bh=8sV11cCodbI7pM5kIxaj6DbkQcEBI2nlp/GIYjsNtag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcgI8ivt5hMF1r5INhPkvT8/SUHtO48VfNMbxObystU3uxyLKaDeRd9xiSmATFPYMRZoM8RbcKNXtQGZA1jiZ90XVekEF7PKgbC+tU8KMGEDycS1RnB5INSq+X99yobt3/mUHO8VK3dyVey2A4pDARCoLn7bwAHHVuakWYHSBNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUxdD07i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5470EC433F1;
	Thu, 25 Jan 2024 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706176472;
	bh=8sV11cCodbI7pM5kIxaj6DbkQcEBI2nlp/GIYjsNtag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SUxdD07iIGwk8Aw2N8NsyEgJXNF4/m0+uvuV4Q1uBshNvQWo6CP2idSHtrGOp9ug7
	 Bu7jBFIBRJg6T6EBD8PXUKZ7nn8n4h3YlRN7Z0T01UfqHJq2pQydq81wfWDZlvU5B5
	 Gvi+0KFyyvORYL0jsEVQpMQRv3dfG5bW4kx7xbJ8IuxWbj/ir18e5g2cQZpnAsekxd
	 joaKG3MEE7EEbS6g2dQLmo4FjmUGcThNG+FkcTd5hmMcZyz+yQZULbj1JyDD6bfHec
	 VB7MqNsUIyMeKm2b+Ha+MCZyMks9ECvEx8jT2cHdsBEIAKHfzl2/O67RbbyNH9sT5k
	 KmyHvMFGMmMWA==
Message-ID: <15d07953-aeff-460e-81fe-ea7fc2f6145d@kernel.org>
Date: Thu, 25 Jan 2024 18:54:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/1] block: introduce content activity based ioprio
Content-Language: en-US
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Yu Zhao <yuzhao@google.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-mm@kvack.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, steve.kang@unisoc.com
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
 <6b2d5694-f802-43a4-a0fd-1c8e34f8e69a@kernel.org>
 <CAGWkznHK5UPajY2PG24Jm7+A0c9q+tyQzrPdd=n3tp0dgX+T0w@mail.gmail.com>
 <95082224-a61d-4f4b-bc96-1beea8aa93a9@kernel.org>
 <CAGWkznGe+37K7_E34G_MZQXNxoLuM3E0mY=BZCGpyiq+TB_PoA@mail.gmail.com>
 <CAGWkznGJejDMZsryPpS-11mb50wMhhQe-=sNoV4_iO5ogVLtLQ@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAGWkznGJejDMZsryPpS-11mb50wMhhQe-=sNoV4_iO5ogVLtLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 18:37, Zhaoyang Huang wrote:
> Actually, the activity information comes from page's history (recorded
> at page cache's slot) instead of user space in step(1) and can be
> associate with bio in step(2) or iterate the bio in step(3)
> page fault(or vfs)(1)
> |
> alloc_pages
> |
> add_page_to_pagecache(get the page's activity information)
> |
> fs_readpage
> |
> bio_add_page(2)
> |

set your prio here. No change to the block layer needed. That is FS land.

> submit_bio(3)


-- 
Damien Le Moal
Western Digital Research


