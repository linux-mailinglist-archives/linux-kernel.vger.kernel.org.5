Return-Path: <linux-kernel+bounces-92813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA3A87265B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF50828B079
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF8318AE0;
	Tue,  5 Mar 2024 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TIDrRuHA"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78F17C98
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662459; cv=none; b=aTUlYVfcdhs01ovQEbT/O8etQppxCyKIFv2ddENQJ/2akLU+kqaQvQLGNg8ZZpXw5uIEZElGoF/CQb06pVjbjP9rO0dqzzHnSqbiBLFbxuNgcCoTaQqIvzih7oWUymlDQpP7BL4NQsx7ma0kaSBCa8dOqSgVyG7vmT+7IG/m2ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662459; c=relaxed/simple;
	bh=CLb6htEM8BQ4wkYj4Mfxot1eztyH01EK5KTKnTSNh54=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bgpYl9lzznCBnBLWuGCbT8FACEgPl8XpMS+UZ/96+KK+JgyCPFxzY0nW2jNQr3G1x4UsWVxvY08Aza9c2X4C1jUqALuqbXzQrQKjRZodyqSig9nqLJibU8fu4kJZY3lueqAzpHJillf9MctT8ZRDcOaw4SO/ISA/HUg2Drn3EbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TIDrRuHA; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6764b9c5-b61a-4f20-a41a-125d5015a3e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709662455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mCLjnlt6q90qUCq4m5luMROvGFxl/z1bFGYicutzgw=;
	b=TIDrRuHAB3Fwdib4sKxYLlkNs/TwItDMIceZL4vZyE4Carkes4zEYbdAlyJQ4dcCUxPpyF
	6rbx5Zlju5IHwZLJLPCTrfuGz8914F21k9UnY4jBL9g2kqJvjQCD3ROpdK7tcPjKdbpgRy
	reYNOMlidxSNyyW8Jc7aInmHfsV4vK8=
Date: Tue, 5 Mar 2024 13:14:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND2 PATCH net v4 2/2] soc: fsl: qbman: Use raw spinlock for
 cgr_lock
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Roy Pledge
 <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Li Yang <leoyang.li@nxp.com>, Scott Wood <oss@buserror.net>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Camelia Groza <camelia.groza@nxp.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240222170749.2607485-1-sean.anderson@linux.dev>
 <20240222170749.2607485-2-sean.anderson@linux.dev>
 <53b401d7-934c-4937-ab83-6732af47668d@csgroup.eu>
 <34da1e7b-029e-410b-8735-a10d6d267e2b@linux.dev>
In-Reply-To: <34da1e7b-029e-410b-8735-a10d6d267e2b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2/23/24 11:02, Sean Anderson wrote:
> On 2/23/24 00:38, Christophe Leroy wrote:
>> Le 22/02/2024 à 18:07, Sean Anderson a écrit :
>>> [Vous ne recevez pas souvent de courriers de sean.anderson@linux.dev. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>> 
>>> cgr_lock may be locked with interrupts already disabled by
>>> smp_call_function_single. As such, we must use a raw spinlock to avoid
>>> problems on PREEMPT_RT kernels. Although this bug has existed for a
>>> while, it was not apparent until commit ef2a8d5478b9 ("net: dpaa: Adjust
>>> queue depth on rate change") which invokes smp_call_function_single via
>>> qman_update_cgr_safe every time a link goes up or down.
>> 
>> Why a raw spinlock to avoid problems on PREEMPT_RT, can you elaborate ?
> 
> smp_call_function always runs its callback in hard IRQ context, even on
> PREEMPT_RT, where spinlocks can sleep. So we need to use raw spinlocks
> to ensure we aren't waiting on a sleeping task. See the first bug report
> for more discussion.
> 
> In the longer term it would be better to switch to some other
> abstraction.

Does this make sense to you?

--Sean


