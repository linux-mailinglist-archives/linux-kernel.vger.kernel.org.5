Return-Path: <linux-kernel+bounces-75501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9585E9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C552F1F22938
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4F51272A9;
	Wed, 21 Feb 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ItdJFygh"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088A126F21
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549925; cv=none; b=BoE0dOfA2CPeB6RusovVM8Ae3zmyzA8t8dXhiDMhTEZDOn/OCREWlG2d5GniqPtpGA9tmJEstsPcuNG/aWUH7UrufRIE/uAl040MCg+jNeGPPw5SzLTRY3zrjsxqCOAZNUrVGF0bSpv+NHNBYwBRz5hDLICteTyXPne9QtRJk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549925; c=relaxed/simple;
	bh=eCAZYluSAU2RBM3yi8viKMCds9GjEA+ZqgAym0tc/HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMU/HwSxLp4uqOB/f1Km42z5j0KsTfIY4eldyg9HPGLbh0N6g8cgBH/+jW5CI5mXOEEHk8hz9HNlaQb1iPFNxJ6uQZMGayAxCKwznAAdScfmZrTI/bEW7p/DcX9G5Prv0KRukxMUYuXE0ZG33a4DJyEFl5HNXOAzsoQUj9O8a3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ItdJFygh; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c3d923f7cbso69827739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708549921; x=1709154721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmnwSrST3rdrwZH7tVh8fU2y439F+I4SPNnc2rPJRm4=;
        b=ItdJFygh+FybiLD/BTfbC2qLS6bc8gnbUww0rf5LlXeVXHCIZYu4JznYcBpUr2BO9s
         BA435dNt2I6i2nkbg5BtB0NqSCMevpFA2C25Nu133+CzuvltRTmAGN2lvnp7BPR3viBm
         O3iquGYhKF3KUngR7XUbo/V7VzBTGaIJqKaHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549921; x=1709154721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmnwSrST3rdrwZH7tVh8fU2y439F+I4SPNnc2rPJRm4=;
        b=UGVzbE/DQrfHxAHrZk9ZG4be3U7WiNRjsv8hVEsFxcVTcqWzquQcYnGjMyas7ZGhjv
         rKAolC31Inq4Jdm6FN3bAP9667OFsPrW6ZoFZlJzDydGmFp8GSpSCe/c7jhFxPLcrR8U
         s0xQ4KPM8uFWmSQfXpa9DiMSC86oixgp545Ql/au50nl5t/M09yfk+UKNAeQS50RIcVT
         D8zbxY880a6dRQfPRA3XHnqWCDubLVlJTQXzFnjZXExYmC0yukOeJIz32Fo1b52eUJya
         Mwhw/61K+I7kgliAc3yfKMn1N7B2y2yhuHuSclgEw/Yzm1Crh3wQt8VgXphKfpciq22s
         zp5g==
X-Forwarded-Encrypted: i=1; AJvYcCUsHBDNlsT7jp1/tHGWIgxBKEFmdoxioYFgCge2I8OgvyYCHwBlv/ubmZtofFFCUOyYsfIlxwmCJiYjP0+verzq2PGUa25XKJCzzy57
X-Gm-Message-State: AOJu0Yw6rK0CNxfzU8EtS3Z5YDqPvJ7rOVZADZPQKoDp5E/UavPIYu0O
	qbfmxFv2B9Z3jf0BTgtFng+bQnbrI9nBS+z34sN5b/bsB9RXqbms2cKVspZSTww=
X-Google-Smtp-Source: AGHT+IEKAg+nZ32ayi2M4M5a60R13l5jKMcKbJmjVQV6UGaoe7QNiELpd3CjkGf9tzTBuiDTkMd6Kg==
X-Received: by 2002:a05:6602:2545:b0:7c4:c985:145a with SMTP id cg5-20020a056602254500b007c4c985145amr478044iob.2.1708549921301;
        Wed, 21 Feb 2024 13:12:01 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ay23-20020a056638411700b0047437765adcsm1200095jab.81.2024.02.21.13.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 13:12:00 -0800 (PST)
Message-ID: <d984977f-b7ad-44b9-82dd-27aeb2fad592@linuxfoundation.org>
Date: Wed, 21 Feb 2024 14:12:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240221122624.30549-1-mpdesouza@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240221122624.30549-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 05:26, Marcos Paulo de Souza wrote:
> On Tue, 20 Feb 2024 17:19:54 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 2/19/24 06:53, Marcos Paulo de Souza wrote:
>>> On Mon, 19 Feb 2024 09:15:15 -0300 Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
>>>
>>>> On Mon, 19 Feb 2024 14:35:16 +0800 kernel test robot <lkp@intel.com> wrote:
>>>>
>>>>> Hi Marcos,
>>>>>
>>>>> kernel test robot noticed the following build errors:
>>>>>
>>>>> [auto build test ERROR on 345e8abe4c355bc24bab3f4a5634122e55be8665]
>>>>>
>>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
>>>>> base:   345e8abe4c355bc24bab3f4a5634122e55be8665
>>>>> patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc%40suse.com
>>>>> patch subject: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
>>>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>>>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191417.XULH88Ct-lkp@intel.com/reproduce)
>>>>>
>>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>>> the same patch/commit), kindly add following tags
>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402191417.XULH88Ct-lkp@intel.com/
>>>>>
>>>>> All errors (new ones prefixed by >>):
>>>>>
>>>>>>> make[3]: *** /lib/modules/5.9.0-2-amd64/build: No such file or directory.  Stop.
>>>>
>>>> We should ask the kernel test robot machine owners to install kernel-devel
>>>> package in order to have this fixed.
>>>
>>> Or maybe ask them to change the reproducer to specify KDIR to the git tree,
>>> instead of /lib/modules/?
>>>
>>
>> This would be a regression to automated test rings. Do you have any other
>> solutions?
> 
> I would say that we could skip the these tests if kernel-devel package is not
> installed. Would it be acceptable? At least we would avoid such issues like this
> in the future as well.
> 

We have to check and skip build. Something we could do in the livepatch
Makefile. Can you send patch for this - I will oull this in for next
so we don't break test rings.

thanks,
-- Shuah

