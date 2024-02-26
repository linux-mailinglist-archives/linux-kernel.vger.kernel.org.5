Return-Path: <linux-kernel+bounces-81157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB9786713D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436AC286724
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB444EB5D;
	Mon, 26 Feb 2024 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VnAJmcyH"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5B4EB3A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943083; cv=none; b=oWUMI3yA2Z3qcr+fw/wcK2DJEJm/YB+I+waD0KQ5FbwIWagUFf02xipP3/GJM9ymN8qRhStDzV1qDV9/5JHI5RmSILih9w47OtIsCT5Ro3hIC/SNq9CN8mMIZh3kF3eYeYWZCYSVvA1N/vhx0EQVT53Z2OSxZUh9n+S+p+9akxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943083; c=relaxed/simple;
	bh=hHXuuFK6rC5afAFqHsHsVuu803HQi5A4NQMlnO6RM/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnMGFClFMy6rGqf/kHH0Wa9/ZP8BHh3apaMgnUswKVG0ykxGo0pY+336IKm+dPw7gQD6nTMLra2kuvVTvalyER0eOmhRto291764oXVDnnr7aDBWCve6E+AZy1RxEwnpialIDuaS8LSYN6SNqUMB7h+Fur1ory/6N3WVeekHso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VnAJmcyH; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5709d61-18cf-4c6e-89b0-9615296c645a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708943079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTCp6YejjtPgu/QUTXPpM8H1Y9H5FjU1dYsnPrliO5M=;
	b=VnAJmcyHzOggqmqiEuGAajYFZ1GBwni/8f5JnFmGEnXRhgpmRwtblR+tSVt8gQ6GbXCKtT
	CcUQ4MhEtDh2uGTEF4GDfIkuDzI7pPCtNsQP/THhHH/DfblUVQpye6suX7wwL0c1g+MVkM
	r0XRq8KylFKqCCCNNZtKxdg/lBRuRYg=
Date: Mon, 26 Feb 2024 18:24:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] freevxfs: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, vbabka@suse.cz, roman.gushchin@linux.dev,
 Xiongwei.Song@windriver.com, Chengming Zhou <zhouchengming@bytedance.com>
References: <20240224134835.829506-1-chengming.zhou@linux.dev>
 <ZdxiqJZY2qSRVvEU@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZdxiqJZY2qSRVvEU@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/26 18:06, Christoph Hellwig wrote:
> Please just do a scripted removal after next -rc1 instead of spamming
> everyone..
> 
Do you mean put all diffs into a single patch, send it to all people?
That is also a choice if it's preferable. Should it will go through
the slab tree then?

Thanks.

