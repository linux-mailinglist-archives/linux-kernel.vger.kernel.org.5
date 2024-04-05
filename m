Return-Path: <linux-kernel+bounces-132831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44F899AEB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593FA285DCC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D559915572F;
	Fri,  5 Apr 2024 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CwZF9RPk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B591552F9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313140; cv=none; b=FXVV3+QNK3gco0JVRAzPvd9XJKn5isCxgcGafUyDTKOwcUEN2vF66z294wpl8ttfozlHeOINcrzMNNSQjb3/+2tQUZWjjJt5wsRmT0ZMCeZIbONB/A2qFpktCWDVcGN/BbpDz62ezOfbZ2zDsn3hJK6zw8PUsMhoK24nAcaRKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313140; c=relaxed/simple;
	bh=k/RJgxIGRh0rGUH8b0MelIQXUqRr3is2NPVQNA9TFMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DI5X1rVTTzvr/0c7OinIJKt9KtbkJklgfoDNPY3mSpG7/6EWcIlb+1Krfx92/xk/4eqFtr1peUdVBXy4FVlrgEcnxqhtQjg9LkifsPUqV/mr4po3TZS7OuCCowIYdQVzZ5AJmWVRKPM87ZWlaDPs7F7LsPXDVYrc60eMsLhuYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CwZF9RPk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712313136;
	bh=k/RJgxIGRh0rGUH8b0MelIQXUqRr3is2NPVQNA9TFMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CwZF9RPkt6MTtl61EqVrut+UekjZTlckK/K5UYzuTcOXKI9UZo189v6Q9QD/ZdcrF
	 YSwL1TzhNKMVF5JQMqRn6xS+xRrog8te3g7EqLYYrkjs/xtlXinwe2fqE5cqjbNIbn
	 179YAzfny0eOq2f59zTll4Mqgb+XnQgVbhgkTFBt/SVzqN9uiM6dzuX/5mkoEtBdEn
	 iWBG2u0I0cWuxXx/SCD8uM8jRMR2k4EaJ556irQOAjTUeai8moOHUi6qpx8z4p/hNI
	 4sf0N3LmKHyiKMJPOav/6uv1qoll/oJyO6yI2Pn66aTEwfKLB9V23odCwlBaSvsixP
	 i7yY/h3rFLAag==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F1F4037813A4;
	Fri,  5 Apr 2024 10:32:15 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: tglx@linutronix.de
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
Date: Fri,  5 Apr 2024 12:32:33 +0200
Message-Id: <20240405103233.268999-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <877chc9p4l.ffs@tglx>
References: <877chc9p4l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 4/5/24 10:42, Thomas Gleixner wrote:
> Laura!
> 
> On Fri, Apr 05 2024 at 10:14, Laura Nao wrote:
>> On 4/4/24 22:05, Thomas Gleixner wrote:
>>> Can I get the /proc/cpuinfo output please?
>>
>> Here are more logs from the same device running v6.8:
>> - cpuid -r: https://pastebin.com/raw/YmDrnw06
>> - cpuinfo: https://pastebin.com/raw/Ki0vwdDE
> 
> Thanks for the info. I'm still not seing why that wouldn't work.
> 
> As the machine seems to have a serial port, can you please replace
> 'earlycon' with 'earlyprintk=ttyS0,115200' on the command line and see
> whether that gives some output. I'm not sure that the current 'earlycon'
> has the same effect.
> 

Thanks for the hint - replacing earlycon with earlyprintk=ttyS0,115200 
doesn't seem to help unfortunately, I still get no output at all.

Not sure if it's really relevant to mention, but when booting a v6.8
kernel the first stage bootloader (i.e. coreboot in this case) spits out
a few lines before the kernel takes over:

coreboot-v1.9308_26_0.0.22-6034-gd586c7b122 Wed Jul 15 17:51:44 UTC 2020 smm starting...
SMI# #0
Chrome EC: Set SMI mask to 0x0000000000000000
Chrome EC: UHEPI supported
Clearing pending EC events. Error code 1 is expected.
EC returned error result code 9
Chrome EC: Set SCI mask to 0x00000000142609fb

When booting e.g. next-20240404 not even these lines are reported after
'Starting Kernel...'. Not sure if that suggests anything significant
though.

For the sake of completeness, I'm leaving here links to the full test
jobs run in our Collabora LAVA lab, to include everything that's reported
on the serial console after the device is powered on:
- v6.8 test job: https://lava.collabora.dev/scheduler/job/13265735#L279
- next-20240404 test job w/ 'earlyprintk=ttyS0,115200' in cmdline:
https://lava.collabora.dev/scheduler/job/13266992#L279

I also tried applying the patch you attached above on top of
next-20240404 but it doesn't seem to make any difference unfortunately.

Best,

Laura


