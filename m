Return-Path: <linux-kernel+bounces-97784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875E0876F5E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D842821DA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E951A364DC;
	Sat,  9 Mar 2024 06:15:02 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E116423
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709964902; cv=none; b=g141RXnMZKDacKEEIEtLrcJPrm9kQE8hGlS4WwFwioqBWKKQOyH+i35REW8bwZEsmMhrUs9TNxVS5YCsL/WBdMGVxGnK+OIP+Aoc+yjVlW9CdJhY5+Z9aL7lawKxUt4XlIT6qftL7cLc6s0YTwPuAnnNGOz8nLu4dYw6IKe9Qow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709964902; c=relaxed/simple;
	bh=pRDbbMiFpecWIYDj1/yyHTleUCERTy6qkobkci/nWJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gAIc7iUeQqwyapaSGB5AcAV1cIgylVa+XN/vJAyU3OMCk10YwJxlgta6CK+9dToeqKGA5GnBhLrDIAXKlum0azByOKE0vGbQT7uaJt/ZnJ4BpGvYFExzmEPMKFQY4J4ReEMQJqC7TWZCMXD3IK543G+pTxp+7SKH+LhiZVhUmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TsCPV5b0FzXhh0;
	Sat,  9 Mar 2024 14:12:30 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F793140121;
	Sat,  9 Mar 2024 14:14:50 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 9 Mar 2024 14:14:50 +0800
Message-ID: <42892794-7668-4eb0-8d2f-c78ca0daf370@huawei.com>
Date: Sat, 9 Mar 2024 14:14:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v2] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Fangrui
 Song <maskray@google.com>
CC: Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>, Andrew
 Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, Mike Rapoport
	<rppt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
	<llvm@lists.linux.dev>
References: <20240307151231.654025-1-liuyuntao12@huawei.com>
 <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/3/8 21:15, Arnd Bergmann wrote:
> On Thu, Mar 7, 2024, at 16:12, Yuntao Liu wrote:
>> The current arm32 architecture does not yet support the
>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
>> embedded scenarios, and enabling this feature would be beneficial for
>> reducing the size of the kernel image.
>>
>> In order to make this work, we keep the necessary tables by annotating
>> them with KEEP, also it requires further changes to linker script to KEEP
>> some tables and wildcard compiler generated sections into the right place.
>>
>> It boots normally with defconfig, vexpress_defconfig and tinyconfig.
>>
>> The size comparison of zImage is as follows:
>> defconfig       vexpress_defconfig      tinyconfig
>> 5137712         5138024                 424192          no dce
>> 5032560         4997824                 298384          dce
>> 2.0%            2.7%                    29.7%           shrink
>>
>> When using smaller config file, there is a significant reduction in the
>> size of the zImage.
>>
>> We also tested this patch on a commercially available single-board
>> computer, and the comparison is as follows:
>> a15eb_config
>> 2161384         no dce
>> 2092240         dce
>> 3.2%            shrink
>>
>> The zImage size has been reduced by approximately 3.2%, which is 70KB on
>> 2.1M.
>>
>> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> 
> I've retested with both gcc-13 and clang-18, and so no
> more build issues. Your previous version already worked
> fine for me.
> 
> I did some tests combining this with CONFIG_TRIM_UNUSED_KSYMS,
> which showed a significant improvement as expected. I also
> tried combining it with an experimental CONFIG_LTO_CLANG
> patch, but that did not show any further improvements.
> 

Thanks for the tests, CONFIG_LD_DEAD_CODE_DATA_ELIMINATION and 
CONFIG_TRIM_UNUSED_KSYMS do indeed result in a significant improvement.
I found that arm32 still doesn't support CONFIG_LTO_CLANG. I've done 
some work on it, but without success. I'd like to learn more about the 
CONFIG_LTO_CLANG patch. Do you have any relevant links?

