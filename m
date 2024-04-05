Return-Path: <linux-kernel+bounces-132639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75EE899796
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED1E1F228E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5E146008;
	Fri,  5 Apr 2024 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yj76Ra8A"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1F145B31
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304838; cv=none; b=P9Ev5ybUAri75ub0IIK+IGcxb+13Z/Rcxp7Ovj/xBite55JRvc5JFMFI0ZzVoVirAHlot9PEURMiU8a30hwcLouImUq9sq0HoFT6AAj2TZMDGh2UQdrbHFQz+fSOkPEdXR1fJmcpx2fC17FTfhnqBnjhqISWrJ4avO/U1Jh9ZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304838; c=relaxed/simple;
	bh=aLcvOXrdCrqopfXqGq+WE4Bd9vEupxkZrmFX8Q7u6Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBy6Rx7It67h5sxQJZPedmgGWpWGRvpCuTAu4nxPW15PdY9MWMpri1MPlASbNsmQGfFYoMDMh0Oo4jcwmICzAU8QODxahQmx/2Ho9SvEZ1Hj3AHd26WBS097I1omYPMFIMmOozFy2NYlNyRTr1iWqVGw5vadxRUroXHH+oXzzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yj76Ra8A; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712304835;
	bh=aLcvOXrdCrqopfXqGq+WE4Bd9vEupxkZrmFX8Q7u6Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yj76Ra8AXVginYgFPamjr/H/RiuVNbfSOwZkOKBzzXPhPzNHnlz4wjj9ikH/FalfY
	 bW26gpoPbGvIktS8C/gzeYZLVCxE+pHFLabtfOPcm7ycCXkX0NA8CdBcxusi8LIKuj
	 aYHfJssGT4q3Du2w9wQUlJi0toIFxnEyCyUaKIobe555F84jRhcVBBv4WpE/nEbJEg
	 WoUtiSEQTAolfzHoZ8yrqIQSQ3wUpbfxqnrpwpJh1/eA+89ThiSqjd+BdLEV3H0e0z
	 hG3mLljicyma/TuvQSP8ncUgbM4ZX80kI+5IqrDkBh/G40pln/1nHubYnFYV/Y8lSt
	 C4ZtdzaJoHC5A==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 22B2B378212D;
	Fri,  5 Apr 2024 08:13:54 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: tglx@linutronix.de
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
Date: Fri,  5 Apr 2024 10:14:15 +0200
Message-Id: <20240405081415.15170-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87cyr4ao79.ffs@tglx>
References: <87cyr4ao79.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 4/4/24 22:05, Thomas Gleixner wrote:
> On Thu, Apr 04 2024 at 21:14, Thomas Gleixner wrote:
> 
>> On Thu, Apr 04 2024 at 20:06, Thomas Gleixner wrote:
>>> On Thu, Apr 04 2024 at 18:14, Thomas Gleixner wrote:
>>>> Can you please provide 'cpuid -r' output too as 'cpuid' does a few
>>>> tweaks to the raw data and it's hard to match it back to the code.
>>>
>>> Don't bother. I think I figured it out.
>>>
>>> Can you please test the patch below?
>>
>> Bah. Won't help. Let me dig deeper.
> 
> Can I get the /proc/cpuinfo output please?

Here are more logs from the same device running v6.8:
- cpuid -r: https://pastebin.com/raw/YmDrnw06
- cpuinfo: https://pastebin.com/raw/Ki0vwdDE

Thanks for looking into this!

Laura

