Return-Path: <linux-kernel+bounces-84259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88D086A446
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E634A1C22E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEF337A;
	Wed, 28 Feb 2024 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iLeIWnjq"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656F15AF
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078938; cv=none; b=nqDD1XhFjz8LacistUC1U89NlqDlephz/dMb0lNMoF81WaG8oPcCcBlMioLTf2sDWBtgdFqE2iFgETNpHte1thAQ7SXM68XAq49vEXF1JwsuShfDaeUBqzEcXmmpqtj55vfixci7todFQQqiZl1ntSXoA7a9eXC97Jc7Knlydd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078938; c=relaxed/simple;
	bh=nTsK9p1jokxVeO3Fo4MQIH5ecfakK/v2VWS6ZWRauNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4RmXhDz0bUy8yN68Kv/ZMzjOo9gzmfEqJ8+jqenDFbcAT9eIsVmRjYF90lwXZQSrZ6PrChybHrMUlpzs86Q26GbgwTH38R0XFR7MtAHEWhKNHsGYJCFxFda87n2lZKJHKEmYMhGb6SAdNurQBgR7yMJhkOLI4BR3SMcbr8OF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iLeIWnjq; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-365b413549eso957345ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709078936; x=1709683736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cq739qr1rsr2NonXQJuyDZ18sirm7FbjHPegYfq2M0w=;
        b=iLeIWnjqSGm0LFXCaE04SK1RaEvsmz8Lcto/E1KGOxArhel2d5MtJS+LT/QApErkpY
         y0Rhe/lzfD102AudZok9CuUBfbb/59geJnUM3uQ8hTtBSwqSDWxjZcQaz5Sq8Z5qGmnf
         ir7pY94wwLzKBWYOrcf4jSIHsLmeCcRlFiiko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709078936; x=1709683736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cq739qr1rsr2NonXQJuyDZ18sirm7FbjHPegYfq2M0w=;
        b=r9kjCLZ9Y4v+0ALGBYVLt+/dGx3Sp8Qovr1JplEw+Dd0liAtg1ChiGs3madXETPPcY
         sRZbmiaD+xLeehWLbkB8hzUHJ8lsv1R1jvZ8i5tsZnbyRQ9+B42MKqLax8lEqlhyNQCK
         LyY1nD5nT8JBfNX8I+Wb6Tc87Gu5WShllMpXhZ9zh/O9GD6Ft5wpaRrQnxRzmU8n8Ums
         2NfGAApEPEq8M3EqsohOQmRh7/m2rEcQTZ0atWtCuHxT1LOOT2lGX2ALsuQ3TcwiEtCD
         gks1bm4Z1DHJA/IMlF0MeA62EYQfgl6jweu0HOyNW/Fit47zmDscW2jRDP4XDAm9oCtO
         zppg==
X-Forwarded-Encrypted: i=1; AJvYcCWpFsjSKKbSV7lMpaKlQ0gwQ98WzgjzflkxnGIlwO8w7/1JRBjkPWD9nEJUYK1KxY3rrP1zzrFfn31C6OC4BjmXo5u6Vlf5hwtwSmc8
X-Gm-Message-State: AOJu0YygKr15Us7ZZvljfv3KLEy2TAaGWKXeZIgE5Ftjd+0irMZTnQxJ
	nloMKX0kwORZMrBDnWgGnYxYYKDWQDpOSKdranKchV+j462UeC39fw2vHJSVJLY=
X-Google-Smtp-Source: AGHT+IHhurMRim1oZpaRa/EmwIjRlUocpRTaLd+78t+2y/ZxHBYDwHmgfe1pto6RyieYWCbjx43vvw==
X-Received: by 2002:a05:6e02:1d98:b0:365:2f19:e58e with SMTP id h24-20020a056e021d9800b003652f19e58emr11475957ila.3.1709078935853;
        Tue, 27 Feb 2024 16:08:55 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id x14-20020a056e020f0e00b00364b66eb5e3sm2427560ilj.24.2024.02.27.16.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 16:08:55 -0800 (PST)
Message-ID: <987a671f-bacf-4c44-a48d-97ab74397628@linuxfoundation.org>
Date: Tue, 27 Feb 2024 17:08:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] selftests/resctrl: Add non-contiguous CBMs in
 Intel CAT selftest
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
 fenghua.yu@intel.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
 <f8886683-4f24-47ce-a0c6-ef28466bfec9@intel.com>
 <685828ed-06d2-4a2c-9911-05145e55ea1a@linuxfoundation.org>
 <48dab897-162d-4075-baa9-f5391a23d31d@intel.com>
 <a8f1f104-c5c1-400c-873e-99b01cde1d88@linuxfoundation.org>
 <beuizmgezzcnd3f74nsmigfn7n5emj43pxaqtyki7bjgj4nqn5@ldpqu65vaunu>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <beuizmgezzcnd3f74nsmigfn7n5emj43pxaqtyki7bjgj4nqn5@ldpqu65vaunu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/24 02:28, Maciej Wieczor-Retman wrote:
> Hi Shuah,
> 
> On 2024-02-23 at 15:37:11 -0700, Shuah Khan wrote:
>>
>> Hi Reinette,
>>
>> Okay ran a quick test. Why does this test leave "/sys/fs/resctrl"
>> mounted when it exits. Can we fix this to unmount before the test
>> exits?
> 
> I also wasn't able to reproduce this unmounting issue:
> - with unmounted resctrl before test:
> 
> 	[/root]# ls /sys/fs/resctrl/
> 	[/root]#
> 	[/root]# ./resctrl_tests -t L3_NONCONT_CAT
> 	TAP version 13
> 	# Pass: Check kernel supports resctrl filesystem
> 	# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
> 	# resctrl filesystem not mounted
> 	# dmesg: [   12.502941] resctrl: L3 allocation detected
> 	# dmesg: [   12.507134] resctrl: MB allocation detected
> 	# dmesg: [   12.511315] resctrl: L3 monitoring detected
> 	1..1
> 	# Starting L3_NONCONT_CAT test ...
> 	# Mounting resctrl to "/sys/fs/resctrl"
> 	# Write schema "L3:1=3f" to resctrl FS
> 	# Write schema "L3:1=f0f" to resctrl FS # write() failed : Invalid argument
> 	# Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected
> 	ok 1 L3_NONCONT_CAT: test
> 	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 	[/root]# ls /sys/fs/resctrl/
> 	[/root]#
> 
> And with mounted before test:
> 
> 	[/root]# ls /sys/fs/resctrl/
> 	[/root]#
> 	[/root]# mount -t resctrl resctrl /sys/fs/resctrl
> 	[/root]# ls /sys/fs/resctrl/
> 	cpus  cpus_list  info  mode  mon_data  mon_groups  schemata  size  tasks
> 	[/root]# ./resctrl_tests -t L3_NONCONT_CAT
> 	TAP version 13
> 	# Pass: Check kernel supports resctrl filesystem
> 	# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
> 	# resctrl filesystem is mounted
> 	# dmesg: [   12.502941] resctrl: L3 allocation detected
> 	# dmesg: [   12.507134] resctrl: MB allocation detected
> 	# dmesg: [   12.511315] resctrl: L3 monitoring detected
> 	1..1
> 	# Starting L3_NONCONT_CAT test ...
> 	# Mounting resctrl to "/sys/fs/resctrl"
> 	# Write schema "L3:1=3f" to resctrl FS
> 	# Write schema "L3:1=f0f" to resctrl FS # write() failed : Invalid argument
> 	# Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected
> 	ok 1 L3_NONCONT_CAT: test
> 	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 	[/root]# ls /sys/fs/resctrl/
> 	[/root]#
> 
> Looking at the code there is an unmounting function called after each test (at
> the end of run_single_test() inside of test_cleanup()). The non-contiguous test
> also doesn't write any data into a temp file so no additional cleanup is
> necessary.
> 


Looks fine. Thanks for the clarification.

thanks,
-- Shuah

