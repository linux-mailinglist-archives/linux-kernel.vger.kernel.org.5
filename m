Return-Path: <linux-kernel+bounces-82734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 280D58688D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4021F234C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE8E53378;
	Tue, 27 Feb 2024 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="SMAjj3hw"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306B5336E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709014067; cv=none; b=PHX2gnjC/bt8B/+oL6+idz3M0cZI3CCkf7vs0Ea0CsW7BtQPwwTa/HeQyj16NhdaSuX4qoPQdx4GvV3Xxyc3inmPJAVP2Zk90WMdDP2lTjyP+29VOPjUeA7G1zA7q674ZuQivREbc99iTHil3RrbNX88FaVAGNvEYFad7yCrfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709014067; c=relaxed/simple;
	bh=tcyvtIM2a9zA9kgA+zfRtdG9EGJaJj2Y0qWf+9sNFSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WvlJwvD9ldX+Gdm22MfbNQr245DJZof/39ULHwXRD3HV8pAs05O+VjDmGy55QPrfk2WHet5yr+ITOUqilaW8rzA00v+lcUgfyZzzbaVBqhAiNSccWM635XZKR0Sxmn9HXnBrMWZ4u46MOmqCg3s00vlT4NoZAQQvCY7vHXdjBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=SMAjj3hw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709014062;
	bh=20EfPIHxyQmybVUOaqQJjyWj5FqndYMB2UQnS5e1DH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SMAjj3hwsEHrCVNHNpUo6f81S+hVoit86vYtw+/8Ycxz6e9h6EJcvRgpR4uSy8PEY
	 6Bi5rZJLKiuiHel+o5eZYodjQuvjMnbhittjjBZ5j6hqe+9HUYtvwSaQlX80jAbUln
	 PGveJMRq1LOdNRhaGc1Us0tRIpAPALInbEfIYt1JxYvMFijKxrQcs2jFaAvq+mJHqv
	 rfJeSASYGWNopbWe9MhHfMXZv8ogA0cxDIaxh06bGwM0gYoL0SXT/wquqXTXGZZw8N
	 /xLwz+73DqWoz7ljz3EkCT8QGphGwwk9aSrKF1kc47Mqy6wywUbFGPGPhQqrxSgMNF
	 EK3jTevCoCwGg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TkRq16g4Dz4wby;
	Tue, 27 Feb 2024 17:07:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kunwu Chan <chentao@kylinos.cn>, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: Code cleanup for __hash_page_thp
In-Reply-To: <f3b53f0e-58ce-4b2d-ba91-f347da73f9f3@kylinos.cn>
References: <20240125092624.537564-1-chentao@kylinos.cn>
 <87h6hva4b0.fsf@mail.lhotse>
 <f3b53f0e-58ce-4b2d-ba91-f347da73f9f3@kylinos.cn>
Date: Tue, 27 Feb 2024 17:07:36 +1100
Message-ID: <87jzmq5tjr.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kunwu Chan <chentao@kylinos.cn> writes:
> Thanks for the reply.
>
> On 2024/2/26 18:49, Michael Ellerman wrote:
>> Kunwu Chan <chentao@kylinos.cn> writes:
>>> This part was commented from commit 6d492ecc6489
>>> ("powerpc/THP: Add code to handle HPTE faults for hugepages")
>>> in about 11 years before.
>>>
>>> If there are no plans to enable this part code in the future,
>>> we can remove this dead code.
>> 
>> I agree the code can go. But I'd like it to be replaced with a comment
>> explaining what the dead code was trying to say.

> Thanks, i'll update a new patch with the following comment:
>      /*
>      * No CPU has hugepages but lacks no execute, so we
>      * don't need to worry about cpu no CPU_FTR_COHERENT_ICACHE feature case
>      */

Maybe wait until we can get some input from Aneesh. I'm not sure the
code/comment are really up to date.

cheers

