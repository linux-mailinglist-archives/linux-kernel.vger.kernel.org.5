Return-Path: <linux-kernel+bounces-38403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85CE83BF0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7156228D40E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C7D24B52;
	Thu, 25 Jan 2024 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPmG+InE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DEA286BC;
	Thu, 25 Jan 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179109; cv=none; b=EeeUyPoV1UBMWb5mTcUd2xs+t+YqT3ejQfeIb5ao4/6sNp4y8uQz6xlC+lR9nDx4hxf6u8+lNXJKR4LEJtSqi4Cf65F018ZtWjo00n/kXjdnT3iJEslkeChyZtxQWqgAEdAHcSRuNjk38LXza0V6++ChjO66qUbDpv12khIj8JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179109; c=relaxed/simple;
	bh=N1jVOSNlM0yJonXxmcq0nNV6L21AE9zFYCH/FyRsngg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbuJtKmqWCjyJnGUK2wa8TSAUzO0gWWvdxkASbctc0CvLKSdoZkqFIexbHE+QAVF4XtKP2kIDNgCPo0WLDMLBtayPIokHUIPySoTFJhtxKUZTacVu19tuaV7UhHPFGzZX74hcgZvFud9eQs1f1q09cQS6OsbBAiw87rdltVjRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPmG+InE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E34C433F1;
	Thu, 25 Jan 2024 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179108;
	bh=N1jVOSNlM0yJonXxmcq0nNV6L21AE9zFYCH/FyRsngg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jPmG+InE//r1LeUk0J19ONKWSo9DOVR9btHeiHWdm3aMkvVl5kYe1wSfLMkLgB+8k
	 J6GpV7LFkvD2lQD7w6N6vZjhDybYSIGzUVjwg3EL64pXBiHDsVNWL5jX5/Vb4g3D7L
	 CJr+NylKuGWziuoVs32/vABe0pbA4eqLiuyA5QEutf0P7sw7QANYRLxo0kKT28YnzV
	 6sR5w7oDg7oK+gqAM2xRY5plyMojpzN5QDkXwUMn9RdIb2zIlml/qUg83kBc5ggitG
	 gQOoqD3g2PWnUKvqFXaU532MdiAVFsEMkYpo11K5jJp49QqwVeROhI0J4Cyft0rzWd
	 K/KI/oDQki59w==
Message-ID: <c83b757c-5cb6-4dbb-a513-754a7cda0ca5@kernel.org>
Date: Thu, 25 Jan 2024 12:38:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/habanalabs: use kcalloc() instead of kzalloc()
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Erick Archer <erick.archer@gmx.com>, Marco Pagani <marpagan@redhat.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240120151028.11092-1-erick.archer@gmx.com>
 <91e87233-3a10-43d6-b850-9cac083913e0@embeddedor.com>
From: Oded Gabbay <ogabbay@kernel.org>
In-Reply-To: <91e87233-3a10-43d6-b850-9cac083913e0@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/01/2024 18:45, Gustavo A. R. Silva wrote:
> 
> 
> On 1/20/24 09:10, Erick Archer wrote:
>> As noted in the "Deprecated Interfaces, Language Features, Attributes,
>> and Conventions" documentation [1], size calculations (especially
>> multiplication) should not be performed in memory allocator (or similar)
>> function arguments due to the risk of them overflowing. This could lead
>> to values wrapping around and a smaller allocation being made than the
>> caller was expecting. Using those allocations could lead to linear
>> overflows of heap memory and other misbehaviors.
>>
>> So, use the purpose specific kcalloc() function instead of the argument
>> size * count in the kzalloc() function.
>>
>> Link: 
>> https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
>> Link: https://github.com/KSPP/linux/issues/162
>>
>> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks!
Applied to -next.
Thanks,
Oded

