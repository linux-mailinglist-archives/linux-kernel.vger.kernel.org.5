Return-Path: <linux-kernel+bounces-79269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E414A861FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57D71C22C58
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B31419B3;
	Fri, 23 Feb 2024 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OKzXKJ69"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20438FA1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727834; cv=none; b=MFIftoPpBhyc48IZf+IajeLee0n5aPRboqOY3SyZOBrpojhlQqucL/qniz018PoduIPtzwJ6pgNA86/2mXpfPMvoaDC6Cs9/YKqbNNh8XId6MjUAk1qoQY4shO1CgioBdGw3eqFez8rmdiSVa/y60MeDpEtu4RSQh0etnhuKQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727834; c=relaxed/simple;
	bh=j0GdMvnu7Pyz5qABJdX7jRCrOkSnK2DF53Fqgk9EPYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJFmeiBSQdvm2iKzLO8v2QSKbqSEi/cZS/W0mYCdeMwftm/ylkJT+M9XdcIxu8EneT+8wUvi2aWwq+PjskO0TU9zSY8ZXnc+qjppqk5n5RLbgI3mfpCawmxO3AIn6gfLe/ZuS1fXXmv/t7ZWJmLgFOXcoT8eDgq3z5HTS430Of8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OKzXKJ69; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c45829f3b6so10660639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708727832; x=1709332632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttxmMzeVk7v+hmJEhpx2SOa2Fr3dSf/g1MsOLQuRp2Q=;
        b=OKzXKJ690E321dO+QzxSh0CtElX4EM7sRDuYufQJlPXfKb2XSXYmQbwGN4pwflSCn2
         izTMWA9CjPo+yOf7JbNN8wRvnMvt6KtpOpR3gOdG1QJyGmQyhX0FimQOt2MmWVedlMiV
         UqIZggnGkejgotODJSSZWjPAVK4aH7W5yHoxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727832; x=1709332632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttxmMzeVk7v+hmJEhpx2SOa2Fr3dSf/g1MsOLQuRp2Q=;
        b=PcnHgg7IDJnD9wZ4wf2Fd+ueZgerslNCdFwvH1rCGIABvtX6dhjEgqbGQ6Hanv8u3Q
         7cop/H3QUuWY2LuExydYfAgmAk+P/2AMRMdKSmocy1z/RZq026/rHaqXZ6ysHSNXnxJY
         jOWY/ekdfwkuwpxS5jY/P9sGALO66c5XDvdZTZViv+WpSo1TY6b/sHLCsHZxHzffSYgm
         ScoYmCy2pOabbNpu0YwJdv1ySVxC804R9dsF5VE3XLvhUFY8uutdAce6jkfCkc6AQqkl
         3sRt/B8pIzvju//KGb+evAPl+uAeOk/RWeo+i7oGfg63ILerlv8mtIFfI/j0GOC3Y3Oa
         d4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUP+8vrJpnZiwVBnbZ8s8FTY5i8+rWAnDYL8PmcPg/dkhk1TgmVUrIhOkyTjP8joyhtUAeIFTPtFAljP+kQdlasAnsFR1Y6rNXDveSZ
X-Gm-Message-State: AOJu0YyllXyvRlxPS4PA1T4YB3hOgXVYVRIHFDjBEOlGCbCzpyQwHpc9
	dC2ft4T3lR8Sk5RmGkjjGfmBwcIxyxO3sWK8QazJ3O/4G44Z2dEpKlT2mCV/HQw=
X-Google-Smtp-Source: AGHT+IFBjTd/GNKQisoDA+gu++dNtQyn3/Eg9HxcPZdwqTYtxi1xl023O9HnvlAnNYTJheZq6ZeRqQ==
X-Received: by 2002:a05:6e02:1d86:b0:363:b545:3a97 with SMTP id h6-20020a056e021d8600b00363b5453a97mr1257091ila.0.1708727832392;
        Fri, 23 Feb 2024 14:37:12 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g15-20020a92c7cf000000b00363c8e5a1a1sm4866810ilk.44.2024.02.23.14.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:37:11 -0800 (PST)
Message-ID: <a8f1f104-c5c1-400c-873e-99b01cde1d88@linuxfoundation.org>
Date: Fri, 23 Feb 2024 15:37:11 -0700
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
 <685828ed-06d2-4a2c-9911-05145e55ea1a@linuxfoundation.org>
 <48dab897-162d-4075-baa9-f5391a23d31d@intel.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <48dab897-162d-4075-baa9-f5391a23d31d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 15:33, Reinette Chatre wrote:
> 
> 
> On 2/23/2024 2:29 PM, Shuah Khan wrote:
> 
>>
>> Applied to linux-ksefltest next for Linux 6.9-rc1
>>
> 
> Thank you very much Shuah.
> 
> Reinette
> 

Hi Reinette,

Okay ran a quick test. Why does this test leave "/sys/fs/resctrl"
mounted when it exits. Can we fix this to unmount before the test
exits?

Please send a patch on top of linux-kselftest next.

thanks,
-- Shuah

