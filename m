Return-Path: <linux-kernel+bounces-102526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAD987B35C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDB31C22FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C9353E15;
	Wed, 13 Mar 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FprN4RY5"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931151C33
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364753; cv=none; b=H/u4aaeY84obUxE/MERCiboFk4Zc783AQdW5rfRHBUkS5lm6MCvG9E9nNZ+JLsI+Eq/pArvS5xnkEPECoFYO1rclwvmL8pn4jdN31O9SMgDK80/bEOFE5Uv8cei5kHWmmQTfRliL4nIwe1Wwl3Odc1+bf9bzUHEbJWnRFCtSbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364753; c=relaxed/simple;
	bh=w3DllNLGMR7lIB8DYbuLI7aupjFur2UiDnef2O0/H9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jht/AfM/RByIJauaCZAyHEtq02SvbI8jYx3/OPNdaBXizBmnpWDU7dyfsEi8W0LKKbYdRb7Muw2gRiQ3J6ezsQGdOpVrd3rfdlc/zrppUahGeV6b1C5Vgq3trIhGC6bF9mUvPw+kGKkl1xZzI2yuKF4qRaBYOFv2X1MHUTLYfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FprN4RY5; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a0f948a-ca0e-4241-8a21-e7c7fc2ea471@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710364748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6mEnRGlJl2PudXnnV6c//UkHzODVG+YtNXtgd0QNKA=;
	b=FprN4RY5m3wnFmv4kM+PK4pnxTTDD9yhEBRhtOdvtHzWmiLr4YhxiidDC8G3UnyzOybdbA
	nnoXbvfeUO0fSgCin2Q8qTzbsO+MupOULF/JlA6MFcXks5hMtNThFu+Ct86/NNmWEvX5I4
	bSY/l6Xap23Lbb2xt5R7VWz2dDsTt9w=
Date: Wed, 13 Mar 2024 14:19:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Content-Language: en-US
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kernel@quicinc.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
 <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
 <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
 <02363fef-0b5e-4b6c-bad9-db924db230b9@quicinc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <02363fef-0b5e-4b6c-bad9-db924db230b9@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/13/24 1:59 PM, Abhishek Chauhan (ABC) wrote:
>>> I think all this is crying for another bit in skb to mean user_delivery_time
>>> (skb->tstamp depends on skb->sk->sk_clockid) while mono_delivery_time is the
>>> mono time either set by kernel-tcp or bpf.
>>
>> It does sound like the approach with least side effects.
>>
> Martin and Willem , while we are discussing to use seperate bit per skb to check if its
> SO_TXTIME from userspace or (rcv) timestamp . I came across two flags used in skbuff
> called in filter framework
> @tc_at_ingress: used within tc_classify to distinguish in/egress
> @from_ingress: packet was redirected from the ingress path
> 
> Since i believe the above testcase is based on redirecting from ingress to egress part
> why cant we use these already existing flags ? Please advice
> 
> I am not completely sure if we can use these flags to solve the bpf problem or not.

I don't see how they are related. It can tell where a skb is at. It cannot tell 
what is in skb->tstamp.



