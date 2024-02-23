Return-Path: <linux-kernel+bounces-79237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3070861F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BE2286060
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C11414CAC4;
	Fri, 23 Feb 2024 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ty/7+bV4"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A5B142648
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726081; cv=none; b=uAQjnbrsTfGRYZHHJ0HOZ7NjemLuR72DPioF+oS9Vj54Nk8N15wv1DIFuH3fCsAurTJsfr3qlSt47HTHyEmc34g264bdqzvg9EYIn8qCG+Wk1Z1qQXCsE76YmaduPRQ1jESd/A9xuwMFMzXgdQnJh2kabuVr0qbu6pOkvavAWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726081; c=relaxed/simple;
	bh=XCkxVjJN6TdCgPtRmewiRi7q1bmPB9dwiCi4ta9RI58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPxhvswvQEzQV1qcFS/WbohJOS8JkfcfO8BKtylcLUOP+Fu1WTA330EQ9ysyTeZWVF1TF52bjlYEJI4MgqjyZZ+d/l021RUP7aBAtWEIXuf1f7GWFgMYXJae+L+EOMWuTvAyix3oFhkehIzWEiNgVAOCfrJZf+2tx8S53W1GETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ty/7+bV4; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso23244139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708726079; x=1709330879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1fdAI0DrY4+cZupo08XTufNQuBtOKpu0rrwHi//EJSU=;
        b=Ty/7+bV4BtT8sPZXsU1Hx88Mk9as271jwVWwQ4kRzfrPttCAFsOb3Lr/mTqo/HBIsh
         xpMVrTilUaw5ZhpOWJNvdTSqxxq7AnuSKjll561YXzkWicph9jiuKA3qtiLT269X7Tms
         S/A4EHKjmZGgAGEufKgSlaMK9Tm97xXl092kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726079; x=1709330879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fdAI0DrY4+cZupo08XTufNQuBtOKpu0rrwHi//EJSU=;
        b=WrfSEhiFr4h2T3jNBODfOJN8PvRmMJlFsKE9GrzZHIzQIxrp8Io0jvHH3b6gYUddYL
         5mAr9JoDxaeJ2dHtStdl0JMFMftGviSTQwhqd3TKXeE0VjG7cOlM4FaSH30FMlGYCNKK
         wL1s0N7hdEvYFOKMOV9d6AIUS1iHOaY0wu6QvWk4VMLGkQCFQiH1CmnHof6+IZ8850qq
         lXT+tawbGrBzovz3xgcXJrdh1AF5TYXj2VzqTRSOWyKFUOvNpvxfbPB5EcCQd0RypYVS
         EVZQ6y3rlRiYJMZbVG4pjc0VYf2hz1OghAUSONpaVhhSxaT7d+F0r+BzEgaZ7q5AN5an
         BZvg==
X-Forwarded-Encrypted: i=1; AJvYcCWmnjTwV6OAwsdMuQ8Cp7YgorW+sodSPdPW8APsQJimh8sTDwM76tmKqYvNkTRfjQ9x1KVfmvPsB+1tTisqSC4nOZ94+mWog+y8UR5h
X-Gm-Message-State: AOJu0YxUqIGJmvdlKM9YhRxuNrGDUBx3OfzCGq++x4kkDwbKQxd3q7CH
	VVPnoSonnPGcp9id6euwKK8Wc9RCVu9dN5FoH/Phmk6dThFHlKqilaxlct1mXQ4=
X-Google-Smtp-Source: AGHT+IHiKVcuqSVcuMUfgbyF+Cd49SlDxNt5CwWlzj2tF4SXuMug78NaNUTvJkUOoYewqfd+aR+MXA==
X-Received: by 2002:a6b:6501:0:b0:7c7:7f73:d1a with SMTP id z1-20020a6b6501000000b007c77f730d1amr1276130iob.1.1708726078903;
        Fri, 23 Feb 2024 14:07:58 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id j3-20020a05663822c300b00472f79e0001sm3950166jat.171.2024.02.23.14.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:07:58 -0800 (PST)
Message-ID: <bfec40fc-8152-4f5e-84c4-926312014322@linuxfoundation.org>
Date: Fri, 23 Feb 2024 15:07:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
 Yujie Liu <yujie.liu@intel.com>
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240222020456.28532-1-mpdesouza@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240222020456.28532-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 19:04, Marcos Paulo de Souza wrote:
> On Thu, 22 Feb 2024 09:28:19 +0800 Yujie Liu <yujie.liu@intel.com> wrote:
> 
>> On Wed, Feb 21, 2024 at 07:04:03PM -0300, Marcos Paulo de Souza wrote:
>>> On Wed, 21 Feb 2024 14:12:00 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>>> On 2/21/24 05:26, Marcos Paulo de Souza wrote:
>>>>> On Tue, 20 Feb 2024 17:19:54 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>
>>>>>> On 2/19/24 06:53, Marcos Paulo de Souza wrote:
>>>>>>> On Mon, 19 Feb 2024 09:15:15 -0300 Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
>>>>>>>
>>>>>>>> On Mon, 19 Feb 2024 14:35:16 +0800 kernel test robot <lkp@intel.com> wrote:
>>>>>>>>
>>>>>>>>> Hi Marcos,
>>>>>>>>>
>>>>>>>>> kernel test robot noticed the following build errors:
>>>>>>>>>
>>>>>>>>> [auto build test ERROR on 345e8abe4c355bc24bab3f4a5634122e55be8665]
>>>>>>>>>
>>>>>>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
>>>>>>>>> base:   345e8abe4c355bc24bab3f4a5634122e55be8665
>>>>>>>>> patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc%40suse.com
>>>>>>>>> patch subject: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
>>>>>>>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>>>>>>>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191417.XULH88Ct-lkp@intel.com/reproduce)
>>>>>>>>>
>>>>>>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>>>>>>> the same patch/commit), kindly add following tags
>>>>>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>>>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402191417.XULH88Ct-lkp@intel.com/
>>>>>>>>>
>>>>>>>>> All errors (new ones prefixed by >>):
>>>>>>>>>
>>>>>>>>>>> make[3]: *** /lib/modules/5.9.0-2-amd64/build: No such file or directory.  Stop.
>>>>>>>>
>>>>>>>> We should ask the kernel test robot machine owners to install kernel-devel
>>>>>>>> package in order to have this fixed.
>>>>>>>
>>>>>>> Or maybe ask them to change the reproducer to specify KDIR to the git tree,
>>>>>>> instead of /lib/modules/?
>>>>>>>
>>>>>>
>>>>>> This would be a regression to automated test rings. Do you have any other
>>>>>> solutions?
>>>>>
>>>>> I would say that we could skip the these tests if kernel-devel package is not
>>>>> installed. Would it be acceptable? At least we would avoid such issues like this
>>>>> in the future as well.
>>>>>
>>>>
>>>> We have to check and skip build. Something we could do in the livepatch
>>>> Makefile. Can you send patch for this - I will oull this in for next
>>>> so we don't break test rings.
>>>
>>> I added a new patch in the same patchset that would cover this, skipping the
>>> build and test if kernel-devel is not installed. The patchset was sent earlier
>>> today. Please check if the new patch fixes things on the build robot.
>>
>> Hi Shuah, Hi Marcos,
>>
>> Sorry for this wrong report. The files are organized in a different way
>> in the bot and cause this issue. We have fixed the bot to explicitly
>> set KDIR to the correct path before building the selftests. The patch
>> [1] can also work well in bot's environment.
>>
>> [1] https://lore.kernel.org/all/20240221-lp-selftests-fixes-v2-2-a19be1e029a7@suse.com/
> 
> Hi Yujie, thanks for letting us know that the bot had different settings. Either
> way the patch you mentioned should help to reduce noise in the future on
> bot's that doesn't have kernel-devel installed.
> 

Marcos, If you send me the patch, I will apply it to linux-kselftest next.
> Again, thanks a lot for fixing the issue!
>    Marcos
> 

Thank you Yujie

thanks,
--- Shuah


