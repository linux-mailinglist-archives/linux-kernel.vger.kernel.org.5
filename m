Return-Path: <linux-kernel+bounces-76705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F9085FB4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C719428359B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5FC53364;
	Thu, 22 Feb 2024 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="X6BMthJz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C9GNx5wI"
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270142AB6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612428; cv=none; b=VqDOssOMd5YAOQyAKWHvMdnMd/bPwqccOL576nq6PxropBOT3/SEIutUD+crCmLKXj3NIbMmPVk6AOyxZLOD52XjnEldWWThs5qra0tX0k3GUEbOadOlIOPsDBrxtXCTRQ0GaBLFBF+gl1uva3s+RpFnYLLHAcLDx7EtnG3GKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612428; c=relaxed/simple;
	bh=527mdPPL4aN2IWeAcmpZEXIQmF09qeMjZOk8FaO4vEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTk38sC8bAt0jjvF8x19CVYm40WP4+FGEayerMKb6bBiyt99SggOPYiq+eeSgEmKvvDSlVJgWq2SiU4091G393gqwAGqlOo/aEO9/orALuKXgBeUpNvAXs/f4c8Y+9d23aaNsDnmJ5DUEMKz5Aq4aDk0lwhVV5oLAYZsMPjMaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=X6BMthJz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C9GNx5wI; arc=none smtp.client-ip=66.111.4.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id 84455581793;
	Thu, 22 Feb 2024 09:33:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 22 Feb 2024 09:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1708612423;
	 x=1708616023; bh=G2omAYB7XWbRhd+2xEirxMz02GexZSs5D7pV8fUH3/o=; b=
	X6BMthJzZe8KLMXgtf3QUc6/IM/VOLY8qoGWoG1LJgDAJQkN+uiutoLJCbz4iVHA
	rJoizqvYSEJfl6VndSxX+sWk6FRifjve/O8y9uCw4NIqifo+vWDBdoWhPrT17DZF
	bawZphtthywKPVeDpiharKcIWVAjg/TD6/YVi3NePNDDQRTa7CqHEGb2Tj8+ied7
	+J6HTUCMOmn5PNimOx+Xw8Z/NfUrV4nDwV2J0/Les3hqCkmAJR2JB40e/cfXcp90
	JkOhmXrmTe/6yuYUyQB4R0egjNVZIhSYSvMzn7M7pZzz94iSrxQ2kPuZbM7wSM2F
	FMBOEf4KjK8vAsHD3C3xUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=if4314918.fm1; t=
	1708612423; x=1708616023; bh=G2omAYB7XWbRhd+2xEirxMz02GexZSs5D7p
	V8fUH3/o=; b=C9GNx5wIwzDkbmTor117zgXQXhFM00YLxso2Pxm+iy35d4xdGj8
	kKaK/+Jn00ThI+MRrpjgdavVFSXKkX39oDZRN55iA0o0gJ7XQ/x34D2ZcZYXF0uh
	Me7N91KPCQ4sJo6zuNv9flsaObgbdiFb86Ok8ZoM1Tv8gQwbzlhwpdgp09k5uYTr
	nOqi1eeQms9+vDi+m7Z8GMHcJphnkco0/IMJ5NVAVh+5yTJXKJcysBX5OEg5Ud6W
	e4ux223ALzp46xQUnJLb2gxdqx6gXPu5hWvGtpDtXgQXWHmIeYagqJgxnVdoWDtY
	fb40jOjKRD8wLCc8pT2cxYtL75PMWhf2D6w==
X-ME-Sender: <xms:RlvXZYeDTx2HiZFSV8L1cbsV1T4d3gXTjmtmYvnOBlDTFoBwWcmXbw>
    <xme:RlvXZaNmcIVnQ0pyFpqofyeqTWAS4dKuOSOAEHdSl4QKA75HbziZTF4Odx5YUeHvn
    -Sin1R9iJzF0v52TNE>
X-ME-Received: <xmr:RlvXZZh9trwzcbS6jbm25u9Wb37LaJVrutavIJsBMdVGIGxdRInKF2747dVxP24xmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepofgrthhi
    rghsuceujhpprhhlihhnghcuoehmsegsjhhorhhlihhnghdrmhgvqeenucggtffrrghtth
    gvrhhnpeduveehjeetteffjeeltdefgeekhfeufeelheejfedvhfeutdffiedvtdfhudeh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmse
    gsjhhorhhlihhnghdrmhgv
X-ME-Proxy: <xmx:RlvXZd91jSv1s27xR-ASgEhMYnYeQutteABRysgrkT4KNto1bFyi1w>
    <xmx:RlvXZUtO-eoPbQANBG_e2trJW-2w_xFgtApVJ2jM2KnjNSDchSYZww>
    <xmx:RlvXZUFUiMD1e9KDq5FIM5eUcAAZNkDF9PzqhLQHCkPDpDDH8DDBvw>
    <xmx:R1vXZYjY0PRdnmum_PjmFqg6EYHR4DKHYpBgzme6w39muDt0zhclIg>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 09:33:41 -0500 (EST)
Message-ID: <65e03e4d-b7ef-27f9-2651-eac372f17a9b@bjorling.me>
Date: Thu, 22 Feb 2024 15:33:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [f2fs-dev] [PATCH 3/3 v2] f2fs: kill zone-capacity support
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, Juhyung Park <qkrwngud825@gmail.com>
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, daehojeong@google.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>
References: <20240207005105.3744811-1-jaegeuk@kernel.org>
 <20240207005105.3744811-3-jaegeuk@kernel.org> <ZcQSV0HyTwoiW8os@google.com>
 <f174092a-192a-47f9-a1d4-14d86bba266c@kernel.org>
 <ZdT3EqOB-wXM1NLm@google.com>
 <CAD14+f106hmLXMOfLu_cd55rAKmv-KLq-HqCSrKULt27OPhk=w@mail.gmail.com>
 <ZdYylhiPrv9Pa7It@google.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
In-Reply-To: <ZdYylhiPrv9Pa7It@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21-02-2024 18:27, Jaegeuk Kim wrote:

>> Doesn't this break practically all ZNS NVMe devices?
> 
> Yes, so here I'm in questioning who is really using w/ zone capacity. If there's
> no user complaining, I'd like to deprecate this, since this adds code complexity
> and unnecessary checks.
> 

Hi Jaegeuk,

I like to make a couple of points to hopefully keep the support in a 
little while longer.

- NVMe-based zone devices continue to be developed with the pow2 zone 
size and zone size != zone cap features. There was some divergence in 
the first-gen drives. However, all the second-gen drives I know of are 
implemented with those features in mind.

- A very active community is doing work using f2fs, and many of those 
members are working with the ZN540s device (which exposes a pow2 zone size).

- For drives with a capacity of less than 16TiB, f2fs is an excellent 
file system to use and is really useful for various use cases. We're 
using the f2fs daily for a couple of our workloads.

Work is ongoing on btrfs and XFS to support zoned storage devices, but 
they have yet to be through the trenches as much as f2fs has been with 
its zone support. So it would be great to have f2fs continue to support 
the pow2 zone sizes, as it is a valuable feature for the currently used 
and second-gen drives that have been released or are soon becoming 
available.

If there is a performance concern with the feature re: ZUFS, maybe the 
pow2 implementation could be slightly more computationally expensive, as 
the feature, anyway, typically is used on more beefy systems.

Regards,
Matias

