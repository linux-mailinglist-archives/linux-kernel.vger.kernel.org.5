Return-Path: <linux-kernel+bounces-24231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CCE82B97B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508051F248AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0461390;
	Fri, 12 Jan 2024 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OfCc/uBG"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B93D14F63
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40C2P6aC044415
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 11 Jan 2024 18:25:07 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40C2P6aC044415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1705026307;
	bh=eXbAguUe+qR+bnHFYgNPuQMZxxGMYoKTlIbL/6KZHvQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OfCc/uBGev2Qbn8FPRU7cZ7KmyQJEEK3hjpEIIw3rcCTsY/u/F/oa6TJr6UpAJ0/y
	 CfzNMhS/oIgmwKxuU5SPRCnt+oemabwfVK0A96oBl5XTGLRk4PlBk4e5bKbMRrdgp8
	 QLfp3z+MLo6veauPnUZIPQcNQjsXA8fF0WRZCmDffUGMu/Ww6Y+kvi9PdVGljVlzHM
	 k1ZN1tbSnclx5Xnf1DmqukB/XgSwDkiYQG9FIX1hTNMalNxiIy3lMkBqOZQI+taXci
	 IFCAzfFUXkreTT1jukjnuEV4CbV1z5mWKT30bePbinF67M1Edpm75rJaJwjjnEawwQ
	 Zm1LwoofKPPrA==
Message-ID: <866d8a95-d7ff-475d-b8c5-bcffed0dfa1d@zytor.com>
Date: Thu, 11 Jan 2024 18:25:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
Cc: pinskia@gmail.com, Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org
References: <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
 <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <1681813.1704843645@warthog.procyon.org.uk>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <1681813.1704843645@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/24 15:40, David Howells wrote:
> 
>> Both C and C++ has had a lot of development since 1999, and C++ has in fact,
>> in my personal opinion, finally "grown up" to be a better C for the kind of
>> embedded programming that an OS kernel epitomizes.
> 
> And gcc got rewritten in C++ some time back, so they have a vested interest.
> 

Indeed.

>>>    (8) 'virtual'.  Don't want virtual base classes, though virtual function
>>>        tables might make operations tables more efficient.
>>
>> Operations tables *are* virtual classes. virtual base classes make sense in a
>> lot of cases, and we de facto use them already.
> 
> You end up adding storage for a 'this' pointer for each virtual base class, I
> think - and then you may have extra fun if you inherit from two classes that
> both inherit the same virtual base class.  Abstract base classes that are just
> ops tables are probably fine, though.

My apologies, I meant *abstract* base classes, not *virtual*. To be 
honest, I don't think I have ever used virtual base classes in any other 
application than games (relating to physical objects), and barely even then.

	-hpa

