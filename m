Return-Path: <linux-kernel+bounces-60334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CE985034C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2409F1C2244A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6E2B9CA;
	Sat, 10 Feb 2024 07:39:07 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401B7472;
	Sat, 10 Feb 2024 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707550747; cv=none; b=aQ0hpwVXtF/iGx11X27tclNpndkeyjz5UFInpg4KiVjZzEWedT+2cbKBrdS7OC/5xK59d+yF3V2uqaltYn8RwLc0D1C4ptsWygef/2YxSvWdA002ofuDbhRWXYcz8arY1UenOiGBcsmgLStWFfb+fCqXBgaqd+9Xh8JI0aMLIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707550747; c=relaxed/simple;
	bh=46eoq7MhMARovYT7U9qx122WZ4h+fYnnHqT6CRXyX8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oksI0OHQ9kC1DnH38h0uRyc1pWsIDPfQj0/5vZduM5AxZED+MYpeDz9LuF2bgDW2VFBgk6UAW61HIC2mzMumJHRTbTKiX3NOJ0bL2G0MgBdhRSXB3P1cWc7nLhKcg53irKXZMjHq3+sfXTqhgGjbydIf3/V0XvmSchKpvjIDdEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rYhwu-0000EU-UZ; Sat, 10 Feb 2024 08:38:56 +0100
Message-ID: <04fc959a-4a50-4c84-88a5-fa0d79c008b3@leemhuis.info>
Date: Sat, 10 Feb 2024 08:38:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "usb: typec: tcpm: fix cc role at port reset"
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240117114742.2587779-1-badhri@google.com>
 <ZcVPHtPt2Dppe_9q@finisterre.sirena.org.uk>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZcVPHtPt2Dppe_9q@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707550745;17f83627;
X-HE-SMSGID: 1rYhwu-0000EU-UZ

On 08.02.24 23:01, Mark Brown wrote:
> On Wed, Jan 17, 2024 at 11:47:42AM +0000, Badhri Jagan Sridharan wrote:
>> This reverts commit 1e35f074399dece73d5df11847d4a0d7a6f49434.
>>
>> Given that ERROR_RECOVERY calls into PORT_RESET for Hi-Zing
>> the CC pins, setting CC pins to default state during PORT_RESET
>> breaks error recovery.
> 
> Between -rc2 and -rc3 I started seeing boot issues in mainline on
> rk3399-roc-pc running arm64 defconfig, a bisection identified this patch
> as having broken things.  The issues manifest as a hang while loading
> modules from the initd, you can see a full boot log at:

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced b717dfbf73e842d15174699fe2c6ee4fdde8a
#regzbot title usb: typec: boot issues on rk3399-roc-pc due to revert
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

