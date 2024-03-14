Return-Path: <linux-kernel+bounces-103816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7172187C4E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075A51F2211F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577E476901;
	Thu, 14 Mar 2024 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YxNrjzC+"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01656763F4;
	Thu, 14 Mar 2024 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710453291; cv=none; b=pAd9DCi6O3rqsvHaLHZWMPp/NPdvT60qEVAtSZW6WDzypWdm/xOeh6+rPaSU5QE0t6AFJML/WQR1wLO/t8k7bvhMIWCHiL3KwQhzskiicHk6zm2xIU1oBKq5JMqB65Lqwu6aJ4TcMqAUhDN1gGSd1C0OOqBIHrHapl7U9RyJBu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710453291; c=relaxed/simple;
	bh=GnBHRQ+3YRZeL4Dxe1ImD8EM2jHxPNk9bN05gh2klCU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y2q25fOe+pRhRkvpt4Lj1Zs3tZKgFTxcA1AQLRD/y8E7/vEXl1e3BFD9h5oBpA5OrUeCCrHElLOHjr42arL0wWP7F/3kWhZ5+QDnWQLsDEI5V3TEfDtyEURgl3tnP+u0Pc7by662dFGJzNaAzGlb3vOXY78y7/fZ6gYRWUM4Xxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YxNrjzC+; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ad7ab1e-6c8c-49a4-8fdf-73a6bc1a9f53@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710453288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FarU8XHGbJqrDksOOLfxHzD2672xS3242un2A6+x6wY=;
	b=YxNrjzC+kJ2XkA8KPgYqH9EhbJhxFo0knJksNl/9B0hy/Tay3W/cMWtcAuaptdwJ+uB7YQ
	ImG9LGTugY8ODmVWudXz9/Ew2nQtNQEfORV+e+vbilWNq6PuacZubIh8uSzFelh3HU4zmW
	4a7+aP1+Cy9xLiX/yACayUIKFo8po3o=
Date: Thu, 14 Mar 2024 14:54:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, kernel@quicinc.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
 <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
 <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
 <0dff8f05-e18d-47c8-9f19-351c44ea8624@linux.dev>
 <e5da91bc-5827-4347-ab38-36c92ae2dfa2@quicinc.com>
 <65f21d65820fc_3d934129463@willemb.c.googlers.com.notmuch>
 <bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev>
 <65f2c81fc7988_3ee61729465@willemb.c.googlers.com.notmuch>
 <5692ddb3-9558-4440-a7bf-47fcc47401ed@linux.dev>
 <65f35e00a83c0_2132294f5@willemb.c.googlers.com.notmuch>
 <e270b646-dae0-41cf-9ef8-e991738b9c57@quicinc.com>
 <8d245f5a-0c75-4634-9513-3d420eb2c88f@linux.dev>
In-Reply-To: <8d245f5a-0c75-4634-9513-3d420eb2c88f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/14/24 2:48 PM, Martin KaFai Lau wrote:
> 
> I would think the first step is to revert this patch. I don't think much of the 
> current patch can be reused.

My bad. Please ignore. Just catch up on the revert patch you sent.

