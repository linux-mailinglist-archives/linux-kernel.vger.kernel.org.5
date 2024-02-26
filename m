Return-Path: <linux-kernel+bounces-80420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE2886684E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512411C20F26
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E614008;
	Mon, 26 Feb 2024 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TJ7M1ufl"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB912E55
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915569; cv=none; b=Q+hDHn+MDtX+Urefo7gYfud3k7gBeyN4hn0CrXpnHiEZht7Ptnd2jVj5UJMbVkiqCotp6nrTKNiTK6A0zj6OqkBm3u5vvUIagzOW6p9MwnjSIPh7DBMSuTOtHHmK97y2wPmoC79PSybHivcBM348Uva4Ve9+Uvv+sTYfqLKsC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915569; c=relaxed/simple;
	bh=SqxRxXT/0+g4d8aAUyoAa2aFlCy7urjf8MXuhRyKyMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stZ3CmRArs+NHXN9mp6vM6b5B5BLv27Ns0FNaK5HBxkNFlB16KI5VR9Qxl6L+TKu+Pr22r2GxBkj/pFns2EJ5whd86v+e/6MNfgBY8d7um19hnwU1VGHYs5lsczFUgnERD84zvJtF9CYliwRQQUkocMsohsNyQtpmL4COxz50qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TJ7M1ufl; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <85628515-9b75-4498-8a7f-1f1a33cfeca1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708915565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+PILNUvh9rhfqYpVarQEPUj15xIczPVax4wdDf61n4=;
	b=TJ7M1uflwrFPvWRyq6mngrdtz86MrpxnH9IwsnC5e82DVbw28EyhwEt3NsBtMYHOxCclmx
	ILXWaDIdntC4PTKDaLeyL7fi+wHhkwpiU54Ee90TNBS4/V+y6yjjvDDIvAVJci/wVoJbkC
	Oycc4G7q7F8Y2AexgWz3LryW7f4MHng=
Date: Mon, 26 Feb 2024 10:46:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ubifs: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>
Cc: linux-mtd <linux-mtd@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, vbabka@suse.cz,
 roman gushchin <roman.gushchin@linux.dev>,
 Xiongwei Song <Xiongwei.Song@windriver.com>
References: <20240224135217.830331-1-chengming.zhou@linux.dev>
 <1319891481.98257.1708893399313.JavaMail.zimbra@nod.at>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <1319891481.98257.1708893399313.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/26 04:36, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "chengming zhou" <chengming.zhou@linux.dev>
>> An: "richard" <richard@nod.at>
>> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-mm"
>> <linux-mm@kvack.org>, vbabka@suse.cz, "roman gushchin" <roman.gushchin@linux.dev>, "Xiongwei Song"
>> <Xiongwei.Song@windriver.com>, "chengming zhou" <chengming.zhou@linux.dev>, "Chengming Zhou"
>> <zhouchengming@bytedance.com>
>> Gesendet: Samstag, 24. Februar 2024 14:52:17
>> Betreff: [PATCH] ubifs: remove SLAB_MEM_SPREAD flag usage
> 
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
>> its usage so we can delete it from slab. No functional change.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Applied.
> Next time please add a reference that makes very clear why such a flag
> is no longer needed.
> It took me a few minutes to figure why SLAB_MEM_SPREAD is
> now a no-op.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag. And the series[1]
went on to mark it obsolete to avoid confusion for users. Here we
can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Thanks,
> //richard

