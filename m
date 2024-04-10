Return-Path: <linux-kernel+bounces-138610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E6389F82C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C961F2668A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9715EFA0;
	Wed, 10 Apr 2024 13:35:32 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF415DBC4;
	Wed, 10 Apr 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756131; cv=none; b=fNT0MHZ09/adnjNc98v6ZsM3XgHCC90GR6a18zLiyTokvi6KoMHjPa93vveYIcO4+3KNsaEOwULYci9nXxTTO11khGAhiAwcQ29glSBeuk/0+MuG7lxnsje/mmcaI/HOkJC27TyuCX11x/gycWgfppsC4ec9djxrH5JzMVTkXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756131; c=relaxed/simple;
	bh=DEngBseA5QdXJf4v5A8FOKLkLRqL3wSCn7bc2Hv/DbU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jO+0FXH25HHd5mKaDCgEQsO8Buetd22xqWObWZwDyfK72s3wShOiE0vJ900YiwplZXWEBsmCQyBhAZJsAO1sxkamms73eg8hxHbrkVfmeCS6IEfk4J6NLNwaZrIbB5YTfP85a+l3AGAKFC9khlHLyizP9N0h92Ql/DDIcEXkhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VF3gw6K6yz6K64Y;
	Wed, 10 Apr 2024 21:33:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B906F1400CA;
	Wed, 10 Apr 2024 21:35:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 14:35:26 +0100
Date: Wed, 10 Apr 2024 14:35:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Miguel Luis <miguel.luis@oracle.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 0/4] ACPI: processor: refactor
 acpi_processor_{get_info|remove}
Message-ID: <20240410143525.0000620a@Huawei.com>
In-Reply-To: <20240409150536.9933-1-miguel.luis@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  9 Apr 2024 15:05:29 +0000
Miguel Luis <miguel.luis@oracle.com> wrote:

> Both acpi_processor_get_info and acpi_processor_remove functions have
> architecture dependent functionality enabled via CONFIG_ACPI_HOTPLUG_CPU.
> 
> Current pre-processor guards are restricting too much of functionality which
> makes it dificult to integrate other features such as Virtual CPU
> hotplug/unplug for arm64.
> 
> This series, applied on top of v6.9-rc3, suggests a refactoring on these two
> functions with the intent to understand them better and hopefully ease
> integration of more functionality.
> 
> Apart from patches 2/4 and 3/4, which could be squashed but left them separated
> intentionally so it would ease reviewing, changes are self-contained.
> 
> So far I've boot tested it successfully alone and as a prefix for vCPU hotplug/unplug
> patches [1], on arm64.

Hi Miguel,

Great to see an attempt to keep this moving. My apologies that I've been rather
quiet on this so far this cycle - a few things came up that ended up more urgent :(

In the thread you link there was a discussion on whether to stub out these functions
as a possible way forwards. I did some analysis of what was going on in 

https://lore.kernel.org/linux-arm-kernel/20240322185327.00002416@Huawei.com/

and my conclusion was that to do so would mostly be misleading.
The flows for make present and make enabled are and should be different
(though not as different as they were in v4!)

Jonathan

> 
> [1]: https://lore.kernel.org/linux-arm-kernel/Zbp5xzmFhKDAgHws@shell.armlinux.org.uk/
> 
> Miguel Luis (4):
>   ACPI: processor: refactor acpi_processor_get_info: evaluation of
>     processor declaration
>   ACPI: processor: refactor acpi_processor_get_info: isolate cpu hotpug
>     init delay
>   ACPI: processor: refactor acpi_processor_get_info: isolate
>     acpi_{map|unmap}_cpu under CONFIG_ACPI_HOTPLUG_CPU
>   ACPI: processor: refactor acpi_processor_remove: isolate
>     acpi_unmap_cpu under CONFIG_ACPI_HOTPLUG_CPU
> 
>  drivers/acpi/acpi_processor.c | 138 ++++++++++++++++++++++------------
>  1 file changed, 91 insertions(+), 47 deletions(-)
> 
> --
> 2.43.0
> 


