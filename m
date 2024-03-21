Return-Path: <linux-kernel+bounces-110614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F064888614F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB46E284DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F951134CFC;
	Thu, 21 Mar 2024 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qNIH0Hs0"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A013441C;
	Thu, 21 Mar 2024 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050758; cv=none; b=hXefctsERmg/rGDyIKgzQwEmT5ao/aFovphGLwvbltkayWXAG4rJRCM9elGHW4BtlJeP+V3iKtBnKBo9LYdzgQS6IkDPVqzlZTsEVZBPMW+/txRGkRBIKRq3WtBf4x1U8FanB/qmQonhWHsonyP0/UT4r751n8SzWQ3G8/vL7O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050758; c=relaxed/simple;
	bh=x9bF2GlKwBQBROkfQn8ZkL7g6dXhyRklXjeoJ7+o78Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=digEmqud/333ip89ZWFL+akeJYEsI6svcZK1rTirFmnTYZ3UPUt1J+gIBiwzd4uhtgDaT3Hn7SeKnAz2x1E+KFjnJSAHNC8l9IxmVFXK/eeJR0+sNlpHwRW6uXHJIU8mLJmvIhXhmeAQIzNqOZaLBospZWYBwGoHOkIO8+P9Kv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qNIH0Hs0; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V0x2648xpz6Cnk8t;
	Thu, 21 Mar 2024 19:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711050744; x=1713642745; bh=x9bF2GlKwBQBROkfQn8ZkL7g
	6dXhyRklXjeoJ7+o78Q=; b=qNIH0Hs0SVRamEYXBAlL3R8NxsWmvf0F4PHIjKf0
	F60nOEwPPcs2nTqPPLGPAeHFPtUzTP6Gn/OMprkUlSoJNy9qyrZ8EQP9EEbKbDE3
	fzs1DTU8ZQ9+lUVJySklU4z4ygGuvWVyGt7wdARk8OSbRif15zuiBgLWp7TybU3x
	SHFhiEEKk5utahJQerMtwOg/siqOA/ra7Dv0RUUsykNAop28QxZ9yiN9XwThYUNR
	h3/qESF2JBeIi/VOWiSVka58EbJP8YElNcTrBbA1FAAuHrVOAPItSZZSCv//fA+1
	VJc9C1fmGJfgByVbHanmDRv0f5BxU3hZK8bUKEbHUhHPUA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id daY4BxjVFOom; Thu, 21 Mar 2024 19:52:24 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V0x1w433Qz6Cnk8s;
	Thu, 21 Mar 2024 19:52:20 +0000 (UTC)
Message-ID: <2ed2dadc-bdc4-4a21-8aca-a2aac0c6479a@acm.org>
Date: Thu, 21 Mar 2024 12:52:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Introduce per-task io utilization boost
Content-Language: en-US
To: Christian Loehle <christian.loehle@arm.com>,
 Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
 juri.lelli@redhat.com, mingo@redhat.com, rafael@kernel.org,
 dietmar.eggemann@arm.com, vschneid@redhat.com, vincent.guittot@linaro.org,
 Johannes.Thumshirn@wdc.com, adrian.hunter@intel.com, ulf.hansson@linaro.org,
 andres@anarazel.de, asml.silence@gmail.com, linux-pm@vger.kernel.org,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20240304201625.100619-1-christian.loehle@arm.com>
 <86f0af00-8765-4481-9245-1819fb2c6379@acm.org>
 <0dc6a839-2922-40ac-8854-2884196da9b9@arm.com>
 <c5b7fc1f-f233-4d25-952b-539607c2a0cc@acm.org>
 <2784c093-eea1-4b73-87da-1a45f14013c8@arm.com>
 <20240321123935.zqscwi2aom7lfhts@airbuntu>
 <1ff973fc-66a4-446e-8590-ec655c686c90@arm.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1ff973fc-66a4-446e-8590-ec655c686c90@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 10:57, Christian Loehle wrote:
> In the long-term it looks like for UFS the problem will disappear as we are
> expected to get one queue/hardirq per CPU (as Bart mentioned), on NVMe that
> is already the case.

Why the focus on storage controllers with a single completion interrupt?
It probably won't take long (one year?) until all new high-end
smartphones may have support for multiple completion interrupts.

Thanks,

Bart.


