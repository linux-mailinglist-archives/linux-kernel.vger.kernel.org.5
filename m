Return-Path: <linux-kernel+bounces-38687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E218D83C41A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C439297418
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DB15B21C;
	Thu, 25 Jan 2024 13:50:14 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7A95B1FE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190614; cv=none; b=d9oBPZBmboYfoFkdcCTOgn9INalDZ/woiFySh5C1mLm7j3oaNP2YdhvRrFb/sNsc5/LGYSL+V7u0wboslAes3vWfxEBLm0ouT94mcZLt6W3GDNbJKU1cSNtLyFfrtSTz9UJx5sPpdRl33EoaicyG6aTpFW1ZnU5SCA+8lO1swjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190614; c=relaxed/simple;
	bh=5ZOPXDAbVb3JfPcHPZt/6K1rMwGtKeHJlzvDwGJqlN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0LpNAIvbxEBOPIQOLIquQEnPKTS+oiqirKcOjG9fj1YxisJH4XOeNbuMGalqzljxyYsD/UDtKh347DiKeWulo8Y6Jx57jbIlN1k6906v6z0YyWS6kRndTCgGyBVgWC+V+7FcOPOhCPz4AjGT2KH7isjXfmSu9MNCmivyyr24dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TLMdN3cwmzbcCh;
	Thu, 25 Jan 2024 21:49:44 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 158EB18007A;
	Thu, 25 Jan 2024 21:50:08 +0800 (CST)
Received: from huawei.com (10.67.174.76) by dggpemd100004.china.huawei.com
 (7.185.36.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Thu, 25 Jan
 2024 21:50:07 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <will@kernel.org>
CC: <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] arm64: enable dead code elimination
Date: Thu, 25 Jan 2024 13:45:32 +0000
Message-ID: <20240125134532.3717157-1-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717092439.GB7868@willie-the-truck>
References: <20230717092439.GB7868@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd100004.china.huawei.com (7.185.36.20)

On 2023/7/17 17:24, Will Deacon wrote:
> On Mon, Jul 17, 2023 at 04:07:39PM +0800, Kefeng Wang wrote:
>> Select CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION for arm64, allowing the
>> user to enable dead code elimination. In order for this to work, ensure
>> that we keep the necessary tables by annotating them with KEEP, also it
>> requires further changes to linker script to KEEP some tables and wildcard
>> compiler generated sections into the right place.
>>
>> The following comparison is based 6.5-rc2 with defconfig,
>>
>> $ ./scripts/bloat-o-meter vmlinux-base vmlinux-new
>> add/remove: 3/1106 grow/shrink: 4102/6964 up/down: 35704/-99980 (-64276)
>> Function                                     old     new   delta
>> ...
>> Total: Before=17888959, After=17824683, chg -0.36%
>>
>> add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-44 (-44)
>> Data                                         old     new   delta
>> ...
>> Total: Before=4820808, After=4820764, chg -0.00%
>>
>> add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-1096 (-1096)
>> RO Data                                      old     new   delta
>> ...
>> Total: Before=5179123, After=5178027, chg -0.02%
>>
>> $ size vmlinux-base vmlinux
>>     text	   data	     bss      dec       hex	filename
>> 25433734  15385766  630656  41450156  2787aac	vmlinux-base
>> 24756738  15360870  629888  40747496  26dc1e8	vmlinux-new
>>
>> Memory available after booting, saving 704k on qemu,
>> base: 8084532K/8388608K
>> new:  8085236K/8388608K
> 
> Is that a 0.009% improvement? Is it really worth the hassle?
> 
> x86 doesn't select this and risc-v had to turn it off for LLD, so it feels
> like we're just creating a rod for our own back by selecting it.

I tested this patch and found that, the smaller the config file,the more 
significant the reduction in file size of the builds. This may be useful
in scenarios such as embedded systems where size is particularly critical.

Just like Select CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION for RISC-V,
this boots well on qemu, with defconfig, it shrinks their builds by ~1.6%,
and with tinyconfig it shrinks their builds by ~18.7%.

defconfig:
    text        data       bss         dec        hex
26839348    16695234    629456    44164038    2a1e3c6    before
26140556    16667058    628880    43436494    296c9ce    after

tinyconfig:
    text        data       bss         dec        hex
 1259568      272100    104312     1635980     18f68c    before
  967056      258716    103824     1329596     1449bc    after

          | tinyconfig             | defconfig
  --------|------------------------|---------------------
   No DCE | 1635980                | 44164038
      DCE | 1329596                | 43436494
   Shrink |  306384 (~18.7%)       |   727544 (~1.6%)

> 
> Will
> 

