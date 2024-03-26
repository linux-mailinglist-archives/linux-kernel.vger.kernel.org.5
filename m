Return-Path: <linux-kernel+bounces-119294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F3088C6BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E0E1C38BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8C613C829;
	Tue, 26 Mar 2024 15:21:44 +0000 (UTC)
Received: from out187-3.us.a.mail.aliyun.com (out187-3.us.a.mail.aliyun.com [47.90.187.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569F13C80C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466504; cv=none; b=W63h6Omw3ybjnU106+BbSasghG1V5IBfd5QYF6O8ncolGLT1d04uVPfNwGgM50BKSEaRXNGiDPxsHpm6EQaPMmDcr1IaLiYUM/ObXWsU3iOB/6scLAizx/UfmhmLAPvp47Pabb4Obts8NSP46DHjKaFho6t70aVYwlZhquCoc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466504; c=relaxed/simple;
	bh=RBJWy2SJKU6/GADnLFnZWtTcwgKY+B+hJ0glm2ITsLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKG5+4yevQ5GZd6yVjhU5EWOn9OadRqdsS3Y/B2wTVKcj/577gQVIRhjYaOWQZLEKv3jMATxYK+iGXGzW4iVykBZdQHg2wcz4DVWyn3WkpLi21ATND0d17/KAqIN5ED8PMvWVjHOGJDZWgiaSBUeIetftPr8ccS21F7FtyfjZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=47.90.187.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.WwaCo0e_1711465550;
Received: from 30.39.128.129(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WwaCo0e_1711465550)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 23:05:51 +0800
Message-ID: <28a3e497-87b7-42ab-8724-2c49594bb4a5@antgroup.com>
Date: Tue, 26 Mar 2024 23:05:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] um: Fix -Wmissing-prototypes warnings for
 text_poke*
Content-Language: en-US
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, jani.nikula@intel.com,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
 <20240306101925.1088870-9-tiwei.btw@antgroup.com>
 <tvkjne4liqm3xx64jtkvqhlvvkwmiwlavif7gdh47xlzeltyp5@ymlqsvkdbppr>
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <tvkjne4liqm3xx64jtkvqhlvvkwmiwlavif7gdh47xlzeltyp5@ymlqsvkdbppr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/26/24 10:13 PM, Lucas De Marchi wrote:
> On Wed, Mar 06, 2024 at 06:19:24PM +0800, Tiwei Bie wrote:
>> The prototypes for text_poke* are declared in asm/text-patching.h
>> under arch/x86/include/. It's safe to include this header, as it's
>> UML-aware (by checking CONFIG_UML_X86).
> 
> but would it work when building on something other than x86? Or is that
> not a thing?

I think it doesn't matter, because uml is x86 only (i.e. uml only supports
x86 currently). And that's how uml works currently. I described the specific
header file to be included in the commit log just to make the changes easier
to review.

PS. The header is included via below search path set in arch/um/Makefile:

HEADER_ARCH     := $(SUBARCH)

ifneq ($(filter $(SUBARCH),x86 x86_64 i386),)
        HEADER_ARCH := x86 
endif
.....
HOST_DIR := arch/$(HEADER_ARCH)
.....
KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/include \
                   -I$(srctree)/$(HOST_DIR)/include/uapi \
                   -I$(objtree)/$(HOST_DIR)/include/generated \
                   -I$(objtree)/$(HOST_DIR)/include/generated/uapi

Regards,
Tiwei

> 
> Lucas De Marchi
> 
>>
>> This will address below -Wmissing-prototypes warnings:
>>
>> arch/um/kernel/um_arch.c:461:7: warning: no previous prototype for ‘text_poke’ [-Wmissing-prototypes]
>> arch/um/kernel/um_arch.c:473:6: warning: no previous prototype for ‘text_poke_sync’ [-Wmissing-prototypes]
>>
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>> ---
>> arch/um/kernel/um_arch.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
>> index 7a9820797eae..e95f805e5004 100644
>> --- a/arch/um/kernel/um_arch.c
>> +++ b/arch/um/kernel/um_arch.c
>> @@ -23,6 +23,7 @@
>> #include <asm/cpufeature.h>
>> #include <asm/sections.h>
>> #include <asm/setup.h>
>> +#include <asm/text-patching.h>
>> #include <as-layout.h>
>> #include <arch.h>
>> #include <init.h>
>> -- 
>> 2.34.1
>>


