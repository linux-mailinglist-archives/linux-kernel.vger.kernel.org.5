Return-Path: <linux-kernel+bounces-25561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938D582D2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4FB281682
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD9617CF;
	Mon, 15 Jan 2024 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hlwrgbtr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5E15A5;
	Mon, 15 Jan 2024 00:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520D1C433F1;
	Mon, 15 Jan 2024 00:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705277595;
	bh=9d8JNOymYGZ3/p+9qqiDWzbARwPOR0ThFsLa+omTDVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HlwrgbtrQaMjHk6Rl1IBwvE+2sWuIYEn5he/RDz7dSWZhfu/UENTUW929466EuROU
	 ior5hw4k52TxL8Vd87EW5a2iJgmNEZyPJjUeJDXTntdTbsmyE7/SdwiV9EIAoWldtM
	 joQIkSN5rhwPYMbpNAK3l2gctjvZ8darjJfrPCu6ArKul1KdEfX0EljfJHR0GcDq8I
	 uJ5sgUQkwp4kyuYVEfe5WbAbcBCxmlvvQ8OjSovamjWsXmvTtmOD1lEoXGgTETRAHf
	 JWgsmDt9yubJJ1Y8LE/OL8dmm5WIdxR8Lpz2+GgASw13adcD8MlMMS4Jgj7HCSAQDl
	 MmaVWl/5A75dQ==
Message-ID: <b5c9a4d9-894c-4812-8dbf-e623cb1baad2@kernel.org>
Date: Mon, 15 Jan 2024 09:13:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scsi: block: ioprio: Clean up interface definition -
 ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
Content-Language: en-US
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
 Linux Regressions <regressions@lists.linux.dev>,
 lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, chrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <niklas.cassel@wdc.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
References: <CA+G9fYu1hB2OMf0EFrt_86OE=0Ug3y6nQd3=OZeEeM1jp3P92g@mail.gmail.com>
 <11a31e09-2e11-43a4-8995-ae70c5bef8bf@kernel.org>
 <CA+G9fYthC3qsH8ey=j3RvCr4-0zp1S3Ysr5QvY6SptorHpju1g@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CA+G9fYthC3qsH8ey=j3RvCr4-0zp1S3Ysr5QvY6SptorHpju1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/24 16:05, Naresh Kamboju wrote:
> On Fri, 12 Jan 2024 at 10:49, Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 1/12/24 14:15, Naresh Kamboju wrote:
>>> The LTP test 'iopri_set03' fails on all the devices.
>>> It fails on linux kernel >= v6.5. ( on Debian rootfs ).
>>> Test fail confirmed on LTP release 20230929 and 20230516.
>>>
>>> Test failed log:
>>> ------------
>>> tst_test.c:1690: TINFO: LTP version: 20230929
>>> tst_test.c:1574: TINFO: Timeout per run is 0h 05m 00s
>>> ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
>>> ioprio_set03.c:48: TINFO: tested illegal priority with class NONE
>>> ioprio_set03.c:51: TPASS: returned correct error for wrong prio: EINVAL (22)
>>>
>>> Investigation:
>>> ----------
>>> Bisecting this test between kernel v6.4 and v6.5 shows patch
>>> eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
>>> as the first faulty commit.
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> This is fixed in LTP. Please update your LTP setup to avoid this issue.
> 
> Please point me to the fixed commit id.

git log --author="Damien Le Moal"

And of course you need to make sure that you are compiling LTP against the
kernel headers of the target test kernel.


-- 
Damien Le Moal
Western Digital Research


