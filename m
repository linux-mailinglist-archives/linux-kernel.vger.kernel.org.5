Return-Path: <linux-kernel+bounces-31994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA738835507
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642011F21766
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 09:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17040364BB;
	Sun, 21 Jan 2024 09:42:47 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FF722086;
	Sun, 21 Jan 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705830166; cv=none; b=dkhOiQt0y+IZJvE2ngAt5TLDl5Ams8GhAC0hijxKXI+yU6Uya/X9UTHj/yK9cvd8vi8WEysUYLT2XjvkRk03w2+VmbO3SzHA/R/a9EhzZHZQRbpSa12emo4PkwAs7k4ElZn/2M5QEXeq+X55G6TXa56/O+ab2nzrjQjw/ERoQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705830166; c=relaxed/simple;
	bh=vXMxtbaRXwShp5WwQRmQyAEkRNo7Eo0/Wr29nZuBn8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFfzCheXdFNey16v6BXSG5VhAOoyt2nCvu8BCUV/pkme4UuRD/TM6Q+ctOq1fCnn+ssT8wmvNLkjpTCe4joBg8aa2HdhtXCJlbqZSds5Ee0ATQ00QlUcfDEZlxyOKzQ2eXbmqzWfKSv0QFCiyNVd8JPqw8dl9iHLHOqOeqOQqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rRULZ-00050W-CV; Sun, 21 Jan 2024 10:42:33 +0100
Message-ID: <4c69cb61-1a43-4bfe-b01a-8118967ddbaf@leemhuis.info>
Date: Sun, 21 Jan 2024 10:42:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/10] spi: Add multi-cs memories support in SPI core
Content-Language: en-US, de-DE
To: Guenter Roeck <linux@roeck-us.net>,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: alexandre.belloni@bootlin.com, vigneshr@ti.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com, git@amd.com,
 sbinding@opensource.cirrus.com, richard@nod.at, lee@kernel.org,
 tudor.ambarus@linaro.org, amitrkcian2002@gmail.com,
 linux-sound@vger.kernel.org, james.schulman@cirrus.com,
 rf@opensource.cirrus.com, broonie@kernel.org, tiwai@suse.com,
 perex@perex.cz, michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
 patches@opensource.cirrus.com, claudiu.beznea@tuxon.dev,
 linux-spi@vger.kernel.org, michael@walle.cc, david.rhodes@cirrus.com,
 pratyush@kernel.org
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-4-amit.kumar-mahapatra@amd.com>
 <3d3a11b1-8396-4d8e-9bb3-61ecb67e7efa@roeck-us.net>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3d3a11b1-8396-4d8e-9bb3-61ecb67e7efa@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705830164;909fc623;
X-HE-SMSGID: 1rRULZ-00050W-CV

On 12.01.24 20:11, Guenter Roeck wrote:
> 
> On Sat, Nov 25, 2023 at 02:51:30PM +0530, Amit Kumar Mahapatra wrote:
>> AMD-Xilinx GQSPI controller has two advanced mode that allows the
>> controller to consider two flashes as one single device.
>>
>> One of these two mode is the parallel mode in which each byte of data is
>> stored in both devices, the even bits in the lower flash & the odd bits in
>> the upper flash. The byte split is automatically handled by the QSPI
>> controller.
> [...]
> With this patch in the mainline kernel, two of my qemu emulations
> (quanta-q71l-bmc and almetto-bmc) fail to instantiate the first SPI
> controller and thus fail to boot from SPI. The error message is
> 
> [    3.006458] spi_master spi0: No. of CS is more than max. no. of supported CS
> [    3.006775] spi_master spi0: Failed to create SPI device for /ahb/spi@1e620000/flash@0
> 
> The problem is no longer seen after reverting this patch.
> [...]
> # first bad commit: [4d8ff6b0991d5e86b17b235fc46ec62e9195cb9b] spi: Add multi-cs memories support in SPI core

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 4d8ff6b0991d5e86b17b235fc46ec62e9195cb9
#regzbot title spi: qemu emulations quanta-q71l-bmc and almetto-bmc fail
to boot
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

