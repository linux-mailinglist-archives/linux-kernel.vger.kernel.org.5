Return-Path: <linux-kernel+bounces-65288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A93854AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64811C25328
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C754BCB;
	Wed, 14 Feb 2024 13:42:43 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE429437;
	Wed, 14 Feb 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918163; cv=none; b=e6Sn/wYEgjD2z3RD7BkFgsO2M0qOnzxyow7uwakbgiHXbfpBdpfxkL4sLXW7/Q2g2wMNVXmGzTk1FFQUg9ESaIp4A394I+o3BbKBmg/ImILUXBfJM7YZHe0KU7ByirQ8IMhgck7p/cBRKKOwO4nHnkJulCgXwxtKBoYTxYinuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918163; c=relaxed/simple;
	bh=PEBn0n47Ia0HKmtG+zEzhBaV3c7DqX2s56hV/ieGz6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpZpvxCBTlx6tpas8Z6T2FzbZ9djOdt+rTtl9gfKmj8uq5yPdkopHx81930TJx+2PVGMfiarKRiIxbJ0aBVhBdE9Zcs9WrgZzIBNLMjOnTUFKFqnhp8twTacentjPDOwDFTRLrwpt2x4qOatc/cdk1YWXGkNRAUD1xosboUSbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1raFX5-00055L-3v; Wed, 14 Feb 2024 14:42:39 +0100
Message-ID: <43b8150e-17ef-4911-81ed-37a96c73195f@leemhuis.info>
Date: Wed, 14 Feb 2024 14:42:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: sched/cpufreq: Rework schedutil governor performance estimation -
 Regression bisected
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <002f01da5ba0$49cbf810$dd63e830$@telus.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707918161;b0bfb5aa;
X-HE-SMSGID: 1raFX5-00055L-3v

On 09.02.24 22:38, Doug Smythies wrote:
> 
> I noticed a regression in the 6.8rc series kernels. Bisecting the kernel pointed to:
> 
> # first bad commit: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d]
> sched/cpufreq: Rework schedutil governor performance estimation
> 
> There was previous bisection and suggestion of reversion,
> but I guess it wasn't done in the end. [1]
> 
> The regression: reduced maximum CPU frequency is ignored.
> 

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d
#regzbot title sched/cpufreq: reduced maximum CPU frequency is ignored.
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

