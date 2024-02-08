Return-Path: <linux-kernel+bounces-57390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5949884D7DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5D41F22585
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEB518E25;
	Thu,  8 Feb 2024 02:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cSqV5VGu"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087271D527
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359703; cv=none; b=i3h6WEgG85qchkygE6jHuaJMzI3KjsBC/ISN7NUhGTFwYOpxP19tGjWTmh33TH+E4a4medqpi4/zOvfP32M+4CmTtpysasiGYHXbeGHDEOMj8UguRPgtEHuzLuutYXG/Pfk8ufFyMuE064LDTavebuNcuikL20yCbuHpTZ8QAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359703; c=relaxed/simple;
	bh=EkOqfampjeSKQg5Cr8kvbOMjAirzAY3ivCor7kCy+9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AE6nQlH4f5Y5bZEqXC8dB8mg7lexL/SPJxiI/wF09TPfAp5QFXb+WNiP12AvfEC4/M4UFbkVAFtcKyxDI78wDrtMpaJUIsptzvIFXaxokE7ViGPO4NBfVJjWvAtR8zre6rZhKPUb8RoiLP7XCbEoePtj7P+22xERMCh85oHZhpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cSqV5VGu; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9dec8d00-c01b-44fe-983a-ec2b83d71e2a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707359700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JcrtKKNrzp8Qp0fqpYyaI1RyGJgRqDnnLYhAFWHoxnw=;
	b=cSqV5VGuSF0ia9JzWNev68oQ36rGLC/zt3lp6piRGnu4bMViCrk5P9y+85jZ0slalDg6Mv
	O+vWNGeAQ9r4clnhO7Q+RkdRsUrYlwCzKtU3n+A4Qho7Gqs8hFRALgr+dPdDlEeL41xNbQ
	0kWe69ej4IETPXXtQwDoSWX+n78X/C8=
Date: Thu, 8 Feb 2024 10:34:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] mm/zswap: invalidate old entry when store fail or
 !zswap_enabled
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>, stable@vger.kernel.org,
 Chris Li <chrisl@kernel.org>
References: <20240207115406.3865746-1-chengming.zhou@linux.dev>
 <CAKEwX=NR+QN1P960_Qz_sHACoD8FK=Kb=LQw==JGR+9h73SENg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAKEwX=NR+QN1P960_Qz_sHACoD8FK=Kb=LQw==JGR+9h73SENg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/8 07:06, Nhat Pham wrote:
> On Wed, Feb 7, 2024 at 3:54 AM <chengming.zhou@linux.dev> wrote:
>>
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> We may encounter duplicate entry in the zswap_store():
>>
>> 1. swap slot that freed to per-cpu swap cache, doesn't invalidate
>>    the zswap entry, then got reused. This has been fixed.
>>
>> 2. !exclusive load mode, swapin folio will leave its zswap entry
>>    on the tree, then swapout again. This has been removed.
>>
>> 3. one folio can be dirtied again after zswap_store(), so need to
>>    zswap_store() again. This should be handled correctly.
>>
>> So we must invalidate the old duplicate entry before insert the
>> new one, which actually doesn't have to be done at the beginning
>> of zswap_store(). And this is a normal situation, we shouldn't
>> WARN_ON(1) in this case, so delete it. (The WARN_ON(1) seems want
>> to detect swap entry UAF problem? But not very necessary here.)
>>
>> The good point is that we don't need to lock tree twice in the
>> store success path.
>>
>> Note we still need to invalidate the old duplicate entry in the
>> store failure path, otherwise the new data in swapfile could be
>> overwrite by the old data in zswap pool when lru writeback.
>>
>> We have to do this even when !zswap_enabled since zswap can be
>> disabled anytime. If the folio store success before, then got
>> dirtied again but zswap disabled, we won't invalidate the old
>> duplicate entry in the zswap_store(). So later lru writeback
>> may overwrite the new data in swapfile.
>>
>> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
>> Cc: <stable@vger.kernel.org>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Acked-by: Yosry Ahmed <yosryahmed@google.com>
>> Acked-by: Chris Li <chrisl@kernel.org>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> 
> Sorry for being late to the party, and thanks for fixing this, Chengming!

Thanks for your review! :)

