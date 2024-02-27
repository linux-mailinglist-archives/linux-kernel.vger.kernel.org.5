Return-Path: <linux-kernel+bounces-82855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDC868AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17911F22512
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F1A56458;
	Tue, 27 Feb 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ex9/7jSK"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584B52F62
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021790; cv=none; b=fsbPPLUGho2vDhSLGx8dsSlHJVc7qPNKZLzCtORGLcx3IGuN9JZv1BuQL4PoA1LEFNQqoAk++NTAqxe4/9RtDlOUsvq+XHV1rn7bfwKddFLt+63BJkFPK5hbqEtyeJVvGQzdQjITBOyEhonFsPvpzTHCnS9wa13aubHrFPxPdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021790; c=relaxed/simple;
	bh=ogrQRebIGYX6RGNzEgtcWYlKlirZ+XllO53RH8xUWzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIdNgaqFZnRcvm/a/WNyIS+UuObgWcPgeLbx6SZ+CMne+bOP5GOiweabLFXNYcTiW/Cz489jPfzx/Q8sdfSG6hMttKr/IJjddM0AA0HpdoPIWW7ctKG9UDB/UnT9c0CdCyOQtIwGq7YjHUvQCs+MR1BgGV55xYLZaqWuvFMXPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ex9/7jSK; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b54646e3-44bd-4937-a2dd-4b88ca7ab672@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709021786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0Qi3G51CgJBKU5e5sRVWIuufbNQP1OF50PFsE9woxw=;
	b=Ex9/7jSKMxy7nBQFw++kFPkmcK3l5ScRjxGXhwzuTs8xJyY4+njmycdqyw6GvkiJuWjsi5
	y5SUGTA4r3NQheZPVx0Mj301JDa+Y/Z2Of/iw3XToN4l0B78UT8tSPGkBE87HKlPTsWTDq
	sZAejXynFE7uFoLwqybHWS37RR2EHCA=
Date: Tue, 27 Feb 2024 16:16:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/zsmalloc: don't need to save tag bit in handle
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
 nphamcs@gmail.com, yosryahmed@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
References: <20240227030045.3443702-1-chengming.zhou@linux.dev>
 <20240227075209.GA11972@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240227075209.GA11972@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/27 15:52, Sergey Senozhatsky wrote:
> On (24/02/27 03:00), chengming.zhou@linux.dev wrote:
>>
>> We only need to save the position (pfn + obj_idx) in the handle, don't
>> need to save tag bit in handle. So one more bit can be used as obj_idx.
> 
> [..]
> 
>> mm/zsmalloc: don't need to save tag bit in handle
> 
> Does this mean "don't need to reserve LSB for tag"?
The head of object still need to reverve LSB, to save (handle | OBJ_ALLOCATED_TAG),
only the handle doesn't need to reserve LSB, which save (pfn | obj_idx).

> We still save allocated tag in the handle, that's what
> 
> 	handle |= OBJ_ALLOCATED_TAG;

Yes, this result will be saved in the head of each allocated object.

> 
> does.
> 
>> Actually, the tag bit is only useful in zspage's memory space, to tell
>> if an object is allocated or not.
> 
> I'm not completely sure if I follow this sentence.

What I mean is that only the head of each allocated object need to reverve LSB,
which is used to check if allocated or not.

handle address -> handle (pfn + obj_idx) -> object: (handle | tag), real_object start

I'm not sure if this makes it clearer?

Thanks.

