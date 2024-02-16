Return-Path: <linux-kernel+bounces-68136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44ED857650
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D743F1C2273C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435614AB4;
	Fri, 16 Feb 2024 06:57:12 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211914AA0;
	Fri, 16 Feb 2024 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066632; cv=none; b=WxVy8TLgFt+ctug6QQWHgcfh3BzbaN/pkLAVLIlGixJ8ouPZm6mPI+xQcKmLdVGFOMjo4qsfPNQalNztz7ISEjMRPW5LYecLPOUxYTA7X+R/DNKOczZM/V15BfY7Jq9oC+dKKDdTap4d7zPicaE/ua8oyx5cOrsV2AXn3Qnpcvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066632; c=relaxed/simple;
	bh=DcfqJeb/CLtSUd3Zo3dx5ue5k4+gqON9RTbFiSVUqsM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=afqBSsJD4PpbWse2wlx/TlulgmFuOaLQhB/M43PPEVNam6mQ7QAPGe4619x8DIYP6HqE3OgkjK3ysDQdxsWw0bTjgFLNanoFg8qT4Jv5XpQ0WmObPpyR7ckr3tL5EVdl1AmfmRVATmVXFRFhBDCHTlMRJ5OT+9l8eHa4DQlBtQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ras9j-0003WS-TV; Fri, 16 Feb 2024 07:57:07 +0100
Message-ID: <8e7f9d37-ab18-419f-9641-287412a5cb4a@leemhuis.info>
Date: Fri, 16 Feb 2024 07:56:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "usb: typec: tcpm: fix cc role at port reset"
Content-Language: en-US, de-DE
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240117114742.2587779-1-badhri@google.com>
 <ZcVPHtPt2Dppe_9q@finisterre.sirena.org.uk>
 <04fc959a-4a50-4c84-88a5-fa0d79c008b3@leemhuis.info>
In-Reply-To: <04fc959a-4a50-4c84-88a5-fa0d79c008b3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708066630;11e64ac6;
X-HE-SMSGID: 1ras9j-0003WS-TV



On 10.02.24 08:38, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 08.02.24 23:01, Mark Brown wrote:
>> On Wed, Jan 17, 2024 at 11:47:42AM +0000, Badhri Jagan Sridharan wrote:
>>> This reverts commit 1e35f074399dece73d5df11847d4a0d7a6f49434.
>>>
>>> Given that ERROR_RECOVERY calls into PORT_RESET for Hi-Zing
>>> the CC pins, setting CC pins to default state during PORT_RESET
>>> breaks error recovery.
>>
>> Between -rc2 and -rc3 I started seeing boot issues in mainline on
>> rk3399-roc-pc running arm64 defconfig, a bisection identified this patch
>> as having broken things.  The issues manifest as a hang while loading
>> modules from the initd, you can see a full boot log at:
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced b717dfbf73e842d15174699fe2c6ee4fdde8a
> #regzbot title usb: typec: boot issues on rk3399-roc-pc due to revert
> #regzbot ignore-activity

#regzbot monitor:
https://lore.kernel.org/all/20240212-usb-fix-renegade-v1-1-22c43c88d635@kernel.org/
#regzbot fix: usb: typec: tpcm: Fix issues with power being removed
during reset
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

