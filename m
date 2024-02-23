Return-Path: <linux-kernel+bounces-79261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D96861FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3473D287B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E6814CAD1;
	Fri, 23 Feb 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZbkQ+s5k"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBC143C63
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727353; cv=none; b=Iobyoh8ZSpI5aQHI9iIr29sLlYQdKKWX42YWfJDo+N3jCkw200MzB3Rz/n9BiIG8kcbyWSfkGORmZmpqUKvPeqf5/sYqYDNy3iFGn9d1qmpxMStFBrZbcS7amKg0H9sZhS8pAjsi4S9Ovb5rbenGOtKSSkzYNeaZRUseHP3padU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727353; c=relaxed/simple;
	bh=tA4eLcKdYfrGfQv9sAUAbE8BGpNDKOdb+D+R4L5JWg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IboOFuPuNwecnJq28JgPq7tDSlBnZ9dqCnA0W43ukMEKpOXx5EbQVreVZ1BjRmfqGv0gOewVJuO+PfgA1QxszvOkjGDV2LiHfGu3fHL3IQR2ZVNELUoOR5a7+vsvbi9nhQq3l2FomV8YO1KtjXDQoacn1fImqLbHe0FAXjYDFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZbkQ+s5k; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso23520639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708727351; x=1709332151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUfyc1Tqy9u/qIjvbCkoS9IsGCnttWBtbO+/mjQP5eU=;
        b=ZbkQ+s5kpG6X8GdHAHdAYxzAX93+TZsCDdgDbRrHi/rAeK6c5hY6Do/vcHRHOcr1dX
         XE2No0YZSOuydYb1BvSnLcuuYxPr2tJOoLVTCe5RXMS+GCAz65elvUPz+BYaARor9dii
         DCFn3Cr5nQwUqDXdqN/RE9kX8CeMCHb61Pnwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727351; x=1709332151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUfyc1Tqy9u/qIjvbCkoS9IsGCnttWBtbO+/mjQP5eU=;
        b=lHVO8Pyb5A3Yln7zalWYqZ14GUqK5ZGUwEIDVq8Lc35sLNOxBYRJ7/brIrhsIqiB/x
         w/nINukc47IHqXpBvQOudTG2qdnLbGceSHzGxaxMmfb+OvCjbnL4Roxhdalcgy+VgKDq
         0oJFKQLf4FoLojqjcDMr/fArR7o5fEkaFQfQX/wQwaYyrzD7gDhbnfQ07I59n0ntYVDA
         8DTd644au/Ht5KVok2n4ykSVi28K3bFxCkf5VQpfVcbFLhgq9NVCb6+O5up08kH+iO63
         UWr5qFLMCqZYgZbYMo5sPa6o5icVM98gAJsxpF2keAgMQONm2j77g0+Aly/a6C/c/YdR
         b5zg==
X-Forwarded-Encrypted: i=1; AJvYcCUpkbjT/gPPQh6DQmRsnUXGE6X/YcUWHKfcSNzpOiQ0ZwJWa0uFfbhdNXTkxl+DTxgxw93IChT4Z+N9ZqieOf2moOGYBaLuPsRpNq6K
X-Gm-Message-State: AOJu0YxF2rr3oeDklNJMe+GoJqsTCM0WusRJxBYTH+80uoJPMOLxvPVe
	gMxDIjv5hW0p2+o/ZWVvmSXcLOIVbfHok9L9oXs9Pz4eWj7Ujl5SAzKVAOA7OSM=
X-Google-Smtp-Source: AGHT+IFTGRuyv+74PtsRdT4HXvYBSReCMdPJ8cZ/xY4yZWeoo09FNCF4ofRRE/IzrJdzLqU5K2aQYA==
X-Received: by 2002:a6b:6501:0:b0:7c7:7f73:d1a with SMTP id z1-20020a6b6501000000b007c77f730d1amr1314032iob.1.1708727351288;
        Fri, 23 Feb 2024 14:29:11 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id u27-20020a02cbdb000000b004744e5a6877sm1401950jaq.160.2024.02.23.14.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:29:10 -0800 (PST)
Message-ID: <685828ed-06d2-4a2c-9911-05145e55ea1a@linuxfoundation.org>
Date: Fri, 23 Feb 2024 15:29:09 -0700
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
To: Reinette Chatre <reinette.chatre@intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, shuah@kernel.org,
 fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
 <f8886683-4f24-47ce-a0c6-ef28466bfec9@intel.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f8886683-4f24-47ce-a0c6-ef28466bfec9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/24 10:05, Reinette Chatre wrote:
> Hi Shuah,
> 
> Could you please consider this series for inclusion?
> 
> Thank you very much.
> 
> Reinette
> 
> On 2/16/2024 12:34 AM, Maciej Wieczor-Retman wrote:
>> Non-contiguous CBM support for Intel CAT has been merged into the kernel
>> with Commit 0e3cd31f6e90 ("x86/resctrl: Enable non-contiguous CBMs in
>> Intel CAT") but there is no selftest that would validate if this feature
>> works correctly. The selftest needs to verify if writing non-contiguous
>> CBMs to the schemata file behaves as expected in comparison to the
>> information about non-contiguous CBMs support.
>>
>> The patch series is based on a rework of resctrl selftests that's
>> currently in review [1]. The patch also implements a similar
>> functionality presented in the bash script included in the cover letter
>> of the original non-contiguous CBMs in Intel CAT series [3].
>>
>> Changelog v6:
>> - Add Reinette's reviewed-by tag to patch 2/5.
>> - Fix ret type in noncont test.
>> - Add a check for bit_center value in noncont test.
>> - Add resource pointer check in resctrl_mon_feature_exists.
>> - Fix patch 4 leaking into patch 3 by mistake.
>>

Applied to linux-ksefltest next for Linux 6.9-rc1

thanks,
-- Shuah


