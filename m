Return-Path: <linux-kernel+bounces-57398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5930284D7EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDAC1B23084
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCF31BDE2;
	Thu,  8 Feb 2024 02:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="drC4G/dn"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EEA1D532
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360148; cv=none; b=ZM/91Phsv8d8ZsZ5rXLeZTbfYGrUTZxRoRETx5F1Ri4llXP5utW0yiFH+A0Qxn2DfwFsCg+94sXvFdP7AZ53A8lFT4yLnP0NbM0CMKT3EzHChXB5AfRjSUoHYAdR5VnzXDVW+yU4/JmR38FLbYnHr7DWLGfkiPx83xzDhciXpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360148; c=relaxed/simple;
	bh=+Hzd1w7HojwnCU/DVxbJMRTDalNKgxkpki45I1mN0VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKsaWlLHIstJJEuQ4TQ7698ZqklOK58p0vZiifLyvsB0oEkW+5zgQvmfwW7kBc0ly9i2ZoULRzq7Y5GnA6NxfSIsAwyQCvSac1DGG5uS/zMj9BvisjGpj/uaFiiUN5vj2m3eoWyA4fpfMOQ7ikY9pRnCpliOqRR8qxJalB6iBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=drC4G/dn; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <defcaf0b-21a9-454f-b44a-c91820f541c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707360143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sxbB6xl70fcGsF0IjYGB+vnomK4N76RXXTy+fmO65MY=;
	b=drC4G/dntuy7hyCZhZ/TYhQlm483ShTPi8iqV0f3Hhe2yE6Idq0qPeIJ61wnyG1xlGW7T3
	SaHbz8HMLWS/eJcIxevdBDs+KSoDAEfBZpICD9Egc9mUTgLfY/q4hSfnIqSyQa9Fme5Fp6
	Mfdiw2hOgnNbiiVNyvQdoID3TlotNmo=
Date: Thu, 8 Feb 2024 10:41:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] mm/zswap: invalidate old entry when store fail or
 !zswap_enabled
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>, stable@vger.kernel.org,
 Chris Li <chrisl@kernel.org>
References: <20240207115406.3865746-1-chengming.zhou@linux.dev>
 <20240207154308.bc275f3e72ec1c1fd06cf5a2@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240207154308.bc275f3e72ec1c1fd06cf5a2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/8 07:43, Andrew Morton wrote:
> On Wed,  7 Feb 2024 11:54:06 +0000 chengming.zhou@linux.dev wrote:
> 
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
> 
> We have a patch ordering issue.
> 
> As a cc:stable hotfix, this should be merged into 6.8-rcX and later
> backported into -stable trees.  So it will go
> mm-hotfixes-unstable->mm-hotfixes-stable->mainline.  So someone has to
> make this patch merge and work against latest mm-hotfixes-unstable.

Ah, right. I just sent a fix based on mm-hotfixes-unstable [1], which
is split from this patch to only include bugfix, so easy to backport.

This patch actually include two parts: bugfix and a little optimization
for the zswap_store() normal case.

Should I split this patch into two small patches and resend based on
mm-unstable?

[1] https://lore.kernel.org/all/20240208023254.3873823-1-chengming.zhou@linux.dev/

> 
> The patch you sent appears to be based on linux-next, so it has
> dependencies upon mm-unstable patches which won't be merged into
> mainline until the next merge window.
> 
> So can you please redo and retest this against mm.git's
> mm-hotfixes-unstable branch?  Then I'll try to figure out how to merge
> the gigentic pile of mm-unstable zswap changes on top of that.
> 
> Thanks.

