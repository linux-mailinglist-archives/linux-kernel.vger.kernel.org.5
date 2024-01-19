Return-Path: <linux-kernel+bounces-31238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90968832AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44BA1C20A33
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF42E53E24;
	Fri, 19 Jan 2024 14:08:29 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C852F75;
	Fri, 19 Jan 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673309; cv=none; b=VYZjrJI85NvHHjs2ioXRmltZ1T49thfrjRyRArFtjAPzK3ihIexXD5lenB17qnHQrzrKfgUAkjeafyNdKzTUEn12iqLhQXt7aNuySxEklPzC2rNJ/1Ymgq5HQvvYD0egIBce12X0daJ9tsPdVfKPz5mPssVQuazDG5hMba6I7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673309; c=relaxed/simple;
	bh=Fiec/VXA2nixAbvl9sqxHaQnfa3rCyHt390tUB1yGjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSxREuopQ4vuBpWeOMG/FA0JxZN58BeqyGdMLAPSWbAintDBsLTmTQCqWzl0r5GEKdvnqcqtAN7X7+Nm1Xl2e7cOhBPi0yXb3o9K2odb8FNyIkUm1oRLC7in1j+EZ9CLg5+6i2I90mjK70UsUXicCKGluh/nUqMJPhs9JBIKXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rQpXl-0006wC-N4; Fri, 19 Jan 2024 15:08:25 +0100
Message-ID: <08b23a77-63c8-4af8-9497-4393235c02ea@leemhuis.info>
Date: Fri, 19 Jan 2024 15:08:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from dcadfd7f7c74ef9ee415e072a19bdf6c085159eb
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux FireWire <linux1394-devel@lists.sourceforge.net>
References: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
 <ZUnhEjtUihOFQ9t1@debian.me>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZUnhEjtUihOFQ9t1@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705673307;e3abef9c;
X-HE-SMSGID: 1rQpXl-0006wC-N4

On 07.11.23 08:02, Bagas Sanjaya wrote:
> On Mon, Nov 06, 2023 at 02:14:39PM -0600, Mario Limonciello wrote:
>> Hi,
>>
>> I recently came across a kernel bugzilla that bisected a boot problem [1]
>> introduced in kernel 6.5 to this change.
>>
>> commit dcadfd7f7c74ef9ee415e072a19bdf6c085159eb (HEAD -> dcadfd7f7c7)
>> Author: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> Date:   Tue May 30 08:12:40 2023 +0900
>>
>>     firewire: core: use union for callback of transaction completion
>>
>> Removing the firewire card from the system fixes it for both reporters
>> (CC'ed)
>>
>> As the author of this issue can you please take a look at it?
>>
> 
> Thanks for the forwarding regression report from Bugzilla. I'm adding it
> to regzbot:
> 
> #regzbot introduced: dcadfd7f7c74ef https://bugzilla.kernel.org/show_bug.cgi?id=217993
> #regzbot title: completing firewire transaction callback with union bootloops AMD Ryzen 7 system
> #regzbot link: https://lore.kernel.org/regressions/f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com/

#regzbot fix: ac9184fbb8478dab4a0724b279f94956b69be827
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


